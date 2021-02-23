local skynet = require "skynet"
local gateserver, fd = ...

-- 必须转换成整数，skynet命令行传入的参数都是字符串
fd = tonumber(fd)
skynet.start(function()
	skynet.call(gateserver, "lua", "kick", fd)
	skynet.exit()
end)
