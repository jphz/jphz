local skynet = require "skynet"

local crypt = require "skynet.crypt"

local msg = "12345678"
local encode = crypt.base64encode(msg)
skynet.error("encode: ", encode)

local decode = crypt.base64decode(encode)
skynet.error("decode: ", decode)