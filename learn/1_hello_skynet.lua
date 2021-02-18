-- 引入skynet api
local skynet = require "skynet"

-- function skynet.start(start_func)
-- 用start_func函数初始化服务，并将消息处理函数注册到C层，让该服务可以工作。
skynet.start(function()
    -- skynet.error(...) 打印函数
    skynet.error("hello skynet.")
end)