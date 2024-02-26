# Stringify Macro Example

This project demonstrates building and using a Swift macro in CMake.

## Requirements
 - Swift 5.9 (5.9.0+ macOS, 5.9.1 Windows and Linux)

## Build Instructions

```sh
>  mkdir build && cd build
>  cmake -G 'Ninja' ../
>  ninja
>  ./HelloMacros
(4, "1 + 3")
```

## Description

Macros must build for the local machine doing the building, not the machine
you're building for because the compiler executes them. It's important to
consider the macro as a separate project from the main part of the codebase if
there is any chance you will want to cross-compile the project.

We can manually invoke CMake twice, once to build the macro, then again to build
the actual project for whatever platform we're building for, but that isn't very
convenient. Instead, we use `ExternalProject_Add` to include the macro project
which invokes compile

```cmake
ExternalProject_Add(StringifyMacro
  SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/StringifyMacro"
  INSTALL_COMMAND "")
ExternalProject_Get_Property(StringifyMacro BINARY_DIR)
string(StringifyMacroPath "${BINARY_DIR}/StringifyMacro#StringifyMacro")
```

Technically, neither the compiler nor CMake know the triple for the build
machine. This is normal, but inconvenient. We are assuming that the Swift
compiler is configured to compile for the build machine by default.
`ExternalProject_Add` doesn't forward variables from the current project into
the external project, which is normally a pain-point of external projects, but
in this case, is exactly what we want.

In the macro project, we need to import SwiftSyntax to access the macro
libraries. Since SwiftSyntax and the macro are built to run in the same
environment, we can use `FetchContent` to merge the build graphs and build the
entire macro project as one.
```cmake
FetchContent_Declare(SwiftSyntax
  GIT_REPOSITORY https://github.com/apple/swift-syntax.git
  GIT_TAG 247e3ce379141f81d56e067fff5ff13135bd5810)
FetchContent_MakeAvailable(SwiftSyntax)
```

Then it's just a matter of linking our macro executable against the needed
libraries.

```cmake
add_executable(StringifyMacro macro.swift)
target_compile_options(StringifyMacro PRIVATE -parse-as-library)
target_link_libraries(StringifyMacro
  SwiftSyntax
  SwiftSyntaxMacros
  SwiftCompilerPlugin)
```
