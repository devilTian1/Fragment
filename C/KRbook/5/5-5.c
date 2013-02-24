#include <stdio.h>

void mstrncpy(char *s, char *t, int n) {
    while ((*s++ = *t++) && n-- > 0) {
        ;
    }
    while (n-- > 0) {
        *s++ = '\0';
    }
}

int mstrncmp(char *s, char *t, int n) {
    int i = 0;
    for (; i < n && (*s != '\0'); s++, t++, i++) {
        if (*s != *t) {
            return *s - *t;
        }
    }
    return 0;
}

void mstrncat(char *s, char *t, int n) {
    while (*s) {
        s++;
    }
    while (--n >= 0 && (*s++ = *t++)) {
        ;
    }
    if (*s != '\0' && *--s != '\0') {
        *s = '\0';       
    }
}


main() {
    char *pmsg  = "tianye";
    char amsg[] = "tianxi";
    //mstrncpy(amsg, pmsg, 7);
    //printf("%s\n", amsg);
    //printf("%d\n", mstrncmp(amsg, pmsg, 4));
    mstrncat(amsg, pmsg, 10);
    printf("%s\n", amsg);
}
