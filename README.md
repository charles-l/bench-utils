# bench-utils

Some utils I wrote for working on LLVM (specifically for benchmarking).

Many of them are just snippets stolen from the wiki and pasted into a conveniently named script. But hey, you need 'em.

* `clang-format-diff.py` - stolen from clang repo - required for format-diff
* `format-diff.sh` - formats diff of current branch against master
* `grab-pass.pl` - used for grepping out a pass from -print-before/after-all output
* `grab-patch.sh` - copy the patch (of the current branch against master) to the clipboard (Linux)
* `llvm-bench-sort.rb` - sorts the output
* `llvm-run-bench.rb` - used to generate a timings for a bunch of the benchmarks in the test-suite (requires some tweaking if you want to test other dirs)
* `bench-prep.sh` - makes isolates single CPU core to make behavior deterministic
* `build-test-suite.sh` - build the test suite (or a single test) to compare ThinLTO and monolithic LTO (could be tweaked to compare some other set of flags)
* `build-llvm.sh` - small script with build flags I use with CMake

To build the test suite:

1. Set `$TEST` variable at top of `build-test-suite.sh` (if left empty, it'll build the whole test suite)
2. Run `build-test-suite.sh`
3. Run `bench-prep.sh` (to configure with `cset`) (if you don't do this, the benchmarking won't work)
4. Run `llvm-run-bench.rb` (picking the benchmark you just built from the list)
