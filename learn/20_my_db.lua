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
	-- 注册该服务的lua消息回调函数
	skynet.dispatch("lua", function(session, address, cmd, ...)
		-- 接受到的第一参数作为命令使用
		cmd = cmd:upper()
		-- 查询cmd命令的具体处理方法
		local func = command[cmd]
		if func then
			-- 指向查询到方法，并且通过skynet.ret将指向结果返回
			skynet.retpack(func(...))
		else
			skynet.error(string.format("Unknown command %s", tostring(cmd)))
		end
	end)
	-- 给当前服务注册一个名字，便于其他服务给当前服务发送消息
	skynet.register(".mydb")
end)
