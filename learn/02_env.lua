local skynet = require "skynet"

skynet.start(function()
	-- 预先加载的环境变量是在config文件中配置的，加载完成后，所有的服务都可以获取这些变量。
	-- 也可以去设置环境变量，但是不能修改已经存在的环境变量。
	-- 环境变量设置完成后，当前节点上所有服务都能访问的到。
	-- 环境变量设置完成后，即使服务退出了，环境变量依然存在，所以不要滥用环境变量。
	skynet.setenv("name", "j")
	local name = skynet.getenv("name")
	skynet.error("name: ", name)

	local address = skynet.getenv("address")
	skynet.error("address: ", address)
end)
