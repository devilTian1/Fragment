#include <ctype.h>
#include <stdio.h>

int atoi(char s[]);

void shellsort(int v[], int n);

void shellsort(int v[], int n) {
    int gap, i, j, temp;

    for (gap = n/2; gap > 0; gap /= 2) {
        for (i = gap; i < n; i++) {
            for (j = i - gap; j >= 0 && v[j] > v[j+gap]; j-=gap) {
                temp = v[j];
                v[j] = v[j+gap];
                v[j+gap] = temp;
            }
        }
    }
}

int atoi(char s[]) {
    int i, n, sign;

    for (i = 0; isspace(s[i]); i++) {
        ;
    }
    sign = s[i] == '-' ? -1 : 1;
    if (s[i] == '+' || s[i] == '-') {
        i++;
    }
    for (n = 0; isdigit(s[i]); i++) {
        n = n * 10 + (s[i] - '0');
    }
    return n * sign;
}

main() {
    int c, i=0;
    char str[10];
    while ((c=getchar()) != EOF) {
        str[i++] = c;
    }
    printf("%d\n", atoi(str));
}
