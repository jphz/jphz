local skynet = require "skynet"
local socket = require "skynet.socket"

-- 简单echo服务
function echo(c_id, addr)
	socket.start(c_id)
	local str = socket.readall(c_id)
	if str then
		skynet.error("recv "..str)
	else
		skynet.error(addr .. " close")
		socket.close(c_id)
		return
	end
end

function accept(c_id, addr)
	skynet.error(addr .. " accepted")
	skynet.fork(echo, c_id, addr)
end

skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen "..addr)
	local l_id = socket.listen(addr)
	assert(l_id)
	socket.start(l_id, accept)
end)
