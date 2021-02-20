local skynet = require "skynet"
require "skynet.manager"
local harbor = require "skynet.harbor"

skynet.start(function()
	handle = skynet.localname(".alias")
	skynet.error("localname .alias handle", skynet.address(handle))

	handle = skynet.localname("alias")
	skynet.error("localname alias handle", skynet.address(handle))

	handle = harbor.queryname(".alias")
	skynet.error("queryname .alias handle", skynet.address(handle))
	
	handle = harbor.queryname("alias")
	skynet.error("queryname alias handle", skynet.address(handle))

	skynet.kill(handle) -- 杀死带别名服务

	handle = skynet.localname(".alias")
	skynet.error("localname .alias handle", skynet.address(handle))

	handle = skynet.localname("alias")
	skynet.error("localname alias handle", skynet.address(handle))

	handle = harbor.queryname(".alias")
	skynet.error("queryname .alias handle", skynet.address(handle))
	
	handle = harbor.queryname("alias")
	skynet.error("queryname alias handle", skynet.address(handle))


end)
