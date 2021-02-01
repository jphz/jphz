# 设置库生成路径
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/cservice)

# 遍历文件列表生成对应库
SET(FILE_LIST snlua logger gate harbor)
foreach (file ${FILE_LIST})
    add_library(${file} SHARED "service_${file}.c")
    set_target_properties(${file} PROPERTIES PREFIX "")
endforeach()