
idt.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <gate_0>:

#ifdef __x86_64__
.global gate_0
# DIV0 <- sysV ABI
gate_0:
	pushaq # 16*8 bytes
   0:	50                   	push   rax
   1:	51                   	push   rcx
   2:	52                   	push   rdx
   3:	53                   	push   rbx
   4:	54                   	push   rsp
   5:	55                   	push   rbp
   6:	56                   	push   rsi
   7:	57                   	push   rdi
   8:	41 50                	push   r8
   a:	41 51                	push   r9
   c:	41 52                	push   r10
   e:	41 53                	push   r11
  10:	41 54                	push   r12
  12:	41 55                	push   r13
  14:	41 56                	push   r14
  16:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
  18:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	xor rsi, rsi # we can't use zero extend
  20:	48 31 f6             	xor    rsi,rsi
	call print_exception # (void*, int)
  23:	e8 00 00 00 00       	call   28 <gate_0+0x28>
	popaq
  28:	41 5f                	pop    r15
  2a:	41 5e                	pop    r14
  2c:	41 5d                	pop    r13
  2e:	41 5c                	pop    r12
  30:	41 5b                	pop    r11
  32:	41 5a                	pop    r10
  34:	41 59                	pop    r9
  36:	41 58                	pop    r8
  38:	5f                   	pop    rdi
  39:	5e                   	pop    rsi
  3a:	5d                   	pop    rbp
  3b:	5c                   	pop    rsp
  3c:	5b                   	pop    rbx
  3d:	5a                   	pop    rdx
  3e:	59                   	pop    rcx
  3f:	58                   	pop    rax
	iretq
  40:	48 cf                	iretq

0000000000000042 <gate_1>:

.global gate_1
# DBG
gate_1:
	pushaq
  42:	50                   	push   rax
  43:	51                   	push   rcx
  44:	52                   	push   rdx
  45:	53                   	push   rbx
  46:	54                   	push   rsp
  47:	55                   	push   rbp
  48:	56                   	push   rsi
  49:	57                   	push   rdi
  4a:	41 50                	push   r8
  4c:	41 51                	push   r9
  4e:	41 52                	push   r10
  50:	41 53                	push   r11
  52:	41 54                	push   r12
  54:	41 55                	push   r13
  56:	41 56                	push   r14
  58:	41 57                	push   r15
	mov rdi, [rsp+17*8] # (old/target) rip
  5a:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov rsi, dr6
  62:	0f 21 f6             	mov    rsi,dr6
	call debug_handler # (void*, uint)
  65:	e8 00 00 00 00       	call   6a <gate_1+0x28>
	mov dr6, rax
  6a:	0f 23 f0             	mov    dr6,rax
	popaq
  6d:	41 5f                	pop    r15
  6f:	41 5e                	pop    r14
  71:	41 5d                	pop    r13
  73:	41 5c                	pop    r12
  75:	41 5b                	pop    r11
  77:	41 5a                	pop    r10
  79:	41 59                	pop    r9
  7b:	41 58                	pop    r8
  7d:	5f                   	pop    rdi
  7e:	5e                   	pop    rsi
  7f:	5d                   	pop    rbp
  80:	5c                   	pop    rsp
  81:	5b                   	pop    rbx
  82:	5a                   	pop    rdx
  83:	59                   	pop    rcx
  84:	58                   	pop    rax
	iretq
  85:	48 cf                	iretq

0000000000000087 <pc_reset>:

.global pc_reset
pc_reset:
	cli
  87:	fa                   	cli
	jmp g2_reset
  88:	eb 2d                	jmp    b7 <g2_reset>

000000000000008a <gate_2>:

.global gate_2
# NMI
gate_2:
	pushaq
  8a:	50                   	push   rax
  8b:	51                   	push   rcx
  8c:	52                   	push   rdx
  8d:	53                   	push   rbx
  8e:	54                   	push   rsp
  8f:	55                   	push   rbp
  90:	56                   	push   rsi
  91:	57                   	push   rdi
  92:	41 50                	push   r8
  94:	41 51                	push   r9
  96:	41 52                	push   r10
  98:	41 53                	push   r11
  9a:	41 54                	push   r12
  9c:	41 55                	push   r13
  9e:	41 56                	push   r14
  a0:	41 57                	push   r15
	xor eax, eax # zero extend
  a2:	31 c0                	xor    eax,eax
	inb al, 0x61
  a4:	e4 61                	in     al,0x61
	mov rdi, rax
  a6:	48 89 c7             	mov    rdi,rax
	inb al, 0x92
  a9:	e4 92                	in     al,0x92
	mov rsi, rax
  ab:	48 89 c6             	mov    rsi,rax
	call nmi_handler #(uchar, uchar)
  ae:	e8 00 00 00 00       	call   b3 <gate_2+0x29>
	test eax, eax # rv is int
  b3:	85 c0                	test   eax,eax
	jz g2_end
  b5:	74 0c                	je     c3 <g2_end>

00000000000000b7 <g2_reset>:
g2_reset:
	# reset with PS/2
	mov al, 0x8d
  b7:	b0 8d                	mov    al,0x8d
	outb 0x70, al
  b9:	e6 70                	out    0x70,al
	inb al, 0x71
  bb:	e4 71                	in     al,0x71
	# cli is already done
	mov al, 0x01
  bd:	b0 01                	mov    al,0x1
	outb 0x92, al
  bf:	e6 92                	out    0x92,al

00000000000000c1 <g2_idle>:
g2_idle: # loop if the reset doesn't work
	jmp g2_idle
  c1:	eb fe                	jmp    c1 <g2_idle>

00000000000000c3 <g2_end>:
g2_end:
	popaq
  c3:	41 5f                	pop    r15
  c5:	41 5e                	pop    r14
  c7:	41 5d                	pop    r13
  c9:	41 5c                	pop    r12
  cb:	41 5b                	pop    r11
  cd:	41 5a                	pop    r10
  cf:	41 59                	pop    r9
  d1:	41 58                	pop    r8
  d3:	5f                   	pop    rdi
  d4:	5e                   	pop    rsi
  d5:	5d                   	pop    rbp
  d6:	5c                   	pop    rsp
  d7:	5b                   	pop    rbx
  d8:	5a                   	pop    rdx
  d9:	59                   	pop    rcx
  da:	58                   	pop    rax
	iretq
  db:	48 cf                	iretq

00000000000000dd <gate_3>:

.global gate_3
# BP
gate_3:
	pushaq
  dd:	50                   	push   rax
  de:	51                   	push   rcx
  df:	52                   	push   rdx
  e0:	53                   	push   rbx
  e1:	54                   	push   rsp
  e2:	55                   	push   rbp
  e3:	56                   	push   rsi
  e4:	57                   	push   rdi
  e5:	41 50                	push   r8
  e7:	41 51                	push   r9
  e9:	41 52                	push   r10
  eb:	41 53                	push   r11
  ed:	41 54                	push   r12
  ef:	41 55                	push   r13
  f1:	41 56                	push   r14
  f3:	41 57                	push   r15
	mov rdi, [rsp+17*8] # next rip
  f5:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 3
  fd:	be 03 00 00 00       	mov    esi,0x3
	call print_exception # (void*, int)
 102:	e8 00 00 00 00       	call   107 <gate_3+0x2a>
	popaq
 107:	41 5f                	pop    r15
 109:	41 5e                	pop    r14
 10b:	41 5d                	pop    r13
 10d:	41 5c                	pop    r12
 10f:	41 5b                	pop    r11
 111:	41 5a                	pop    r10
 113:	41 59                	pop    r9
 115:	41 58                	pop    r8
 117:	5f                   	pop    rdi
 118:	5e                   	pop    rsi
 119:	5d                   	pop    rbp
 11a:	5c                   	pop    rsp
 11b:	5b                   	pop    rbx
 11c:	5a                   	pop    rdx
 11d:	59                   	pop    rcx
 11e:	58                   	pop    rax
	iretq
 11f:	48 cf                	iretq

0000000000000121 <gate_4>:

.global gate_4
# OF
gate_4:
	pushaq
 121:	50                   	push   rax
 122:	51                   	push   rcx
 123:	52                   	push   rdx
 124:	53                   	push   rbx
 125:	54                   	push   rsp
 126:	55                   	push   rbp
 127:	56                   	push   rsi
 128:	57                   	push   rdi
 129:	41 50                	push   r8
 12b:	41 51                	push   r9
 12d:	41 52                	push   r10
 12f:	41 53                	push   r11
 131:	41 54                	push   r12
 133:	41 55                	push   r13
 135:	41 56                	push   r14
 137:	41 57                	push   r15
	mov rdi, [rsp+17*8] # next rip
 139:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 4
 141:	be 04 00 00 00       	mov    esi,0x4
	call print_exception # (void*, int)
 146:	e8 00 00 00 00       	call   14b <gate_4+0x2a>
	popaq
 14b:	41 5f                	pop    r15
 14d:	41 5e                	pop    r14
 14f:	41 5d                	pop    r13
 151:	41 5c                	pop    r12
 153:	41 5b                	pop    r11
 155:	41 5a                	pop    r10
 157:	41 59                	pop    r9
 159:	41 58                	pop    r8
 15b:	5f                   	pop    rdi
 15c:	5e                   	pop    rsi
 15d:	5d                   	pop    rbp
 15e:	5c                   	pop    rsp
 15f:	5b                   	pop    rbx
 160:	5a                   	pop    rdx
 161:	59                   	pop    rcx
 162:	58                   	pop    rax
	iretq
 163:	48 cf                	iretq

0000000000000165 <gate_5>:

.global gate_5
# BR
gate_5:
	pushaq
 165:	50                   	push   rax
 166:	51                   	push   rcx
 167:	52                   	push   rdx
 168:	53                   	push   rbx
 169:	54                   	push   rsp
 16a:	55                   	push   rbp
 16b:	56                   	push   rsi
 16c:	57                   	push   rdi
 16d:	41 50                	push   r8
 16f:	41 51                	push   r9
 171:	41 52                	push   r10
 173:	41 53                	push   r11
 175:	41 54                	push   r12
 177:	41 55                	push   r13
 179:	41 56                	push   r14
 17b:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 17d:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 5
 185:	be 05 00 00 00       	mov    esi,0x5
	call print_exception
 18a:	e8 00 00 00 00       	call   18f <gate_5+0x2a>
	popaq
 18f:	41 5f                	pop    r15
 191:	41 5e                	pop    r14
 193:	41 5d                	pop    r13
 195:	41 5c                	pop    r12
 197:	41 5b                	pop    r11
 199:	41 5a                	pop    r10
 19b:	41 59                	pop    r9
 19d:	41 58                	pop    r8
 19f:	5f                   	pop    rdi
 1a0:	5e                   	pop    rsi
 1a1:	5d                   	pop    rbp
 1a2:	5c                   	pop    rsp
 1a3:	5b                   	pop    rbx
 1a4:	5a                   	pop    rdx
 1a5:	59                   	pop    rcx
 1a6:	58                   	pop    rax
	iretq
 1a7:	48 cf                	iretq

00000000000001a9 <gate_6>:

.global gate_6
# UD
gate_6:
	pushaq
 1a9:	50                   	push   rax
 1aa:	51                   	push   rcx
 1ab:	52                   	push   rdx
 1ac:	53                   	push   rbx
 1ad:	54                   	push   rsp
 1ae:	55                   	push   rbp
 1af:	56                   	push   rsi
 1b0:	57                   	push   rdi
 1b1:	41 50                	push   r8
 1b3:	41 51                	push   r9
 1b5:	41 52                	push   r10
 1b7:	41 53                	push   r11
 1b9:	41 54                	push   r12
 1bb:	41 55                	push   r13
 1bd:	41 56                	push   r14
 1bf:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 1c1:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 6
 1c9:	be 06 00 00 00       	mov    esi,0x6
	call print_exception
 1ce:	e8 00 00 00 00       	call   1d3 <gate_6+0x2a>
	popaq
 1d3:	41 5f                	pop    r15
 1d5:	41 5e                	pop    r14
 1d7:	41 5d                	pop    r13
 1d9:	41 5c                	pop    r12
 1db:	41 5b                	pop    r11
 1dd:	41 5a                	pop    r10
 1df:	41 59                	pop    r9
 1e1:	41 58                	pop    r8
 1e3:	5f                   	pop    rdi
 1e4:	5e                   	pop    rsi
 1e5:	5d                   	pop    rbp
 1e6:	5c                   	pop    rsp
 1e7:	5b                   	pop    rbx
 1e8:	5a                   	pop    rdx
 1e9:	59                   	pop    rcx
 1ea:	58                   	pop    rax
	iretq
 1eb:	48 cf                	iretq

00000000000001ed <gate_7>:

.global gate_7
# NM
gate_7:
	pushaq
 1ed:	50                   	push   rax
 1ee:	51                   	push   rcx
 1ef:	52                   	push   rdx
 1f0:	53                   	push   rbx
 1f1:	54                   	push   rsp
 1f2:	55                   	push   rbp
 1f3:	56                   	push   rsi
 1f4:	57                   	push   rdi
 1f5:	41 50                	push   r8
 1f7:	41 51                	push   r9
 1f9:	41 52                	push   r10
 1fb:	41 53                	push   r11
 1fd:	41 54                	push   r12
 1ff:	41 55                	push   r13
 201:	41 56                	push   r14
 203:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 205:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 7
 20d:	be 07 00 00 00       	mov    esi,0x7
	call print_exception
 212:	e8 00 00 00 00       	call   217 <gate_7+0x2a>
	popaq
 217:	41 5f                	pop    r15
 219:	41 5e                	pop    r14
 21b:	41 5d                	pop    r13
 21d:	41 5c                	pop    r12
 21f:	41 5b                	pop    r11
 221:	41 5a                	pop    r10
 223:	41 59                	pop    r9
 225:	41 58                	pop    r8
 227:	5f                   	pop    rdi
 228:	5e                   	pop    rsi
 229:	5d                   	pop    rbp
 22a:	5c                   	pop    rsp
 22b:	5b                   	pop    rbx
 22c:	5a                   	pop    rdx
 22d:	59                   	pop    rcx
 22e:	58                   	pop    rax
	iret
 22f:	cf                   	iret

0000000000000230 <gate_8>:

.global gate_8
# DF -- ignore stack errorcode (zero as per intel manual)
gate_8:
	pushaq
 230:	50                   	push   rax
 231:	51                   	push   rcx
 232:	52                   	push   rdx
 233:	53                   	push   rbx
 234:	54                   	push   rsp
 235:	55                   	push   rbp
 236:	56                   	push   rsi
 237:	57                   	push   rdi
 238:	41 50                	push   r8
 23a:	41 51                	push   r9
 23c:	41 52                	push   r10
 23e:	41 53                	push   r11
 240:	41 54                	push   r12
 242:	41 55                	push   r13
 244:	41 56                	push   r14
 246:	41 57                	push   r15
	mov rdi, [rsp+18*8] # old rip <- ! below error code
 248:	48 8b bc 24 90 00 00 00 	mov    rdi,QWORD PTR [rsp+0x90]
	mov esi, 8
 250:	be 08 00 00 00       	mov    esi,0x8
	call print_exception
 255:	e8 00 00 00 00       	call   25a <gate_8+0x2a>
	popaq
 25a:	41 5f                	pop    r15
 25c:	41 5e                	pop    r14
 25e:	41 5d                	pop    r13
 260:	41 5c                	pop    r12
 262:	41 5b                	pop    r11
 264:	41 5a                	pop    r10
 266:	41 59                	pop    r9
 268:	41 58                	pop    r8
 26a:	5f                   	pop    rdi
 26b:	5e                   	pop    rsi
 26c:	5d                   	pop    rbp
 26d:	5c                   	pop    rsp
 26e:	5b                   	pop    rbx
 26f:	5a                   	pop    rdx
 270:	59                   	pop    rcx
 271:	58                   	pop    rax
	add rsp, 8
 272:	48 83 c4 08          	add    rsp,0x8
	iretq
 276:	48 cf                	iretq

0000000000000278 <gate_9>:

.global gate_9
# Legacy
gate_9:
	pushaq
 278:	50                   	push   rax
 279:	51                   	push   rcx
 27a:	52                   	push   rdx
 27b:	53                   	push   rbx
 27c:	54                   	push   rsp
 27d:	55                   	push   rbp
 27e:	56                   	push   rsi
 27f:	57                   	push   rdi
 280:	41 50                	push   r8
 282:	41 51                	push   r9
 284:	41 52                	push   r10
 286:	41 53                	push   r11
 288:	41 54                	push   r12
 28a:	41 55                	push   r13
 28c:	41 56                	push   r14
 28e:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 290:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 9
 298:	be 09 00 00 00       	mov    esi,0x9
	call print_exception
 29d:	e8 00 00 00 00       	call   2a2 <gate_9+0x2a>
	popaq
 2a2:	41 5f                	pop    r15
 2a4:	41 5e                	pop    r14
 2a6:	41 5d                	pop    r13
 2a8:	41 5c                	pop    r12
 2aa:	41 5b                	pop    r11
 2ac:	41 5a                	pop    r10
 2ae:	41 59                	pop    r9
 2b0:	41 58                	pop    r8
 2b2:	5f                   	pop    rdi
 2b3:	5e                   	pop    rsi
 2b4:	5d                   	pop    rbp
 2b5:	5c                   	pop    rsp
 2b6:	5b                   	pop    rbx
 2b7:	5a                   	pop    rdx
 2b8:	59                   	pop    rcx
 2b9:	58                   	pop    rax
	iretq
 2ba:	48 cf                	iretq

00000000000002bc <gate_10>:

.global gate_10
# Gates 10-14 with segment error codes on stack
gate_10:
	push 0
 2bc:	6a 00                	push   0x0
	jmp gate_se
 2be:	eb 10                	jmp    2d0 <gate_se>

00000000000002c0 <gate_11>:
.global gate_11
gate_11:
	push 1
 2c0:	6a 01                	push   0x1
	jmp gate_se
 2c2:	eb 0c                	jmp    2d0 <gate_se>

00000000000002c4 <gate_12>:
.global gate_12
gate_12:
	push 2
 2c4:	6a 02                	push   0x2
	jmp gate_se
 2c6:	eb 08                	jmp    2d0 <gate_se>

00000000000002c8 <gate_13>:
.global gate_13
gate_13:
	push 3
 2c8:	6a 03                	push   0x3
	jmp gate_se
 2ca:	eb 04                	jmp    2d0 <gate_se>

00000000000002cc <gate_14>:
.global gate_14
gate_14:
	push 4
 2cc:	6a 04                	push   0x4
	jmp gate_se
 2ce:	eb 00                	jmp    2d0 <gate_se>

00000000000002d0 <gate_se>:
gate_se:
	pushaq # 16*8 bytes
 2d0:	50                   	push   rax
 2d1:	51                   	push   rcx
 2d2:	52                   	push   rdx
 2d3:	53                   	push   rbx
 2d4:	54                   	push   rsp
 2d5:	55                   	push   rbp
 2d6:	56                   	push   rsi
 2d7:	57                   	push   rdi
 2d8:	41 50                	push   r8
 2da:	41 51                	push   r9
 2dc:	41 52                	push   r10
 2de:	41 53                	push   r11
 2e0:	41 54                	push   r12
 2e2:	41 55                	push   r13
 2e4:	41 56                	push   r14
 2e6:	41 57                	push   r15
	mov rcx, [rsp+16*8] # type code pushed before
 2e8:	48 8b 8c 24 80 00 00 00 	mov    rcx,QWORD PTR [rsp+0x80]
	mov rdx, cr2
 2f0:	0f 20 d2             	mov    rdx,cr2
	mov rsi, [rsp+17*8] # segment error code
 2f3:	48 8b b4 24 88 00 00 00 	mov    rsi,QWORD PTR [rsp+0x88]
	mov rdi, [rsp+18*8] # rip
 2fb:	48 8b bc 24 90 00 00 00 	mov    rdi,QWORD PTR [rsp+0x90]
	call segment_handler # (void* rip, uint ec, void* cr2, uint tp)
 303:	e8 00 00 00 00       	call   308 <gate_se+0x38>
	popaq
 308:	41 5f                	pop    r15
 30a:	41 5e                	pop    r14
 30c:	41 5d                	pop    r13
 30e:	41 5c                	pop    r12
 310:	41 5b                	pop    r11
 312:	41 5a                	pop    r10
 314:	41 59                	pop    r9
 316:	41 58                	pop    r8
 318:	5f                   	pop    rdi
 319:	5e                   	pop    rsi
 31a:	5d                   	pop    rbp
 31b:	5c                   	pop    rsp
 31c:	5b                   	pop    rbx
 31d:	5a                   	pop    rdx
 31e:	59                   	pop    rcx
 31f:	58                   	pop    rax
	add rsp, 16 # segerr&code
 320:	48 83 c4 10          	add    rsp,0x10
	iretq
 324:	48 cf                	iretq

0000000000000326 <gate_16>:
	
.global gate_16
# MF
gate_16:
	pushaq
 326:	50                   	push   rax
 327:	51                   	push   rcx
 328:	52                   	push   rdx
 329:	53                   	push   rbx
 32a:	54                   	push   rsp
 32b:	55                   	push   rbp
 32c:	56                   	push   rsi
 32d:	57                   	push   rdi
 32e:	41 50                	push   r8
 330:	41 51                	push   r9
 332:	41 52                	push   r10
 334:	41 53                	push   r11
 336:	41 54                	push   r12
 338:	41 55                	push   r13
 33a:	41 56                	push   r14
 33c:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 33e:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 0x10
 346:	be 10 00 00 00       	mov    esi,0x10
	call print_exception
 34b:	e8 00 00 00 00       	call   350 <gate_16+0x2a>
	popaq
 350:	41 5f                	pop    r15
 352:	41 5e                	pop    r14
 354:	41 5d                	pop    r13
 356:	41 5c                	pop    r12
 358:	41 5b                	pop    r11
 35a:	41 5a                	pop    r10
 35c:	41 59                	pop    r9
 35e:	41 58                	pop    r8
 360:	5f                   	pop    rdi
 361:	5e                   	pop    rsi
 362:	5d                   	pop    rbp
 363:	5c                   	pop    rsp
 364:	5b                   	pop    rbx
 365:	5a                   	pop    rdx
 366:	59                   	pop    rcx
 367:	58                   	pop    rax
	iretq
 368:	48 cf                	iretq

000000000000036a <gate_17>:
	
.global gate_17
# AC -- ignore error on stack (zero as per intel manual)
gate_17:
	pushaq
 36a:	50                   	push   rax
 36b:	51                   	push   rcx
 36c:	52                   	push   rdx
 36d:	53                   	push   rbx
 36e:	54                   	push   rsp
 36f:	55                   	push   rbp
 370:	56                   	push   rsi
 371:	57                   	push   rdi
 372:	41 50                	push   r8
 374:	41 51                	push   r9
 376:	41 52                	push   r10
 378:	41 53                	push   r11
 37a:	41 54                	push   r12
 37c:	41 55                	push   r13
 37e:	41 56                	push   r14
 380:	41 57                	push   r15
	mov rdi, [rsp+18*8] # old rip (+1)
 382:	48 8b bc 24 90 00 00 00 	mov    rdi,QWORD PTR [rsp+0x90]
	mov esi, 0x11
 38a:	be 11 00 00 00       	mov    esi,0x11
	call print_exception
 38f:	e8 00 00 00 00       	call   394 <gate_17+0x2a>
	popaq
 394:	41 5f                	pop    r15
 396:	41 5e                	pop    r14
 398:	41 5d                	pop    r13
 39a:	41 5c                	pop    r12
 39c:	41 5b                	pop    r11
 39e:	41 5a                	pop    r10
 3a0:	41 59                	pop    r9
 3a2:	41 58                	pop    r8
 3a4:	5f                   	pop    rdi
 3a5:	5e                   	pop    rsi
 3a6:	5d                   	pop    rbp
 3a7:	5c                   	pop    rsp
 3a8:	5b                   	pop    rbx
 3a9:	5a                   	pop    rdx
 3aa:	59                   	pop    rcx
 3ab:	58                   	pop    rax
	add rsp, 8
 3ac:	48 83 c4 08          	add    rsp,0x8
	iretq
 3b0:	48 cf                	iretq

00000000000003b2 <gate_18>:
	
.global gate_18
# MC
gate_18:
	pushaq
 3b2:	50                   	push   rax
 3b3:	51                   	push   rcx
 3b4:	52                   	push   rdx
 3b5:	53                   	push   rbx
 3b6:	54                   	push   rsp
 3b7:	55                   	push   rbp
 3b8:	56                   	push   rsi
 3b9:	57                   	push   rdi
 3ba:	41 50                	push   r8
 3bc:	41 51                	push   r9
 3be:	41 52                	push   r10
 3c0:	41 53                	push   r11
 3c2:	41 54                	push   r12
 3c4:	41 55                	push   r13
 3c6:	41 56                	push   r14
 3c8:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 3ca:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 0x12
 3d2:	be 12 00 00 00       	mov    esi,0x12
	call print_exception
 3d7:	e8 00 00 00 00       	call   3dc <gate_18+0x2a>
	popaq
 3dc:	41 5f                	pop    r15
 3de:	41 5e                	pop    r14
 3e0:	41 5d                	pop    r13
 3e2:	41 5c                	pop    r12
 3e4:	41 5b                	pop    r11
 3e6:	41 5a                	pop    r10
 3e8:	41 59                	pop    r9
 3ea:	41 58                	pop    r8
 3ec:	5f                   	pop    rdi
 3ed:	5e                   	pop    rsi
 3ee:	5d                   	pop    rbp
 3ef:	5c                   	pop    rsp
 3f0:	5b                   	pop    rbx
 3f1:	5a                   	pop    rdx
 3f2:	59                   	pop    rcx
 3f3:	58                   	pop    rax
	iretq
 3f4:	48 cf                	iretq

00000000000003f6 <gate_19>:
	
.global gate_19
# XM/XF
gate_19:
	pushaq
 3f6:	50                   	push   rax
 3f7:	51                   	push   rcx
 3f8:	52                   	push   rdx
 3f9:	53                   	push   rbx
 3fa:	54                   	push   rsp
 3fb:	55                   	push   rbp
 3fc:	56                   	push   rsi
 3fd:	57                   	push   rdi
 3fe:	41 50                	push   r8
 400:	41 51                	push   r9
 402:	41 52                	push   r10
 404:	41 53                	push   r11
 406:	41 54                	push   r12
 408:	41 55                	push   r13
 40a:	41 56                	push   r14
 40c:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 40e:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 0x13
 416:	be 13 00 00 00       	mov    esi,0x13
	call print_exception
 41b:	e8 00 00 00 00       	call   420 <gate_19+0x2a>
	popaq
 420:	41 5f                	pop    r15
 422:	41 5e                	pop    r14
 424:	41 5d                	pop    r13
 426:	41 5c                	pop    r12
 428:	41 5b                	pop    r11
 42a:	41 5a                	pop    r10
 42c:	41 59                	pop    r9
 42e:	41 58                	pop    r8
 430:	5f                   	pop    rdi
 431:	5e                   	pop    rsi
 432:	5d                   	pop    rbp
 433:	5c                   	pop    rsp
 434:	5b                   	pop    rbx
 435:	5a                   	pop    rdx
 436:	59                   	pop    rcx
 437:	58                   	pop    rax
	iretq
 438:	48 cf                	iretq

000000000000043a <gate_20>:
	
.global gate_20
# VE
gate_20:
	pushaq
 43a:	50                   	push   rax
 43b:	51                   	push   rcx
 43c:	52                   	push   rdx
 43d:	53                   	push   rbx
 43e:	54                   	push   rsp
 43f:	55                   	push   rbp
 440:	56                   	push   rsi
 441:	57                   	push   rdi
 442:	41 50                	push   r8
 444:	41 51                	push   r9
 446:	41 52                	push   r10
 448:	41 53                	push   r11
 44a:	41 54                	push   r12
 44c:	41 55                	push   r13
 44e:	41 56                	push   r14
 450:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 452:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 0x14
 45a:	be 14 00 00 00       	mov    esi,0x14
	call print_exception
 45f:	e8 00 00 00 00       	call   464 <gate_20+0x2a>
	popaq
 464:	41 5f                	pop    r15
 466:	41 5e                	pop    r14
 468:	41 5d                	pop    r13
 46a:	41 5c                	pop    r12
 46c:	41 5b                	pop    r11
 46e:	41 5a                	pop    r10
 470:	41 59                	pop    r9
 472:	41 58                	pop    r8
 474:	5f                   	pop    rdi
 475:	5e                   	pop    rsi
 476:	5d                   	pop    rbp
 477:	5c                   	pop    rsp
 478:	5b                   	pop    rbx
 479:	5a                   	pop    rdx
 47a:	59                   	pop    rcx
 47b:	58                   	pop    rax
	iretq
 47c:	48 cf                	iretq

000000000000047e <gate_30>:
	
.global gate_30
# SX -- ignore stack value (exp unknown)
gate_30:
	pushaq
 47e:	50                   	push   rax
 47f:	51                   	push   rcx
 480:	52                   	push   rdx
 481:	53                   	push   rbx
 482:	54                   	push   rsp
 483:	55                   	push   rbp
 484:	56                   	push   rsi
 485:	57                   	push   rdi
 486:	41 50                	push   r8
 488:	41 51                	push   r9
 48a:	41 52                	push   r10
 48c:	41 53                	push   r11
 48e:	41 54                	push   r12
 490:	41 55                	push   r13
 492:	41 56                	push   r14
 494:	41 57                	push   r15
	mov rdi, [rsp+18*8] # old rip (+1)
 496:	48 8b bc 24 90 00 00 00 	mov    rdi,QWORD PTR [rsp+0x90]
	mov esi, 0x1e
 49e:	be 1e 00 00 00       	mov    esi,0x1e
	call print_exception
 4a3:	e8 00 00 00 00       	call   4a8 <gate_30+0x2a>
	popaq
 4a8:	41 5f                	pop    r15
 4aa:	41 5e                	pop    r14
 4ac:	41 5d                	pop    r13
 4ae:	41 5c                	pop    r12
 4b0:	41 5b                	pop    r11
 4b2:	41 5a                	pop    r10
 4b4:	41 59                	pop    r9
 4b6:	41 58                	pop    r8
 4b8:	5f                   	pop    rdi
 4b9:	5e                   	pop    rsi
 4ba:	5d                   	pop    rbp
 4bb:	5c                   	pop    rsp
 4bc:	5b                   	pop    rbx
 4bd:	5a                   	pop    rdx
 4be:	59                   	pop    rcx
 4bf:	58                   	pop    rax
	add rsp, 8
 4c0:	48 83 c4 08          	add    rsp,0x8
	iretq
 4c4:	48 cf                	iretq

00000000000004c6 <gate_res>:

.global gate_res
# Reserved gate
gate_res:
	pushaq
 4c6:	50                   	push   rax
 4c7:	51                   	push   rcx
 4c8:	52                   	push   rdx
 4c9:	53                   	push   rbx
 4ca:	54                   	push   rsp
 4cb:	55                   	push   rbp
 4cc:	56                   	push   rsi
 4cd:	57                   	push   rdi
 4ce:	41 50                	push   r8
 4d0:	41 51                	push   r9
 4d2:	41 52                	push   r10
 4d4:	41 53                	push   r11
 4d6:	41 54                	push   r12
 4d8:	41 55                	push   r13
 4da:	41 56                	push   r14
 4dc:	41 57                	push   r15
	mov rdi, [rsp+17*8] # old rip
 4de:	48 8b bc 24 88 00 00 00 	mov    rdi,QWORD PTR [rsp+0x88]
	mov esi, 0xf
 4e6:	be 0f 00 00 00       	mov    esi,0xf
	call print_exception
 4eb:	e8 00 00 00 00       	call   4f0 <gate_res+0x2a>
	popaq
 4f0:	41 5f                	pop    r15
 4f2:	41 5e                	pop    r14
 4f4:	41 5d                	pop    r13
 4f6:	41 5c                	pop    r12
 4f8:	41 5b                	pop    r11
 4fa:	41 5a                	pop    r10
 4fc:	41 59                	pop    r9
 4fe:	41 58                	pop    r8
 500:	5f                   	pop    rdi
 501:	5e                   	pop    rsi
 502:	5d                   	pop    rbp
 503:	5c                   	pop    rsp
 504:	5b                   	pop    rbx
 505:	5a                   	pop    rdx
 506:	59                   	pop    rcx
 507:	58                   	pop    rax
	iretq
 508:	48 cf                	iretq

000000000000050a <irq_0>:

.global irq0_longjmp
.global irq_0
irq_0:
	pushaq # 16*8+4*8
 50a:	50                   	push   rax
 50b:	51                   	push   rcx
 50c:	52                   	push   rdx
 50d:	53                   	push   rbx
 50e:	54                   	push   rsp
 50f:	55                   	push   rbp
 510:	56                   	push   rsi
 511:	57                   	push   rdi
 512:	41 50                	push   r8
 514:	41 51                	push   r9
 516:	41 52                	push   r10
 518:	41 53                	push   r11
 51a:	41 54                	push   r12
 51c:	41 55                	push   r13
 51e:	41 56                	push   r14
 520:	41 57                	push   r15
	pushseg
 522:	8c d8                	mov    eax,ds
 524:	50                   	push   rax
 525:	8c c0                	mov    eax,es
 527:	50                   	push   rax
 528:	8c e0                	mov    eax,fs
 52a:	50                   	push   rax
 52b:	8c e8                	mov    eax,gs
 52d:	50                   	push   rax
	mov rdi, rsp
 52e:	48 89 e7             	mov    rdi,rsp
	call task_save_state # (void* esp)
 531:	e8 00 00 00 00       	call   536 <irq_0+0x2c>
	xor edi, edi # zero extend
 536:	31 ff                	xor    edi,edi
	call irq_handler # (uint)
 538:	e8 00 00 00 00       	call   53d <irq0_longjmp>

000000000000053d <irq0_longjmp>:
irq0_longjmp:
	popseg
 53d:	58                   	pop    rax
 53e:	8e e8                	mov    gs,eax
 540:	58                   	pop    rax
 541:	8e e0                	mov    fs,eax
 543:	58                   	pop    rax
 544:	8e c0                	mov    es,eax
 546:	58                   	pop    rax
 547:	8e d8                	mov    ds,eax
	popaq
 549:	41 5f                	pop    r15
 54b:	41 5e                	pop    r14
 54d:	41 5d                	pop    r13
 54f:	41 5c                	pop    r12
 551:	41 5b                	pop    r11
 553:	41 5a                	pop    r10
 555:	41 59                	pop    r9
 557:	41 58                	pop    r8
 559:	5f                   	pop    rdi
 55a:	5e                   	pop    rsi
 55b:	5d                   	pop    rbp
 55c:	5c                   	pop    rsp
 55d:	5b                   	pop    rbx
 55e:	5a                   	pop    rdx
 55f:	59                   	pop    rcx
 560:	58                   	pop    rax
	iretq
 561:	48 cf                	iretq

0000000000000563 <irq_1>:

.global irq_1
irq_1:
	push 1
 563:	6a 01                	push   0x1
	jmp irq_ahandler
 565:	eb 38                	jmp    59f <irq_ahandler>

0000000000000567 <irq_2>:

.global irq_2
irq_2:
	push 2
 567:	6a 02                	push   0x2
	jmp irq_ahandler
 569:	eb 34                	jmp    59f <irq_ahandler>

000000000000056b <irq_3>:

.global irq_3
irq_3:
	push 3
 56b:	6a 03                	push   0x3
	jmp irq_ahandler
 56d:	eb 30                	jmp    59f <irq_ahandler>

000000000000056f <irq_4>:

.global irq_4
irq_4:
	push 4
 56f:	6a 04                	push   0x4
	jmp irq_ahandler
 571:	eb 2c                	jmp    59f <irq_ahandler>

0000000000000573 <irq_5>:

.global irq_5
irq_5:
	push 5
 573:	6a 05                	push   0x5
	jmp irq_ahandler
 575:	eb 28                	jmp    59f <irq_ahandler>

0000000000000577 <irq_6>:

.global irq_6
irq_6:
	push 6
 577:	6a 06                	push   0x6
	jmp irq_ahandler
 579:	eb 24                	jmp    59f <irq_ahandler>

000000000000057b <irq_7>:

.global irq_7
irq_7:
	push 7
 57b:	6a 07                	push   0x7
	jmp irq_ahandler
 57d:	eb 20                	jmp    59f <irq_ahandler>

000000000000057f <irq_8>:

.global irq_8
irq_8:
	push 8
 57f:	6a 08                	push   0x8
	jmp irq_ahandler
 581:	eb 1c                	jmp    59f <irq_ahandler>

0000000000000583 <irq_9>:

.global irq_9
irq_9:
	push 9
 583:	6a 09                	push   0x9
	jmp irq_ahandler
 585:	eb 18                	jmp    59f <irq_ahandler>

0000000000000587 <irq_10>:

.global irq_10
irq_10:
	push 10
 587:	6a 0a                	push   0xa
	jmp irq_ahandler
 589:	eb 14                	jmp    59f <irq_ahandler>

000000000000058b <irq_11>:

.global irq_11
irq_11:
	push 11
 58b:	6a 0b                	push   0xb
	jmp irq_ahandler
 58d:	eb 10                	jmp    59f <irq_ahandler>

000000000000058f <irq_12>:

.global irq_12
irq_12:
	push 12
 58f:	6a 0c                	push   0xc
	jmp irq_ahandler
 591:	eb 0c                	jmp    59f <irq_ahandler>

0000000000000593 <irq_13>:

.global irq_13
irq_13:
	push 13
 593:	6a 0d                	push   0xd
	jmp irq_ahandler
 595:	eb 08                	jmp    59f <irq_ahandler>

0000000000000597 <irq_14>:

.global irq_14
irq_14:
	push 14
 597:	6a 0e                	push   0xe
	jmp irq_ahandler
 599:	eb 04                	jmp    59f <irq_ahandler>

000000000000059b <irq_15>:

.global irq_15
irq_15:
	push 15
 59b:	6a 0f                	push   0xf
	jmp irq_ahandler
 59d:	eb 00                	jmp    59f <irq_ahandler>

000000000000059f <irq_ahandler>:


# handler for all IRQs
irq_ahandler:
	pushaq
 59f:	50                   	push   rax
 5a0:	51                   	push   rcx
 5a1:	52                   	push   rdx
 5a2:	53                   	push   rbx
 5a3:	54                   	push   rsp
 5a4:	55                   	push   rbp
 5a5:	56                   	push   rsi
 5a6:	57                   	push   rdi
 5a7:	41 50                	push   r8
 5a9:	41 51                	push   r9
 5ab:	41 52                	push   r10
 5ad:	41 53                	push   r11
 5af:	41 54                	push   r12
 5b1:	41 55                	push   r13
 5b3:	41 56                	push   r14
 5b5:	41 57                	push   r15
	mov rdi, [rsp+16*8] # type
 5b7:	48 8b bc 24 80 00 00 00 	mov    rdi,QWORD PTR [rsp+0x80]
	call irq_handler # (uint)
 5bf:	e8 00 00 00 00       	call   5c4 <irq_ahandler+0x25>
	popaq
 5c4:	41 5f                	pop    r15
 5c6:	41 5e                	pop    r14
 5c8:	41 5d                	pop    r13
 5ca:	41 5c                	pop    r12
 5cc:	41 5b                	pop    r11
 5ce:	41 5a                	pop    r10
 5d0:	41 59                	pop    r9
 5d2:	41 58                	pop    r8
 5d4:	5f                   	pop    rdi
 5d5:	5e                   	pop    rsi
 5d6:	5d                   	pop    rbp
 5d7:	5c                   	pop    rsp
 5d8:	5b                   	pop    rbx
 5d9:	5a                   	pop    rdx
 5da:	59                   	pop    rcx
 5db:	58                   	pop    rax
	add rsp, 8 # type
 5dc:	48 83 c4 08          	add    rsp,0x8
	iretq
 5e0:	48 cf                	iretq

00000000000005e2 <msi_0>:

# MSI pre-handlers
.global msi_0
msi_0:
	push 0
 5e2:	6a 00                	push   0x0
	jmp msi_ahandler
 5e4:	eb 1c                	jmp    602 <msi_ahandler>

00000000000005e6 <msi_1>:
.global msi_1
msi_1:
	push 1
 5e6:	6a 01                	push   0x1
	jmp msi_ahandler
 5e8:	eb 18                	jmp    602 <msi_ahandler>

00000000000005ea <msi_2>:
.global msi_2
msi_2:
	push 2
 5ea:	6a 02                	push   0x2
	jmp msi_ahandler
 5ec:	eb 14                	jmp    602 <msi_ahandler>

00000000000005ee <msi_3>:
.global msi_3
msi_3:
	push 3
 5ee:	6a 03                	push   0x3
	jmp msi_ahandler
 5f0:	eb 10                	jmp    602 <msi_ahandler>

00000000000005f2 <msi_4>:
.global msi_4
msi_4:
	push 4
 5f2:	6a 04                	push   0x4
	jmp msi_ahandler
 5f4:	eb 0c                	jmp    602 <msi_ahandler>

00000000000005f6 <msi_5>:
.global msi_5
msi_5:
	push 5
 5f6:	6a 05                	push   0x5
	jmp msi_ahandler
 5f8:	eb 08                	jmp    602 <msi_ahandler>

00000000000005fa <msi_6>:
.global msi_6
msi_6:
	push 6
 5fa:	6a 06                	push   0x6
	jmp msi_ahandler
 5fc:	eb 04                	jmp    602 <msi_ahandler>

00000000000005fe <msi_7>:
.global msi_7
msi_7:
	push 7
 5fe:	6a 07                	push   0x7
	jmp msi_ahandler
 600:	eb 00                	jmp    602 <msi_ahandler>

0000000000000602 <msi_ahandler>:

# MSI handler
msi_ahandler:
	pushaq
 602:	50                   	push   rax
 603:	51                   	push   rcx
 604:	52                   	push   rdx
 605:	53                   	push   rbx
 606:	54                   	push   rsp
 607:	55                   	push   rbp
 608:	56                   	push   rsi
 609:	57                   	push   rdi
 60a:	41 50                	push   r8
 60c:	41 51                	push   r9
 60e:	41 52                	push   r10
 610:	41 53                	push   r11
 612:	41 54                	push   r12
 614:	41 55                	push   r13
 616:	41 56                	push   r14
 618:	41 57                	push   r15
	mov rdi, [rsp+16*8] # type
 61a:	48 8b bc 24 80 00 00 00 	mov    rdi,QWORD PTR [rsp+0x80]
	call msi_handler # (uint)
 622:	e8 00 00 00 00       	call   627 <msi_ahandler+0x25>
	popaq
 627:	41 5f                	pop    r15
 629:	41 5e                	pop    r14
 62b:	41 5d                	pop    r13
 62d:	41 5c                	pop    r12
 62f:	41 5b                	pop    r11
 631:	41 5a                	pop    r10
 633:	41 59                	pop    r9
 635:	41 58                	pop    r8
 637:	5f                   	pop    rdi
 638:	5e                   	pop    rsi
 639:	5d                   	pop    rbp
 63a:	5c                   	pop    rsp
 63b:	5b                   	pop    rbx
 63c:	5a                   	pop    rdx
 63d:	59                   	pop    rcx
 63e:	58                   	pop    rax
	add rsp, 8 # type
 63f:	48 83 c4 08          	add    rsp,0x8
	iretq
 643:	48 cf                	iretq

0000000000000645 <apic_err>:

# APIC gates
apic_err:
	push 0
 645:	6a 00                	push   0x0
	jmp apic_cmm
 647:	eb 06                	jmp    64f <apic_cmm>

0000000000000649 <apic_ipi>:
apic_ipi:
	push 2
 649:	6a 02                	push   0x2
	jmp apic_cmm
 64b:	eb 02                	jmp    64f <apic_cmm>

000000000000064d <apic_spr>:
apic_spr:
	push 3
 64d:	6a 03                	push   0x3

000000000000064f <apic_cmm>:
apic_cmm:
	pushaq # 16*8 bytes
 64f:	50                   	push   rax
 650:	51                   	push   rcx
 651:	52                   	push   rdx
 652:	53                   	push   rbx
 653:	54                   	push   rsp
 654:	55                   	push   rbp
 655:	56                   	push   rsi
 656:	57                   	push   rdi
 657:	41 50                	push   r8
 659:	41 51                	push   r9
 65b:	41 52                	push   r10
 65d:	41 53                	push   r11
 65f:	41 54                	push   r12
 661:	41 55                	push   r13
 663:	41 56                	push   r14
 665:	41 57                	push   r15
	mov rdi, [rsp+16*8] # type
 667:	48 8b bc 24 80 00 00 00 	mov    rdi,QWORD PTR [rsp+0x80]
	call apic_handler
 66f:	e8 00 00 00 00       	call   674 <apic_cmm+0x25>
	popaq
 674:	41 5f                	pop    r15
 676:	41 5e                	pop    r14
 678:	41 5d                	pop    r13
 67a:	41 5c                	pop    r12
 67c:	41 5b                	pop    r11
 67e:	41 5a                	pop    r10
 680:	41 59                	pop    r9
 682:	41 58                	pop    r8
 684:	5f                   	pop    rdi
 685:	5e                   	pop    rsi
 686:	5d                   	pop    rbp
 687:	5c                   	pop    rsp
 688:	5b                   	pop    rbx
 689:	5a                   	pop    rdx
 68a:	59                   	pop    rcx
 68b:	58                   	pop    rax
	add rsp, 8 # type
 68c:	48 83 c4 08          	add    rsp,0x8
	iretq
 690:	48 cf                	iretq

0000000000000692 <apic_tmr>:
apic_tmr:
	pushaq # 16*8+4*8
 692:	50                   	push   rax
 693:	51                   	push   rcx
 694:	52                   	push   rdx
 695:	53                   	push   rbx
 696:	54                   	push   rsp
 697:	55                   	push   rbp
 698:	56                   	push   rsi
 699:	57                   	push   rdi
 69a:	41 50                	push   r8
 69c:	41 51                	push   r9
 69e:	41 52                	push   r10
 6a0:	41 53                	push   r11
 6a2:	41 54                	push   r12
 6a4:	41 55                	push   r13
 6a6:	41 56                	push   r14
 6a8:	41 57                	push   r15
	pushseg
 6aa:	8c d8                	mov    eax,ds
 6ac:	50                   	push   rax
 6ad:	8c c0                	mov    eax,es
 6af:	50                   	push   rax
 6b0:	8c e0                	mov    eax,fs
 6b2:	50                   	push   rax
 6b3:	8c e8                	mov    eax,gs
 6b5:	50                   	push   rax
	mov rdi, rsp
 6b6:	48 89 e7             	mov    rdi,rsp
	call task_save_state # (void*)
 6b9:	e8 00 00 00 00       	call   6be <apic_tmr+0x2c>
	mov edi, 1 # zero extend
 6be:	bf 01 00 00 00       	mov    edi,0x1
	call apic_handler
 6c3:	e8 00 00 00 00       	call   6c8 <apic_tmr+0x36>
	jmp irq0_longjmp
 6c8:	e9 70 fe ff ff       	jmp    53d <irq0_longjmp>

00000000000006cd <idt_init>:
.global idt_init
idt_init:
#	push ebp <- no need for frame
#	mov ebp, esp
	# disable NMI
	inb al, 0x70
 6cd:	e4 70                	in     al,0x70
	or al, 0x80
 6cf:	0c 80                	or     al,0x80
	outb 0x70, al
 6d1:	e6 70                	out    0x70,al

	# now set up the idt
#ifdef __x86_64__
	lea rax, idt
 6d3:	48 8d 04 25 00 00 00 00 	lea    rax,ds:0x0
	mov qword ptr[idtr+2], rax
 6db:	48 89 04 25 00 00 00 00 	mov    QWORD PTR ds:0x0,rax
	lea rax, idt_end-1
 6e3:	48 8d 04 25 00 00 00 00 	lea    rax,ds:0x0
	sub rax, OFFSET idt
 6eb:	48 2d 00 00 00 00    	sub    rax,0x0
	lea eax, idt
	mov dword ptr[idtr+2], eax
	lea eax, idt_end-1
	sub eax, OFFSET idt
#endif
	mov word ptr[idtr], ax
 6f1:	66 89 04 25 00 00 00 00 	mov    WORD PTR ds:0x0,ax
	lidt [idtr]
 6f9:	0f 01 1c 25 00 00 00 00 	lidt   ds:0x0

	mov ecx,  ( idt_end - idt ) / 8 
 701:	b9 00 04 00 00       	mov    ecx,0x400

0000000000000706 <idt_i1>:

#	mov ecx, 48 # zero extend in amd64

idt_i1:
	dec ecx
 706:	ff c9                	dec    ecx
	IGI ecx
 708:	89 ca                	mov    edx,ecx
 70a:	48 c1 e2 04          	shl    rdx,0x4
 70e:	8b 82 00 00 00 00    	mov    eax,DWORD PTR [rdx+0x0]
 714:	87 82 00 00 00 00    	xchg   DWORD PTR [rdx+0x0],eax
 71a:	89 82 00 00 00 00    	mov    DWORD PTR [rdx+0x0],eax
 720:	c1 e8 10             	shr    eax,0x10
 723:	66 87 82 00 00 00 00 	xchg   WORD PTR [rdx+0x0],ax
 72a:	66 89 82 00 00 00 00 	mov    WORD PTR [rdx+0x0],ax
	test ecx, ecx
 731:	85 c9                	test   ecx,ecx
	jnz idt_i1
 733:	75 d1                	jne    706 <idt_i1>

	# reenable NMI
	inb al, 0x70
 735:	e4 70                	in     al,0x70
	and al, 0x7f
 737:	24 7f                	and    al,0x7f
	outb 0x70, al
 739:	e6 70                	out    0x70,al

#	leave <- none at all
	ret
 73b:	c3                   	ret

000000000000073c <pc_shutdown>:

.global pc_shutdown
pc_shutdown:
	cli
 73c:	fa                   	cli
	hlt # TODO PM->RM or LM->RM
 73d:	f4                   	hlt
