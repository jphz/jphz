local skynet = require "skynet"
local snax = require "skynet.snax"

skynet.start(function()
	-- 启动simplesnax服务
	local obj = snax.newservice("60_simple_snax")

	-- 未更新之前调用一次
	obj.post.hello()

	local r = snax.hotfix(obj, [[
		local skynet
		local i
		function accept.hello(...)
			skynet.error("fix hello", i, gname, ...)
		end

		function hotfix(...)
			local temp = i
			i = 100
			gname = "jph2"
			return temp
		end
	]])
	
	skynet.error("hotfix return:", r)

	-- 更新之后再调用一次
	obj.post.hello()
	-- 没更新quit函数，还是能调用
	obj.post.quit()
	skynet.exit()
end)
