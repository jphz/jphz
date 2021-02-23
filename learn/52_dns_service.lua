local skynet = require "skynet"
require "skynet.manager"
local dns = require "skynet.dns"

-- 由于每个服务去调用dns接口查询ip时都会再这个服务上缓存一份，下次查询的时候速度就会快很多，但如果每个服务都保存一份，显示时浪费资源空间，下面我们来封装lua消息进行查询DNS服务。
local command = {}
function command.FLUSH()
	return dns.flush()
end

function command.GETIP(domain)
	return dns.resolve(domain)
end

skynet.start(function()
	dns.server()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		cmd = cmd:upper()
		local f = command[cmd]
		if f then
			skynet.retpack(f(...))
		else
			skynet.error(skynet.format("Unknown command %s", tostring(cmd)))
		end
	end)
	skynet.register(".dnsservice")
end)
