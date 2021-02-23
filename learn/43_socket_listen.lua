local skynet = require "skynet"
local socket = require "skynet.socket"

skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen "..addr)
	local l_id = socket.listen(addr)
	assert(l_id)
	socket.start(l_id, function(c_id, addr)
		skynet.error(addr .. " accepted")
		skynet.newservice("44_socket_agent", c_id, addr)
	end)
end)
