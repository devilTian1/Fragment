#include <stdio.h>
#define TABSTEP 8

main() {
    int c, pos = 0, nspace, i = 0, j;
    char s[1000];
    while ((c = getchar()) != EOF) {
        if (c == '\t') {
            nspace = TABSTEP - (pos % TABSTEP);
            for (j = 0; j < nspace; j++, pos++) {
                s[i++] = ' ';
            }
        } else if (c == '\n') {
            s[i++] = c;
            pos = 0;
        } else {
            s[i++] = c;
            pos++;
        }
    }
    s[i++] = '\n';
    s[i]   = '\0';
    printf("%s", s);
}
