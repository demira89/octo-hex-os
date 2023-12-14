
libc.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <strlen>:

#include "limits.h"
#include "kernel.h"

size_t strlen(const char* str)
{
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	41 54                	push   r12
       6:	53                   	push   rbx
       7:	48 83 ec 08          	sub    rsp,0x8
       b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		register const char* s = str;
       f:	48 8b 5d e8          	mov    rbx,QWORD PTR [rbp-0x18]
		register size_t rv = 0;
      13:	41 bc 00 00 00 00    	mov    r12d,0x0
		if (!s)
      19:	48 85 db             	test   rbx,rbx
      1c:	75 0b                	jne    29 <strlen+0x29>
				return 0;
      1e:	b8 00 00 00 00       	mov    eax,0x0
      23:	eb 15                	jmp    3a <strlen+0x3a>
		while (*s++)
				rv++;
      25:	49 83 c4 01          	add    r12,0x1
		while (*s++)
      29:	48 89 d8             	mov    rax,rbx
      2c:	48 8d 58 01          	lea    rbx,[rax+0x1]
      30:	0f b6 00             	movzx  eax,BYTE PTR [rax]
      33:	84 c0                	test   al,al
      35:	75 ee                	jne    25 <strlen+0x25>
		return rv;
      37:	4c 89 e0             	mov    rax,r12
}
      3a:	48 83 c4 08          	add    rsp,0x8
      3e:	5b                   	pop    rbx
      3f:	41 5c                	pop    r12
      41:	5d                   	pop    rbp
      42:	c3                   	ret

0000000000000043 <strcmp>:

int strcmp(const char* p1, const char* p2)
{
      43:	55                   	push   rbp
      44:	48 89 e5             	mov    rbp,rsp
      47:	41 56                	push   r14
      49:	41 55                	push   r13
      4b:	41 54                	push   r12
      4d:	53                   	push   rbx
      4e:	48 83 ec 10          	sub    rsp,0x10
      52:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
      56:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		register const unsigned char* s1 = (const unsigned char*)p1;
      5a:	4c 8b 6d d8          	mov    r13,QWORD PTR [rbp-0x28]
		register const unsigned char* s2 = (const unsigned char*)p2;
      5e:	4c 8b 75 d0          	mov    r14,QWORD PTR [rbp-0x30]
		register unsigned char c1, c2;
		
		do {
				c1 = (unsigned char)*s1++;
      62:	4c 89 e8             	mov    rax,r13
      65:	4c 8d 68 01          	lea    r13,[rax+0x1]
      69:	0f b6 18             	movzx  ebx,BYTE PTR [rax]
				c2 = (unsigned char)*s2++;
      6c:	4c 89 f0             	mov    rax,r14
      6f:	4c 8d 70 01          	lea    r14,[rax+0x1]
      73:	44 0f b6 20          	movzx  r12d,BYTE PTR [rax]
				if (c1 == '\0')
      77:	84 db                	test   bl,bl
      79:	75 0b                	jne    86 <strcmp+0x43>
						return c1 - c2;
      7b:	0f b6 c3             	movzx  eax,bl
      7e:	41 0f b6 d4          	movzx  edx,r12b
      82:	29 d0                	sub    eax,edx
      84:	eb 0e                	jmp    94 <strcmp+0x51>
		} while (c1 == c2);
      86:	44 38 e3             	cmp    bl,r12b
      89:	74 d7                	je     62 <strcmp+0x1f>

		return c1 - c2;
      8b:	0f b6 c3             	movzx  eax,bl
      8e:	41 0f b6 d4          	movzx  edx,r12b
      92:	29 d0                	sub    eax,edx
}
      94:	48 83 c4 10          	add    rsp,0x10
      98:	5b                   	pop    rbx
      99:	41 5c                	pop    r12
      9b:	41 5d                	pop    r13
      9d:	41 5e                	pop    r14
      9f:	5d                   	pop    rbp
      a0:	c3                   	ret

00000000000000a1 <strncmp>:

int strncmp(const char* p1, const char* p2, size_t num)
{
      a1:	55                   	push   rbp
      a2:	48 89 e5             	mov    rbp,rsp
      a5:	41 57                	push   r15
      a7:	41 56                	push   r14
      a9:	41 55                	push   r13
      ab:	41 54                	push   r12
      ad:	53                   	push   rbx
      ae:	48 83 ec 18          	sub    rsp,0x18
      b2:	48 89 7d d0          	mov    QWORD PTR [rbp-0x30],rdi
      b6:	48 89 75 c8          	mov    QWORD PTR [rbp-0x38],rsi
      ba:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
		register const unsigned char* s1 = (const unsigned char*)p1;
      be:	4c 8b 75 d0          	mov    r14,QWORD PTR [rbp-0x30]
		register const unsigned char* s2 = (const unsigned char*)p2;
      c2:	4c 8b 7d c8          	mov    r15,QWORD PTR [rbp-0x38]
		register unsigned char c1, c2;
		register size_t n = num;
      c6:	4c 8b 65 c0          	mov    r12,QWORD PTR [rbp-0x40]
		
		while (n) {
      ca:	eb 2d                	jmp    f9 <strncmp+0x58>
				c1 = (unsigned char)*s1++;
      cc:	4c 89 f0             	mov    rax,r14
      cf:	4c 8d 70 01          	lea    r14,[rax+0x1]
      d3:	0f b6 18             	movzx  ebx,BYTE PTR [rax]
				c2 = (unsigned char)*s2++;
      d6:	4c 89 f8             	mov    rax,r15
      d9:	4c 8d 78 01          	lea    r15,[rax+0x1]
      dd:	44 0f b6 28          	movzx  r13d,BYTE PTR [rax]
				if (c1 == '\0' || (c1 != c2))
      e1:	84 db                	test   bl,bl
      e3:	74 05                	je     ea <strncmp+0x49>
      e5:	44 38 eb             	cmp    bl,r13b
      e8:	74 0b                	je     f5 <strncmp+0x54>
						return c1 - c2;
      ea:	0f b6 c3             	movzx  eax,bl
      ed:	41 0f b6 d5          	movzx  edx,r13b
      f1:	29 d0                	sub    eax,edx
      f3:	eb 12                	jmp    107 <strncmp+0x66>
				else
						n--;
      f5:	49 83 ec 01          	sub    r12,0x1
		while (n) {
      f9:	4d 85 e4             	test   r12,r12
      fc:	75 ce                	jne    cc <strncmp+0x2b>
		}

		return c1 - c2;
      fe:	0f b6 c3             	movzx  eax,bl
     101:	41 0f b6 d5          	movzx  edx,r13b
     105:	29 d0                	sub    eax,edx
}
     107:	48 83 c4 18          	add    rsp,0x18
     10b:	5b                   	pop    rbx
     10c:	41 5c                	pop    r12
     10e:	41 5d                	pop    r13
     110:	41 5e                	pop    r14
     112:	41 5f                	pop    r15
     114:	5d                   	pop    rbp
     115:	c3                   	ret

0000000000000116 <strstr>:

char* strstr(const char* p1, const char* p2)
{
     116:	55                   	push   rbp
     117:	48 89 e5             	mov    rbp,rsp
     11a:	41 54                	push   r12
     11c:	53                   	push   rbx
     11d:	48 83 ec 10          	sub    rsp,0x10
     121:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     125:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		register const unsigned char* s1 = (const unsigned char*)p1;
     129:	4c 8b 65 e8          	mov    r12,QWORD PTR [rbp-0x18]
		register const unsigned char* s2 = (const unsigned char*)p2;
     12d:	48 8b 5d e0          	mov    rbx,QWORD PTR [rbp-0x20]
		if (!p1)
     131:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     136:	75 07                	jne    13f <strstr+0x29>
				return NULL;
     138:	b8 00 00 00 00       	mov    eax,0x0
     13d:	eb 58                	jmp    197 <strstr+0x81>
		if (!p2)
     13f:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     144:	75 36                	jne    17c <strstr+0x66>
				return (char*)p1;
     146:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     14a:	eb 4b                	jmp    197 <strstr+0x81>
		while (*s1) {
				if (*s1 != *s2) {
     14c:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
     151:	0f b6 03             	movzx  eax,BYTE PTR [rbx]
     154:	38 c2                	cmp    dl,al
     156:	74 0f                	je     167 <strstr+0x51>
						s2 = (const unsigned char*)p2;
     158:	48 8b 5d e0          	mov    rbx,QWORD PTR [rbp-0x20]
						p1 = (const char*)(s1 + 1);
     15c:	49 8d 44 24 01       	lea    rax,[r12+0x1]
     161:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     165:	eb 0d                	jmp    174 <strstr+0x5e>
				} else if (!*s2)
     167:	0f b6 03             	movzx  eax,BYTE PTR [rbx]
     16a:	84 c0                	test   al,al
     16c:	75 06                	jne    174 <strstr+0x5e>
						return (char*)p1;
     16e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     172:	eb 23                	jmp    197 <strstr+0x81>
				s1++; s2++;
     174:	49 83 c4 01          	add    r12,0x1
     178:	48 83 c3 01          	add    rbx,0x1
		while (*s1) {
     17c:	41 0f b6 04 24       	movzx  eax,BYTE PTR [r12]
     181:	84 c0                	test   al,al
     183:	75 c7                	jne    14c <strstr+0x36>
		}
		return (*s2) ?  NULL : (char*)p1;
     185:	0f b6 03             	movzx  eax,BYTE PTR [rbx]
     188:	84 c0                	test   al,al
     18a:	75 06                	jne    192 <strstr+0x7c>
     18c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     190:	eb 05                	jmp    197 <strstr+0x81>
     192:	b8 00 00 00 00       	mov    eax,0x0
}
     197:	48 83 c4 10          	add    rsp,0x10
     19b:	5b                   	pop    rbx
     19c:	41 5c                	pop    r12
     19e:	5d                   	pop    rbp
     19f:	c3                   	ret

00000000000001a0 <bzero>:

void bzero(void* ptr, size_t s)
{
     1a0:	55                   	push   rbp
     1a1:	48 89 e5             	mov    rbp,rsp
     1a4:	53                   	push   rbx
     1a5:	48 83 ec 10          	sub    rsp,0x10
     1a9:	48 89 7d f0          	mov    QWORD PTR [rbp-0x10],rdi
     1ad:	48 89 75 e8          	mov    QWORD PTR [rbp-0x18],rsi
		register uint8_t* p = (uint8_t*)ptr;
     1b1:	48 8b 5d f0          	mov    rbx,QWORD PTR [rbp-0x10]
		if (s >= 8) {
     1b5:	48 83 7d e8 07       	cmp    QWORD PTR [rbp-0x18],0x7
     1ba:	76 40                	jbe    1fc <bzero+0x5c>
				/* first align to dword boundary */
				while ((size_t)p % 4) {
     1bc:	eb 0f                	jmp    1cd <bzero+0x2d>
						*p++ = 0;
     1be:	48 89 d8             	mov    rax,rbx
     1c1:	48 8d 58 01          	lea    rbx,[rax+0x1]
     1c5:	c6 00 00             	mov    BYTE PTR [rax],0x0
						s--;
     1c8:	48 83 6d e8 01       	sub    QWORD PTR [rbp-0x18],0x1
				while ((size_t)p % 4) {
     1cd:	48 89 d8             	mov    rax,rbx
     1d0:	83 e0 03             	and    eax,0x3
     1d3:	48 85 c0             	test   rax,rax
     1d6:	75 e6                	jne    1be <bzero+0x1e>
				}
				/* now clear uint32_t-sized blocks */
				while (s >= 4) {
     1d8:	eb 0f                	jmp    1e9 <bzero+0x49>
						*(uint32_t*)p = 0;
     1da:	c7 03 00 00 00 00    	mov    DWORD PTR [rbx],0x0
						p += 4;
     1e0:	48 83 c3 04          	add    rbx,0x4
						s -= 4;
     1e4:	48 83 6d e8 04       	sub    QWORD PTR [rbp-0x18],0x4
				while (s >= 4) {
     1e9:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
     1ee:	77 ea                	ja     1da <bzero+0x3a>
				}
		}
		/* set remaining memory */
		while (s--)
     1f0:	eb 0a                	jmp    1fc <bzero+0x5c>
				*p++ = 0;
     1f2:	48 89 d8             	mov    rax,rbx
     1f5:	48 8d 58 01          	lea    rbx,[rax+0x1]
     1f9:	c6 00 00             	mov    BYTE PTR [rax],0x0
		while (s--)
     1fc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     200:	48 8d 50 ff          	lea    rdx,[rax-0x1]
     204:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
     208:	48 85 c0             	test   rax,rax
     20b:	75 e5                	jne    1f2 <bzero+0x52>
}
     20d:	90                   	nop
     20e:	90                   	nop
     20f:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     213:	c9                   	leave
     214:	c3                   	ret

0000000000000215 <memmove>:

void* memmove(void* dest, const void* src, size_t len)
{
     215:	55                   	push   rbp
     216:	48 89 e5             	mov    rbp,rsp
     219:	41 54                	push   r12
     21b:	53                   	push   rbx
     21c:	48 83 ec 18          	sub    rsp,0x18
     220:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     224:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
     228:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		register uint8_t* p = (uint8_t*)dest;
     22c:	48 8b 5d e8          	mov    rbx,QWORD PTR [rbp-0x18]
		register uint8_t* s = (uint8_t*)src;
     230:	4c 8b 65 e0          	mov    r12,QWORD PTR [rbp-0x20]
		if (((size_t)__builtin_abs(dest - src)) >= len) { /* FWD copy */
     234:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     238:	48 2b 45 e0          	sub    rax,QWORD PTR [rbp-0x20]
     23c:	89 c2                	mov    edx,eax
     23e:	f7 da                	neg    edx
     240:	0f 49 c2             	cmovns eax,edx
     243:	48 98                	cdqe
     245:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
     249:	72 28                	jb     273 <memmove+0x5e>
			while (len--)
     24b:	eb 13                	jmp    260 <memmove+0x4b>
					*p++ = *s++;
     24d:	4c 89 e2             	mov    rdx,r12
     250:	4c 8d 62 01          	lea    r12,[rdx+0x1]
     254:	48 89 d8             	mov    rax,rbx
     257:	48 8d 58 01          	lea    rbx,[rax+0x1]
     25b:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
     25e:	88 10                	mov    BYTE PTR [rax],dl
			while (len--)
     260:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     264:	48 8d 50 ff          	lea    rdx,[rax-0x1]
     268:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
     26c:	48 85 c0             	test   rax,rax
     26f:	75 dc                	jne    24d <memmove+0x38>
     271:	eb 32                	jmp    2a5 <memmove+0x90>
		} else {
				dest += len;
     273:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     277:	48 01 45 e8          	add    QWORD PTR [rbp-0x18],rax
				src += len;
     27b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     27f:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
				while (len--)
     283:	eb 0f                	jmp    294 <memmove+0x7f>
						*--p = *--s;
     285:	49 83 ec 01          	sub    r12,0x1
     289:	48 83 eb 01          	sub    rbx,0x1
     28d:	41 0f b6 04 24       	movzx  eax,BYTE PTR [r12]
     292:	88 03                	mov    BYTE PTR [rbx],al
				while (len--)
     294:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     298:	48 8d 50 ff          	lea    rdx,[rax-0x1]
     29c:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
     2a0:	48 85 c0             	test   rax,rax
     2a3:	75 e0                	jne    285 <memmove+0x70>
		}
		return dest;
     2a5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
     2a9:	48 83 c4 18          	add    rsp,0x18
     2ad:	5b                   	pop    rbx
     2ae:	41 5c                	pop    r12
     2b0:	5d                   	pop    rbp
     2b1:	c3                   	ret

00000000000002b2 <memset>:

void* memset(void* ptr, int value, size_t num)
{
     2b2:	55                   	push   rbp
     2b3:	48 89 e5             	mov    rbp,rsp
     2b6:	53                   	push   rbx
     2b7:	48 83 ec 18          	sub    rsp,0x18
     2bb:	48 89 7d f0          	mov    QWORD PTR [rbp-0x10],rdi
     2bf:	89 75 ec             	mov    DWORD PTR [rbp-0x14],esi
     2c2:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
		register uint8_t* p = (uint8_t*)ptr;
     2c6:	48 8b 5d f0          	mov    rbx,QWORD PTR [rbp-0x10]
		while (num--)
     2ca:	eb 0c                	jmp    2d8 <memset+0x26>
				*p++ = (uint8_t)value;
     2cc:	48 89 d8             	mov    rax,rbx
     2cf:	48 8d 58 01          	lea    rbx,[rax+0x1]
     2d3:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     2d6:	88 10                	mov    BYTE PTR [rax],dl
		while (num--)
     2d8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     2dc:	48 8d 50 ff          	lea    rdx,[rax-0x1]
     2e0:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
     2e4:	48 85 c0             	test   rax,rax
     2e7:	75 e3                	jne    2cc <memset+0x1a>
		return ptr;
     2e9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
     2ed:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     2f1:	c9                   	leave
     2f2:	c3                   	ret

00000000000002f3 <isspace>:

int isspace(int c)
{
     2f3:	55                   	push   rbp
     2f4:	48 89 e5             	mov    rbp,rsp
     2f7:	48 83 ec 08          	sub    rsp,0x8
     2fb:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		return (c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r');
     2fe:	83 7d fc 20          	cmp    DWORD PTR [rbp-0x4],0x20
     302:	74 1e                	je     322 <isspace+0x2f>
     304:	83 7d fc 09          	cmp    DWORD PTR [rbp-0x4],0x9
     308:	74 18                	je     322 <isspace+0x2f>
     30a:	83 7d fc 0a          	cmp    DWORD PTR [rbp-0x4],0xa
     30e:	74 12                	je     322 <isspace+0x2f>
     310:	83 7d fc 0b          	cmp    DWORD PTR [rbp-0x4],0xb
     314:	74 0c                	je     322 <isspace+0x2f>
     316:	83 7d fc 0c          	cmp    DWORD PTR [rbp-0x4],0xc
     31a:	74 06                	je     322 <isspace+0x2f>
     31c:	83 7d fc 0d          	cmp    DWORD PTR [rbp-0x4],0xd
     320:	75 07                	jne    329 <isspace+0x36>
     322:	b8 01 00 00 00       	mov    eax,0x1
     327:	eb 05                	jmp    32e <isspace+0x3b>
     329:	b8 00 00 00 00       	mov    eax,0x0
}
     32e:	c9                   	leave
     32f:	c3                   	ret

0000000000000330 <isprint>:

int isprint(int c)
{
     330:	55                   	push   rbp
     331:	48 89 e5             	mov    rbp,rsp
     334:	48 83 ec 08          	sub    rsp,0x8
     338:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		if (c > 0x1f && c < 0x7f)
     33b:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
     33f:	7e 0d                	jle    34e <isprint+0x1e>
     341:	83 7d fc 7e          	cmp    DWORD PTR [rbp-0x4],0x7e
     345:	7f 07                	jg     34e <isprint+0x1e>
				return 1;
     347:	b8 01 00 00 00       	mov    eax,0x1
     34c:	eb 05                	jmp    353 <isprint+0x23>
		return 0;
     34e:	b8 00 00 00 00       	mov    eax,0x0
}
     353:	c9                   	leave
     354:	c3                   	ret

0000000000000355 <strtol>:

long int strtol(const char* str, char** endptr, int base)
{
     355:	55                   	push   rbp
     356:	48 89 e5             	mov    rbp,rsp
     359:	48 83 ec 38          	sub    rsp,0x38
     35d:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     361:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
     365:	89 55 cc             	mov    DWORD PTR [rbp-0x34],edx
		unsigned long int rv = 0, isN = 0;
     368:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     370:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		char num_max, char_max, char2_max;
		if (!str || base > 32 || base < 0 || base == 1) {
     378:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     37d:	74 12                	je     391 <strtol+0x3c>
     37f:	83 7d cc 20          	cmp    DWORD PTR [rbp-0x34],0x20
     383:	7f 0c                	jg     391 <strtol+0x3c>
     385:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
     389:	78 06                	js     391 <strtol+0x3c>
     38b:	83 7d cc 01          	cmp    DWORD PTR [rbp-0x34],0x1
     38f:	75 19                	jne    3aa <strtol+0x55>
				errno = EINVAL;
     391:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 39b <strtol+0x46>
				return 0L;
     39b:	b8 00 00 00 00       	mov    eax,0x0
     3a0:	e9 44 02 00 00       	jmp    5e9 <strtol+0x294>
		}
		while (isspace(*str))
				str++;
     3a5:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
		while (isspace(*str))
     3aa:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3ae:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     3b1:	0f be c0             	movsx  eax,al
     3b4:	89 c7                	mov    edi,eax
     3b6:	e8 00 00 00 00       	call   3bb <strtol+0x66>
     3bb:	85 c0                	test   eax,eax
     3bd:	75 e6                	jne    3a5 <strtol+0x50>
		if (!base) {
     3bf:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
     3c3:	75 42                	jne    407 <strtol+0xb2>
				/* read prefix */
				if (*str == '0') {
     3c5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3c9:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     3cc:	3c 30                	cmp    al,0x30
     3ce:	75 30                	jne    400 <strtol+0xab>
						base = 8;
     3d0:	c7 45 cc 08 00 00 00 	mov    DWORD PTR [rbp-0x34],0x8
						str++;
     3d7:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
						if (*str == 'x' || *str == 'X') {
     3dc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3e0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     3e3:	3c 78                	cmp    al,0x78
     3e5:	74 0b                	je     3f2 <strtol+0x9d>
     3e7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3eb:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     3ee:	3c 58                	cmp    al,0x58
     3f0:	75 15                	jne    407 <strtol+0xb2>
								base = 16;
     3f2:	c7 45 cc 10 00 00 00 	mov    DWORD PTR [rbp-0x34],0x10
								str++;
     3f9:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
     3fe:	eb 07                	jmp    407 <strtol+0xb2>
						}
				} else
						base = 10;
     400:	c7 45 cc 0a 00 00 00 	mov    DWORD PTR [rbp-0x34],0xa
		}
		num_max = ((base >= 10) ? '9' : ('0' + base - 1));
     407:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     40a:	ba 0a 00 00 00       	mov    edx,0xa
     40f:	39 d0                	cmp    eax,edx
     411:	0f 4f c2             	cmovg  eax,edx
     414:	83 c0 2f             	add    eax,0x2f
     417:	88 45 ee             	mov    BYTE PTR [rbp-0x12],al
		char_max = ((base <= 10) ? ('A' - 1) : ('A' + base - 11));
     41a:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     41d:	ba 0a 00 00 00       	mov    edx,0xa
     422:	39 d0                	cmp    eax,edx
     424:	0f 4c c2             	cmovl  eax,edx
     427:	83 c0 36             	add    eax,0x36
     42a:	88 45 ed             	mov    BYTE PTR [rbp-0x13],al
		char2_max = ((base <= 10) ? ('a' - 1) : ('a' + base - 11));
     42d:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     430:	ba 0a 00 00 00       	mov    edx,0xa
     435:	39 d0                	cmp    eax,edx
     437:	0f 4c c2             	cmovl  eax,edx
     43a:	83 c0 56             	add    eax,0x56
     43d:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		if (*str == '-' || *str == '+')
     440:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     444:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     447:	3c 2d                	cmp    al,0x2d
     449:	74 0b                	je     456 <strtol+0x101>
     44b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     44f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     452:	3c 2b                	cmp    al,0x2b
     454:	75 1b                	jne    471 <strtol+0x11c>
				isN = (*str++ == '-');
     456:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     45a:	48 8d 50 01          	lea    rdx,[rax+0x1]
     45e:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
     462:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     465:	3c 2d                	cmp    al,0x2d
     467:	0f 94 c0             	sete   al
     46a:	0f b6 c0             	movzx  eax,al
     46d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		while (1) {
				uint8_t addv = 0xff;
     471:	c6 45 ef ff          	mov    BYTE PTR [rbp-0x11],0xff
				if(*str >= '0' && *str <= num_max)
     475:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     479:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     47c:	3c 2f                	cmp    al,0x2f
     47e:	7e 1b                	jle    49b <strtol+0x146>
     480:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     484:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     487:	38 45 ee             	cmp    BYTE PTR [rbp-0x12],al
     48a:	7c 0f                	jl     49b <strtol+0x146>
						addv = *str - '0';
     48c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     490:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     493:	83 e8 30             	sub    eax,0x30
     496:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
     499:	eb 4a                	jmp    4e5 <strtol+0x190>
				else if (*str >= 'A' && *str <= char_max)
     49b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     49f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     4a2:	3c 40                	cmp    al,0x40
     4a4:	7e 1b                	jle    4c1 <strtol+0x16c>
     4a6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4aa:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     4ad:	38 45 ed             	cmp    BYTE PTR [rbp-0x13],al
     4b0:	7c 0f                	jl     4c1 <strtol+0x16c>
						addv = (*str - 'A') + 10;
     4b2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4b6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     4b9:	83 e8 37             	sub    eax,0x37
     4bc:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
     4bf:	eb 24                	jmp    4e5 <strtol+0x190>
				else if (*str >= 'a' && *str <= char2_max)
     4c1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4c5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     4c8:	3c 60                	cmp    al,0x60
     4ca:	7e 19                	jle    4e5 <strtol+0x190>
     4cc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4d0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     4d3:	38 45 ec             	cmp    BYTE PTR [rbp-0x14],al
     4d6:	7c 0d                	jl     4e5 <strtol+0x190>
						addv = (*str - 'a') + 10;
     4d8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4dc:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     4df:	83 e8 57             	sub    eax,0x57
     4e2:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al

				if (addv == 0xff) {
     4e5:	80 7d ef ff          	cmp    BYTE PTR [rbp-0x11],0xff
     4e9:	75 6b                	jne    556 <strtol+0x201>
						if (endptr)
     4eb:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
     4f0:	74 0b                	je     4fd <strtol+0x1a8>
								*endptr = (char*)str;
     4f2:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     4f6:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     4fa:	48 89 10             	mov    QWORD PTR [rax],rdx
						if (isN == 2 || isN == 3) {
     4fd:	48 83 7d f0 02       	cmp    QWORD PTR [rbp-0x10],0x2
     502:	74 07                	je     50b <strtol+0x1b6>
     504:	48 83 7d f0 03       	cmp    QWORD PTR [rbp-0x10],0x3
     509:	75 2f                	jne    53a <strtol+0x1e5>
								errno = ERANGE;
     50b:	c7 05 00 00 00 00 22 00 00 00 	mov    DWORD PTR [rip+0x0],0x22        # 515 <strtol+0x1c0>
								return isN == 2 ? LONG_MAX : LONG_MIN;
     515:	48 83 7d f0 02       	cmp    QWORD PTR [rbp-0x10],0x2
     51a:	75 0f                	jne    52b <strtol+0x1d6>
     51c:	48 b8 ff ff ff ff ff ff ff 7f 	movabs rax,0x7fffffffffffffff
     526:	e9 be 00 00 00       	jmp    5e9 <strtol+0x294>
     52b:	48 b8 00 00 00 00 00 00 00 80 	movabs rax,0x8000000000000000
     535:	e9 af 00 00 00       	jmp    5e9 <strtol+0x294>
						}
						return isN ? -rv : rv;
     53a:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     53f:	74 0c                	je     54d <strtol+0x1f8>
     541:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     545:	48 f7 d8             	neg    rax
     548:	e9 9c 00 00 00       	jmp    5e9 <strtol+0x294>
     54d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     551:	e9 93 00 00 00       	jmp    5e9 <strtol+0x294>
				} else {
						if (isN == 0) {
     556:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     55b:	75 3d                	jne    59a <strtol+0x245>
								if (rv * base + addv > LONG_MAX)
     55d:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     560:	48 98                	cdqe
     562:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     567:	48 89 c2             	mov    rdx,rax
     56a:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
     56e:	48 01 d0             	add    rax,rdx
     571:	48 85 c0             	test   rax,rax
     574:	79 0a                	jns    580 <strtol+0x22b>
										isN = 2;
     576:	48 c7 45 f0 02 00 00 00 	mov    QWORD PTR [rbp-0x10],0x2
     57e:	eb 5f                	jmp    5df <strtol+0x28a>
								else
										rv = rv * base + addv;
     580:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     583:	48 98                	cdqe
     585:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     58a:	48 89 c2             	mov    rdx,rax
     58d:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
     591:	48 01 d0             	add    rax,rdx
     594:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     598:	eb 45                	jmp    5df <strtol+0x28a>
						} else {
								if ((rv * base + addv) > (unsigned long int)(LONG_MAX) + 1)
     59a:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     59d:	48 98                	cdqe
     59f:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     5a4:	48 89 c2             	mov    rdx,rax
     5a7:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
     5ab:	48 01 d0             	add    rax,rdx
     5ae:	48 ba 00 00 00 00 00 00 00 80 	movabs rdx,0x8000000000000000
     5b8:	48 39 c2             	cmp    rdx,rax
     5bb:	73 0a                	jae    5c7 <strtol+0x272>
										isN = 3;
     5bd:	48 c7 45 f0 03 00 00 00 	mov    QWORD PTR [rbp-0x10],0x3
     5c5:	eb 18                	jmp    5df <strtol+0x28a>
								else
										rv = rv * base + addv;
     5c7:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     5ca:	48 98                	cdqe
     5cc:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     5d1:	48 89 c2             	mov    rdx,rax
     5d4:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
     5d8:	48 01 d0             	add    rax,rdx
     5db:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						}
				}
				str++;
     5df:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
		while (1) {
     5e4:	e9 88 fe ff ff       	jmp    471 <strtol+0x11c>
		}
}
     5e9:	c9                   	leave
     5ea:	c3                   	ret

00000000000005eb <atoi>:

int atoi(const char* str)
{
     5eb:	55                   	push   rbp
     5ec:	48 89 e5             	mov    rbp,rsp
     5ef:	48 83 ec 18          	sub    rsp,0x18
     5f3:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		unsigned int rv = 0, isN = 0;
     5f7:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     5fe:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
		if (!str)
     605:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     60a:	75 0f                	jne    61b <atoi+0x30>
				return 0;
     60c:	b8 00 00 00 00       	mov    eax,0x0
     611:	e9 9a 00 00 00       	jmp    6b0 <atoi+0xc5>
		while (isspace(*str))
				str++;
     616:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
		while (isspace(*str))
     61b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     61f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     622:	0f be c0             	movsx  eax,al
     625:	89 c7                	mov    edi,eax
     627:	e8 00 00 00 00       	call   62c <atoi+0x41>
     62c:	85 c0                	test   eax,eax
     62e:	75 e6                	jne    616 <atoi+0x2b>
		if (*str == '-') {
     630:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     634:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     637:	3c 2d                	cmp    al,0x2d
     639:	75 0e                	jne    649 <atoi+0x5e>
				isN = 1;
     63b:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [rbp-0x8],0x1
				str++;
     642:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     647:	eb 3b                	jmp    684 <atoi+0x99>
		} else if (*str == '+')
     649:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     64d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     650:	3c 2b                	cmp    al,0x2b
     652:	75 30                	jne    684 <atoi+0x99>
				str++;
     654:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
		while (*str >= '0' && *str <= '9') {
     659:	eb 29                	jmp    684 <atoi+0x99>
				rv *= 10;
     65b:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     65e:	89 d0                	mov    eax,edx
     660:	c1 e0 02             	shl    eax,0x2
     663:	01 d0                	add    eax,edx
     665:	01 c0                	add    eax,eax
     667:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				rv += *str - '0';
     66a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     66e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     671:	0f be d0             	movsx  edx,al
     674:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     677:	01 d0                	add    eax,edx
     679:	83 e8 30             	sub    eax,0x30
     67c:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				str++;
     67f:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
		while (*str >= '0' && *str <= '9') {
     684:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     688:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     68b:	3c 2f                	cmp    al,0x2f
     68d:	7e 0b                	jle    69a <atoi+0xaf>
     68f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     693:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     696:	3c 39                	cmp    al,0x39
     698:	7e c1                	jle    65b <atoi+0x70>
		}
		if (isN && rv)
     69a:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     69e:	74 0d                	je     6ad <atoi+0xc2>
     6a0:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     6a4:	74 07                	je     6ad <atoi+0xc2>
				return (int)-rv;
     6a6:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     6a9:	f7 d8                	neg    eax
     6ab:	eb 03                	jmp    6b0 <atoi+0xc5>
		else
				return (int)rv;
     6ad:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]

}
     6b0:	c9                   	leave
     6b1:	c3                   	ret

00000000000006b2 <strchr>:

char* strchr(const char* str, int character)
{
     6b2:	55                   	push   rbp
     6b3:	48 89 e5             	mov    rbp,rsp
     6b6:	48 83 ec 10          	sub    rsp,0x10
     6ba:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     6be:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
		if (!str)
     6c1:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     6c6:	75 1e                	jne    6e6 <strchr+0x34>
				return NULL;
     6c8:	b8 00 00 00 00       	mov    eax,0x0
     6cd:	eb 29                	jmp    6f8 <strchr+0x46>
		while (*str != (char)character)
				if (*str == '\0')
     6cf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     6d3:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     6d6:	84 c0                	test   al,al
     6d8:	75 07                	jne    6e1 <strchr+0x2f>
						return NULL;
     6da:	b8 00 00 00 00       	mov    eax,0x0
     6df:	eb 17                	jmp    6f8 <strchr+0x46>
				else
						str++;
     6e1:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
		while (*str != (char)character)
     6e6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     6ea:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     6ed:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     6f0:	38 d0                	cmp    al,dl
     6f2:	75 db                	jne    6cf <strchr+0x1d>
		return (char*)str;
     6f4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
     6f8:	c9                   	leave
     6f9:	c3                   	ret

00000000000006fa <strndup>:

char* strndup(const char* s, size_t n)
{
     6fa:	55                   	push   rbp
     6fb:	48 89 e5             	mov    rbp,rsp
     6fe:	48 83 ec 20          	sub    rsp,0x20
     702:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     706:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		size_t l; char* rv;
		if (!s)
     70a:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     70f:	75 0a                	jne    71b <strndup+0x21>
				return NULL;
     711:	b8 00 00 00 00       	mov    eax,0x0
     716:	e9 95 00 00 00       	jmp    7b0 <strndup+0xb6>
		l = strlen(s);
     71b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     71f:	48 89 c7             	mov    rdi,rax
     722:	e8 00 00 00 00       	call   727 <strndup+0x2d>
     727:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		rv = kmalloc(1 + (l = min(l, n)));
     72b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     72f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     733:	48 39 c2             	cmp    rdx,rax
     736:	48 0f 46 c2          	cmovbe rax,rdx
     73a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     73e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     742:	48 83 c0 01          	add    rax,0x1
     746:	48 89 c7             	mov    rdi,rax
     749:	e8 00 00 00 00       	call   74e <strndup+0x54>
     74e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!rv) {
     752:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     757:	75 11                	jne    76a <strndup+0x70>
				errno = ENOMEM;
     759:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # 763 <strndup+0x69>
				return NULL;
     763:	b8 00 00 00 00       	mov    eax,0x0
     768:	eb 46                	jmp    7b0 <strndup+0xb6>
		}
		for (n = 0; n < l; n++)
     76a:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     772:	eb 20                	jmp    794 <strndup+0x9a>
				rv[n] = s[n];
     774:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     778:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     77c:	48 01 d0             	add    rax,rdx
     77f:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     783:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     787:	48 01 ca             	add    rdx,rcx
     78a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     78d:	88 02                	mov    BYTE PTR [rdx],al
		for (n = 0; n < l; n++)
     78f:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
     794:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     798:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
     79c:	72 d6                	jb     774 <strndup+0x7a>
		rv[n] = '\0';
     79e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     7a2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     7a6:	48 01 d0             	add    rax,rdx
     7a9:	c6 00 00             	mov    BYTE PTR [rax],0x0
		return rv;
     7ac:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
     7b0:	c9                   	leave
     7b1:	c3                   	ret

00000000000007b2 <strdup>:

char* strdup(const char* s)
{
     7b2:	55                   	push   rbp
     7b3:	48 89 e5             	mov    rbp,rsp
     7b6:	48 83 ec 30          	sub    rsp,0x30
     7ba:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		char* rv; size_t l, n;
		if (!s)
     7be:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     7c3:	75 07                	jne    7cc <strdup+0x1a>
				return NULL;
     7c5:	b8 00 00 00 00       	mov    eax,0x0
     7ca:	eb 6a                	jmp    836 <strdup+0x84>
		l = strlen(s) + 1;
     7cc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     7d0:	48 89 c7             	mov    rdi,rax
     7d3:	e8 00 00 00 00       	call   7d8 <strdup+0x26>
     7d8:	48 83 c0 01          	add    rax,0x1
     7dc:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		rv = kmalloc(l);
     7e0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     7e4:	48 89 c7             	mov    rdi,rax
     7e7:	e8 00 00 00 00       	call   7ec <strdup+0x3a>
     7ec:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		for (n = 0; n < l; n++)
     7f0:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     7f8:	eb 20                	jmp    81a <strdup+0x68>
				rv[n] = s[n];
     7fa:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     7fe:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     802:	48 01 d0             	add    rax,rdx
     805:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
     809:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     80d:	48 01 ca             	add    rdx,rcx
     810:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     813:	88 02                	mov    BYTE PTR [rdx],al
		for (n = 0; n < l; n++)
     815:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     81a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     81e:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
     822:	72 d6                	jb     7fa <strdup+0x48>
		rv[n] = '\0';
     824:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     828:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     82c:	48 01 d0             	add    rax,rdx
     82f:	c6 00 00             	mov    BYTE PTR [rax],0x0
		return rv;
     832:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
     836:	c9                   	leave
     837:	c3                   	ret

0000000000000838 <strncpy>:

char* strncpy(char* dest, const char* src, size_t n)
{
     838:	55                   	push   rbp
     839:	48 89 e5             	mov    rbp,rsp
     83c:	48 83 ec 28          	sub    rsp,0x28
     840:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     844:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
     848:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		size_t i;
		if (!dest)
     84c:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     851:	75 07                	jne    85a <strncpy+0x22>
				return NULL;
     853:	b8 00 00 00 00       	mov    eax,0x0
     858:	eb 67                	jmp    8c1 <strncpy+0x89>
		for (i = 0; i < n; i++) {
     85a:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     862:	eb 4f                	jmp    8b3 <strncpy+0x7b>
				dest[i] = src ? *src : '\0';
     864:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     869:	74 09                	je     874 <strncpy+0x3c>
     86b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     86f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     872:	eb 05                	jmp    879 <strncpy+0x41>
     874:	b8 00 00 00 00       	mov    eax,0x0
     879:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
     87d:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     881:	48 01 ca             	add    rdx,rcx
     884:	88 02                	mov    BYTE PTR [rdx],al
				if (src && !(*src))
     886:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     88b:	74 15                	je     8a2 <strncpy+0x6a>
     88d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     891:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     894:	84 c0                	test   al,al
     896:	75 0a                	jne    8a2 <strncpy+0x6a>
						src = NULL;
     898:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     8a0:	eb 0c                	jmp    8ae <strncpy+0x76>
				else if (src)
     8a2:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     8a7:	74 05                	je     8ae <strncpy+0x76>
						src++;
     8a9:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
		for (i = 0; i < n; i++) {
     8ae:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     8b3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     8b7:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
     8bb:	72 a7                	jb     864 <strncpy+0x2c>
		}
		return dest;
     8bd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
     8c1:	c9                   	leave
     8c2:	c3                   	ret

00000000000008c3 <strcpy>:

char* strcpy(char* dest, char* src)
{
     8c3:	55                   	push   rbp
     8c4:	48 89 e5             	mov    rbp,rsp
     8c7:	48 83 ec 20          	sub    rsp,0x20
     8cb:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     8cf:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		char* rv = dest;
     8d3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     8d7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!dest || !src)
     8db:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     8e0:	74 07                	je     8e9 <strcpy+0x26>
     8e2:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     8e7:	75 07                	jne    8f0 <strcpy+0x2d>
				return NULL;
     8e9:	b8 00 00 00 00       	mov    eax,0x0
     8ee:	eb 2c                	jmp    91c <strcpy+0x59>
		do {
			*(dest++) = *(src++);
     8f0:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     8f4:	48 8d 42 01          	lea    rax,[rdx+0x1]
     8f8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     8fc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     900:	48 8d 48 01          	lea    rcx,[rax+0x1]
     904:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
     908:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
     90b:	88 10                	mov    BYTE PTR [rax],dl
		} while (*src);
     90d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     911:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     914:	84 c0                	test   al,al
     916:	75 d8                	jne    8f0 <strcpy+0x2d>
		return rv;
     918:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
     91c:	c9                   	leave
     91d:	c3                   	ret

000000000000091e <strtok_r>:

char* strtok_r(char* str, const char* delim, char** saveptr)
{
     91e:	55                   	push   rbp
     91f:	48 89 e5             	mov    rbp,rsp
     922:	48 83 ec 38          	sub    rsp,0x38
     926:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     92a:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
     92e:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
		size_t l = strlen(delim);
     932:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     936:	48 89 c7             	mov    rdi,rax
     939:	e8 00 00 00 00       	call   93e <strtok_r+0x20>
     93e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (str)
     942:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     947:	74 0b                	je     954 <strtok_r+0x36>
				*saveptr = str;
     949:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     94d:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     951:	48 89 10             	mov    QWORD PTR [rax],rdx
		str = *saveptr;
     954:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     958:	48 8b 00             	mov    rax,QWORD PTR [rax]
     95b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		if (!l) { /* return full token only once */
     95f:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     964:	0f 85 97 00 00 00    	jne    a01 <strtok_r+0xe3>
				*saveptr = NULL;
     96a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     96e:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				return str;
     975:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     979:	e9 c0 00 00 00       	jmp    a3e <strtok_r+0x120>
		}
		while (*str) {
				for (size_t i = 0; i < l; i++)
     97e:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     986:	eb 6a                	jmp    9f2 <strtok_r+0xd4>
						if (*str == delim[i]) {
     988:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     98c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     98f:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
     993:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     997:	48 01 c8             	add    rax,rcx
     99a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     99d:	38 c2                	cmp    dl,al
     99f:	75 4c                	jne    9ed <strtok_r+0xcf>
								*str = '\0';
     9a1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9a5:	c6 00 00             	mov    BYTE PTR [rax],0x0
								if (strlen(*saveptr)) {
     9a8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     9ac:	48 8b 00             	mov    rax,QWORD PTR [rax]
     9af:	48 89 c7             	mov    rdi,rax
     9b2:	e8 00 00 00 00       	call   9b7 <strtok_r+0x99>
     9b7:	48 85 c0             	test   rax,rax
     9ba:	74 20                	je     9dc <strtok_r+0xbe>
										char* rv = *saveptr;
     9bc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     9c0:	48 8b 00             	mov    rax,QWORD PTR [rax]
     9c3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
										*saveptr = str + 1;
     9c7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9cb:	48 8d 50 01          	lea    rdx,[rax+0x1]
     9cf:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     9d3:	48 89 10             	mov    QWORD PTR [rax],rdx
										return rv;
     9d6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     9da:	eb 62                	jmp    a3e <strtok_r+0x120>
								} else
										*saveptr = str + 1;
     9dc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9e0:	48 8d 50 01          	lea    rdx,[rax+0x1]
     9e4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     9e8:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     9eb:	eb 0f                	jmp    9fc <strtok_r+0xde>
				for (size_t i = 0; i < l; i++)
     9ed:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     9f2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9f6:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
     9fa:	72 8c                	jb     988 <strtok_r+0x6a>
						}
				str++;
     9fc:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
		while (*str) {
     a01:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a05:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     a08:	84 c0                	test   al,al
     a0a:	0f 85 6e ff ff ff    	jne    97e <strtok_r+0x60>
		}
		/* in case of no delims return full token once */
		if (str == *saveptr)
     a10:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a14:	48 8b 00             	mov    rax,QWORD PTR [rax]
     a17:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
     a1b:	75 07                	jne    a24 <strtok_r+0x106>
				return NULL;
     a1d:	b8 00 00 00 00       	mov    eax,0x0
     a22:	eb 1a                	jmp    a3e <strtok_r+0x120>
		else {
				char* rv = *saveptr;
     a24:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a28:	48 8b 00             	mov    rax,QWORD PTR [rax]
     a2b:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				*saveptr = str;
     a2f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a33:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     a37:	48 89 10             	mov    QWORD PTR [rax],rdx
				return rv;
     a3a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
		}
}
     a3e:	c9                   	leave
     a3f:	c3                   	ret

0000000000000a40 <strtok>:

char* strtok(char* str, const char* delim)
{
     a40:	55                   	push   rbp
     a41:	48 89 e5             	mov    rbp,rsp
     a44:	48 83 ec 10          	sub    rsp,0x10
     a48:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     a4c:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		static char* ptr;
		return strtok_r(str, delim, &ptr);
     a50:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     a54:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a58:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     a5f:	48 89 ce             	mov    rsi,rcx
     a62:	48 89 c7             	mov    rdi,rax
     a65:	e8 00 00 00 00       	call   a6a <strtok+0x2a>
}
     a6a:	c9                   	leave
     a6b:	c3                   	ret

0000000000000a6c <asctime_r>:

char* asctime_r(const struct tm* timep, char* result)
{
     a6c:	55                   	push   rbp
     a6d:	48 89 e5             	mov    rbp,rsp
     a70:	48 83 ec 40          	sub    rsp,0x40
     a74:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     a78:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		};
		static char mon_name[12][3] = {
			"Jan", "Feb", "Mar", "Apr", "May", "Jun",
			"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
		};
		char zerobt = 0;
     a7c:	c6 45 ff 00          	mov    BYTE PTR [rbp-0x1],0x0
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
			wday_name[timep->tm_wday],
			mon_name[timep->tm_mon],
			timep->tm_mday, timep->tm_hour,
			timep->tm_min, timep->tm_sec,
			1900 + timep->tm_year);
     a80:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a84:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
     a87:	44 8d 80 6c 07 00 00 	lea    r8d,[rax+0x76c]
			timep->tm_min, timep->tm_sec,
     a8e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a92:	8b 38                	mov    edi,DWORD PTR [rax]
     a94:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a98:	8b 70 04             	mov    esi,DWORD PTR [rax+0x4]
			timep->tm_mday, timep->tm_hour,
     a9b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a9f:	44 8b 48 08          	mov    r9d,DWORD PTR [rax+0x8]
     aa3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     aa7:	44 8b 50 0c          	mov    r10d,DWORD PTR [rax+0xc]
			mon_name[timep->tm_mon],
     aab:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     aaf:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     ab2:	48 63 d0             	movsxd rdx,eax
     ab5:	48 89 d0             	mov    rax,rdx
     ab8:	48 01 c0             	add    rax,rax
     abb:	48 01 d0             	add    rax,rdx
     abe:	48 8d 88 00 00 00 00 	lea    rcx,[rax+0x0]
			wday_name[timep->tm_wday],
     ac5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ac9:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     acc:	48 63 d0             	movsxd rdx,eax
     acf:	48 89 d0             	mov    rax,rdx
     ad2:	48 01 c0             	add    rax,rax
     ad5:	48 01 d0             	add    rax,rdx
     ad8:	48 8d 90 00 00 00 00 	lea    rdx,[rax+0x0]
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
     adf:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     ae3:	44 89 44 24 10       	mov    DWORD PTR [rsp+0x10],r8d
     ae8:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
     aec:	89 34 24             	mov    DWORD PTR [rsp],esi
     aef:	45 89 d0             	mov    r8d,r10d
     af2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     af9:	48 89 c7             	mov    rdi,rax
     afc:	b8 00 00 00 00       	mov    eax,0x0
     b01:	e8 00 00 00 00       	call   b06 <asctime_r+0x9a>
		return result;
     b06:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
}
     b0a:	c9                   	leave
     b0b:	c3                   	ret

0000000000000b0c <asctime>:

char* asctime(const struct tm* timep)
{
     b0c:	55                   	push   rbp
     b0d:	48 89 e5             	mov    rbp,rsp
     b10:	48 83 ec 10          	sub    rsp,0x10
     b14:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		static char result[26];
		return asctime_r(timep, result);
     b18:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b1c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     b23:	48 89 c7             	mov    rdi,rax
     b26:	e8 00 00 00 00       	call   b2b <asctime+0x1f>
}
     b2b:	c9                   	leave
     b2c:	c3                   	ret

0000000000000b2d <ctime>:

char* ctime(const time_t* timep)
{
     b2d:	55                   	push   rbp
     b2e:	48 89 e5             	mov    rbp,rsp
     b31:	48 83 ec 10          	sub    rsp,0x10
     b35:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		return asctime(localtime(timep));
     b39:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b3d:	48 89 c7             	mov    rdi,rax
     b40:	e8 00 00 00 00       	call   b45 <ctime+0x18>
     b45:	48 89 c7             	mov    rdi,rax
     b48:	e8 00 00 00 00       	call   b4d <ctime+0x20>
}
     b4d:	c9                   	leave
     b4e:	c3                   	ret

0000000000000b4f <ctime_r>:

char* ctime_r(const time_t* timep, char* result)
{
     b4f:	55                   	push   rbp
     b50:	48 89 e5             	mov    rbp,rsp
     b53:	48 83 ec 10          	sub    rsp,0x10
     b57:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     b5b:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		return asctime_r(localtime(timep), result);
     b5f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b63:	48 89 c7             	mov    rdi,rax
     b66:	e8 00 00 00 00       	call   b6b <ctime_r+0x1c>
     b6b:	48 89 c2             	mov    rdx,rax
     b6e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b72:	48 89 c6             	mov    rsi,rax
     b75:	48 89 d7             	mov    rdi,rdx
     b78:	e8 00 00 00 00       	call   b7d <ctime_r+0x2e>
}
     b7d:	c9                   	leave
     b7e:	c3                   	ret

0000000000000b7f <time>:

time_t time(time_t* timep)
{
     b7f:	55                   	push   rbp
     b80:	48 89 e5             	mov    rbp,rsp
     b83:	48 83 ec 08          	sub    rsp,0x8
     b87:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
}
     b8b:	90                   	nop
     b8c:	c9                   	leave
     b8d:	c3                   	ret

0000000000000b8e <mktime>:

time_t mktime(struct tm* timep)
{
     b8e:	55                   	push   rbp
     b8f:	48 89 e5             	mov    rbp,rsp
     b92:	48 83 ec 08          	sub    rsp,0x8
     b96:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
}
     b9a:	90                   	nop
     b9b:	c9                   	leave
     b9c:	c3                   	ret

0000000000000b9d <gmtime_r>:

#define COUNT_LEAPS(Y)   ( ((Y)-1)/4 - ((Y)-1)/100 + ((Y)-1)/400 )
#define COUNT_DAYS(Y)  ( ((Y)-1)*365 + COUNT_LEAPS(Y) )
#define IS_LEAP_YEAR(Y)     ( ((Y)>0) && !((Y)%4) && ( ((Y)%100) || !((Y)%400) ) )
struct tm* gmtime_r(const time_t* timep, struct tm* result)
{
     b9d:	55                   	push   rbp
     b9e:	48 89 e5             	mov    rbp,rsp
     ba1:	48 83 ec 40          	sub    rsp,0x40
     ba5:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     ba9:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		int dayct = *timep / 86400, isl, rem;
     bad:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     bb1:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     bb4:	48 ba 57 29 51 ce a0 c8 45 18 	movabs rdx,0x1845c8a0ce512957
     bbe:	48 89 c8             	mov    rax,rcx
     bc1:	48 f7 ea             	imul   rdx
     bc4:	48 89 d0             	mov    rax,rdx
     bc7:	48 c1 f8 0d          	sar    rax,0xd
     bcb:	48 c1 f9 3f          	sar    rcx,0x3f
     bcf:	48 89 ca             	mov    rdx,rcx
     bd2:	48 29 d0             	sub    rax,rdx
     bd5:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		*result = (struct tm){0};
     bd8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     bdc:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
     be3:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
     beb:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
     bf3:	48 c7 40 18 00 00 00 00 	mov    QWORD PTR [rax+0x18],0x0
     bfb:	c7 40 20 00 00 00 00 	mov    DWORD PTR [rax+0x20],0x0
		result->tm_wday = (dayct + 4) % 7; /* Jan 1 1970 is Thu */
     c02:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     c05:	8d 50 04             	lea    edx,[rax+0x4]
     c08:	48 63 c2             	movsxd rax,edx
     c0b:	48 69 c0 93 24 49 92 	imul   rax,rax,0xffffffff92492493
     c12:	48 c1 e8 20          	shr    rax,0x20
     c16:	01 d0                	add    eax,edx
     c18:	c1 f8 02             	sar    eax,0x2
     c1b:	89 d1                	mov    ecx,edx
     c1d:	c1 f9 1f             	sar    ecx,0x1f
     c20:	29 c8                	sub    eax,ecx
     c22:	89 c1                	mov    ecx,eax
     c24:	c1 e1 03             	shl    ecx,0x3
     c27:	29 c1                	sub    ecx,eax
     c29:	89 d0                	mov    eax,edx
     c2b:	29 c8                	sub    eax,ecx
     c2d:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
     c31:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
     c34:	eb 11                	jmp    c47 <gmtime_r+0xaa>
			result->tm_year++;
     c36:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     c3a:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     c3d:	8d 50 01             	lea    edx,[rax+0x1]
     c40:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     c44:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
     c47:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     c4b:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     c4e:	05 6b 07 00 00       	add    eax,0x76b
     c53:	69 d0 6d 01 00 00    	imul   edx,eax,0x16d
     c59:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     c5d:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     c60:	05 6b 07 00 00       	add    eax,0x76b
     c65:	8d 48 03             	lea    ecx,[rax+0x3]
     c68:	85 c0                	test   eax,eax
     c6a:	0f 48 c1             	cmovs  eax,ecx
     c6d:	c1 f8 02             	sar    eax,0x2
     c70:	89 c6                	mov    esi,eax
     c72:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     c76:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     c79:	05 6b 07 00 00       	add    eax,0x76b
     c7e:	48 63 c8             	movsxd rcx,eax
     c81:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
     c88:	48 c1 e9 20          	shr    rcx,0x20
     c8c:	c1 f9 05             	sar    ecx,0x5
     c8f:	c1 f8 1f             	sar    eax,0x1f
     c92:	29 c8                	sub    eax,ecx
     c94:	01 c6                	add    esi,eax
     c96:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     c9a:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     c9d:	05 6b 07 00 00       	add    eax,0x76b
     ca2:	48 63 c8             	movsxd rcx,eax
     ca5:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
     cac:	48 c1 e9 20          	shr    rcx,0x20
     cb0:	c1 f9 07             	sar    ecx,0x7
     cb3:	c1 f8 1f             	sar    eax,0x1f
     cb6:	29 c1                	sub    ecx,eax
     cb8:	8d 04 0e             	lea    eax,[rsi+rcx*1]
     cbb:	01 d0                	add    eax,edx
     cbd:	2d 3a f9 0a 00       	sub    eax,0xaf93a
     cc2:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
     cc5:	0f 8d 6b ff ff ff    	jge    c36 <gmtime_r+0x99>
		result->tm_year--;
     ccb:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     ccf:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     cd2:	8d 50 ff             	lea    edx,[rax-0x1]
     cd5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     cd9:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		isl = IS_LEAP_YEAR(result->tm_year);
     cdc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     ce0:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     ce3:	85 c0                	test   eax,eax
     ce5:	7e 6c                	jle    d53 <gmtime_r+0x1b6>
     ce7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     ceb:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     cee:	83 e0 03             	and    eax,0x3
     cf1:	85 c0                	test   eax,eax
     cf3:	75 5e                	jne    d53 <gmtime_r+0x1b6>
     cf5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     cf9:	8b 50 14             	mov    edx,DWORD PTR [rax+0x14]
     cfc:	48 63 c2             	movsxd rax,edx
     cff:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
     d06:	48 c1 e8 20          	shr    rax,0x20
     d0a:	c1 f8 05             	sar    eax,0x5
     d0d:	89 d1                	mov    ecx,edx
     d0f:	c1 f9 1f             	sar    ecx,0x1f
     d12:	29 c8                	sub    eax,ecx
     d14:	6b c8 64             	imul   ecx,eax,0x64
     d17:	89 d0                	mov    eax,edx
     d19:	29 c8                	sub    eax,ecx
     d1b:	85 c0                	test   eax,eax
     d1d:	75 2d                	jne    d4c <gmtime_r+0x1af>
     d1f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     d23:	8b 50 14             	mov    edx,DWORD PTR [rax+0x14]
     d26:	48 63 c2             	movsxd rax,edx
     d29:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
     d30:	48 c1 e8 20          	shr    rax,0x20
     d34:	c1 f8 07             	sar    eax,0x7
     d37:	89 d1                	mov    ecx,edx
     d39:	c1 f9 1f             	sar    ecx,0x1f
     d3c:	29 c8                	sub    eax,ecx
     d3e:	69 c8 90 01 00 00    	imul   ecx,eax,0x190
     d44:	89 d0                	mov    eax,edx
     d46:	29 c8                	sub    eax,ecx
     d48:	85 c0                	test   eax,eax
     d4a:	75 07                	jne    d53 <gmtime_r+0x1b6>
     d4c:	b8 01 00 00 00       	mov    eax,0x1
     d51:	eb 05                	jmp    d58 <gmtime_r+0x1bb>
     d53:	b8 00 00 00 00       	mov    eax,0x0
     d58:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		dayct -= COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970);
     d5b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     d5f:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     d62:	05 6b 07 00 00       	add    eax,0x76b
     d67:	69 d0 6d 01 00 00    	imul   edx,eax,0x16d
     d6d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     d71:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     d74:	05 6b 07 00 00       	add    eax,0x76b
     d79:	8d 48 03             	lea    ecx,[rax+0x3]
     d7c:	85 c0                	test   eax,eax
     d7e:	0f 48 c1             	cmovs  eax,ecx
     d81:	c1 f8 02             	sar    eax,0x2
     d84:	89 c6                	mov    esi,eax
     d86:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     d8a:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     d8d:	05 6b 07 00 00       	add    eax,0x76b
     d92:	48 63 c8             	movsxd rcx,eax
     d95:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
     d9c:	48 c1 e9 20          	shr    rcx,0x20
     da0:	c1 f9 05             	sar    ecx,0x5
     da3:	c1 f8 1f             	sar    eax,0x1f
     da6:	29 c8                	sub    eax,ecx
     da8:	01 c6                	add    esi,eax
     daa:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     dae:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
     db1:	05 6b 07 00 00       	add    eax,0x76b
     db6:	48 63 c8             	movsxd rcx,eax
     db9:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
     dc0:	48 c1 e9 20          	shr    rcx,0x20
     dc4:	c1 f9 07             	sar    ecx,0x7
     dc7:	c1 f8 1f             	sar    eax,0x1f
     dca:	29 c1                	sub    ecx,eax
     dcc:	8d 04 0e             	lea    eax,[rsi+rcx*1]
     dcf:	01 d0                	add    eax,edx
     dd1:	2d 3a f9 0a 00       	sub    eax,0xaf93a
     dd6:	29 45 fc             	sub    DWORD PTR [rbp-0x4],eax
		result->tm_yday = dayct;
     dd9:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     ddd:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     de0:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		static const int dayct_nl[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, INT_MAX };
		static const int dayct_lp[] = { 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, INT_MAX };
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
     de3:	eb 11                	jmp    df6 <gmtime_r+0x259>
			result->tm_mon++;
     de5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     de9:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     dec:	8d 50 01             	lea    edx,[rax+0x1]
     def:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     df3:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
     df6:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     dfa:	74 09                	je     e05 <gmtime_r+0x268>
     dfc:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     e03:	eb 07                	jmp    e0c <gmtime_r+0x26f>
     e05:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     e0c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e10:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e13:	48 98                	cdqe
     e15:	48 c1 e0 02          	shl    rax,0x2
     e19:	48 01 d0             	add    rax,rdx
     e1c:	8b 10                	mov    edx,DWORD PTR [rax]
     e1e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e22:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     e25:	39 c2                	cmp    edx,eax
     e27:	7c bc                	jl     de5 <gmtime_r+0x248>
		result->tm_mon--;
     e29:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e2d:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e30:	8d 50 ff             	lea    edx,[rax-0x1]
     e33:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e37:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		dayct -= (isl ? dayct_lp : dayct_nl)[result->tm_mon]; /* 0 based */
     e3a:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     e3e:	74 09                	je     e49 <gmtime_r+0x2ac>
     e40:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     e47:	eb 07                	jmp    e50 <gmtime_r+0x2b3>
     e49:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     e50:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e54:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e57:	48 98                	cdqe
     e59:	48 c1 e0 02          	shl    rax,0x2
     e5d:	48 01 d0             	add    rax,rdx
     e60:	8b 00                	mov    eax,DWORD PTR [rax]
     e62:	29 45 fc             	sub    DWORD PTR [rbp-0x4],eax
		result->tm_mday = dayct + 1; /* 1 based */
     e65:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     e68:	8d 50 01             	lea    edx,[rax+0x1]
     e6b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e6f:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		/* time logic */
		rem = *timep % 86400;
     e72:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     e76:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     e79:	48 ba 57 29 51 ce a0 c8 45 18 	movabs rdx,0x1845c8a0ce512957
     e83:	48 89 c8             	mov    rax,rcx
     e86:	48 f7 ea             	imul   rdx
     e89:	48 89 d0             	mov    rax,rdx
     e8c:	48 c1 f8 0d          	sar    rax,0xd
     e90:	48 89 ca             	mov    rdx,rcx
     e93:	48 c1 fa 3f          	sar    rdx,0x3f
     e97:	48 29 d0             	sub    rax,rdx
     e9a:	48 69 d0 80 51 01 00 	imul   rdx,rax,0x15180
     ea1:	48 89 c8             	mov    rax,rcx
     ea4:	48 29 d0             	sub    rax,rdx
     ea7:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		result->tm_hour = rem / 3600;
     eaa:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     ead:	48 63 d0             	movsxd rdx,eax
     eb0:	48 69 d2 c5 b3 a2 91 	imul   rdx,rdx,0xffffffff91a2b3c5
     eb7:	48 c1 ea 20          	shr    rdx,0x20
     ebb:	01 c2                	add    edx,eax
     ebd:	c1 fa 0b             	sar    edx,0xb
     ec0:	c1 f8 1f             	sar    eax,0x1f
     ec3:	29 c2                	sub    edx,eax
     ec5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     ec9:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		rem %= 3600;
     ecc:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     ecf:	48 63 d0             	movsxd rdx,eax
     ed2:	48 69 d2 c5 b3 a2 91 	imul   rdx,rdx,0xffffffff91a2b3c5
     ed9:	48 c1 ea 20          	shr    rdx,0x20
     edd:	01 c2                	add    edx,eax
     edf:	89 d1                	mov    ecx,edx
     ee1:	c1 f9 0b             	sar    ecx,0xb
     ee4:	99                   	cdq
     ee5:	29 d1                	sub    ecx,edx
     ee7:	69 d1 10 0e 00 00    	imul   edx,ecx,0xe10
     eed:	29 d0                	sub    eax,edx
     eef:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		result->tm_min = rem / 60;
     ef2:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     ef5:	48 63 d0             	movsxd rdx,eax
     ef8:	48 69 d2 89 88 88 88 	imul   rdx,rdx,0xffffffff88888889
     eff:	48 c1 ea 20          	shr    rdx,0x20
     f03:	01 c2                	add    edx,eax
     f05:	c1 fa 05             	sar    edx,0x5
     f08:	c1 f8 1f             	sar    eax,0x1f
     f0b:	29 c2                	sub    edx,eax
     f0d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     f11:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		rem %= 60;
     f14:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     f17:	48 63 d0             	movsxd rdx,eax
     f1a:	48 69 d2 89 88 88 88 	imul   rdx,rdx,0xffffffff88888889
     f21:	48 c1 ea 20          	shr    rdx,0x20
     f25:	01 c2                	add    edx,eax
     f27:	89 d1                	mov    ecx,edx
     f29:	c1 f9 05             	sar    ecx,0x5
     f2c:	99                   	cdq
     f2d:	29 d1                	sub    ecx,edx
     f2f:	6b d1 3c             	imul   edx,ecx,0x3c
     f32:	29 d0                	sub    eax,edx
     f34:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		result->tm_sec = rem;
     f37:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     f3b:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     f3e:	89 10                	mov    DWORD PTR [rax],edx
		/* gmtime isdst=0 */
		return result;
     f40:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
}
     f44:	c9                   	leave
     f45:	c3                   	ret

0000000000000f46 <gmtime>:

struct tm* gmtime(const time_t* timep)
{
     f46:	55                   	push   rbp
     f47:	48 89 e5             	mov    rbp,rsp
     f4a:	48 83 ec 08          	sub    rsp,0x8
     f4e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		static struct tm lts;
		return gmtime_r(timep, &lts);
     f52:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f56:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f5d:	48 89 c7             	mov    rdi,rax
     f60:	e8 00 00 00 00       	call   f65 <gmtime+0x1f>
}
     f65:	c9                   	leave
     f66:	c3                   	ret

0000000000000f67 <localtime_r>:

struct tm* localtime_r(const time_t* timep, struct tm* result)
{
     f67:	55                   	push   rbp
     f68:	48 89 e5             	mov    rbp,rsp
     f6b:	48 83 ec 10          	sub    rsp,0x10
     f6f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     f73:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		/*TODO: +- time_t offset */
		return gmtime_r(timep, result);
     f77:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f7b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f7f:	48 89 d6             	mov    rsi,rdx
     f82:	48 89 c7             	mov    rdi,rax
     f85:	e8 00 00 00 00       	call   f8a <localtime_r+0x23>
}
     f8a:	c9                   	leave
     f8b:	c3                   	ret

0000000000000f8c <localtime>:

struct tm* localtime(const time_t* timep)
{
     f8c:	55                   	push   rbp
     f8d:	48 89 e5             	mov    rbp,rsp
     f90:	48 83 ec 08          	sub    rsp,0x8
     f94:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		static struct tm lts;
		return localtime_r(timep, &lts);
     f98:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f9c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     fa3:	48 89 c7             	mov    rdi,rax
     fa6:	e8 00 00 00 00       	call   fab <localtime+0x1f>
}
     fab:	c9                   	leave
     fac:	c3                   	ret

0000000000000fad <__umoddi3>:
		return q;
}

UDWtype
__umoddi3 (UDWtype u, UDWtype v)
{
     fad:	55                   	push   rbp
     fae:	48 89 e5             	mov    rbp,rsp
     fb1:	48 83 ec 60          	sub    rsp,0x60
     fb5:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     fb9:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
     fbd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     fc1:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     fc5:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     fc9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     fcd:	48 8d 45 b8          	lea    rax,[rbp-0x48]
     fd1:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		UDWtype q = 0, r = n, y = d;
     fd5:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     fdd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fe1:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
     fe5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     fe9:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		if (y <= r)
     fed:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ff1:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
     ff5:	0f 82 b1 00 00 00    	jb     10ac <__umoddi3+0xff>
				lz1 = __builtin_clzll (d);
     ffb:	48 0f bd 45 f0       	bsr    rax,QWORD PTR [rbp-0x10]
    1000:	48 83 f0 3f          	xor    rax,0x3f
    1004:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
				lz2 = __builtin_clzll (n);
    1007:	48 0f bd 45 f8       	bsr    rax,QWORD PTR [rbp-0x8]
    100c:	48 83 f0 3f          	xor    rax,0x3f
    1010:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				k = lz1 - lz2;
    1013:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    1016:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38]
    1019:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				y = (y << k);
    101c:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    101f:	89 c1                	mov    ecx,eax
    1021:	48 d3 65 d0          	shl    QWORD PTR [rbp-0x30],cl
				if (r >= y)
    1025:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1029:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    102d:	72 1c                	jb     104b <__umoddi3+0x9e>
						r = r - y;
    102f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1033:	48 29 45 d8          	sub    QWORD PTR [rbp-0x28],rax
						q =  (1ULL << k);
    1037:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    103a:	ba 01 00 00 00       	mov    edx,0x1
    103f:	89 c1                	mov    ecx,eax
    1041:	48 d3 e2             	shl    rdx,cl
    1044:	48 89 d0             	mov    rax,rdx
    1047:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (k > 0)
    104b:	83 7d c4 00          	cmp    DWORD PTR [rbp-0x3c],0x0
    104f:	74 5b                	je     10ac <__umoddi3+0xff>
						y = y >> 1;
    1051:	48 d1 6d d0          	shr    QWORD PTR [rbp-0x30],1
						i = k;
    1055:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1058:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
								if (r >= y)
    105b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    105f:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    1063:	72 15                	jb     107a <__umoddi3+0xcd>
										r = ((r - y) << 1) + 1;
    1065:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1069:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
    106d:	48 01 c0             	add    rax,rax
    1070:	48 83 c0 01          	add    rax,0x1
    1074:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    1078:	eb 04                	jmp    107e <__umoddi3+0xd1>
										r =  (r << 1);
    107a:	48 d1 65 d8          	shl    QWORD PTR [rbp-0x28],1
								i = i - 1;
    107e:	83 6d c0 01          	sub    DWORD PTR [rbp-0x40],0x1
						} while (i != 0);
    1082:	83 7d c0 00          	cmp    DWORD PTR [rbp-0x40],0x0
    1086:	75 d3                	jne    105b <__umoddi3+0xae>
						q = q + r;
    1088:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    108c:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
						r = r >> k;
    1090:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1093:	89 c1                	mov    ecx,eax
    1095:	48 d3 6d d8          	shr    QWORD PTR [rbp-0x28],cl
						q = q - (r << k);
    1099:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    109c:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    10a0:	89 c1                	mov    ecx,eax
    10a2:	48 d3 e2             	shl    rdx,cl
    10a5:	48 89 d0             	mov    rax,rdx
    10a8:	48 29 45 e0          	sub    QWORD PTR [rbp-0x20],rax
		if (rp)
    10ac:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    10b1:	74 0b                	je     10be <__umoddi3+0x111>
				*rp = r;
    10b3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    10b7:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    10bb:	48 89 10             	mov    QWORD PTR [rax],rdx
		UDWtype w;

		(void) __udivmoddi4 (u, v, &w);

		return w;
    10be:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
}
    10c2:	c9                   	leave
    10c3:	c3                   	ret

00000000000010c4 <__udivdi3>:

UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
    10c4:	55                   	push   rbp
    10c5:	48 89 e5             	mov    rbp,rsp
    10c8:	48 83 ec 50          	sub    rsp,0x50
    10cc:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    10d0:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
    10d4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    10d8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    10dc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    10e0:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    10e4:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		UDWtype q = 0, r = n, y = d;
    10ec:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    10f4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10f8:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    10fc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1100:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		if (y <= r)
    1104:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1108:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    110c:	0f 82 b1 00 00 00    	jb     11c3 <__udivdi3+0xff>
				lz1 = __builtin_clzll (d);
    1112:	48 0f bd 45 f0       	bsr    rax,QWORD PTR [rbp-0x10]
    1117:	48 83 f0 3f          	xor    rax,0x3f
    111b:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
				lz2 = __builtin_clzll (n);
    111e:	48 0f bd 45 f8       	bsr    rax,QWORD PTR [rbp-0x8]
    1123:	48 83 f0 3f          	xor    rax,0x3f
    1127:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				k = lz1 - lz2;
    112a:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    112d:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38]
    1130:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				y = (y << k);
    1133:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1136:	89 c1                	mov    ecx,eax
    1138:	48 d3 65 d0          	shl    QWORD PTR [rbp-0x30],cl
				if (r >= y)
    113c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1140:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    1144:	72 1c                	jb     1162 <__udivdi3+0x9e>
						r = r - y;
    1146:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    114a:	48 29 45 d8          	sub    QWORD PTR [rbp-0x28],rax
						q =  (1ULL << k);
    114e:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1151:	ba 01 00 00 00       	mov    edx,0x1
    1156:	89 c1                	mov    ecx,eax
    1158:	48 d3 e2             	shl    rdx,cl
    115b:	48 89 d0             	mov    rax,rdx
    115e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (k > 0)
    1162:	83 7d c4 00          	cmp    DWORD PTR [rbp-0x3c],0x0
    1166:	74 5b                	je     11c3 <__udivdi3+0xff>
						y = y >> 1;
    1168:	48 d1 6d d0          	shr    QWORD PTR [rbp-0x30],1
						i = k;
    116c:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    116f:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
								if (r >= y)
    1172:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1176:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    117a:	72 15                	jb     1191 <__udivdi3+0xcd>
										r = ((r - y) << 1) + 1;
    117c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1180:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
    1184:	48 01 c0             	add    rax,rax
    1187:	48 83 c0 01          	add    rax,0x1
    118b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    118f:	eb 04                	jmp    1195 <__udivdi3+0xd1>
										r =  (r << 1);
    1191:	48 d1 65 d8          	shl    QWORD PTR [rbp-0x28],1
								i = i - 1;
    1195:	83 6d c0 01          	sub    DWORD PTR [rbp-0x40],0x1
						} while (i != 0);
    1199:	83 7d c0 00          	cmp    DWORD PTR [rbp-0x40],0x0
    119d:	75 d3                	jne    1172 <__udivdi3+0xae>
						q = q + r;
    119f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    11a3:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
						r = r >> k;
    11a7:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    11aa:	89 c1                	mov    ecx,eax
    11ac:	48 d3 6d d8          	shr    QWORD PTR [rbp-0x28],cl
						q = q - (r << k);
    11b0:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    11b3:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    11b7:	89 c1                	mov    ecx,eax
    11b9:	48 d3 e2             	shl    rdx,cl
    11bc:	48 89 d0             	mov    rax,rdx
    11bf:	48 29 45 e0          	sub    QWORD PTR [rbp-0x20],rax
		if (rp)
    11c3:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    11c8:	74 0b                	je     11d5 <__udivdi3+0x111>
				*rp = r;
    11ca:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11ce:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    11d2:	48 89 10             	mov    QWORD PTR [rax],rdx
		return q;
    11d5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
		return __udivmoddi4 (n, d, (UDWtype *) 0);
}
    11d9:	c9                   	leave
    11da:	c3                   	ret

00000000000011db <__moddi3>:

DWtype
__moddi3 (DWtype u, DWtype v)
{
    11db:	55                   	push   rbp
    11dc:	48 89 e5             	mov    rbp,rsp
    11df:	48 83 ec 70          	sub    rsp,0x70
    11e3:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    11e7:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
		Wtype c = 0;
    11eb:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		DWunion uu = {.ll = u};
    11f2:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    11f6:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		DWunion vv = {.ll = v};
    11fa:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    11fe:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		DWtype w;
	
		if (uu.s.high < 0)
    1202:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1205:	85 c0                	test   eax,eax
    1207:	79 0e                	jns    1217 <__moddi3+0x3c>
				c = ~c,
    1209:	f7 55 fc             	not    DWORD PTR [rbp-0x4]
					uu.ll = -uu.ll;
    120c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1210:	48 f7 d8             	neg    rax
    1213:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		if (vv.s.high < 0)
    1217:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    121a:	85 c0                	test   eax,eax
    121c:	79 0b                	jns    1229 <__moddi3+0x4e>
				vv.ll = -vv.ll;
    121e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1222:	48 f7 d8             	neg    rax
    1225:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
	
		(void) __udivmoddi4 (uu.ll, vv.ll, (UDWtype*)&w);
    1229:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    122d:	48 89 c2             	mov    rdx,rax
    1230:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1234:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    1238:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    123c:	48 8d 45 a0          	lea    rax,[rbp-0x60]
    1240:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		UDWtype q = 0, r = n, y = d;
    1244:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    124c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1250:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    1254:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1258:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (y <= r)
    125c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1260:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
    1264:	0f 82 b1 00 00 00    	jb     131b <__moddi3+0x140>
				lz1 = __builtin_clzll (d);
    126a:	48 0f bd 45 e8       	bsr    rax,QWORD PTR [rbp-0x18]
    126f:	48 83 f0 3f          	xor    rax,0x3f
    1273:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				lz2 = __builtin_clzll (n);
    1276:	48 0f bd 45 f0       	bsr    rax,QWORD PTR [rbp-0x10]
    127b:	48 83 f0 3f          	xor    rax,0x3f
    127f:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				k = lz1 - lz2;
    1282:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1285:	2b 45 c0             	sub    eax,DWORD PTR [rbp-0x40]
    1288:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
				y = (y << k);
    128b:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    128e:	89 c1                	mov    ecx,eax
    1290:	48 d3 65 c8          	shl    QWORD PTR [rbp-0x38],cl
				if (r >= y)
    1294:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1298:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
    129c:	72 1c                	jb     12ba <__moddi3+0xdf>
						r = r - y;
    129e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    12a2:	48 29 45 d0          	sub    QWORD PTR [rbp-0x30],rax
						q =  (1ULL << k);
    12a6:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    12a9:	ba 01 00 00 00       	mov    edx,0x1
    12ae:	89 c1                	mov    ecx,eax
    12b0:	48 d3 e2             	shl    rdx,cl
    12b3:	48 89 d0             	mov    rax,rdx
    12b6:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (k > 0)
    12ba:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
    12be:	74 5b                	je     131b <__moddi3+0x140>
						y = y >> 1;
    12c0:	48 d1 6d c8          	shr    QWORD PTR [rbp-0x38],1
						i = k;
    12c4:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    12c7:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
								if (r >= y)
    12ca:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    12ce:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    12d2:	72 15                	jb     12e9 <__moddi3+0x10e>
										r = ((r - y) << 1) + 1;
    12d4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    12d8:	48 2b 45 c8          	sub    rax,QWORD PTR [rbp-0x38]
    12dc:	48 01 c0             	add    rax,rax
    12df:	48 83 c0 01          	add    rax,0x1
    12e3:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    12e7:	eb 04                	jmp    12ed <__moddi3+0x112>
										r =  (r << 1);
    12e9:	48 d1 65 d0          	shl    QWORD PTR [rbp-0x30],1
								i = i - 1;
    12ed:	83 6d b8 01          	sub    DWORD PTR [rbp-0x48],0x1
						} while (i != 0);
    12f1:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
    12f5:	75 d3                	jne    12ca <__moddi3+0xef>
						q = q + r;
    12f7:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    12fb:	48 01 45 d8          	add    QWORD PTR [rbp-0x28],rax
						r = r >> k;
    12ff:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    1302:	89 c1                	mov    ecx,eax
    1304:	48 d3 6d d0          	shr    QWORD PTR [rbp-0x30],cl
						q = q - (r << k);
    1308:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    130b:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    130f:	89 c1                	mov    ecx,eax
    1311:	48 d3 e2             	shl    rdx,cl
    1314:	48 89 d0             	mov    rax,rdx
    1317:	48 29 45 d8          	sub    QWORD PTR [rbp-0x28],rax
		if (rp)
    131b:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    1320:	74 0b                	je     132d <__moddi3+0x152>
				*rp = r;
    1322:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1326:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    132a:	48 89 10             	mov    QWORD PTR [rax],rdx
		if (c)
    132d:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1331:	74 0b                	je     133e <__moddi3+0x163>
				w = -w;
    1333:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1337:	48 f7 d8             	neg    rax
    133a:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
	
		return w;
    133e:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
}
    1342:	c9                   	leave
    1343:	c3                   	ret

0000000000001344 <__divdi3>:

DWtype
__divdi3 (DWtype u, DWtype v)
{
    1344:	55                   	push   rbp
    1345:	48 89 e5             	mov    rbp,rsp
    1348:	48 83 ec 70          	sub    rsp,0x70
    134c:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    1350:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
		Wtype c = 0;
    1354:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		DWunion uu = {.ll = u};
    135b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    135f:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		DWunion vv = {.ll = v};
    1363:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1367:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
		DWtype w;
	
		if (uu.s.high < 0)
    136b:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    136e:	85 c0                	test   eax,eax
    1370:	79 0e                	jns    1380 <__divdi3+0x3c>
				c = ~c,
    1372:	f7 55 fc             	not    DWORD PTR [rbp-0x4]
				  uu.ll = -uu.ll;
    1375:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1379:	48 f7 d8             	neg    rax
    137c:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		if (vv.s.high < 0)
    1380:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1383:	85 c0                	test   eax,eax
    1385:	79 0e                	jns    1395 <__divdi3+0x51>
				c = ~c,
    1387:	f7 55 fc             	not    DWORD PTR [rbp-0x4]
				  vv.ll = -vv.ll;
    138a:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    138e:	48 f7 d8             	neg    rax
    1391:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
	
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
    1395:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1399:	48 89 c2             	mov    rdx,rax
    139c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    13a0:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    13a4:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    13a8:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		UDWtype q = 0, r = n, y = d;
    13b0:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    13b8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13bc:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    13c0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    13c4:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		if (y <= r)
    13c8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    13cc:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    13d0:	0f 82 b1 00 00 00    	jb     1487 <__divdi3+0x143>
				lz1 = __builtin_clzll (d);
    13d6:	48 0f bd 45 e0       	bsr    rax,QWORD PTR [rbp-0x20]
    13db:	48 83 f0 3f          	xor    rax,0x3f
    13df:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
				lz2 = __builtin_clzll (n);
    13e2:	48 0f bd 45 e8       	bsr    rax,QWORD PTR [rbp-0x18]
    13e7:	48 83 f0 3f          	xor    rax,0x3f
    13eb:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
				k = lz1 - lz2;
    13ee:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    13f1:	2b 45 b8             	sub    eax,DWORD PTR [rbp-0x48]
    13f4:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
				y = (y << k);
    13f7:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    13fa:	89 c1                	mov    ecx,eax
    13fc:	48 d3 65 c0          	shl    QWORD PTR [rbp-0x40],cl
				if (r >= y)
    1400:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1404:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    1408:	72 1c                	jb     1426 <__divdi3+0xe2>
						r = r - y;
    140a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    140e:	48 29 45 c8          	sub    QWORD PTR [rbp-0x38],rax
						q =  (1ULL << k);
    1412:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1415:	ba 01 00 00 00       	mov    edx,0x1
    141a:	89 c1                	mov    ecx,eax
    141c:	48 d3 e2             	shl    rdx,cl
    141f:	48 89 d0             	mov    rax,rdx
    1422:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				if (k > 0)
    1426:	83 7d b4 00          	cmp    DWORD PTR [rbp-0x4c],0x0
    142a:	74 5b                	je     1487 <__divdi3+0x143>
						y = y >> 1;
    142c:	48 d1 6d c0          	shr    QWORD PTR [rbp-0x40],1
						i = k;
    1430:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1433:	89 45 b0             	mov    DWORD PTR [rbp-0x50],eax
								if (r >= y)
    1436:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    143a:	48 39 45 c8          	cmp    QWORD PTR [rbp-0x38],rax
    143e:	72 15                	jb     1455 <__divdi3+0x111>
										r = ((r - y) << 1) + 1;
    1440:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1444:	48 2b 45 c0          	sub    rax,QWORD PTR [rbp-0x40]
    1448:	48 01 c0             	add    rax,rax
    144b:	48 83 c0 01          	add    rax,0x1
    144f:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    1453:	eb 04                	jmp    1459 <__divdi3+0x115>
										r =  (r << 1);
    1455:	48 d1 65 c8          	shl    QWORD PTR [rbp-0x38],1
								i = i - 1;
    1459:	83 6d b0 01          	sub    DWORD PTR [rbp-0x50],0x1
						} while (i != 0);
    145d:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
    1461:	75 d3                	jne    1436 <__divdi3+0xf2>
						q = q + r;
    1463:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1467:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
						r = r >> k;
    146b:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    146e:	89 c1                	mov    ecx,eax
    1470:	48 d3 6d c8          	shr    QWORD PTR [rbp-0x38],cl
						q = q - (r << k);
    1474:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1477:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    147b:	89 c1                	mov    ecx,eax
    147d:	48 d3 e2             	shl    rdx,cl
    1480:	48 89 d0             	mov    rax,rdx
    1483:	48 29 45 d0          	sub    QWORD PTR [rbp-0x30],rax
		if (rp)
    1487:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    148c:	74 0b                	je     1499 <__divdi3+0x155>
				*rp = r;
    148e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1492:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1496:	48 89 10             	mov    QWORD PTR [rax],rdx
		return q;
    1499:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
    149d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (c)
    14a1:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    14a5:	74 04                	je     14ab <__divdi3+0x167>
				w = -w;
    14a7:	48 f7 5d f0          	neg    QWORD PTR [rbp-0x10]
	
		return w;
    14ab:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
    14af:	c9                   	leave
    14b0:	c3                   	ret
