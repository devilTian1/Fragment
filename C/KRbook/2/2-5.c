#include <stdio.h>

#define NOFIND 0
#define FIND 1

void any(char s1[], char s2[]);

void any(char s1[], char s2[]) {
    int t  = NOFIND;
    int i, j, k;
    printf("s1: %s\ns2: %s\n", s1, s2);

    for (i = 0; s1[i] != '\0'; i++) {
        for (j = 0; s2[j] != '\0' && s1[i] != s2[j]; j++) {
            ;
        }
        if (s1[i] == s2[j]) {
            t = FIND;
            for (k = i-1; k >= 0 && s1[i] != s1[k]; k--) {
                ;
            }
            if (k < 0) {
                printf("%c pos-> %d\n", s1[i], i+1);
            }
        }
    }
    if (t == NOFIND) {
        printf("-1");
    }
}

main() {
    any("tianye", "w");
}
