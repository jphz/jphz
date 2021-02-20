local skynet = require "skynet"

-- 通过使用skynet.yield然后同一服务中的不同线程都可以得到执行权限。
function task(name)
	local i = 0
	skynet.error(name, "begin task")
	while i < 20000000 do
		i = i + 1
		if i % 5000000 == 0 then
			skynet.yield()
			skynet.error(name, "task yield")
		end
	end
	skynet.error(name, "end task", i)
end

skynet.start(function()
	skynet.fork(task, "task1")
	skynet.fork(task, "task2")
end)
