local skynet = require "skynet"

function task()
	skynet.error("task")
	-- 获取skynet节点开始运行的时间
	skynet.error("start time", skynet.starttime())	
	skynet.sleep(200)

	-- 获取当前时间
	skynet.error("time", skynet.time())

	-- 获取skynet节点已经运行的时间
	skynet.error("now", skynet.now())
end

skynet.start(function()
	skynet.fork(task)
end)
