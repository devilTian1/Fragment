#include <stdio.h>

#define MAXCHAR 128
#define MAXHIST 15

main() {
    int lastc, c, cc[MAXCHAR], nl = 0;
    int i, j, len, maxvalue = 0;

    for (i = 0; i < MAXCHAR; i++) {
        cc[i] = 0;
    }
    while ((c = getchar()) != EOF) {
        if (c < MAXCHAR) {
            ++cc[c];
        }
    }

    for (i = 0; i < MAXCHAR; i++) {
        if (maxvalue < cc[i]) {
            maxvalue = cc[i];
        }
    }
    for (i = 0; i < MAXCHAR; i++) {
        printf("%5d - %c - %5d: ", i ,i, cc[i]);
        if (cc[i] > 0) {
            if ((len = cc[i] * MAXHIST / maxvalue) <= 0) {
                len = 1;
            }
        } else {
            len = 0;
        }
        for (j = len; j > 0; j--) {
            putchar('*');
        }
        putchar('\n');
    }
}
