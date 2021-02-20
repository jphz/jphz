local skynet = require "skynet"
require "skynet.manager"

-- 服务临界区
local queue = require "skynet.queue"

-- 获取一个执行队列
local cs = queue()

local db = {}

local command = {}

function command.GET(key)
	-- 这里加了一个阻塞函数
	skynet.sleep(1000)
	return db[key]
end

function command.SET(key, value)
	db[key] = value
end

-- 上面的输出结果就是我们想要的了，把所有不希望重入的函数丢到cs队列中去执行，队列将依次每一个函数，前一个函数还没执行完的时候，后面的函数永远不会执行。
-- 执行队列虽然解决了重入的问题，但是明显降低了服务的并发处理能力，所以使用执行队列的时候尽量缩小临界区的颗粒大小。
skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		cmd = cmd:upper()
		local func = command[cmd]
		if func then
			-- 将func丢到队列中去执行，队列中的函数按照先后顺序进行执行
			skynet.retpack(cs(func, ...))
		else
			skynet.error(string.format("Unknown command %s", tostring(cmd)))
		end
	end)

	skynet.register(".mydb")
end)
