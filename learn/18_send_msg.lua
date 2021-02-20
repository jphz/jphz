local skynet = require "skynet"
require "skynet.manager"
-- 打包与解包消息
-- skynet中的消息在发送之前必须把参数进行打包，然后才发送，接收方收到消息后
-- 会自动根据指定的解包函数进行解包，最常用的打包解包函数skynet.pack与skynet.unpack
-- skynet.pack(...)
-- 打包后，会返回两个参数，一个C指针msg指向数据包的起始地址，sz一个是数据包的长度。msg指针的内存区域是动态申请的。

-- skynet.unpack(...)
-- 解包后，会返回一个参数列表，需要注意这个时候C指针msg指向的内存不会释放掉。
-- 如果msg有实际的用途，skynet框架会帮你在合适的地方释放掉，如果没有实际用途，自己想释放掉可以使用skynet.trash(msg, sz)释放掉。

-- skynet.send(addr, type, ...)
-- 用type类型向addr发送未打包的消息，该函数自动把...参数列表进行打包，默认情况下lua消息使用skynet.pack打包，addr可以是服务句柄也可以是别名。

-- skynet.rawsend(addr, type, msg, sz)
-- 用type类型向addr发送一个打包好的消息，addr可以是服务句柄也可以是别名。

skynet.start(function()
	skynet.register(".sendmsg")
	local luamsg = skynet.localname(".luamsg")
	-- 发送lua类型的消息给luamsg，发送立即返回，r的值为0
	local r = skynet.send(luamsg, "lua", 1, "jph", true) -- 申请了C内存(msg,sz)已经用与发送，所有不用自己在释放内存了。
	skynet.error("skynet.send return value: ", r)

	-- 通过skynet.pack来打包发送
	r = skynet.rawsend(luamsg, "lua", skynet.pack(2, "jph", false)) -- 申请了C内存
	skynet.error("skynet.rawsend return value: ", r)
end)
