local skynet = require "skynet"
local gateserver = require "snax.gateserver"
local netpack = require "skynet.netpack" -- 使用netpack

local handler = {}

-- 当一个客户端连接进来，gateserver自动处理链接，并且调用该函数，必须要有
function handler.connect(fd, ipaddr)
	skynet.error("ipaddr:", ipaddr, "fd:", fd, "connect")
	-- 链接成功不代表马上可以读到数据，需要打开这个套接字，允许fd接收数据
	gateserver.openclient(fd)
end

-- 当一个客户端断开链接后调用该函数，必须要有
function handler.disconnect(fd)
	skynet.error("fd:", fd, "disconnect")
end

-- 当fd有数据到达了，会调用这个函数，前提是fd需要调用gateserver.openclient打开
function handler.message(fd, msg, sz)
	skynet.error("recv message from fd:", fd)
	-- 把handler.message 方法收到的msg,sz转换成一个luastring，并释放msg占用的C内存。
	skynet.error(netpack.tostring(msg, sz))
end

gateserver.start(handler)
