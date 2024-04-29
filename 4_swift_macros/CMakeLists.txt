# This source file is part of the Swift open source project
#
# Copyright (c) 2024 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

cmake_minimum_required(VERSION 3.22...3.29)

project(StringifyMacroExample
  LANGUAGES Swift)

include(ExternalProject)

# Build the macros
#
# Macros must run on the same machine doing the compiling, not the one that
# CMake is configured to build for. In order to support cross-compiling, we use
# ExternalProject to invoke CMake again. This project assumes that the compiler
# in toolchain is configured to compile for the builder by default. Otherwise,
# you will need to set the `CMAKE_Swift_COMPILER_TARGET` to the builder triple.
ExternalProject_Add(StringifyMacro
  SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/StringifyMacro"
  INSTALL_COMMAND "")
ExternalProject_Get_Property(StringifyMacro BINARY_DIR)
if(CMAKE_HOST_WIN32)
  set(StringifyMacroPath "${BINARY_DIR}/StringifyMacro.exe#StringifyMacro")
else()
  set(StringifyMacroPath "${BINARY_DIR}/StringifyMacro#StringifyMacro")
endif()

add_executable(HelloMacros main.swift)
add_dependencies(HelloMacros StringifyMacro)
target_compile_options(HelloMacros PRIVATE -load-plugin-executable "${StringifyMacroPath}")
