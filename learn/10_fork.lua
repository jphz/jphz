local skynet = require "skynet"

-- 在服务中开启新的线程
-- 在skynet的服务中我们可以开一个新的线程来处理业务(注意这个线程并不是传统义的线程，更像是一个虚拟线程，其实通过协程来模拟的)。
-- console服务仍然可以接收终端输入
-- 以后遇到需要长时间运行，并且出现阻塞情况，都要使用skynet.fork在创建一个线程（协程）。
function task(timeout)
	skynet.error("fork co: ", coroutine.running())
	skynet.error("begin sleep")
	skynet.sleep(timeout)

	skynet.error("begin end")
end

-- 查看skynet.lua了解底层实现，其实就是使用coroutine.create实现
-- 每次使用skynet.fork其实都是从协程池中获取未被使用的协程，并把协程加入fork队列中，等待一个消息调度，然后会一次把fork队列中协程拿出来执行一遍，执行结束后，会把协程重新丢入协程池中，这样可以避免重复开启关闭协程的额外开销。
skynet.start(function()
	skynet.error("start co:", coroutine.running())
	skynet.fork(task, 500)
end)

