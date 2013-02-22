#include <stdio.h>
#include <string.h>

int abs(int x);
int abs(int x) {
    if (x < 0) {
        return -1 * x;
    } else {
        return x;
    }
}

void itoa(int n, char s[]);
void itoa(int n, char s[]) {
    int len = 0;
    static int i;
    if (n/10) {
        itoa(n/10, s);
    } else {
        if (n < 0) {
            s[i++] = '-';
        }
    }
    s[i++] = (abs(n) % 10) + '0';
    s[i] = '\0';
}


long prints(char n[]);
long printn(char n[]);
long printn(char n[]) {
    if (n[0] == '-') {
        return -1 * prints(n);
    } else {
        return prints(n);
    }
}

long prints(char n[]) {
    int sum = 0, len;
    char c;
    len = strlen(n)-1;
    c = n[len];
    n[len] = '\0';
    if (c == '-') {
        return 0;
    } else if (len > 0) {
        sum = prints(n) * 10 + (c - '0');
    } else {
        sum = c - '0';
    }
    return sum;
}

main() {
    char s[10] = "";
    //char x[] = "1342";
    //printf("%ld\n", printn(x));
    itoa(-12432, s);
    printf("%s\n", s);
}
