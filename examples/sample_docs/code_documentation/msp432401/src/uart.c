/**
 * @file uart.c
 * @author John McAvoy
 */

#include "msp432p401r.h"
#include "uart.h"
#include "Equation.h"
#include "calculator.h"

extern void setup_uart(void);           // see: setup_uart.s
extern char read_rx_buffer(void);       // see: read_rx_buffer.s
extern void write_tx_buffer(char c);    // see: write_tx_buffer.s

Equation parseInput(char buffer[], uint8_t length){
    Equation eq;
    eq.a = 0;
    eq.b = 0;

    uint8_t op_i = 0; // operator index
    for(uint8_t i = 0; i < length; i++){
        if(buffer[i] == ' ' && op_i == 0){
            // operator index found
            op_i = i + 1;
        }
    }

    eq.op = buffer[op_i];
    eq.a = charBuffer2Int(&buffer[0], op_i - 2);
    eq.b = charBuffer2Int(&buffer[op_i+2], length - op_i -1);

    return eq;
}

void send_bytes(char buffer[], uint8_t length){
    for(uint8_t i = length - 1; i >= 0; i--){
        while(!(EUSCI_A0->IFG & EUSCI_A_IFG_TXIFG)); // wait for TX to send
        write_tx_buffer(buffer[i]); // send char
    }
}
