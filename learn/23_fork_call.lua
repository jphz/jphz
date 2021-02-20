local skynet = require "skynet"

function task(id)
	for i = 1, 5 do
		skynet.error("task"..id.." call")
		skynet.error("task"..id.." return:", skynet.call(".echoluamsg", "lua", "task"..id))
	end
end

skynet.start(function()
	skynet.fork(task, 1)
	skynet.fork(task, 2)
end)
