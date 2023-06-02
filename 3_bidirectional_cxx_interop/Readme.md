# Ping Pong

This project demonstrates using Swift/C++ interop, creating two executables and
two libraries. One executable is written in C++, calling into a Swift library,
which calls into a C++ library. The other executable is written in Swift,
calling into a C++ library, which calls into a Swift library, bouncing control
flow between the two languages to compute fibonacci numbers.

## Requirements
 - Swift 5.9 or later
 - Clang 11 or Apple Clang shipped in Xcode 12 or newer
 - CMake 3.26 or later
 - Ninja

## Build

```sh
 $ mkdir build
 $ cd build
 $ cmake -G 'Ninja' ../
 $ ninja
```

## Run

Start in the build directory you created above. There are two executables under
`src/`. `src/fibonacci_cpp` is a program written in C++ that calls into a Swift
library, which calls back into C++. `src/fibonacci_swift` is a program written
in Swift that calls into a C++ library, which calls back into Swift. Both
compute the n'th fibonacci number, where `n` is 5.

Each step of computing the numbers prints whether it's running in Swift or C++,
and the value `x` at that step.

```sh
 $ ./src/fibonacci_cpp
x [swift]: 5
x [cpp]: 4
x [swift]: 3
x [cpp]: 2
x [swift]: 1
x [swift]: 0
x [cpp]: 1
x [swift]: 2
x [cpp]: 1
x [cpp]: 0
x [cpp]: 3
x [swift]: 2
x [cpp]: 1
x [cpp]: 0
x [swift]: 1
8

$ ./src/fibonacci_swift
x [cpp]: 5
x [swift]: 4
x [cpp]: 3
x [swift]: 2
x [cpp]: 1
x [cpp]: 0
x [swift]: 1
x [cpp]: 2
x [swift]: 1
x [swift]: 0
x [swift]: 3
x [cpp]: 2
x [swift]: 1
x [swift]: 0
x [cpp]: 1
8
```
