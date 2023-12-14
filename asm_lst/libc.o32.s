
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
     261:	83 ec 14             	sub    esp,0x14
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
     299:	e9 f1 01 00 00       	jmp    48f <strtol+0x231>
		}
		while (isspace(*str))
				str++;
     29e:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (isspace(*str))
     2a2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2a5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2a8:	0f be c0             	movsx  eax,al
     2ab:	89 04 24             	mov    DWORD PTR [esp],eax
     2ae:	e8 fc ff ff ff       	call   2af <strtol+0x51>
     2b3:	85 c0                	test   eax,eax
     2b5:	75 e7                	jne    29e <strtol+0x40>
		if (!base) {
     2b7:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     2bb:	75 3d                	jne    2fa <strtol+0x9c>
				/* read prefix */
				if (*str == '0') {
     2bd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2c0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2c3:	3c 30                	cmp    al,0x30
     2c5:	75 2c                	jne    2f3 <strtol+0x95>
						base = 8;
     2c7:	c7 45 10 08 00 00 00 	mov    DWORD PTR [ebp+0x10],0x8
						str++;
     2ce:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
						if (*str == 'x' || *str == 'X') {
     2d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2d5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2d8:	3c 78                	cmp    al,0x78
     2da:	74 0a                	je     2e6 <strtol+0x88>
     2dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2df:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2e2:	3c 58                	cmp    al,0x58
     2e4:	75 14                	jne    2fa <strtol+0x9c>
								base = 16;
     2e6:	c7 45 10 10 00 00 00 	mov    DWORD PTR [ebp+0x10],0x10
								str++;
     2ed:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
     2f1:	eb 07                	jmp    2fa <strtol+0x9c>
						}
				} else
						base = 10;
     2f3:	c7 45 10 0a 00 00 00 	mov    DWORD PTR [ebp+0x10],0xa
		}
		num_max = ((base >= 10) ? '9' : ('0' + base - 1));
     2fa:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2fd:	ba 0a 00 00 00       	mov    edx,0xa
     302:	39 d0                	cmp    eax,edx
     304:	0f 4f c2             	cmovg  eax,edx
     307:	83 c0 2f             	add    eax,0x2f
     30a:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
		char_max = ((base <= 10) ? ('A' - 1) : ('A' + base - 11));
     30d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     310:	ba 0a 00 00 00       	mov    edx,0xa
     315:	39 d0                	cmp    eax,edx
     317:	0f 4c c2             	cmovl  eax,edx
     31a:	83 c0 36             	add    eax,0x36
     31d:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
		char2_max = ((base <= 10) ? ('a' - 1) : ('a' + base - 11));
     320:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     323:	ba 0a 00 00 00       	mov    edx,0xa
     328:	39 d0                	cmp    eax,edx
     32a:	0f 4c c2             	cmovl  eax,edx
     32d:	83 c0 56             	add    eax,0x56
     330:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		if (*str == '-' || *str == '+')
     333:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     336:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     339:	3c 2d                	cmp    al,0x2d
     33b:	74 0a                	je     347 <strtol+0xe9>
     33d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     340:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     343:	3c 2b                	cmp    al,0x2b
     345:	75 17                	jne    35e <strtol+0x100>
				isN = (*str++ == '-');
     347:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     34a:	8d 50 01             	lea    edx,[eax+0x1]
     34d:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
     350:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     353:	3c 2d                	cmp    al,0x2d
     355:	0f 94 c0             	sete   al
     358:	0f b6 c0             	movzx  eax,al
     35b:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		while (1) {
				uint8_t addv = 0xff;
     35e:	c6 45 f7 ff          	mov    BYTE PTR [ebp-0x9],0xff
				if(*str >= '0' && *str <= num_max)
     362:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     365:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     368:	3c 2f                	cmp    al,0x2f
     36a:	7e 19                	jle    385 <strtol+0x127>
     36c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     36f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     372:	38 45 f6             	cmp    BYTE PTR [ebp-0xa],al
     375:	7c 0e                	jl     385 <strtol+0x127>
						addv = *str - '0';
     377:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     37a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     37d:	83 e8 30             	sub    eax,0x30
     380:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
     383:	eb 44                	jmp    3c9 <strtol+0x16b>
				else if (*str >= 'A' && *str <= char_max)
     385:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     388:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     38b:	3c 40                	cmp    al,0x40
     38d:	7e 19                	jle    3a8 <strtol+0x14a>
     38f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     392:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     395:	38 45 f5             	cmp    BYTE PTR [ebp-0xb],al
     398:	7c 0e                	jl     3a8 <strtol+0x14a>
						addv = (*str - 'A') + 10;
     39a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     39d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3a0:	83 e8 37             	sub    eax,0x37
     3a3:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
     3a6:	eb 21                	jmp    3c9 <strtol+0x16b>
				else if (*str >= 'a' && *str <= char2_max)
     3a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3ab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3ae:	3c 60                	cmp    al,0x60
     3b0:	7e 17                	jle    3c9 <strtol+0x16b>
     3b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3b8:	38 45 f4             	cmp    BYTE PTR [ebp-0xc],al
     3bb:	7c 0c                	jl     3c9 <strtol+0x16b>
						addv = (*str - 'a') + 10;
     3bd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3c3:	83 e8 57             	sub    eax,0x57
     3c6:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al

				if (addv == 0xff) {
     3c9:	80 7d f7 ff          	cmp    BYTE PTR [ebp-0x9],0xff
     3cd:	75 50                	jne    41f <strtol+0x1c1>
						if (endptr)
     3cf:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     3d3:	74 08                	je     3dd <strtol+0x17f>
								*endptr = (char*)str;
     3d5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3d8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     3db:	89 10                	mov    DWORD PTR [eax],edx
						if (isN == 2 || isN == 3) {
     3dd:	83 7d f8 02          	cmp    DWORD PTR [ebp-0x8],0x2
     3e1:	74 06                	je     3e9 <strtol+0x18b>
     3e3:	83 7d f8 03          	cmp    DWORD PTR [ebp-0x8],0x3
     3e7:	75 24                	jne    40d <strtol+0x1af>
								errno = ERANGE;
     3e9:	c7 05 00 00 00 00 22 00 00 00 	mov    DWORD PTR ds:0x0,0x22
								return isN == 2 ? LONG_MAX : LONG_MIN;
     3f3:	83 7d f8 02          	cmp    DWORD PTR [ebp-0x8],0x2
     3f7:	75 0a                	jne    403 <strtol+0x1a5>
     3f9:	b8 ff ff ff 7f       	mov    eax,0x7fffffff
     3fe:	e9 8c 00 00 00       	jmp    48f <strtol+0x231>
     403:	b8 00 00 00 80       	mov    eax,0x80000000
     408:	e9 82 00 00 00       	jmp    48f <strtol+0x231>
						}
						return isN ? -rv : rv;
     40d:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     411:	74 07                	je     41a <strtol+0x1bc>
     413:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     416:	f7 d8                	neg    eax
     418:	eb 75                	jmp    48f <strtol+0x231>
     41a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     41d:	eb 70                	jmp    48f <strtol+0x231>
				} else {
						if (isN == 0) {
     41f:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     423:	75 30                	jne    455 <strtol+0x1f7>
								if (rv * base + addv > LONG_MAX)
     425:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     428:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     42c:	89 c2                	mov    edx,eax
     42e:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     432:	01 d0                	add    eax,edx
     434:	85 c0                	test   eax,eax
     436:	79 09                	jns    441 <strtol+0x1e3>
										isN = 2;
     438:	c7 45 f8 02 00 00 00 	mov    DWORD PTR [ebp-0x8],0x2
     43f:	eb 45                	jmp    486 <strtol+0x228>
								else
										rv = rv * base + addv;
     441:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     444:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     448:	89 c2                	mov    edx,eax
     44a:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     44e:	01 d0                	add    eax,edx
     450:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     453:	eb 31                	jmp    486 <strtol+0x228>
						} else {
								if ((rv * base + addv) > (unsigned long int)(LONG_MAX) + 1)
     455:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     458:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     45c:	89 c2                	mov    edx,eax
     45e:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     462:	01 d0                	add    eax,edx
     464:	3d 00 00 00 80       	cmp    eax,0x80000000
     469:	76 09                	jbe    474 <strtol+0x216>
										isN = 3;
     46b:	c7 45 f8 03 00 00 00 	mov    DWORD PTR [ebp-0x8],0x3
     472:	eb 12                	jmp    486 <strtol+0x228>
								else
										rv = rv * base + addv;
     474:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     477:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     47b:	89 c2                	mov    edx,eax
     47d:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     481:	01 d0                	add    eax,edx
     483:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						}
				}
				str++;
     486:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (1) {
     48a:	e9 cf fe ff ff       	jmp    35e <strtol+0x100>
		}
}
     48f:	c9                   	leave
     490:	c3                   	ret

00000491 <atoi>:

int atoi(const char* str)
{
     491:	55                   	push   ebp
     492:	89 e5                	mov    ebp,esp
     494:	83 ec 14             	sub    esp,0x14
		unsigned int rv = 0, isN = 0;
     497:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     49e:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		if (!str)
     4a5:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     4a9:	75 0e                	jne    4b9 <atoi+0x28>
				return 0;
     4ab:	b8 00 00 00 00       	mov    eax,0x0
     4b0:	e9 91 00 00 00       	jmp    546 <atoi+0xb5>
		while (isspace(*str))
				str++;
     4b5:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (isspace(*str))
     4b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4bc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4bf:	0f be c0             	movsx  eax,al
     4c2:	89 04 24             	mov    DWORD PTR [esp],eax
     4c5:	e8 fc ff ff ff       	call   4c6 <atoi+0x35>
     4ca:	85 c0                	test   eax,eax
     4cc:	75 e7                	jne    4b5 <atoi+0x24>
		if (*str == '-') {
     4ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4d1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4d4:	3c 2d                	cmp    al,0x2d
     4d6:	75 0d                	jne    4e5 <atoi+0x54>
				isN = 1;
     4d8:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [ebp-0x8],0x1
				str++;
     4df:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
     4e3:	eb 37                	jmp    51c <atoi+0x8b>
		} else if (*str == '+')
     4e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4e8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4eb:	3c 2b                	cmp    al,0x2b
     4ed:	75 2d                	jne    51c <atoi+0x8b>
				str++;
     4ef:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str >= '0' && *str <= '9') {
     4f3:	eb 27                	jmp    51c <atoi+0x8b>
				rv *= 10;
     4f5:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     4f8:	89 d0                	mov    eax,edx
     4fa:	c1 e0 02             	shl    eax,0x2
     4fd:	01 d0                	add    eax,edx
     4ff:	01 c0                	add    eax,eax
     501:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				rv += *str - '0';
     504:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     507:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     50a:	0f be d0             	movsx  edx,al
     50d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     510:	01 d0                	add    eax,edx
     512:	83 e8 30             	sub    eax,0x30
     515:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				str++;
     518:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str >= '0' && *str <= '9') {
     51c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     51f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     522:	3c 2f                	cmp    al,0x2f
     524:	7e 0a                	jle    530 <atoi+0x9f>
     526:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     529:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     52c:	3c 39                	cmp    al,0x39
     52e:	7e c5                	jle    4f5 <atoi+0x64>
		}
		if (isN && rv)
     530:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     534:	74 0d                	je     543 <atoi+0xb2>
     536:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     53a:	74 07                	je     543 <atoi+0xb2>
				return (int)-rv;
     53c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     53f:	f7 d8                	neg    eax
     541:	eb 03                	jmp    546 <atoi+0xb5>
		else
				return (int)rv;
     543:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]

}
     546:	c9                   	leave
     547:	c3                   	ret

00000548 <strchr>:

char* strchr(const char* str, int character)
{
     548:	55                   	push   ebp
     549:	89 e5                	mov    ebp,esp
		if (!str)
     54b:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     54f:	75 1c                	jne    56d <strchr+0x25>
				return NULL;
     551:	b8 00 00 00 00       	mov    eax,0x0
     556:	eb 25                	jmp    57d <strchr+0x35>
		while (*str != (char)character)
				if (*str == '\0')
     558:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     55b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     55e:	84 c0                	test   al,al
     560:	75 07                	jne    569 <strchr+0x21>
						return NULL;
     562:	b8 00 00 00 00       	mov    eax,0x0
     567:	eb 14                	jmp    57d <strchr+0x35>
				else
						str++;
     569:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str != (char)character)
     56d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     570:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     573:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     576:	38 d0                	cmp    al,dl
     578:	75 de                	jne    558 <strchr+0x10>
		return (char*)str;
     57a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
     57d:	5d                   	pop    ebp
     57e:	c3                   	ret

0000057f <strndup>:

char* strndup(const char* s, size_t n)
{
     57f:	55                   	push   ebp
     580:	89 e5                	mov    ebp,esp
     582:	83 ec 28             	sub    esp,0x28
		size_t l; char* rv;
		if (!s)
     585:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     589:	75 07                	jne    592 <strndup+0x13>
				return NULL;
     58b:	b8 00 00 00 00       	mov    eax,0x0
     590:	eb 7c                	jmp    60e <strndup+0x8f>
		l = strlen(s);
     592:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     595:	89 04 24             	mov    DWORD PTR [esp],eax
     598:	e8 fc ff ff ff       	call   599 <strndup+0x1a>
     59d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv = kmalloc(1 + (l = min(l, n)));
     5a0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     5a3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5a6:	39 c2                	cmp    edx,eax
     5a8:	0f 46 c2             	cmovbe eax,edx
     5ab:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     5ae:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     5b1:	83 c0 01             	add    eax,0x1
     5b4:	89 04 24             	mov    DWORD PTR [esp],eax
     5b7:	e8 fc ff ff ff       	call   5b8 <strndup+0x39>
     5bc:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!rv) {
     5bf:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     5c3:	75 11                	jne    5d6 <strndup+0x57>
				errno = ENOMEM;
     5c5:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
				return NULL;
     5cf:	b8 00 00 00 00       	mov    eax,0x0
     5d4:	eb 38                	jmp    60e <strndup+0x8f>
		}
		for (n = 0; n < l; n++)
     5d6:	c7 45 0c 00 00 00 00 	mov    DWORD PTR [ebp+0xc],0x0
     5dd:	eb 19                	jmp    5f8 <strndup+0x79>
				rv[n] = s[n];
     5df:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     5e2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5e5:	01 d0                	add    eax,edx
     5e7:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     5ea:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     5ed:	01 ca                	add    edx,ecx
     5ef:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     5f2:	88 02                	mov    BYTE PTR [edx],al
		for (n = 0; n < l; n++)
     5f4:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
     5f8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5fb:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
     5fe:	72 df                	jb     5df <strndup+0x60>
		rv[n] = '\0';
     600:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     603:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     606:	01 d0                	add    eax,edx
     608:	c6 00 00             	mov    BYTE PTR [eax],0x0
		return rv;
     60b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     60e:	c9                   	leave
     60f:	c3                   	ret

00000610 <strdup>:

char* strdup(const char* s)
{
     610:	55                   	push   ebp
     611:	89 e5                	mov    ebp,esp
     613:	83 ec 28             	sub    esp,0x28
		char* rv; size_t l, n;
		if (!s)
     616:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     61a:	75 07                	jne    623 <strdup+0x13>
				return NULL;
     61c:	b8 00 00 00 00       	mov    eax,0x0
     621:	eb 57                	jmp    67a <strdup+0x6a>
		l = strlen(s) + 1;
     623:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     626:	89 04 24             	mov    DWORD PTR [esp],eax
     629:	e8 fc ff ff ff       	call   62a <strdup+0x1a>
     62e:	83 c0 01             	add    eax,0x1
     631:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv = kmalloc(l);
     634:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     637:	89 04 24             	mov    DWORD PTR [esp],eax
     63a:	e8 fc ff ff ff       	call   63b <strdup+0x2b>
     63f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		for (n = 0; n < l; n++)
     642:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     649:	eb 19                	jmp    664 <strdup+0x54>
				rv[n] = s[n];
     64b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     64e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     651:	01 d0                	add    eax,edx
     653:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     656:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     659:	01 ca                	add    edx,ecx
     65b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     65e:	88 02                	mov    BYTE PTR [edx],al
		for (n = 0; n < l; n++)
     660:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     664:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     667:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
     66a:	72 df                	jb     64b <strdup+0x3b>
		rv[n] = '\0';
     66c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     66f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     672:	01 d0                	add    eax,edx
     674:	c6 00 00             	mov    BYTE PTR [eax],0x0
		return rv;
     677:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
     67a:	c9                   	leave
     67b:	c3                   	ret

0000067c <strncpy>:

char* strncpy(char* dest, const char* src, size_t n)
{
     67c:	55                   	push   ebp
     67d:	89 e5                	mov    ebp,esp
     67f:	83 ec 10             	sub    esp,0x10
		size_t i;
		if (!dest)
     682:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     686:	75 07                	jne    68f <strncpy+0x13>
				return NULL;
     688:	b8 00 00 00 00       	mov    eax,0x0
     68d:	eb 58                	jmp    6e7 <strncpy+0x6b>
		for (i = 0; i < n; i++) {
     68f:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     696:	eb 44                	jmp    6dc <strncpy+0x60>
				dest[i] = src ? *src : '\0';
     698:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     69c:	74 08                	je     6a6 <strncpy+0x2a>
     69e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6a1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     6a4:	eb 05                	jmp    6ab <strncpy+0x2f>
     6a6:	b8 00 00 00 00       	mov    eax,0x0
     6ab:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     6ae:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     6b1:	01 ca                	add    edx,ecx
     6b3:	88 02                	mov    BYTE PTR [edx],al
				if (src && !(*src))
     6b5:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     6b9:	74 13                	je     6ce <strncpy+0x52>
     6bb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6be:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     6c1:	84 c0                	test   al,al
     6c3:	75 09                	jne    6ce <strncpy+0x52>
						src = NULL;
     6c5:	c7 45 0c 00 00 00 00 	mov    DWORD PTR [ebp+0xc],0x0
     6cc:	eb 0a                	jmp    6d8 <strncpy+0x5c>
				else if (src)
     6ce:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     6d2:	74 04                	je     6d8 <strncpy+0x5c>
						src++;
     6d4:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
		for (i = 0; i < n; i++) {
     6d8:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     6dc:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     6df:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
     6e2:	72 b4                	jb     698 <strncpy+0x1c>
		}
		return dest;
     6e4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
     6e7:	c9                   	leave
     6e8:	c3                   	ret

000006e9 <strcpy>:

char* strcpy(char* dest, char* src)
{
     6e9:	55                   	push   ebp
     6ea:	89 e5                	mov    ebp,esp
     6ec:	83 ec 10             	sub    esp,0x10
		char* rv = dest;
     6ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6f2:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (!dest || !src)
     6f5:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     6f9:	74 06                	je     701 <strcpy+0x18>
     6fb:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     6ff:	75 07                	jne    708 <strcpy+0x1f>
				return NULL;
     701:	b8 00 00 00 00       	mov    eax,0x0
     706:	eb 24                	jmp    72c <strcpy+0x43>
		do {
			*(dest++) = *(src++);
     708:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     70b:	8d 42 01             	lea    eax,[edx+0x1]
     70e:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
     711:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     714:	8d 48 01             	lea    ecx,[eax+0x1]
     717:	89 4d 08             	mov    DWORD PTR [ebp+0x8],ecx
     71a:	0f b6 12             	movzx  edx,BYTE PTR [edx]
     71d:	88 10                	mov    BYTE PTR [eax],dl
		} while (*src);
     71f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     722:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     725:	84 c0                	test   al,al
     727:	75 df                	jne    708 <strcpy+0x1f>
		return rv;
     729:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
     72c:	c9                   	leave
     72d:	c3                   	ret

0000072e <strtok_r>:

char* strtok_r(char* str, const char* delim, char** saveptr)
{
     72e:	55                   	push   ebp
     72f:	89 e5                	mov    ebp,esp
     731:	83 ec 14             	sub    esp,0x14
		size_t l = strlen(delim);
     734:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     737:	89 04 24             	mov    DWORD PTR [esp],eax
     73a:	e8 fc ff ff ff       	call   73b <strtok_r+0xd>
     73f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		if (str)
     742:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     746:	74 08                	je     750 <strtok_r+0x22>
				*saveptr = str;
     748:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     74b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     74e:	89 10                	mov    DWORD PTR [eax],edx
		str = *saveptr;
     750:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     753:	8b 00                	mov    eax,DWORD PTR [eax]
     755:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
		if (!l) { /* return full token only once */
     758:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     75c:	75 7b                	jne    7d9 <strtok_r+0xab>
				*saveptr = NULL;
     75e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     761:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				return str;
     767:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     76a:	e9 98 00 00 00       	jmp    807 <strtok_r+0xd9>
		}
		while (*str) {
				for (size_t i = 0; i < l; i++)
     76f:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     776:	eb 55                	jmp    7cd <strtok_r+0x9f>
						if (*str == delim[i]) {
     778:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     77b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     77e:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     781:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     784:	01 c8                	add    eax,ecx
     786:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     789:	38 c2                	cmp    dl,al
     78b:	75 3c                	jne    7c9 <strtok_r+0x9b>
								*str = '\0';
     78d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     790:	c6 00 00             	mov    BYTE PTR [eax],0x0
								if (strlen(*saveptr)) {
     793:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     796:	8b 00                	mov    eax,DWORD PTR [eax]
     798:	89 04 24             	mov    DWORD PTR [esp],eax
     79b:	e8 fc ff ff ff       	call   79c <strtok_r+0x6e>
     7a0:	85 c0                	test   eax,eax
     7a2:	74 18                	je     7bc <strtok_r+0x8e>
										char* rv = *saveptr;
     7a4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7a7:	8b 00                	mov    eax,DWORD PTR [eax]
     7a9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
										*saveptr = str + 1;
     7ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7af:	8d 50 01             	lea    edx,[eax+0x1]
     7b2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7b5:	89 10                	mov    DWORD PTR [eax],edx
										return rv;
     7b7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7ba:	eb 4b                	jmp    807 <strtok_r+0xd9>
								} else
										*saveptr = str + 1;
     7bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7bf:	8d 50 01             	lea    edx,[eax+0x1]
     7c2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7c5:	89 10                	mov    DWORD PTR [eax],edx
								break;
     7c7:	eb 0c                	jmp    7d5 <strtok_r+0xa7>
				for (size_t i = 0; i < l; i++)
     7c9:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     7cd:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     7d0:	3b 45 f8             	cmp    eax,DWORD PTR [ebp-0x8]
     7d3:	72 a3                	jb     778 <strtok_r+0x4a>
						}
				str++;
     7d5:	83 45 08 01          	add    DWORD PTR [ebp+0x8],0x1
		while (*str) {
     7d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7dc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     7df:	84 c0                	test   al,al
     7e1:	75 8c                	jne    76f <strtok_r+0x41>
		}
		/* in case of no delims return full token once */
		if (str == *saveptr)
     7e3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7e6:	8b 00                	mov    eax,DWORD PTR [eax]
     7e8:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     7eb:	75 07                	jne    7f4 <strtok_r+0xc6>
				return NULL;
     7ed:	b8 00 00 00 00       	mov    eax,0x0
     7f2:	eb 13                	jmp    807 <strtok_r+0xd9>
		else {
				char* rv = *saveptr;
     7f4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7f7:	8b 00                	mov    eax,DWORD PTR [eax]
     7f9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				*saveptr = str;
     7fc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7ff:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     802:	89 10                	mov    DWORD PTR [eax],edx
				return rv;
     804:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
		}
}
     807:	c9                   	leave
     808:	c3                   	ret

00000809 <strtok>:

char* strtok(char* str, const char* delim)
{
     809:	55                   	push   ebp
     80a:	89 e5                	mov    ebp,esp
     80c:	83 ec 0c             	sub    esp,0xc
		static char* ptr;
		return strtok_r(str, delim, &ptr);
     80f:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
     817:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     81a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     81e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     821:	89 04 24             	mov    DWORD PTR [esp],eax
     824:	e8 fc ff ff ff       	call   825 <strtok+0x1c>
}
     829:	c9                   	leave
     82a:	c3                   	ret

0000082b <asctime_r>:

char* asctime_r(const struct tm* timep, char* result)
{
     82b:	55                   	push   ebp
     82c:	89 e5                	mov    ebp,esp
     82e:	57                   	push   edi
     82f:	56                   	push   esi
     830:	53                   	push   ebx
     831:	83 ec 5c             	sub    esp,0x5c
		};
		static char mon_name[12][3] = {
			"Jan", "Feb", "Mar", "Apr", "May", "Jun",
			"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
		};
		char zerobt = 0;
     834:	c6 45 e7 00          	mov    BYTE PTR [ebp-0x19],0x0
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
			wday_name[timep->tm_wday],
			mon_name[timep->tm_mon],
			timep->tm_mday, timep->tm_hour,
			timep->tm_min, timep->tm_sec,
			1900 + timep->tm_year);
     838:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     83b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
     83e:	05 6c 07 00 00       	add    eax,0x76c
     843:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
			timep->tm_min, timep->tm_sec,
     846:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     849:	8b 08                	mov    ecx,DWORD PTR [eax]
     84b:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
     84e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     851:	8b 78 04             	mov    edi,DWORD PTR [eax+0x4]
			timep->tm_mday, timep->tm_hour,
     854:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     857:	8b 70 08             	mov    esi,DWORD PTR [eax+0x8]
     85a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     85d:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
			mon_name[timep->tm_mon],
     860:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     863:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     866:	89 d0                	mov    eax,edx
     868:	01 c0                	add    eax,eax
     86a:	01 d0                	add    eax,edx
     86c:	8d 88 00 00 00 00    	lea    ecx,[eax+0x0]
			wday_name[timep->tm_wday],
     872:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     875:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     878:	89 d0                	mov    eax,edx
     87a:	01 c0                	add    eax,eax
     87c:	01 d0                	add    eax,edx
     87e:	05 24 00 00 00       	add    eax,0x24
		sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d\n",
     883:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     886:	89 54 24 20          	mov    DWORD PTR [esp+0x20],edx
     88a:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     88d:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
     891:	89 7c 24 18          	mov    DWORD PTR [esp+0x18],edi
     895:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
     899:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     89d:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     8a1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     8a5:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     8ad:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8b0:	89 04 24             	mov    DWORD PTR [esp],eax
     8b3:	e8 fc ff ff ff       	call   8b4 <asctime_r+0x89>
		return result;
     8b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     8bb:	83 c4 5c             	add    esp,0x5c
     8be:	5b                   	pop    ebx
     8bf:	5e                   	pop    esi
     8c0:	5f                   	pop    edi
     8c1:	5d                   	pop    ebp
     8c2:	c3                   	ret

000008c3 <asctime>:

char* asctime(const struct tm* timep)
{
     8c3:	55                   	push   ebp
     8c4:	89 e5                	mov    ebp,esp
     8c6:	83 ec 18             	sub    esp,0x18
		static char result[26];
		return asctime_r(timep, result);
     8c9:	c7 44 24 04 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x4
     8d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8d4:	89 04 24             	mov    DWORD PTR [esp],eax
     8d7:	e8 fc ff ff ff       	call   8d8 <asctime+0x15>
}
     8dc:	c9                   	leave
     8dd:	c3                   	ret

000008de <ctime>:

char* ctime(const time_t* timep)
{
     8de:	55                   	push   ebp
     8df:	89 e5                	mov    ebp,esp
     8e1:	83 ec 18             	sub    esp,0x18
		return asctime(localtime(timep));
     8e4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8e7:	89 04 24             	mov    DWORD PTR [esp],eax
     8ea:	e8 fc ff ff ff       	call   8eb <ctime+0xd>
     8ef:	89 04 24             	mov    DWORD PTR [esp],eax
     8f2:	e8 fc ff ff ff       	call   8f3 <ctime+0x15>
}
     8f7:	c9                   	leave
     8f8:	c3                   	ret

000008f9 <ctime_r>:

char* ctime_r(const time_t* timep, char* result)
{
     8f9:	55                   	push   ebp
     8fa:	89 e5                	mov    ebp,esp
     8fc:	83 ec 18             	sub    esp,0x18
		return asctime_r(localtime(timep), result);
     8ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     902:	89 04 24             	mov    DWORD PTR [esp],eax
     905:	e8 fc ff ff ff       	call   906 <ctime_r+0xd>
     90a:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     90d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     911:	89 04 24             	mov    DWORD PTR [esp],eax
     914:	e8 fc ff ff ff       	call   915 <ctime_r+0x1c>
}
     919:	c9                   	leave
     91a:	c3                   	ret

0000091b <time>:

time_t time(time_t* timep)
{
     91b:	55                   	push   ebp
     91c:	89 e5                	mov    ebp,esp
}
     91e:	90                   	nop
     91f:	5d                   	pop    ebp
     920:	c3                   	ret

00000921 <mktime>:

time_t mktime(struct tm* timep)
{
     921:	55                   	push   ebp
     922:	89 e5                	mov    ebp,esp
}
     924:	90                   	nop
     925:	5d                   	pop    ebp
     926:	c3                   	ret

00000927 <gmtime_r>:

#define COUNT_LEAPS(Y)   ( ((Y)-1)/4 - ((Y)-1)/100 + ((Y)-1)/400 )
#define COUNT_DAYS(Y)  ( ((Y)-1)*365 + COUNT_LEAPS(Y) )
#define IS_LEAP_YEAR(Y)     ( ((Y)>0) && !((Y)%4) && ( ((Y)%100) || !((Y)%400) ) )
struct tm* gmtime_r(const time_t* timep, struct tm* result)
{
     927:	55                   	push   ebp
     928:	89 e5                	mov    ebp,esp
     92a:	57                   	push   edi
     92b:	56                   	push   esi
     92c:	53                   	push   ebx
     92d:	83 ec 4c             	sub    esp,0x4c
		int dayct = *timep / 86400, isl, rem;
     930:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     933:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     936:	8b 00                	mov    eax,DWORD PTR [eax]
     938:	c7 44 24 08 80 51 01 00 	mov    DWORD PTR [esp+0x8],0x15180
     940:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
     948:	89 04 24             	mov    DWORD PTR [esp],eax
     94b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     94f:	e8 fc ff ff ff       	call   950 <gmtime_r+0x29>
     954:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		*result = (struct tm){0};
     957:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     95a:	89 c3                	mov    ebx,eax
     95c:	b8 00 00 00 00       	mov    eax,0x0
     961:	ba 09 00 00 00       	mov    edx,0x9
     966:	89 df                	mov    edi,ebx
     968:	89 d1                	mov    ecx,edx
     96a:	f3 ab                	rep stos DWORD PTR es:[edi],eax
		result->tm_wday = (dayct + 4) % 7; /* Jan 1 1970 is Thu */
     96c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     96f:	8d 48 04             	lea    ecx,[eax+0x4]
     972:	ba 93 24 49 92       	mov    edx,0x92492493
     977:	89 c8                	mov    eax,ecx
     979:	f7 ea                	imul   edx
     97b:	8d 04 0a             	lea    eax,[edx+ecx*1]
     97e:	c1 f8 02             	sar    eax,0x2
     981:	89 ca                	mov    edx,ecx
     983:	c1 fa 1f             	sar    edx,0x1f
     986:	29 d0                	sub    eax,edx
     988:	89 c2                	mov    edx,eax
     98a:	c1 e2 03             	shl    edx,0x3
     98d:	29 c2                	sub    edx,eax
     98f:	89 c8                	mov    eax,ecx
     991:	29 d0                	sub    eax,edx
     993:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     996:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
     999:	eb 0f                	jmp    9aa <gmtime_r+0x83>
			result->tm_year++;
     99b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     99e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9a1:	8d 50 01             	lea    edx,[eax+0x1]
     9a4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9a7:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		while (COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970) <= dayct)
     9aa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9ad:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9b0:	05 6b 07 00 00       	add    eax,0x76b
     9b5:	69 d8 6d 01 00 00    	imul   ebx,eax,0x16d
     9bb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9be:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9c1:	05 6b 07 00 00       	add    eax,0x76b
     9c6:	8d 50 03             	lea    edx,[eax+0x3]
     9c9:	85 c0                	test   eax,eax
     9cb:	0f 48 c2             	cmovs  eax,edx
     9ce:	c1 f8 02             	sar    eax,0x2
     9d1:	89 c6                	mov    esi,eax
     9d3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9d6:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9d9:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     9df:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     9e4:	89 c8                	mov    eax,ecx
     9e6:	f7 ea                	imul   edx
     9e8:	89 d0                	mov    eax,edx
     9ea:	c1 f8 05             	sar    eax,0x5
     9ed:	c1 f9 1f             	sar    ecx,0x1f
     9f0:	89 ca                	mov    edx,ecx
     9f2:	29 c2                	sub    edx,eax
     9f4:	01 d6                	add    esi,edx
     9f6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9f9:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9fc:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     a02:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     a07:	89 c8                	mov    eax,ecx
     a09:	f7 ea                	imul   edx
     a0b:	c1 fa 07             	sar    edx,0x7
     a0e:	89 c8                	mov    eax,ecx
     a10:	c1 f8 1f             	sar    eax,0x1f
     a13:	29 c2                	sub    edx,eax
     a15:	8d 04 16             	lea    eax,[esi+edx*1]
     a18:	01 d8                	add    eax,ebx
     a1a:	2d 3a f9 0a 00       	sub    eax,0xaf93a
     a1f:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
     a22:	0f 8d 73 ff ff ff    	jge    99b <gmtime_r+0x74>
		result->tm_year--;
     a28:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a2b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a2e:	8d 50 ff             	lea    edx,[eax-0x1]
     a31:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a34:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		isl = IS_LEAP_YEAR(result->tm_year);
     a37:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a3a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a3d:	85 c0                	test   eax,eax
     a3f:	7e 63                	jle    aa4 <gmtime_r+0x17d>
     a41:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a44:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     a47:	83 e0 03             	and    eax,0x3
     a4a:	85 c0                	test   eax,eax
     a4c:	75 56                	jne    aa4 <gmtime_r+0x17d>
     a4e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a51:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     a54:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     a59:	89 c8                	mov    eax,ecx
     a5b:	f7 ea                	imul   edx
     a5d:	89 d0                	mov    eax,edx
     a5f:	c1 f8 05             	sar    eax,0x5
     a62:	89 ca                	mov    edx,ecx
     a64:	c1 fa 1f             	sar    edx,0x1f
     a67:	29 d0                	sub    eax,edx
     a69:	6b d0 64             	imul   edx,eax,0x64
     a6c:	89 c8                	mov    eax,ecx
     a6e:	29 d0                	sub    eax,edx
     a70:	85 c0                	test   eax,eax
     a72:	75 29                	jne    a9d <gmtime_r+0x176>
     a74:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a77:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     a7a:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     a7f:	89 c8                	mov    eax,ecx
     a81:	f7 ea                	imul   edx
     a83:	89 d0                	mov    eax,edx
     a85:	c1 f8 07             	sar    eax,0x7
     a88:	89 ca                	mov    edx,ecx
     a8a:	c1 fa 1f             	sar    edx,0x1f
     a8d:	29 d0                	sub    eax,edx
     a8f:	69 d0 90 01 00 00    	imul   edx,eax,0x190
     a95:	89 c8                	mov    eax,ecx
     a97:	29 d0                	sub    eax,edx
     a99:	85 c0                	test   eax,eax
     a9b:	75 07                	jne    aa4 <gmtime_r+0x17d>
     a9d:	b8 01 00 00 00       	mov    eax,0x1
     aa2:	eb 05                	jmp    aa9 <gmtime_r+0x182>
     aa4:	b8 00 00 00 00       	mov    eax,0x0
     aa9:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		dayct -= COUNT_DAYS(1900 + result->tm_year) - COUNT_DAYS(1970);
     aac:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     aaf:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     ab2:	05 6b 07 00 00       	add    eax,0x76b
     ab7:	69 d8 6d 01 00 00    	imul   ebx,eax,0x16d
     abd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ac0:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     ac3:	05 6b 07 00 00       	add    eax,0x76b
     ac8:	8d 50 03             	lea    edx,[eax+0x3]
     acb:	85 c0                	test   eax,eax
     acd:	0f 48 c2             	cmovs  eax,edx
     ad0:	c1 f8 02             	sar    eax,0x2
     ad3:	89 c6                	mov    esi,eax
     ad5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ad8:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     adb:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     ae1:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     ae6:	89 c8                	mov    eax,ecx
     ae8:	f7 ea                	imul   edx
     aea:	89 d0                	mov    eax,edx
     aec:	c1 f8 05             	sar    eax,0x5
     aef:	c1 f9 1f             	sar    ecx,0x1f
     af2:	89 ca                	mov    edx,ecx
     af4:	29 c2                	sub    edx,eax
     af6:	01 d6                	add    esi,edx
     af8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     afb:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     afe:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
     b04:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
     b09:	89 c8                	mov    eax,ecx
     b0b:	f7 ea                	imul   edx
     b0d:	c1 fa 07             	sar    edx,0x7
     b10:	89 c8                	mov    eax,ecx
     b12:	c1 f8 1f             	sar    eax,0x1f
     b15:	29 c2                	sub    edx,eax
     b17:	8d 04 16             	lea    eax,[esi+edx*1]
     b1a:	01 d8                	add    eax,ebx
     b1c:	2d 3a f9 0a 00       	sub    eax,0xaf93a
     b21:	29 45 e4             	sub    DWORD PTR [ebp-0x1c],eax
		result->tm_yday = dayct;
     b24:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b27:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     b2a:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		static const int dayct_nl[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, INT_MAX };
		static const int dayct_lp[] = { 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, INT_MAX };
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
     b2d:	eb 0f                	jmp    b3e <gmtime_r+0x217>
			result->tm_mon++;
     b2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b32:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b35:	8d 50 01             	lea    edx,[eax+0x1]
     b38:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b3b:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		while ((isl ? dayct_lp : dayct_nl)[result->tm_mon] < result->tm_yday)
     b3e:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
     b42:	74 07                	je     b4b <gmtime_r+0x224>
     b44:	ba 20 00 00 00       	mov    edx,0x20
     b49:	eb 05                	jmp    b50 <gmtime_r+0x229>
     b4b:	ba 60 00 00 00       	mov    edx,0x60
     b50:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b53:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b56:	c1 e0 02             	shl    eax,0x2
     b59:	01 d0                	add    eax,edx
     b5b:	8b 10                	mov    edx,DWORD PTR [eax]
     b5d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b60:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
     b63:	39 c2                	cmp    edx,eax
     b65:	7c c8                	jl     b2f <gmtime_r+0x208>
		result->tm_mon--;
     b67:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b6a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b6d:	8d 50 ff             	lea    edx,[eax-0x1]
     b70:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b73:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		dayct -= (isl ? dayct_lp : dayct_nl)[result->tm_mon]; /* 0 based */
     b76:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
     b7a:	74 07                	je     b83 <gmtime_r+0x25c>
     b7c:	ba 20 00 00 00       	mov    edx,0x20
     b81:	eb 05                	jmp    b88 <gmtime_r+0x261>
     b83:	ba 60 00 00 00       	mov    edx,0x60
     b88:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b8b:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     b8e:	c1 e0 02             	shl    eax,0x2
     b91:	01 d0                	add    eax,edx
     b93:	8b 00                	mov    eax,DWORD PTR [eax]
     b95:	29 45 e4             	sub    DWORD PTR [ebp-0x1c],eax
		result->tm_mday = dayct + 1; /* 1 based */
     b98:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b9b:	8d 50 01             	lea    edx,[eax+0x1]
     b9e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ba1:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		/* time logic */
		rem = *timep % 86400;
     ba4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ba7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     baa:	8b 00                	mov    eax,DWORD PTR [eax]
     bac:	c7 44 24 08 80 51 01 00 	mov    DWORD PTR [esp+0x8],0x15180
     bb4:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
     bbc:	89 04 24             	mov    DWORD PTR [esp],eax
     bbf:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     bc3:	e8 fc ff ff ff       	call   bc4 <gmtime_r+0x29d>
     bc8:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		result->tm_hour = rem / 3600;
     bcb:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     bce:	ba c5 b3 a2 91       	mov    edx,0x91a2b3c5
     bd3:	89 c8                	mov    eax,ecx
     bd5:	f7 ea                	imul   edx
     bd7:	8d 04 0a             	lea    eax,[edx+ecx*1]
     bda:	c1 f8 0b             	sar    eax,0xb
     bdd:	89 c2                	mov    edx,eax
     bdf:	89 c8                	mov    eax,ecx
     be1:	c1 f8 1f             	sar    eax,0x1f
     be4:	29 c2                	sub    edx,eax
     be6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     be9:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		rem %= 3600;
     bec:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     bef:	ba c5 b3 a2 91       	mov    edx,0x91a2b3c5
     bf4:	89 c8                	mov    eax,ecx
     bf6:	f7 ea                	imul   edx
     bf8:	8d 04 0a             	lea    eax,[edx+ecx*1]
     bfb:	c1 f8 0b             	sar    eax,0xb
     bfe:	89 c2                	mov    edx,eax
     c00:	89 c8                	mov    eax,ecx
     c02:	c1 f8 1f             	sar    eax,0x1f
     c05:	29 c2                	sub    edx,eax
     c07:	69 c2 10 0e 00 00    	imul   eax,edx,0xe10
     c0d:	29 c1                	sub    ecx,eax
     c0f:	89 ca                	mov    edx,ecx
     c11:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		result->tm_min = rem / 60;
     c14:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     c17:	ba 89 88 88 88       	mov    edx,0x88888889
     c1c:	89 c8                	mov    eax,ecx
     c1e:	f7 ea                	imul   edx
     c20:	8d 04 0a             	lea    eax,[edx+ecx*1]
     c23:	c1 f8 05             	sar    eax,0x5
     c26:	89 c2                	mov    edx,eax
     c28:	89 c8                	mov    eax,ecx
     c2a:	c1 f8 1f             	sar    eax,0x1f
     c2d:	29 c2                	sub    edx,eax
     c2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c32:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		rem %= 60;
     c35:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     c38:	ba 89 88 88 88       	mov    edx,0x88888889
     c3d:	89 c8                	mov    eax,ecx
     c3f:	f7 ea                	imul   edx
     c41:	8d 04 0a             	lea    eax,[edx+ecx*1]
     c44:	c1 f8 05             	sar    eax,0x5
     c47:	89 c2                	mov    edx,eax
     c49:	89 c8                	mov    eax,ecx
     c4b:	c1 f8 1f             	sar    eax,0x1f
     c4e:	29 c2                	sub    edx,eax
     c50:	6b c2 3c             	imul   eax,edx,0x3c
     c53:	29 c1                	sub    ecx,eax
     c55:	89 ca                	mov    edx,ecx
     c57:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		result->tm_sec = rem;
     c5a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c5d:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     c60:	89 10                	mov    DWORD PTR [eax],edx
		/* gmtime isdst=0 */
		return result;
     c62:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     c65:	83 c4 4c             	add    esp,0x4c
     c68:	5b                   	pop    ebx
     c69:	5e                   	pop    esi
     c6a:	5f                   	pop    edi
     c6b:	5d                   	pop    ebp
     c6c:	c3                   	ret

00000c6d <gmtime>:

struct tm* gmtime(const time_t* timep)
{
     c6d:	55                   	push   ebp
     c6e:	89 e5                	mov    ebp,esp
     c70:	83 ec 18             	sub    esp,0x18
		static struct tm lts;
		return gmtime_r(timep, &lts);
     c73:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
     c7b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c7e:	89 04 24             	mov    DWORD PTR [esp],eax
     c81:	e8 fc ff ff ff       	call   c82 <gmtime+0x15>
}
     c86:	c9                   	leave
     c87:	c3                   	ret

00000c88 <localtime_r>:

struct tm* localtime_r(const time_t* timep, struct tm* result)
{
     c88:	55                   	push   ebp
     c89:	89 e5                	mov    ebp,esp
     c8b:	83 ec 18             	sub    esp,0x18
		/*TODO: +- time_t offset */
		return gmtime_r(timep, result);
     c8e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c91:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     c95:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c98:	89 04 24             	mov    DWORD PTR [esp],eax
     c9b:	e8 fc ff ff ff       	call   c9c <localtime_r+0x14>
}
     ca0:	c9                   	leave
     ca1:	c3                   	ret

00000ca2 <localtime>:

struct tm* localtime(const time_t* timep)
{
     ca2:	55                   	push   ebp
     ca3:	89 e5                	mov    ebp,esp
     ca5:	83 ec 18             	sub    esp,0x18
		static struct tm lts;
		return localtime_r(timep, &lts);
     ca8:	c7 44 24 04 60 00 00 00 	mov    DWORD PTR [esp+0x4],0x60
     cb0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cb3:	89 04 24             	mov    DWORD PTR [esp],eax
     cb6:	e8 fc ff ff ff       	call   cb7 <localtime+0x15>
}
     cbb:	c9                   	leave
     cbc:	c3                   	ret

00000cbd <__umoddi3>:
		return q;
}

UDWtype
__umoddi3 (UDWtype u, UDWtype v)
{
     cbd:	55                   	push   ebp
     cbe:	89 e5                	mov    ebp,esp
     cc0:	83 ec 60             	sub    esp,0x60
     cc3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cc6:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
     cc9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ccc:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
     ccf:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     cd2:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     cd5:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     cd8:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
     cdb:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
     cde:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     ce1:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     ce4:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
     ce7:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     cea:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     ced:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     cf0:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     cf3:	8d 45 b8             	lea    eax,[ebp-0x48]
     cf6:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		UDWtype q = 0, r = n, y = d;
     cf9:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
     d00:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     d07:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d0a:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     d0d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     d10:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     d13:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d16:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     d19:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     d1c:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (y <= r)
     d1f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     d22:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     d25:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     d28:	89 d0                	mov    eax,edx
     d2a:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     d2d:	0f 82 4f 01 00 00    	jb     e82 <__umoddi3+0x1c5>
				lz1 = __builtin_clzll (d);
     d33:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d36:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     d39:	85 d2                	test   edx,edx
     d3b:	74 08                	je     d45 <__umoddi3+0x88>
     d3d:	0f bd c2             	bsr    eax,edx
     d40:	83 f0 1f             	xor    eax,0x1f
     d43:	eb 09                	jmp    d4e <__umoddi3+0x91>
     d45:	0f bd c0             	bsr    eax,eax
     d48:	83 f0 1f             	xor    eax,0x1f
     d4b:	83 c0 20             	add    eax,0x20
     d4e:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				lz2 = __builtin_clzll (n);
     d51:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d54:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     d57:	85 d2                	test   edx,edx
     d59:	74 08                	je     d63 <__umoddi3+0xa6>
     d5b:	0f bd c2             	bsr    eax,edx
     d5e:	83 f0 1f             	xor    eax,0x1f
     d61:	eb 09                	jmp    d6c <__umoddi3+0xaf>
     d63:	0f bd c0             	bsr    eax,eax
     d66:	83 f0 1f             	xor    eax,0x1f
     d69:	83 c0 20             	add    eax,0x20
     d6c:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				k = lz1 - lz2;
     d6f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     d72:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
     d75:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				y = (y << k);
     d78:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     d7b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     d7e:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     d81:	0f a5 c2             	shld   edx,eax,cl
     d84:	d3 e0                	shl    eax,cl
     d86:	f6 c1 20             	test   cl,0x20
     d89:	74 04                	je     d8f <__umoddi3+0xd2>
     d8b:	89 c2                	mov    edx,eax
     d8d:	31 c0                	xor    eax,eax
     d8f:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     d92:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (r >= y)
     d95:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     d98:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     d9b:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     d9e:	89 d0                	mov    eax,edx
     da0:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     da3:	72 2d                	jb     dd2 <__umoddi3+0x115>
						r = r - y;
     da5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     da8:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     dab:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
     dae:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						q =  (1ULL << k);
     db1:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     db4:	b8 01 00 00 00       	mov    eax,0x1
     db9:	ba 00 00 00 00       	mov    edx,0x0
     dbe:	0f a5 c2             	shld   edx,eax,cl
     dc1:	d3 e0                	shl    eax,cl
     dc3:	f6 c1 20             	test   cl,0x20
     dc6:	74 04                	je     dcc <__umoddi3+0x10f>
     dc8:	89 c2                	mov    edx,eax
     dca:	31 c0                	xor    eax,eax
     dcc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     dcf:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (k > 0)
     dd2:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
     dd6:	0f 84 a6 00 00 00    	je     e82 <__umoddi3+0x1c5>
						y = y >> 1;
     ddc:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     ddf:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     de2:	0f ac d0 01          	shrd   eax,edx,0x1
     de6:	d1 ea                	shr    edx,1
     de8:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     deb:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						i = k;
     dee:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     df1:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								if (r >= y)
     df4:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     df7:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     dfa:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     dfd:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
     e00:	19 d1                	sbb    ecx,edx
     e02:	72 1e                	jb     e22 <__umoddi3+0x165>
										r = ((r - y) << 1) + 1;
     e04:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e07:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e0a:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     e0d:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
     e10:	01 c0                	add    eax,eax
     e12:	11 d2                	adc    edx,edx
     e14:	83 c0 01             	add    eax,0x1
     e17:	83 d2 00             	adc    edx,0x0
     e1a:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e1d:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     e20:	eb 10                	jmp    e32 <__umoddi3+0x175>
										r =  (r << 1);
     e22:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e25:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e28:	01 c0                	add    eax,eax
     e2a:	11 d2                	adc    edx,edx
     e2c:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e2f:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
								i = i - 1;
     e32:	83 6d c0 01          	sub    DWORD PTR [ebp-0x40],0x1
						} while (i != 0);
     e36:	83 7d c0 00          	cmp    DWORD PTR [ebp-0x40],0x0
     e3a:	75 b8                	jne    df4 <__umoddi3+0x137>
						q = q + r;
     e3c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e3f:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e42:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
     e45:	11 55 e4             	adc    DWORD PTR [ebp-0x1c],edx
						r = r >> k;
     e48:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     e4b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e4e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e51:	0f ad d0             	shrd   eax,edx,cl
     e54:	d3 ea                	shr    edx,cl
     e56:	f6 c1 20             	test   cl,0x20
     e59:	74 04                	je     e5f <__umoddi3+0x1a2>
     e5b:	89 d0                	mov    eax,edx
     e5d:	31 d2                	xor    edx,edx
     e5f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e62:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
						q = q - (r << k);
     e65:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     e68:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e6b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e6e:	0f a5 c2             	shld   edx,eax,cl
     e71:	d3 e0                	shl    eax,cl
     e73:	f6 c1 20             	test   cl,0x20
     e76:	74 04                	je     e7c <__umoddi3+0x1bf>
     e78:	89 c2                	mov    edx,eax
     e7a:	31 c0                	xor    eax,eax
     e7c:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
     e7f:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
		if (rp)
     e82:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     e86:	74 0e                	je     e96 <__umoddi3+0x1d9>
				*rp = r;
     e88:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     e8b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e8e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     e91:	89 01                	mov    DWORD PTR [ecx],eax
     e93:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		UDWtype w;

		(void) __udivmoddi4 (u, v, &w);

		return w;
     e96:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     e99:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
}
     e9c:	c9                   	leave
     e9d:	c3                   	ret

00000e9e <__udivdi3>:

UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
     e9e:	55                   	push   ebp
     e9f:	89 e5                	mov    ebp,esp
     ea1:	83 ec 50             	sub    esp,0x50
     ea4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ea7:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
     eaa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ead:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
     eb0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     eb3:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
     eb6:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     eb9:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
     ebc:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     ebf:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     ec2:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     ec5:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
     ec8:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
     ecb:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
     ece:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     ed1:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     ed4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		UDWtype q = 0, r = n, y = d;
     edb:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
     ee2:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     ee9:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     eec:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     eef:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     ef2:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     ef5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ef8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     efb:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     efe:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (y <= r)
     f01:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     f04:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     f07:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     f0a:	89 d0                	mov    eax,edx
     f0c:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     f0f:	0f 82 4f 01 00 00    	jb     1064 <__udivdi3+0x1c6>
				lz1 = __builtin_clzll (d);
     f15:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f18:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     f1b:	85 d2                	test   edx,edx
     f1d:	74 08                	je     f27 <__udivdi3+0x89>
     f1f:	0f bd c2             	bsr    eax,edx
     f22:	83 f0 1f             	xor    eax,0x1f
     f25:	eb 09                	jmp    f30 <__udivdi3+0x92>
     f27:	0f bd c0             	bsr    eax,eax
     f2a:	83 f0 1f             	xor    eax,0x1f
     f2d:	83 c0 20             	add    eax,0x20
     f30:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				lz2 = __builtin_clzll (n);
     f33:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     f36:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     f39:	85 d2                	test   edx,edx
     f3b:	74 08                	je     f45 <__udivdi3+0xa7>
     f3d:	0f bd c2             	bsr    eax,edx
     f40:	83 f0 1f             	xor    eax,0x1f
     f43:	eb 09                	jmp    f4e <__udivdi3+0xb0>
     f45:	0f bd c0             	bsr    eax,eax
     f48:	83 f0 1f             	xor    eax,0x1f
     f4b:	83 c0 20             	add    eax,0x20
     f4e:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				k = lz1 - lz2;
     f51:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f54:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
     f57:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				y = (y << k);
     f5a:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     f5d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f60:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     f63:	0f a5 c2             	shld   edx,eax,cl
     f66:	d3 e0                	shl    eax,cl
     f68:	f6 c1 20             	test   cl,0x20
     f6b:	74 04                	je     f71 <__udivdi3+0xd3>
     f6d:	89 c2                	mov    edx,eax
     f6f:	31 c0                	xor    eax,eax
     f71:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     f74:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (r >= y)
     f77:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     f7a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     f7d:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     f80:	89 d0                	mov    eax,edx
     f82:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
     f85:	72 2d                	jb     fb4 <__udivdi3+0x116>
						r = r - y;
     f87:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f8a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     f8d:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
     f90:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						q =  (1ULL << k);
     f93:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     f96:	b8 01 00 00 00       	mov    eax,0x1
     f9b:	ba 00 00 00 00       	mov    edx,0x0
     fa0:	0f a5 c2             	shld   edx,eax,cl
     fa3:	d3 e0                	shl    eax,cl
     fa5:	f6 c1 20             	test   cl,0x20
     fa8:	74 04                	je     fae <__udivdi3+0x110>
     faa:	89 c2                	mov    edx,eax
     fac:	31 c0                	xor    eax,eax
     fae:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     fb1:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (k > 0)
     fb4:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
     fb8:	0f 84 a6 00 00 00    	je     1064 <__udivdi3+0x1c6>
						y = y >> 1;
     fbe:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     fc1:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     fc4:	0f ac d0 01          	shrd   eax,edx,0x1
     fc8:	d1 ea                	shr    edx,1
     fca:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     fcd:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						i = k;
     fd0:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     fd3:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								if (r >= y)
     fd6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     fd9:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     fdc:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     fdf:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
     fe2:	19 d1                	sbb    ecx,edx
     fe4:	72 1e                	jb     1004 <__udivdi3+0x166>
										r = ((r - y) << 1) + 1;
     fe6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     fe9:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     fec:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     fef:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
     ff2:	01 c0                	add    eax,eax
     ff4:	11 d2                	adc    edx,edx
     ff6:	83 c0 01             	add    eax,0x1
     ff9:	83 d2 00             	adc    edx,0x0
     ffc:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     fff:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1002:	eb 10                	jmp    1014 <__udivdi3+0x176>
										r =  (r << 1);
    1004:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1007:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    100a:	01 c0                	add    eax,eax
    100c:	11 d2                	adc    edx,edx
    100e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1011:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
								i = i - 1;
    1014:	83 6d c0 01          	sub    DWORD PTR [ebp-0x40],0x1
						} while (i != 0);
    1018:	83 7d c0 00          	cmp    DWORD PTR [ebp-0x40],0x0
    101c:	75 b8                	jne    fd6 <__udivdi3+0x138>
						q = q + r;
    101e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1021:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1024:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
    1027:	11 55 e4             	adc    DWORD PTR [ebp-0x1c],edx
						r = r >> k;
    102a:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    102d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1030:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1033:	0f ad d0             	shrd   eax,edx,cl
    1036:	d3 ea                	shr    edx,cl
    1038:	f6 c1 20             	test   cl,0x20
    103b:	74 04                	je     1041 <__udivdi3+0x1a3>
    103d:	89 d0                	mov    eax,edx
    103f:	31 d2                	xor    edx,edx
    1041:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1044:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
						q = q - (r << k);
    1047:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    104a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    104d:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1050:	0f a5 c2             	shld   edx,eax,cl
    1053:	d3 e0                	shl    eax,cl
    1055:	f6 c1 20             	test   cl,0x20
    1058:	74 04                	je     105e <__udivdi3+0x1c0>
    105a:	89 c2                	mov    edx,eax
    105c:	31 c0                	xor    eax,eax
    105e:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
    1061:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
		if (rp)
    1064:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1068:	74 0e                	je     1078 <__udivdi3+0x1da>
				*rp = r;
    106a:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    106d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1070:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1073:	89 01                	mov    DWORD PTR [ecx],eax
    1075:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return q;
    1078:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    107b:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
		return __udivmoddi4 (n, d, (UDWtype *) 0);
}
    107e:	c9                   	leave
    107f:	c3                   	ret

00001080 <__moddi3>:

DWtype
__moddi3 (DWtype u, DWtype v)
{
    1080:	55                   	push   ebp
    1081:	89 e5                	mov    ebp,esp
    1083:	53                   	push   ebx
    1084:	83 ec 74             	sub    esp,0x74
    1087:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    108a:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    108d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1090:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    1093:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1096:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
    1099:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    109c:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		Wtype c = 0;
    109f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		DWunion uu = {.ll = u};
    10a6:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    10a9:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    10ac:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    10af:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
		DWunion vv = {.ll = v};
    10b2:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    10b5:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
    10b8:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    10bb:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		DWtype w;
	
		if (uu.s.high < 0)
    10be:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    10c1:	85 c0                	test   eax,eax
    10c3:	79 16                	jns    10db <__moddi3+0x5b>
				c = ~c,
    10c5:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
					uu.ll = -uu.ll;
    10c8:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    10cb:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    10ce:	f7 d8                	neg    eax
    10d0:	83 d2 00             	adc    edx,0x0
    10d3:	f7 da                	neg    edx
    10d5:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    10d8:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
		if (vv.s.high < 0)
    10db:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    10de:	85 c0                	test   eax,eax
    10e0:	79 13                	jns    10f5 <__moddi3+0x75>
				vv.ll = -vv.ll;
    10e2:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    10e5:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    10e8:	f7 d8                	neg    eax
    10ea:	83 d2 00             	adc    edx,0x0
    10ed:	f7 da                	neg    edx
    10ef:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    10f2:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
	
		(void) __udivmoddi4 (uu.ll, vv.ll, (UDWtype*)&w);
    10f5:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    10f8:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    10fb:	89 c1                	mov    ecx,eax
    10fd:	89 d3                	mov    ebx,edx
    10ff:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    1102:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    1105:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1108:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    110b:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
    110e:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
    1111:	8d 45 98             	lea    eax,[ebp-0x68]
    1114:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		UDWtype q = 0, r = n, y = d;
    1117:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    111e:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    1125:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1128:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    112b:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    112e:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    1131:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1134:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1137:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    113a:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
		if (y <= r)
    113d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1140:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1143:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
    1146:	89 d0                	mov    eax,edx
    1148:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
    114b:	0f 82 4f 01 00 00    	jb     12a0 <__moddi3+0x220>
				lz1 = __builtin_clzll (d);
    1151:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1154:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1157:	85 d2                	test   edx,edx
    1159:	74 08                	je     1163 <__moddi3+0xe3>
    115b:	0f bd c2             	bsr    eax,edx
    115e:	83 f0 1f             	xor    eax,0x1f
    1161:	eb 09                	jmp    116c <__moddi3+0xec>
    1163:	0f bd c0             	bsr    eax,eax
    1166:	83 f0 1f             	xor    eax,0x1f
    1169:	83 c0 20             	add    eax,0x20
    116c:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				lz2 = __builtin_clzll (n);
    116f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1172:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1175:	85 d2                	test   edx,edx
    1177:	74 08                	je     1181 <__moddi3+0x101>
    1179:	0f bd c2             	bsr    eax,edx
    117c:	83 f0 1f             	xor    eax,0x1f
    117f:	eb 09                	jmp    118a <__moddi3+0x10a>
    1181:	0f bd c0             	bsr    eax,eax
    1184:	83 f0 1f             	xor    eax,0x1f
    1187:	83 c0 20             	add    eax,0x20
    118a:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				k = lz1 - lz2;
    118d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1190:	2b 45 b8             	sub    eax,DWORD PTR [ebp-0x48]
    1193:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				y = (y << k);
    1196:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    1199:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    119c:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    119f:	0f a5 c2             	shld   edx,eax,cl
    11a2:	d3 e0                	shl    eax,cl
    11a4:	f6 c1 20             	test   cl,0x20
    11a7:	74 04                	je     11ad <__moddi3+0x12d>
    11a9:	89 c2                	mov    edx,eax
    11ab:	31 c0                	xor    eax,eax
    11ad:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    11b0:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
				if (r >= y)
    11b3:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    11b6:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    11b9:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
    11bc:	89 d0                	mov    eax,edx
    11be:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
    11c1:	72 2d                	jb     11f0 <__moddi3+0x170>
						r = r - y;
    11c3:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    11c6:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    11c9:	29 45 c8             	sub    DWORD PTR [ebp-0x38],eax
    11cc:	19 55 cc             	sbb    DWORD PTR [ebp-0x34],edx
						q =  (1ULL << k);
    11cf:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    11d2:	b8 01 00 00 00       	mov    eax,0x1
    11d7:	ba 00 00 00 00       	mov    edx,0x0
    11dc:	0f a5 c2             	shld   edx,eax,cl
    11df:	d3 e0                	shl    eax,cl
    11e1:	f6 c1 20             	test   cl,0x20
    11e4:	74 04                	je     11ea <__moddi3+0x16a>
    11e6:	89 c2                	mov    edx,eax
    11e8:	31 c0                	xor    eax,eax
    11ea:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    11ed:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (k > 0)
    11f0:	83 7d b4 00          	cmp    DWORD PTR [ebp-0x4c],0x0
    11f4:	0f 84 a6 00 00 00    	je     12a0 <__moddi3+0x220>
						y = y >> 1;
    11fa:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    11fd:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1200:	0f ac d0 01          	shrd   eax,edx,0x1
    1204:	d1 ea                	shr    edx,1
    1206:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    1209:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
						i = k;
    120c:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    120f:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								if (r >= y)
    1212:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1215:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1218:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
    121b:	39 45 c8             	cmp    DWORD PTR [ebp-0x38],eax
    121e:	19 d1                	sbb    ecx,edx
    1220:	72 1e                	jb     1240 <__moddi3+0x1c0>
										r = ((r - y) << 1) + 1;
    1222:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1225:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1228:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    122b:	1b 55 c4             	sbb    edx,DWORD PTR [ebp-0x3c]
    122e:	01 c0                	add    eax,eax
    1230:	11 d2                	adc    edx,edx
    1232:	83 c0 01             	add    eax,0x1
    1235:	83 d2 00             	adc    edx,0x0
    1238:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    123b:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    123e:	eb 10                	jmp    1250 <__moddi3+0x1d0>
										r =  (r << 1);
    1240:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1243:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1246:	01 c0                	add    eax,eax
    1248:	11 d2                	adc    edx,edx
    124a:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    124d:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
								i = i - 1;
    1250:	83 6d b0 01          	sub    DWORD PTR [ebp-0x50],0x1
						} while (i != 0);
    1254:	83 7d b0 00          	cmp    DWORD PTR [ebp-0x50],0x0
    1258:	75 b8                	jne    1212 <__moddi3+0x192>
						q = q + r;
    125a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    125d:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1260:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
    1263:	11 55 d4             	adc    DWORD PTR [ebp-0x2c],edx
						r = r >> k;
    1266:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    1269:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    126c:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    126f:	0f ad d0             	shrd   eax,edx,cl
    1272:	d3 ea                	shr    edx,cl
    1274:	f6 c1 20             	test   cl,0x20
    1277:	74 04                	je     127d <__moddi3+0x1fd>
    1279:	89 d0                	mov    eax,edx
    127b:	31 d2                	xor    edx,edx
    127d:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1280:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						q = q - (r << k);
    1283:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    1286:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1289:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    128c:	0f a5 c2             	shld   edx,eax,cl
    128f:	d3 e0                	shl    eax,cl
    1291:	f6 c1 20             	test   cl,0x20
    1294:	74 04                	je     129a <__moddi3+0x21a>
    1296:	89 c2                	mov    edx,eax
    1298:	31 c0                	xor    eax,eax
    129a:	29 45 d0             	sub    DWORD PTR [ebp-0x30],eax
    129d:	19 55 d4             	sbb    DWORD PTR [ebp-0x2c],edx
		if (rp)
    12a0:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    12a4:	74 0e                	je     12b4 <__moddi3+0x234>
				*rp = r;
    12a6:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    12a9:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    12ac:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    12af:	89 01                	mov    DWORD PTR [ecx],eax
    12b1:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		if (c)
    12b4:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    12b8:	74 13                	je     12cd <__moddi3+0x24d>
				w = -w;
    12ba:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    12bd:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    12c0:	f7 d8                	neg    eax
    12c2:	83 d2 00             	adc    edx,0x0
    12c5:	f7 da                	neg    edx
    12c7:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    12ca:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
	
		return w;
    12cd:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    12d0:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
}
    12d3:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    12d6:	c9                   	leave
    12d7:	c3                   	ret

000012d8 <__divdi3>:

DWtype
__divdi3 (DWtype u, DWtype v)
{
    12d8:	55                   	push   ebp
    12d9:	89 e5                	mov    ebp,esp
    12db:	53                   	push   ebx
    12dc:	83 ec 74             	sub    esp,0x74
    12df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12e2:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    12e5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12e8:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    12eb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    12ee:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
    12f1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12f4:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		Wtype c = 0;
    12f7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		DWunion uu = {.ll = u};
    12fe:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1301:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    1304:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1307:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		DWunion vv = {.ll = v};
    130a:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    130d:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
    1310:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    1313:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
		DWtype w;
	
		if (uu.s.high < 0)
    1316:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    1319:	85 c0                	test   eax,eax
    131b:	79 16                	jns    1333 <__divdi3+0x5b>
				c = ~c,
    131d:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
				  uu.ll = -uu.ll;
    1320:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1323:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1326:	f7 d8                	neg    eax
    1328:	83 d2 00             	adc    edx,0x0
    132b:	f7 da                	neg    edx
    132d:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1330:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		if (vv.s.high < 0)
    1333:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    1336:	85 c0                	test   eax,eax
    1338:	79 16                	jns    1350 <__divdi3+0x78>
				c = ~c,
    133a:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
				  vv.ll = -vv.ll;
    133d:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    1340:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    1343:	f7 d8                	neg    eax
    1345:	83 d2 00             	adc    edx,0x0
    1348:	f7 da                	neg    edx
    134a:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    134d:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
	
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
    1350:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    1353:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    1356:	89 c1                	mov    ecx,eax
    1358:	89 d3                	mov    ebx,edx
    135a:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    135d:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1360:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1363:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1366:	89 4d d8             	mov    DWORD PTR [ebp-0x28],ecx
    1369:	89 5d dc             	mov    DWORD PTR [ebp-0x24],ebx
    136c:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		UDWtype q = 0, r = n, y = d;
    1373:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    137a:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    1381:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1384:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1387:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    138a:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
    138d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1390:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1393:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1396:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
		if (y <= r)
    1399:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    139c:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    139f:	3b 45 b8             	cmp    eax,DWORD PTR [ebp-0x48]
    13a2:	89 d0                	mov    eax,edx
    13a4:	1b 45 bc             	sbb    eax,DWORD PTR [ebp-0x44]
    13a7:	0f 82 4f 01 00 00    	jb     14fc <__divdi3+0x224>
				lz1 = __builtin_clzll (d);
    13ad:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13b0:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    13b3:	85 d2                	test   edx,edx
    13b5:	74 08                	je     13bf <__divdi3+0xe7>
    13b7:	0f bd c2             	bsr    eax,edx
    13ba:	83 f0 1f             	xor    eax,0x1f
    13bd:	eb 09                	jmp    13c8 <__divdi3+0xf0>
    13bf:	0f bd c0             	bsr    eax,eax
    13c2:	83 f0 1f             	xor    eax,0x1f
    13c5:	83 c0 20             	add    eax,0x20
    13c8:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				lz2 = __builtin_clzll (n);
    13cb:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13ce:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    13d1:	85 d2                	test   edx,edx
    13d3:	74 08                	je     13dd <__divdi3+0x105>
    13d5:	0f bd c2             	bsr    eax,edx
    13d8:	83 f0 1f             	xor    eax,0x1f
    13db:	eb 09                	jmp    13e6 <__divdi3+0x10e>
    13dd:	0f bd c0             	bsr    eax,eax
    13e0:	83 f0 1f             	xor    eax,0x1f
    13e3:	83 c0 20             	add    eax,0x20
    13e6:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
				k = lz1 - lz2;
    13e9:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    13ec:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    13ef:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
				y = (y << k);
    13f2:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    13f5:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    13f8:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    13fb:	0f a5 c2             	shld   edx,eax,cl
    13fe:	d3 e0                	shl    eax,cl
    1400:	f6 c1 20             	test   cl,0x20
    1403:	74 04                	je     1409 <__divdi3+0x131>
    1405:	89 c2                	mov    edx,eax
    1407:	31 c0                	xor    eax,eax
    1409:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    140c:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
				if (r >= y)
    140f:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1412:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1415:	3b 45 b8             	cmp    eax,DWORD PTR [ebp-0x48]
    1418:	89 d0                	mov    eax,edx
    141a:	1b 45 bc             	sbb    eax,DWORD PTR [ebp-0x44]
    141d:	72 2d                	jb     144c <__divdi3+0x174>
						r = r - y;
    141f:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1422:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1425:	29 45 c0             	sub    DWORD PTR [ebp-0x40],eax
    1428:	19 55 c4             	sbb    DWORD PTR [ebp-0x3c],edx
						q =  (1ULL << k);
    142b:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    142e:	b8 01 00 00 00       	mov    eax,0x1
    1433:	ba 00 00 00 00       	mov    edx,0x0
    1438:	0f a5 c2             	shld   edx,eax,cl
    143b:	d3 e0                	shl    eax,cl
    143d:	f6 c1 20             	test   cl,0x20
    1440:	74 04                	je     1446 <__divdi3+0x16e>
    1442:	89 c2                	mov    edx,eax
    1444:	31 c0                	xor    eax,eax
    1446:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1449:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (k > 0)
    144c:	83 7d ac 00          	cmp    DWORD PTR [ebp-0x54],0x0
    1450:	0f 84 a6 00 00 00    	je     14fc <__divdi3+0x224>
						y = y >> 1;
    1456:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1459:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    145c:	0f ac d0 01          	shrd   eax,edx,0x1
    1460:	d1 ea                	shr    edx,1
    1462:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1465:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
						i = k;
    1468:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    146b:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
								if (r >= y)
    146e:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1471:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1474:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    1477:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    147a:	19 d1                	sbb    ecx,edx
    147c:	72 1e                	jb     149c <__divdi3+0x1c4>
										r = ((r - y) << 1) + 1;
    147e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1481:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1484:	2b 45 b8             	sub    eax,DWORD PTR [ebp-0x48]
    1487:	1b 55 bc             	sbb    edx,DWORD PTR [ebp-0x44]
    148a:	01 c0                	add    eax,eax
    148c:	11 d2                	adc    edx,edx
    148e:	83 c0 01             	add    eax,0x1
    1491:	83 d2 00             	adc    edx,0x0
    1494:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    1497:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
    149a:	eb 10                	jmp    14ac <__divdi3+0x1d4>
										r =  (r << 1);
    149c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    149f:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14a2:	01 c0                	add    eax,eax
    14a4:	11 d2                	adc    edx,edx
    14a6:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    14a9:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								i = i - 1;
    14ac:	83 6d a8 01          	sub    DWORD PTR [ebp-0x58],0x1
						} while (i != 0);
    14b0:	83 7d a8 00          	cmp    DWORD PTR [ebp-0x58],0x0
    14b4:	75 b8                	jne    146e <__divdi3+0x196>
						q = q + r;
    14b6:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14b9:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14bc:	01 45 c8             	add    DWORD PTR [ebp-0x38],eax
    14bf:	11 55 cc             	adc    DWORD PTR [ebp-0x34],edx
						r = r >> k;
    14c2:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    14c5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14c8:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14cb:	0f ad d0             	shrd   eax,edx,cl
    14ce:	d3 ea                	shr    edx,cl
    14d0:	f6 c1 20             	test   cl,0x20
    14d3:	74 04                	je     14d9 <__divdi3+0x201>
    14d5:	89 d0                	mov    eax,edx
    14d7:	31 d2                	xor    edx,edx
    14d9:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    14dc:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
						q = q - (r << k);
    14df:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    14e2:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    14e5:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    14e8:	0f a5 c2             	shld   edx,eax,cl
    14eb:	d3 e0                	shl    eax,cl
    14ed:	f6 c1 20             	test   cl,0x20
    14f0:	74 04                	je     14f6 <__divdi3+0x21e>
    14f2:	89 c2                	mov    edx,eax
    14f4:	31 c0                	xor    eax,eax
    14f6:	29 45 c8             	sub    DWORD PTR [ebp-0x38],eax
    14f9:	19 55 cc             	sbb    DWORD PTR [ebp-0x34],edx
		if (rp)
    14fc:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1500:	74 0e                	je     1510 <__divdi3+0x238>
				*rp = r;
    1502:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1505:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1508:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    150b:	89 01                	mov    DWORD PTR [ecx],eax
    150d:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return q;
    1510:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1513:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
    1516:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1519:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (c)
    151c:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1520:	74 0a                	je     152c <__divdi3+0x254>
				w = -w;
    1522:	f7 5d e8             	neg    DWORD PTR [ebp-0x18]
    1525:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0
    1529:	f7 5d ec             	neg    DWORD PTR [ebp-0x14]
	
		return w;
    152c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    152f:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
}
    1532:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1535:	c9                   	leave
    1536:	c3                   	ret
