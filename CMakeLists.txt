cmake_minimum_required(VERSION 3.23)

project(icepic
    VERSION 0.1.0
    DESCRIPTION "Test library")

include(GNUInstallDirs)

# https://jeremimucha.com/2021/04/cmake-fundamentals-part8/
# We don't need it when packaging with guix
# Fix rpath for installation
# file(RELATIVE_PATH relativeRpath
#     ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
#     ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
# )
# set(CMAKE_INSTALL_RPATH $ORIGIN $ORIGIN/${relativeRpath})

add_library(icepic SHARED)
add_library(icepic::icepic ALIAS icepic)
add_executable(icepic_test)

target_include_directories(icepic PUBLIC
   "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>"
   "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")


# FILESETS do not work with export atm (
# (see https://github.com/aminya/project_options/pull/144)
# target_sources(icepic
#     PRIVATE src/icepic.c
#     PUBLIC FILE_SET HEADERS
#     BASE_DIRS ${PROJECT_SOURCE_DIR}/include
#     FILES "include/icepic.h")
#install(TARGETS icepic FILE_SET HEADERS)

target_sources(icepic PRIVATE src/icepic.c)
set_target_properties(icepic PROPERTIES PUBLIC_HEADER "include/icepic.h")

target_sources(icepic_test PRIVATE "test/test.c")
target_link_libraries(icepic_test PRIVATE icepic)

install(TARGETS icepic
    EXPORT icepic
    LIBRARY
    PUBLIC_HEADER)

install(TARGETS icepic_test RUNTIME)

install(EXPORT icepic
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/icepic"
    NAMESPACE icepic::
    FILE icepicConfig.cmake
 )

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/icepicConfigVersion.cmake
    VERSION 1.0.0
    COMPATIBILITY SameMajorVersion)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/icepicConfigVersion.cmake"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/icepic")

# build
#cmake -DCMAKE_BUILD_TYPE=Release ../libicepic && cmake --build . && cmake --install . --prefix ./bla

# install(TARGETS icepic_test RUNTIME)


# # install(
# #   TARGETS icepic
# #   DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/icepic
# #   FILE icepictargets.cmake)

# include(CMakePackageConfigHelpers)
# configure_package_config_file(
#   "Config.cmake.in"
#   "IcepicConfig.cmake"
#   INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/icepic
#   PATH_VARS
#     CMAKE_INSTALL_LIBDIR)

# write_basic_package_version_file(
#   ${CMAKE_CURRENT_BINARY_DIR}/IcepicConfigVersion.cmake
#   VERSION 1.0.0
#   COMPATIBILITY SameMajorVersion)

# export(EXPORT    IcepicTargets
#        FILE      "${CMAKE_CURRENT_BINARY_DIR}/icepic/IcepicTargets.cmake")

# # Copy the FooConfig.cmake to the build/Foo directory:
# # configure_file(cmake/FooConfig.cmake
# #                "${CMAKE_CURRENT_BINARY_DIR}/Foo/FooConfig.cmake"
# #                COPYONLY)

# # This is relative to CMAKE_INSTALL_PREFIX:
# # Change the location appropriately:
# set(ConfigPackageLocation lib/cmake/Icepic)
# install(EXPORT      IcepicTargets
#         FILE        IcepicTargets.cmake
#         DESTINATION ${ConfigPackageLocation})

# ### Install Config and ConfigVersion files
# install(
#   FILES "${CMAKE_CURRENT_BINARY_DIR}/IcepicConfig.cmake"
#         "${CMAKE_CURRENT_BINARY_DIR}/IcepicConfigVersion.cmake"
#   DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Icepic"
#   )

