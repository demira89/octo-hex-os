
trampo.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <.text>:
	...

Disassembly of section .trampo:

0000000000000000 <ap_trampoline>:
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
   f:	06                   	(bad)
  10:	ac                   	lods   al,BYTE PTR ds:[rsi]
  11:	00 01                	add    BYTE PTR [rcx],al
	# A20 is per processor (package)
	mov ax, 0x2401
  13:	b8 01 24 cd 15       	mov    eax,0x15cd2401
	int 0x15
	cmp ah, 0x86
  18:	80 fc 86             	cmp    ah,0x86
	jz failed
  1b:	0f 84 82 00 80 fc    	je     fffffffffc8000a3 <tmp_gdtr+0xfffffffffc7fffbb>
	cmp ah, 0x00
  21:	00 75 7d             	add    BYTE PTR [rbp+0x7d],dh
	jnz failed

	# go to PM32 using our small GDT
	lgdt cs:[tmp_gdtr-base]	
  24:	2e 0f 01 16          	cs lgdt [rsi]
  28:	e8 00 0f 20 c0       	call   ffffffffc0200f2d <tmp_gdtr+0xffffffffc0200e45>
	mov eax, cr0
	or al, 1
  2d:	0c 01                	or     al,0x1
	mov cr0, eax
  2f:	0f 22 c0             	mov    cr0,rax
	ljmp 0x08,ap_pm-base
  32:	ea                   	(bad)
  33:	37                   	(bad)
  34:	00 08                	add    BYTE PTR [rax],cl
	...

0000000000000037 <ap_pm>:

.code32
.global ap_pm
ap_pm: # Now we're in 32-bit PM enable PAE/LM if possible
	mov ax, 0x10
  37:	66 b8 10 00          	mov    ax,0x10
	mov ds, ax
  3b:	8e d8                	mov    ds,eax
	mov es, ax
  3d:	8e c0                	mov    es,eax
	mov gs, ax
  3f:	8e e8                	mov    gs,eax
	mov fs, ax
  41:	8e e0                	mov    fs,eax
	mov ss, ax
  43:	8e d0                	mov    ss,eax
	# set the stack
	mov eax, [ap_stack]
  45:	a1 00 00 00 00 89 c4 89 e5 	movabs eax,ds:0xe589c48900000000
	mov esp, eax
	mov ebp, esp
	# switch modes if neccessary
	movb al, [ap_mode]
  4e:	a0 00 00 00 00 a8 02 74 04 	movabs al,ds:0x47402a800000000
#ifdef __x86_64__
	test al, 2
	je ap_to_lm
	jmp nope32
  57:	eb 00                	jmp    59 <nope32>

0000000000000059 <nope32>:
	lidt [idtr]
	# now enter the kernel
	call ap_entry
#endif
nope32:
	jmp nope32
  59:	eb fe                	jmp    59 <nope32>

000000000000005b <ap_to_lm>:


#ifdef __x86_64__
ap_to_lm:
	mov eax, 0b10100000 # PAE & PGE
  5b:	b8 a0 00 00 00       	mov    eax,0xa0
	mov cr4, eax
  60:	0f 22 e0             	mov    cr4,rax
	mov eax, [ap_cr3] # Load cr3_val into cr3 (extend)
  63:	a1 00 00 00 00 0f 22 d8 b9 	movabs eax,ds:0xb9d8220f00000000
	mov cr3, eax

	mov ecx, 0xc0000080 # EFER MSR
  6c:	80 00 00             	add    BYTE PTR [rax],0x0
  6f:	c0 0f 32             	ror    BYTE PTR [rdi],0x32
	rdmsr

	or eax, 0x00000900 # Set LME+NX
  72:	0d 00 09 00 00       	or     eax,0x900
	wrmsr
  77:	0f 30                	wrmsr

	mov eax, cr0
  79:	0f 20 c0             	mov    rax,cr0
	or eax, 0x80010001 # PG & PM  + BIT16 (WP in ring0)
  7c:	0d 01 00 01 80       	or     eax,0x80010001
	mov cr0, eax
  81:	0f 22 c0             	mov    cr0,rax

	# paging is already working -> use ptr
	lgdt [ap_gdtp]
  84:	0f 01 15 00 00 00 00 	lgdt   [rip+0x0]        # 8b <ap_to_lm+0x30>
	jmp 0x08:LongMode
  8b:	ea                   	(bad)
  8c:	00 00                	add    BYTE PTR [rax],al
  8e:	00 00                	add    BYTE PTR [rax],al
  90:	08 00                	or     BYTE PTR [rax],al

0000000000000092 <LongMode>:

.code64
LongMode:
	lidt [idtr]
  92:	0f 01 1c 25 00 00 00 00 	lidt   ds:0x0
	call ap_entry
  9a:	e8 00 00 00 00       	call   9f <nope64>

000000000000009f <nope64>:
nope64:
	jmp nope64
  9f:	eb fe                	jmp    9f <nope64>

00000000000000a1 <failed>:
#endif

.code16
failed:
	movb [ap_fail-base], 1
  a1:	c6 06 ad             	mov    BYTE PTR [rsi],0xad
  a4:	00 01                	add    BYTE PTR [rcx],al
	movb [ap_start-base], 0
  a6:	c6 06 ac             	mov    BYTE PTR [rsi],0xac
  a9:	00 00                	add    BYTE PTR [rax],al
	hlt
  ab:	f4                   	hlt

00000000000000ac <ap_start>:
	...

00000000000000ad <ap_fail>:
	...

00000000000000ae <ap_mode>:
	...

00000000000000af <ap_gdtr>:
	...

00000000000000b1 <ap_gdtp>:
	...

00000000000000b9 <ap_stack>:
	...

00000000000000c1 <ap_cr3>:
	...
  c9:	2e                   	cs
  ca:	8d                   	.byte 0x8d
  cb:	b4 00                	mov    ah,0x0
  cd:	00                   	.byte 0
  ce:	89 f6                	mov    esi,esi

00000000000000d0 <temp_gdt>:
	...

00000000000000d8 <flatcode>:
  d8:	ff                   	(bad)
  d9:	ff 00                	inc    DWORD PTR [rax]
  db:	00 00                	add    BYTE PTR [rax],al
  dd:	9a                   	(bad)
  de:	cf                   	iret
	...

00000000000000e0 <flatdata>:
  e0:	ff                   	(bad)
  e1:	ff 00                	inc    DWORD PTR [rax]
  e3:	00 00                	add    BYTE PTR [rax],al
  e5:	92                   	xchg   edx,eax
  e6:	cf                   	iret
	...

00000000000000e8 <tmp_gdtr>:
  e8:	17                   	(bad)
  e9:	00 00                	add    BYTE PTR [rax],al
  eb:	00 00                	add    BYTE PTR [rax],al
	...
