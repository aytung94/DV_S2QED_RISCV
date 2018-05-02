	.file	"main.c"
gcc2_compiled.:
.section	.rodata
	.align 2
.LC0:
	.string	"<SuperH in FPGA>"
	.text
	.align 2
	.global	_main_sh
	.type	 _main_sh,@function
_main_sh:
	mov.l	r8,@-r15
	mov.l	r14,@-r15
	sts.l	pr,@-r15
	add	#-28,r15
	mov	r15,r14
	mov	r14,r1
	mov.l	.L10,r2
	mov	r14,r1
	mov	#17,r3
	mov	r15,r7
	mov	r1,r4
	mov	r2,r5
	mov	r3,r6
	mov.l	.L11,r8
	jsr	@r8
	nop
	mov.l	r14,@(20,r14)
	mov	r15,r1
	mov.l	.L12,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.l	.L13,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.w	.L14,r2
	mov	#0,r4
	mov	r2,r5
	mov.l	.L15,r8
	jsr	@r8
	nop
.L3:
	mov.l	@(20,r14),r1
	mov.b	@r1,r2
	extu.b	r2,r1
	tst	r1,r1
	bf	.L5
	bra	.L4
	nop
	.align 2
.L5:
	mov	r15,r1
	mov.l	.L13,r8
	jsr	@r8
	nop
	mov	r15,r2
	mov	r14,r1
	add	#20,r1
	mov.l	@r1,r2
	mov.b	@r2,r7
	extu.b	r7,r3
	add	#1,r2
	mov.l	r2,@r1
	mov	#1,r4
	mov	r3,r5
	mov.l	.L15,r8
	jsr	@r8
	nop
	bra	.L3
	nop
	.align 2
.L4:
	mov	r14,r1
	mov	r14,r2
	add	#24,r2
	mov	#0,r1
	mov.b	r1,@r2
.L6:
	bra	.L8
	nop
	bra	.L7
	nop
	.align 2
.L8:
	mov	r14,r1
	mov	r14,r2
	add	#24,r2
	mov.b	@r2,r1
	extu.b	r1,r2
	mov	r2,r1
	shlr2	r1
	shlr2	r1
	extu.b	r1,r2
	tst	r2,r2
	bf	.L9
	mov	r15,r1
	mov.l	.L13,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.w	.L16,r2
	mov	#0,r4
	mov	r2,r5
	mov.l	.L15,r8
	jsr	@r8
	nop
.L9:
	mov	r15,r1
	mov.l	.L13,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov	r14,r2
	mov	r14,r1
	add	#24,r1
	mov.b	@r1,r2
	mov	r2,r3
	add	#1,r3
	mov.b	r3,@r1
	extu.b	r2,r1
	mov	#1,r4
	mov	r1,r5
	mov.l	.L15,r8
	jsr	@r8
	nop
	bra	.L6
	nop
	.align 2
.L7:
.L2:
	add	#28,r14
	mov	r14,r15
	lds.l	@r15+,pr
	mov.l	@r15+,r14
	mov.l	@r15+,r8
	rts	
	nop
	.align 1
.L14:
	.short	128
.L16:
	.short	192
.L17:
	.align 2
.L10:
	.long	.LC0
.L11:
	.long	_memcpy
.L12:
	.long	_lcdinit
.L13:
	.long	_lcdready
.L15:
	.long	_lcdwr
.Lfe1:
	.size	 _main_sh,.Lfe1-_main_sh
	.align 2
	.global	_lcdready
	.type	 _lcdready,@function
_lcdready:
	mov.l	r8,@-r15
	mov.l	r14,@-r15
	sts.l	pr,@-r15
	mov	r15,r14
.L19:
	mov	r15,r1
	mov	#0,r4
	mov.l	.L22,r8
	jsr	@r8
	nop
	mov.w	.L23,r1
	and	r0,r1
	extu.b	r1,r2
	tst	r2,r2
	bf	.L21
	bra	.L20
	nop
	.align 2
.L21:
	bra	.L19
	nop
	.align 2
.L20:
.L18:
	mov	r14,r15
	lds.l	@r15+,pr
	mov.l	@r15+,r14
	mov.l	@r15+,r8
	rts	
	nop
	.align 1
.L23:
	.short	128
.L24:
	.align 2
.L22:
	.long	_lcdrd
.Lfe2:
	.size	 _lcdready,.Lfe2-_lcdready
	.align 2
	.global	_lcdrd
	.type	 _lcdrd,@function
_lcdrd:
	mov.l	r14,@-r15
	add	#-12,r15
	mov	r15,r14
	mov.l	r4,@r14
	mov.l	.L34,r1
	mov	r14,r3
	mov	r14,r2
	add	#3,r2
	mov	r1,r3
	add	#2,r1
	mov.b	@r2,r3
	mov	#1,r2
	and	r3,r2
	mov.b	@r1,r3
	mov.w	.L35,r7
	and	r3,r7
	mov	r7,r3
	or	r2,r3
	mov.b	r3,@r1
	mov.l	.L34,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov	#2,r3
	or	r2,r3
	mov.b	r3,@r1
	mov.l	.L34,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov.w	.L36,r3
	and	r2,r3
	mov.b	r3,@r1
	mov	r14,r2
	mov	r14,r1
	add	#8,r1
	mov.l	.L34,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
	mov	r14,r2
	mov	r14,r1
	add	#8,r1
	mov.l	.L34,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
	mov	r14,r2
	mov	r14,r1
	add	#8,r1
	mov.l	.L34,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
	mov.l	.L34,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov	#4,r3
	or	r2,r3
	mov.b	r3,@r1
	mov	#0,r1
	mov.l	r1,@(4,r14)
.L26:
	mov.l	@(4,r14),r1
	mov	#25,r2
	cmp/gt	r2,r1
	bf	.L29
	bra	.L27
	nop
	.align 2
.L29:
	mov	r14,r2
	mov	r14,r1
	add	#8,r1
	mov.l	.L34,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
.L28:
	mov.l	@(4,r14),r1
	mov	r1,r2
	add	#1,r2
	mov.l	r2,@(4,r14)
	bra	.L26
	nop
	.align 2
.L27:
	mov	r14,r2
	mov	r14,r1
	add	#9,r1
	mov.l	.L34,r3
	mov	r3,r2
	add	#3,r3
	mov.b	@r3,r2
	mov.b	r2,@r1
	mov.l	.L34,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov.w	.L36,r3
	and	r2,r3
	mov.b	r3,@r1
	mov	#0,r1
	mov.l	r1,@(4,r14)
.L30:
	mov.l	@(4,r14),r1
	mov	#25,r2
	cmp/gt	r2,r1
	bf	.L33
	bra	.L31
	nop
	.align 2
.L33:
	mov	r14,r2
	mov	r14,r1
	add	#8,r1
	mov.l	.L34,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
.L32:
	mov.l	@(4,r14),r1
	mov	r1,r2
	add	#1,r2
	mov.l	r2,@(4,r14)
	bra	.L30
	nop
	.align 2
.L31:
	mov	r14,r1
	mov	r14,r2
	add	#9,r2
	mov.b	@r2,r3
	extu.b	r3,r1
	mov	r1,r0
	bra	.L25
	nop
	.align 2
.L25:
	add	#12,r14
	mov	r14,r15
	mov.l	@r15+,r14
	rts	
	nop
	.align 1
.L35:
	.short	254
.L36:
	.short	251
.L37:
	.align 2
.L34:
	.long	-1412628480
.Lfe3:
	.size	 _lcdrd,.Lfe3-_lcdrd
	.align 2
	.global	_lcdwr
	.type	 _lcdwr,@function
_lcdwr:
	mov.l	r14,@-r15
	add	#-16,r15
	mov	r15,r14
	mov.l	r4,@r14
	mov	r5,r1
	mov	r14,r2
	mov	r14,r3
	add	#4,r3
	mov.b	r1,@r3
	mov.l	.L47,r1
	mov	r1,r2
	add	#3,r1
	mov	r14,r2
	mov	r14,r3
	add	#4,r3
	mov.b	@r3,r2
	mov.b	r2,@r1
	mov.l	.L47,r1
	mov	r14,r3
	mov	r14,r2
	add	#3,r2
	mov	r1,r3
	add	#2,r1
	mov.b	@r2,r3
	mov	#1,r2
	and	r3,r2
	mov.b	@r1,r3
	mov.w	.L48,r7
	and	r3,r7
	mov	r7,r3
	or	r2,r3
	mov.b	r3,@r1
	mov.l	.L47,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov.w	.L49,r3
	and	r2,r3
	mov.b	r3,@r1
	mov.l	.L47,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov.w	.L50,r3
	and	r2,r3
	mov.b	r3,@r1
	mov	r14,r2
	mov	r14,r1
	add	#12,r1
	mov.l	.L47,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
	mov	r14,r2
	mov	r14,r1
	add	#12,r1
	mov.l	.L47,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
	mov	r14,r2
	mov	r14,r1
	add	#12,r1
	mov.l	.L47,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
	mov.l	.L47,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov	#4,r3
	or	r2,r3
	mov.b	r3,@r1
	mov	#0,r1
	mov.l	r1,@(8,r14)
.L39:
	mov.l	@(8,r14),r1
	mov	#25,r2
	cmp/gt	r2,r1
	bf	.L42
	bra	.L40
	nop
	.align 2
.L42:
	mov	r14,r2
	mov	r14,r1
	add	#12,r1
	mov.l	.L47,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
.L41:
	mov.l	@(8,r14),r1
	mov	r1,r2
	add	#1,r2
	mov.l	r2,@(8,r14)
	bra	.L39
	nop
	.align 2
.L40:
	mov.l	.L47,r1
	mov	r1,r2
	add	#2,r1
	mov.b	@r1,r2
	mov.w	.L50,r3
	and	r2,r3
	mov.b	r3,@r1
	mov	#0,r1
	mov.l	r1,@(8,r14)
.L43:
	mov.l	@(8,r14),r1
	mov	#25,r2
	cmp/gt	r2,r1
	bf	.L46
	bra	.L44
	nop
	.align 2
.L46:
	mov	r14,r2
	mov	r14,r1
	add	#12,r1
	mov.l	.L47,r2
	mov.b	@r2,r3
	mov.b	r3,@r1
.L45:
	mov.l	@(8,r14),r1
	mov	r1,r2
	add	#1,r2
	mov.l	r2,@(8,r14)
	bra	.L43
	nop
	.align 2
.L44:
.L38:
	add	#16,r14
	mov	r14,r15
	mov.l	@r15+,r14
	rts	
	nop
	.align 1
.L48:
	.short	254
.L49:
	.short	253
.L50:
	.short	251
.L51:
	.align 2
.L47:
	.long	-1412628480
.Lfe4:
	.size	 _lcdwr,.Lfe4-_lcdwr
	.align 2
	.global	_lcdinit
	.type	 _lcdinit,@function
_lcdinit:
	mov.l	r8,@-r15
	mov.l	r14,@-r15
	sts.l	pr,@-r15
	add	#-4,r15
	mov	r15,r14
	mov	r15,r1
	mov	#0,r4
	mov	#48,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
	mov	#0,r1
	mov.l	r1,@r14
.L53:
	mov.l	@r14,r1
	mov.l	.L62,r2
	cmp/gt	r2,r1
	bf	.L55
	bra	.L54
	nop
	.align 2
.L56:
.L55:
	mov.l	@r14,r1
	mov	r1,r2
	add	#1,r2
	mov.l	r2,@r14
	bra	.L53
	nop
	.align 2
.L54:
	mov	r15,r1
	mov	#0,r4
	mov	#48,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
	mov	#0,r1
	mov.l	r1,@r14
.L57:
	mov.l	@r14,r1
	mov.w	.L63,r2
	cmp/gt	r2,r1
	bf	.L59
	bra	.L58
	nop
	.align 2
.L60:
.L59:
	mov.l	@r14,r1
	mov	r1,r2
	add	#1,r2
	mov.l	r2,@r14
	bra	.L57
	nop
	.align 2
.L58:
	mov	r15,r1
	mov	#0,r4
	mov	#48,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.l	.L64,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov	#0,r4
	mov	#56,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.l	.L64,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov	#0,r4
	mov	#12,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.l	.L64,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov	#0,r4
	mov	#1,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov.l	.L64,r8
	jsr	@r8
	nop
	mov	r15,r1
	mov	#0,r4
	mov	#6,r5
	mov.l	.L61,r8
	jsr	@r8
	nop
.L52:
	add	#4,r14
	mov	r14,r15
	lds.l	@r15+,pr
	mov.l	@r15+,r14
	mov.l	@r15+,r8
	rts	
	nop
	.align 1
.L63:
	.short	4999
.L65:
	.align 2
.L61:
	.long	_lcdwr
.L62:
	.long	204999
.L64:
	.long	_lcdready
.Lfe5:
	.size	 _lcdinit,.Lfe5-_lcdinit
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
