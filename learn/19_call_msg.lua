local skynet = require "skynet"
require "skynet.manager"

-- skynet.call(addr, type, ...)
-- 用默认函数打包消息，向addr发送type类型的消息并等待返回响应，并对回应信息进行解包，自动打包与解包。

-- skynet.rawcall(addr, type, msg, sz)
-- 直接向addr发送type类型的msg,sz并等待返回响应，不对回应信息解包，需要自己打包与解包。

-- 应答消息打包的时候，打包方法必须与接收消息的打包方式一致。
-- skynet.ret不需要指定应答消息是那个服务的。
-- 因为每次接收消息时，服务都会启动一个协程来处理，并且把这个协程与源服务地址绑定再一起了（其实就是把协程句柄作为key，源服务地址为value，记录再一张表中）。需要响应的时候可以根据协程句柄找到源服务地址。
skynet.start(function()
	skynet.register(".callmsg")

	-- 发送lua类型服务，发送成功，该函数将阻塞等待响应返回，r的值为响应的返回值
	local r = skynet.call(".luamsg", "lua", 1, "jph", true)
	skynet.error("skynet.call return value: ", r)

	-- 通过skynet.pack来打包发送，返回的值也需要自己解包
	r = skynet.unpack(skynet.rawcall(".luamsg", "lua", skynet.pack(2, "jph", false)))
	skynet.error("skynet.rawcall return value: ", r)
end)
