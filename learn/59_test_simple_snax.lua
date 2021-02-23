local skynet = require "skynet"
local snax = require "skynet.snax"

skynet.start(function()
	-- 启动simplesnax服务
	local obj = snax.uniqueservice("57_simple_snax", 123, "abc")
	-- 查询全局唯一服
	obj = snax.queryservice("57_simple_snax")
	snax.kill(obj, 123, "abc")

	-- 启动simplesnax服务
	local gobj = snax.globalservice("57_simple_snax", 123, "abc")
	gobj = snax.queryglobal("57_simple_snax")
	snax.kill(gobj, 123, "abc")

	skynet.exit()
end)
