/****************************************
 SuperH (SH-2) C compiler Startup Routine
 ----------------------------------------
     Rev1. March 21, 2003 by Thorn Aitch
 ****************************************/

/********************
 Section: .text (ROM)
 ********************/
    .section  .text

/************
 Vector Table
 ************/
_vector_top:
    .long     _start       ! #000
    .long     _stack+0x200 ! #001

/************
 Main Routine
 ************/
_start:
    mov.l    _pmain_sh, r8
    jsr      @r8
    mov      #0, r14

_endless:
    bra      _endless
    nop

    .align   4
_pmain_sh :     .long _main_sh

/**********************
 Section: .rodata (ROM)
 **********************/
    .section .rodata
    .align 4

/********************
 Section: .data (RAM)
 ********************/
    .section .data
    .align 4

/*******************
 Section: .bss (RAM)
 *******************/
    .section .bss
    .align 4

/*********************
 Section: .stack (RAM)
 *********************/
    .section .stack
    .align   4
_stack:
	.end

