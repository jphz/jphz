local skynet = require "skynet"

local args = {...}

if #args == 0 then
	table.insert(args, "1_base")
end

-- 查询接口
-- function skynet.queryservice(global, ...)
-- 假如不清楚当前创建了此全局服务没有，可以通过以下接口来查询
-- 如果还没有创建过目标则一直等下去，直到目标服务被（其他服务触发）创建。
-- 当参数global为true时，则表示查询在所有节点中唯一的服务是否存在。
skynet.start(function()
	local us
	skynet.error("start query service")
	-- 如果1_base服务未被创建，该接口将会阻塞，后面的代码将不会执行
	if #args == 2 and args[1] == "true" then
		us = skynet.queryservice(true, args[2])
	else
		us = skynet.queryservice(args[1])
	end
	skynet.error("end query service handler: ", skynet.address(us))
end)
