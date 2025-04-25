# Swift CMake Examples

This repository contains examples for using CMake to build Swift with different
project layouts, including using CMake to build pure-Swift projects, and
projects that use Swift-C++ interoperability.

## Requirements

The projects in this repository have been tested with the 5.7.3 Linux container,
as well as with the 5.7 compiler toolchain on macOS. For some of the examples
with more advanced usage, you may need a newer CMake than what is shipped by
the packages in your Linux distro.

 - CMake 3.22+\*
 - Ninja 1.5+
 - Swift 5.7+\*

\* Unless noted otherwise.

These projects build with the Ninja generator (e.g `cmake -G 'Ninja' ...`) and
likely do not work with the other generators.

## Single Executable

Directory: `1_single_executable`

This project demonstrates creating a simple executable written in Swift.

## Executable with Library

Directory: `2_executable_library`

This project demonstrates creating a single executable that links against a
Swift library.

## Bi-directional Swift/C++ Interop

Directory: `3_bidirectional_cxx_interop`

This project demonstrates mixing Swift and C++ in a library using the Swift/C++
interoperability in Swift 5.9. Requires CMake 3.26, Swift 5.9, and Clang 11 or
newer, or Apple Clang shipped in Xcode 12 or newer.

Requires:

 - CMake 3.26
 - Swift 5.9
 - Clang 11 or Apple Clang in Xcode 12 or newer

## Swift Macros

Directory: `4_swift_macros`

This project demonstrates how to build a custom macro in a CMake-based project
using the Swift macro support introduced in Swift 5.9.

Requires:

 - Swift 5.9 (macOS: Swift 5.9.0, Windows and Linux: Swift 5.9.1)

# Testing

Tests are run with `ctest`, configured with the CMakeLists at the top-level.

```sh
cmake -G Ninja -B build -S .
cd build
ctest -j --output-on-failure
```

When you add a test, add it to the top-level CMakeLists file and re-run CMake
from the test directory to ensure that the CTest files are updated
appropriately before trying to run the tests.

```sh
cmake .
ctest -j --output-on-failure
```
