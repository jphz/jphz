-- 引入skynet api
local skynet = require "skynet"

-- 若服务尚未初始化完成，则注册一个函数等服务服务初始化阶段在执行，
-- 若服务初始化完成，则立即运行该函数。
skynet.init(function()
	skynet.error("init...")
end)

-- function skynet.start(start_func)
-- 用start_func函数初始化服务，并将消息处理函数注册到C层，让该服务可以工作。
skynet.start(function()

    -- skynet.error(...) 打印函数
    skynet.error("hello skynet.")

	-- 获取当前服务的句柄handler
	local handler = skynet.self()
	skynet.error("handler: ", handler)

	-- handler转换成字符串
	local address = skynet.address(handler)
	skynet.error("address: ", address)

	-- 结束当前进程
	-- 不要尝试服务初始化阶段退出服务，唯一服会创建失败
	-- skynet.exit()
end)
