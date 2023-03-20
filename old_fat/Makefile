#CC=i686-elf-gcc -ffreestanding -L~/Downloads/prog/asm/ -llibgcc.a
#AS=i686-elf-as
#LD=i686-elf-ln -L./ -llibgcc.a
#OD=i686-elf-objdump
CC=gcc -fno-builtin -ffreestanding -nostdlib -fno-asynchronous-unwind-tables -g -m32 -fstrict-volatile-bitfields
AS=as
LD=gcc -Wl,--oformat,binary,--Map,ld_x.map,-cref,-melf_i386 -ffreestanding -nostdlib
LD2=gcc -Wl,--oformat,binary,-melf_i386 -ffreestanding -nostdlib
OD=objdump
SRCS= prog.s idt.s vga.s
CSRCS= early.c framebuffer.c kernel.c apic.c smp.c tasks.c i386-stub.c kbd.c kio.c libc.c mmgr.c module.c
XSRCS= ata_device.c partition.c disk_cache.c # Just for info
KOSRCS= pci.c file.c floppy.c ahci.c
HDRS= limits.h kernel.h kdata.h kbd.h pci.h ahci.h pci_regs.h elf.h elf-em.h file.h
OBJS= ${SRCS:.s=.o} ${CSRCS:.c=.o}
KOBJS=${KOSRCS:.c=.o}
FAT_BEGIN= 6

# clear out all suffixes
.SUFFIXES:
# # list only those we use
.SUFFIXES: .o .s .c

all: prog.img

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

framebuffer.o : framebuffer.c
	$(CC) -mmmx -msse -c $< -o $@ -std=gnu99 -Wall -Wextra
	$(OD) -S -d --disassembler-options=intel -w --show-raw-insn $@ > asm_lst/$@.s

.c.o : 
	$(CC) -c $< -o $@ -std=gnu99 -Wall -Wextra
	$(OD) -S -d --disassembler-options=intel -w --show-raw-insn $@ > asm_lst/$@.s

early.o: FORCE  # for updating the builddate

.PHONY: FORCE

#other:
#	$(CC) -c abc.c -std=c99 -Wall -Wextra
#	$(CC) -c def.c -std=c99 -Wall -Wextra
#	gcc -Wl,--oformat,elf32-i386,--Map,ld_y.map,-cref,-melf_i386,-Ttext,80000000,-r,-d -ffreestanding -nostdlib -o other.img abc.o def.o

# headers dependency
$(OBJS) $(KOBJS): $(HDRS)

# -f-pic
%.ko: %.o
	cp $< $@

ahci.ko: ahci.o ata_drive.o
	ld -melf_i386 -r ahci.o ata_drive.o -o ahci.ko

file.ko: file.o partition.o disk_cache.o
	ld -melf_i386 -r file.o partition.o disk_cache.o -o file.ko

# initial FAT_BEGIN=6

fat_ld.ld: ld.map
	./genfat.sh $(FAT_BEGIN) ld.map fat_ld.ld
	./genfdir.sh ld.map $@ >> fdirs.ld
	$(eval FAT_BEGIN= "fat_ld.ld")

fat_mod.ld: MODULES.MOD
	./genfat.sh $(FAT_BEGIN) MODULES.MOD fat_mod.ld
	./genfdir.sh MODULES.MOD $@ >> fdirs.ld
	$(eval FAT_BEGIN= "fat_mod.ld")

fat_%.ld: $(KOBJS)
	./genfat.sh $(FAT_BEGIN) $(subst fat_,,$(subst .ld,.ko,$@)) $@
	./genfdir.sh $(subst fat_,,$(subst .ld,.ko,$@)) $@ >> fdirs.ld
	$(eval FAT_BEGIN= "$@")

.PHONY rmf:
	echo "" > fdirs.ld

fats.ld: fat_mod.ld fat_pci.ld fat_file.ld fat_floppy.ld fat_ahci.ld fat_ld.ld
	echo "" > fats.ld
	cat $^ >> fats.ld
	rm $^

fdirs.ld: rmf fats.ld

fils.ld: MODULES.MOD pci.ko file.ko floppy.ko ahci.ko ld.map
	echo "" > fils.ld
	cat MODULES.MOD | hexdump -v -e '"BYTE(0x" 1/1 "%02X" ")\n"' >> fils.ld
	echo ". = ALIGN(0x200) ;" >> fils.ld
	cat pci.ko | hexdump -v -e '"BYTE(0x" 1/1 "%02X" ")\n"' >> fils.ld
	echo ". = ALIGN(0x200) ;" >> fils.ld
	cat file.ko | hexdump -v -e '"BYTE(0x" 1/1 "%02X" ")\n"' >> fils.ld
	echo ". = ALIGN(0x200) ;" >> fils.ld
	cat floppy.ko | hexdump -v -e '"BYTE(0x" 1/1 "%02X" ")\n"' >> fils.ld
	echo ". = ALIGN(0x200) ;" >> fils.ld
	cat ahci.ko | hexdump -v -e '"BYTE(0x" 1/1 "%02X" ")\n"' >> fils.ld
	echo ". = ALIGN(0x200) ;" >> fils.ld
	cat ld.map | hexdump -v -e '"BYTE(0x" 1/1 "%02X" ")\n"' >> fils.ld
	echo ". = ALIGN(0x200) ;" >> fils.ld

.PHONY: baseprog
baseprog: pci.ko file.ko floppy.ko $(OBJS) in.ld fils.ld fdirs.ld
	echo "" > ifats.ld
	echo "" > ifdirs.ld
	echo "" > ifils.ld
	$(LD) -T in.ld -o $@ $(OBJS)
	ls -l $@
	rm $@
	./ld2nm.awk ld_x.map > ld.map
	cp ld.map ~/Downloads/smnt/ld.map
	./gdbp.awk ld_x.map > gdb.map
	cat gdb.map | sort -k 4 > gdbs.map
	echo "" >> gdbs.map
	./gdbi.awk gdbs.map > .gdbinit
	#rm gdb.map gdbs.map

.SECONDEXPANSION:
prog.img: baseprog fils.ld fdirs.ld
	mv fats.ld ifats.ld
	mv fdirs.ld ifdirs.ld
	mv fils.ld ifils.ld
	$(LD2) -T in.ld -o $@ $(OBJS)
	rm ifats.ld ifdirs.ld ifils.ld
	truncate -s 1474560 prog.img
	ls -l prog.img
	#qemu-img convert prog.img -O vdi prog.vdi
	qemu-img convert prog.img -O qed prog.qed
	cp prog.img ~/Downloads/smnt/
	cp prog.qed ~/Downloads/smnt/
#prog.img: pci.ko file.ko floppy.ko $(OBJS) in.ld fils.ld fdirs.ld

clean:
	rm $(OBJS) $(KOBJS) prog.img prog.qed
	rm asm_lst/*

