# 最低CMake版本要求
cmake_minimum_required(VERSION 3.10.0)

# 项目名称
project(cmake)
set(CPACK_PROJECT_NAME ${PROJECT_NAME})

# 设置C/C++标准
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 头文件路径
include_directories("include")

# 枚举头文件
file(GLOB_RECURSE INCLUDES "include/*.h" "include/*.hpp")

# 枚举源文件
aux_source_directory("src" SOURCES)

# 输出路径
set(EXECUTABLE_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/out")

# 生成可执行的文件
add_executable(${PROJECT_NAME} ${SOURCES} ${INCLUDES})