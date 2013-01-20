#include<stdio.h>
int getlines(char line[], int max) {
    int c, i;
    i = 0;
    while (--max > 0 && (c = getchar()) != EOF && c != '\n') {
        line[i++] = c;
    }
    if (c == '\n') {
        line[i++] = c;
    }
    line[i] = '\0';
    return i;
}


