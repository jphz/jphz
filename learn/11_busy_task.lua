local skynet = require "skynet"

-- skynet.fork创建线程其实是通过lua协程来实现的，即一个协程占用执行权后，
-- 其他协程需要等待
function task(name)
	local i = 0
	skynet.error(name, "begin task")
	while i < 200000000 do
		i = i + 1
	end

	skynet.error(name, "end task", i)
end

skynet.start(function()
	skynet.fork(task, "task1")
	skynet.fork(task, "task2")
end)
