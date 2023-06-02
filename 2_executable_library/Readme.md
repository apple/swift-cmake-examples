# Factorials

This program demonstrates using CMake to build a Swift executable that uses a
Swift library.

## Build Instructions

### macOS and Linux:

```sh
$ mkdir build && cd build
$ cmake -G 'Ninja' ../
$ ninja factorials
$ ./src/factorials

factorial(0) = 1
factorial(1) = 1
factorial(2) = 2
factorial(3) = 6
factorial(4) = 24
factorial(5) = 120
factorial(6) = 720
factorial(7) = 5040
factorial(8) = 40320
factorial(9) = 362880
factorial(10) = 3628800
```

## Build Results

This project results in two primary build products, the `factorial` library, and
the `factorials` executable The library and the corresponding swiftmodule live
under the `lib/` directory, while the executable lives under the `src/`
directory.
