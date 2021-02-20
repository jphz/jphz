local skynet = require "skynet"

--[[
-- function skynet.newservice(name, ...)
-- 启动一个新的lua服务，name是脚本的名字(无需添加.lua后缀)。
-- 只有被启动的脚本的start函数返回后，这个api才会返回启动的服务地址，这是一个阻塞的API。
-- 如果被启动的脚本在初始化环境抛出异常，skynet.newservice也会执行失败。
-- 如果被启动的start函数是一个永不结束的循环，那么newservice也会被永远阻塞住。
--]]

skynet.start(function()
	skynet.error("start newservice 0")
	skynet.newservice("1_base")
	skynet.error("start newservice 1")
	skynet.newservice("1_base")
	skynet.error("end newservice")
end)
