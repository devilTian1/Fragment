#include <string.h>
int strrindex(char s[], char t[]) {
    int i, j, k, m;
    i = strlen(s);
    j = strlen(t);
    i--, j--;
    for(; i >= 0; i--) {
        for (k = i, m = j; m >= 0 && s[k] == t[m] ; k--, m--) {
            ;
        }
        if (m == -1) {
            return ++k;
        }
    }
    return -1;
}
