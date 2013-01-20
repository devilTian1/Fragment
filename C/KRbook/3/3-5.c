#include <stdio.h> 

void itob(int n, char s[], int b);
void reverse(char s[]);
void reverse(char s[]) {
    int i, j = 0;
    char c;
    if (s[0] == '\0') {
        return ;
    }
    for (i = 0; s[i+1] != '\0'; i++) {
        ;
    }
    if (s[i] == '\n') {
        i--;
    }
    while (j < i) {
        c = s[j];
        s[j] = s[i];
        s[i] = c;
        i--, j++;
    }
    
}
void itob(int n, char s[], int b) {
    int i = 0, t, sign;
    if ((sign = n) < 0) {
        n = -n;   
    }
    do {
        t = n % b;
        if (t >= 0 && t <= 9) {
            s[i++] = t + '0';
        } else {
            s[i++] = t - 10 + 'A';
        }
    } while ((n/=b) > 0);
    if (sign < 0) {
        s[i++] = '-';
    }
    s[i] = '\0';
    reverse(s);
}

main() {
    char s[10];
    itob(-15, s, 16);
    printf("%s\n", s);
}
