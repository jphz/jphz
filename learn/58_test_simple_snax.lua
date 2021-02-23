local skynet = require "skynet"
local snax = require "skynet.snax"

skynet.start(function()
	local obj = snax.newservice("57_simple_snax", 123, "abc", false)
	skynet.error("snax server", obj, "startup")

	-- 调用simplesnax中response.echo方法
	local r = obj.req.echo("jph")
	skynet.error("echo return:", r)
end)
