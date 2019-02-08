#####################################################
# @file read_rx_buffer                              #
# @author John McAvoy                               #
# @desc exports "read_rx_buffer" assembly function  #
#####################################################

.equ eUSCI_A0,  0x40001000  @ eUSCI_A0 base address

# eUSCI_A0 Offsets
.equ UCA0RXBUF, 0x0C        @ eUSCI_A0 Receive Buffer

.global read_rx_buffer      @ exports read_rx_buffer asm function to be linked to C code

.text
read_rx_buffer:

    ldr     %r1, =eUSCI_A0          @ load eUSCI_A0 base address to R1
    ldrb    %r0, [%r1, #UCA0RXBUF]  @ load UCA0RXBUF byte to R0, which is returned
