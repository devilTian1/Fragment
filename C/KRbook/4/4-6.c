#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "calc.h"

#define MAXOP   100

main() {
    int i, type, var = 0;
    double op2, v;
    char s[MAXOP];
    double variable[26];
    
    for(i = 0; i < 26; i++) {
        variable[i] = 0.0;
    }
    while((type = getop(s)) != EOF) {
        switch(type) {
            case NUMBER:
                push(atof(s));
                break;
            case '+':
                push(pop() + pop());
                break;
            case '-':
                op2 = pop();
                push(pop() - op2);
                break;
            case '*':
                push(pop() * pop());
                break;
            case '/':
                op2 = pop();
                if (op2 != 0.0) {
                    push(pop() / op2);
                } else {
                    printf("error: zero divisor\n");
                }
                break;
            case '\n':
                v = pop();
                printf("\t%.8g\n", v);
                break;
            case '=' :
                pop();
                if (var >= 'A' && var <= 'Z') {
                    variable[var-'A'] = pop();
                    push(variable[var-'A']);
                } else {
                    printf("error: no variable name, %f\n", var);
                }
                break;
            default:
                if (type >= 'A' && type <= 'Z') {
                    push(variable[type-'A']);
                } else if (type == 'v') {
                    push(v);
                } else {
                    printf("error : unknown command %s\n", s);
                }
                break;
        }
        var = type;
    }
    return 0;
}
