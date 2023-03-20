#!/usr/bin/awk -f

BEGIN { fn=""; bs=""; xs=""; }

{
		if ($4 != fn) {
				if (fn != "") {
						print "add-symbol-file", fn, bs, xs;
						bs = "";
						xs = "";
				}
				fn = $4;
		}
		if ($1 == ".text") {
				bs = $2;
		} else if ($1 == ".vga" || $1 == ".bstext" || $1 == ".idtext") {
				bs = $2; # double for gdb to find
				xs = xs "-s " $1 " " $2 " ";
		} else {
				xs = xs "-s " $1 " " $2 " ";
		}
}

