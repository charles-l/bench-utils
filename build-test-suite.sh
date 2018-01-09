# build the test-suite
TEST="MultiSource/Benchmarks/SciMark2-C" # path to the test you want to build (leave empty if you want to build everything)
TEST_SUITE_DIR="./test-suite" # directory of the test-suite repo
LLVM_BUILD_BIN_DIR="../build/bin" # directory for llvm binaries (needs clang, llvm and lld)

    ltoflags="-g -fno-omit-frame-pointer -flto      -fuse-ld=lld --for-linker=-mllvm --for-linker=-stats"
thinltoflags="-g -fno-omit-frame-pointer -flto=thin -fuse-ld=lld --for-linker=-mllvm --for-linker=-stats"

mkdir -p build-thinlto && (cd build-thinlto && PATH=../$LLVM_BUILD_BIN_DIR:$PATH CC=clang CXX=clang++ CFLAGS=$thinltoflags CXXFLAGS=$thinltoflags cmake -DTEST_SUITE_BENCHMARKING_ONLY=ON ../$TEST_SUITE_DIR)
(cd build-thinlto/$TEST && make)
echo "=== DONE BUILDING '$TEST' WITH THINLTO ==="

mkdir -p build-lto &&     (cd build-lto     && PATH=../$LLVM_BUILD_BIN_DIR:$PATH CC=clang CXX=clang++ CFLAGS=$ltoflags CXXFLAGS=$ltoflags cmake -DTEST_SUITE_BENCHMARKING_ONLY=ON ../$TEST_SUITE_DIR)
(cd build-lto/$TEST && make)
echo "=== DONE BUILDING '$TEST' WITH LTO ==="
