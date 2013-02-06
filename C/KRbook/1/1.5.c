#include <stdio.h>

#define NONBLACK 'a'

main() {
    int c, lastc = NONBLACK;

    while ((c = getchar()) != EOF) {
        if (c != ' ' || lastc != ' ') {
            putchar(c);
        }
        lastc = c;
    }
}
