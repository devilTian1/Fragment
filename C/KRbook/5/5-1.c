#include <stdio.h>

extern int getch(void);
extern void ungetch(int);

int getint(int *pn) {
    int c, d, sign;

    while (isspace(c = getch())) {
        ;
    }
    if (!isdigit(c) && c != EOF && c != '+' && c != '-') {
        //ungetch(c);
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
        *pn = 10 * *pn + (c - '0');
    }
    *pn *= sign;
    if (c != EOF) {
        ungetch(c);
    }
    return c;
}

main() {
    int n, array[10], getint(int *);
    for (n = 0; n < 10 && getint(&array[n]) != EOF; n++) {
        ;
    }
    printf("************\n");
    for (n = 0; n < 10; n++) {
        printf("%d\n", array[n]);
    }
}
