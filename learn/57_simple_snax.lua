local skynet = require "skynet"
local snax = require "skynet.snax"

-- 处理有响应请求

-- 当其他服通过obj.req.echo调用时候，触发该回调函数，并返回应答
function response.echo(str)
	skynet.error("echo", str)
	return str:upper()
end

function init(...)
	skynet.error("snax server start:", ...)
end

function exit(...)
	skynet.error("snax server exit:", ...)
end
