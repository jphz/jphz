local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
	-- 注册"lua"类型消息的回调函数
	skynet.dispatch("lua", function(session, address, msg)
		skynet.sleep(math.random(100, 500))
		skynet.retpack(msg:upper())
	end)
	skynet.register(".echoluamsg")
end)
