local skynet = require "skynet"
local netpack = require "skynet.netpack"
local socket = require "skynet.socket"

local client_fd = ...
client_fd = tonumber(client_fd)

skynet.register_protocol {
    name = "client",
    id = skynet.PTYPE_CLIENT,
    unpack = netpack.tostring
}

local function task(msg)
    skynet.error("recv from fd", client_fd, msg)
    socket.write(client_fd, netpack.pack(string.upper(msg)))
end

skynet.start(function()
    skynet.dispatch("client", function(_, _, msg)
        task(msg)
    end)

    skynet.dispatch("lua", function(_, _, cmd)
        if cmd == "quit" then
            skynet.error(client_fd, "agent quit")
            skynet.exit()
        end
    end)
end)