#include <stdio.h>

unsigned long invert(unsigned long x, int p, int n);

unsigned long invert(unsigned long x, int p, int n) {
    return (~(~0<<n) << (p-n+1)) ^ x;
}

main() {
    printf("%d\n", invert(0111, 3, 1));
}
