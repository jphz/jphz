# 指定库生成路径
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/luaclib)

# 设置编译选项
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -Wl,-E)

# skynet库
aux_source_directory(. DIR_SRCS)
add_library(skynet SHARED ${DIR_SRCS})
target_link_libraries(skynet ssl)

# client库
add_library(client SHARED lua-clientsocket.c lua-crypt.c lsha1.c)

# bson库
add_library(bson SHARED lua-bson.c)

# sproto库
add_library(sproto SHARED ./sproto/sproto.c ./sproto/lsproto.c)

# ltls库
add_library(ltls SHARED ltls.c)

# lpeg库
aux_source_directory("../3rd/lpeg" LPEG_SRCS)
add_library(lpeg SHARED ${LPEG_SRCS})

# lua库
add_definitions(-DLUA_USE_LINUX)
aux_source_directory("../3rd/lua" LUA_SRCS)
add_library(lua STATIC ${LUA_SRCS})

# lua-md5库
aux_source_directory("../3rd/lua-md5" LUA_MD5_SRCS)
add_library(md5 SHARED ${LUA_MD5_SRCS})

# 去掉lib前缀
SET(FILE_LIST skynet client bson ltls lpeg sproto md5)
foreach (file ${FILE_LIST})
    set_target_properties(${file} PROPERTIES PREFIX "")
endforeach ()