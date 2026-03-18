#include <stdlib.h>
#include <stdio.h>

int main() {
    void *ptr = aligned_alloc(16, 64);
    if (ptr == NULL) {
        perror("aligned_alloc");
        return 1;
    }
    printf("Successfully allocated aligned memory at %p\n", ptr);
    free(ptr);
    return 0;
}
