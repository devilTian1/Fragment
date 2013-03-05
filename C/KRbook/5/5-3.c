#include <stdio.h>

void mstrcpy(char *s, char *t) {
    while (*s++ = *t++) {
        ;
    }
}

int mstrcmp(char *s, char *t) {
    for (; *s != '\0'; s++, t++) {
        if (*s != *t) {
            return *s - *t;
        }
    }
    return 0;
}

void mstrcat(char *s, char *t) {
    while (*s) {
        s++;
    }
    while (*s++ = *t++) {
        ;
    }
}

main() {
    char *pmsg  = "i am tianye";
    char amsg[] = "i am tianye";
    mstrcat(amsg, pmsg);
    printf("%s\n", amsg);
}
