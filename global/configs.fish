#!/usr/bin/fish

# 检查是否传入了参数
if [ (count $argv) -eq 0 ]
    echo "错误：请提供要配置的编辑器名称。"
    echo "用法: ./configs.fish [code|antigravity]"
    exit 1
end

set -l target $argv[1]
set -l editor_cmd
set -l config_path
set -l runtime_path

# 根据传入参数设置对应的命令和路径
switch $target
    case code Code vscode
        set editor_cmd code
        set config_path ~/.config/Code
        set runtime_path ~/.vscode
    case antigravity Antigravity
        set editor_cmd antigravity
        set config_path ~/.config/Antigravity
        set runtime_path ~/.antigravity
    case '*'
        echo "错误：不支持的编辑器类型 '$target'。"
        echo "支持的参数为: 'code' 或 'antigravity'"
        exit 1
end

echo "=> 开始配置编辑器: $target"

# 1. 复制 snippets、settings 和 keybindings 到用户配置目录
set -l snippets_path $config_path/snippets
mkdir -p $snippets_path
cp snippets/*.json $snippets_path/
cp *.json $config_path/User/
echo "✔️ 已复制用户配置到 $config_path"

# 2. 复制运行时配置
mkdir -p $runtime_path
cp ./runtime/*.json $runtime_path/
echo "✔️ 已复制运行时配置到 $runtime_path"

# 3. 安装插件
echo "=> 正在通过 $editor_cmd 安装插件..."
for ext in (cat extensions.txt)
    $editor_cmd \
        # 使用代理服务器进行插件安装
        # --proxy-server=socks5://localhost \
        # 更新到最新版本以确保安装成功
        --force \
        --install-extension \
        $ext
end
echo "✔️ 插件安装完成！"
