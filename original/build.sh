# Do not use `-e main`

# Parse command line arguments: ./build.sh build or ./build.sh clean
# If no arguments are provided, the script will print an error message and exit
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided"
    echo "Usage: ./build.sh build or ./build.sh clean"
    exit 1
fi

if [ $1 = "build" ]; then
    # clang -S -emit-llvm main.c
    clang -S -emit-llvm my_fn.c
    llvm-link main.ll my_fn.ll -o merged.bc
    llc -filetype=obj merged.bc -o merged.o
    ld /usr/lib/crt1.o /usr/lib/crti.o merged.o /usr/lib/crtn.o -o merged -lc -dynamic-linker /lib/ld-linux-x86-64.so.2
fi

if [ $1 = "build-separate-o-files" ]; then
    # clang -S -emit-llvm main.c
    clang -S -emit-llvm my_fn.c
    llc -filetype=obj main.ll -o main.o
    llc -filetype=obj my_fn.ll -o my_fn.o
    ld main.o my_fn.o -o merged -e main -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2
fi

if [ $1 = "build-clang" ]; then
    # clang -S -emit-llvm main.c
    clang -S -emit-llvm my_fn.c
    llc -filetype=obj main.ll -o main.o
    llc -filetype=obj my_fn.ll -o my_fn.o
    clang main.o my_fn.o -o merged
fi

# if [ $1 = "test" ]; then
#     clang -S -emit-llvm test.c
#     llc -filetype=obj test.ll -o test.o
#     ld  /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/crtn.o test.o -lc -o test -dynamic-linker /lib/ld-linux-x86-64.so.2
# fi

if [ $1 = "clean" ]; then
    rm -f my_fn.ll main.o my_fn.o my_fn.o merged.bc merged.o merged test.o test.ll test
fi
