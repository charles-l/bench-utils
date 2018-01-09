#!/bin/sh
# build settings that I found to make builds a bit faster
mkdir build && cd build
CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -G Ninja ../llvm/ -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_CCACHE_BUILD=ON -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_USE_LINKER=lld -DLLVM_ENABLE_PROJECTS='lld;clang' -DCMAKE_C_FLAGS=-DLLVM_ENABLE_STATS -DCMAKE_CXX_FLAGS=-DLLVM_ENABLE_STATS
