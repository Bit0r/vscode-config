settings {
	insist = true, -- 出现错误时，继续运行
	logfile = './logs/lsyncd.log',
	statusFile = './runs/lsyncd.status',
	statusInterval = 10, -- 状态检查间隔
	nodaemon = true -- 设为true，不会在后台运行，因为daemon模式存在bug：https://github.com/lsyncd/lsyncd/issues/609。
	-- pidfile = './runs/lsyncd.pid'
}

sync {
	default.rsync,
	delay = 30, -- 延迟30秒
	source = './', -- 源目录
	-- target = string.format("%s:%s/", os.getenv("remote_host"), os.getenv("remote_dir") or require("lfs").currentdir()), -- 目标主机
	host = 'zw403-1080ti', -- 目标主机
	targetdir = '文档/lsyncd/', -- 目标目录
	-- include = '.env*', -- 包含的文件
	exclude = {'.git', '.svn'}, -- 排除的文件，详情见<https://lsyncd.github.io/lsyncd/manual/config/layer4/#exclusions>
	excludeFrom = '.gitignore', -- 从文件中读取排除的文件
	delete = false, -- 设为false，不会删除目标主机上的文件
	rsync = {
		cvs_exclude = true,
		update = true,
		archive = true,
		compress = true,
		verbose = true
	}
}
