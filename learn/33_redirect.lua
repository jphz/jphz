local skynet = require "skynet"

-- 伪造消息
-- skynet.redirect = function(dest,source,typename,...)
-- 伪造其他服务地址来发送一个消息，可以使用到skynet.redirect
-- 使用source服务地址，发送typename类型的消息dest服务，不需要接收响应，(source,dest只能是服务ID)
-- msg sz一般使用skynet.pack打包生成
local source, dest = ...
skynet.start(function()
	source = skynet.localname(source)
	dest = skynet.localname(dest)
	skynet.redirect(source, dest, "lua", 0, skynet.pack("jph", 11.2, false))
end)
