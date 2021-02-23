local skynet = require "skynet"
local socket = require "skynet.socket"

-- 简单echo服务
function echo(c_id, addr)
	socket.start(c_id)
	local str
	while true do
		str = socket.readline(c_id)	
		if str then
			skynet.fork(function()
				skynet.error("recv "..str)
				skynet.sleep(math.random(1, 5)*100)
				socket.write(c_id, string.upper(str).."\n")
			end)
		else
			socket.close(c_id)
			skynet.error(addr .. " disconnect")
			return
		end
	end
end

function accept(c_id, addr)
	skynet.error(addr .. "accepted")
	skynet.fork(echo, c_id, addr)
end

-- 服务入口
skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen " .. addr)
	local l_id = socket.listen(addr)
	assert(l_id)
	socket.start(l_id, accept)
end)
