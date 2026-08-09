********************************************************************************

	include	"lvo/exec_lib.i"
	include	"lvo/dos_lib.i"
	include	"dos/dos.i"

********************************************************************************

	machine	68000

********************************************************************************

	xdef	hello_world	; ELF symbol
	xdef	_hello_world ; Classic Amiga symbol

********************************************************************************

	section	"CODE",code

hello_world:
_hello_world:
	movem.l	d2-d3/a5-a6,-(sp)

	move.l	4.w,a6

	lea	dos_name,a1
	moveq	#0,d0
	jsr	_LVOOpenLibrary(a6)

	tst.l	d0
	beq.s	.error

	move.l	d0,a5   ; DOSBase
	move.l	a5,a6

	jsr	_LVOOutput(a6)
	move.l	d1,d4

	move.l	d4,d1
	lea	message,a0
	move.l	a0,d2
	move.l	#MESSAGE_LENGTH,d3
	jsr	_LVOWrite(a6)

	move.l	d4,d1
	lea	message_chip,a0
	move.l	a0,d2
	move.l	#MESSAGE_CHIP_LENGTH,d3
	jsr	_LVOWrite(a6)

	move.l	a5,a1
	move.l	4.w,a6
	jsr	_LVOCloseLibrary(a6)

	moveq	#RETURN_OK,d0
	bra.s	.return

.error:
	moveq	#RETURN_ERROR,d0

.return:
	movem.l	(sp)+,d2-d3/a5-a6
	rts

********************************************************************************

	section	"DATA",data

dos_name:
	dc.b	"dos.library",0

message:
	dc.b	"Hello world from ASM!",10,0
message_end:

MESSAGE_LENGTH	equ	message_end-message

********************************************************************************

	section	"DATA.MEMF_CHIP",data_c ; Chip RAM: data_c (HUNK), .MEMF_CHIP (ELF/elf2hunk)

message_chip:
	dc.b	"Hello world from ASM in chipmem!",10,0
message_chip_end:

MESSAGE_CHIP_LENGTH	equ	message_chip_end-message_chip

********************************************************************************

