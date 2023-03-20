OUTPUT_FORMAT(binary)
/*STARTUP(prog.o)*/
SECTIONS
{
	. = 0x7c00 ;
	bootsect :
	{
		prog.o (.bstext)
		prog.o (.bsdata)
		endbootsect = . ;
		FILL(0x00)
		/* partition table */
/*		. = 0x1be ;
		BYTE(0x80) *//* bootable */
/*		BYTE(0x00) *//* head 0 */
/*		BYTE(0x02) *//* sector 2 LBA 1 */
/*		BYTE(0x00) *//* cylinder 0 */
/*		BYTE(0x04) *//* type - fat16 */
		/* last sector 5760 CHS (18 per side) last is before cyl 160 */
/*		BYTE(0x01)
		BYTE(0x11)*/ /* 17 */
/*		BYTE(0x9f)*/
		/* start sector lba */
/*		LONG(0x00000001)*/
		/* end sector */
/*		LONG(5760)*/ /* minus a? */
		. = 0x1fe ;
		SHORT(0xaa55)
	}
	. = 0x7e00 ;
	rest :
	{
		rest = . ;
		idt.o (.idt)
		/*. = 0x1fe ;*/
		/*SHORT(0x1111)*/
		. = 0x200 ;
		idt.o (.trampo)
		. = 0x3fe ;
		idt.o (.idtext)
		FILL(0x00)
		. = 0x7fe ;
		SHORT(0x1d35)
		prog.o (.bsrmio)
		vga.o (.vga)
		. = 0xdfe ;
		SHORT(0xf1f0)
		endbase = . ;
		*(.text)
		*(.rodata*)
		. = ALIGN(0x1000) ;
		endtext = . ;
		*(.data)
		*(.bss)
		*(COMMON)
		*(.tdata)
		*(.tbss)
		FILL(0x00)
		. = 0x39dfe ;
		SHORT(0x789a)
		endrest = . ;
		/**(.symtab)*/
	}
	basesize = (endbase - rest) / 0x200 + 1;
	restsize = (endrest - rest) / 0x200 + 1;
	. = 0x47c00 ; /*(0x28000=512*512)*/
	fat16 :
	{
		/* media descriptor & 1 for sector 1 */
		SHORT(0xfff0)
		SHORT(0xffff) /* mandatory second entry */
		/* first file */
		SHORT(0x0003)
		SHORT(0x0004)
		SHORT(0xffff)
		INCLUDE ifats.ld
		/* free clusters (2880-2*14-512) */
		FILL(0x00)
		. = 0x2c00 ; /* 4x2880 */
	}
	fat16b :
	{
		SHORT(0xfff0)
		SHORT(0xffff)
		SHORT(0x0003)
		SHORT(0x0004)
		SHORT(0xffff)
		INCLUDE ifats.ld
		FILL(0x00)
		. = 0x2c00 ;
	}
	fat16f :
	{
		prog.o (.fat16dir)
		INCLUDE ifdirs.ld
		FILL(0x00)
		. = 0x1c00 ; /* 224*32 */
		/* fat16 files */
		prog.o (.fat16files)
		FILL(0x00)
		. = ALIGN(0x200) ;
		INCLUDE ifils.ld
	}
}

