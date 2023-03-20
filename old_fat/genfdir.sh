#!/bin/bash

ord() {
		  LC_CTYPE=C printf '%d' "'$1"
  }

siz="$((du -B 1 --apparent-size $1 ) | awk '{print $1}')"

if [[ "$2" == *.ld ]]; then
#		>&2 echo "FAT baseval: $(head -n 1 "$2")"
		base="$(head -n 1 "$2" | sed 's/\/\*SHORT(//; s/)\*\///')"
		base="$((base-1))"
else
		exit 1
fi

bn="$(basename $1)"
ex="${bn##*.}"
bn="${bn%%.*}"

#>&2 echo "s=$siz"
#>&2 echo "b=$base"
#>&2 echo "bn=$bn"
#>&2 echo "ex=$ex"

# now output the file descriptor 8.3
for ((i=0;i<8;i++)); do
		if (( i < ${#bn} )); then
				val="${bn:$i:1}"
				val="${val^^}"
				val="$(ord $val)"
		else
				val="32"
		fi
		echo "BYTE($val)"
done

for ((i=0;i<3;i++)); do
		if (( i < ${#ex} )); then
				val="${ex:$i:1}"
				val="${val^^}"
				val="$(ord $val)"
		else
				val="32"
		fi
		echo "BYTE($val)"
done

echo "BYTE(0)"
echo "BYTE(0)"
echo "BYTE(0)"
echo "SHORT(0)"
echo "SHORT(0)"
echo "SHORT(0)"
echo "SHORT(0)"
echo "SHORT(0)"
echo "SHORT(0)"
echo "SHORT($base)"
echo "LONG($siz)"

