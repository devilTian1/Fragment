#include <stdio.h>

void escape(char t[], char s[]);

void escape(char t[], char s[]) {
    int i, j;
    for (i = j = 0; s[i] != '\0'; i++) {
        switch (s[i]) {
            case '\n':
                t[j++] = '\\';
                t[j++] = 'n';
                break;
            case '\t': 
                t[j++] = '\\';
                t[j++] = 't';
                break;
            default: 
                t[j++] = s[i];
                break;
        }
    }
    t[j] = '\0';
}

main() {
    char t[10];
    
    escape(t, "ti\n\tan\nyeaaaaa");
    printf("%s\n", t);
}
