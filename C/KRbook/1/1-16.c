#include <stdio.h>

#define MAXLINE 1000

int getLongestStr(char line[], int maxline);
void copy(char to[], char from[]);

main() {
    int len, max = 0;
    char line[MAXLINE];
    char longest[MAXLINE];

    while ((len = getLongestStr(line, MAXLINE)) > 0) {
        printf("%d, %s", len, line);
        if (len > max) {
            max = len;
            copy(longest, line);
        }
    }
    if (max > 0) {
        printf("%s", longest);
    }
    return 0;
}

int getLongestStr(char s[], int maxline) {
    int i, j = 0, c;
    for (i = 0; (c = getchar()) != EOF && c != '\n'; i++) {
        if (i < maxline-2) {
            s[j] = c;
            ++j;
        }
    }
    if (c == '\n') {
        s[j] = c;
        ++i;
        ++j;
    }
    s[j] = '\0';
    return i;
}

void copy(char to[], char from[]) {
    int i = 0;

    while ((to[i] = from[i]) != '\0') {
        ++i;
    }
}
