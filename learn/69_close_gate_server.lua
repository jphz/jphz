local skynet = require "skynet"

local gateserver = ...

-- gateserver 保留了open和close两个lua消息用来打开关闭监听的端口
skynet.start(function()
	skynet.call(gateserver, "lua", "close")
	skynet.exit()
end)
