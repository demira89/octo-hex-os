#!/usr/bin/awk -f

BEGIN { module = ""; type = "U"; }

#/LOAD/ { print $2 }
/ \.[a-z]+/ && NF==4 {
		module = $4;
		if ($1 == ".text")
				type = "T";
		else if ($1 == ".data")
				type = "D";
		else if ($1 == ".bss")
				type = "B";
		else if ($1 == ".rodata")
				type = "D";
		else if ($1 == ".bstext")
				type = "T";
		else if ($1 == ".bsrmio")
				type = "T";
		else if ($1 == ".bsdata")
				type = "D";
		else if ($1 == ".idt")
				type = "T";
		else
				type = "U";
#	   	print "td", $0 
}

/ *0x[0-9a-f]* *[_A-Za-z][_A-Za-z0-9]+/ && NF==2 {
		print substr($1,3), type, $2
}

