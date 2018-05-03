/**************************************
 SuperH (SH-2) C Compiler Linker Script
 **************************************/ 

OUTPUT_FORMAT("elf32-sh")
OUTPUT_ARCH(sh)

MEMORY
{
	ram    : o = 0x00003000, l = 0x0e00
	stack  : o = 0x00003e00, l = 0x0200
}

SECTIONS 				
{ 					
.text :	{ 					
	*(.text) 				
	*(.strings)
   	 _etext = . ; 
	}  > ram

.tors : {
	___ctors = . ;
	*(.ctors)
	___ctors_end = . ;
	___dtors = . ;
	*(.dtors)
	___dtors_end = . ;
	}  > ram

.rodata : {
    *(.rodata)
    } >ram

__idata_start = ADDR(.text) + SIZEOF(.text) + SIZEOF(.tors) + SIZEOF(.rodata); 
.data : AT(__idata_start) {
	__idata_start = .;
        _sdata = . ;
	*(.data)
	_edata = . ;
	}  > ram
__idata_end = __idata_start + SIZEOF(.data);

.bss : {
	_bss_start = .;
	*(.bss)
	*(COMMON)
	_end = .;
	}  >ram

.stack :
	{
	_stack = .;
	*(.stack)
	} > stack
}
