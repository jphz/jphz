local skynet = require "skynet"
require "skynet.manager"

-- 30_proxy效率问题时因为默认接收到lua消息后，会解包消息，
-- 但是lua消息已经注册了无法更改，那么我们可以使用skynet.forward_type
-- 进行协议转换。
-- skynet.forward_type也是启动服务的一种方法，跟skynet.start类似，只不过skynet.forward_type还需提供一张消息转换映射表forward_map，其他的方法跟skynet.start一样。

skynet.register_protocol{
	name = "system",
	id = skynet.PTYPE_SYSTEM,
	unpack = function(...) return ... end, -- unpack直接返回不解包
}

local forward_map = {
	-- 发送到代理服务的lua消息全部转成system消息，不改变原先LUA的消息协议处理方式
	[skynet.PTYPE_LUA] = skynet.PTYPE_SYSTEM,
	-- 如果接收到应答消息，默认情况下会释放掉消息msg,sz，forward的方式处理消息不会释放掉消息msg,sz
	[skynet.PTYPE_RESPONSE] = skynet.PTYPE_RESPONSE,
}

local realsvr = ...
skynet.forward_type(forward_map, function()
	-- 注册system消息处理函数
	skynet.dispatch("system", function(session, source, msg, sz)
	-- 直接转发realsvr，接收到realsvr响应后也不释放内存，直接转发
	skynet.ret(skynet.rawcall(realsvr, "lua", msg, sz))
	end) -- 处理完不释放内存msg
	skynet.register(".proxy")
end)
