settings {
    -- logfile = '.lsyncd/lsyncd.log',
    -- statusFile = '.lsyncd/status.log',
    -- statusInterval = 20,
    nodaemon = true -- 设为true，不会在后台运行
}

sync {
    default.rsyncssh,
    delay = 0, -- 设为0s，实时同步
    source = './', -- 源目录
    host = 'zw403-1080ti', -- 目标主机
    targetdir = '文档/lsyncd/', -- 目标目录
    exclude = {'.lsyncd', '.vscode'}, -- 排除的文件，详情见<https://lsyncd.github.io/lsyncd/manual/config/layer4/#exclusions>
    delete = false, -- 设为false，不会删除目标主机上的文件
    rsync = {
        update = true,
        archive = true,
        compress = true,
        verbose = true
    }
}
