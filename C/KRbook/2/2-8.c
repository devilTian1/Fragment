#include <stdio.h>

unsigned long rightrot(unsigned long x, int n);
int wordlength(void);
int wordlength(void) {
    int i;
    unsigned v = (unsigned)~0;
    for (i = 1; (v = v >> 1) > 0; i++) {
        ;
    }
    return i;
}

unsigned long rightrot(unsigned long x, int n) {
    unsigned long rbit;
    while (n-- > 0) {
        rbit = (x & 1) << (wordlength() -1);
        x = (x >> 1) | rbit;
    }
    return x;
}

main() {
    printf("%d\n", wordlength());
}
