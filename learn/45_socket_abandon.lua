local skynet = require "skynet"
local socket = require "skynet.socket"

skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen" .. addr)
	local l_id = socket.listen(addr)
	assert(l_id)
	socket.start(l_id, function(c_id, addr)
		skynet.error(addr.." accepted")
		-- 当前服务开始使用套接字
		socket.start(c_id)
		local str = socket.read(c_id)
		if str then
			socket.write(c_id, string.upper(str))
		end
		-- 不想使用了，这个时候一起控制权
		socket.abandon(c_id)
		-- 代理服务不变
		skynet.newservice("44_socket_agent", c_id, addr)
	end)
end)
