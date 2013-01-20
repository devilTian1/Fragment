#include <stdio.h>

main() {
    enum loop {NO, YES};
    enum loop okloop = YES;

    int i = 0;
    char s[10];
    int lim = 10, c;
    while (okloop == YES) {
        if (i >= lim-1) {
            okloop = NO;
        } else if ((c = getchar()) == '\n') {
            okloop = NO;
        } else if (c == EOF) {
            okloop = NO;
        } else {
            s[i++] = c;
        }
    }
    printf("%d, %s\n", i, s);   
}
