local skynet = require "skynet"
local snax = require "skynet.snax"

-- 最简单snax服务

function init(...)
	-- snax服务初始化时会调用该回调函数，可以获取到启动参数
	skynet.error("snax server start: ", ...)
end

function exit(...)
	-- snax服务初始化时会调用该回调函数，可以获取到退出参数
	skynet.error("snax server exit: ", ...)
end
