#include <stdio.h>

extern void *my_fn(size_t size);

typedef struct MyS {
    int a;
    int b;
} MyS;

int main() {
    MyS *s = (MyS *)my_fn(sizeof(MyS));

    printf("Hello, World!\n");

    return 0;
}
