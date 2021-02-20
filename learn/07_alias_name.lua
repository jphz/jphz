local skynet = require "skynet"
require "skynet.manager"
local harbor = require "skynet.harbor"

skynet.start(function()
	local handle = skynet.newservice("1_base")
	skynet.name(".alias", handle)	-- 给服务起一个本地别名
	skynet.name("alias", handle)	-- 给服务起一个全局别名
end)
