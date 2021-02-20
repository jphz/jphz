local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		-- 在这里退出了服务
		skynet.exit()
	end)

	skynet.register(".noresponse")
end)
