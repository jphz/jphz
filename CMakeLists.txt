# 校验CMake版本
cmake_minimum_required(VERSION 3.10)

# 工程名
project(skynet)

# 头文件路径
include_directories(
    skynet-src
    3rd/lua
    3rd/lua-md5
	3rd/jemalloc/include/jemalloc
    3rd/lpeg
    lualib-src
    lualib-src/sproto
)

# 库路径
link_directories(
    /usr/local/lib
    3rd/jemalloc/lib/
)

# 编译参数
add_definitions(-O3 -ggdb -Wall -std=gnu99 -pthread)

# 设置可执行文件输出目录
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR})

# 去这些目录下找CMakeLists.txt执行
subdirs(
    skynet-src
    service-src
    lualib-src
)
