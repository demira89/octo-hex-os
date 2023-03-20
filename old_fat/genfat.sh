#!/bin/bash

base=$1
nsec="$((du -B 512 --apparent-size $2 ) | awk '{print $1}')"

if [[ "$1" == *.ld ]]; then
		if [[ $(cat "$1" | wc -l) -gt 2 ]]; then
#				echo "IMa baseval: $(tail -n 2 "$1" | head -n 1)"
				base="$(tail -n 2 "$1" | head -n 1 | sed "s/SHORT(//; s/)//")"
				base="$((base+2))"
		else
#				echo "IMb baseval: $(head -n 1 "$1")"
#				echo "file: $(cat "$1")"
				base="$(head -n 1 "$1" | sed 's/\/\*SHORT(//; s/)\*\///')"
				base="$((base+1))"
		fi
fi

#echo "base=$base"
#echo "val=$nsec"
echo "/*SHORT($base)*/" >> $3
typeset -i i nsec
for ((i=0;i<nsec-1;i++)); do
		echo "SHORT($((i+base)))" >> $3
#		echo "val: $((i+base))"
done
echo "SHORT(0xffff)" >> $3


