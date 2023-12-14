
base.o:     file format elf32-i386


Disassembly of section .text:

00000000 <scrl>:
#include "basedefs.h"

static void* const vmem = FM_VIDEO_MEMORY;
static void* vmc = FM_VIDEO_MEMORY;
void scrl()
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 18             	sub    esp,0x18
		int i = 0;
   6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		/* scroll */
		mem_cpy(vmem, vmem + 2 * 80, 24 * 2 * 80);
   d:	b8 00 80 0b 00       	mov    eax,0xb8000
  12:	05 a0 00 00 00       	add    eax,0xa0
  17:	ba 00 80 0b 00       	mov    edx,0xb8000
  1c:	83 ec 04             	sub    esp,0x4
  1f:	68 00 0f 00 00       	push   0xf00
  24:	50                   	push   eax
  25:	52                   	push   edx
  26:	e8 fc ff ff ff       	call   27 <scrl+0x27>
  2b:	83 c4 10             	add    esp,0x10
		vmc -= 2 * 80;
  2e:	a1 00 00 00 00       	mov    eax,ds:0x0
  33:	2d a0 00 00 00       	sub    eax,0xa0
  38:	a3 00 00 00 00       	mov    ds:0x0,eax
		/* and zero last line */
		for (char* c = vmem + 24 * 2 * 80; i < 80; i++)
  3d:	b8 00 80 0b 00       	mov    eax,0xb8000
  42:	05 00 0f 00 00       	add    eax,0xf00
  47:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
  4a:	eb 13                	jmp    5f <scrl+0x5f>
				c[2 * i] = ' ';
  4c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  4f:	01 c0                	add    eax,eax
  51:	89 c2                	mov    edx,eax
  53:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  56:	01 d0                	add    eax,edx
  58:	c6 00 20             	mov    BYTE PTR [eax],0x20
		for (char* c = vmem + 24 * 2 * 80; i < 80; i++)
  5b:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
  5f:	83 7d f4 4f          	cmp    DWORD PTR [ebp-0xc],0x4f
  63:	7e e7                	jle    4c <scrl+0x4c>
}
  65:	90                   	nop
  66:	90                   	nop
  67:	c9                   	leave
  68:	c3                   	ret

00000069 <putc>:
void putc(char c)
{
  69:	55                   	push   ebp
  6a:	89 e5                	mov    ebp,esp
  6c:	83 ec 28             	sub    esp,0x28
  6f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  72:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		while (vmc - vmem >= (2 * 80 * 25))
  75:	eb 05                	jmp    7c <putc+0x13>
	   			scrl();
  77:	e8 fc ff ff ff       	call   78 <putc+0xf>
		while (vmc - vmem >= (2 * 80 * 25))
  7c:	a1 00 00 00 00       	mov    eax,ds:0x0
  81:	ba 00 80 0b 00       	mov    edx,0xb8000
  86:	29 d0                	sub    eax,edx
  88:	3d 9f 0f 00 00       	cmp    eax,0xf9f
  8d:	7f e8                	jg     77 <putc+0xe>
		char* vm = vmc;
  8f:	a1 00 00 00 00       	mov    eax,ds:0x0
  94:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		*vm++ = c;
  97:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  9a:	8d 50 01             	lea    edx,[eax+0x1]
  9d:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
  a0:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
  a4:	88 10                	mov    BYTE PTR [eax],dl
		*vm++ = 0x0f;
  a6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  a9:	8d 50 01             	lea    edx,[eax+0x1]
  ac:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
  af:	c6 00 0f             	mov    BYTE PTR [eax],0xf
		vmc = (void*)vm;
  b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  b5:	a3 00 00 00 00       	mov    ds:0x0,eax
}
  ba:	90                   	nop
  bb:	c9                   	leave
  bc:	c3                   	ret

000000bd <putstr>:
void putstr(const char* str) /* simple wrap-around */
{
  bd:	55                   	push   ebp
  be:	89 e5                	mov    ebp,esp
  c0:	83 ec 08             	sub    esp,0x8
		while (*str)
  c3:	eb 1b                	jmp    e0 <putstr+0x23>
	   			putc(*str++);
  c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  c8:	8d 50 01             	lea    edx,[eax+0x1]
  cb:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
  ce:	0f b6 00             	movzx  eax,BYTE PTR [eax]
  d1:	0f be c0             	movsx  eax,al
  d4:	83 ec 0c             	sub    esp,0xc
  d7:	50                   	push   eax
  d8:	e8 fc ff ff ff       	call   d9 <putstr+0x1c>
  dd:	83 c4 10             	add    esp,0x10
		while (*str)
  e0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  e3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
  e6:	84 c0                	test   al,al
  e8:	75 db                	jne    c5 <putstr+0x8>
}
  ea:	90                   	nop
  eb:	90                   	nop
  ec:	c9                   	leave
  ed:	c3                   	ret

000000ee <unputc>:
void unputc()
{
  ee:	55                   	push   ebp
  ef:	89 e5                	mov    ebp,esp
		if (vmc > vmem) {
  f1:	a1 00 00 00 00       	mov    eax,ds:0x0
  f6:	ba 00 80 0b 00       	mov    edx,0xb8000
  fb:	39 c2                	cmp    edx,eax
  fd:	73 18                	jae    117 <unputc+0x29>
				((char*)vmc)[-2] = ' ';
  ff:	a1 00 00 00 00       	mov    eax,ds:0x0
 104:	83 e8 02             	sub    eax,0x2
 107:	c6 00 20             	mov    BYTE PTR [eax],0x20
				vmc -= 2;
 10a:	a1 00 00 00 00       	mov    eax,ds:0x0
 10f:	83 e8 02             	sub    eax,0x2
 112:	a3 00 00 00 00       	mov    ds:0x0,eax
		}
}
 117:	90                   	nop
 118:	5d                   	pop    ebp
 119:	c3                   	ret

0000011a <nputstr>:
void nputstr(const char* str, int n)
{
 11a:	55                   	push   ebp
 11b:	89 e5                	mov    ebp,esp
 11d:	83 ec 08             	sub    esp,0x8
		while (*str && n--)
 120:	eb 1b                	jmp    13d <nputstr+0x23>
	   			putc(*str++);
 122:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 125:	8d 50 01             	lea    edx,[eax+0x1]
 128:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
 12b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 12e:	0f be c0             	movsx  eax,al
 131:	83 ec 0c             	sub    esp,0xc
 134:	50                   	push   eax
 135:	e8 fc ff ff ff       	call   136 <nputstr+0x1c>
 13a:	83 c4 10             	add    esp,0x10
		while (*str && n--)
 13d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 140:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 143:	84 c0                	test   al,al
 145:	74 0d                	je     154 <nputstr+0x3a>
 147:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 14a:	8d 50 ff             	lea    edx,[eax-0x1]
 14d:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
 150:	85 c0                	test   eax,eax
 152:	75 ce                	jne    122 <nputstr+0x8>
}
 154:	90                   	nop
 155:	c9                   	leave
 156:	c3                   	ret

00000157 <put_nl>:
void put_nl()
{
 157:	55                   	push   ebp
 158:	89 e5                	mov    ebp,esp
 15a:	83 ec 10             	sub    esp,0x10
		size_t len = (size_t)(vmc - vmem) % 160;
 15d:	a1 00 00 00 00       	mov    eax,ds:0x0
 162:	ba 00 80 0b 00       	mov    edx,0xb8000
 167:	29 d0                	sub    eax,edx
 169:	89 c1                	mov    ecx,eax
 16b:	ba cd cc cc cc       	mov    edx,0xcccccccd
 170:	89 c8                	mov    eax,ecx
 172:	f7 e2                	mul    edx
 174:	89 d0                	mov    eax,edx
 176:	c1 e8 07             	shr    eax,0x7
 179:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
 17c:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
 17f:	89 d0                	mov    eax,edx
 181:	c1 e0 02             	shl    eax,0x2
 184:	01 d0                	add    eax,edx
 186:	c1 e0 05             	shl    eax,0x5
 189:	29 c1                	sub    ecx,eax
 18b:	89 ca                	mov    edx,ecx
 18d:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
		if (len) {
 190:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
 194:	74 3f                	je     1d5 <put_nl+0x7e>
				for (size_t k = 0; k < 160 - len; k++)
 196:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
 19d:	eb 12                	jmp    1b1 <put_nl+0x5a>
						((char*)vmc)[k] = 0;
 19f:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 1a5:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 1a8:	01 d0                	add    eax,edx
 1aa:	c6 00 00             	mov    BYTE PTR [eax],0x0
				for (size_t k = 0; k < 160 - len; k++)
 1ad:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
 1b1:	b8 a0 00 00 00       	mov    eax,0xa0
 1b6:	2b 45 f8             	sub    eax,DWORD PTR [ebp-0x8]
 1b9:	39 45 fc             	cmp    DWORD PTR [ebp-0x4],eax
 1bc:	72 e1                	jb     19f <put_nl+0x48>
				vmc += 160 - len;
 1be:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 1c4:	b8 a0 00 00 00       	mov    eax,0xa0
 1c9:	2b 45 f8             	sub    eax,DWORD PTR [ebp-0x8]
 1cc:	01 d0                	add    eax,edx
 1ce:	a3 00 00 00 00       	mov    ds:0x0,eax
		} else
				vmc += 160;
}
 1d3:	eb 0f                	jmp    1e4 <put_nl+0x8d>
				vmc += 160;
 1d5:	a1 00 00 00 00       	mov    eax,ds:0x0
 1da:	05 a0 00 00 00       	add    eax,0xa0
 1df:	a3 00 00 00 00       	mov    ds:0x0,eax
}
 1e4:	90                   	nop
 1e5:	c9                   	leave
 1e6:	c3                   	ret

000001e7 <puts>:
void puts(const char* str)
{
 1e7:	55                   	push   ebp
 1e8:	89 e5                	mov    ebp,esp
 1ea:	83 ec 08             	sub    esp,0x8
		putstr(str);
 1ed:	83 ec 0c             	sub    esp,0xc
 1f0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 1f3:	e8 fc ff ff ff       	call   1f4 <puts+0xd>
 1f8:	83 c4 10             	add    esp,0x10
		put_nl();
 1fb:	e8 fc ff ff ff       	call   1fc <puts+0x15>
}
 200:	90                   	nop
 201:	c9                   	leave
 202:	c3                   	ret

00000203 <strncmp>:
int strncmp(const char* p1, const char* p2, size_t num)
{
 203:	55                   	push   ebp
 204:	89 e5                	mov    ebp,esp
 206:	57                   	push   edi
 207:	56                   	push   esi
 208:	53                   	push   ebx
		register const unsigned char* s1 = (const unsigned char*)p1;
 209:	8b 7d 08             	mov    edi,DWORD PTR [ebp+0x8]
		register const unsigned char* s2 = (const unsigned char*)p2;
 20c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 20f:	89 c1                	mov    ecx,eax
		register unsigned char c1, c2;
		register size_t n = num;
 211:	8b 75 10             	mov    esi,DWORD PTR [ebp+0x10]
		
		while (n) {
 214:	eb 2b                	jmp    241 <strncmp+0x3e>
				c1 = (unsigned char)*s1++;
 216:	89 f8                	mov    eax,edi
 218:	8d 78 01             	lea    edi,[eax+0x1]
 21b:	0f b6 18             	movzx  ebx,BYTE PTR [eax]
				c2 = (unsigned char)*s2++;
 21e:	89 c8                	mov    eax,ecx
 220:	8d 50 01             	lea    edx,[eax+0x1]
 223:	89 d1                	mov    ecx,edx
 225:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 228:	89 c2                	mov    edx,eax
				if (c1 == '\0' || (c1 != c2))
 22a:	84 db                	test   bl,bl
 22c:	74 04                	je     232 <strncmp+0x2f>
 22e:	38 c3                	cmp    bl,al
 230:	74 0c                	je     23e <strncmp+0x3b>
						return c1 - c2;
 232:	0f b6 c3             	movzx  eax,bl
 235:	89 d1                	mov    ecx,edx
 237:	0f b6 d1             	movzx  edx,cl
 23a:	29 d0                	sub    eax,edx
 23c:	eb 11                	jmp    24f <strncmp+0x4c>
				else
						n--;
 23e:	83 ee 01             	sub    esi,0x1
		while (n) {
 241:	85 f6                	test   esi,esi
 243:	75 d1                	jne    216 <strncmp+0x13>
		}

		return c1 - c2;
 245:	0f b6 c3             	movzx  eax,bl
 248:	89 d1                	mov    ecx,edx
 24a:	0f b6 d1             	movzx  edx,cl
 24d:	29 d0                	sub    eax,edx
}
 24f:	5b                   	pop    ebx
 250:	5e                   	pop    esi
 251:	5f                   	pop    edi
 252:	5d                   	pop    ebp
 253:	c3                   	ret

00000254 <enable_sse>:

void enable_sse()
{
 254:	55                   	push   ebp
 255:	89 e5                	mov    ebp,esp
 257:	53                   	push   ebx
 258:	83 ec 10             	sub    esp,0x10
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
 25b:	b8 01 00 00 00       	mov    eax,0x1
 260:	b9 00 00 00 00       	mov    ecx,0x0
 265:	ba 00 00 00 00       	mov    edx,0x0
 26a:	89 cb                	mov    ebx,ecx
 26c:	89 d1                	mov    ecx,edx
 26e:	0f a2                	cpuid
 270:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
 273:	89 5d f4             	mov    DWORD PTR [ebp-0xc],ebx
 276:	89 4d f0             	mov    DWORD PTR [ebp-0x10],ecx
 279:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (edx & (1<< 25)) {
 27c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 27f:	25 00 00 00 02       	and    eax,0x2000000
 284:	85 c0                	test   eax,eax
 286:	74 17                	je     29f <enable_sse+0x4b>
				asm("mov %%cr0, %%eax\n"
 288:	0f 20 c0             	mov    eax,cr0
 28b:	83 c8 02             	or     eax,0x2
 28e:	83 e0 fb             	and    eax,0xfffffffb
 291:	0f 22 c0             	mov    cr0,eax
					"or $2, %%eax\n"
					"and $0xfffffffb, %%eax\n"
					"mov %%eax, %%cr0\n"
					: : : "eax"); /* clear em(2); set mp(1) bit */
				asm("mov %%cr4, %%eax\n"
 294:	0f 20 e0             	mov    eax,cr4
 297:	0d 00 06 00 00       	or     eax,0x600
 29c:	0f 22 e0             	mov    cr4,eax
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
		}
}
 29f:	90                   	nop
 2a0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 2a3:	c9                   	leave
 2a4:	c3                   	ret

000002a5 <base_entry>:

/* Entry point working on physical memory with all interrupts
 * disabled, a basic GDT and an invalid IDT. */
void base_entry()
{
 2a5:	55                   	push   ebp
 2a6:	89 e5                	mov    ebp,esp
 2a8:	53                   	push   ebx
 2a9:	83 ec 34             	sub    esp,0x34
		/* First check for 32, PAE and 64-bit */
		int mode = 0, nx = 0, msr = 0; /* 0=32, 1=PAE, 2=64 */
 2ac:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 2b3:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 2ba:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		unsigned int eax, ebx, ecx, edx;
		uint64_t ep;

		__cpuid(0, eax, ebx, ecx, edx);
 2c1:	b8 00 00 00 00       	mov    eax,0x0
 2c6:	0f a2                	cpuid
 2c8:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 2cb:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 2ce:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 2d1:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

		/* eax leaves */
		if (eax >= 1) {
 2d4:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 2d8:	74 56                	je     330 <base_entry+0x8b>
				__cpuid(1, eax, ebx, ecx, edx);
 2da:	b8 01 00 00 00       	mov    eax,0x1
 2df:	b9 00 00 00 00       	mov    ecx,0x0
 2e4:	ba 00 00 00 00       	mov    edx,0x0
 2e9:	89 cb                	mov    ebx,ecx
 2eb:	89 d1                	mov    ecx,edx
 2ed:	0f a2                	cpuid
 2ef:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 2f2:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 2f5:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 2f8:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
				if (edx & (1 << 5)) /* MSR */
 2fb:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 2fe:	83 e0 20             	and    eax,0x20
 301:	85 c0                	test   eax,eax
 303:	74 07                	je     30c <base_entry+0x67>
					msr = 1;
 305:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
				if (edx & (1 << 6)) /* PAE */
 30c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 30f:	83 e0 40             	and    eax,0x40
 312:	85 c0                	test   eax,eax
 314:	74 07                	je     31d <base_entry+0x78>
						mode = 1;
 316:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
				if (edx & (1 << 20))
 31d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 320:	25 00 00 10 00       	and    eax,0x100000
 325:	85 c0                	test   eax,eax
 327:	74 07                	je     330 <base_entry+0x8b>
					nx = 1;
 329:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1
		}

		/* EFEAT leaves */
		__cpuid(0x80000000, eax, ebx, ecx, edx);
 330:	b8 00 00 00 80       	mov    eax,0x80000000
 335:	0f a2                	cpuid
 337:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 33a:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 33d:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 340:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		if (eax >= 0x80000001) {
 343:	81 7d e8 00 00 00 80 	cmp    DWORD PTR [ebp-0x18],0x80000000
 34a:	76 4c                	jbe    398 <base_entry+0xf3>
				__cpuid(0x80000001, eax, ebx, ecx, edx);
 34c:	b8 01 00 00 80       	mov    eax,0x80000001
 351:	0f a2                	cpuid
 353:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 356:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 359:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 35c:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
				if (edx & (1 << 29))
 35f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 362:	25 00 00 00 20       	and    eax,0x20000000
 367:	85 c0                	test   eax,eax
 369:	74 09                	je     374 <base_entry+0xcf>
						mode = 2;
 36b:	c7 45 f4 02 00 00 00 	mov    DWORD PTR [ebp-0xc],0x2
 372:	eb 11                	jmp    385 <base_entry+0xe0>
				else if (edx & (1 << 6)) /* PAE alternative */
 374:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 377:	83 e0 40             	and    eax,0x40
 37a:	85 c0                	test   eax,eax
 37c:	74 07                	je     385 <base_entry+0xe0>
						mode = 1;
 37e:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
				if (edx & (1 << 20))
 385:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 388:	25 00 00 10 00       	and    eax,0x100000
 38d:	85 c0                	test   eax,eax
 38f:	74 07                	je     398 <base_entry+0xf3>
					nx = 1;
 391:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1
		}

		/* enable nx if possible*/
		if (msr) {
 398:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 39c:	74 25                	je     3c3 <base_entry+0x11e>
			uint32_t a, d;
			asm volatile("rdmsr" : "=a"(a), "=d"(d) : "c"(0xC0000080)); /* IA32_EFER */
 39e:	b8 80 00 00 c0       	mov    eax,0xc0000080
 3a3:	89 c1                	mov    ecx,eax
 3a5:	0f 32                	rdmsr
 3a7:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 3aa:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
			a |= (1 << 11); /* NX enable */
 3ad:	81 4d d8 00 08 00 00 	or     DWORD PTR [ebp-0x28],0x800
			asm volatile("wrmsr" : : "a"(a), "d"(d), "c"(0xC0000080));
 3b4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 3b7:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 3ba:	b9 80 00 00 c0       	mov    ecx,0xc0000080
 3bf:	0f 30                	wrmsr
 3c1:	eb 07                	jmp    3ca <base_entry+0x125>
		} else
			nx = 0;
 3c3:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		if (mode == 0)
 3ca:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 3ce:	75 12                	jne    3e2 <base_entry+0x13d>
				puts("32-bit");
 3d0:	83 ec 0c             	sub    esp,0xc
 3d3:	68 04 00 00 00       	push   0x4
 3d8:	e8 fc ff ff ff       	call   3d9 <base_entry+0x134>
 3dd:	83 c4 10             	add    esp,0x10
 3e0:	eb 2e                	jmp    410 <base_entry+0x16b>
		else if (mode == 1)
 3e2:	83 7d f4 01          	cmp    DWORD PTR [ebp-0xc],0x1
 3e6:	75 12                	jne    3fa <base_entry+0x155>
				puts("PAE");
 3e8:	83 ec 0c             	sub    esp,0xc
 3eb:	68 0b 00 00 00       	push   0xb
 3f0:	e8 fc ff ff ff       	call   3f1 <base_entry+0x14c>
 3f5:	83 c4 10             	add    esp,0x10
 3f8:	eb 16                	jmp    410 <base_entry+0x16b>
		else if (mode == 2)
 3fa:	83 7d f4 02          	cmp    DWORD PTR [ebp-0xc],0x2
 3fe:	75 10                	jne    410 <base_entry+0x16b>
				puts("64-bit");
 400:	83 ec 0c             	sub    esp,0xc
 403:	68 0f 00 00 00       	push   0xf
 408:	e8 fc ff ff ff       	call   409 <base_entry+0x164>
 40d:	83 c4 10             	add    esp,0x10
		if (nx)
 410:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 414:	74 12                	je     428 <base_entry+0x183>
			puts("with NX");
 416:	83 ec 0c             	sub    esp,0xc
 419:	68 16 00 00 00       	push   0x16
 41e:	e8 fc ff ff ff       	call   41f <base_entry+0x17a>
 423:	83 c4 10             	add    esp,0x10
 426:	eb 28                	jmp    450 <base_entry+0x1ab>
		else if (!msr)
 428:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 42c:	75 12                	jne    440 <base_entry+0x19b>
			puts("due to no MSR support");
 42e:	83 ec 0c             	sub    esp,0xc
 431:	68 1e 00 00 00       	push   0x1e
 436:	e8 fc ff ff ff       	call   437 <base_entry+0x192>
 43b:	83 c4 10             	add    esp,0x10
 43e:	eb 10                	jmp    450 <base_entry+0x1ab>
		else
			puts("due to lack of processor support");
 440:	83 ec 0c             	sub    esp,0xc
 443:	68 34 00 00 00       	push   0x34
 448:	e8 fc ff ff ff       	call   449 <base_entry+0x1a4>
 44d:	83 c4 10             	add    esp,0x10

		/* and initialize the mini-mm */
		mm_initialize(mode, nx);
 450:	83 ec 08             	sub    esp,0x8
 453:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
 456:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 459:	e8 fc ff ff ff       	call   45a <base_entry+0x1b5>
 45e:	83 c4 10             	add    esp,0x10

		/* Then load the kernel image & modules via BIOS functions */
		ep = fl_load_images(mode);
 461:	83 ec 0c             	sub    esp,0xc
 464:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 467:	e8 fc ff ff ff       	call   468 <base_entry+0x1c3>
 46c:	83 c4 10             	add    esp,0x10
 46f:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 472:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx

		/* select the video mode */
		void vga_init(int mode);
		vga_init(mode);
 475:	83 ec 0c             	sub    esp,0xc
 478:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 47b:	e8 fc ff ff ff       	call   47c <base_entry+0x1d7>
 480:	83 c4 10             	add    esp,0x10

		/* Preallocate memory map tables in VM */
		void mm_preallocate_maps(int mode);
		mm_preallocate_maps(mode);
 483:	83 ec 0c             	sub    esp,0xc
 486:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 489:	e8 fc ff ff ff       	call   48a <base_entry+0x1e5>
 48e:	83 c4 10             	add    esp,0x10

		/* enable paging (and LM?) and jump into
		 * the kernel */
		mm_enable_paging(mode, ep);
 491:	83 ec 04             	sub    esp,0x4
 494:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
 497:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
 49a:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 49d:	e8 fc ff ff ff       	call   49e <base_entry+0x1f9>
 4a2:	83 c4 10             	add    esp,0x10
}
 4a5:	90                   	nop
 4a6:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 4a9:	c9                   	leave
 4aa:	c3                   	ret
