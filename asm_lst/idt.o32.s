
idt.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <gate_0>:
#else
.global gate_0
# DIV0 <- cld instruction in all handlers
gate_0:
#	movb [0xb8000], 'a'
	pushad # 8*4 bytes
   0:	60                   	pusha
	push 0x00000000
   1:	6a 00                	push   0x0
	push [esp+9*4] # old eip
   3:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
   7:	e8 fc ff ff ff       	call   8 <gate_0+0x8>
	add esp, 8
   c:	83 c4 08             	add    esp,0x8
	popad
   f:	61                   	popa
	iret
  10:	cf                   	iret

00000011 <gate_1>:

.global gate_1
# DBG
gate_1:
#	movb [0xb8000], 'b'
	pushad
  11:	60                   	pusha
	mov eax, dr6
  12:	0f 21 f0             	mov    eax,dr6
	push eax
  15:	50                   	push   eax
	push [esp+9*4] # (old or target) eip
  16:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call debug_handler
  1a:	e8 fc ff ff ff       	call   1b <gate_1+0xa>
	add esp, 8
  1f:	83 c4 08             	add    esp,0x8
	mov dr6, eax
  22:	0f 23 f0             	mov    dr6,eax
	popad
  25:	61                   	popa
	iret
  26:	cf                   	iret

00000027 <pc_reset>:

.global pc_reset
pc_reset:
	cli
  27:	fa                   	cli
	jmp g2_reset
  28:	eb 15                	jmp    3f <g2_reset>

0000002a <gate_2>:

.global gate_2
# NMI
gate_2:
#	movb [0xb8000], 'c'
	pushad
  2a:	60                   	pusha
	xor eax, eax
  2b:	31 c0                	xor    eax,eax
	inb al, 0x92
  2d:	e4 92                	in     al,0x92
	push eax
  2f:	50                   	push   eax
	inb al, 0x61
  30:	e4 61                	in     al,0x61
	push eax
  32:	50                   	push   eax
	call nmi_handler
  33:	e8 fc ff ff ff       	call   34 <gate_2+0xa>
	add esp, 8
  38:	83 c4 08             	add    esp,0x8
	test eax, eax
  3b:	85 c0                	test   eax,eax
	jz g2_end
  3d:	74 0c                	je     4b <g2_end>

0000003f <g2_reset>:
g2_reset:
	# reset with PS/2
	mov al, 0x8d
  3f:	b0 8d                	mov    al,0x8d
	outb 0x70, al
  41:	e6 70                	out    0x70,al
	inb al, 0x71
  43:	e4 71                	in     al,0x71
	# cli is already done
	mov al, 0x01
  45:	b0 01                	mov    al,0x1
	outb 0x92, al
  47:	e6 92                	out    0x92,al

00000049 <g2_idle>:
g2_idle: # loop if the reset doesn't work
	jmp g2_idle
  49:	eb fe                	jmp    49 <g2_idle>

0000004b <g2_end>:
g2_end:
	popad
  4b:	61                   	popa
	iret
  4c:	cf                   	iret

0000004d <gate_3>:

.global gate_3
# BP
gate_3:
#	movb [0xb8000], 'd'
	pushad # 8*4 bytes
  4d:	60                   	pusha
	push 0x00000003
  4e:	6a 03                	push   0x3
	push [esp+9*4] # next eip
  50:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  54:	e8 fc ff ff ff       	call   55 <gate_3+0x8>
	add esp, 8
  59:	83 c4 08             	add    esp,0x8
	popad
  5c:	61                   	popa
	iret
  5d:	cf                   	iret

0000005e <gate_4>:

.global gate_4
# OF
gate_4:
#	movb [0xb8000], 'e'
	pushad # 8*4 bytes
  5e:	60                   	pusha
	push 0x00000004
  5f:	6a 04                	push   0x4
	push [esp+9*4] # next eip
  61:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  65:	e8 fc ff ff ff       	call   66 <gate_4+0x8>
	add esp, 8
  6a:	83 c4 08             	add    esp,0x8
	popad
  6d:	61                   	popa
	iret
  6e:	cf                   	iret

0000006f <gate_5>:

.global gate_5
# BR
gate_5:
#	movb [0xb8000], 'f'
	pushad # 8*4 bytes
  6f:	60                   	pusha
	push 0x00000005
  70:	6a 05                	push   0x5
	push [esp+9*4] # old eip
  72:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  76:	e8 fc ff ff ff       	call   77 <gate_5+0x8>
	add esp, 8
  7b:	83 c4 08             	add    esp,0x8
	popad
  7e:	61                   	popa
	iret
  7f:	cf                   	iret

00000080 <gate_6>:

.global gate_6
# UD
gate_6:
#	movb [0xb8000], 'g'
	pushad # 8*4 bytes
  80:	60                   	pusha
	push 0x00000006
  81:	6a 06                	push   0x6
	push [esp+9*4] # old eip
  83:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  87:	e8 fc ff ff ff       	call   88 <gate_6+0x8>
	add esp, 8
  8c:	83 c4 08             	add    esp,0x8
	popad
  8f:	61                   	popa
	iret
  90:	cf                   	iret

00000091 <gate_7>:

.global gate_7
# NM
gate_7:
#	movb [0xb8000], 'h'
	pushad # 8*4 bytes
  91:	60                   	pusha
	push 0x00000007
  92:	6a 07                	push   0x7
	push [esp+9*4] # old eip
  94:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  98:	e8 fc ff ff ff       	call   99 <gate_7+0x8>
	add esp, 8
  9d:	83 c4 08             	add    esp,0x8
	popad
  a0:	61                   	popa
	iret
  a1:	cf                   	iret

000000a2 <gate_8>:

.global gate_8
# DF -- ignore stack errorcode (zero as per intel manual)
gate_8:
#	movb [0xb8000], 'i'
	pushad # 8*4 bytes
  a2:	60                   	pusha
	push 0x00000008
  a3:	6a 08                	push   0x8
	push [esp+9*4] # error code
  a5:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  a9:	e8 fc ff ff ff       	call   aa <gate_8+0x8>
	add esp, 8
  ae:	83 c4 08             	add    esp,0x8
	popad
  b1:	61                   	popa
	add esp, 4
  b2:	83 c4 04             	add    esp,0x4
	iret
  b5:	cf                   	iret

000000b6 <gate_9>:

.global gate_9
# Legacy
gate_9:
#	movb [0xb8000], 'j'
	pushad # 8*4 bytes
  b6:	60                   	pusha
	push 0x00000009
  b7:	6a 09                	push   0x9
	push [esp+9*4] # old eip
  b9:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
  bd:	e8 fc ff ff ff       	call   be <gate_9+0x8>
	add esp, 8
  c2:	83 c4 08             	add    esp,0x8
	popad
  c5:	61                   	popa
	iret
  c6:	cf                   	iret

000000c7 <gate_10>:

.global gate_10
# Gates 10-14 with segment error codes on stack
gate_10:
#	movb [0xb8000], 'k'
	push 0
  c7:	6a 00                	push   0x0
	jmp gate_se
  c9:	eb 10                	jmp    db <gate_se>

000000cb <gate_11>:
.global gate_11
gate_11:
#	movb [0xb8000], 'l'
	push 1
  cb:	6a 01                	push   0x1
	jmp gate_se
  cd:	eb 0c                	jmp    db <gate_se>

000000cf <gate_12>:
.global gate_12
gate_12:
#	movb [0xb8000], 'm'
	push 2
  cf:	6a 02                	push   0x2
	jmp gate_se
  d1:	eb 08                	jmp    db <gate_se>

000000d3 <gate_13>:
.global gate_13
gate_13:
#	movb [0xb8000], 'n'
	push 3
  d3:	6a 03                	push   0x3
	jmp gate_se
  d5:	eb 04                	jmp    db <gate_se>

000000d7 <gate_14>:
.global gate_14
gate_14:
#	movb [0xb8000], 'o'
	push 4
  d7:	6a 04                	push   0x4
	jmp gate_se
  d9:	eb 00                	jmp    db <gate_se>

000000db <gate_se>:
gate_se:
	pushad # 8*4 bytes
  db:	60                   	pusha
	mov eax, [esp+8*4] # type
  dc:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
	push eax
  e0:	50                   	push   eax
	mov eax, cr2
  e1:	0f 20 d0             	mov    eax,cr2
	push eax
  e4:	50                   	push   eax
	mov eax, [esp+11*4] # segerr
  e5:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
	push eax
  e9:	50                   	push   eax
	mov eax, [esp+13*4] # eip
  ea:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
	push eax
  ee:	50                   	push   eax
	call segment_handler
  ef:	e8 fc ff ff ff       	call   f0 <gate_se+0x15>
	add esp, 16
  f4:	83 c4 10             	add    esp,0x10
	popad
  f7:	61                   	popa
	add esp, 8 # segerr&code <- correct
  f8:	83 c4 08             	add    esp,0x8
	iret
  fb:	cf                   	iret

000000fc <gate_16>:
	
.global gate_16
# MF
gate_16:
#	movb [0xb8000], 'p'
	pushad # 8*4 bytes
  fc:	60                   	pusha
	push 0x00000010
  fd:	6a 10                	push   0x10
	push [esp+9*4] # old eip
  ff:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 103:	e8 fc ff ff ff       	call   104 <gate_16+0x8>
	add esp, 8
 108:	83 c4 08             	add    esp,0x8
	popad
 10b:	61                   	popa
	iret
 10c:	cf                   	iret

0000010d <gate_17>:
	
.global gate_17
# AC -- ignore error on stack (zero as per intel manual)
gate_17:
#	movb [0xb8000], 'q'
	pushad # 8*4 bytes
 10d:	60                   	pusha
	push 0x00000011
 10e:	6a 11                	push   0x11
	push [esp+9*4] # old eip
 110:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 114:	e8 fc ff ff ff       	call   115 <gate_17+0x8>
	add esp, 8
 119:	83 c4 08             	add    esp,0x8
	popad
 11c:	61                   	popa
	add esp, 4
 11d:	83 c4 04             	add    esp,0x4
	iret
 120:	cf                   	iret

00000121 <gate_18>:
	
.global gate_18
# MC
gate_18:
#	movb [0xb8000], 'r'
	pushad # 8*4 bytes
 121:	60                   	pusha
	push 0x00000012
 122:	6a 12                	push   0x12
	push [esp+9*4] # old eip
 124:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 128:	e8 fc ff ff ff       	call   129 <gate_18+0x8>
	add esp, 8
 12d:	83 c4 08             	add    esp,0x8
	popad
 130:	61                   	popa
	iret
 131:	cf                   	iret

00000132 <gate_19>:
	
.global gate_19
# XM/XF
gate_19:
#	movb [0xb8000], 's'
	pushad # 8*4 bytes
 132:	60                   	pusha
	push 0x00000013
 133:	6a 13                	push   0x13
	push [esp+9*4] # old eip
 135:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 139:	e8 fc ff ff ff       	call   13a <gate_19+0x8>
	add esp, 8
 13e:	83 c4 08             	add    esp,0x8
	popad
 141:	61                   	popa
	iret
 142:	cf                   	iret

00000143 <gate_20>:
	
.global gate_20
# VE
gate_20:
#	movb [0xb8000], 't'
	pushad # 8*4 bytes
 143:	60                   	pusha
	push 0x00000014
 144:	6a 14                	push   0x14
	push [esp+9*4] # old eip
 146:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 14a:	e8 fc ff ff ff       	call   14b <gate_20+0x8>
	add esp, 8
 14f:	83 c4 08             	add    esp,0x8
	popad
 152:	61                   	popa
	iret
 153:	cf                   	iret

00000154 <gate_30>:
	
.global gate_30
# SX -- ignore stack value (exp unknown)
gate_30:
#	movb [0xb8000], 'u'
	pushad # 8*4 bytes
 154:	60                   	pusha
	push 0x0000001e
 155:	6a 1e                	push   0x1e
	push [esp+9*4] # old eip
 157:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 15b:	e8 fc ff ff ff       	call   15c <gate_30+0x8>
	add esp, 8
 160:	83 c4 08             	add    esp,0x8
	popad
 163:	61                   	popa
	add esp, 4
 164:	83 c4 04             	add    esp,0x4
	iret
 167:	cf                   	iret

00000168 <gate_res>:

.global gate_res
# Reserved gate
gate_res:
#	movb [0xb8000], 'v'
	pushad # 8*4 bytes
 168:	60                   	pusha
	push 0x0000000f
 169:	6a 0f                	push   0xf
	push [esp+9*4] # old eip
 16b:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
	call print_exception
 16f:	e8 fc ff ff ff       	call   170 <gate_res+0x8>
	add esp, 8
 174:	83 c4 08             	add    esp,0x8
	popad
 177:	61                   	popa
	iret
 178:	cf                   	iret

00000179 <irq_0>:

.global irq0_longjmp
.global irq_0
irq_0:
#	movb [0xb8000], 'w'
	pushad # 8*4+4*4
 179:	60                   	pusha
	push ds
 17a:	1e                   	push   ds
	push es
 17b:	06                   	push   es
	push fs
 17c:	0f a0                	push   fs
	push gs
 17e:	0f a8                	push   gs
	push esp
 180:	54                   	push   esp
	call task_save_state
 181:	e8 fc ff ff ff       	call   182 <irq_0+0x9>
	push 0
 186:	6a 00                	push   0x0
	call irq_handler
 188:	e8 fc ff ff ff       	call   189 <irq_0+0x10>
	add esp, 8 # old type+esp <- only in case no longjmp
 18d:	83 c4 08             	add    esp,0x8

00000190 <irq0_longjmp>:
irq0_longjmp:
	pop gs
 190:	0f a9                	pop    gs
	pop fs
 192:	0f a1                	pop    fs
	pop es
 194:	07                   	pop    es
	pop ds
 195:	1f                   	pop    ds
	popad
 196:	61                   	popa
	iret
 197:	cf                   	iret

00000198 <irq_1>:

.global irq_1
irq_1:
#	movb [0xb8000], 'x'
	push 1
 198:	6a 01                	push   0x1
	jmp irq_ahandler
 19a:	eb 38                	jmp    1d4 <irq_ahandler>

0000019c <irq_2>:

.global irq_2
irq_2:
#	movb [0xb8000], 'y'
	push 2
 19c:	6a 02                	push   0x2
	jmp irq_ahandler
 19e:	eb 34                	jmp    1d4 <irq_ahandler>

000001a0 <irq_3>:

.global irq_3
irq_3:
#	movb [0xb8000], 'z'
	push 3
 1a0:	6a 03                	push   0x3
	jmp irq_ahandler
 1a2:	eb 30                	jmp    1d4 <irq_ahandler>

000001a4 <irq_4>:

.global irq_4
irq_4:
#	movb [0xb8000], '0'
	push 4
 1a4:	6a 04                	push   0x4
	jmp irq_ahandler
 1a6:	eb 2c                	jmp    1d4 <irq_ahandler>

000001a8 <irq_5>:

.global irq_5
irq_5:
#	movb [0xb8000], '1'
	push 5
 1a8:	6a 05                	push   0x5
	jmp irq_ahandler
 1aa:	eb 28                	jmp    1d4 <irq_ahandler>

000001ac <irq_6>:

.global irq_6
irq_6:
#	movb [0xb8000], '2'
	push 6
 1ac:	6a 06                	push   0x6
	jmp irq_ahandler
 1ae:	eb 24                	jmp    1d4 <irq_ahandler>

000001b0 <irq_7>:

.global irq_7
irq_7:
#	movb [0xb8000], '3'
	push 7
 1b0:	6a 07                	push   0x7
	jmp irq_ahandler
 1b2:	eb 20                	jmp    1d4 <irq_ahandler>

000001b4 <irq_8>:

.global irq_8
irq_8:
#	movb [0xb8000], '4'
	push 8
 1b4:	6a 08                	push   0x8
	jmp irq_ahandler
 1b6:	eb 1c                	jmp    1d4 <irq_ahandler>

000001b8 <irq_9>:

.global irq_9
irq_9:
#	movb [0xb8000], '5'
	push 9
 1b8:	6a 09                	push   0x9
	jmp irq_ahandler
 1ba:	eb 18                	jmp    1d4 <irq_ahandler>

000001bc <irq_10>:

.global irq_10
irq_10:
#	movb [0xb8000], '6'
	push 10
 1bc:	6a 0a                	push   0xa
	jmp irq_ahandler
 1be:	eb 14                	jmp    1d4 <irq_ahandler>

000001c0 <irq_11>:

.global irq_11
irq_11:
#	movb [0xb8000], '7'
	push 11
 1c0:	6a 0b                	push   0xb
	jmp irq_ahandler
 1c2:	eb 10                	jmp    1d4 <irq_ahandler>

000001c4 <irq_12>:

.global irq_12
irq_12:
#	movb [0xb8000], '8'
	push 12
 1c4:	6a 0c                	push   0xc
	jmp irq_ahandler
 1c6:	eb 0c                	jmp    1d4 <irq_ahandler>

000001c8 <irq_13>:

.global irq_13
irq_13:
#	movb [0xb8000], '9'
	push 13
 1c8:	6a 0d                	push   0xd
	jmp irq_ahandler
 1ca:	eb 08                	jmp    1d4 <irq_ahandler>

000001cc <irq_14>:

.global irq_14
irq_14:
#	movb [0xb8000], '!'
	push 14
 1cc:	6a 0e                	push   0xe
	jmp irq_ahandler
 1ce:	eb 04                	jmp    1d4 <irq_ahandler>

000001d0 <irq_15>:

.global irq_15
irq_15:
#	movb [0xb8000], '?'
	push 15
 1d0:	6a 0f                	push   0xf
	jmp irq_ahandler
 1d2:	eb 00                	jmp    1d4 <irq_ahandler>

000001d4 <irq_ahandler>:


# handler for all IRQs
irq_ahandler:
	pushad # 8*4 bytes
 1d4:	60                   	pusha
	mov eax, [esp+8*4] # type
 1d5:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
	push eax
 1d9:	50                   	push   eax
	call irq_handler
 1da:	e8 fc ff ff ff       	call   1db <irq_ahandler+0x7>
	add esp, 4 # type
 1df:	83 c4 04             	add    esp,0x4
	popad
 1e2:	61                   	popa
	add esp, 4 # old type
 1e3:	83 c4 04             	add    esp,0x4
	iret
 1e6:	cf                   	iret

000001e7 <msi_0>:

# MSI pre-handlers
.global msi_0
msi_0:
	push 0
 1e7:	6a 00                	push   0x0
	jmp msi_ahandler
 1e9:	eb 1c                	jmp    207 <msi_ahandler>

000001eb <msi_1>:
.global msi_1
msi_1:
	push 1
 1eb:	6a 01                	push   0x1
	jmp msi_ahandler
 1ed:	eb 18                	jmp    207 <msi_ahandler>

000001ef <msi_2>:
.global msi_2
msi_2:
	push 2
 1ef:	6a 02                	push   0x2
	jmp msi_ahandler
 1f1:	eb 14                	jmp    207 <msi_ahandler>

000001f3 <msi_3>:
.global msi_3
msi_3:
	push 3
 1f3:	6a 03                	push   0x3
	jmp msi_ahandler
 1f5:	eb 10                	jmp    207 <msi_ahandler>

000001f7 <msi_4>:
.global msi_4
msi_4:
	push 4
 1f7:	6a 04                	push   0x4
	jmp msi_ahandler
 1f9:	eb 0c                	jmp    207 <msi_ahandler>

000001fb <msi_5>:
.global msi_5
msi_5:
	push 5
 1fb:	6a 05                	push   0x5
	jmp msi_ahandler
 1fd:	eb 08                	jmp    207 <msi_ahandler>

000001ff <msi_6>:
.global msi_6
msi_6:
	push 6
 1ff:	6a 06                	push   0x6
	jmp msi_ahandler
 201:	eb 04                	jmp    207 <msi_ahandler>

00000203 <msi_7>:
.global msi_7
msi_7:
	push 7
 203:	6a 07                	push   0x7
	jmp msi_ahandler
 205:	eb 00                	jmp    207 <msi_ahandler>

00000207 <msi_ahandler>:

# MSI handler
msi_ahandler:
	pushad # 8*4
 207:	60                   	pusha
	mov eax, [esp+8*4] # ype
 208:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
	push eax
 20c:	50                   	push   eax
	call msi_handler
 20d:	e8 fc ff ff ff       	call   20e <msi_ahandler+0x7>
	add esp, 4 # type
 212:	83 c4 04             	add    esp,0x4
	popad
 215:	61                   	popa
	add esp, 4 # old type
 216:	83 c4 04             	add    esp,0x4
	iret
 219:	cf                   	iret

0000021a <apic_err>:

# APIC gates
apic_err:
	push 0
 21a:	6a 00                	push   0x0
	jmp apic_cmm
 21c:	eb 06                	jmp    224 <apic_cmm>

0000021e <apic_ipi>:
#apic_tmr:
#	push 1
#	jmp apic_cmm
apic_ipi:
	push 2
 21e:	6a 02                	push   0x2
	jmp apic_cmm
 220:	eb 02                	jmp    224 <apic_cmm>

00000222 <apic_spr>:
apic_spr:
	push 3
 222:	6a 03                	push   0x3

00000224 <apic_cmm>:
apic_cmm:
	pushad
 224:	60                   	pusha
	mov eax, [esp+8*4] # type
 225:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
	push eax
 229:	50                   	push   eax
	call apic_handler
 22a:	e8 fc ff ff ff       	call   22b <apic_cmm+0x7>
	add esp, 4 # type
 22f:	83 c4 04             	add    esp,0x4
	popad
 232:	61                   	popa
	add esp, 4 # old type
 233:	83 c4 04             	add    esp,0x4
	iret
 236:	cf                   	iret

00000237 <apic_tmr>:
apic_tmr:
	pushad # 8*4+4*4
 237:	60                   	pusha
	push ds
 238:	1e                   	push   ds
	push es
 239:	06                   	push   es
	push fs
 23a:	0f a0                	push   fs
	push gs
 23c:	0f a8                	push   gs
	push esp
 23e:	54                   	push   esp
	call task_save_state
 23f:	e8 fc ff ff ff       	call   240 <apic_tmr+0x9>
	push 1
 244:	6a 01                	push   0x1
	call apic_handler
 246:	e8 fc ff ff ff       	call   247 <apic_tmr+0x10>
	add esp, 8 # old type+esp <- only in case no longjmp
 24b:	83 c4 08             	add    esp,0x8
	jmp irq0_longjmp
 24e:	e9 3d ff ff ff       	jmp    190 <irq0_longjmp>

00000253 <idt_init>:
.global idt_init
idt_init:
#	push ebp <- no need for frame
#	mov ebp, esp
	# disable NMI
	inb al, 0x70
 253:	e4 70                	in     al,0x70
	or al, 0x80
 255:	0c 80                	or     al,0x80
	outb 0x70, al
 257:	e6 70                	out    0x70,al
	lea rax, idt
	mov qword ptr[idtr+2], rax
	lea rax, idt_end-1
	sub rax, OFFSET idt
#else
	lea eax, idt
 259:	8d 05 00 00 00 00    	lea    eax,ds:0x0
	mov dword ptr[idtr+2], eax
 25f:	a3 02 00 00 00       	mov    ds:0x2,eax
	lea eax, idt_end-1
 264:	8d 05 ff ff ff ff    	lea    eax,ds:0xffffffff
	sub eax, OFFSET idt
 26a:	2d 00 00 00 00       	sub    eax,0x0
#endif
	mov word ptr[idtr], ax
 26f:	66 a3 00 00 00 00    	mov    ds:0x0,ax
	lidt [idtr]
 275:	0f 01 1d 00 00 00 00 	lidtd  ds:0x0

	# reenable NMI
	inb al, 0x70
 27c:	e4 70                	in     al,0x70
	and al, 0x7f
 27e:	24 7f                	and    al,0x7f
	outb 0x70, al
 280:	e6 70                	out    0x70,al

#	leave <- none at all
	ret
 282:	c3                   	ret

00000283 <pc_shutdown>:

.global pc_shutdown
pc_shutdown:
	cli
 283:	fa                   	cli
	hlt # TODO PM->RM or LM->RM
 284:	f4                   	hlt
