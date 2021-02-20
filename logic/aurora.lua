local skynet = require "skynet"
local utils = require "helper.utils"
local recv_protos = require "protoc.recv_protos"
local lua_pb = require "pb"
assert(lua_pb.loadfile "logic/protoc/aurora.pb")

skynet.start(function()
    local role_info = {
        char_idx = 10086,
        char_name = "张三",
        age = 20
    }

    local bin_data = assert(lua_pb.encode(recv_protos[1001], role_info))
    local data = assert(lua_pb.decode(recv_protos[1001], bin_data))
    utils.table_print(data)

    --skynet.error("Server start")
    --local gateserver = skynet.newservice("aurora_gate")
    --skynet.call(gateserver, "lua", "open", {
    --    port = 8002,
    --    maxclient = 64,
    --    nodelay = true
    --})
    --
    --skynet.error("gate server setup on", 8002)
    --skynet.exit()
end)