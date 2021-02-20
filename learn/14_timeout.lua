local skynet = require "skynet"
-- 循环启动定时器
-- skynet中的定时器，其实是通过给定时器线程注册一个超时时间，并占用了一个空闲协程，
-- 空闲协程也是从协程池中获取，超时后会使用空闲协程来处理超时回调函数。
function task()
	skynet.error("task", coroutine.running())
	skynet.timeout(500, task)
end

-- skynet.start源码分析
-- 其实skynet.start服务启动函数实现中，就已经启动一个timeout为0s的定时器，来
-- 执行通过skynet.start函数传入参得到的初始化函数，其目的是为了让skynet工作线程调度一次新服务。
-- 这一次服务调度最重要的意义在于把fork队列中的协程全部执行一遍。
skynet.start(function()
	-- skynet.start启动一个timeout执行function，创建一个协程
	skynet.error("start", coroutine.running())

	-- 由于function函数还没有用完协程，所有这个timeout又创建一个协程。
	skynet.timeout(500, task)
end)
