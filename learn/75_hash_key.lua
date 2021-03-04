local skynet = require "skynet"
local crypt = require "skynet.crypt"

local msg = "12345678"
skynet.error(crypt.hashkey(msg))
