#####################################################
# @file write_tx_buffer                             #
# @author John McAvoy                               #
# @desc exports "write_tx_buffer" assembly function #
#####################################################

.equ eUSCI_A0,  0x40001000  @ eUSCI_A0 base address

# eUSCI_A0 Offsets
.equ UCA0TXBUF, 0x0E        @ eUSCI_A0 Transmit Buffer

.global write_tx_buffer     @ exports read_rx_buffer asm function to be linked to C code

.text
write_tx_buffer:

    ldr     %r1, =eUSCI_A0          @ load eUSCI_A0 base address to R1
    strb    %r0, [%r1, #UCA0TXBUF]  @ store R0 byte to UCA0TXBUF

