/**
 * @file calculator.c
 * @author John McAvoy
 */

#include <stdint.h>
#include "msp432p401r.h"
#include "Equation.h"
#include "calculator.h"

/**
 * @func calculate
 * @param equation_str  a pointer to a char array of an equation chars
 * @param length        length of equation_str
 * @returns the solution to the equation
 */
int32_t calculate(Equation eq) {
    switch(eq.op){
        case '+' : return eq.a +  eq.b;
        case '-' : return eq.a -  eq.b;
        case '*' : return eq.a *  eq.b;
        case '/' : return eq.a /  eq.b;
        case '^' : return eq.a ^  eq.b;
        case '|' : return eq.a |  eq.b;
        case '&' : return eq.a &  eq.b;
        case '>' : return eq.a >> eq.b;
        case '<' : return eq.a << eq.b;
    }
}

int32_t charBuffer2Int(char *buffer, uint8_t length){
    uint8_t sign = 1;
    if(*(buffer) == '-'){
        sign = -1;
        *(buffer) = '0';
    }

    int32_t num = 0;
    for (uint8_t i = sign; i < length; i++){
        num += (*(buffer + i) - '0') * power(10, (length - i));
    }

    return num * sign;
}

int32_t power(uint8_t a, uint8_t p){
    if(p == 0) {
        return 1;
    }
    else if(p == 1) {
        return a;
    }
    else {
        return a * power(a, p-1);
    }
}
