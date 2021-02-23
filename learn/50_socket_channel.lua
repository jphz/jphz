local skynet = require "skynet"
require "skynet.manager"

local sc = require "skynet.socketchannel"

function dispatch(sock)
	local r = sock:readline()
	local session = tonumber(string.sub(r, 5))
	-- 返回值必须要有三个，第一个session
	return session, true, r
end

-- 创建一个channel对象出来, 其中host可以是ip地址或者域名port是端口号。
local channel = sc.channel{
	host = "127.0.0.1",
	port = 8001,
	-- 处理消息的函数
	response = dispatch
}

local function task()
	local resp
	local i = 0
	while i < 3 do
		skynet.fork(function(session)
			resp = channel:request("data"..session.."\n", session)
			skynet.error("recv", resp, session)
		end, i)
		i = i + 1
	end
end

skynet.start(function()
	skynet.fork(task)
end)
