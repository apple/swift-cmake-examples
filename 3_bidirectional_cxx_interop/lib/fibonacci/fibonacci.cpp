//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#include "fibonacci/fibonacci-swift.h"
#include <iostream>

int fibonacci_cpp(int x) {
  std::cout << "x [cpp]: " << x << std::endl;
  if (x <= 1) return 1;
  return SwiftFibonacci::fibonacciSwift(x - 1) + SwiftFibonacci::fibonacciSwift(x - 2);
}
