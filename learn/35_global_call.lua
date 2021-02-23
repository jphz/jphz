local skynet = require "skynet"

-- 节点间消息通信
harbor = require "skynet.harbor"
skynet.start(function()
	local globalluamsg = harbor.queryname("globalluamsg")
	local r = skynet.call(globalluamsg, "lua", "jph")
	skynet.error("skynet.call return value: ", r)
end)
