#!/usr/bin/fish

clang-format -style='{ BasedOnStyle: LLVM, IndentWidth: 4}' --dump-config > .clang-format
