# Showcase of interoperability between LLVM and C

```bash
# Generate main.ll
clang -S -emit-llvm main.c

# Generate my_fn.ll
clang -S -emit-llvm my_fn.c

# Link them together
llvm-link main.ll my_fn.ll -o merged.bc

# Generate object file
llc -filetype=obj merged.bc -o merged.o

# Link the object file with the C library
ld /usr/lib/crt1.o /usr/lib/crti.o merged.o /usr/lib/crtn.o -o merged -lc -dynamic-linker /lib/ld-linux-x86-64.so.2
```

## Additional commands

**Generate `<file>.ll` from `<file>.bc`**

```bash
llvm-dis <file>.bc
```

**lli is the LLVM interpreter that can run the LLVM IR code (.ll) or the bitcode (.bc) file**

```
lli <file>.ll
```

