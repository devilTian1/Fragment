#include <stdio.h>
#define MAXLENGTH 1000
#define LONGLINE  80

int getStrLength(char line[], int lim);

main() {
    int len = 0;
    char line[MAXLENGTH];
    while ((len = getStrLength(line, MAXLENGTH)) > 0) {
        if (len > LONGLINE) {
            printf("%d, %s\n", len, line);
        }
    }
    return 0;
}

int getStrLength(char line[], int lim) {
    int i, c;
    int j = 0;
    for (i = 0; (c = getchar()) != EOF && c != '\n'; i++) {
        if (i < lim -2) {
            line[j] = c;
            j++;
        }
    }
    if (c == '\n') {
        line[j++] = c;
        i++;
    }
    line[j] = '\0';
    return i;
}
