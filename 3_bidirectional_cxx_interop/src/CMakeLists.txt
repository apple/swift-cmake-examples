# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

add_executable(fibonacci_swift fibonacci.swift)
target_link_libraries(fibonacci_swift PRIVATE fibonacci)

add_executable(fibonacci_cpp fibonacci.cpp)
target_link_libraries(fibonacci_cpp PRIVATE fibonacci)
