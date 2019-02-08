//****************************************************************************
//
// MSP432 main.c
//
// Main Developers:
// Nate Hoffman, David Gaffney, Alex Marino
// Commented by:
//
//
// Description:
// UART Calculator
//
//****************************************************************************

#include "msp.h"

volatile uint32_t msTicks; /* counts 1ms timeTicks       */

extern void init_wdt(void);
extern void init_uart(void);
extern char uart_read(void);
extern void uart_write(char);

void separateInput(void);
void sendIt(void);
int calculator(int a, int b, int operand);

int inputCounter = 0;
char inputArray[40];
int firstInput;
int isFirstInputNeg;
int secondInput;
int isSecondInputNeg;
char operandInput;

volatile int outputCounter = 0;
volatile char outputArray[40];
int intOutput;
int isOutputNeg;

/*----------------------------------------------------------------------------
  SysTick_Handler
 *----------------------------------------------------------------------------*/
void SysTick_Handler(void)
{
    msTicks++;
}

/*----------------------------------------------------------------------------
  delays number of tick Systicks (happens every 1 ms)
 *----------------------------------------------------------------------------*/
void Delay(uint32_t dlyTicks)
{
    uint32_t curTicks;
    curTicks = msTicks;
    while ((msTicks - curTicks) < dlyTicks)
        ;
}

int main(void)
{
    init_wdt();
    init_uart();

    __enable_irq();

    NVIC->ISER[0] = 1 << ((EUSCIA0_IRQn)&31);

    // The following code configures P1.0 and P2.0-2 ports
    P1->DIR |= BIT0; // Configure P1.0 as output  LED Port 1
    P2->DIR |= 7; // Configure P2.0 - 2 as output  LED Port 2
    P1->OUT = 0; // Turn LED P1 off
    P2->OUT = 0; // Turn LED P2 off

    SystemCoreClockUpdate();
    SysTick_Config(SystemCoreClock / 1000); /* Systick interrupt each 1ms */

    while (1) {
        P1->OUT ^= BIT0; // LED1 Red ON P1.0
        Delay(500); // Delay 500 msec (500 times 1 SysTick interrupt)
        P1->OUT = 0; // LED1 Red OFF P1.0
        P2->OUT ^= BIT0; // LED2 Red ON P2.0
        Delay(500);
        P2->OUT = BIT1; // LED2 Green ON P2.1
        Delay(500);
        P2->OUT = BIT2; // LED2 Blue ON P2.2
        Delay(500);
        P2->OUT = 0; // LED2 Blue OFF P2.2
    }
}

void EUSCIA0_IRQHandler(void)
{
    char in;
    if (EUSCI_A0->IFG & EUSCI_A_IFG_RXIFG) {
        in = uart_read();

        if (in == '=') {
            // Do a calculation
            separateInput();
            intOutput = calculator(firstInput, secondInput, operandInput);
            sendIt();
        }
        else {
            // Store the entry
            inputArray[inputCounter] = in;
            inputCounter++;

            uart_write(in);
        }
    }

    if (EUSCI_A0->IFG & EUSCI_A_IFG_TXIFG) {
        EUSCI_A0->IFG &= ~EUSCI_A_IFG_TXIFG;

        if (outputCounter > 0) {
            outputCounter--;
            uart_write(outputArray[outputCounter]);
        }
    }
}

void separateInput()
{
    int i;
    firstInput = 0;
    isFirstInputNeg = 0;
    secondInput = 0;
    isSecondInputNeg = 0;
    operandInput = 0;
    for (i = 0; i < inputCounter; i++) {
        if ((inputArray[i] >= '0') && (inputArray[i] <= '9')) {
            if (operandInput == 0) {
                firstInput = (firstInput * 10) + (inputArray[i] - '0');
            }
            else {
                secondInput = (secondInput * 10) + (inputArray[i] - '0');
            }
        }
        else if ((inputArray[i] == '-') && (i == 0)) {
            isFirstInputNeg = 1;
        }
        else if ((inputArray[i] == 45) && !((inputArray[i - 1] >= '0') && (inputArray[i - 1] <= '9'))) {
            isSecondInputNeg = 1;
        }
        else {
            operandInput = inputArray[i];
        }
    }

    if (isFirstInputNeg == 1) {
        firstInput *= -1;
    }
    if (isSecondInputNeg == 1) {
        secondInput *= -1;
    }

    inputCounter = 0;
}

int calculator(int a, int b, int operand)
{
    switch (operand) {
        case '+':
            return a + b;
        case '-':
            return a - b;
        case '*':
            return a * b;
        case '/':
            return a / b;
        default:
            return 0;
    }
}

void sendIt()
{

    int digit = 0;

    outputArray[0] = '\r';
    outputArray[1] = '\n';

    if (intOutput == 0) {
        outputArray[2] = '0';
        outputCounter = 1;
        uart_write(outputArray[2]);
        return;
    }

    if (intOutput < 0) {
        isOutputNeg = 1;
        intOutput *= -1;
    }
    else {
        isOutputNeg = 0;
    }

    for (outputCounter = 2; intOutput != 0; outputCounter++) {
        digit = intOutput % 10;
        outputArray[outputCounter] = digit + '0';
        intOutput = intOutput / 10;
    }

    if (isOutputNeg == 1) {
        outputArray[outputCounter] = '-';
        outputCounter++;
    }

    uart_write('=');
}
