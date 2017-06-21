# bench-utils

Some utils I wrote for working on LLVM (specifically for benchmarking).

Many of them are just snippets stolen from the wiki and pasted into a conveniently named script. But hey, you need 'em.

* `clang-format-diff.py` - stolen from clang repo - required for format-diff
* `format-diff.sh` - formats diff of current branch against master
* `grab-pass.pl` - used for grepping out a pass from -print-before/after-all output
* `grab-patch.sh` - copy the patch (of the current branch against master) to the clipboard (Linux)
* `llvm-bench-sort.rb` - sorts the output
* `llvm-run-bench.rb` - used to generate a timings for a bunch of the benchmarks in the test-suite (requires some tweaking if you want to test other dirs)
