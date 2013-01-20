#include <stdio.h>

unsigned long setbits(unsigned long x, int p, int n, int y);

unsigned long setbits(unsigned long x, int p, int n, int y) {
    return (x & ~(~(~0<<n)<<(p-n+1))) | ((~(~0 << n) & y)<<(p-n+1));
}

main() {
    printf("%d\n", setbits(0111, 3, 1, 0));
}
