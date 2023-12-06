SECTIONS
{
	. = 0x7c00 ;
	bootsect :
	{
		boot.o (.bspart1) /* 218 bt */
		FILL(0x00)
		. = 0x0da ;
		boot.o (.bstmstmp) /* 8 bt */
		. = 0x0e0 ;
		boot.o (.bspart2) /* 216 bt */
		boot.o (.bsdata)
		. = 0x1b8 ;
		boot.o (.bssign) /* 6 bt */
		/* partition table 4x16 bt */
		. = 0x1be ;
		boot.o (.parttbl)
		FILL(0x00)
		. = 0x1fe ;
		SHORT(0xaa55) /* boot signature */
	}
	. = 0x7e00 ;
	rest :
	{
		rest = . ;
		vga.o (.vga)
		*(.text)
		*(.rodata*)
		*(.data)
		*(.bss)
		*(COMMON)
/*		idt.o (.idt)*/
		/*. = 0x1fe ;*/
		/*SHORT(0x1111)*/
/*		. = 0x200 ;
		idt.o (.trampo)
		. = 0x3fe ;
		idt.o (.idtext)
		FILL(0x00)
		. = 0x7fe ;
		SHORT(0x1d35)
		prog.o (.bsrmio)
		. = 0xdfe ;
		SHORT(0xf1f0)*/
		endbase = . ;
	}
	basesize = (endbase - rest) / 0x200 + 1;
}

