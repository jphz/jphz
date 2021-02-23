local skynet = require "skynet"
require "skynet.manager"

local realsvr = ...

skynet.start(function()
	-- 注册lua消息处理函数
	skynet.dispatch("lua", function(session, source, ...) -- 接收消息msg, sz
		-- 根据参数列表重新打包消息转发
		skynet.ret(skynet.rawcall(realsvr, "lua", skynet.pack(...)))
	end) -- 释放消息msg,sz
	skynet.register(".proxy")
end)
