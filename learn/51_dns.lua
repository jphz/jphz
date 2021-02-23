local skynet = require "skynet"
local dns = require "skynet.dns"

-- dns.server(ip, port)
-- port的默认值为53，如果不填写ip的话，将从/etc/resolv.conf中找到合适的ip

-- dns.resolve(name,ipv6)
-- 查询name对应的ip，如果ipv6为true则查询ipv6地址，默认为false。如果查询失败将抛出异常，成功则返回ip，以及一张包含所有ip的table。

-- dns.flush()
-- 默认情况下，模块会根据ttl值cache查询结果。在查询超时的情况下，也可能返回之前的结果。dns.flush可以用来清空cache。注意cache保存在调用服务中，并非针对整个skynet进程。所以，推荐写一个独立的dns查询服务统一处理dns查询。
skynet.start(function()
	-- 设置DNS服务器地址
	-- you can specify the server like dns.server("8.8.4.4", 53)
	skynet.error("nameserver", dns.server())

	local ip, ips = dns.resolve("jiangpenghui.cn")
	skynet.error("dns.resolve return: ", ip)
	for k,v in pairs(ips) do
		skynet.error("jiangpenghui.cn", v)
	end
	dns.flush()
end)
