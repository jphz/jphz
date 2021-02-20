local skynet = require "skynet"

-- 错误处理
-- lua中的错误处理都是通过assert以及error来抛出异常，并且中断当前流程，skynet也不例外。
-- task1断言后终止掉当前协程，不会再往下执行，但是task2还能正常执行。
-- skynet节点也没用挂掉，还是能正常运行。
function task1()
	skynet.error("task1", coroutine.running())
	skynet.sleep(100)
	assert(nil)
	skynet.error("task2", coroutine.running(), "end")
end

function task2()
	skynet.error("task2", coroutine.running())
	skynet.sleep(500)
	skynet.error("task2", coroutine.running(), "end")
end

skynet.start(function()
	skynet.error("start", coroutine.running())
	skynet.fork(task1)
	-- 不想协程中中断掉，可以使用pcall来捕捉异常。
	skynet.fork(pcall, task1)
	skynet.fork(task2)
end)
