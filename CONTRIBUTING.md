## Legal

By submitting a pull request, you represent that you have the right to license
your contribution to Apple and the Swift project, and agree by submitting the
patch that your contributions are licensed under the Apache 2.0 license (see
`LICENSE.txt`).

## How to submit a bug report

Please ensure to specify the following:

* Swift-CMake-Examples commit hash
* Platform (Windows, macOS, Linux)
* CMake version
* Swift version
* Clang version
* Simple steps to reproduce
  * Failing CMake command invocation

## How to submit a new example

Please keep examples self-contained; each example should be self-contained and
not require parts from other examples. If a new example requires additional
library or tool support from the system, the additional requirement should be
indicated clearly.

At this time, examples require [Swift](https://github.com/apple/swift),
[CMake](https://github.com/kitware/cmake), and
[Ninja](https://github.com/ninja-build/ninja), although some may have
requirements for other compilers.

To contribute new examples, please open a pull request at
https://github.com/apple/swift-cmake-examples.
