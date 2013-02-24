#include <stdio.h>

int mstrend(char *s, char *t) {
    int i = 1, j = 1;
    while (*s) {
        s++;
    }
    while (*t) {
        i++;
        t++;
    }
    while ((*t-- == *s--)) {
        if (i == j) {
            break;
        }
        j++;
    }
    if (i == j) {
        return 1;
    } else {
        return 0;
    }
}

main() {
    char *pmsg  = "";
    char amsg[] = "";
    printf("%d\n", mstrend(amsg, pmsg));
}
