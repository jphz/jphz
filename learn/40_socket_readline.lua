local skynet = require "skynet"
local socket = require "skynet.socket"

-- 简单echo服务
function echo(c_id, addr)
	socket.start(c_id)
	local str, endstr
	while true do
		str, endstr = socket.readline(c_id)	
		if str then
			skynet.error("recv "..str)
			socket.write(c_id, string.upper(str))
		else
			socket.close(c_id)
			if endstr then
				skynet.error("last recv "..endstr)
			end
			skynet.error(addr.." disconnect")
			return
		end
	end
end

function accept(c_id, addr)
	skynet.error(addr.." accepted")
	skynet.fork(echo, c_id, addr)
end

-- 服务入口
skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen "..addr)
	local l_id = socket.listen(addr)
	assert(l_id)
	socket.start(l_id, accept)
end)
