local skynet = require "skynet"
-- 引入multicast模块后，你可以使用skynet的组播方案。你可以自由创建一个频道，并可以向其中投递任意消息。频道的订阅可以收到投递的消息。
local mc = require "skynet.multicast"
local channel

-- channel:publish(...)
-- 可以向一个频道发布消息，消息可以是任意数量合法的lua值。
function task()
	local i = 0
	while i < 100 do
		skynet.sleep(100)
		-- 推送数据
		channel:publish("data"..i)
		i = i + 1
	end
	channel:delete()
	skynet.exit()
end

skynet.start(function()
	-- 创建一个频道，成功创建后，channel.channel是这个频道的id
	channel = mc.new()
	skynet.error("new channel ID", channel.channel)
	skynet.fork(task)
end)
