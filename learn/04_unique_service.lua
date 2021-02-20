local skynet = require "skynet"

local args = {...}

if #args == 0 then
	table.insert(args, "1_base")
end

-- 全局唯一服务
-- 全局唯一的服务等同于单例，即不管调用多少次创建接口，
-- 最后都只会创建一个此类型的服务示例，且全局唯一。
-- skynet.uniqueservice(global, ...)
-- 带参数global时，则表示此服务在所有节点之间是唯一的。
-- 第一次创建唯一服，返回服务地址，第二次创建的时候不会正常创建服务，
-- 只是返回第一次创建的服务地址。

skynet.start(function() 
	local us
	skynet.error("test unique service")
	if #args == 2 and args[1] == "true" then
		us = skynet.uniqueservice(true, args[2])
	else
		us = skynet.uniqueservice(args[1])
	end

	skynet.error("uniqueservice handler: ", skynet.address(us))
end)
