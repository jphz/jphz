local skynet = require "skynet"
local mc = require "skynet.multicast"
local channel
local channel_id = ... -- 从启动参数获取channel_id
channel_id = tonumber(channel_id)

local function recv_channel(channel, source, msg, ...)
	skynet.error("channel ID: ", channel, "source: ", skynet.address(source), "msg: ", msg)
end

-- channel.subscribe()
-- 绑定到一个频道后，默认并不接受这个频道上的消息，也许你只想向这个频道发布消息，你需要先调用channel:subscribe()订阅它。
skynet.start(function()
	channel = mc.new{
		channel = channel_id,	-- 绑定上一个频道
		dispatch = recv_channel	-- 设置这个频道的消息处理函数
	}

	channel:subscribe()
	-- 5秒钟后取消订阅
	skynet.timeout(500, function() channel:unsubscribe() end)
end)
