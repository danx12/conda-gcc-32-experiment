#include <stdio.h>

int main() {
    printf("Pointer size: %zu bytes\n", sizeof(void*));
    if (sizeof(void*) == 4) {
        printf("Hello from 32-bit mode!\n");
    } else {
        printf("Not 32-bit mode: %zu bits\n", sizeof(void*) * 8);
    }
    return 0;
}
