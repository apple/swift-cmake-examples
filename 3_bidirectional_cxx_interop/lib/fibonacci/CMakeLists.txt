# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information


# Generate a C++ header from Swift sources
#
# This function is implemented in cmake/modules/AddSwift.cmake.
#
# _swift_generate_cxx_header_target(target-name,
#                                   SwiftModule/C++ namespace,
#                                   generated header path)
_swift_generate_cxx_header_target(
  fibonacci_swift_h
  SwiftFibonacci
  "${CMAKE_CURRENT_BINARY_DIR}/include/fibonacci/fibonacci-swift.h"
  SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/fibonacci.swift"
  SEARCH_PATHS "${PINGPONG_INCLUDE_DIR}")

# 1. Create a library from the Swift and C++ sources.
# 2. The library requires the Swift header in order to compile, so we create a
#    dependency between the library and the header target created above.
# 3. This libraries, and users of this library, will need to find the
#    generated header, so we direct CMake to emit `PUBLIC` a public header
#    search path, ensuring that dependees of this library also pick up this
#    search path.
# 4. Manually override the Swift module name to "SwiftFibonacci" to match the
#    name in the generated header header above.
# 5. Enable C++ interoperability mode on all Swift compilations. Again, this is
#    required for users of this library, so we make it 'PUBLIC' to ensure the
#    flag is propagated to users of the library. Emitting the flag is gated by
#    the COMPILE_LANGUAGE cmake generator expression to ensure that the flag is
#    only passed to the Swift compiler and not the C++ compiler.
add_library(fibonacci STATIC fibonacci.swift fibonacci.cpp)
add_dependencies(fibonacci fibonacci_swift_h)
target_include_directories(fibonacci PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/include")
set_target_properties(fibonacci PROPERTIES Swift_MODULE_NAME "SwiftFibonacci")
target_compile_options(fibonacci PUBLIC
  "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")
