#include <stdio.h>
#define MAXLENGTH 1000
#define LONGLINE  80

int getStrLength(char line[], int lim);
void reverse(char s[], int len);

main() {
    int len = 0;
    char line[MAXLENGTH];
    while ((len = getStrLength(line, MAXLENGTH)) > 0) {
        reverse(line, len);
        printf("%d, %s\n", len, line);
    }
    return 0;
}

void reverse(char s[], int len) {
    int i, temp;
    len -= 2; // delete \n and \0
    for (i = 0; i < len/2; i++) {
        temp = s[i];
        s[i] = s[len-i-1];
        s[len-i-1] = temp;
    }
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
