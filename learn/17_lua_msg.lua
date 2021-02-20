local skynet = require "skynet"
require "skynet.manager"

-- 注册消息处理函数
-- 当我们需要在一个服务中监听指定类型的消息，就需要在服务启动的时候先注册该类型的消息的监听，通常是在服务的入口函数skynet.start处通过调用skynet.dispatch来注册绑定
local function dosomething(session, address, ...)
	skynet.error("session", session)
	skynet.error("address", skynet.address(address))
	local args = {...}
	for k,v in pairs(args) do
		skynet.error("arg"..k..":", v)
	end
	return 100, false
end

skynet.start(function()
	-- 注册"lua"类型消息的回调函数
	skynet.dispatch("lua", function(session, address, ...)
		-- 申请响应消息C内存
		-- 或者skynet.ret(skynet.pack(dosomething(session, address, ...)))
		skynet.retpack(dosomething(session, address, ...))
	end)-- skynet.dispatch完成后，释放调用接收消息C内存
	skynet.register(".luamsg")
end)
