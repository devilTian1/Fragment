#include <stdio.h>

long htoi(char s[]);

long htoi(char s[]) {
    int i;
    long result = 0;
    for (i = 0; s[i] != '\0'; i++) {
        if (s[i] == '0' && (s[i+1] == 'x' || s[i+1] == 'X')) {
            i++;
            continue;
        } else if (s[i] >= '0' && s[i] <= '9') {
            result = result * 16 + (s[i] - '0');
        } else if (s[i] >= 'a' && s[i] <= 'f') {
            result = result * 16 + (s[i] - 'a' + 10);
        } else if (s[i] >= 'A' && s[i] <= 'F') {
            result = result * 16 + (s[i] - 'A' + 10);
        }
    }
    return result;
}

main() {
    printf("%ld\n", htoi("0x10"));

}
