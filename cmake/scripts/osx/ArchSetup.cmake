if(NOT CMAKE_TOOLCHAIN_FILE)
  message(FATAL_ERROR "CMAKE_TOOLCHAIN_FILE required for osx. See ${CMAKE_SOURCE_DIR}/cmake/README.md")
endif()

set(CORE_MAIN_SOURCE ${CMAKE_SOURCE_DIR}/xbmc/platform/posix/main.cpp
                     ${CMAKE_SOURCE_DIR}/xbmc/platform/darwin/osx/SDLMain.mm
                     ${CMAKE_SOURCE_DIR}/xbmc/platform/darwin/osx/SDLMain.h)

set(ARCH_DEFINES -DTARGET_POSIX -DTARGET_DARWIN -DTARGET_DARWIN_OSX)
set(SYSTEM_DEFINES -D_REENTRANT -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
                   -D__STDC_CONSTANT_MACROS)
set(PLATFORM_DIR platform/darwin)
set(PLATFORMDEFS_DIR platform/posix)
set(CMAKE_SYSTEM_NAME Darwin)
if(WITH_ARCH)
  set(ARCH ${WITH_ARCH})
else()
  if(CPU STREQUAL x86_64 OR CPU STREQUAL i386)
    set(ARCH x86-osx)
    set(NEON False)
  else()
    message(SEND_ERROR "Unknown CPU: ${CPU}")
  endif()
endif()

# Additional SYSTEM_DEFINES
list(APPEND SYSTEM_DEFINES -DHAS_LINUX_NETWORK -DHAS_SDL -DHAS_ZEROCONF)

list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${NATIVEPREFIX})

list(APPEND DEPLIBS "-framework DiskArbitration" "-framework IOKit"
                    "-framework IOSurface" "-framework SystemConfiguration"
                    "-framework ApplicationServices" "-framework AppKit"
                    "-framework CoreAudio" "-framework AudioToolbox"
                    "-framework CoreGraphics" "-framework CoreMedia"
                    "-framework VideoToolbox")

set(CMAKE_OSX_DEPLOYMENT_TARGET 10.9)
set(CMAKE_XCODE_ATTRIBUTE_CLANG_LINK_OBJC_RUNTIME OFF)

if(CMAKE_GENERATOR STREQUAL Xcode)
  set(CMAKE_XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES)
else()
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fobjc-arc")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fobjc-arc")
endif()
