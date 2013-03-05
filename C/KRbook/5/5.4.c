#include <stdio.h>

#define ALLOCSIZE 1000

static char allocbuf[ALLOCSIZE];

static char *allocp = allocbuf;

char *allow(int n) {
    if (allocbuf + ALLOCSIZE - allocp >= n) {
        allocp += n;
        return allocp -n;
    } else {
        return 0;
    }
}

void afree(char *p) {
    if (p >= allocbuf && p < allocbuf + ALLOCSIZE) {
        allocp = p;
    }
}

main() {

}
