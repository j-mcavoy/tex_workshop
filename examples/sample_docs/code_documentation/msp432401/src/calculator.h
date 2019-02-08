/**
 * @file calculator.h
 * @author John McAvoy
 */

#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <stdint.h>
#include "Equation.h"

/**
 * @func calculate
 * @param equation_str  a pointer to a char array of an equation chars
 * @param length        length of equation_str
 * @returns the solution to the equation
 */
int32_t calculate(Equation eq);

/**
 * @func calculate
 * @param buffer        a pointer to a char array of an integer
 * @param length        length of buffer
 * @returns the character representation of the integer
 */
int32_t charBuffer2Int(char *buffer, uint8_t length);

/**
 * @func calculates power of number
 * @param a             uint8_t
 * @param pow           uint8_t a raised to power
 * @returns a to the p power
 */
int32_t power(uint8_t a, uint8_t p);

#endif // CALCULATOR_H
