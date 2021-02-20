local skynet = require "skynet"

local cos = {}

-- 同一个服务之间的线程通过，skynet.wait以及skynet.wakeup来同步线程
function task1()
	skynet.error("task1 begin task")
	skynet.error("task1 wait")
	skynet.wait()	-- task1等待唤醒
	-- 或者skynet.wait(coroutine.running())
	skynet.error("task1 end task")
end

function task2()
	skynet.error("task2 begin task")
	skynet.error("task2 wait")
	skynet.wakeup(cos[1])	-- task2去唤醒task1，task1并不是马上唤醒，而是等task2运行完
	skynet.error("task2 end task")
end

-- skynet.wakeup除了能唤醒wait线程，也可以唤醒sleep的线程
skynet.start(function()
	-- 保存线程句柄
	cos[1] = skynet.fork(task1)
	cos[2] = skynet.fork(task2)
end)
