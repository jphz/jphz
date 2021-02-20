local skynet = require "skynet"

function task()
	local r = skynet.call(".noresponse", "lua", "get")
	skynet.error("get Test", r)
	skynet.exit()
end

skynet.start(function()
	skynet.fork(task)
end)
