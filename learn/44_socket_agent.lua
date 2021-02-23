local skynet = require "skynet"
local socket = require "skynet.socket"

function echo(c_id, addr)
	socket.start(c_id)
	local str
	while true do
		str = socket.read(c_id)	
		if str then
			skynet.error("recv "..str)
			socket.write(c_id, string.upper(str))
		else
			socket.close(c_id)
			skynet.error(addr.." disconnect")
			return
		end
	end
end

local c_id, addr = ...
c_id = tonumber(c_id)

skynet.start(function()
	skynet.fork(function()
		echo(c_id, addr)
		skynet.exit()
	end)
end)
