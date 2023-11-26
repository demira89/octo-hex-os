# octo-hex-os
 Simple OS providing basic memory management, scheduling and graphics output. Other features include PCI device discovery, ELF module handling, SATA disk access and SMP with CPU core initialization.

## Target architectures
- Currently the classic IBM compatible BIOS version for i386 or x86_64 is most complete
- Implementations for other systems are in development (ARM Cortex A53: aarch64 or armv7, ESP32: RISC-V)
- UEFI support is lagging but should be not too hard to implement

## Features

- Graphics detection with appropiate modesetting on BIOS systems
- multiprocessor support and scheduling
- EFI kernel modules

## Compiling
 For compilation of the respective targets, ELF GNU binutils and compilers are needed. The makefile calls the programs (as, gcc, objdump) using the standard target prefixes, e.g. x86_64-elf-gcc. Adapt the variables in the makefile accrodingly. Another area of concern is the creation of the disk image for IBM compatible systems. It uses a FAT16 images and needs the mkdosfs utility as well as a way to mount disk images. Currently compilation occurs in a MSYS2 UCRT environment, for linux hosts the image creation has to occur via mount of loopback devices.

## Usage
 To use the system use the disk image prog.img or prog.qed in your virtualization software of choice. E.g.
```
qemu-system-x86_64 -machine q35 -hda prog.qed
´´´
