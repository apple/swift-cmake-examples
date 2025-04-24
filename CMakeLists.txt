# This source file is part of the Swift open source project
#
# Copyright (c) 2025 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information
# =============================================================================
# This file configure testing that each project configures and builds with
# ctest.
# It is not meant for configuring and building each project.

cmake_minimum_required(VERSION 3.22)
project(SwiftCMakeExamples LANGUAGES NONE)

include(CTest)

function(add_cmake_test name source_dir)
  cmake_parse_arguments(PARSE_ARGV 2 ARG "" "CMAKE_VERSION" "" )
  if(NOT ARG_CMAKE_VERSION)
    set(ARG_CMAKE_VERSION 3.22)
  endif()

  if(${CMAKE_VERSION} VERSION_LESS ${ARG_CMAKE_VERSION})
    message(STATUS "Skipping ${name} -- CMake version too old: ${CMAKE_VERSION} < ${ARG_CMAKE_VERSION}")
    return()
  endif()

  add_test(NAME "${name}-configure"
    COMMAND ${CMAKE_COMMAND}
      -G ${CMAKE_GENERATOR}
      -B "${name}-build"
      -S "${CMAKE_CURRENT_SOURCE_DIR}/${source_dir}"
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
  add_test(NAME "${name}-build" COMMAND
    ${CMAKE_COMMAND} --build "${name}-build")
  set_tests_properties("${name}-build" PROPERTIES DEPENDS "${name}-configure")
endfunction()

add_cmake_test(SingleExecutable 1_single_executable)
add_cmake_test(ExecutableLibrary 2_executable_library)
add_cmake_test(BidirectionalCxxInterop 3_bidirectional_cxx_interop
  CMAKE_VERSION 3.26)
add_cmake_test(SwiftMacros 4_swift_macros)
