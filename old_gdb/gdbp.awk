#!/usr/bin/awk -f

NF==4 && (/\.data/ || /\.rodata/ || /\.bss/ || /\.text/ || /\.vga/ || /\.bsrmio/ || /\.idtext/ || /\.bstext/ || /\.bsdata/ || /\.idt/ || /\.trampo/ ) {
		if($3 != "0x0")
				print;
}

