local skynet = require "skynet"
local key,value = ...
function task()
	-- 修改为.proxy，发给代理
	local r = skynet.send(".proxy", "lua", "set", key, value)
	skynet.error("mydb set test", r)

	-- 修改为.proxy，发给代理
	r = skynet.call(".proxy", "lua", "get", key)
	skynet.error("mydb get test", r)

	skynet.exit()
end

--重复打包影响效率
skynet.start(function()
	skynet.fork(task)
end)
