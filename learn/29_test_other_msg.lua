local skynet = require "skynet"

-- 注册system消息
skynet.register_protocol{
	name = "system",
	id = skynet.PTYPE_SYSTEM,
	-- pack = skynet.pack,
	-- unpack = skynet.unpack
}

skynet.start(function()
	local othermsg = skynet.localname(".othermsg")
	local r = skynet.unpack(skynet.rawcall(othermsg, "system", skynet.pack(1,"jph",true)))
	-- 使用skynet.call的时候, 必须要skynet.register_protocol指定pack与unpack
	-- local r = skynet.call(othermsg, "system", 1, "jph", true)
	skynet.error("skynet.call return value: ", r)
end)
