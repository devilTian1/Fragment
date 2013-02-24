#include <stdio.h>

extern int getch(void);
extern void ungetch(int);

int getint(float *pn) {
    int c, d, sign, pow = 1;

    while (isspace(c = getch())) {
        ;
    }
    if (!isdigit(c) && c != EOF && c != '+' && c != '-') {
        *pn = 0;
        return 0;
    }
    sign = (c == '-') ? -1 : 1;
    if (c == '+' || c == '-') {
        d = c;
        if (!isdigit(c = getch())) {
            if (EOF != c) {
                ungetch(c);
            }
            ungetch(d);
            return d;
        }
    }
    for (*pn = 0; isdigit(c) ; c = getch()) {
        *pn = 10.0 * *pn + (c - '0');
    }
    if (c == '.') {
        c = getch();
        for (; isdigit(c) ; c = getch()) {
            *pn = 10.0 * *pn + (c - '0');
            pow *= 10; 
        }
    }
    *pn /= sign * pow;
    if (c != EOF) {
        ungetch(c);
    }
    return c;
}

main() {
    int n, getint(float *);
    float array[10];
    for (n = 0; n < 10 && getint(&array[n]) != EOF; n++) {
        ;
    }
    printf("************\n");
    for (n = 0; n < 10; n++) {
        printf("%6.2f\n", array[n]);
    }
}
