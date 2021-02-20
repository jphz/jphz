local skynet = require "skynet"
require "skynet.manager"

-- 注册system消息
skynet.register_protocol{
	name = "system",
	id = skynet.PTYPE_SYSTEM,
	-- pack = skynet.pack,
	unpack = skynet.unpack -- unpack必须指定一下，接收到消息后会自动使用unpack解析
}

skynet.start(function()
	skynet.dispatch("system", function(session, address, ...) -- 使用unpack解包
		-- 使用skynet.retpack的时候，必须要在skynet.register_protocol指定pack
		-- skynet.retpack("jph")
		skynet.ret(skynet.pack("JPH"))
	end)
	skynet.register(".othermsg")
end)
