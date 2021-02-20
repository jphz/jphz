local skynet = require "skynet"
local gateserver = require "snax.gateserver"

local handler = {}
local CMD = {}
local agents = {}

skynet.register_protocol {
    name = "client",
    id = skynet.PTYPE_CLIENT,
}

function handler.connect(fd, ipaddr)
    skynet.error("ipaddr:", ipaddr, "fd:", fd, "connect.")
    gateserver.openclient(fd)
    local agent = skynet.newservice("agent_gate", fd)
    agents[fd] = agent
end

function handler.disconnect(fd)
    skynet.error("fd:", fd, "disconnect.")
    local agent = agents[fd]
    if agent then
        skynet.send(agent, "lua", "quit")
        agents[fd] = nil
    end
end

function handler.message(fd, msg, sz)
    local agent = agents[fd]
    skynet.redirect(agent, 0, "client", 0, msg, sz)
end

function handler.error(fd, msg)
    gateserver.closeclient(fd)
end

function handler.warning(fd, size)
    skynet.error("warning fd=", fd, "unset data over 1M.")
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
    local func = assert(CMD[cmd])
    return func(source, ...)
end

gateserver.start(handler)