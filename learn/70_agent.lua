local skynet = require "skynet"
local netpack = require "skynet.netpack"
local socket = require "skynet.socket"

local client_fd = ...
client_fd = tonumber(client_fd)

skynet.register_protocol{
	name = "client",
	id = skynet.PTYPE_CLIENT,
	-- 需要将网络数据转换成lua字符串，不需要打包，所以不用注册pack函数
	unpack = netpack.tostring
}

local function task(msg)
	print("recv from fd", client_fd, msg)
	-- 响应消息的时候直接通过fd发送出去
	socket.write(client_fd, netpack.pack(string.upper(msg)))
end

skynet.start(function()
	-- 注册client消息专门来接收数据
	skynet.dispatch("client", function(_,_,msg)
		task(msg)
	end)

	-- 注册lua消息，来退出服务
	skynet.dispatch("lua", function(_,_,cmd)
		if cmd == "quit" then
			skynet.error(fd, "agent quit")
			skynet.exit()
		end
	end)
end)
