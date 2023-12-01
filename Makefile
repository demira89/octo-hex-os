CC32=i686-elf-gcc -fno-builtin -ffreestanding -nostdlib -fno-asynchronous-unwind-tables \
	 -g -m32 -fstrict-volatile-bitfields -std=gnu99 -Wall -Wextra -mincoming-stack-boundary=4
CC64=x86_64-elf-gcc -fno-builtin -ffreestanding -nostdlib -fno-asynchronous-unwind-tables \
	 -g -m64 -fstrict-volatile-bitfields -mno-red-zone -std=gnu99 -Wall -Wextra \
	 -mcmodel=kernel -mincoming-stack-boundary=4
AS32=i686-elf-as
AS64=x86_64-elf-as
LD32=i686-elf-gcc -Wl,--oformat,elf32-i386,--Map,ld_32.map,-cref -ffreestanding -nostdlib \
	 -Wl,--build-id=none,-Ttext,80000000,--section-start,.trampo=6000,-z,muldefs -m32
LD64=x86_64-elf-gcc -Wl,--oformat,elf64-x86-64,--Map,ld_64.map,-cref -ffreestanding -nostdlib \
	 -Wl,--build-id=none,-Ttext,ffffffff80000000,--section-start,.trampo=6000,-z,muldefs -m64
OD32=i686-elf-objdump -S -d --disassembler-options=intel -w --show-raw-insn
OD64=x86_64-elf-objdump -S -d --disassembler-options=intel -w --show-raw-insn
SRCS= 
PSRCS= idt.S gdt.S trampo.S
CSRCS= framebuffer.c kernel.c apic.c smp.c tasks.c kbd.c kio.c libc.c mm/pmem.c mm/vmem.c mm/heap.c mm/scrub.c module.c
XSRCS= ata_device.c partition.c disk_cache.c # Just for info
KOSRCS= pci.c file.c floppy.c ahci.c
HDRS= limits.h kernel.h kdata.h kbd.h pci.h ahci.h pci_regs.h elf.h elf-em.h file.h mm/mm.h mm/virtmem.h boot/fixmem.h
OBJS32= ${SRCS:.s=.o32} ${PSRCS:.S=.o32} ${CSRCS:.c=.o32}
OBJS64= ${SRCS:.s=.o64} ${PSRCS:.S=.o64} ${CSRCS:.c=.o64}
KOBJS32=${KOSRCS:.c=.k32}
KOBJS64=${KOSRCS:.c=.k64}
F16FILS=kernel32.elf kernel64.elf ld32.map ld64.map MODULES.MOD $(KOBJS32) $(KOBJS64)

# clear out all suffixes
.SUFFIXES:
# # list only those we use
.SUFFIXES: .o32 .o64 .s .S .c

all: prog.img boot/Makefile

.S.o32 : 
	$(CC32) -E -m32 $< > fil.s
	$(AS32) --32 -g -o $@ fil.s
	rm fil.s
	$(OD32) $@ > asm_lst/$@.s

.S.o64 : 
	$(CC64) -E -m64 $< > fil.s
	$(AS64) --64 -g -o $@ fil.s
	rm fil.s
	$(OD64) $@ > asm_lst/$@.s

.s.o32 : 
	$(AS32) --32 -g -o $@ $<
	$(OD32) $@ > asm_lst/$@.s

.s.o64 : 
	$(AS64) --64 -g -o $@ $<
	$(OD64) $@ > asm_lst/$@.s

framebuffer.o32 : framebuffer.c
	$(CC32) -mmmx -msse -c $< -o $@
	$(OD32) $@ > asm_lst/$@.s

framebuffer.o64 : framebuffer.c
	$(CC64) -mmmx -msse -c $< -o $@
	$(OD64) $@ > asm_lst/$@.s

.c.o32 : 
	$(CC32) -c $< -o $@
	$(OD32) $@ > asm_lst/$@.s

.c.o64 : 
	$(CC64) -c $< -o $@
	$(OD64) $@ > asm_lst/$@.s

#early.o: FORCE  # for updating the builddate
#
#.PHONY: FORCE

# headers dependency
$(OBJS32) $(KOBJS32): $(HDRS)

$(OBJS64) $(KOBJS64): $(HDRS)

# -f-pic
%.k32: %.o32
	cp $< $@

%.k64: %.o64
	cp $< $@

# Modules from multiple objects
ahci.k32: ahci.o32 ata_drive.o32
	$(LD32) -r ahci.o32 ata_drive.o32 -o $@

ahci.k64: ahci.o64 ata_drive.o64
	$(LD64) -r ahci.o64 ata_drive.o64 -o $@

file.k32: file.o32 partition.o32 disk_cache.o32
	$(LD32) -r file.o32 partition.o32 disk_cache.o32 -o $@

file.k64: file.o64 partition.o64 disk_cache.o64
	$(LD64) -r file.o64 partition.o64 disk_cache.o64 -o $@

ld32.map ld64.map: kernel32.elf kernel64.elf
	./ld2nm.awk ld_32.map > ld32.map
	./ld2nm.awk ld_64.map > ld64.map

kernel64.elf: $(OBJS64)
	$(LD64) -o $@ $^

kernel32.elf: $(OBJS32)
	$(LD32) -o $@ $^

boot/boot.img:
	make -C boot/

f16_part.img: $(F16FILS)
	dd if=/dev/zero of=f16_part.img bs=1024 count=4096 # 8M partition
	mkdosfs -F 16 -r 224 -s 1 -S 512 -v f16_part.img
	#imdisk -a -t file -m W: -f f16_part.img -o hd -o rw -p "/fs:FAT /q /y"
	imdisk -a -t file -m W: -f f16_part.img -o hd -o rw
	cp kernel64.elf /w/
	cp kernel32.elf /w/kernel36.elf
	cp kernel32.elf /w/
	cp MODULES.MOD /w/
	cp -t /w/ $(KOBJS32) $(KOBJS64) ld32.map ld64.map
	imdisk -D -m W:

prog.img: boot/boot.img f16_part.img
	cp boot/boot.img boot.bin
	truncate -s 64512 boot.bin
	cat boot.bin f16_part.img > prog.img
	qemu-img convert prog.img -O qed prog.qed

clean:
	rm $(OBJS32) $(OBJS64) $(KOBJS32) $(KOBJS64) prog.img prog.qed $(F16FILS)
	rm asm_lst/*
	make -C boot/ clean

