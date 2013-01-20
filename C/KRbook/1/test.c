#include <stdio.h>

main() {
    int min, max, step;
    float f, c;

    min = 0;
    max = 300;
    step = 20;

    for (f = min; min <= max; min += step) {
        c = 5 * (f-32) / 9;
        printf("%3.0f\t%6.2f\n", f, c);
        f += step;
    }
}
