# This source file is part of the Swift open source project
#
# Copyright (c) 2024 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

cmake_minimum_required(VERSION 3.22...3.29)

project(StringifyMacro
  LANGUAGES Swift)

# We use FetchContent to download and build SwiftSyntax. Unlike ExternalProject,
# FetchContent does not re-invoke CMake, and the build graphs are merged. This
# exposes the variables and build targets in SwiftSyntax to our Macro project.
# Everything in this project is isolated, so you can have macros that require
# different versions of SwiftSyntax. They won't be able to link eachother, but
# will work together as imported by the compiler.
include(FetchContent)
FetchContent_Declare(SwiftSyntax
  GIT_REPOSITORY https://github.com/apple/swift-syntax.git
  GIT_TAG 84a4bedfd1294f6ee18e6dc9ad70df55fa6230f6)
FetchContent_MakeAvailable(SwiftSyntax)

add_executable(StringifyMacro macro.swift)
target_compile_options(StringifyMacro PRIVATE -parse-as-library)
target_link_libraries(StringifyMacro
  SwiftSyntax
  SwiftSyntaxMacros
  SwiftCompilerPlugin)
