local skynet = require "skynet"

require "skynet.manager"

local db = {}

local command = {}

function command.GET(key)
	return db[key]
end

function command.SET(key, value)
	db[key] = value
end

skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		-- 先把发送服务地址以及session打包到闭包中，可以在任意地方调用
		local response = skynet.response(skynet.pack) -- 指定打包函数，必须根据接收到的消息打包函数一致

		-- 开启一个新的协程来处理响应
		skynet.fork(function(cmd, ...)
			skynet.sleep(500)
			cmd = cmd:upper()
			local func = command[cmd]
			if func then
				-- 第一个参数true表示应答成功，false则应答个错误消息
				response(true, func(...))		
			else
				skynet.error(string.format("Unknown command %s", tostring(cmd)))
			end
		end, cmd, ...)
	end)

	skynet.register(".mydb")
end)
