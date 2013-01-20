#include <stdio.h>

void expand(char s1[], char s2[]);
void expand(char s1[], char s2[]) {
    int i, j;
    char c;
    for (i = j = 0; s1[i] != '\0'; i++) {
        if (s1[i] == '-' && s1[i+1] - s1[i-1] > 0) {
           for(c = s1[i-1]+1; c < s1[i+1]; c++) {
                s2[j++] = c;
            }
        } else {
            s2[j++] = s1[i];
        }
    }
    s2[j] = '\0';
}

main() {
    char s1[] = "!-~", s2[100];
    expand(s1, s2);
    printf("%s, %s\n", s1, s2);
}
