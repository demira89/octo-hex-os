#CC=i686-elf-gcc -ffreestanding -L~/Downloads/prog/asm/ -llibgcc.a
#AS=i686-elf-as
#LD=i686-elf-ln -L./ -llibgcc.a
#OD=i686-elf-objdump
CC=i686-elf-gcc -fno-builtin -ffreestanding -nostdlib -fno-asynchronous-unwind-tables -g -m32 -fstrict-volatile-bitfields
AS=i686-elf-as
LD=i686-elf-gcc -Wl,--oformat,binary,--Map,ld_x.map,-cref,-melf_i386 -ffreestanding -nostdlib
LD2=i686-elf-gcc -Wl,--oformat,binary,-melf_i386 -ffreestanding -nostdlib
OD=i686-elf-objdump
SRCS= boot.s stage2.s pge.s vga.s
CSRCS= base.c min_mm.c longmath.c loader.c elf.c vga_mode.c
HDRS= fixmem.h basedefs.h
OBJS= ${SRCS:.s=.o} ${CSRCS:.c=.o}

# clear out all suffixes
.SUFFIXES:
# # list only those we use
.SUFFIXES: .o .s .c

all: boot.img

# for x64 -mno-red-zone to prevent 128bit intr state destruction
# in leaf function (function that don't call sth. and therefore
# dont have good stack alignment, etc.)

# here explicitly use 32-bit object files
# else gcc creates 64-bit output which is then run
# in 386 mode creating "funny" effect or
# 32-bit gcc output is incompatible with "64bit" assembler elf
# define a suffix rule for .s -> .o

.s.o : 
	$(AS) --32 -g -o $@ $<

.c.o : 
	$(CC) -c $< -o $@ -std=gnu99 -Wall -Wextra
	$(OD) -S -d --disassembler-options=intel -w --show-raw-insn $@ > asm_lst/$@.s

early.o: FORCE  # for updating the builddate

.PHONY: FORCE

# headers dependency
$(OBJS): $(HDRS)

boot.img: $(OBJS)
	$(LD) -T boot.ld -o $@ $(OBJS)

clean:
	rm $(OBJS) boot.img
	rm asm_lst/*

