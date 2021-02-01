# 查找当前目录下的所有源文件
aux_source_directory(. DIR_SRCS)

# 设置编译选项
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -Wl,-E)

# 生成可执行文件
add_executable(skynet_run ${DIR_SRCS})

# 添加依赖库
target_link_libraries(skynet_run jemalloc_pic pthread dl lua m ssl rt)