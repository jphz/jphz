local skynet = require "skynet"
local snax = require "skynet.snax"

-- 处理无响应请求

-- 通过obj.post.hello
function accept.hello(...)
	skynet.error("hello", ...)
end

-- obj.post.quit 来触发回调函数
function accept.quit(...)
	-- 等同snax.kill(snax.self(), ...)
	snax.exit(...)
end

function exit(...)
	skynet.error("snax server exit:", ...)
end
