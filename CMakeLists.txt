cmake_minimum_required(VERSION 3.20)
project(silk-editor C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

if(DEFINED ENGINE_DIST_DIR AND NOT IS_ABSOLUTE "${ENGINE_DIST_DIR}")
    get_filename_component(ENGINE_DIST_DIR "${ENGINE_DIST_DIR}" ABSOLUTE
        BASE_DIR "${CMAKE_BINARY_DIR}")
endif()

if(NOT DEFINED ENGINE_DIST_DIR)
    set(ENGINE_DIST_DIR "${CMAKE_SOURCE_DIR}/engine/dist")
endif()

if(EXISTS "${ENGINE_DIST_DIR}/lib" AND EXISTS "${ENGINE_DIST_DIR}/include")
    message(STATUS "[Engine] Found prebuilt dist at ${ENGINE_DIST_DIR}")
    include(toolchain/engine_import.cmake)
else()
    message(STATUS "[Engine] No dist found at ${ENGINE_DIST_DIR} — building from source")
    add_subdirectory(engine)
endif()

add_executable(silk-editor
    src/main.c
    src/map_editor.c
)

target_include_directories(silk-editor
    PUBLIC
        include
)

target_link_libraries(silk-editor PRIVATE
    Engine::Core
    Engine::Graphic
    Engine::Audio
    Engine::Input
    Engine::RGUI
    Engine::R2D
    Engine::R3D
)