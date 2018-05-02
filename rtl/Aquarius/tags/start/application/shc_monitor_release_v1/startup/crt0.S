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
    .long     _start       ! #002
    .long     _stack+0x200 ! #003
    .long     _gnrl_ilgl   ! #004
    .long     _unexpected  ! #005
    .long     _slot_ilgl   ! #006
    .long     _unexpected  ! #007
    .long     _unexpected  ! #008
    .long     _cpuerr      ! #009
    .long     _dmaerr      ! #010
    .long     _nmi         ! #011
    .long     _unexpected  ! #012
    .long     _unexpected  ! #013
    .long     _unexpected  ! #014
    .long     _unexpected  ! #015
    .long     _unexpected  ! #016
    .long     _unexpected  ! #017
    .long     _unexpected  ! #018
    .long     _unexpected  ! #019
    .long     _unexpected  ! #020
    .long     _unexpected  ! #021
    .long     _unexpected  ! #022
    .long     _unexpected  ! #023
    .long     _unexpected  ! #024
    .long     _unexpected  ! #025
    .long     _unexpected  ! #026
    .long     _unexpected  ! #027
    .long     _unexpected  ! #028
    .long     _unexpected  ! #029
    .long     _unexpected  ! #030
    .long     _unexpected  ! #031
    .long     _trap        ! #032
    .long     _trap        ! #033
    .long     _trap        ! #034
    .long     _trap        ! #035
    .long     _trap        ! #036
    .long     _trap        ! #037
    .long     _trap        ! #038
    .long     _trap        ! #039
    .long     _trap        ! #040
    .long     _trap        ! #041
    .long     _trap        ! #042
    .long     _trap        ! #043
    .long     _trap        ! #044
    .long     _trap        ! #045
    .long     _trap        ! #046
    .long     _trap        ! #047
    .long     _trap        ! #048
    .long     _trap        ! #049
    .long     _trap        ! #050
    .long     _trap        ! #051
    .long     _trap        ! #052
    .long     _trap        ! #053
    .long     _trap        ! #054
    .long     _trap        ! #055
    .long     _trap        ! #056
    .long     _trap        ! #057
    .long     _trap        ! #058
    .long     _trap        ! #059
    .long     _trap        ! #060
    .long     _trap        ! #061
    .long     _trap        ! #062
    .long     _trap        ! #063
    .long     _irq0        ! #064
    .long     _irq1        ! #065
    .long     _irq2        ! #066
    .long     _irq3        ! #067
    .long     _irq4        ! #068
    .long     _irq5        ! #069
    .long     _irq6        ! #070
    .long     _irq7        ! #071

/***************
 General Illegal
 Slot Illegal
 ***************/
_gnrl_ilgl:
_slot_ilgl:
    mov.l    _pillegal, r0
    jsr      @r0
    nop
_restart:
    mov.l    _pvector_top, r1
    mov.l    @r1, r0
    jmp      @r0
    mov.l    @(4, r1), r15

/*****************
 CPU Address Error
 DMA Address Error
 Unexpected Vector
 *****************/
_cpuerr:
_dmaerr:
_unexpected:
    mov.l    _perror, r0
    jsr      @r0
    nop
    bra      _restart
    nop

/****************************
 NMI (Non Maskable Interrupt)
 ****************************/
_nmi:
    mov.l    r0, @-r15
    mov.l    r1, @-r15
    mov.l    _pbreak_reg_top, r1

    mov.l    @(12, r15), r0 ! sr
    mov.l    r0, @r1
    add      #4, r1
    mov.l    @( 8, r15), r0 ! pc
    mov.l    r0, @r1
    add      #4, r1
    mov      r15, r0        ! sp
    add      #8, r0
    mov.l    r0, @r1
    add      #4, r1
    sts      pr, r0         ! pr
    mov.l    r0, @r1
    add      #4, r1
    mov.l    @( 4, r15), r0 ! r0
    mov.l    r0, @r1
    add      #4, r1
    mov.l    @( 0, r15), r0 ! r1
    mov.l    r0, @r1
    add      #4, r1
    mov.l    r2, @r1        ! r2
    add      #4, r1
    mov.l    r3, @r1        ! r3
    add      #4, r1
    mov.l    r4, @r1        ! r4
    add      #4, r1
    mov.l    r5, @r1        ! r5
    add      #4, r1
    mov.l    r6, @r1        ! r6
    add      #4, r1
    mov.l    r7, @r1        ! r7
    add      #4, r1
    mov.l    r8, @r1        ! r8
    add      #4, r1
    mov.l    r9, @r1        ! r9
    add      #4, r1
    mov.l    r10, @r1       ! r10
    add      #4, r1
    mov.l    r11, @r1       ! r11
    add      #4, r1
    mov.l    r12, @r1       ! r12
    add      #4, r1
    mov.l    r13, @r1       ! r13
    add      #4, r1
    mov.l    r14, @r1       ! r14
    add      #4, r1
    mov      r15, r0        ! r15
    add      #8, r0
    mov.l    r0, @r1
    add      #4, r1
    sts      mach, r0       ! mach
    mov.l    r0, @r1
    add      #4, r1
    sts      macl, r0       ! macl
    mov.l    r0, @r1
    add      #4, r1
    stc      gbr, r0        ! gbr
    mov.l    r0, @r1
    add      #4, r1
    stc      vbr, r0        ! vbr
    mov.l    r0, @r1

    mov.l    _pnmi_handler, r0
    jsr      @r0
    nop
    bra      _restart
    nop

/***********************
 IRQ (Interrupt Request)
 ***********************/
_irq0:
_irq1:
_irq2:
_irq3:
_irq4:
_irq5:
_irq6:
_irq7:
    stc.l   gbr, @-r15
    stc.l   vbr, @-r15
    sts.l   mach, @-r15
    sts.l   macl, @-r15
    sts.l   pr, @-r15
    mov.l   r14, @-r15
    mov.l   r13, @-r15
    mov.l   r12, @-r15
    mov.l   r11, @-r15
    mov.l   r10, @-r15
    mov.l   r9, @-r15
    mov.l   r8, @-r15
    mov.l   r7, @-r15
    mov.l   r6, @-r15
    mov.l   r5, @-r15
    mov.l   r4, @-r15
    mov.l   r3, @-r15
    mov.l   r2, @-r15
    mov.l   r1, @-r15
    mov.l   r0, @-r15
    mov.l    _pirq_handler, r0
    jsr      @r0
    nop
    mov.l   @r15+, r0
    mov.l   @r15+, r1
    mov.l   @r15+, r2
    mov.l   @r15+, r3
    mov.l   @r15+, r4
    mov.l   @r15+, r5
    mov.l   @r15+, r6
    mov.l   @r15+, r7
    mov.l   @r15+, r8
    mov.l   @r15+, r9
    mov.l   @r15+, r10
    mov.l   @r15+, r11
    mov.l   @r15+, r12
    mov.l   @r15+, r13
    mov.l   @r15+, r14
    lds.l   @r15+, pr
    lds.l   @r15+, macl
    lds.l   @r15+, mach
    ldc.l   @r15+, vbr
    ldc.l   @r15+, gbr
    rte
    nop

/************
 TRAP Handler
 ************/
_trap:
    stc.l   gbr, @-r15
    stc.l   vbr, @-r15
    sts.l   mach, @-r15
    sts.l   macl, @-r15
    sts.l   pr, @-r15
    mov.l   r14, @-r15
    mov.l   r13, @-r15
    mov.l   r12, @-r15
    mov.l   r11, @-r15
    mov.l   r10, @-r15
    mov.l   r9, @-r15
    mov.l   r8, @-r15
    mov.l   r7, @-r15
    mov.l   r6, @-r15
    mov.l   r5, @-r15
    mov.l   r4, @-r15
    mov.l   r3, @-r15
    mov.l   r2, @-r15
    mov.l   r1, @-r15
    mov.l   r0, @-r15
    mov.l    _ptrap_handler, r0
    jsr      @r0
    nop
    mov.l   @r15+, r0
    mov.l   @r15+, r1
    mov.l   @r15+, r2
    mov.l   @r15+, r3
    mov.l   @r15+, r4
    mov.l   @r15+, r5
    mov.l   @r15+, r6
    mov.l   @r15+, r7
    mov.l   @r15+, r8
    mov.l   @r15+, r9
    mov.l   @r15+, r10
    mov.l   @r15+, r11
    mov.l   @r15+, r12
    mov.l   @r15+, r13
    mov.l   @r15+, r14
    lds.l   @r15+, pr
    lds.l   @r15+, macl
    lds.l   @r15+, mach
    ldc.l   @r15+, vbr
    ldc.l   @r15+, gbr
    rte
    nop

/**********************
 Break Information Area
 **********************/
    .org     _vector_top + 0x300
_break_reg_top:
_break_sr: .long 0xffffffff
_break_pc: .long 0xffffffff
_break_sp: .long 0xffffffff
_break_pr: .long 0xffffffff
_break_r0: .long 0xffffffff
_break_r1: .long 0xffffffff
_break_r2: .long 0xffffffff
_break_r3: .long 0xffffffff
_break_r4: .long 0xffffffff
_break_r5: .long 0xffffffff
_break_r6: .long 0xffffffff
_break_r7: .long 0xffffffff
_break_r8: .long 0xffffffff
_break_r9: .long 0xffffffff
_break_r10: .long 0xffffffff
_break_r11: .long 0xffffffff
_break_r12: .long 0xffffffff
_break_r13: .long 0xffffffff
_break_r14: .long 0xffffffff
_break_r15: .long 0xffffffff
_break_mach: .long 0xffffffff
_break_macl: .long 0xffffffff
_break_gbr: .long 0xffffffff
_break_vbr: .long 0xffffffff

/************
 Main Routine
 ************/
    .org     _vector_top + 0x400
_start:
    mov.l    _pvector_top, r8
    ldc      r8, vbr
    mov      #0x00, r8
    ldc      r8, sr
    mov.l    _pmain_sh, r8
    jsr      @r8
    mov      #0, r14

_endless:
    bra      _endless
    nop

    .align   4
_pmain_sh :      .long _main_sh
_pvector_top:    .long _vector_top
_pillegal:       .long _illegal
_perror:         .long _error
_pnmi_handler:   .long _nmi_handler
_pirq_handler:   .long _irq_handler
_ptrap_handler:  .long _trap_handler
_pbreak_reg_top: .long _break_reg_top


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

