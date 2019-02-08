/**
  ******************************************************************************
  *  Copyright (C) 2012 - 2017 Texas Instruments Incorporated - http://www.ti.com/ 
  * 
  *  Redistribution and use in source and binary forms, with or without 
  *  modification, are permitted provided that the following conditions 
  *  are met:
  * 
  *   Redistributions of source code must retain the above copyright 
  *   notice, this list of conditions and the following disclaimer.
  * 
  *   Redistributions in binary form must reproduce the above copyright
  *   notice, this list of conditions and the following disclaimer in the 
  *   documentation and/or other materials provided with the   
  *   distribution.
  * 
  *   Neither the name of Texas Instruments Incorporated nor the names of
  *   its contributors may be used to endorse or promote products derived
  *   from this software without specific prior written permission.
  * 
  *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
  *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
  *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
  *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
  *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
  *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
  *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
  *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
  * 
  *  MSP432P401Y Interrupt Vector Table
  *
  ******************************************************************************
  */

  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

.global g_pfnVectors
.global Default_Handler

/* start address for the initialization values of the .data section.
defined in linker script */
.word _sidata
/* start address for the .data section. defined in linker script */
.word _sdata
/* end address for the .data section. defined in linker script */
.word _edata
/* start address for the .bss section. defined in linker script */
.word _sbss
/* end address for the .bss section. defined in linker script */
.word _ebss

/**
 * @brief  This is the code that gets called when the processor first
 *          starts execution following a reset event. Only the absolutely
 *          necessary set is performed, after which the application
 *          supplied main() routine is called.
 * @param  None
 * @retval : None
*/

  .section .text.Reset_Handler
  .weak Reset_Handler
  .type Reset_Handler, %function
Reset_Handler:
  ldr   sp, =_estack    /* set stack pointer */
/* Copy the data segment initializers from flash to SRAM */
  movs r1, #0
  b LoopCopyDataInit

CopyDataInit:
  ldr r3, =_sidata
  ldr r3, [r3, r1]
  str r3, [r0, r1]
  adds r1, r1, #4

LoopCopyDataInit:
  ldr r0, =_sdata
  ldr r3, =_edata
  adds r2, r0, r1
  cmp r2, r3
  bcc CopyDataInit
  ldr r2, =_sbss
  b LoopFillZerobss
/* Zero fill the bss segment. */
FillZerobss:
  movs r3, #0
  str r3, [r2], #4

LoopFillZerobss:
  ldr r3, = _ebss
  cmp r2, r3
  bcc FillZerobss

/* Call the clock system intitialization function.*/
    bl  SystemInit
/* Call static constructors */
    bl __libc_init_array
/* Call the applications entry point.*/
  bl main
  
    /* 6. Loop forever if returning from main */
LoopForever:
  b LoopForever
  
.size Reset_Handler, .-Reset_Handler

/**
 * @brief  This is the code that gets called when the processor receives an
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 *
 * @param  None
 * @retval : None
*/
    .section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b Infinite_Loop
  .size Default_Handler, .-Default_Handler
/******************************************************************************
*
* The minimal vector table for a Cortex M3.  Note that the proper constructs
* must be placed on this to ensure that it ends up at physical address
* 0x0000.0000.
*
******************************************************************************/
   .section .isr_vector,"a",%progbits
  .type g_pfnVectors, %object
  .size g_pfnVectors, .-g_pfnVectors


g_pfnVectors:
  .word _estack
  .word Reset_Handler
  .word NMI_Handler
  .word HardFault_Handler
  .word MemManage_Handler
  .word BusFault_Handler
  .word UsageFault_Handler
  .word 0
  .word 0
  .word 0
  .word 0
  .word SVC_Handler
  .word DebugMon_Handler
  .word 0
  .word PendSV_Handler
  .word SysTick_Handler
  .word PSS_IRQHandler                           /* PSS Interrupt             */
  .word CS_IRQHandler                            /* CS Interrupt              */
  .word PCM_IRQHandler                           /* PCM Interrupt             */
  .word WDT_A_IRQHandler                         /* WDT_A Interrupt           */
  .word FPU_IRQHandler                           /* FPU Interrupt             */
  .word FLCTL_A_IRQHandler                       /* Flash Controller Interrupt*/
  .word COMP_E0_IRQHandler                       /* COMP_E0 Interrupt         */
  .word COMP_E1_IRQHandler                       /* COMP_E1 Interrupt         */
  .word TA0_0_IRQHandler                         /* TA0_0 Interrupt           */
  .word TA0_N_IRQHandler                         /* TA0_N Interrupt           */
  .word TA1_0_IRQHandler                         /* TA1_0 Interrupt           */
  .word TA1_N_IRQHandler                         /* TA1_N Interrupt           */
  .word TA2_0_IRQHandler                         /* TA2_0 Interrupt           */
  .word TA2_N_IRQHandler                         /* TA2_N Interrupt           */
  .word 0
  .word 0
  .word EUSCIA0_IRQHandler                       /* EUSCIA0 Interrupt         */
  .word EUSCIA1_IRQHandler                       /* EUSCIA1 Interrupt         */
  .word EUSCIA2_IRQHandler                       /* EUSCIA2 Interrupt         */
  .word 0
  .word EUSCIB0_IRQHandler                       /* EUSCIB0 Interrupt         */
  .word 0
  .word EUSCIB2_IRQHandler                       /* EUSCIB2 Interrupt         */
  .word EUSCIB3_IRQHandler                       /* EUSCIB3 Interrupt         */
  .word ADC14_IRQHandler                         /* ADC14 Interrupt           */
  .word T32_INT1_IRQHandler                      /* T32_INT1 Interrupt        */
  .word T32_INT2_IRQHandler                      /* T32_INT2 Interrupt        */
  .word T32_INTC_IRQHandler                      /* T32_INTC Interrupt        */
  .word AES256_IRQHandler                        /* AES256 Interrupt          */
  .word RTC_C_IRQHandler                         /* RTC_C Interrupt           */
  .word DMA_ERR_IRQHandler                       /* DMA_ERR Interrupt         */
  .word DMA_INT3_IRQHandler                      /* DMA_INT3 Interrupt        */
  .word DMA_INT2_IRQHandler                      /* DMA_INT2 Interrupt        */
  .word DMA_INT1_IRQHandler                      /* DMA_INT1 Interrupt        */
  .word DMA_INT0_IRQHandler                      /* DMA_INT0 Interrupt        */
  .word PORT1_IRQHandler                         /* Port1 Interrupt           */
  .word PORT2_IRQHandler                         /* Port2 Interrupt           */
  .word PORT3_IRQHandler                         /* Port3 Interrupt           */
  .word PORT4_IRQHandler                         /* Port4 Interrupt           */
  .word PORT5_IRQHandler                         /* Port5 Interrupt           */
  .word PORT6_IRQHandler                         /* Port6 Interrupt           */


/*******************************************************************************
*
* Provide weak aliases for each Exception handler to the Default_Handler.
* As they are weak aliases, any function with the same name will override
* this definition.
*
*******************************************************************************/

  .weak NMI_Handler
  .thumb_set NMI_Handler,Default_Handler

  .weak HardFault_Handler
  .thumb_set HardFault_Handler,Default_Handler

  .weak MemManage_Handler
  .thumb_set MemManage_Handler,Default_Handler

  .weak BusFault_Handler
  .thumb_set BusFault_Handler,Default_Handler

  .weak UsageFault_Handler
  .thumb_set UsageFault_Handler,Default_Handler

  .weak SVC_Handler
  .thumb_set SVC_Handler,Default_Handler

  .weak DebugMon_Handler
  .thumb_set DebugMon_Handler,Default_Handler

  .weak PendSV_Handler
  .thumb_set PendSV_Handler,Default_Handler

  .weak SysTick_Handler
  .thumb_set SysTick_Handler,Default_Handler 

  .weak PSS_IRQHandler
  .thumb_set PSS_IRQHandler,Default_Handler

  .weak CS_IRQHandler
  .thumb_set CS_IRQHandler,Default_Handler

  .weak PCM_IRQHandler
  .thumb_set PCM_IRQHandler,Default_Handler

  .weak WDT_A_IRQHandler
  .thumb_set WDT_A_IRQHandler,Default_Handler

  .weak FPU_IRQHandler
  .thumb_set FPU_IRQHandler,Default_Handler

  .weak FLCTL_A_IRQHandler
  .thumb_set FLCTL_A_IRQHandler,Default_Handler

  .weak COMP_E0_IRQHandler
  .thumb_set COMP_E0_IRQHandler,Default_Handler

  .weak COMP_E1_IRQHandler
  .thumb_set COMP_E1_IRQHandler,Default_Handler

  .weak TA0_0_IRQHandler
  .thumb_set TA0_0_IRQHandler,Default_Handler

  .weak TA0_N_IRQHandler
  .thumb_set TA0_N_IRQHandler,Default_Handler

  .weak TA1_0_IRQHandler
  .thumb_set TA1_0_IRQHandler,Default_Handler

  .weak TA1_N_IRQHandler
  .thumb_set TA1_N_IRQHandler,Default_Handler

  .weak TA2_0_IRQHandler
  .thumb_set TA2_0_IRQHandler,Default_Handler

  .weak TA2_N_IRQHandler
  .thumb_set TA2_N_IRQHandler,Default_Handler

  .weak EUSCIA0_IRQHandler
  .thumb_set EUSCIA0_IRQHandler,Default_Handler

  .weak EUSCIA1_IRQHandler
  .thumb_set EUSCIA1_IRQHandler,Default_Handler

  .weak EUSCIA2_IRQHandler
  .thumb_set EUSCIA2_IRQHandler,Default_Handler

  .weak EUSCIB0_IRQHandler
  .thumb_set EUSCIB0_IRQHandler,Default_Handler

  .weak EUSCIB2_IRQHandler
  .thumb_set EUSCIB2_IRQHandler,Default_Handler

  .weak EUSCIB3_IRQHandler
  .thumb_set EUSCIB3_IRQHandler,Default_Handler

  .weak ADC14_IRQHandler
  .thumb_set ADC14_IRQHandler,Default_Handler

  .weak T32_INT1_IRQHandler
  .thumb_set T32_INT1_IRQHandler,Default_Handler

  .weak T32_INT2_IRQHandler
  .thumb_set T32_INT2_IRQHandler,Default_Handler

  .weak T32_INTC_IRQHandler
  .thumb_set T32_INTC_IRQHandler,Default_Handler

  .weak AES256_IRQHandler
  .thumb_set AES256_IRQHandler,Default_Handler

  .weak RTC_C_IRQHandler
  .thumb_set RTC_C_IRQHandler,Default_Handler

  .weak DMA_ERR_IRQHandler
  .thumb_set DMA_ERR_IRQHandler,Default_Handler

  .weak DMA_INT3_IRQHandler
  .thumb_set DMA_INT3_IRQHandler,Default_Handler

  .weak DMA_INT2_IRQHandler
  .thumb_set DMA_INT2_IRQHandler,Default_Handler

  .weak DMA_INT1_IRQHandler
  .thumb_set DMA_INT1_IRQHandler,Default_Handler

  .weak DMA_INT0_IRQHandler
  .thumb_set DMA_INT0_IRQHandler,Default_Handler

  .weak PORT1_IRQHandler
  .thumb_set PORT1_IRQHandler,Default_Handler

  .weak PORT2_IRQHandler
  .thumb_set PORT2_IRQHandler,Default_Handler

  .weak PORT3_IRQHandler
  .thumb_set PORT3_IRQHandler,Default_Handler

  .weak PORT4_IRQHandler
  .thumb_set PORT4_IRQHandler,Default_Handler

  .weak PORT5_IRQHandler
  .thumb_set PORT5_IRQHandler,Default_Handler

  .weak PORT6_IRQHandler
  .thumb_set PORT6_IRQHandler,Default_Handler

.end

