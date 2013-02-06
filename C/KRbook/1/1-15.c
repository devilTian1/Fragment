#include <stdio.h>

float celsius(float fahr);
/* note */
main()
{
    float fahr;

    printf("\ttemperature\n");
    for (fahr  = 0; fahr <= 300; fahr += 20) {
        printf("%3.0f\t%6.1f\n", fahr, celsius(fahr));
    }
    return 0;
}

float celsius(float fahr) {
    return (5.0/9.0) * (fahr-32.0);
}
