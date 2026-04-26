set(_dist "${ENGINE_DIST_DIR}")

macro(import_engine_lib TARGET_NAME LIB_NAME)
    add_library(${TARGET_NAME} SHARED IMPORTED GLOBAL)

    set_target_properties(${TARGET_NAME} PROPERTIES
        IMPORTED_LOCATION             "${_dist}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}${LIB_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
        INTERFACE_INCLUDE_DIRECTORIES "${_dist}/include"
    )

    if(WIN32)
        set_target_properties(${TARGET_NAME} PROPERTIES
            IMPORTED_IMPLIB "${_dist}/lib/${LIB_NAME}.lib"
        )
    endif()
endmacro()

import_engine_lib(_engine_core    "cncore")
import_engine_lib(_engine_graphic "cngraphic")
import_engine_lib(_engine_audio   "cnaudio")
import_engine_lib(_engine_input   "cninput")
import_engine_lib(_engine_rgui   "rgui")
import_engine_lib(_engine_r2d   "r2d")
import_engine_lib(_engine_r3d   "r3d")

add_library(Engine::Core    ALIAS _engine_core)
add_library(Engine::Graphic ALIAS _engine_graphic)
add_library(Engine::Audio   ALIAS _engine_audio)
add_library(Engine::Input   ALIAS _engine_input)
add_library(Engine::RGUI   ALIAS _engine_rgui)
add_library(Engine::R2D   ALIAS _engine_r2d)
add_library(Engine::R3D   ALIAS _engine_r3d)
