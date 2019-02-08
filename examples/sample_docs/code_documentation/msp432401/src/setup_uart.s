#####################################################
# @file setup_uart.s                                #
# @author John McAvoy                               #
# @desc exports "setup_uart" assembly function      #
#####################################################


.equ eUSCI_A0,  0x40001000  @ eUSCI_A0 base address

# eUSCI_A0 Offsets
.equ UCA0CTLW0, 0x00        @ eUSCI_A0 Control Word 0
.equ UCA0CTLW1, 0x02        @ eUSCI_A0 Control Word 1
.equ UCA0BRW  , 0x06        @ eUSCI_A0 Baud Rate Control
.equ UCA0MCTLW, 0x08        @ eUSCI_A0 Modulation Control
.equ UCA0STATW, 0x0A        @ eUSCI_A0 Status
.equ UCA0RXBUF, 0x0C        @ eUSCI_A0 Receive Buffer
.equ UCA0TXBUF, 0x0E        @ eUSCI_A0 Transmit Buffer
.equ UCA0ABCTL, 0x10        @ eUSCI_A0 Auto Baud Rate Control
.equ UCA0IRCTL, 0x12        @ eUSCI_A0 IrDA Control
.equ UCA0IE   , 0x1A        @ eUSCI_A0 Interrupt Enable
.equ UCA0IFG  , 0x1C        @ eUSCI_A0 Interrupt Flag
.equ UCA0IV   , 0x1E        @ eUSCI_A0 Interrupt Vector

.global setup_uart @ exports setup_uart asm function to be linked to C code

.text
setup_uart:

    ldr     %r1, =eUSCI_A0   @ load eUSCI_A0 base address to R1

    # enabled, smclK, async, UART auto baud rate mode, one-stop bit, 8-bit char, MSB first, no parity
    mov     %r3, #0x26c1            @ table 24-8 of user guide
    strh    %r3, [%r1, #UCA0CTLW0]  @ configure UCA0CTLW0

    # deglitch t0x26c1ime ~5ns
    mov     %r3, #0x00              @ table 24-13 of user guide
    strh    %r3, [%r1, #UCA0CTLW1]  @ configure UCA0CTLW1

    # alternating second stage modulation, 4-th bit irst stage modulation, oversampling
    mov     %r3, #0xAA81            @ table 24-11 of user guide
    strh    %r3, [%r1, #UCA0MCTLW]  @ configure UCA0MCTLW

    # enable rx interrupt
    mov     %r3, #0x01              @ table 24-17 of user guide
    strh    %r3, [%r1, #UCA0IE]     @ configure UCA0IE

