/**
 * @file Equation.h
 * @author John McAvoy
 */

#ifndef EQUATION_H
#define EQUATION_H

#include <stdint.h>

// a <op> b
// EX: 3 + 4
typedef struct equation {
    int32_t a;
    char op;
    int32_t b;
} Equation;

#endif // EQUATION_H
