local skynet = require "skynet"
local key,value = ...

function task()
	-- 给.mydb服务发送一个lua消息，命令为set
	-- 发送成功后直接返回，不管接受消息端的是否调用skynet.ret，skynet.send的返回值为0
	local r = skynet.send(".mydb", "lua", "set", key, value)
	skynet.error("mydb set Test", r)

	-- 给.mydb服务发送一个lua消息，命令为get
	-- 发送成功后直接返回，不管接收消息端是否调用skynet.ret，skynet.send的返回值为0
	r = skynet.call(".mydb", "lua", "get", key)
	skynet.error("mydb get Test", r)
	skynet.exit()
end

skynet.start(function()
	skynet.fork(task)
end)
