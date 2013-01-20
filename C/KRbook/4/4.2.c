#include <stdio.h>
#include <ctype.h>

#define MAXLINE 100

main () {
    double sum, atof(char s[]);
    char line[MAXLINE];
    int getlines(char line[], int max);

    sum = 0;
    while (getlines(line, MAXLINE) > 0) {
        printf("\t%g\n", sum += atof(line));
    }
    return 0;
}
