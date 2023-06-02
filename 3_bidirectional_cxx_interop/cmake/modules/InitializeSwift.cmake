# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

# Compute flags and search paths
# NOTE: This logic will eventually move to CMake
function(_setup_swift_paths)
  # If we haven't set the swift library search paths, do that now
  if(NOT SWIFT_LIBRARY_SEARCH_PATHS)
    if(APPLE)
      set(SDK_FLAGS "-sdk" "${CMAKE_OSX_SYSROOT}")
    endif()

    # Note: This does not handle cross-compiling correctly.
    #       To handle it correctly, we would need to pass the target triple and
    #       flags to this compiler invocation.
    execute_process(
      COMMAND ${CMAKE_Swift_COMPILER} ${SDK_FLAGS} -print-target-info
      OUTPUT_VARIABLE SWIFT_TARGET_INFO
    )

    # extract search paths from swift driver response
    string(JSON SWIFT_TARGET_PATHS GET ${SWIFT_TARGET_INFO} "paths")

    string(JSON SWIFT_TARGET_LIBRARY_PATHS GET ${SWIFT_TARGET_PATHS} "runtimeLibraryPaths")
    string(JSON SWIFT_TARGET_LIBRARY_PATHS_LENGTH LENGTH ${SWIFT_TARGET_LIBRARY_PATHS})
    math(EXPR SWIFT_TARGET_LIBRARY_PATHS_LENGTH "${SWIFT_TARGET_LIBRARY_PATHS_LENGTH} - 1 ")

    string(JSON SWIFT_TARGET_LIBRARY_IMPORT_PATHS GET ${SWIFT_TARGET_PATHS} "runtimeLibraryImportPaths")
    string(JSON SWIFT_TARGET_LIBRARY_IMPORT_PATHS_LENGTH LENGTH ${SWIFT_TARGET_LIBRARY_IMPORT_PATHS})
    math(EXPR SWIFT_TARGET_LIBRARY_IMPORT_PATHS_LENGTH "${SWIFT_TARGET_LIBRARY_IMPORT_PATHS_LENGTH} - 1 ")

    string(JSON SWIFT_SDK_IMPORT_PATH ERROR_VARIABLE errno GET ${SWIFT_TARGET_PATHS} "sdkPath")

    foreach(JSON_ARG_IDX RANGE ${SWIFT_TARGET_LIBRARY_PATHS_LENGTH})
      string(JSON SWIFT_LIB GET ${SWIFT_TARGET_LIBRARY_PATHS} ${JSON_ARG_IDX})
      list(APPEND SWIFT_SEARCH_PATHS ${SWIFT_LIB})
    endforeach()

    foreach(JSON_ARG_IDX RANGE ${SWIFT_TARGET_LIBRARY_IMPORT_PATHS_LENGTH})
      string(JSON SWIFT_LIB GET ${SWIFT_TARGET_LIBRARY_IMPORT_PATHS} ${JSON_ARG_IDX})
      list(APPEND SWIFT_SEARCH_PATHS ${SWIFT_LIB})
    endforeach()

    if(SWIFT_SDK_IMPORT_PATH)
      list(APPEND SWIFT_SEARCH_PATHS ${SWIFT_SDK_IMPORT_PATH})
    endif()

    # Save the swift library search paths
    set(SWIFT_LIBRARY_SEARCH_PATHS ${SWIFT_SEARCH_PATHS} CACHE FILEPATH "Swift driver search paths")
  endif()

  link_directories(${SWIFT_LIBRARY_SEARCH_PATHS})

  if(NOT APPLE)
    find_file(SWIFT_SWIFTRT_FILE
              swiftrt.o
              PATHS ${SWIFT_LIBRARY_SEARCH_PATHS}
              NO_CACHE
              REQUIRED
              NO_DEFAULT_PATH)
    add_link_options("$<$<LINK_LANGUAGE:Swift>:${SWIFT_SWIFTRT_FILE}>")
  endif()
endfunction()

_setup_swift_paths()
