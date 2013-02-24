#include <stdio.h>
#include <string.h>

void reverse(char x[]) {
    static int i = 0;
    char c;
    if (i+1 < strlen(x)-1-i) {
        ++i;
        reverse(x);
    }
    c = x[i];
    x[i] = x[strlen(x)-1-i];
    x[strlen(x)-1-i] = c;
}   

main() {
    char x[] = "xy";
    void reverse(char []);
    reverse(x);
    printf("%s\n", x);
}
