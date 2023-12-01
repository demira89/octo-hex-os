
trampo.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <.text>:
	...

Disassembly of section .trampo:

00000000 <ap_trampoline>:
#.align 0x1000
# The AP trampoline code for MP init at pseudovector 8 -> 0x8000
.code16
base:
ap_trampoline: # is CS:IP=800:0000 or 0:8000?
	cli
   0:	fa                   	cli
	cld # get to PM ASAP
   1:	fc                   	cld
	xor ax, ax
   2:	31 c0                	xor    eax,eax
	mov ds, ax
   4:	8e d8                	mov    ds,eax
	mov ss, ax
   6:	8e d0                	mov    ss,eax
	mov es, ax
   8:	8e c0                	mov    es,eax
	mov sp, 0x6000 # use the page below as stack
   a:	bc 00 60 2e c6       	mov    esp,0xc62e6000
	movb cs:[ap_start-base], 1
   f:	06                   	push   es
  10:	97                   	xchg   edi,eax
  11:	00 01                	add    BYTE PTR [ecx],al
	# A20 is per processor (package)
	mov ax, 0x2401
  13:	b8 01 24 cd 15       	mov    eax,0x15cd2401
	int 0x15
	cmp ah, 0x86
  18:	80 fc 86             	cmp    ah,0x86
	jz failed
  1b:	74 6f                	je     8c <failed>
	cmp ah, 0x00
  1d:	80 fc 00             	cmp    ah,0x0
	jnz failed
  20:	75 6a                	jne    8c <failed>

	# go to PM32 using our small GDT
	lgdt cs:[tmp_gdtr-base]	
  22:	2e 0f 01 16          	lgdtd  cs:[esi]
  26:	d8 00                	fadd   DWORD PTR [eax]
	mov eax, cr0
  28:	0f 20 c0             	mov    eax,cr0
	or al, 1
  2b:	0c 01                	or     al,0x1
	mov cr0, eax
  2d:	0f 22 c0             	mov    cr0,eax
	ljmp 0x08,ap_pm-base
  30:	ea                   	.byte 0xea
  31:	35                   	.byte 0x35
  32:	00 08                	add    BYTE PTR [eax],cl
	...

00000035 <ap_pm>:

.code32
.global ap_pm
ap_pm: # Now we're in 32-bit PM enable PAE/LM if possible
	mov ax, 0x10
  35:	66 b8 10 00          	mov    ax,0x10
	mov ds, ax
  39:	8e d8                	mov    ds,eax
	mov es, ax
  3b:	8e c0                	mov    es,eax
	mov gs, ax
  3d:	8e e8                	mov    gs,eax
	mov fs, ax
  3f:	8e e0                	mov    fs,eax
	mov ss, ax
  41:	8e d0                	mov    ss,eax
	# set the stack
	mov eax, [ap_stack]
  43:	a1 00 00 00 00       	mov    eax,ds:0x0
	mov esp, eax
  48:	89 c4                	mov    esp,eax
	mov ebp, esp
  4a:	89 e5                	mov    ebp,esp
	# switch modes if neccessary
	movb al, [ap_mode]
  4c:	a0 00 00 00 00       	mov    al,ds:0x0
#ifdef __x86_64__
	test al, 2
	je ap_to_lm
	jmp nope32
#else
	test al, 1
  51:	a8 01                	test   al,0x1
	je ap_enable_pae
  53:	74 07                	je     5c <ap_enable_pae>
	mov eax, 0b10000000 # no PAE & PGE
  55:	b8 80 00 00 00       	mov    eax,0x80
	jmp ap_32
  5a:	eb 05                	jmp    61 <ap_32>

0000005c <ap_enable_pae>:
ap_enable_pae:
	mov eax, 0b10100000 # PAE & PGE
  5c:	b8 a0 00 00 00       	mov    eax,0xa0

00000061 <ap_32>:
ap_32:
	#set CR4
	mov cr4, eax
  61:	0f 22 e0             	mov    cr4,eax
	# load CR3
	mov eax, [ap_cr3]
  64:	a1 00 00 00 00       	mov    eax,ds:0x0
	mov cr3, eax
  69:	0f 22 d8             	mov    cr3,eax
	# enable paging
	mov eax, cr0
  6c:	0f 20 c0             	mov    eax,cr0
	or eax, 0x80010001 # PG & PM  + BIT16 (WP in ring0)
  6f:	0d 01 00 01 80       	or     eax,0x80010001
	mov cr0, eax
  74:	0f 22 c0             	mov    cr0,eax
	# set IDT & GDT
	lgdt [ap_gdtr]
  77:	0f 01 15 00 00 00 00 	lgdtd  ds:0x0
	lidt [idtr]
  7e:	0f 01 1d 00 00 00 00 	lidtd  ds:0x0
	# now enter the kernel
	call ap_entry
  85:	e8 fc ff ff ff       	call   86 <ap_32+0x25>

0000008a <nope32>:
#endif
nope32:
	jmp nope32
  8a:	eb fe                	jmp    8a <nope32>

0000008c <failed>:
	jmp nope64
#endif

.code16
failed:
	movb [ap_fail-base], 1
  8c:	c6 06 98             	mov    BYTE PTR [esi],0x98
  8f:	00 01                	add    BYTE PTR [ecx],al
	movb [ap_start-base], 0
  91:	c6 06 97             	mov    BYTE PTR [esi],0x97
  94:	00 00                	add    BYTE PTR [eax],al
	hlt
  96:	f4                   	hlt

00000097 <ap_start>:
	...

00000098 <ap_fail>:
	...

00000099 <ap_mode>:
	...

0000009a <ap_gdtr>:
	...

0000009c <ap_gdtp>:
	...

000000a4 <ap_stack>:
	...

000000ac <ap_cr3>:
	...
  b4:	2e 8d b4 00 00 2e 8d b4 	lea    esi,cs:[eax+eax*1-0x4b72d200]
  bc:	00 00                	add    BYTE PTR [eax],al
  be:	89 f6                	mov    esi,esi

000000c0 <temp_gdt>:
	...

000000c8 <flatcode>:
  c8:	ff                   	(bad)
  c9:	ff 00                	inc    DWORD PTR [eax]
  cb:	00 00                	add    BYTE PTR [eax],al
  cd:	9a                   	.byte 0x9a
  ce:	cf                   	iret
	...

000000d0 <flatdata>:
  d0:	ff                   	(bad)
  d1:	ff 00                	inc    DWORD PTR [eax]
  d3:	00 00                	add    BYTE PTR [eax],al
  d5:	92                   	xchg   edx,eax
  d6:	cf                   	iret
	...

000000d8 <tmp_gdtr>:
  d8:	17                   	pop    ss
  d9:	00 c0                	add    al,al
  db:	00 00                	add    BYTE PTR [eax],al
	...
