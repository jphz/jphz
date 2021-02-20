local skynet = require "skynet"
require "skynet.manager"

local harbor = require "skynet.harbor"

skynet.start(function()
	local handle = skynet.newservice("1_base")

	skynet.name(".alias", handle)	-- 给服务起一个本地别名
	skynet.name("alias", handle)	-- 给服务起一个全局别名

	handle = skynet.localname(".alias")	-- 查到本地名 不阻塞
	skynet.error("localname .alias handle: ", skynet.address(handle))

	-- 查不到全局名
	handle = skynet.localname("alias") -- 无法查询全局别名
	skynet.error("localname alias handle: ", skynet.address(handle))

	handle = harbor.queryname(".alias")	-- 查到本地名 不阻塞
	skynet.error("queryname .alias handle: ", skynet.address(handle))

	handle = harbor.queryname("alias")	-- 查到全局名 阻塞
	skynet.error("queryname alias handle: ", skynet.address(handle))
end)
