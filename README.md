# Showcase of interoperability between LLVM and C

The `main.ll` uses the `my_fn` which is defined in `my_fn.c`. The `my_fn.ll` is generated from `my_fn.c` and linked with `main.ll` to generate the `merged.bc`. The `merged.bc` is then converted to `merged.o` and linked with the C library to generate the executable `merged`.

```bash
# Generate my_fn.ll
clang -S -emit-llvm my_fn.c

# Link them together
llvm-link main.ll my_fn.ll -o merged.bc

# Generate object file
llc -filetype=obj merged.bc -o merged.o

# Link the object file with the C library
ld /usr/lib/crt1.o /usr/lib/crti.o merged.o /usr/lib/crtn.o -o merged -lc -dynamic-linker /lib/ld-linux-x86-64.so.2
```

The `ld` command needs an explanation:

- `/usr/lib/crt1.o` is the **C runtime initialization file 1**. It contains the **entry point** (_start) for the executable, which eventually calls the `main` function,

- `/usr/lib/crti.o` is the **C runtime initialization file 2**. It contributes some prologue functions used for constructor initialization,

- `/usr/lib/crtn.o` is the **C runtime finalization file**. It contains the epilogue functions used for destructor finalization.

Noticing that by using these object files, which depend on the `libc` library, we have to avoid to pass `-e main` to the `ld` command.

## Additional commands

**Generate `<file>.ll` from `<file>.bc`**

```bash
llvm-dis <file>.bc
```

**lli is the LLVM interpreter that can run the LLVM IR code (.ll) or the bitcode (.bc) file**

```
lli <file>.ll
```

