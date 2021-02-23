local skynet = require "skynet"
local gateserver = require "snax.gateserver"
local netpack = require "skynet.netpack"

local handler = {}
local CMD = {}

-- 当客户端链接进来，gatesever自动处理链接，并且调用该函数
function handler.connect(fd, ipaddr)
	skynet.error("ipaddr:", ipaddr, "fd:", fd, "connect")
	gateserver.openclient(fd)
end

-- 当一个客户端断开链接后调用该函数
function handler.disconnect(fd)
	skynet.error("fd:", fd, "disconnect")
end

-- 接收数据
function handler.message(fd, msg, sz)
	skynet.error("recv message from fd:", fd)
	-- handler.message方法收到的msg,sz转换成一个luastring，并释放msg占用的C内存。
	skynet.error(netpack.tostring(msg, sz))
end

-- 如果报错就关闭该套接字
function handler.error(fd, msg)
	gateserver.closeclient(fd)
end

-- fd中待发送数据超过1M时调用该函数，可以不处理
function handler.warnning(fd, size)
	skynet.error("warinning fd=", fd, "unsent data over 1M")
end

-- 一旦gateserver打开监听成功后会调用该接口
-- 通过给这个服务发送lua消息open触发函数调用
function handler.open(source, conf)
	skynet.error("open by ", skynet.address(source))
	skynet.error("listen on", conf.port)
	skynet.error("client max", conf.maxclient)
	skynet.error("nodelay", conf.nodelay)
end

function CMD.kick(source, fd)
	skynet.error("source:", skynet.address(source), "kick fd:", fd)
	gateserver.closeclient(fd)
end

-- 接收skynet的lua消息，不需要我们调用skynet.dispatch来注册
function handler.command(cmd, source, ...)
	local f = assert(CMD[cmd])
	return f(source, ...)
end

gateserver.start(handler)
