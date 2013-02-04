#include <stdio.h>

main() {
    int c;
    int repeatSpace = 0;
    while ((c = getchar()) != EOF) {
        if (c == ' ' && repeatSpace == 1) {
            continue;
        } else if (c == ' ' && repeatSpace == 0) {
            repeatSpace = 1;
            putchar(' ');
        } else {
            repeatSpace = 0;
            putchar(c);
        }
    }
}
