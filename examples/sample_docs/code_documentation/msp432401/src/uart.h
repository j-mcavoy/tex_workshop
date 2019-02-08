/**
 * @file uart.h
 * @author John McAvoy
 */

#ifndef UART_H
#define UART_H

#include <stdint.h>
#include "Equation.h"

void setup_uart(void);           // see: setup_uart.s
char read_rx_buffer(void);       // see: read_rx_buffer.s
void write_tx_buffer(char c);    // see: write_tx_buffer.s

/**
 * @func parseInput
 * @param buffer        a char array of an equation
 * @param length        length of buffer
 * @returns a parsed Equation struct
 */
Equation parseInput(char buffer[], uint8_t length);


/**
 * @func send_bytes
 * @param buffer        a char array of message to be sent via UART
 * @param length        length of buffer
 */
void send_bytes(char buffer[], uint8_t length);

#endif // UART_H
