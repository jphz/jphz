local skynet = require "skynet"
local socket = require "skynet.socket"

function echo(c_id, addr)
	socket.start(c_id)
	local str
	while true do
		str = socket.read(c_id)	
		if str then
			skynet.error("recv "..str)
			-- 由于数量少处理非常快，无法看到效果，只能发送大量数据的时候，才会出现优先级后发送的现象。
			socket.lwrite(c_id, "l:" .. string.upper(str))
			socket.write(c_id, "h:" .. string.upper(str))
		else
			socket.close(c_id)
			skynet.error(addr .. " disconnect")
			return
		end
	end
end

function accept(c_id, addr)
	skynet.error(addr .. " accepted")
	-- 如果不开协程，那么同一时刻肯定只能处理一个客户端的连接请求
	skynet.fork(echo, c_id, addr)
end

-- 服务入口
skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen" .. addr)
	local l_id = socket.listen(addr)
	assert(l_id)
	socket.start(l_id, accept)
end)
