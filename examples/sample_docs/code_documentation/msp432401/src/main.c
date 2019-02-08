/**
 * @file main.c
 * @author John McAvoy
 */

#include <stdint.h>
#include <stdio.h>
#include "msp432p401r.h"
#include "calculator.h"
#include "uart.h"

const char CALCULATION_DELIMINATOR = '\n'; // sets character code for end of calculation string
char input_buffer[256]; // sets char buffer for input from UART
uint8_t input_counter = 0; // counts chars added to input buffer

int main() {

    setup_uart();

    return 0;
}

// USCIA0_RX Interrupt Handler
void EUSCIA0_IRQHandler(void) {

    if (EUSCI_A0->IFG & EUSCI_A_IFG_RXIFG) {
        // if UA0RX flag set

        char rx_in = read_rx_buffer(); // read byte

        if(rx_in == '\n'){
            // end of equation
            input_counter = 0;
            Equation eq = parseInput(input_buffer, input_counter);

            char out_buffer[32];
            sprintf(out_buffer, "%d\n", calculate(eq));
            send_bytes(out_buffer, 32);
        }
        else
            input_buffer[input_counter++] = rx_in;
    }
}
