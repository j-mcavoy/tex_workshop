; @file setup_uart_asm
; @author John McAvoy
; @desc exports "setup_uart" assembly function

eUSCI_A0                    EQU 0x40001000  ; eUSCI_A0 base address

; eUSCI_A0 Offsets
UCA0CTLW0   EQU 0x00  ; eUSCI_A0 Control Word 0
UCA0CTLW1   EQU 0x02  ; eUSCI_A0 Control Word 1
UCA0BRW     EQU 0x06  ; eUSCI_A0 Baud Rate Control
UCA0MCTLW   EQU 0x08  ; eUSCI_A0 Modulation Control
UCA0STATW   EQU 0x0A  ; eUSCI_A0 Status
UCA0RXBUF   EQU 0x0C  ; eUSCI_A0 Receive Buffer
UCA0TXBUF   EQU 0x0E  ; eUSCI_A0 Transmit Buffer
UCA0ABCTL   EQU 0x10  ; eUSCI_A0 Auto Baud Rate Control
UCA0IRCTL   EQU 0x12  ; eUSCI_A0 IrDA Control
UCA0IE      EQU 0x1A  ; eUSCI_A0 Interrupt Enable
UCA0IFG     EQU 0x1C  ; eUSCI_A0 Interrupt Flag
UCA0IV      EQU 0x1E  ; eUSCI_A0 Interrupt Vector



	AREA uart_config, CODE, READONLY ; code area for uart configuration
	EXPORT setup_uart ; exports setup_uart asm function to be linked to C code

setup_uart

    LDR     R1, =eUSCI_A0   ; load eUSCI_A0 base address to R1

    ; enabled, SMCLK, async, UART auto baud rate mode, one-stop bit, 8-bit char, MSB first, no parity
    MOV     R3, #0x26c1                    ; table 24-8 of user guide
    STRH    R3, [R1, #UCA0CTLW0]    ; configure UCA0CTLW0

    ; deglitch t0x26c1ime ~5ns
    MOV     R3, #0x00                ; table 24-13 of user guide
    STRH    R3, [R1, #UCA0CTLW1]    ; configure UCA0CTLW1

    ;; clock prescalar
    ;MOV     R3, 0x00                ; table 24-14 of user guide
    ;STRH    R3, [R1, =UCA0BRW]      ; configure UCA0BRW

    ; alternating second stage modulation, 4-th bit irst stage modulation, oversampling
    MOV     R3, #0xAA81              ; table 24-11 of user guide
    STRH    R3, [R1, #UCA0MCTLW]    ; configure UCA0MCTLW

    ; enable RX interrupt
    MOV     R3, #0x01              ; table 24-17 of user guide
    STRH    R3, [R1, #UCA0IE]       ; configure UCA0IE

    END

