#include <stdio.h>

int atio(char s[]);
int atio(char s[]) {
    int i;
    long sum = 0;
    for(i = 0; s[i] >= '0' && s[i] <= '9'; i++) {
        sum = sum * 10 + (s[i] - '0');
    }
    return sum;
}

int lower(char c) {
    // return (c >= 'A' && c <= 'Z') ? c + 32 : c;
    if (c >= 'A' && c <= 'Z') {
        return c + 32;
    } else {
        return c;
    }
}
main () {
    printf("%ld, %c\n", atio("123"), lower('Q'));
    if (-1L > 1UL) {
        putchar('1');
    } else {
        putchar('0');
    }
    return 0;
}


