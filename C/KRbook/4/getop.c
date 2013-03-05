#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include "calc.h"

#define MAXLINE 1000
#define BUFSIZE 100

char buf[BUFSIZE];
int bufp = 0;

int getch(void) {
    return bufp > 0 ? buf[--bufp] : getchar();
}
void ungetch(int c) {
    if (bufp >= BUFSIZE) {
        printf("ungetch: too many characters\n");
    } else {
        buf[bufp++] = c;
    }
}

void ungets(char s[]) {
    int i = strlen(s) - 1;
    while ((i--) >= 0) {
        ungetch(s[i]);
    } 
}

int li = 0;
char line[MAXLINE];
//int getlines(char line[], int max);
/*
int getop(char s[]) {
    int i, c;
        
    if (getlines(line, MAXLINE) == 0) {
        return EOF;
    } else {
        li = 0;
    }
    while ((s[0] = c = line[li++]) == ' ' || c == '\t') {
    //while ((s[0] = c = getch()) == ' ' || c == '\t') {
        ;
    }
    s[1] = '\0';

    i = 0;
    if (!isdigit(c) && c != '.' && c != '-') {
        return c;    }
    /*
    if (c == '-') {
        if (isdigit(c = getch()) || c == '.') {
            s[++i] = c;
        } else {
            if (c != EOF) {
                ungetch(c);
            }
            return '-';
        }
    }
    */
/*
    if (isdigit(c)) {
        //while (isdigit(s[++i] = c = getch())) {
        while (isdigit(s[++i] = c = line[li++])) {
            ;
        }
    }
    if (c == '.') {
        //while (isdigit(s[++i] = c = getch())) {
        while (isdigit(s[++i] = c = line[li++])) {
            ;
        }
    }
    s[i] = '\0';
    /*
    if (c != EOF) {
        ungetch(c);
    }
    */
/*
    li--;
    return NUMBER;
}
*/
