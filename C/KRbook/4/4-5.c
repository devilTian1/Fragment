#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

#define MAXOP   100
#define NUMBER  '0'

int getop(char []);
void push(double);
double pop(void);

void mathfunc(char s[]);

main() {
    int type;
    double op2;
    char s[MAXOP];

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
                printf("\t%.8g\n", pop());
                break;
            default:
                printf("error : unknown command %s\n", s);
                break;
        }
    }
}

void mathfunc(char s[]) {
    double op2, t;

    if (strcmp(s, "sin")) {
        op2 = pop();
        t = sin(op2);
        push(t);
    } else {
        printf("error %s", s);
    }
}