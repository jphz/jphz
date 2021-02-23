local skynet = require "skynet"
require "skynet.manager"
local sc = require "skynet.socketchannel"

-- 创建一个channel对象出来
local channel = sc.channel{
	host = "127.0.0.1",	-- ip或者域名
	port = 8001			-- 端口
}

-- 接收响应的数据必须这么定义，sock就是远端的tcp服务相连的套接字，通过这个套接字可以把数据读出来
function response(sock)
	-- 返回值必须要有两个，第一个是true表示响应数据是有效的
	return true, sock:read() -- 读到什么就返回什么
end

local function task()
	local resp
	local i = 0
	while i < 3 do
		-- 第一参数是需要发送的请求，第二个参数是一个函数，用来接收响应的数据。
		-- 调用channel:request会自动连接指定的TCP服务，并且发送请求消息。
		-- 该函数阻塞，返回读到的内容
		resp = channel:request("data"..i.."\n", response)
		skynet.error("recv", resp)
		i = i + 1
	end
	-- channel:close() -- channel可以不关闭，当前服务退出会自动关闭掉
	skynet.exit()
end

skynet.start(function()
	skynet.fork(task)
end)
