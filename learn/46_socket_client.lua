local skynet = require "skynet"
local socket = require "skynet.socket"

function asclient(id)
	local i = 0
	local str
	while i < 3 do
		skynet.error("send data"..i)
		socket.write(id, "data"..i.."\n")
		str = socket.readline(id)
		if str then
			skynet.error("recv "..str)
		else
			skynet.error("disconnect")
		end
		i = i + 1
	end

	-- 不主动关闭也行，服务退出的时候，会自动将套接字关闭
	socket.close(id)
	skynet.exit()
end

skynet.start(function()
	local addr = "127.0.0.1:8001"
	skynet.error("connect "..addr)
	local id = socket.open(addr)
	assert(id)
	-- 启动读协程
	skynet.fork(asclient, id)
end)
