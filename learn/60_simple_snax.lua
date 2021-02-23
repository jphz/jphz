local skynet = require "skynet"
local snax = require "skynet.snax"

local i = 10
gname = "jph"

-- 通过obj.post.hello
function accept.hello(...)
	skynet.error("hello", i, gname, ...)
end

-- obj.post.quit来触发回调函数
function accept.quit(...)
	snax.exit(...)
	-- 等同snax.kill(snax.self(), ...)
end

function init(...)
	skynet.error("snax server start:", ...)
end

function exit(...)
	skynet.error("snax server exit:", ...)
end
