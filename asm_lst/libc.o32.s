
libc.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <strlen>:

#include "limits.h"
#include "kernel.h"

size_t strlen(const char* str)
{
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	56                   	push   esi
       4:	53                   	push   ebx
		register const char* s = str;
       5:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
		register size_t rv = 0;
       8:	be 00 00 00 00       	mov    esi,0x0
		if (!s)
       d:	85 db                	test   ebx,ebx
       f:	75 0a                	jne    1b <strlen+0x1b>
				return 0;
      11:	b8 00 00 00 00       	mov    eax,0x0
      16:	eb 11                	jmp    29 <strlen+0x29>
		while (*s++)
				rv++;
      18:	83 c6 01             	add    esi,0x1
		while (*s++)
      1b:	89 d8                	mov    eax,ebx
      1d:	8d 58 01             	lea    ebx,[eax+0x1]
      20:	0f b6 00             	movzx  eax,BYTE PTR [eax]
      23:	84 c0                	test   al,al
      25:	75 f1                	jne    18 <strlen+0x18>
		return rv;
      27:	89 f0                	mov    eax,esi
}
      29:	5b                   	pop    ebx
      2a:	5e                   	pop    esi
      2b:	5d                   	pop    ebp
      2c:	c3                   	ret

0000002d <strcmp>:

int strcmp(const char* p1, const char* p2)
{
      2d:	55                   	push   ebp
      2e:	89 e5                	mov    ebp,esp
      30:	57                   	push   edi
      31:	56                   	push   esi
      32:	53                   	push   ebx
		register const unsigned char* s1 = (const unsigned char*)p1;
      33:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
		register const unsigned char* s2 = (const unsigned char*)p2;
      36:	8b 7d 0c             	mov    edi,DWORD PTR [ebp+0xc]
		register unsigned char c1, c2;
		
		do {
				c1 = (unsigned char)*s1++;
      39:	89 f0                	mov    eax,esi
      3b:	8d 70 01             	lea    esi,[eax+0x1]
      3e:	0f b6 18             	movzx  ebx,BYTE PTR [eax]
				c2 = (unsigned char)*s2++;
      41:	89 f8                	mov    eax,edi
      43:	8d 78 01             	lea    edi,[eax+0x1]
      46:	0f b6 08             	movzx  ecx,BYTE PTR [eax]
      49:	89 c8                	mov    eax,ecx
				if (c1 == '\0')
      4b:	84 db                	test   bl,bl
      4d:	75 0a                	jne    59 <strcmp+0x2c>
						return c1 - c2;
      4f:	0f b6 c3             	movzx  eax,bl
      52:	0f b6 d1             	movzx  edx,cl
      55:	29 d0                	sub    eax,edx
      57:	eb 0e                	jmp    67 <strcmp+0x3a>
		} while (c1 == c2);
      59:	89 c2                	mov    edx,eax
      5b:	38 d3                	cmp    bl,dl
      5d:	74 da                	je     39 <strcmp+0xc>

		return c1 - c2;
      5f:	0f b6 c3             	movzx  eax,bl
      62:	0f b6 d2             	movzx  edx,dl
      65:	29 d0                	sub    eax,edx
}
      67:	5b                   	pop    ebx
      68:	5e                   	pop    esi
      69:	5f                   	pop    edi
      6a:	5d                   	pop    ebp
      6b:	c3                   	ret

0000006c <strncmp>:

int strncmp(const char* p1, const char* p2, size_t num)
{
      6c:	55                   	push   ebp
      6d:	89 e5                	mov    ebp,esp
      6f:	57                   	push   edi
      70:	56                   	push   esi
      71:	53                   	push   ebx
		register const unsigned char* s1 = (const unsigned char*)p1;
      72:	8b 7d 08             	mov    edi,DWORD PTR [ebp+0x8]
		register const unsigned char* s2 = (const unsigned char*)p2;
      75:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      78:	89 c1                	mov    ecx,eax
		register unsigned char c1, c2;
		register size_t n = num;
      7a:	8b 75 10             	mov    esi,DWORD PTR [ebp+0x10]
		
		while (n) {
      7d:	eb 2b                	jmp    aa <strncmp+0x3e>
				c1 = (unsigned char)*s1++;
      7f:	89 f8                	mov    eax,edi
      81:	8d 78 01             	lea    edi,[eax+0x1]
      84:	0f b6 18             	movzx  ebx,BYTE PTR [eax]
				c2 = (unsigned char)*s2++;
      87:	89 c8                	mov    eax,ecx
      89:	8d 50 01             	lea    edx,[eax+0x1]
      8c:	89 d1                	mov    ecx,edx
      8e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
      91:	89 c2                	mov    edx,eax
				if (c1 == '\0' || (c1 != c2))
      93:	84 db                	test   bl,bl
      95:	74 04                	je     9b <strncmp+0x2f>
      97:	38 c3                	cmp    bl,al
      99:	74 0c                	je     a7 <strncmp+0x3b>
						return c1 - c2;
      9b:	0f b6 c3             	movzx  eax,bl
      9e:	89 d1                	mov    ecx,edx
      a0:	0f b6 d1             	movzx  edx,cl
      a3:	29 d0                	sub    eax,edx
      a5:	eb 11                	jmp    b8 <strncmp+0x4c>
				else
						n--;
      a7:	83 ee 01             	sub    esi,0x1
		while (n) {
      aa:	85 f6                	test   esi,esi
      ac:	75 d1                	jne    7f <strncmp+0x13>
		}

		return c1 - c2;
      ae:	0f b6 c3             	movzx  eax,bl
      b1:	89 d1                	mov    ecx,edx
      b3:	0f b6 d1             	movzx  edx,cl
      b6:	29 d0                	sub    eax,edx
}
      b8:	5b                   	pop    ebx
      b9:	5e                   	pop    esi
      ba:	5f                   	pop    edi
      bb:	5d                   	pop    ebp
      bc:	c3                   	ret

000000bd <strstr>:

char* strstr(const char* p1, const char* p2)
{
      bd:	55                   	push   ebp
      be:	89 e5                	mov    ebp,esp
      c0:	56                   	push   esi
      c1:	53                   	push   ebx
		register const unsigned char* s1 = (const unsigned char*)p1;
      c2:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
		register const unsigned char* s2 = (const unsigned char*)p2;
      c5:	8b 5d 0c             	mov    ebx,DWORD PTR [ebp+0xc]
		if (!p1)
      c8:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
      cc:	75 07                	jne    d5 <strstr+0x18>
				return NULL;
      ce:	b8 00 00 00 00       	mov    eax,0x0
      d3:	eb 4a                	jmp    11f <strstr+0x62>
		if (!p2)
      d5:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
      d9:	75 2c                	jne    107 <strstr+0x4a>
				return (char*)p1;
      db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      de:	eb 3f                	jmp    11f <strstr+0x62>
		while (*s1) {
				if (*s1 != *s2) {
      e0:	0f b6 16             	movzx  edx,BYTE PTR [esi]
      e3:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
      e6:	38 c2                	cmp    dl,al
      e8:	74 0b                	je     f5 <strstr+0x38>
						s2 = (const unsigned char*)p2;
      ea:	8b 5d 0c             	mov    ebx,DWORD PTR [ebp+0xc]
						p1 = (const char*)(s1 + 1);
      ed:	8d 46 01             	lea    eax,[esi+0x1]
      f0:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
      f3:	eb 0c                	jmp    101 <strstr+0x44>
				} else if (!*s2)
      f5:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
      f8:	84 c0                	test   al,al
      fa:	75 05                	jne    101 <strstr+0x44>
						return (char*)p1;
      fc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      ff:	eb 1e                	jmp    11f <strstr+0x62>
				s1++; s2++;
     101:	83 c6 01             	add    esi,0x1
     104:	83 c3 01             	add    ebx,0x1
		while (*s1) {
     107:	0f b6 06             	movzx  eax,BYTE PTR [esi]
     10a:	84 c0                	test   al,al
     10c:	75 d2                	jne    e0 <strstr+0x23>
		}
		return (*s2) ?  NULL : (char*)p1;
     10e:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
     111:	84 c0                	test   al,al
     113:	75 05                	jne    11a <strstr+0x5d>
     115:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     118:	eb 05                	jmp    11f <strstr+0x62>
     11a:	b8 00 00 00 00       	mov    eax,0x0
}
     11f:	5b                   	pop    ebx
     120:	5e                   	pop    esi
     121:	5d                   	pop    ebp
     122:	c3                   	ret

00000123 <bzero>:

void bzero(void* ptr, size_t s)
{
     123:	55                   	push   ebp
     124:	89 e5                	mov    ebp,esp
     126:	53                   	push   ebx
		register uint8_t* p = (uint8_t*)ptr;
     127:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
		if (s >= 8) {
     12a:	83 7d 0c 07          	cmp    DWORD PTR [ebp+0xc],0x7
     12e:	76 36                	jbe    166 <bzero+0x43>
				/* first align to dword boundary */
				while ((size_t)p % 4) {
     130:	eb 0c                	jmp    13e <bzero+0x1b>
						*p++ = 0;
     132:	89 d8                	mov    eax,ebx
     134:	8d 58 01             	lea    ebx,[eax+0x1]
     137:	c6 00 00             	mov    BYTE PTR [eax],0x0
						s--;
     13a:	83 6d 0c 01          	sub    DWORD PTR [ebp+0xc],0x1
				while ((size_t)p % 4) {
     13e:	89 d8                	mov    eax,ebx
     140:	83 e0 03             	and    eax,0x3
     143:	85 c0                	test   eax,eax
     145:	75 eb                	jne    132 <bzero+0xf>
				}
				/* now clear uint32_t-sized blocks */
				while (s >= 4) {
     147:	eb 0d                	jmp    156 <bzero+0x33>
						*(uint32_t*)p = 0;
     149:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
						p += 4;
     14f:	83 c3 04             	add    ebx,0x4
						s -= 4;
     152:	83 6d 0c 04          	sub    DWORD PTR [ebp+0xc],0x4
				while (s >= 4) {
     156:	83 7d 0c 03          	cmp    DWORD PTR [ebp+0xc],0x3
     15a:	77 ed                	ja     149 <bzero+0x26>
				}
		}
		/* set remaining memory */
		while (s--)
     15c:	eb 08                	jmp    166 <bzero+0x43>
				*p++ = 0;
     15e:	89 d8                	mov    eax,ebx
     160:	8d 58 01             	lea    ebx,[eax+0x1]
     163:	c6 00 00             	mov    BYTE PTR [eax],0x0
		while (s--)
     166:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     169:	8d 50 ff             	lea    edx,[eax-0x1]
     16c:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     16f:	85 c0                	test   eax,eax
     171:	75 eb                	jne    15e <bzero+0x3b>
}
     173:	90                   	nop
     174:	90                   	nop
     175:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     178:	c9                   	leave
     179:	c3                   	ret

0000017a <memmove>:

void* memmove(void* dest, const void* src, size_t len)
{
     17a:	55                   	push   ebp
     17b:	89 e5                	mov    ebp,esp
     17d:	56                   	push   esi
     17e:	53                   	push   ebx
		register uint8_t* p = (uint8_t*)dest;
     17f:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
		register uint8_t* s = (uint8_t*)src;
     182:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
		if (((size_t)__builtin_abs(dest - src)) >= len) { /* FWD copy */
     185:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     188:	2b 45 0c             	sub    eax,DWORD PTR [ebp+0xc]
     18b:	89 c2                	mov    edx,eax
     18d:	f7 da                	neg    edx
     18f:	0f 49 c2             	cmovns eax,edx
     192:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
     195:	72 20                	jb     1b7 <memmove+0x3d>
			while (len--)
     197:	eb 0f                	jmp    1a8 <memmove+0x2e>
					*p++ = *s++;
     199:	89 f2                	mov    edx,esi
     19b:	8d 72 01             	lea    esi,[edx+0x1]
     19e:	89 d8                	mov    eax,ebx
     1a0:	8d 58 01             	lea    ebx,[eax+0x1]
     1a3:	0f b6 12             	movzx  edx,BYTE PTR [edx]
     1a6:	88 10                	mov    BYTE PTR [eax],dl
			while (len--)
     1a8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     1ab:	8d 50 ff             	lea    edx,[eax-0x1]
     1ae:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     1b1:	85 c0                	test   eax,eax
     1b3:	75 e4                	jne    199 <memmove+0x1f>
     1b5:	eb 26                	jmp    1dd <memmove+0x63>
		} else {
				dest += len;
     1b7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     1ba:	01 45 08             	add    DWORD PTR [ebp+0x8],eax
				src += len;
     1bd:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     1c0:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
				while (len--)
     1c3:	eb 0b                	jmp    1d0 <memmove+0x56>
						*--p = *--s;
     1c5:	83 ee 01             	sub    esi,0x1
     1c8:	83 eb 01             	sub    ebx,0x1
     1cb:	0f b6 06             	movzx  eax,BYTE PTR [esi]
     1ce:	88 03                	mov    BYTE PTR [ebx],al
				while (len--)
     1d0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     1d3:	8d 50 ff             	lea    edx,[eax-0x1]
     1d6:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     1d9:	85 c0                	test   eax,eax
     1db:	75 e8                	jne    1c5 <memmove+0x4b>
		}
		return dest;
     1dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
     1e0:	5b                   	pop    ebx
     1e1:	5e                   	pop    esi
     1e2:	5d                   	pop    ebp
     1e3:	c3                   	ret

000001e4 <memset>:

void* memset(void* ptr, int value, size_t num)
{
     1e4:	55                   	push   ebp
     1e5:	89 e5                	mov    ebp,esp
     1e7:	53                   	push   ebx
		register uint8_t* p = (uint8_t*)ptr;
     1e8:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
		while (num--)
     1eb:	eb 0a                	jmp    1f7 <memset+0x13>
				*p++ = (uint8_t)value;
     1ed:	89 d8                	mov    eax,ebx
     1ef:	8d 58 01             	lea    ebx,[eax+0x1]
     1f2:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     1f5:	88 10                	mov    BYTE PTR [eax],dl
		while (num--)
     1f7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     1fa:	8d 50 ff             	lea    edx,[eax-0x1]
     1fd:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     200:	85 c0                	test   eax,eax
     202:	75 e9                	jne    1ed <memset+0x9>
		return ptr;
     204:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
     207:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     20a:	c9                   	leave
     20b:	c3                   	ret

0000020c <isspace>:

int isspace(int c)
{
     20c:	55                   	push   ebp
     20d:	89 e5                	mov    ebp,esp
		return (c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r');
     20f:	83 7d 08 20          	cmp    DWORD PTR [ebp+0x8],0x20
     213:	74 1e                	je     233 <isspace+0x27>
     215:	83 7d 08 09          	cmp    DWORD PTR [ebp+0x8],0x9
     219:	74 18                	je     233 <isspace+0x27>
     21b:	83 7d 08 0a          	cmp    DWORD PTR [ebp+0x8],0xa
     21f:	74 12                	je     233 <isspace+0x27>
     221:	83 7d 08 0b          	cmp    DWORD PTR [ebp+0x8],0xb
     225:	74 0c                	je     233 <isspace+0x27>
     227:	83 7d 08 0c          	cmp    DWORD PTR [ebp+0x8],0xc
     22b:	74 06                	je     233 <isspace+0x27>
     22d:	83 7d 08 0d          	cmp    DWORD PTR [ebp+0x8],0xd
     231:	75 07                	jne    23a <isspace+0x2e>
     233:	b8 01 00 00 00       	mov    eax,0x1
     238:	eb 05                	jmp    23f <isspace+0x33>
     23a:	b8 00 00 00 00       	mov    eax,0x0
}
     23f:	5d                   	pop    ebp
     240:	c3                   	ret

00000241 <isprint>:

int isprint(int c)
{
     241:	55                   	push   ebp
     242:	89 e5                	mov    ebp,esp
		if (c > 0x1f && c < 0x7f)
     244:	83 7d 08 1f          	cmp    DWORD PTR [ebp+0x8],0x1f
     248:	7e 0d                	jle    257 <isprint+0x16>
     24a:	83 7d 08 7e          	cmp    DWORD PTR [ebp+0x8],0x7e
     24e:	7f 07                	jg     257 <isprint+0x16>
				return 1;
     250:	b8 01 00 00 00       	mov    eax,0x1
     255:	eb 05                	jmp    25c <isprint+0x1b>
		return 0;
     257:	b8 00 00 00 00       	mov    eax,0x0
}
     25c:	5d                   	pop    ebp
     25d:	c3                   	ret

0000025e <strtol>:

long int strtol(const char* str, char** endptr, int base)
{
     25e:	55                   	push   ebp
     25f:	89 e5                	mov    ebp,esp
     261:	83 ec 10             	sub    esp,0x10
		unsigned long int rv = 0, isN = 0;
     264:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     26b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		char num_max, char_max, char2_max;
		if (!str || base > 32 || base < 0 || base == 1) {
     272:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     276:	74 12                	je     28a <strtol+0x2c>
     278:	83 7d 10 20          	cmp    DWORD PTR [ebp+0x10],0x20
     27c:	7f 0c                	jg     28a <strtol+0x2c>
     27e:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     282:	78 06                	js     28a <strtol+0x2c>
     284:	83 7d 10 01          	cmp    DWORD PTR [ebp+0x10],0x1
     288:	75 18                	jne    2a2 <strtol+0x44>
				errno = EINVAL;
     28a:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return 0L;
     294:	b8 00 00 00 00       	mov    eax,0x0
     299:	e9 f2 01 00 00       	jmp    490 <strtol+0x232>
		}
		while (isspace(*str))
				str++;
     29e:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (isspace(*str))
     2a2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2a5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2a8:	0f be c0             	movsx  eax,al
     2ab:	50                   	push   eax
     2ac:	e8 fc ff ff ff       	call   2ad <strtol+0x4f>
     2b1:	83 c4 04             	add    esp,0x4
     2b4:	85 c0                	test   eax,eax
     2b6:	75 e6                	jne    29e <strtol+0x40>
		if (!base) {
     2b8:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     2bc:	75 3d                	jne    2fb <strtol+0x9d>
				/* read prefix */
				if (*str == '0') {
     2be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2c1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2c4:	3c 30                	cmp    al,0x30
     2c6:	75 2c                	jne    2f4 <strtol+0x96>
						base = 8;
     2c8:	c7 45 10 08 00 00 00 	mov    DWORD PTR [ebp+0x10],0x8
						str++;
     2cf:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
						if (*str == 'x' || *str == 'X') {
     2d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2d6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2d9:	3c 78                	cmp    al,0x78
     2db:	74 0a                	je     2e7 <strtol+0x89>
     2dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2e0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2e3:	3c 58                	cmp    al,0x58
     2e5:	75 14                	jne    2fb <strtol+0x9d>
								base = 16;
     2e7:	c7 45 10 10 00 00 00 	mov    DWORD PTR [ebp+0x10],0x10
								str++;
     2ee:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
     2f2:	eb 07                	jmp    2fb <strtol+0x9d>
						}
				} else
						base = 10;
     2f4:	c7 45 10 0a 00 00 00 	mov    DWORD PTR [ebp+0x10],0xa
		}
		num_max = ((base >= 10) ? '9' : ('0' + base - 1));
     2fb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2fe:	ba 0a 00 00 00       	mov    edx,0xa
     303:	39 d0                	cmp    eax,edx
     305:	0f 4f c2             	cmovg  eax,edx
     308:	83 c0 2f             	add    eax,0x2f
     30b:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
		char_max = ((base <= 10) ? ('A' - 1) : ('A' + base - 11));
     30e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     311:	ba 0a 00 00 00       	mov    edx,0xa
     316:	39 d0                	cmp    eax,edx
     318:	0f 4c c2             	cmovl  eax,edx
     31b:	83 c0 36             	add    eax,0x36
     31e:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
		char2_max = ((base <= 10) ? ('a' - 1) : ('a' + base - 11));
     321:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     324:	ba 0a 00 00 00       	mov    edx,0xa
     329:	39 d0                	cmp    eax,edx
     32b:	0f 4c c2             	cmovl  eax,edx
     32e:	83 c0 56             	add    eax,0x56
     331:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		if (*str == '-' || *str == '+')
     334:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     337:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     33a:	3c 2d                	cmp    al,0x2d
     33c:	74 0a                	je     348 <strtol+0xea>
     33e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     341:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     344:	3c 2b                	cmp    al,0x2b
     346:	75 17                	jne    35f <strtol+0x101>
				isN = (*str++ == '-');
     348:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     34b:	8d 50 01             	lea    edx,[eax+0x1]
     34e:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
     351:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     354:	3c 2d                	cmp    al,0x2d
     356:	0f 94 c0             	sete   al
     359:	0f b6 c0             	movzx  eax,al
     35c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		while (1) {
				uint8_t addv = 0xff;
     35f:	c6 45 f7 ff          	mov    BYTE PTR [ebp-0x9],0xff
				if(*str >= '0' && *str <= num_max)
     363:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     366:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     369:	3c 2f                	cmp    al,0x2f
     36b:	7e 19                	jle    386 <strtol+0x128>
     36d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     370:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     373:	38 45 f6             	cmp    BYTE PTR [ebp-0xa],al
     376:	7c 0e                	jl     386 <strtol+0x128>
						addv = *str - '0';
     378:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     37b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     37e:	83 e8 30             	sub    eax,0x30
     381:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
     384:	eb 44                	jmp    3ca <strtol+0x16c>
				else if (*str >= 'A' && *str <= char_max)
     386:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     389:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     38c:	3c 40                	cmp    al,0x40
     38e:	7e 19                	jle    3a9 <strtol+0x14b>
     390:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     393:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     396:	38 45 f5             	cmp    BYTE PTR [ebp-0xb],al
     399:	7c 0e                	jl     3a9 <strtol+0x14b>
						addv = (*str - 'A') + 10;
     39b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     39e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3a1:	83 e8 37             	sub    eax,0x37
     3a4:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
     3a7:	eb 21                	jmp    3ca <strtol+0x16c>
				else if (*str >= 'a' && *str <= char2_max)
     3a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3ac:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3af:	3c 60                	cmp    al,0x60
     3b1:	7e 17                	jle    3ca <strtol+0x16c>
     3b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3b9:	38 45 f4             	cmp    BYTE PTR [ebp-0xc],al
     3bc:	7c 0c                	jl     3ca <strtol+0x16c>
						addv = (*str - 'a') + 10;
     3be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3c4:	83 e8 57             	sub    eax,0x57
     3c7:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al

				if (addv == 0xff) {
     3ca:	80 7d f7 ff          	cmp    BYTE PTR [ebp-0x9],0xff
     3ce:	75 50                	jne    420 <strtol+0x1c2>
						if (endptr)
     3d0:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     3d4:	74 08                	je     3de <strtol+0x180>
								*endptr = (char*)str;
     3d6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3d9:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     3dc:	89 10                	mov    DWORD PTR [eax],edx
						if (isN == 2 || isN == 3) {
     3de:	83 7d f8 02          	cmp    DWORD PTR [ebp-0x8],0x2
     3e2:	74 06                	je     3ea <strtol+0x18c>
     3e4:	83 7d f8 03          	cmp    DWORD PTR [ebp-0x8],0x3
     3e8:	75 24                	jne    40e <strtol+0x1b0>
								errno = ERANGE;
     3ea:	c7 05 00 00 00 00 22 00 00 00 	mov    DWORD PTR ds:0x0,0x22
								return isN == 2 ? LONG_MAX : LONG_MIN;
     3f4:	83 7d f8 02          	cmp    DWORD PTR [ebp-0x8],0x2
     3f8:	75 0a                	jne    404 <strtol+0x1a6>
     3fa:	b8 ff ff ff 7f       	mov    eax,0x7fffffff
     3ff:	e9 8c 00 00 00       	jmp    490 <strtol+0x232>
     404:	b8 00 00 00 80       	mov    eax,0x80000000
     409:	e9 82 00 00 00       	jmp    490 <strtol+0x232>
						}
						return isN ? -rv : rv;
     40e:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     412:	74 07                	je     41b <strtol+0x1bd>
     414:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     417:	f7 d8                	neg    eax
     419:	eb 75                	jmp    490 <strtol+0x232>
     41b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     41e:	eb 70                	jmp    490 <strtol+0x232>
				} else {
						if (isN == 0) {
     420:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     424:	75 30                	jne    456 <strtol+0x1f8>
								if (rv * base + addv > LONG_MAX)
     426:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     429:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     42d:	89 c2                	mov    edx,eax
     42f:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     433:	01 d0                	add    eax,edx
     435:	85 c0                	test   eax,eax
     437:	79 09                	jns    442 <strtol+0x1e4>
										isN = 2;
     439:	c7 45 f8 02 00 00 00 	mov    DWORD PTR [ebp-0x8],0x2
     440:	eb 45                	jmp    487 <strtol+0x229>
								else
										rv = rv * base + addv;
     442:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     445:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     449:	89 c2                	mov    edx,eax
     44b:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     44f:	01 d0                	add    eax,edx
     451:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     454:	eb 31                	jmp    487 <strtol+0x229>
						} else {
								if ((rv * base + addv) > (unsigned long int)(LONG_MAX) + 1)
     456:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     459:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     45d:	89 c2                	mov    edx,eax
     45f:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     463:	01 d0                	add    eax,edx
     465:	3d 00 00 00 80       	cmp    eax,0x80000000
     46a:	76 09                	jbe    475 <strtol+0x217>
										isN = 3;
     46c:	c7 45 f8 03 00 00 00 	mov    DWORD PTR [ebp-0x8],0x3
     473:	eb 12                	jmp    487 <strtol+0x229>
								else
										rv = rv * base + addv;
     475:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     478:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     47c:	89 c2                	mov    edx,eax
     47e:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     482:	01 d0                	add    eax,edx
     484:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						}
				}
				str++;
     487:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (1) {
     48b:	e9 cf fe ff ff       	jmp    35f <strtol+0x101>
		}
}
     490:	c9                   	leave
     491:	c3                   	ret

00000492 <atoi>:

int atoi(const char* str)
{
     492:	55                   	push   ebp
     493:	89 e5                	mov    ebp,esp
     495:	83 ec 10             	sub    esp,0x10
		unsigned int rv = 0, isN = 0;
     498:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     49f:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		if (!str)
     4a6:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     4aa:	75 0e                	jne    4ba <atoi+0x28>
				return 0;
     4ac:	b8 00 00 00 00       	mov    eax,0x0
     4b1:	e9 92 00 00 00       	jmp    548 <atoi+0xb6>
		while (isspace(*str))
				str++;
     4b6:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (isspace(*str))
     4ba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4bd:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4c0:	0f be c0             	movsx  eax,al
     4c3:	50                   	push   eax
     4c4:	e8 fc ff ff ff       	call   4c5 <atoi+0x33>
     4c9:	83 c4 04             	add    esp,0x4
     4cc:	85 c0                	test   eax,eax
     4ce:	75 e6                	jne    4b6 <atoi+0x24>
		if (*str == '-') {
     4d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4d3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4d6:	3c 2d                	cmp    al,0x2d
     4d8:	75 0d                	jne    4e7 <atoi+0x55>
				isN = 1;
     4da:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [ebp-0x8],0x1
				str++;
     4e1:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
     4e5:	eb 37                	jmp    51e <atoi+0x8c>
		} else if (*str == '+')
     4e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4ea:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4ed:	3c 2b                	cmp    al,0x2b
     4ef:	75 2d                	jne    51e <atoi+0x8c>
				str++;
     4f1:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str >= '0' && *str <= '9') {
     4f5:	eb 27                	jmp    51e <atoi+0x8c>
				rv *= 10;
     4f7:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     4fa:	89 d0                	mov    eax,edx
     4fc:	c1 e0 02             	shl    eax,0x2
     4ff:	01 d0                	add    eax,edx
     501:	01 c0                	add    eax,eax
     503:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				rv += *str - '0';
     506:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     509:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     50c:	0f be d0             	movsx  edx,al
     50f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     512:	01 d0                	add    eax,edx
     514:	83 e8 30             	sub    eax,0x30
     517:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				str++;
     51a:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str >= '0' && *str <= '9') {
     51e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     521:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     524:	3c 2f                	cmp    al,0x2f
     526:	7e 0a                	jle    532 <atoi+0xa0>
     528:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     52b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     52e:	3c 39                	cmp    al,0x39
     530:	7e c5                	jle    4f7 <atoi+0x65>
		}
		if (isN && rv)
     532:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     536:	74 0d                	je     545 <atoi+0xb3>
     538:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     53c:	74 07                	je     545 <atoi+0xb3>
				return (int)-rv;
     53e:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     541:	f7 d8                	neg    eax
     543:	eb 03                	jmp    548 <atoi+0xb6>
		else
				return (int)rv;
     545:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]

}
     548:	c9                   	leave
     549:	c3                   	ret

0000054a <strchr>:

char* strchr(const char* str, int character)
{
     54a:	55                   	push   ebp
     54b:	89 e5                	mov    ebp,esp
		if (!str)
     54d:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     551:	75 1c                	jne    56f <strchr+0x25>
				return NULL;
     553:	b8 00 00 00 00       	mov    eax,0x0
     558:	eb 25                	jmp    57f <strchr+0x35>
		while (*str != (char)character)
				if (*str == '\0')
     55a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     55d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     560:	84 c0                	test   al,al
     562:	75 07                	jne    56b <strchr+0x21>
						return NULL;
     564:	b8 00 00 00 00       	mov    eax,0x0
     569:	eb 14                	jmp    57f <strchr+0x35>
				else
						str++;
     56b:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str != (char)character)
     56f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     572:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     575:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     578:	38 d0                	cmp    al,dl
     57a:	75 de                	jne    55a <strchr+0x10>
		return (char*)str;
     57c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
     57f:	5d                   	pop    ebp
     580:	c3                   	ret

00000581 <strndup>:

char* strndup(const char* s, size_t n)
{
     581:	55                   	push   ebp
     582:	89 e5                	mov    ebp,esp
     584:	83 ec 18             	sub    esp,0x18
		size_t l; char* rv;
		if (!s)
     587:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     58b:	75 0a                	jne    597 <strndup+0x16>
				return NULL;
     58d:	b8 00 00 00 00       	mov    eax,0x0
     592:	e9 80 00 00 00       	jmp    617 <strndup+0x96>
		l = strlen(s);
     597:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     59a:	e8 fc ff ff ff       	call   59b <strndup+0x1a>
     59f:	83 c4 04             	add    esp,0x4
     5a2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv = kmalloc(1 + (l = min(l, n)));
     5a5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     5a8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5ab:	39 c2                	cmp    edx,eax
     5ad:	0f 46 c2             	cmovbe eax,edx
     5b0:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     5b3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     5b6:	83 c0 01             	add    eax,0x1
     5b9:	83 ec 0c             	sub    esp,0xc
     5bc:	50                   	push   eax
     5bd:	e8 fc ff ff ff       	call   5be <strndup+0x3d>
     5c2:	83 c4 10             	add    esp,0x10
     5c5:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!rv) {
     5c8:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     5cc:	75 11                	jne    5df <strndup+0x5e>
				errno = ENOMEM;
     5ce:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
				return NULL;
     5d8:	b8 00 00 00 00       	mov    eax,0x0
     5dd:	eb 38                	jmp    617 <strndup+0x96>
		}
		for (n = 0; n < l; n++)
     5df:	c7 45 0c 00 00 00 00 	mov    DWORD PTR [ebp+0xc],0x0
     5e6:	eb 19                	jmp    601 <strndup+0x80>
				rv[n] = s[n];
     5e8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     5eb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5ee:	01 d0                	add    eax,edx
     5f0:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     5f3:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     5f6:	01 ca                	add    edx,ecx
     5f8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     5fb:	88 02                	mov    BYTE PTR [edx],al
		for (n = 0; n < l; n++)
     5fd:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
     601:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     604:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
     607:	72 df                	jb     5e8 <strndup+0x67>
		rv[n] = '\0';
     609:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     60c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     60f:	01 d0                	add    eax,edx
     611:	c6 00 00             	mov    BYTE PTR [eax],0x0
		return rv;
     614:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     617:	c9                   	leave
     618:	c3                   	ret

00000619 <strdup>:

char* strdup(const char* s)
{
     619:	55                   	push   ebp
     61a:	89 e5                	mov    ebp,esp
     61c:	83 ec 18             	sub    esp,0x18
		char* rv; size_t l, n;
		if (!s)
     61f:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     623:	75 07                	jne    62c <strdup+0x13>
				return NULL;
     625:	b8 00 00 00 00       	mov    eax,0x0
     62a:	eb 5a                	jmp    686 <strdup+0x6d>
		l = strlen(s) + 1;
     62c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     62f:	e8 fc ff ff ff       	call   630 <strdup+0x17>
     634:	83 c4 04             	add    esp,0x4
     637:	83 c0 01             	add    eax,0x1
     63a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv = kmalloc(l);
     63d:	83 ec 0c             	sub    esp,0xc
     640:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     643:	e8 fc ff ff ff       	call   644 <strdup+0x2b>
     648:	83 c4 10             	add    esp,0x10
     64b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		for (n = 0; n < l; n++)
     64e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     655:	eb 19                	jmp    670 <strdup+0x57>
				rv[n] = s[n];
     657:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     65a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     65d:	01 d0                	add    eax,edx
     65f:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     662:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     665:	01 ca                	add    edx,ecx
     667:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     66a:	88 02                	mov    BYTE PTR [edx],al
		for (n = 0; n < l; n++)
     66c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     670:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     673:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
     676:	72 df                	jb     657 <strdup+0x3e>
		rv[n] = '\0';
     678:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     67b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     67e:	01 d0                	add    eax,edx
     680:	c6 00 00             	mov    BYTE PTR [eax],0x0
		return rv;
     683:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
     686:	c9                   	leave
     687:	c3                   	ret

00000688 <strncpy>:

char* strncpy(char* dest, const char* src, size_t n)
{
     688:	55                   	push   ebp
     689:	89 e5                	mov    ebp,esp
     68b:	83 ec 10             	sub    esp,0x10
		size_t i;
		if (!dest)
     68e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     692:	75 07                	jne    69b <strncpy+0x13>
				return NULL;
     694:	b8 00 00 00 00       	mov    eax,0x0
     699:	eb 58                	jmp    6f3 <strncpy+0x6b>
		for (i = 0; i < n; i++) {
     69b:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     6a2:	eb 44                	jmp    6e8 <strncpy+0x60>
				dest[i] = src ? *src : '\0';
     6a4:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     6a8:	74 08                	je     6b2 <strncpy+0x2a>
     6aa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6ad:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     6b0:	eb 05                	jmp    6b7 <strncpy+0x2f>
     6b2:	b8 00 00 00 00       	mov    eax,0x0
     6b7:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     6ba:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     6bd:	01 ca                	add    edx,ecx
     6bf:	88 02                	mov    BYTE PTR [edx],al
				if (src && !(*src))
     6c1:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     6c5:	74 13                	je     6da <strncpy+0x52>
     6c7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6ca:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     6cd:	84 c0                	test   al,al
     6cf:	75 09                	jne    6da <strncpy+0x52>
						src = NULL;
     6d1:	c7 45 0c 00 00 00 00 	mov    DWORD PTR [ebp+0xc],0x0
     6d8:	eb 0a                	jmp    6e4 <strncpy+0x5c>
				else if (src)
     6da:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     6de:	74 04                	je     6e4 <strncpy+0x5c>
						src++;
     6e0:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
		for (i = 0; i < n; i++) {
     6e4:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     6e8:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     6eb:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
     6ee:	72 b4                	jb     6a4 <strncpy+0x1c>
		}
		return dest;
     6f0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
     6f3:	c9                   	leave
     6f4:	c3                   	ret

000006f5 <strcpy>:

char* strcpy(char* dest, char* src)
{
     6f5:	55                   	push   ebp
     6f6:	89 e5                	mov    ebp,esp
     6f8:	83 ec 10             	sub    esp,0x10
		char* rv = dest;
     6fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6fe:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (!dest || !src)
     701:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     705:	74 06                	je     70d <strcpy+0x18>
     707:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     70b:	75 07                	jne    714 <strcpy+0x1f>
				return NULL;
     70d:	b8 00 00 00 00       	mov    eax,0x0
     712:	eb 24                	jmp    738 <strcpy+0x43>
		do {
			*(dest++) = *(src++);
     714:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     717:	8d 42 01             	lea    eax,[edx+0x1]
     71a:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
     71d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     720:	8d 48 01             	lea    ecx,[eax+0x1]
     723:	89 4d 08             	mov    DWORD PTR [ebp+0x8],ecx
     726:	0f b6 12             	movzx  edx,BYTE PTR [edx]
     729:	88 10                	mov    BYTE PTR [eax],dl
		} while (*src);
     72b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     72e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     731:	84 c0                	test   al,al
     733:	75 df                	jne    714 <strcpy+0x1f>
		return rv;
     735:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
     738:	c9                   	leave
     739:	c3                   	ret

0000073a <strtok_r>:

char* strtok_r(char* str, const char* delim, char** saveptr)
{
     73a:	55                   	push   ebp
     73b:	89 e5                	mov    ebp,esp
     73d:	83 ec 10             	sub    esp,0x10
		size_t l = strlen(delim);
     740:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     743:	e8 fc ff ff ff       	call   744 <strtok_r+0xa>
     748:	83 c4 04             	add    esp,0x4
     74b:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		if (str)
     74e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     752:	74 08                	je     75c <strtok_r+0x22>
				*saveptr = str;
     754:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     757:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     75a:	89 10                	mov    DWORD PTR [eax],edx
		str = *saveptr;
     75c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     75f:	8b 00                	mov    eax,DWORD PTR [eax]
     761:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
		if (!l) { /* return full token only once */
     764:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     768:	75 7c                	jne    7e6 <strtok_r+0xac>
				*saveptr = NULL;
     76a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     76d:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				return str;
     773:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     776:	e9 99 00 00 00       	jmp    814 <strtok_r+0xda>
		}
		while (*str) {
				for (size_t i = 0; i < l; i++)
     77b:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     782:	eb 56                	jmp    7da <strtok_r+0xa0>
						if (*str == delim[i]) {
     784:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     787:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     78a:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     78d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     790:	01 c8                	add    eax,ecx
     792:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     795:	38 c2                	cmp    dl,al
     797:	75 3d                	jne    7d6 <strtok_r+0x9c>
								*str = '\0';
     799:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     79c:	c6 00 00             	mov    BYTE PTR [eax],0x0
								if (strlen(*saveptr)) {
     79f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7a2:	8b 00                	mov    eax,DWORD PTR [eax]
     7a4:	50                   	push   eax
     7a5:	e8 fc ff ff ff       	call   7a6 <strtok_r+0x6c>
     7aa:	83 c4 04             	add    esp,0x4
     7ad:	85 c0                	test   eax,eax
     7af:	74 18                	je     7c9 <strtok_r+0x8f>
										char* rv = *saveptr;
     7b1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7b4:	8b 00                	mov    eax,DWORD PTR [eax]
     7b6:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
										*saveptr = str + 1;
     7b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7bc:	8d 50 01             	lea    edx,[eax+0x1]
     7bf:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7c2:	89 10                	mov    DWORD PTR [eax],edx
										return rv;
     7c4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7c7:	eb 4b                	jmp    814 <strtok_r+0xda>
								} else
										*saveptr = str + 1;
     7c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7cc:	8d 50 01             	lea    edx,[eax+0x1]
     7cf:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7d2:	89 10                	mov    DWORD PTR [eax],edx
								break;
     7d4:	eb 0c                	jmp    7e2 <strtok_r+0xa8>
				for (size_t i = 0; i < l; i++)
     7d6:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     7da:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     7dd:	3b 45 f8             	cmp    eax,DWORD PTR [ebp-0x8]
     7e0:	72 a2                	jb     784 <strtok_r+0x4a>
						}
				str++;
     7e2:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str) {
     7e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7e9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     7ec:	84 c0                	test   al,al
     7ee:	75 8b                	jne    77b <strtok_r+0x41>
		}
		/* in case of no delims return full token once */
		if (str == *saveptr)
     7f0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7f3:	8b 00                	mov    eax,DWORD PTR [eax]
     7f5:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     7f8:	75 07                	jne    801 <strtok_r+0xc7>
				return NULL;
     7fa:	b8 00 00 00 00       	mov    eax,0x0
     7ff:	eb 13                	jmp    814 <strtok_r+0xda>
		else {
				char* rv = *saveptr;
     801:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     804:	8b 00                	mov    eax,DWORD PTR [eax]
     806:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				*saveptr = str;
     809:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     80c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     80f:	89 10                	mov    DWORD PTR [eax],edx
				return rv;
     811:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
		}
}
     814:	c9                   	leave
     815:	c3                   	ret

00000816 <strtok>:

char* strtok(char* str, const char* delim)
{
     816:	55                   	push   ebp
     817:	89 e5                	mov    ebp,esp
		static char* ptr;
		return strtok_r(str, delim, &ptr);
     819:	68 08 00 00 00       	push   0x8
     81e:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     821:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     824:	e8 fc ff ff ff       	call   825 <strtok+0xf>
     829:	83 c4 0c             	add    esp,0xc
}
     82c:	c9                   	leave
     82d:	c3                   	ret

0000082e <asctime_r>:

char* asctime_r(const struct tm* timep, char* result)
{
     82e:	55                   	push   ebp
     82f:	89 e5                	mov    ebp,esp
     831:	57                   	push   edi
     832:	56                   	push   esi
     833:	53                   	push   ebx
     834:	83 ec 2c             	sub    esp,0x2c
		};
		static char mon_name[12][3] = {
			"Jan", "Feb", "Mar", "Apr", "May", "Jun",
			"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
		};
		char zerobt = 0;
     837:	c6 45 e7 00          	mov    BYTE PTR [ebp-0x19],0x0
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
			wday_name[timep->tm_wday],
			mon_name[timep->tm_mon],
			timep->tm_mday, timep->tm_hour,
			timep->tm_min, timep->tm_sec,
			1900 + timep->tm_year);
     83b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     83e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
     841:	05 6c 07 00 00       	add    eax,0x76c
     846:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
			timep->tm_min, timep->tm_sec,
     849:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     84c:	8b 08                	mov    ecx,DWORD PTR [eax]
     84e:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
     851:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     854:	8b 78 04             	mov    edi,DWORD PTR [eax+0x4]
			timep->tm_mday, timep->tm_hour,
     857:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     85a:	8b 70 08             	mov    esi,DWORD PTR [eax+0x8]
     85d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     860:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
			mon_name[timep->tm_mon],
     863:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     866:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     869:	89 d0                	mov    eax,edx
     86b:	01 c0                	add    eax,eax
     86d:	01 d0                	add    eax,edx
     86f:	8d 88 00 00 00 00    	lea    ecx,[eax+0x0]
			wday_name[timep->tm_wday],
     875:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     878:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     87b:	89 d0                	mov    eax,edx
     87d:	01 c0                	add    eax,eax
     87f:	01 d0                	add    eax,edx
     881:	05 24 00 00 00       	add    eax,0x24
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
     886:	83 ec 0c             	sub    esp,0xc
     889:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     88c:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     88f:	57                   	push   edi
     890:	56                   	push   esi
     891:	53                   	push   ebx
     892:	51                   	push   ecx
     893:	50                   	push   eax
     894:	68 00 00 00 00       	push   0x0
     899:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     89c:	e8 fc ff ff ff       	call   89d <asctime_r+0x6f>
     8a1:	83 c4 30             	add    esp,0x30
		return result;
     8a4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     8a7:	8d 65 f4             	lea    esp,[ebp-0xc]
     8aa:	5b                   	pop    ebx
     8ab:	5e                   	pop    esi
     8ac:	5f                   	pop    edi
     8ad:	5d                   	pop    ebp
     8ae:	c3                   	ret

000008af <asctime>:

char* asctime(const struct tm* timep)
{
     8af:	55                   	push   ebp
     8b0:	89 e5                	mov    ebp,esp
     8b2:	83 ec 08             	sub    esp,0x8
		static char result[26];
		return asctime_r(timep, result);
     8b5:	83 ec 08             	sub    esp,0x8
     8b8:	68 0c 00 00 00       	push   0xc
     8bd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     8c0:	e8 fc ff ff ff       	call   8c1 <asctime+0x12>
     8c5:	83 c4 10             	add    esp,0x10
}
     8c8:	c9                   	leave
     8c9:	c3                   	ret

000008ca <ctime>:

char* ctime(const time_t* timep)
{
     8ca:	55                   	push   ebp
     8cb:	89 e5                	mov    ebp,esp
     8cd:	83 ec 08             	sub    esp,0x8
		return asctime(localtime(timep));
     8d0:	83 ec 0c             	sub    esp,0xc
     8d3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     8d6:	e8 fc ff ff ff       	call   8d7 <ctime+0xd>
     8db:	83 c4 10             	add    esp,0x10
     8de:	83 ec 0c             	sub    esp,0xc
     8e1:	50                   	push   eax
     8e2:	e8 fc ff ff ff       	call   8e3 <ctime+0x19>
     8e7:	83 c4 10             	add    esp,0x10
}
     8ea:	c9                   	leave
     8eb:	c3                   	ret

000008ec <ctime_r>:

char* ctime_r(const time_t* timep, char* result)
{
     8ec:	55                   	push   ebp
     8ed:	89 e5                	mov    ebp,esp
     8ef:	83 ec 08             	sub    esp,0x8
		return asctime_r(localtime(timep), result);
     8f2:	83 ec 0c             	sub    esp,0xc
     8f5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     8f8:	e8 fc ff ff ff       	call   8f9 <ctime_r+0xd>
     8fd:	83 c4 10             	add    esp,0x10
     900:	83 ec 08             	sub    esp,0x8
     903:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     906:	50                   	push   eax
     907:	e8 fc ff ff ff       	call   908 <ctime_r+0x1c>
     90c:	83 c4 10             	add    esp,0x10
}
     90f:	c9                   	leave
     910:	c3                   	ret

00000911 <time>:

time_t time(time_t* timep)
{
     911:	55                   	push   ebp
     912:	89 e5                	mov    ebp,esp
}
     914:	90                   	nop
     915:	5d                   	pop    ebp
     916:	c3                   	ret

00000917 <mktime>:

time_t mktime(struct tm* timep)
{
     917:	55                   	push   ebp
     918:	89 e5                	mov    ebp,esp
}
     91a:	90                   	nop
     91b:	5d                   	pop    ebp
     91c:	c3                   	ret

0000091d <gmtime_r>:

#define COUNT_LEAPS(Y)   ( ((Y)-1)/4 - ((Y)-1)/100 + ((Y)-1)/400 )
#define COUNT_DAYS(Y)  ( ((Y)-1)*365 + COUNT_LEAPS(Y) )
#define IS_LEAP_YEAR(Y)     ( ((Y)>0) && !((Y)%4) && ( ((Y)%100) || !((Y)%400) ) )
struct tm* gmtime_r(const time_t* timep, struct tm* result)
{
     91d:	55                   	push   ebp
     91e:	89 e5                	mov    ebp,esp
     920:	57                   	push   edi
     921:	56                   	push   esi
     922:	53                   	push   ebx
     923:	83 ec 3c             	sub    esp,0x3c
		int dayct = *timep / 86400, isl, rem;
     926:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     929:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     92c:	8b 00                	mov    eax,DWORD PTR [eax]
     92e:	6a 00                	push   0x0
     930:	68 80 51 01 00       	push   0x15180
     935:	52                   	push   edx
     936:	50                   	push   eax
     937:	e8 fc ff ff ff       	call   938 <gmtime_r+0x1b>
     93c:	83 c4 10             	add    esp,0x10
     93f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		*result = (struct tm){0};
     942:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     945:	89 c3                	mov    ebx,eax
     947:	b8 00 00 00 00       	mov    eax,0x0
     94c:	ba 09 00 00 00       	mov    edx,0x9
     951:	89 df                	mov    edi,ebx
     953:	89 d1                	mov    ecx,edx
     955:	f3 ab                	rep stos DWORD PTR es:[edi],eax
		result->tm_wday = (dayct + 4) % 7; /* Jan 1 1970 is Thu */
     957:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     95a:	8d 48 04             	lea    ecx,[eax+0x4]
     95d:	ba 93 24 49 92       	mov    edx,0x92492493
     962:	89 c8                	mov    eax,ecx
     964:	f7 ea                	imul   edx
     966:	8d 04 0a             	lea    eax,[edx+ecx*1]
     969:	c1 f8 02             	sar    eax,0x2
     96c:	89 ca                	mov    edx,ecx
     96e:	c1 fa 1f             	sar    edx,0x1f
     971:	29 d0                	sub    eax,edx
     973:	89 c2                	mov    edx,eax
     975:	c1 e2 03             	shl    edx,0x3
     978:	29 c2                	sub    edx,eax
     97a:	89 c8                	mov    eax,ecx
     97c:	29 d0                	sub    eax,edx
     97e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     981:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
     984:	eb 0f                	jmp    995 <gmtime_r+0x78>
			result->tm_year++;
     986:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     989:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     98c:	8d 50 01             	lea    edx,[eax+0x1]
     98f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     992:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
     995:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     998:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     99b:	05 6b 07 00 00       	add    eax,0x76b
     9a0:	69 d8 6d 01 00 00    	imul   ebx,eax,0x16d
     9a6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9a9:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9ac:	05 6b 07 00 00       	add    eax,0x76b
     9b1:	8d 50 03             	lea    edx,[eax+0x3]
     9b4:	85 c0                	test   eax,eax
     9b6:	0f 48 c2             	cmovs  eax,edx
     9b9:	c1 f8 02             	sar    eax,0x2
     9bc:	89 c6                	mov    esi,eax
     9be:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9c1:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9c4:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     9ca:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     9cf:	89 c8                	mov    eax,ecx
     9d1:	f7 ea                	imul   edx
     9d3:	89 d0                	mov    eax,edx
     9d5:	c1 f8 05             	sar    eax,0x5
     9d8:	c1 f9 1f             	sar    ecx,0x1f
     9db:	89 ca                	mov    edx,ecx
     9dd:	29 c2                	sub    edx,eax
     9df:	01 d6                	add    esi,edx
     9e1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9e4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9e7:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     9ed:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     9f2:	89 c8                	mov    eax,ecx
     9f4:	f7 ea                	imul   edx
     9f6:	c1 fa 07             	sar    edx,0x7
     9f9:	89 c8                	mov    eax,ecx
     9fb:	c1 f8 1f             	sar    eax,0x1f
     9fe:	29 c2                	sub    edx,eax
     a00:	8d 04 16             	lea    eax,[esi+edx*1]
     a03:	01 d8                	add    eax,ebx
     a05:	2d 3a f9 0a 00       	sub    eax,0xaf93a
     a0a:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
     a0d:	0f 8d 73 ff ff ff    	jge    986 <gmtime_r+0x69>
		result->tm_year--;
     a13:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a16:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a19:	8d 50 ff             	lea    edx,[eax-0x1]
     a1c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a1f:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		isl = IS_LEAP_YEAR(result->tm_year);
     a22:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a25:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a28:	85 c0                	test   eax,eax
     a2a:	7e 63                	jle    a8f <gmtime_r+0x172>
     a2c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a2f:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a32:	83 e0 03             	and    eax,0x3
     a35:	85 c0                	test   eax,eax
     a37:	75 56                	jne    a8f <gmtime_r+0x172>
     a39:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a3c:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     a3f:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     a44:	89 c8                	mov    eax,ecx
     a46:	f7 ea                	imul   edx
     a48:	89 d0                	mov    eax,edx
     a4a:	c1 f8 05             	sar    eax,0x5
     a4d:	89 ca                	mov    edx,ecx
     a4f:	c1 fa 1f             	sar    edx,0x1f
     a52:	29 d0                	sub    eax,edx
     a54:	6b d0 64             	imul   edx,eax,0x64
     a57:	89 c8                	mov    eax,ecx
     a59:	29 d0                	sub    eax,edx
     a5b:	85 c0                	test   eax,eax
     a5d:	75 29                	jne    a88 <gmtime_r+0x16b>
     a5f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a62:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     a65:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     a6a:	89 c8                	mov    eax,ecx
     a6c:	f7 ea                	imul   edx
     a6e:	89 d0                	mov    eax,edx
     a70:	c1 f8 07             	sar    eax,0x7
     a73:	89 ca                	mov    edx,ecx
     a75:	c1 fa 1f             	sar    edx,0x1f
     a78:	29 d0                	sub    eax,edx
     a7a:	69 d0 90 01 00 00    	imul   edx,eax,0x190
     a80:	89 c8                	mov    eax,ecx
     a82:	29 d0                	sub    eax,edx
     a84:	85 c0                	test   eax,eax
     a86:	75 07                	jne    a8f <gmtime_r+0x172>
     a88:	b8 01 00 00 00       	mov    eax,0x1
     a8d:	eb 05                	jmp    a94 <gmtime_r+0x177>
     a8f:	b8 00 00 00 00       	mov    eax,0x0
     a94:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		dayct -= COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970);
     a97:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a9a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a9d:	05 6b 07 00 00       	add    eax,0x76b
     aa2:	69 d8 6d 01 00 00    	imul   ebx,eax,0x16d
     aa8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     aab:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     aae:	05 6b 07 00 00       	add    eax,0x76b
     ab3:	8d 50 03             	lea    edx,[eax+0x3]
     ab6:	85 c0                	test   eax,eax
     ab8:	0f 48 c2             	cmovs  eax,edx
     abb:	c1 f8 02             	sar    eax,0x2
     abe:	89 c6                	mov    esi,eax
     ac0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ac3:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     ac6:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     acc:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     ad1:	89 c8                	mov    eax,ecx
     ad3:	f7 ea                	imul   edx
     ad5:	89 d0                	mov    eax,edx
     ad7:	c1 f8 05             	sar    eax,0x5
     ada:	c1 f9 1f             	sar    ecx,0x1f
     add:	89 ca                	mov    edx,ecx
     adf:	29 c2                	sub    edx,eax
     ae1:	01 d6                	add    esi,edx
     ae3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ae6:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     ae9:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     aef:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     af4:	89 c8                	mov    eax,ecx
     af6:	f7 ea                	imul   edx
     af8:	c1 fa 07             	sar    edx,0x7
     afb:	89 c8                	mov    eax,ecx
     afd:	c1 f8 1f             	sar    eax,0x1f
     b00:	29 c2                	sub    edx,eax
     b02:	8d 04 16             	lea    eax,[esi+edx*1]
     b05:	01 d8                	add    eax,ebx
     b07:	2d 3a f9 0a 00       	sub    eax,0xaf93a
     b0c:	29 45 e4             	sub    DWORD PTR [ebp-0x1c],eax
		result->tm_yday = dayct;
     b0f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b12:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     b15:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		static const int dayct_nl[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, INT_MAX };
		static const int dayct_lp[] = { 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, INT_MAX };
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
     b18:	eb 0f                	jmp    b29 <gmtime_r+0x20c>
			result->tm_mon++;
     b1a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b1d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b20:	8d 50 01             	lea    edx,[eax+0x1]
     b23:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b26:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
     b29:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
     b2d:	74 07                	je     b36 <gmtime_r+0x219>
     b2f:	ba 20 00 00 00       	mov    edx,0x20
     b34:	eb 05                	jmp    b3b <gmtime_r+0x21e>
     b36:	ba 60 00 00 00       	mov    edx,0x60
     b3b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b3e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b41:	c1 e0 02             	shl    eax,0x2
     b44:	01 d0                	add    eax,edx
     b46:	8b 10                	mov    edx,DWORD PTR [eax]
     b48:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b4b:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
     b4e:	39 c2                	cmp    edx,eax
     b50:	7c c8                	jl     b1a <gmtime_r+0x1fd>
		result->tm_mon--;
     b52:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b55:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b58:	8d 50 ff             	lea    edx,[eax-0x1]
     b5b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b5e:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		dayct -= (isl ? dayct_lp : dayct_nl)[result->tm_mon]; /* 0 based */
     b61:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
     b65:	74 07                	je     b6e <gmtime_r+0x251>
     b67:	ba 20 00 00 00       	mov    edx,0x20
     b6c:	eb 05                	jmp    b73 <gmtime_r+0x256>
     b6e:	ba 60 00 00 00       	mov    edx,0x60
     b73:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b76:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b79:	c1 e0 02             	shl    eax,0x2
     b7c:	01 d0                	add    eax,edx
     b7e:	8b 00                	mov    eax,DWORD PTR [eax]
     b80:	29 45 e4             	sub    DWORD PTR [ebp-0x1c],eax
		result->tm_mday = dayct + 1; /* 1 based */
     b83:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b86:	8d 50 01             	lea    edx,[eax+0x1]
     b89:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b8c:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		/* time logic */
		rem = *timep % 86400;
     b8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b92:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     b95:	8b 00                	mov    eax,DWORD PTR [eax]
     b97:	6a 00                	push   0x0
     b99:	68 80 51 01 00       	push   0x15180
     b9e:	52                   	push   edx
     b9f:	50                   	push   eax
     ba0:	e8 fc ff ff ff       	call   ba1 <gmtime_r+0x284>
     ba5:	83 c4 10             	add    esp,0x10
     ba8:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		result->tm_hour = rem / 3600;
     bab:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     bae:	ba c5 b3 a2 91       	mov    edx,0x91a2b3c5
     bb3:	89 c8                	mov    eax,ecx
     bb5:	f7 ea                	imul   edx
     bb7:	8d 04 0a             	lea    eax,[edx+ecx*1]
     bba:	c1 f8 0b             	sar    eax,0xb
     bbd:	89 c2                	mov    edx,eax
     bbf:	89 c8                	mov    eax,ecx
     bc1:	c1 f8 1f             	sar    eax,0x1f
     bc4:	29 c2                	sub    edx,eax
     bc6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     bc9:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		rem %= 3600;
     bcc:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     bcf:	ba c5 b3 a2 91       	mov    edx,0x91a2b3c5
     bd4:	89 c8                	mov    eax,ecx
     bd6:	f7 ea                	imul   edx
     bd8:	8d 04 0a             	lea    eax,[edx+ecx*1]
     bdb:	c1 f8 0b             	sar    eax,0xb
     bde:	89 c2                	mov    edx,eax
     be0:	89 c8                	mov    eax,ecx
     be2:	c1 f8 1f             	sar    eax,0x1f
     be5:	29 c2                	sub    edx,eax
     be7:	69 c2 10 0e 00 00    	imul   eax,edx,0xe10
     bed:	29 c1                	sub    ecx,eax
     bef:	89 ca                	mov    edx,ecx
     bf1:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		result->tm_min = rem / 60;
     bf4:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     bf7:	ba 89 88 88 88       	mov    edx,0x88888889
     bfc:	89 c8                	mov    eax,ecx
     bfe:	f7 ea                	imul   edx
     c00:	8d 04 0a             	lea    eax,[edx+ecx*1]
     c03:	c1 f8 05             	sar    eax,0x5
     c06:	89 c2                	mov    edx,eax
     c08:	89 c8                	mov    eax,ecx
     c0a:	c1 f8 1f             	sar    eax,0x1f
     c0d:	29 c2                	sub    edx,eax
     c0f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c12:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		rem %= 60;
     c15:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     c18:	ba 89 88 88 88       	mov    edx,0x88888889
     c1d:	89 c8                	mov    eax,ecx
     c1f:	f7 ea                	imul   edx
     c21:	8d 04 0a             	lea    eax,[edx+ecx*1]
     c24:	c1 f8 05             	sar    eax,0x5
     c27:	89 c2                	mov    edx,eax
     c29:	89 c8                	mov    eax,ecx
     c2b:	c1 f8 1f             	sar    eax,0x1f
     c2e:	29 c2                	sub    edx,eax
     c30:	6b c2 3c             	imul   eax,edx,0x3c
     c33:	29 c1                	sub    ecx,eax
     c35:	89 ca                	mov    edx,ecx
     c37:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		result->tm_sec = rem;
     c3a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c3d:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     c40:	89 10                	mov    DWORD PTR [eax],edx
		/* gmtime isdst=0 */
		return result;
     c42:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     c45:	8d 65 f4             	lea    esp,[ebp-0xc]
     c48:	5b                   	pop    ebx
     c49:	5e                   	pop    esi
     c4a:	5f                   	pop    edi
     c4b:	5d                   	pop    ebp
     c4c:	c3                   	ret

00000c4d <gmtime>:

struct tm* gmtime(const time_t* timep)
{
     c4d:	55                   	push   ebp
     c4e:	89 e5                	mov    ebp,esp
     c50:	83 ec 08             	sub    esp,0x8
		static struct tm lts;
		return gmtime_r(timep, &lts);
     c53:	83 ec 08             	sub    esp,0x8
     c56:	68 40 00 00 00       	push   0x40
     c5b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c5e:	e8 fc ff ff ff       	call   c5f <gmtime+0x12>
     c63:	83 c4 10             	add    esp,0x10
}
     c66:	c9                   	leave
     c67:	c3                   	ret

00000c68 <localtime_r>:

struct tm* localtime_r(const time_t* timep, struct tm* result)
{
     c68:	55                   	push   ebp
     c69:	89 e5                	mov    ebp,esp
     c6b:	83 ec 08             	sub    esp,0x8
		/*TODO: +- time_t offset */
		return gmtime_r(timep, result);
     c6e:	83 ec 08             	sub    esp,0x8
     c71:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     c74:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c77:	e8 fc ff ff ff       	call   c78 <localtime_r+0x10>
     c7c:	83 c4 10             	add    esp,0x10
}
     c7f:	c9                   	leave
     c80:	c3                   	ret

00000c81 <localtime>:

struct tm* localtime(const time_t* timep)
{
     c81:	55                   	push   ebp
     c82:	89 e5                	mov    ebp,esp
     c84:	83 ec 08             	sub    esp,0x8
		static struct tm lts;
		return localtime_r(timep, &lts);
     c87:	83 ec 08             	sub    esp,0x8
     c8a:	68 80 00 00 00       	push   0x80
     c8f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c92:	e8 fc ff ff ff       	call   c93 <localtime+0x12>
     c97:	83 c4 10             	add    esp,0x10
}
     c9a:	c9                   	leave
     c9b:	c3                   	ret

00000c9c <difftime>:

double difftime(time_t end, time_t beg)
{
     c9c:	55                   	push   ebp
     c9d:	89 e5                	mov    ebp,esp
     c9f:	83 ec 18             	sub    esp,0x18
     ca2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ca5:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     ca8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     cab:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     cae:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     cb1:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     cb4:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     cb7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return (double)(end - beg); /* our time_t is in seconds */
     cba:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     cbd:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     cc0:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
     cc3:	1b 55 f4             	sbb    edx,DWORD PTR [ebp-0xc]
     cc6:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     cc9:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     ccc:	df 6d e8             	fild   QWORD PTR [ebp-0x18]
}
     ccf:	c9                   	leave
     cd0:	c3                   	ret

00000cd1 <__umoddi3>:
		return q;
}

UDWtype
__umoddi3 (UDWtype u, UDWtype v)
{
     cd1:	55                   	push   ebp
     cd2:	89 e5                	mov    ebp,esp
     cd4:	83 ec 60             	sub    esp,0x60
     cd7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cda:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
     cdd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ce0:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
     ce3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ce6:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     ce9:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     cec:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
     cef:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
     cf2:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     cf5:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     cf8:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
     cfb:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     cfe:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     d01:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     d04:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     d07:	8d 45 b8             	lea    eax,[ebp-0x48]
     d0a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		UDWtype q = 0, r = n, y = d;
     d0d:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
     d14:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     d1b:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d1e:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     d21:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     d24:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     d27:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d2a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     d2d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     d30:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (y <= r)
     d33:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     d36:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     d39:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     d3c:	89 d0                	mov    eax,edx
     d3e:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     d41:	0f 82 4f 01 00 00    	jb     e96 <__umoddi3+0x1c5>
				lz1 = __builtin_clzll (d);
     d47:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d4a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     d4d:	85 d2                	test   edx,edx
     d4f:	74 08                	je     d59 <__umoddi3+0x88>
     d51:	0f bd c2             	bsr    eax,edx
     d54:	83 f0 1f             	xor    eax,0x1f
     d57:	eb 09                	jmp    d62 <__umoddi3+0x91>
     d59:	0f bd c0             	bsr    eax,eax
     d5c:	83 f0 1f             	xor    eax,0x1f
     d5f:	83 c0 20             	add    eax,0x20
     d62:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				lz2 = __builtin_clzll (n);
     d65:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d68:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     d6b:	85 d2                	test   edx,edx
     d6d:	74 08                	je     d77 <__umoddi3+0xa6>
     d6f:	0f bd c2             	bsr    eax,edx
     d72:	83 f0 1f             	xor    eax,0x1f
     d75:	eb 09                	jmp    d80 <__umoddi3+0xaf>
     d77:	0f bd c0             	bsr    eax,eax
     d7a:	83 f0 1f             	xor    eax,0x1f
     d7d:	83 c0 20             	add    eax,0x20
     d80:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				k = lz1 - lz2;
     d83:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     d86:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
     d89:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				y = (y << k);
     d8c:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     d8f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     d92:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     d95:	0f a5 c2             	shld   edx,eax,cl
     d98:	d3 e0                	shl    eax,cl
     d9a:	f6 c1 20             	test   cl,0x20
     d9d:	74 04                	je     da3 <__umoddi3+0xd2>
     d9f:	89 c2                	mov    edx,eax
     da1:	31 c0                	xor    eax,eax
     da3:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     da6:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (r >= y)
     da9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     dac:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     daf:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     db2:	89 d0                	mov    eax,edx
     db4:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     db7:	72 2d                	jb     de6 <__umoddi3+0x115>
						r = r - y;
     db9:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     dbc:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     dbf:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
     dc2:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						q =  (1ULL << k);
     dc5:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     dc8:	b8 01 00 00 00       	mov    eax,0x1
     dcd:	ba 00 00 00 00       	mov    edx,0x0
     dd2:	0f a5 c2             	shld   edx,eax,cl
     dd5:	d3 e0                	shl    eax,cl
     dd7:	f6 c1 20             	test   cl,0x20
     dda:	74 04                	je     de0 <__umoddi3+0x10f>
     ddc:	89 c2                	mov    edx,eax
     dde:	31 c0                	xor    eax,eax
     de0:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     de3:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (k > 0)
     de6:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
     dea:	0f 84 a6 00 00 00    	je     e96 <__umoddi3+0x1c5>
						y = y >> 1;
     df0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     df3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     df6:	0f ac d0 01          	shrd   eax,edx,0x1
     dfa:	d1 ea                	shr    edx,1
     dfc:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     dff:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						i = k;
     e02:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     e05:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								if (r >= y)
     e08:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     e0b:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     e0e:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     e11:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
     e14:	19 d1                	sbb    ecx,edx
     e16:	72 1e                	jb     e36 <__umoddi3+0x165>
										r = ((r - y) << 1) + 1;
     e18:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e1b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e1e:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     e21:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
     e24:	01 c0                	add    eax,eax
     e26:	11 d2                	adc    edx,edx
     e28:	83 c0 01             	add    eax,0x1
     e2b:	83 d2 00             	adc    edx,0x0
     e2e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e31:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     e34:	eb 10                	jmp    e46 <__umoddi3+0x175>
										r =  (r << 1);
     e36:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e39:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e3c:	01 c0                	add    eax,eax
     e3e:	11 d2                	adc    edx,edx
     e40:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e43:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
								i = i - 1;
     e46:	83 6d c0 01          	sub    DWORD PTR [ebp-0x40],0x1
						} while (i != 0);
     e4a:	83 7d c0 00          	cmp    DWORD PTR [ebp-0x40],0x0
     e4e:	75 b8                	jne    e08 <__umoddi3+0x137>
						q = q + r;
     e50:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e53:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e56:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
     e59:	11 55 e4             	adc    DWORD PTR [ebp-0x1c],edx
						r = r >> k;
     e5c:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     e5f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e62:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e65:	0f ad d0             	shrd   eax,edx,cl
     e68:	d3 ea                	shr    edx,cl
     e6a:	f6 c1 20             	test   cl,0x20
     e6d:	74 04                	je     e73 <__umoddi3+0x1a2>
     e6f:	89 d0                	mov    eax,edx
     e71:	31 d2                	xor    edx,edx
     e73:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e76:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
						q = q - (r << k);
     e79:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     e7c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e7f:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e82:	0f a5 c2             	shld   edx,eax,cl
     e85:	d3 e0                	shl    eax,cl
     e87:	f6 c1 20             	test   cl,0x20
     e8a:	74 04                	je     e90 <__umoddi3+0x1bf>
     e8c:	89 c2                	mov    edx,eax
     e8e:	31 c0                	xor    eax,eax
     e90:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
     e93:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
		if (rp)
     e96:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     e9a:	74 0e                	je     eaa <__umoddi3+0x1d9>
				*rp = r;
     e9c:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     e9f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     ea2:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     ea5:	89 01                	mov    DWORD PTR [ecx],eax
     ea7:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		UDWtype w;

		(void) __udivmoddi4 (u, v, &w);

		return w;
     eaa:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     ead:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
}
     eb0:	c9                   	leave
     eb1:	c3                   	ret

00000eb2 <__udivdi3>:

UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
     eb2:	55                   	push   ebp
     eb3:	89 e5                	mov    ebp,esp
     eb5:	83 ec 50             	sub    esp,0x50
     eb8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ebb:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
     ebe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ec1:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
     ec4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ec7:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
     eca:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ecd:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
     ed0:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     ed3:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     ed6:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     ed9:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
     edc:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
     edf:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
     ee2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     ee5:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     ee8:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		UDWtype q = 0, r = n, y = d;
     eef:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
     ef6:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     efd:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     f00:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     f03:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     f06:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     f09:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f0c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     f0f:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     f12:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (y <= r)
     f15:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     f18:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     f1b:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     f1e:	89 d0                	mov    eax,edx
     f20:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     f23:	0f 82 4f 01 00 00    	jb     1078 <__udivdi3+0x1c6>
				lz1 = __builtin_clzll (d);
     f29:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f2c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     f2f:	85 d2                	test   edx,edx
     f31:	74 08                	je     f3b <__udivdi3+0x89>
     f33:	0f bd c2             	bsr    eax,edx
     f36:	83 f0 1f             	xor    eax,0x1f
     f39:	eb 09                	jmp    f44 <__udivdi3+0x92>
     f3b:	0f bd c0             	bsr    eax,eax
     f3e:	83 f0 1f             	xor    eax,0x1f
     f41:	83 c0 20             	add    eax,0x20
     f44:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				lz2 = __builtin_clzll (n);
     f47:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     f4a:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     f4d:	85 d2                	test   edx,edx
     f4f:	74 08                	je     f59 <__udivdi3+0xa7>
     f51:	0f bd c2             	bsr    eax,edx
     f54:	83 f0 1f             	xor    eax,0x1f
     f57:	eb 09                	jmp    f62 <__udivdi3+0xb0>
     f59:	0f bd c0             	bsr    eax,eax
     f5c:	83 f0 1f             	xor    eax,0x1f
     f5f:	83 c0 20             	add    eax,0x20
     f62:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				k = lz1 - lz2;
     f65:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f68:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
     f6b:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				y = (y << k);
     f6e:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     f71:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f74:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     f77:	0f a5 c2             	shld   edx,eax,cl
     f7a:	d3 e0                	shl    eax,cl
     f7c:	f6 c1 20             	test   cl,0x20
     f7f:	74 04                	je     f85 <__udivdi3+0xd3>
     f81:	89 c2                	mov    edx,eax
     f83:	31 c0                	xor    eax,eax
     f85:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     f88:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (r >= y)
     f8b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     f8e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     f91:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     f94:	89 d0                	mov    eax,edx
     f96:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     f99:	72 2d                	jb     fc8 <__udivdi3+0x116>
						r = r - y;
     f9b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f9e:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     fa1:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
     fa4:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						q =  (1ULL << k);
     fa7:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     faa:	b8 01 00 00 00       	mov    eax,0x1
     faf:	ba 00 00 00 00       	mov    edx,0x0
     fb4:	0f a5 c2             	shld   edx,eax,cl
     fb7:	d3 e0                	shl    eax,cl
     fb9:	f6 c1 20             	test   cl,0x20
     fbc:	74 04                	je     fc2 <__udivdi3+0x110>
     fbe:	89 c2                	mov    edx,eax
     fc0:	31 c0                	xor    eax,eax
     fc2:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     fc5:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (k > 0)
     fc8:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
     fcc:	0f 84 a6 00 00 00    	je     1078 <__udivdi3+0x1c6>
						y = y >> 1;
     fd2:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     fd5:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     fd8:	0f ac d0 01          	shrd   eax,edx,0x1
     fdc:	d1 ea                	shr    edx,1
     fde:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     fe1:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						i = k;
     fe4:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     fe7:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								if (r >= y)
     fea:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     fed:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     ff0:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     ff3:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
     ff6:	19 d1                	sbb    ecx,edx
     ff8:	72 1e                	jb     1018 <__udivdi3+0x166>
										r = ((r - y) << 1) + 1;
     ffa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     ffd:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1000:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    1003:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
    1006:	01 c0                	add    eax,eax
    1008:	11 d2                	adc    edx,edx
    100a:	83 c0 01             	add    eax,0x1
    100d:	83 d2 00             	adc    edx,0x0
    1010:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1013:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1016:	eb 10                	jmp    1028 <__udivdi3+0x176>
										r =  (r << 1);
    1018:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    101b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    101e:	01 c0                	add    eax,eax
    1020:	11 d2                	adc    edx,edx
    1022:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1025:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
								i = i - 1;
    1028:	83 6d c0 01          	sub    DWORD PTR [ebp-0x40],0x1
						} while (i != 0);
    102c:	83 7d c0 00          	cmp    DWORD PTR [ebp-0x40],0x0
    1030:	75 b8                	jne    fea <__udivdi3+0x138>
						q = q + r;
    1032:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1035:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1038:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
    103b:	11 55 e4             	adc    DWORD PTR [ebp-0x1c],edx
						r = r >> k;
    103e:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    1041:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1044:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1047:	0f ad d0             	shrd   eax,edx,cl
    104a:	d3 ea                	shr    edx,cl
    104c:	f6 c1 20             	test   cl,0x20
    104f:	74 04                	je     1055 <__udivdi3+0x1a3>
    1051:	89 d0                	mov    eax,edx
    1053:	31 d2                	xor    edx,edx
    1055:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1058:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
						q = q - (r << k);
    105b:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    105e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1061:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1064:	0f a5 c2             	shld   edx,eax,cl
    1067:	d3 e0                	shl    eax,cl
    1069:	f6 c1 20             	test   cl,0x20
    106c:	74 04                	je     1072 <__udivdi3+0x1c0>
    106e:	89 c2                	mov    edx,eax
    1070:	31 c0                	xor    eax,eax
    1072:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
    1075:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
		if (rp)
    1078:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    107c:	74 0e                	je     108c <__udivdi3+0x1da>
				*rp = r;
    107e:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1081:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1084:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1087:	89 01                	mov    DWORD PTR [ecx],eax
    1089:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return q;
    108c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    108f:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
		return __udivmoddi4 (n, d, (UDWtype *) 0);
}
    1092:	c9                   	leave
    1093:	c3                   	ret

00001094 <__moddi3>:

DWtype
__moddi3 (DWtype u, DWtype v)
{
    1094:	55                   	push   ebp
    1095:	89 e5                	mov    ebp,esp
    1097:	53                   	push   ebx
    1098:	83 ec 74             	sub    esp,0x74
    109b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    109e:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    10a1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    10a4:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    10a7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    10aa:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
    10ad:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    10b0:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		Wtype c = 0;
    10b3:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		DWunion uu = {.ll = u};
    10ba:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    10bd:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    10c0:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    10c3:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
		DWunion vv = {.ll = v};
    10c6:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    10c9:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
    10cc:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    10cf:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		DWtype w;
	
		if (uu.s.high < 0)
    10d2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    10d5:	85 c0                	test   eax,eax
    10d7:	79 16                	jns    10ef <__moddi3+0x5b>
				c = ~c,
    10d9:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
					uu.ll = -uu.ll;
    10dc:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    10df:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    10e2:	f7 d8                	neg    eax
    10e4:	83 d2 00             	adc    edx,0x0
    10e7:	f7 da                	neg    edx
    10e9:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    10ec:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
		if (vv.s.high < 0)
    10ef:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    10f2:	85 c0                	test   eax,eax
    10f4:	79 13                	jns    1109 <__moddi3+0x75>
				vv.ll = -vv.ll;
    10f6:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    10f9:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    10fc:	f7 d8                	neg    eax
    10fe:	83 d2 00             	adc    edx,0x0
    1101:	f7 da                	neg    edx
    1103:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1106:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
	
		(void) __udivmoddi4 (uu.ll, vv.ll, (UDWtype*)&w);
    1109:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    110c:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    110f:	89 c1                	mov    ecx,eax
    1111:	89 d3                	mov    ebx,edx
    1113:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    1116:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    1119:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    111c:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    111f:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
    1122:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
    1125:	8d 45 98             	lea    eax,[ebp-0x68]
    1128:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		UDWtype q = 0, r = n, y = d;
    112b:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    1132:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    1139:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    113c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    113f:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1142:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    1145:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1148:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    114b:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    114e:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
		if (y <= r)
    1151:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1154:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1157:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
    115a:	89 d0                	mov    eax,edx
    115c:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
    115f:	0f 82 4f 01 00 00    	jb     12b4 <__moddi3+0x220>
				lz1 = __builtin_clzll (d);
    1165:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1168:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    116b:	85 d2                	test   edx,edx
    116d:	74 08                	je     1177 <__moddi3+0xe3>
    116f:	0f bd c2             	bsr    eax,edx
    1172:	83 f0 1f             	xor    eax,0x1f
    1175:	eb 09                	jmp    1180 <__moddi3+0xec>
    1177:	0f bd c0             	bsr    eax,eax
    117a:	83 f0 1f             	xor    eax,0x1f
    117d:	83 c0 20             	add    eax,0x20
    1180:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				lz2 = __builtin_clzll (n);
    1183:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1186:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1189:	85 d2                	test   edx,edx
    118b:	74 08                	je     1195 <__moddi3+0x101>
    118d:	0f bd c2             	bsr    eax,edx
    1190:	83 f0 1f             	xor    eax,0x1f
    1193:	eb 09                	jmp    119e <__moddi3+0x10a>
    1195:	0f bd c0             	bsr    eax,eax
    1198:	83 f0 1f             	xor    eax,0x1f
    119b:	83 c0 20             	add    eax,0x20
    119e:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				k = lz1 - lz2;
    11a1:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    11a4:	2b 45 b8             	sub    eax,DWORD PTR [ebp-0x48]
    11a7:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				y = (y << k);
    11aa:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    11ad:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    11b0:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    11b3:	0f a5 c2             	shld   edx,eax,cl
    11b6:	d3 e0                	shl    eax,cl
    11b8:	f6 c1 20             	test   cl,0x20
    11bb:	74 04                	je     11c1 <__moddi3+0x12d>
    11bd:	89 c2                	mov    edx,eax
    11bf:	31 c0                	xor    eax,eax
    11c1:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    11c4:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
				if (r >= y)
    11c7:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    11ca:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    11cd:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
    11d0:	89 d0                	mov    eax,edx
    11d2:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
    11d5:	72 2d                	jb     1204 <__moddi3+0x170>
						r = r - y;
    11d7:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    11da:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    11dd:	29 45 c8             	sub    DWORD PTR [ebp-0x38],eax
    11e0:	19 55 cc             	sbb    DWORD PTR [ebp-0x34],edx
						q =  (1ULL << k);
    11e3:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    11e6:	b8 01 00 00 00       	mov    eax,0x1
    11eb:	ba 00 00 00 00       	mov    edx,0x0
    11f0:	0f a5 c2             	shld   edx,eax,cl
    11f3:	d3 e0                	shl    eax,cl
    11f5:	f6 c1 20             	test   cl,0x20
    11f8:	74 04                	je     11fe <__moddi3+0x16a>
    11fa:	89 c2                	mov    edx,eax
    11fc:	31 c0                	xor    eax,eax
    11fe:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1201:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (k > 0)
    1204:	83 7d b4 00          	cmp    DWORD PTR [ebp-0x4c],0x0
    1208:	0f 84 a6 00 00 00    	je     12b4 <__moddi3+0x220>
						y = y >> 1;
    120e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1211:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1214:	0f ac d0 01          	shrd   eax,edx,0x1
    1218:	d1 ea                	shr    edx,1
    121a:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    121d:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
						i = k;
    1220:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1223:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								if (r >= y)
    1226:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1229:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    122c:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
    122f:	39 45 c8             	cmp    DWORD PTR [ebp-0x38],eax
    1232:	19 d1                	sbb    ecx,edx
    1234:	72 1e                	jb     1254 <__moddi3+0x1c0>
										r = ((r - y) << 1) + 1;
    1236:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1239:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    123c:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    123f:	1b 55 c4             	sbb    edx,DWORD PTR [ebp-0x3c]
    1242:	01 c0                	add    eax,eax
    1244:	11 d2                	adc    edx,edx
    1246:	83 c0 01             	add    eax,0x1
    1249:	83 d2 00             	adc    edx,0x0
    124c:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    124f:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    1252:	eb 10                	jmp    1264 <__moddi3+0x1d0>
										r =  (r << 1);
    1254:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1257:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    125a:	01 c0                	add    eax,eax
    125c:	11 d2                	adc    edx,edx
    125e:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1261:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
								i = i - 1;
    1264:	83 6d b0 01          	sub    DWORD PTR [ebp-0x50],0x1
						} while (i != 0);
    1268:	83 7d b0 00          	cmp    DWORD PTR [ebp-0x50],0x0
    126c:	75 b8                	jne    1226 <__moddi3+0x192>
						q = q + r;
    126e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1271:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1274:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
    1277:	11 55 d4             	adc    DWORD PTR [ebp-0x2c],edx
						r = r >> k;
    127a:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    127d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1280:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1283:	0f ad d0             	shrd   eax,edx,cl
    1286:	d3 ea                	shr    edx,cl
    1288:	f6 c1 20             	test   cl,0x20
    128b:	74 04                	je     1291 <__moddi3+0x1fd>
    128d:	89 d0                	mov    eax,edx
    128f:	31 d2                	xor    edx,edx
    1291:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1294:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						q = q - (r << k);
    1297:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    129a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    129d:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    12a0:	0f a5 c2             	shld   edx,eax,cl
    12a3:	d3 e0                	shl    eax,cl
    12a5:	f6 c1 20             	test   cl,0x20
    12a8:	74 04                	je     12ae <__moddi3+0x21a>
    12aa:	89 c2                	mov    edx,eax
    12ac:	31 c0                	xor    eax,eax
    12ae:	29 45 d0             	sub    DWORD PTR [ebp-0x30],eax
    12b1:	19 55 d4             	sbb    DWORD PTR [ebp-0x2c],edx
		if (rp)
    12b4:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    12b8:	74 0e                	je     12c8 <__moddi3+0x234>
				*rp = r;
    12ba:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    12bd:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    12c0:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    12c3:	89 01                	mov    DWORD PTR [ecx],eax
    12c5:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		if (c)
    12c8:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    12cc:	74 13                	je     12e1 <__moddi3+0x24d>
				w = -w;
    12ce:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    12d1:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    12d4:	f7 d8                	neg    eax
    12d6:	83 d2 00             	adc    edx,0x0
    12d9:	f7 da                	neg    edx
    12db:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    12de:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
	
		return w;
    12e1:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    12e4:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
}
    12e7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    12ea:	c9                   	leave
    12eb:	c3                   	ret

000012ec <__divdi3>:

DWtype
__divdi3 (DWtype u, DWtype v)
{
    12ec:	55                   	push   ebp
    12ed:	89 e5                	mov    ebp,esp
    12ef:	53                   	push   ebx
    12f0:	83 ec 74             	sub    esp,0x74
    12f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12f6:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    12f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12fc:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    12ff:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1302:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
    1305:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1308:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		Wtype c = 0;
    130b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		DWunion uu = {.ll = u};
    1312:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1315:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    1318:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    131b:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		DWunion vv = {.ll = v};
    131e:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    1321:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
    1324:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    1327:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
		DWtype w;
	
		if (uu.s.high < 0)
    132a:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    132d:	85 c0                	test   eax,eax
    132f:	79 16                	jns    1347 <__divdi3+0x5b>
				c = ~c,
    1331:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
				  uu.ll = -uu.ll;
    1334:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1337:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    133a:	f7 d8                	neg    eax
    133c:	83 d2 00             	adc    edx,0x0
    133f:	f7 da                	neg    edx
    1341:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1344:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		if (vv.s.high < 0)
    1347:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    134a:	85 c0                	test   eax,eax
    134c:	79 16                	jns    1364 <__divdi3+0x78>
				c = ~c,
    134e:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
				  vv.ll = -vv.ll;
    1351:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    1354:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    1357:	f7 d8                	neg    eax
    1359:	83 d2 00             	adc    edx,0x0
    135c:	f7 da                	neg    edx
    135e:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    1361:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
	
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
    1364:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    1367:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    136a:	89 c1                	mov    ecx,eax
    136c:	89 d3                	mov    ebx,edx
    136e:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1371:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1374:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1377:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    137a:	89 4d d8             	mov    DWORD PTR [ebp-0x28],ecx
    137d:	89 5d dc             	mov    DWORD PTR [ebp-0x24],ebx
    1380:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		UDWtype q = 0, r = n, y = d;
    1387:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    138e:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    1395:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1398:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    139b:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    139e:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
    13a1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13a4:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    13a7:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    13aa:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
		if (y <= r)
    13ad:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    13b0:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    13b3:	3b 45 b8             	cmp    eax,DWORD PTR [ebp-0x48]
    13b6:	89 d0                	mov    eax,edx
    13b8:	1b 45 bc             	sbb    eax,DWORD PTR [ebp-0x44]
    13bb:	0f 82 4f 01 00 00    	jb     1510 <__divdi3+0x224>
				lz1 = __builtin_clzll (d);
    13c1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13c4:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    13c7:	85 d2                	test   edx,edx
    13c9:	74 08                	je     13d3 <__divdi3+0xe7>
    13cb:	0f bd c2             	bsr    eax,edx
    13ce:	83 f0 1f             	xor    eax,0x1f
    13d1:	eb 09                	jmp    13dc <__divdi3+0xf0>
    13d3:	0f bd c0             	bsr    eax,eax
    13d6:	83 f0 1f             	xor    eax,0x1f
    13d9:	83 c0 20             	add    eax,0x20
    13dc:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				lz2 = __builtin_clzll (n);
    13df:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13e2:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    13e5:	85 d2                	test   edx,edx
    13e7:	74 08                	je     13f1 <__divdi3+0x105>
    13e9:	0f bd c2             	bsr    eax,edx
    13ec:	83 f0 1f             	xor    eax,0x1f
    13ef:	eb 09                	jmp    13fa <__divdi3+0x10e>
    13f1:	0f bd c0             	bsr    eax,eax
    13f4:	83 f0 1f             	xor    eax,0x1f
    13f7:	83 c0 20             	add    eax,0x20
    13fa:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
				k = lz1 - lz2;
    13fd:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1400:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    1403:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
				y = (y << k);
    1406:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    1409:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    140c:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    140f:	0f a5 c2             	shld   edx,eax,cl
    1412:	d3 e0                	shl    eax,cl
    1414:	f6 c1 20             	test   cl,0x20
    1417:	74 04                	je     141d <__divdi3+0x131>
    1419:	89 c2                	mov    edx,eax
    141b:	31 c0                	xor    eax,eax
    141d:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1420:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
				if (r >= y)
    1423:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1426:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1429:	3b 45 b8             	cmp    eax,DWORD PTR [ebp-0x48]
    142c:	89 d0                	mov    eax,edx
    142e:	1b 45 bc             	sbb    eax,DWORD PTR [ebp-0x44]
    1431:	72 2d                	jb     1460 <__divdi3+0x174>
						r = r - y;
    1433:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1436:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1439:	29 45 c0             	sub    DWORD PTR [ebp-0x40],eax
    143c:	19 55 c4             	sbb    DWORD PTR [ebp-0x3c],edx
						q =  (1ULL << k);
    143f:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    1442:	b8 01 00 00 00       	mov    eax,0x1
    1447:	ba 00 00 00 00       	mov    edx,0x0
    144c:	0f a5 c2             	shld   edx,eax,cl
    144f:	d3 e0                	shl    eax,cl
    1451:	f6 c1 20             	test   cl,0x20
    1454:	74 04                	je     145a <__divdi3+0x16e>
    1456:	89 c2                	mov    edx,eax
    1458:	31 c0                	xor    eax,eax
    145a:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    145d:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (k > 0)
    1460:	83 7d ac 00          	cmp    DWORD PTR [ebp-0x54],0x0
    1464:	0f 84 a6 00 00 00    	je     1510 <__divdi3+0x224>
						y = y >> 1;
    146a:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    146d:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1470:	0f ac d0 01          	shrd   eax,edx,0x1
    1474:	d1 ea                	shr    edx,1
    1476:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1479:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
						i = k;
    147c:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    147f:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
								if (r >= y)
    1482:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1485:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1488:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    148b:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    148e:	19 d1                	sbb    ecx,edx
    1490:	72 1e                	jb     14b0 <__divdi3+0x1c4>
										r = ((r - y) << 1) + 1;
    1492:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1495:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1498:	2b 45 b8             	sub    eax,DWORD PTR [ebp-0x48]
    149b:	1b 55 bc             	sbb    edx,DWORD PTR [ebp-0x44]
    149e:	01 c0                	add    eax,eax
    14a0:	11 d2                	adc    edx,edx
    14a2:	83 c0 01             	add    eax,0x1
    14a5:	83 d2 00             	adc    edx,0x0
    14a8:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    14ab:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
    14ae:	eb 10                	jmp    14c0 <__divdi3+0x1d4>
										r =  (r << 1);
    14b0:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14b3:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14b6:	01 c0                	add    eax,eax
    14b8:	11 d2                	adc    edx,edx
    14ba:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    14bd:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								i = i - 1;
    14c0:	83 6d a8 01          	sub    DWORD PTR [ebp-0x58],0x1
						} while (i != 0);
    14c4:	83 7d a8 00          	cmp    DWORD PTR [ebp-0x58],0x0
    14c8:	75 b8                	jne    1482 <__divdi3+0x196>
						q = q + r;
    14ca:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14cd:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14d0:	01 45 c8             	add    DWORD PTR [ebp-0x38],eax
    14d3:	11 55 cc             	adc    DWORD PTR [ebp-0x34],edx
						r = r >> k;
    14d6:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    14d9:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14dc:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14df:	0f ad d0             	shrd   eax,edx,cl
    14e2:	d3 ea                	shr    edx,cl
    14e4:	f6 c1 20             	test   cl,0x20
    14e7:	74 04                	je     14ed <__divdi3+0x201>
    14e9:	89 d0                	mov    eax,edx
    14eb:	31 d2                	xor    edx,edx
    14ed:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    14f0:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
						q = q - (r << k);
    14f3:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    14f6:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14f9:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14fc:	0f a5 c2             	shld   edx,eax,cl
    14ff:	d3 e0                	shl    eax,cl
    1501:	f6 c1 20             	test   cl,0x20
    1504:	74 04                	je     150a <__divdi3+0x21e>
    1506:	89 c2                	mov    edx,eax
    1508:	31 c0                	xor    eax,eax
    150a:	29 45 c8             	sub    DWORD PTR [ebp-0x38],eax
    150d:	19 55 cc             	sbb    DWORD PTR [ebp-0x34],edx
		if (rp)
    1510:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1514:	74 0e                	je     1524 <__divdi3+0x238>
				*rp = r;
    1516:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1519:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    151c:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    151f:	89 01                	mov    DWORD PTR [ecx],eax
    1521:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return q;
    1524:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1527:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
    152a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    152d:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (c)
    1530:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1534:	74 0a                	je     1540 <__divdi3+0x254>
				w = -w;
    1536:	f7 5d e8             	neg    DWORD PTR [ebp-0x18]
    1539:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0
    153d:	f7 5d ec             	neg    DWORD PTR [ebp-0x14]
	
		return w;
    1540:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1543:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
}
    1546:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1549:	c9                   	leave
    154a:	c3                   	ret
