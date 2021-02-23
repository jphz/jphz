local skynet = require "skynet"

skynet.start(function()
	skynet.error("Server start")
	-- 启动刚才写的网关服务
	-- local gateserver = skynet.newservice("64_gate_server")
	-- local gateserver = skynet.newservice("67_gate_server")
	local gateserver = skynet.newservice("71_gate_server")
	-- 需要给网关发送open消息，来启动监听
	skynet.call(gateserver, "lua", "open", {
		port = 8001,		-- 监听端口
		maxclient = 64,		-- 客户端最大连接数
		nodelay = true		-- 是否延迟TCP
	})

	skynet.error("gate server setup on", 8001)
	skynet.exit()
end)
