local skynet = require "skynet"
local snax = require "skynet.snax"

skynet.start(function()
	-- 启动simplesnax服务，并传递参数
	local obj = snax.newservice("55_simple_snax", 123, "abc", false)
	skynet.error("snax service", obj, "startup")

	-- 调用simple snax中accept.hello方法
	local r = obj.post.hello(123, "abc", false)
	skynet.error("hello return:", r)

	-- 退出服务
	obj.post.quit("exit now")
end)
