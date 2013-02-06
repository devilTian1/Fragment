#include <stdio.h>
#define MAXLENGTH 1000

int getStrLength(char line[], int lim);

main() {
    int len = 0, i;
    
    char line[MAXLENGTH];
    while ((len = getStrLength(line, MAXLENGTH)) > 0) {
        for (i = len-2; i >= 0; i--) {
            if (line[i] == '\t' || line[i] == ' ') {
                line[i] = '\n';
                line[i+1] = '\0';
            } else {
                break;
            }
        }
        if (line[0] != '\n' && line[1] != '\0') {
            printf("%d, %s\n", ++i, line);
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
