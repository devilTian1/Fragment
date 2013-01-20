#include <stdio.h>

#define MAXLINE 1000
char pattern[] = "ould";

int strrindex(char source[], char searchfor[]);

main() {
    char line[MAXLINE];
    int found = 0;
    while (getlines(line, MAXLINE) > 0) {
        if (strrindex(line, pattern) >= 0) {
            printf("%s", line);
            found++;
        }
    }
    return found;
}
