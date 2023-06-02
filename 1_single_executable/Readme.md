# Hello World

This is the simplest usage of Swift and CMake, building a single swift
executable.

## Build Instructions

### macOS and Linux:

```sh
$ mkdir build && cd build
$ cmake -G 'Ninja' ../
$ ninja hello
$ ./hello
Hello, world!
```

## Build Results

Building this project results in a single executable, `hello` in the build
directory.
