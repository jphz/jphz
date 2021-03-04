local skynet = require "skynet"
local crypt = require "skynet.crypt"

-- randomkey 生成8字节随机数，一般作为对称加密算法随机密钥
local client_key = crypt.randomkey()
skynet.error("client_key: ", client_key)
-- dhexchange 转换8字节的key
local ckey = crypt.dhexchange(client_key)
skynet.error("ckey: ", crypt.hexencode(ckey))

local server_key = crypt.randomkey()
skynet.error("server_key: ", server_key)
local skey = crypt.dhexchange(server_key)
skynet.error("skey: ", crypt.hexencode(skey))

-- dhsecret 通过key1与key2得到密钥
-- 交换成功
local csecret = crypt.dhsecret(skey, client_key)
skynet.error("use skey client_key dhsecret: ", crypt.hexencode(csecret))

-- 交换成功
local ssecret = crypt.dhsecret(ckey, server_key)
skynet.error("use ckey server_key dhsecret: ", crypt.hexencode(ssecret))

-- 交换失败
ssecret = crypt.dhsecret(ckey, skey)
skynet.error("use ckey skey dhsecret: ", crypt.hexencode(ssecret))