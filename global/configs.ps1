#Requires -Version 7.0

[CmdletBinding()]
param(
    [ValidateSet("code")]
    [string]$Target = "code",

    [switch]$NoBackup,
    [switch]$NoExtensions
)

$ErrorActionPreference = "Stop"

$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) {
    $ScriptDir = (Get-Location).Path
}

$RepoRoot = Split-Path -Parent $ScriptDir
$UserDir = Join-Path $env:APPDATA "Code\User"
$SnippetsDir = Join-Path $UserDir "snippets"
$RuntimeDir = Join-Path $env:USERPROFILE ".vscode"
$EditorCmd = $Target

function Test-RequiredPath {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Required path does not exist: $Path"
    }
}

Write-Host "=> Configuring VS Code for Windows..."
Write-Host "   Source:  $ScriptDir"
Write-Host "   User:    $UserDir"
Write-Host "   Runtime: $RuntimeDir"

Test-RequiredPath (Join-Path $ScriptDir "settings.json")
Test-RequiredPath (Join-Path $ScriptDir "keybindings.json")
Test-RequiredPath (Join-Path $ScriptDir "snippets")
Test-RequiredPath (Join-Path $ScriptDir "runtime")
Test-RequiredPath (Join-Path $ScriptDir "extensions.txt")

New-Item -ItemType Directory -Force -Path $UserDir | Out-Null
New-Item -ItemType Directory -Force -Path $SnippetsDir | Out-Null
New-Item -ItemType Directory -Force -Path $RuntimeDir | Out-Null

if (-not $NoBackup) {
    $Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $BackupDir = Join-Path $RepoRoot ".backup\vscode-win-$Stamp"
    New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null

    $BackupItems = @(
        @{ Source = (Join-Path $UserDir "settings.json"); Destination = (Join-Path $BackupDir "settings.json") },
        @{ Source = (Join-Path $UserDir "keybindings.json"); Destination = (Join-Path $BackupDir "keybindings.json") },
        @{ Source = $SnippetsDir; Destination = (Join-Path $BackupDir "snippets") },
        @{ Source = (Join-Path $RuntimeDir "argv.json"); Destination = (Join-Path $BackupDir "argv.json") }
    )

    foreach ($Item in $BackupItems) {
        if (Test-Path -LiteralPath $Item.Source) {
            Copy-Item -LiteralPath $Item.Source -Destination $Item.Destination -Recurse -Force
        }
    }

    Write-Host "=> Backup saved to $BackupDir"
}

Write-Host "=> Copying user settings..."
Copy-Item -LiteralPath (Join-Path $ScriptDir "settings.json") -Destination (Join-Path $UserDir "settings.json") -Force
Copy-Item -LiteralPath (Join-Path $ScriptDir "keybindings.json") -Destination (Join-Path $UserDir "keybindings.json") -Force

Get-ChildItem -LiteralPath (Join-Path $ScriptDir "snippets") -Filter "*.json" | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $SnippetsDir -Force
}

Write-Host "=> Copying runtime settings..."
Get-ChildItem -LiteralPath (Join-Path $ScriptDir "runtime") -Filter "*.json" | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $RuntimeDir -Force
}

if (-not $NoExtensions) {
    if (-not (Get-Command $EditorCmd -ErrorAction SilentlyContinue)) {
        throw "Cannot find '$EditorCmd' in PATH. Install VS Code CLI first or add it to PATH."
    }

    Write-Host "=> Installing extensions with '$EditorCmd --force --install-extension'..."
    $Extensions = Get-Content -LiteralPath (Join-Path $ScriptDir "extensions.txt") |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -and -not $_.StartsWith("#") }

    $Failed = New-Object System.Collections.Generic.List[string]

    foreach ($Extension in $Extensions) {
        Write-Host "   Installing $Extension"
        & $EditorCmd --force --install-extension $Extension
        if ($LASTEXITCODE -ne 0) {
            $Failed.Add($Extension) | Out-Null
            Write-Warning "Failed to install $Extension (exit code $LASTEXITCODE)"
        }
    }

    if ($Failed.Count -gt 0) {
        Write-Warning "Some extensions failed to install:"
        $Failed | ForEach-Object { Write-Warning " - $_" }
        exit 1
    }
}

Write-Host "=> Done. Restart VS Code to apply argv.json changes."
