local skynet = require "skynet"
local socket = require "skynet.socket"

-- 简单echo服务
function echo(c_id, addr)
	socket.start(c_id)
	local str, endstr
	while true do
		str, endstr = socket.read(c_id)
		if str then	
			skynet.error("recv "..str)
			socket.write(c_id, string.upper(str))
		else
			socket.close(c_id)
			skynet.error(addr .. " disconnect, endstr", endstr)
			return
		end
	end
end

function accept(c_id, addr)
	skynet.error(addr .. " accepted")
	-- 来一个连接，就开一个新的协程来处理客户端数据
	skynet.fork(echo, c_id, addr)
end

-- 服务入口
skynet.start(function()
	local addr = "0.0.0.0:8001"
	skynet.error("listen "..addr)
	local l_id = socket.listen(addr)
	-- 或者 local l_id = socket.listen("0.0.0.0", 8001, 128)
	assert(l_id)
	-- 把套接字与当前服务绑定
	socket.start(l_id, accept)
end)
