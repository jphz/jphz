local skynet = require "skynet"
local gateserver = require "snax.gateserver"
local netpack = require "skynet.netpack"

local handler = {}
local CMD = {}
local agents = {}

-- 注册client消息专门来接收数据转发给agent，不需要解包，也不需要打包
skynet.register_protocol{
	name = "client",
	id = skynet.PTYPE_CLIENT
}

function handler.connect(fd, ipaddr)
	skynet.error("ipaddr:", ipaddr, "fd:", fd, "connect")
	gateserver.openclient(fd)
	-- 连接成功后就启动一个agent服务来代理
	local agent = skynet.newservice("70_agent", fd)
	agents[fd] = agent
end

-- 断开连接后，agent服务退出
function handler.disconnect(fd)
	skynet.error("fd:", fd, "disconnect")
	local agent = agents[fd]
	if agent then
		-- 通过发送消息的方式来退出不要使用skynet.kill(agent)
		skynet.send(agent, "lua", "quit")
		agents[fd] = nil
	end
end

function handler.message(fd, msg, sz)
	local agent = agents[fd]
	-- 收到消息就转发给agent
	skynet.redirect(agent, 0, "client", 0, msg, sz)
end

function handler.error(fd, msg)
	skynet.closeclient(fd)
end

function handler.warnning(fd, size)
	skynet.error("warnning fd=", fd, "unsend data over 1M")
end

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

function handler.command(cmd, source, ...)
	local f = assert(CMD[cmd])
	return f(source, ...)
end

gateserver.start(handler)
