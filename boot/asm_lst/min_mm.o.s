
min_mm.o:     file format elf32-i386


Disassembly of section .text:

00000000 <fmt_fun>:
		uint16_t free_ct[4];
		struct pmue entries[4];
};

/***************   UTILITY FUNCTIONS   ****************************************/
void fmt_fun(char* p, uint64_t v) {
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 18             	sub    esp,0x18
       6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
       c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
       f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		for (int i = 0; i < 16; i++) {
      12:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
      19:	eb 52                	jmp    6d <fmt_fun+0x6d>
				char c = (v >> 60);
      1b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
      1e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
      21:	89 d0                	mov    eax,edx
      23:	31 d2                	xor    edx,edx
      25:	c1 e8 1c             	shr    eax,0x1c
      28:	88 45 fb             	mov    BYTE PTR [ebp-0x5],al
				if (c > 9)
      2b:	80 7d fb 09          	cmp    BYTE PTR [ebp-0x5],0x9
      2f:	7e 0c                	jle    3d <fmt_fun+0x3d>
						c = 'a' + (c - 10);
      31:	0f b6 45 fb          	movzx  eax,BYTE PTR [ebp-0x5]
      35:	83 c0 57             	add    eax,0x57
      38:	88 45 fb             	mov    BYTE PTR [ebp-0x5],al
      3b:	eb 0a                	jmp    47 <fmt_fun+0x47>
				else
						c = '0' + c;
      3d:	0f b6 45 fb          	movzx  eax,BYTE PTR [ebp-0x5]
      41:	83 c0 30             	add    eax,0x30
      44:	88 45 fb             	mov    BYTE PTR [ebp-0x5],al
				*p++ = c;
      47:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      4a:	8d 50 01             	lea    edx,[eax+0x1]
      4d:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
      50:	0f b6 55 fb          	movzx  edx,BYTE PTR [ebp-0x5]
      54:	88 10                	mov    BYTE PTR [eax],dl
				v <<= 4;
      56:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
      59:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
      5c:	0f a4 c2 04          	shld   edx,eax,0x4
      60:	c1 e0 04             	shl    eax,0x4
      63:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
      66:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		for (int i = 0; i < 16; i++) {
      69:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
      6d:	83 7d fc 0f          	cmp    DWORD PTR [ebp-0x4],0xf
      71:	7e a8                	jle    1b <fmt_fun+0x1b>
		}
}
      73:	90                   	nop
      74:	90                   	nop
      75:	c9                   	leave
      76:	c3                   	ret

00000077 <fmt_fun2>:
void fmt_fun2(char* p, uint32_t v) {
      77:	55                   	push   ebp
      78:	89 e5                	mov    ebp,esp
      7a:	83 ec 10             	sub    esp,0x10
		for (int i = 0; i < 8; i++) {
      7d:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
      84:	eb 3c                	jmp    c2 <fmt_fun2+0x4b>
				char c = (v >> 28);
      86:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      89:	c1 e8 1c             	shr    eax,0x1c
      8c:	88 45 fb             	mov    BYTE PTR [ebp-0x5],al
				if (c > 9)
      8f:	80 7d fb 09          	cmp    BYTE PTR [ebp-0x5],0x9
      93:	7e 0c                	jle    a1 <fmt_fun2+0x2a>
						c = 'a' + (c - 10);
      95:	0f b6 45 fb          	movzx  eax,BYTE PTR [ebp-0x5]
      99:	83 c0 57             	add    eax,0x57
      9c:	88 45 fb             	mov    BYTE PTR [ebp-0x5],al
      9f:	eb 0a                	jmp    ab <fmt_fun2+0x34>
				else
						c = '0' + c;
      a1:	0f b6 45 fb          	movzx  eax,BYTE PTR [ebp-0x5]
      a5:	83 c0 30             	add    eax,0x30
      a8:	88 45 fb             	mov    BYTE PTR [ebp-0x5],al
				*p++ = c;
      ab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      ae:	8d 50 01             	lea    edx,[eax+0x1]
      b1:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
      b4:	0f b6 55 fb          	movzx  edx,BYTE PTR [ebp-0x5]
      b8:	88 10                	mov    BYTE PTR [eax],dl
				v <<= 4;
      ba:	c1 65 0c 04          	shl    DWORD PTR [ebp+0xc],0x4
		for (int i = 0; i < 8; i++) {
      be:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
      c2:	83 7d fc 07          	cmp    DWORD PTR [ebp-0x4],0x7
      c6:	7e be                	jle    86 <fmt_fun2+0xf>
		}
}
      c8:	90                   	nop
      c9:	90                   	nop
      ca:	c9                   	leave
      cb:	c3                   	ret

000000cc <put32>:

void put32(uint32_t num)
{
      cc:	55                   	push   ebp
      cd:	89 e5                	mov    ebp,esp
      cf:	83 ec 18             	sub    esp,0x18
		char buf[] = "0x01234567";
      d2:	c7 45 ed 30 78 30 31 	mov    DWORD PTR [ebp-0x13],0x31307830
      d9:	c7 45 f1 32 33 34 35 	mov    DWORD PTR [ebp-0xf],0x35343332
      e0:	c7 45 f4 35 36 37 00 	mov    DWORD PTR [ebp-0xc],0x373635
		fmt_fun2(buf + 2, num);
      e7:	8d 45 ed             	lea    eax,[ebp-0x13]
      ea:	83 c0 02             	add    eax,0x2
      ed:	ff 75 08             	push   DWORD PTR [ebp+0x8]
      f0:	50                   	push   eax
      f1:	e8 fc ff ff ff       	call   f2 <put32+0x26>
      f6:	83 c4 08             	add    esp,0x8
		putstr(buf);
      f9:	83 ec 0c             	sub    esp,0xc
      fc:	8d 45 ed             	lea    eax,[ebp-0x13]
      ff:	50                   	push   eax
     100:	e8 fc ff ff ff       	call   101 <put32+0x35>
     105:	83 c4 10             	add    esp,0x10
}
     108:	90                   	nop
     109:	c9                   	leave
     10a:	c3                   	ret

0000010b <nput32>:
void nput32(uint32_t num, int min_cc)
{
     10b:	55                   	push   ebp
     10c:	89 e5                	mov    ebp,esp
     10e:	83 ec 28             	sub    esp,0x28
		int len;
		char buf[] = "----------";
     111:	c7 45 e1 2d 2d 2d 2d 	mov    DWORD PTR [ebp-0x1f],0x2d2d2d2d
     118:	c7 45 e5 2d 2d 2d 2d 	mov    DWORD PTR [ebp-0x1b],0x2d2d2d2d
     11f:	c7 45 e8 2d 2d 2d 00 	mov    DWORD PTR [ebp-0x18],0x2d2d2d
		char* c = &buf[9];
     126:	8d 45 e1             	lea    eax,[ebp-0x1f]
     129:	83 c0 09             	add    eax,0x9
     12c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (c >= buf) {
     12f:	eb 4f                	jmp    180 <nput32+0x75>
				uint8_t rem = num % 10;
     131:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     134:	ba cd cc cc cc       	mov    edx,0xcccccccd
     139:	89 c8                	mov    eax,ecx
     13b:	f7 e2                	mul    edx
     13d:	c1 ea 03             	shr    edx,0x3
     140:	89 d0                	mov    eax,edx
     142:	c1 e0 02             	shl    eax,0x2
     145:	01 d0                	add    eax,edx
     147:	01 c0                	add    eax,eax
     149:	29 c1                	sub    ecx,eax
     14b:	89 ca                	mov    edx,ecx
     14d:	88 55 f3             	mov    BYTE PTR [ebp-0xd],dl
				num /= 10;
     150:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     153:	ba cd cc cc cc       	mov    edx,0xcccccccd
     158:	f7 e2                	mul    edx
     15a:	89 d0                	mov    eax,edx
     15c:	c1 e8 03             	shr    eax,0x3
     15f:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
				*c = '0' + rem;
     162:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
     166:	83 c0 30             	add    eax,0x30
     169:	89 c2                	mov    edx,eax
     16b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     16e:	88 10                	mov    BYTE PTR [eax],dl
				c--;
     170:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
				if (!num) {
     174:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     178:	75 06                	jne    180 <nput32+0x75>
						c++;
     17a:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						break;
     17e:	eb 08                	jmp    188 <nput32+0x7d>
		while (c >= buf) {
     180:	8d 45 e1             	lea    eax,[ebp-0x1f]
     183:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
     186:	73 a9                	jae    131 <nput32+0x26>
				}
		}
		len = 10 - (c - buf); /* c-buf=-1 */
     188:	8d 45 e1             	lea    eax,[ebp-0x1f]
     18b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     18e:	29 c2                	sub    edx,eax
     190:	b8 0a 00 00 00       	mov    eax,0xa
     195:	29 d0                	sub    eax,edx
     197:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (min_cc > 0) {
     19a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     19e:	7e 20                	jle    1c0 <nput32+0xb5>
				while (min_cc-- > len)
     1a0:	eb 10                	jmp    1b2 <nput32+0xa7>
						putstr(" ");
     1a2:	83 ec 0c             	sub    esp,0xc
     1a5:	68 0c 00 00 00       	push   0xc
     1aa:	e8 fc ff ff ff       	call   1ab <nput32+0xa0>
     1af:	83 c4 10             	add    esp,0x10
				while (min_cc-- > len)
     1b2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1b5:	8d 50 ff             	lea    edx,[eax-0x1]
     1b8:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     1bb:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
     1be:	7c e2                	jl     1a2 <nput32+0x97>
		}
		putstr(c);
     1c0:	83 ec 0c             	sub    esp,0xc
     1c3:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     1c6:	e8 fc ff ff ff       	call   1c7 <nput32+0xbc>
     1cb:	83 c4 10             	add    esp,0x10
		if (min_cc < 0) {
     1ce:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     1d2:	79 24                	jns    1f8 <nput32+0xed>
				while (len + min_cc++ < 0)
     1d4:	eb 10                	jmp    1e6 <nput32+0xdb>
						putstr(" ");
     1d6:	83 ec 0c             	sub    esp,0xc
     1d9:	68 0c 00 00 00       	push   0xc
     1de:	e8 fc ff ff ff       	call   1df <nput32+0xd4>
     1e3:	83 c4 10             	add    esp,0x10
				while (len + min_cc++ < 0)
     1e6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1e9:	8d 50 01             	lea    edx,[eax+0x1]
     1ec:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     1ef:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     1f2:	01 d0                	add    eax,edx
     1f4:	85 c0                	test   eax,eax
     1f6:	78 de                	js     1d6 <nput32+0xcb>
		}
}
     1f8:	90                   	nop
     1f9:	c9                   	leave
     1fa:	c3                   	ret

000001fb <put64>:
void put64(uint64_t num)
{
     1fb:	55                   	push   ebp
     1fc:	89 e5                	mov    ebp,esp
     1fe:	83 ec 38             	sub    esp,0x38
     201:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     204:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     207:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     20a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		char buf[] = "0x0123456789abcdef";
     20d:	c7 45 e5 30 78 30 31 	mov    DWORD PTR [ebp-0x1b],0x31307830
     214:	c7 45 e9 32 33 34 35 	mov    DWORD PTR [ebp-0x17],0x35343332
     21b:	c7 45 ed 36 37 38 39 	mov    DWORD PTR [ebp-0x13],0x39383736
     222:	c7 45 f1 61 62 63 64 	mov    DWORD PTR [ebp-0xf],0x64636261
     229:	c7 45 f4 64 65 66 00 	mov    DWORD PTR [ebp-0xc],0x666564
		fmt_fun(buf + 2, num);
     230:	8d 45 e5             	lea    eax,[ebp-0x1b]
     233:	83 c0 02             	add    eax,0x2
     236:	83 ec 04             	sub    esp,0x4
     239:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     23c:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     23f:	50                   	push   eax
     240:	e8 fc ff ff ff       	call   241 <put64+0x46>
     245:	83 c4 10             	add    esp,0x10
		putstr(buf);
     248:	83 ec 0c             	sub    esp,0xc
     24b:	8d 45 e5             	lea    eax,[ebp-0x1b]
     24e:	50                   	push   eax
     24f:	e8 fc ff ff ff       	call   250 <put64+0x55>
     254:	83 c4 10             	add    esp,0x10
}
     257:	90                   	nop
     258:	c9                   	leave
     259:	c3                   	ret

0000025a <bzero>:

void bzero(void* ptr, size_t s)
{
     25a:	55                   	push   ebp
     25b:	89 e5                	mov    ebp,esp
     25d:	53                   	push   ebx
		register uint8_t* p = (uint8_t*)ptr;
     25e:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
		if (s >= 8) {
     261:	83 7d 0c 07          	cmp    DWORD PTR [ebp+0xc],0x7
     265:	76 36                	jbe    29d <bzero+0x43>
				/* first align to dword boundary */
				while ((size_t)p % 4) {
     267:	eb 0c                	jmp    275 <bzero+0x1b>
						*p++ = 0;
     269:	89 d8                	mov    eax,ebx
     26b:	8d 58 01             	lea    ebx,[eax+0x1]
     26e:	c6 00 00             	mov    BYTE PTR [eax],0x0
						s--;
     271:	83 6d 0c 01          	sub    DWORD PTR [ebp+0xc],0x1
				while ((size_t)p % 4) {
     275:	89 d8                	mov    eax,ebx
     277:	83 e0 03             	and    eax,0x3
     27a:	85 c0                	test   eax,eax
     27c:	75 eb                	jne    269 <bzero+0xf>
				}
				/* now clear uint32_t-sized blocks */
				while (s >= 4) {
     27e:	eb 0d                	jmp    28d <bzero+0x33>
						*(uint32_t*)p = 0;
     280:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
						p += 4;
     286:	83 c3 04             	add    ebx,0x4
						s -= 4;
     289:	83 6d 0c 04          	sub    DWORD PTR [ebp+0xc],0x4
				while (s >= 4) {
     28d:	83 7d 0c 03          	cmp    DWORD PTR [ebp+0xc],0x3
     291:	77 ed                	ja     280 <bzero+0x26>
				}
		}
		/* set remaining memory */
		while (s--)
     293:	eb 08                	jmp    29d <bzero+0x43>
				*p++ = 0;
     295:	89 d8                	mov    eax,ebx
     297:	8d 58 01             	lea    ebx,[eax+0x1]
     29a:	c6 00 00             	mov    BYTE PTR [eax],0x0
		while (s--)
     29d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     2a0:	8d 50 ff             	lea    edx,[eax-0x1]
     2a3:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     2a6:	85 c0                	test   eax,eax
     2a8:	75 eb                	jne    295 <bzero+0x3b>
}
     2aa:	90                   	nop
     2ab:	90                   	nop
     2ac:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     2af:	c9                   	leave
     2b0:	c3                   	ret

000002b1 <mem_cpy>:

void mem_cpy(void* d, void* s, size_t c)
{
     2b1:	55                   	push   ebp
     2b2:	89 e5                	mov    ebp,esp
     2b4:	83 ec 10             	sub    esp,0x10
		char *p1 = d, *p2 = s;
     2b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2ba:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     2bd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     2c0:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		while (c--)
     2c3:	eb 17                	jmp    2dc <mem_cpy+0x2b>
				*p1++ = *p2++;
     2c5:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
     2c8:	8d 42 01             	lea    eax,[edx+0x1]
     2cb:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     2ce:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     2d1:	8d 48 01             	lea    ecx,[eax+0x1]
     2d4:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
     2d7:	0f b6 12             	movzx  edx,BYTE PTR [edx]
     2da:	88 10                	mov    BYTE PTR [eax],dl
		while (c--)
     2dc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2df:	8d 50 ff             	lea    edx,[eax-0x1]
     2e2:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     2e5:	85 c0                	test   eax,eax
     2e7:	75 dc                	jne    2c5 <mem_cpy+0x14>
}
     2e9:	90                   	nop
     2ea:	90                   	nop
     2eb:	c9                   	leave
     2ec:	c3                   	ret

000002ed <mm_add_free>:
/*************   MEMORY MAP GENERATION   **************************************/
void mm_add_free(uint64_t b, uint64_t s)
{
     2ed:	55                   	push   ebp
     2ee:	89 e5                	mov    ebp,esp
     2f0:	83 ec 10             	sub    esp,0x10
     2f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2f6:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     2f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     2fc:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     2ff:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     302:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     305:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     308:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!s)
     30b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     30e:	0b 45 f4             	or     eax,DWORD PTR [ebp-0xc]
     311:	74 5b                	je     36e <mm_add_free+0x81>
				return;
		bzero(&fmm[fm_ofs], sizeof(*fmm));
     313:	ba 00 40 02 00       	mov    edx,0x24000
     318:	a1 18 00 00 00       	mov    eax,ds:0x18
     31d:	6b c0 38             	imul   eax,eax,0x38
     320:	01 d0                	add    eax,edx
     322:	6a 38                	push   0x38
     324:	50                   	push   eax
     325:	e8 fc ff ff ff       	call   326 <mm_add_free+0x39>
     32a:	83 c4 08             	add    esp,0x8
		fmm[fm_ofs].base = b;
     32d:	ba 00 40 02 00       	mov    edx,0x24000
     332:	a1 18 00 00 00       	mov    eax,ds:0x18
     337:	6b c0 38             	imul   eax,eax,0x38
     33a:	8d 0c 02             	lea    ecx,[edx+eax*1]
     33d:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     340:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     343:	89 01                	mov    DWORD PTR [ecx],eax
     345:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		fmm[fm_ofs++].size = s;
     348:	b9 00 40 02 00       	mov    ecx,0x24000
     34d:	a1 18 00 00 00       	mov    eax,ds:0x18
     352:	8d 50 01             	lea    edx,[eax+0x1]
     355:	89 15 18 00 00 00    	mov    DWORD PTR ds:0x18,edx
     35b:	6b c0 38             	imul   eax,eax,0x38
     35e:	01 c1                	add    ecx,eax
     360:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     363:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     366:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     369:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
     36c:	eb 01                	jmp    36f <mm_add_free+0x82>
				return;
     36e:	90                   	nop
}
     36f:	c9                   	leave
     370:	c3                   	ret

00000371 <mm_add_reserved>:

/* for providing valid MMIO ranges */
void mm_add_reserved(uint64_t b, uint64_t s)
{
     371:	55                   	push   ebp
     372:	89 e5                	mov    ebp,esp
     374:	83 ec 10             	sub    esp,0x10
     377:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     37a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     37d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     380:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     383:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     386:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     389:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     38c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rmm[rm_count].base = b;
     38f:	ba 00 20 02 00       	mov    edx,0x22000
     394:	a1 20 00 00 00       	mov    eax,ds:0x20
     399:	c1 e0 04             	shl    eax,0x4
     39c:	8d 0c 02             	lea    ecx,[edx+eax*1]
     39f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     3a2:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     3a5:	89 01                	mov    DWORD PTR [ecx],eax
     3a7:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		rmm[rm_count++].size = s;
     3aa:	b9 00 20 02 00       	mov    ecx,0x22000
     3af:	a1 20 00 00 00       	mov    eax,ds:0x20
     3b4:	8d 50 01             	lea    edx,[eax+0x1]
     3b7:	89 15 20 00 00 00    	mov    DWORD PTR ds:0x20,edx
     3bd:	c1 e0 04             	shl    eax,0x4
     3c0:	01 c1                	add    ecx,eax
     3c2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     3c5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     3c8:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     3cb:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
}
     3ce:	90                   	nop
     3cf:	c9                   	leave
     3d0:	c3                   	ret

000003d1 <mm_sub_block>:

void mm_sub_block(uint64_t b, uint64_t s)
{
     3d1:	55                   	push   ebp
     3d2:	89 e5                	mov    ebp,esp
     3d4:	53                   	push   ebx
     3d5:	83 ec 34             	sub    esp,0x34
     3d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3db:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     3de:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3e1:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     3e4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     3e7:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     3ea:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     3ed:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		size_t ofs;
		uint64_t end = b + s;
     3f0:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
     3f3:	8b 5d d4             	mov    ebx,DWORD PTR [ebp-0x2c]
     3f6:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     3f9:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     3fc:	01 c8                	add    eax,ecx
     3fe:	11 da                	adc    edx,ebx
     400:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     403:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (!s)
     406:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     409:	0b 45 cc             	or     eax,DWORD PTR [ebp-0x34]
     40c:	0f 84 6c 02 00 00    	je     67e <mm_sub_block+0x2ad>
				return;
		/* search for conflicting entries */
		for (ofs = 0; ofs < fm_ofs; ofs++) {
     412:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     419:	e9 50 02 00 00       	jmp    66e <mm_sub_block+0x29d>
				uint64_t b2 = fmm[ofs].base;
     41e:	ba 00 40 02 00       	mov    edx,0x24000
     423:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     426:	6b c0 38             	imul   eax,eax,0x38
     429:	01 d0                	add    eax,edx
     42b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     42e:	8b 00                	mov    eax,DWORD PTR [eax]
     430:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     433:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				uint64_t end2 = b2 + fmm[ofs].size;
     436:	ba 00 40 02 00       	mov    edx,0x24000
     43b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     43e:	6b c0 38             	imul   eax,eax,0x38
     441:	01 d0                	add    eax,edx
     443:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     446:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
     449:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     44c:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     44f:	01 c8                	add    eax,ecx
     451:	11 da                	adc    edx,ebx
     453:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     456:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

				/* any overlap? */
				if ((end > b2) && (b < end2)) {
     459:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     45c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     45f:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     462:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
     465:	19 d1                	sbb    ecx,edx
     467:	0f 83 fd 01 00 00    	jae    66a <mm_sub_block+0x299>
     46d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     470:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     473:	3b 45 d8             	cmp    eax,DWORD PTR [ebp-0x28]
     476:	89 d0                	mov    eax,edx
     478:	1b 45 dc             	sbb    eax,DWORD PTR [ebp-0x24]
     47b:	0f 83 e9 01 00 00    	jae    66a <mm_sub_block+0x299>
						putstr("O");
     481:	83 ec 0c             	sub    esp,0xc
     484:	68 0e 00 00 00       	push   0xe
     489:	e8 fc ff ff ff       	call   48a <mm_sub_block+0xb9>
     48e:	83 c4 10             	add    esp,0x10
						if (b <= b2) {
     491:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     494:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     497:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     49a:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
     49d:	19 d1                	sbb    ecx,edx
     49f:	0f 82 2e 01 00 00    	jb     5d3 <mm_sub_block+0x202>
								/* overlap below */
								if (b + s >= end2) {
     4a5:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
     4a8:	8b 5d d4             	mov    ebx,DWORD PTR [ebp-0x2c]
     4ab:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     4ae:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     4b1:	01 c8                	add    eax,ecx
     4b3:	11 da                	adc    edx,ebx
     4b5:	3b 45 d8             	cmp    eax,DWORD PTR [ebp-0x28]
     4b8:	89 d0                	mov    eax,edx
     4ba:	1b 45 dc             	sbb    eax,DWORD PTR [ebp-0x24]
     4bd:	0f 82 d2 00 00 00    	jb     595 <mm_sub_block+0x1c4>
										/* complete overlap */
										if (ofs + 1 < fm_ofs) { /* swap out */
     4c3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4c6:	8d 50 01             	lea    edx,[eax+0x1]
     4c9:	a1 18 00 00 00       	mov    eax,ds:0x18
     4ce:	39 c2                	cmp    edx,eax
     4d0:	0f 83 ab 01 00 00    	jae    681 <mm_sub_block+0x2b0>
												fmm[ofs--] = fmm[--fm_ofs];
     4d6:	ba 00 40 02 00       	mov    edx,0x24000
     4db:	a1 18 00 00 00       	mov    eax,ds:0x18
     4e0:	83 e8 01             	sub    eax,0x1
     4e3:	a3 18 00 00 00       	mov    ds:0x18,eax
     4e8:	a1 18 00 00 00       	mov    eax,ds:0x18
     4ed:	6b c0 38             	imul   eax,eax,0x38
     4f0:	01 c2                	add    edx,eax
     4f2:	bb 00 40 02 00       	mov    ebx,0x24000
     4f7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4fa:	8d 48 ff             	lea    ecx,[eax-0x1]
     4fd:	89 4d f4             	mov    DWORD PTR [ebp-0xc],ecx
     500:	6b c0 38             	imul   eax,eax,0x38
     503:	01 d8                	add    eax,ebx
     505:	8b 0a                	mov    ecx,DWORD PTR [edx]
     507:	89 08                	mov    DWORD PTR [eax],ecx
     509:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
     50c:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
     50f:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
     512:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
     515:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
     518:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
     51b:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
     51e:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
     521:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
     524:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
     527:	8b 4a 18             	mov    ecx,DWORD PTR [edx+0x18]
     52a:	89 48 18             	mov    DWORD PTR [eax+0x18],ecx
     52d:	8b 4a 1c             	mov    ecx,DWORD PTR [edx+0x1c]
     530:	89 48 1c             	mov    DWORD PTR [eax+0x1c],ecx
     533:	8b 4a 20             	mov    ecx,DWORD PTR [edx+0x20]
     536:	89 48 20             	mov    DWORD PTR [eax+0x20],ecx
     539:	8b 4a 24             	mov    ecx,DWORD PTR [edx+0x24]
     53c:	89 48 24             	mov    DWORD PTR [eax+0x24],ecx
     53f:	8b 4a 28             	mov    ecx,DWORD PTR [edx+0x28]
     542:	89 48 28             	mov    DWORD PTR [eax+0x28],ecx
     545:	8b 4a 2c             	mov    ecx,DWORD PTR [edx+0x2c]
     548:	89 48 2c             	mov    DWORD PTR [eax+0x2c],ecx
     54b:	8b 4a 30             	mov    ecx,DWORD PTR [edx+0x30]
     54e:	89 48 30             	mov    DWORD PTR [eax+0x30],ecx
     551:	8b 52 34             	mov    edx,DWORD PTR [edx+0x34]
     554:	89 50 34             	mov    DWORD PTR [eax+0x34],edx
												fmm[fm_ofs].base = 0;
     557:	ba 00 40 02 00       	mov    edx,0x24000
     55c:	a1 18 00 00 00       	mov    eax,ds:0x18
     561:	6b c0 38             	imul   eax,eax,0x38
     564:	01 d0                	add    eax,edx
     566:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     56c:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
												fmm[fm_ofs].size = 0;
     573:	ba 00 40 02 00       	mov    edx,0x24000
     578:	a1 18 00 00 00       	mov    eax,ds:0x18
     57d:	6b c0 38             	imul   eax,eax,0x38
     580:	01 d0                	add    eax,edx
     582:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
     589:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
     590:	e9 d5 00 00 00       	jmp    66a <mm_sub_block+0x299>
										} else
												break;
								} else {
										/* only reduce size */
										fmm[ofs].size = end2 - end;
     595:	ba 00 40 02 00       	mov    edx,0x24000
     59a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     59d:	6b c0 38             	imul   eax,eax,0x38
     5a0:	8d 0c 02             	lea    ecx,[edx+eax*1]
     5a3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     5a6:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     5a9:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
     5ac:	1b 55 ec             	sbb    edx,DWORD PTR [ebp-0x14]
     5af:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     5b2:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
										fmm[ofs].base = end;
     5b5:	ba 00 40 02 00       	mov    edx,0x24000
     5ba:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     5bd:	6b c0 38             	imul   eax,eax,0x38
     5c0:	8d 0c 02             	lea    ecx,[edx+eax*1]
     5c3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     5c6:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     5c9:	89 01                	mov    DWORD PTR [ecx],eax
     5cb:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
     5ce:	e9 97 00 00 00       	jmp    66a <mm_sub_block+0x299>
								}
						} else if (end >= end2) {
     5d3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     5d6:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     5d9:	3b 45 d8             	cmp    eax,DWORD PTR [ebp-0x28]
     5dc:	89 d0                	mov    eax,edx
     5de:	1b 45 dc             	sbb    eax,DWORD PTR [ebp-0x24]
     5e1:	72 22                	jb     605 <mm_sub_block+0x234>
								/* overlap on top end */
								fmm[ofs].size = b - b2;
     5e3:	ba 00 40 02 00       	mov    edx,0x24000
     5e8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     5eb:	6b c0 38             	imul   eax,eax,0x38
     5ee:	8d 0c 02             	lea    ecx,[edx+eax*1]
     5f1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     5f4:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     5f7:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
     5fa:	1b 55 e4             	sbb    edx,DWORD PTR [ebp-0x1c]
     5fd:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     600:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
     603:	eb 65                	jmp    66a <mm_sub_block+0x299>
						} else {
								/* overlap in center */
								fmm[fm_ofs].base = end; /* top end */
     605:	ba 00 40 02 00       	mov    edx,0x24000
     60a:	a1 18 00 00 00       	mov    eax,ds:0x18
     60f:	6b c0 38             	imul   eax,eax,0x38
     612:	8d 0c 02             	lea    ecx,[edx+eax*1]
     615:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     618:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     61b:	89 01                	mov    DWORD PTR [ecx],eax
     61d:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								fmm[fm_ofs++].size = end2 - end;
     620:	b9 00 40 02 00       	mov    ecx,0x24000
     625:	a1 18 00 00 00       	mov    eax,ds:0x18
     62a:	8d 50 01             	lea    edx,[eax+0x1]
     62d:	89 15 18 00 00 00    	mov    DWORD PTR ds:0x18,edx
     633:	6b c0 38             	imul   eax,eax,0x38
     636:	01 c1                	add    ecx,eax
     638:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     63b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     63e:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
     641:	1b 55 ec             	sbb    edx,DWORD PTR [ebp-0x14]
     644:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     647:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
								fmm[ofs].size = b - b2; /* lower end */
     64a:	ba 00 40 02 00       	mov    edx,0x24000
     64f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     652:	6b c0 38             	imul   eax,eax,0x38
     655:	8d 0c 02             	lea    ecx,[edx+eax*1]
     658:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     65b:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     65e:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
     661:	1b 55 e4             	sbb    edx,DWORD PTR [ebp-0x1c]
     664:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     667:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
		for (ofs = 0; ofs < fm_ofs; ofs++) {
     66a:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     66e:	a1 18 00 00 00       	mov    eax,ds:0x18
     673:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
     676:	0f 82 a2 fd ff ff    	jb     41e <mm_sub_block+0x4d>
     67c:	eb 04                	jmp    682 <mm_sub_block+0x2b1>
				return;
     67e:	90                   	nop
     67f:	eb 01                	jmp    682 <mm_sub_block+0x2b1>
												break;
     681:	90                   	nop
						}
				}
		}
}
     682:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     685:	c9                   	leave
     686:	c3                   	ret

00000687 <mm_sort_and_merge>:

void mm_sort_and_merge()
{
     687:	55                   	push   ebp
     688:	89 e5                	mov    ebp,esp
     68a:	57                   	push   edi
     68b:	56                   	push   esi
     68c:	53                   	push   ebx
     68d:	83 ec 64             	sub    esp,0x64
		size_t n = fm_ofs, i; int new_n;
     690:	a1 18 00 00 00       	mov    eax,ds:0x18
     695:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		/* bubble sort */
		do {
				new_n = 1;
     698:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
				for (i = 0; i < n - 1; i++) {
     69f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     6a6:	e9 72 01 00 00       	jmp    81d <mm_sort_and_merge+0x196>
						if (fmm[i].base > fmm[i + 1].base) {
     6ab:	ba 00 40 02 00       	mov    edx,0x24000
     6b0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6b3:	6b c0 38             	imul   eax,eax,0x38
     6b6:	01 d0                	add    eax,edx
     6b8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     6bb:	8b 00                	mov    eax,DWORD PTR [eax]
     6bd:	bb 00 40 02 00       	mov    ebx,0x24000
     6c2:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     6c5:	83 c1 01             	add    ecx,0x1
     6c8:	6b c9 38             	imul   ecx,ecx,0x38
     6cb:	01 d9                	add    ecx,ebx
     6cd:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
     6d0:	8b 09                	mov    ecx,DWORD PTR [ecx]
     6d2:	39 c1                	cmp    ecx,eax
     6d4:	89 df                	mov    edi,ebx
     6d6:	19 d7                	sbb    edi,edx
     6d8:	0f 83 3b 01 00 00    	jae    819 <mm_sort_and_merge+0x192>
								struct fme fm = fmm[i + 1];
     6de:	ba 00 40 02 00       	mov    edx,0x24000
     6e3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6e6:	83 c0 01             	add    eax,0x1
     6e9:	6b c0 38             	imul   eax,eax,0x38
     6ec:	01 d0                	add    eax,edx
     6ee:	8b 10                	mov    edx,DWORD PTR [eax]
     6f0:	89 55 98             	mov    DWORD PTR [ebp-0x68],edx
     6f3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     6f6:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
     6f9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     6fc:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
     6ff:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     702:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
     705:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     708:	89 55 a8             	mov    DWORD PTR [ebp-0x58],edx
     70b:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     70e:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
     711:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     714:	89 55 b0             	mov    DWORD PTR [ebp-0x50],edx
     717:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     71a:	89 55 b4             	mov    DWORD PTR [ebp-0x4c],edx
     71d:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
     720:	89 55 b8             	mov    DWORD PTR [ebp-0x48],edx
     723:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
     726:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
     729:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
     72c:	89 55 c0             	mov    DWORD PTR [ebp-0x40],edx
     72f:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
     732:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
     735:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
     738:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
     73b:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     73e:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								fmm[i + 1] = fmm[i];
     741:	ba 00 40 02 00       	mov    edx,0x24000
     746:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     749:	6b c0 38             	imul   eax,eax,0x38
     74c:	01 c2                	add    edx,eax
     74e:	b9 00 40 02 00       	mov    ecx,0x24000
     753:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     756:	83 c0 01             	add    eax,0x1
     759:	6b c0 38             	imul   eax,eax,0x38
     75c:	01 c8                	add    eax,ecx
     75e:	8b 0a                	mov    ecx,DWORD PTR [edx]
     760:	89 08                	mov    DWORD PTR [eax],ecx
     762:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
     765:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
     768:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
     76b:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
     76e:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
     771:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
     774:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
     777:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
     77a:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
     77d:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
     780:	8b 4a 18             	mov    ecx,DWORD PTR [edx+0x18]
     783:	89 48 18             	mov    DWORD PTR [eax+0x18],ecx
     786:	8b 4a 1c             	mov    ecx,DWORD PTR [edx+0x1c]
     789:	89 48 1c             	mov    DWORD PTR [eax+0x1c],ecx
     78c:	8b 4a 20             	mov    ecx,DWORD PTR [edx+0x20]
     78f:	89 48 20             	mov    DWORD PTR [eax+0x20],ecx
     792:	8b 4a 24             	mov    ecx,DWORD PTR [edx+0x24]
     795:	89 48 24             	mov    DWORD PTR [eax+0x24],ecx
     798:	8b 4a 28             	mov    ecx,DWORD PTR [edx+0x28]
     79b:	89 48 28             	mov    DWORD PTR [eax+0x28],ecx
     79e:	8b 4a 2c             	mov    ecx,DWORD PTR [edx+0x2c]
     7a1:	89 48 2c             	mov    DWORD PTR [eax+0x2c],ecx
     7a4:	8b 4a 30             	mov    ecx,DWORD PTR [edx+0x30]
     7a7:	89 48 30             	mov    DWORD PTR [eax+0x30],ecx
     7aa:	8b 52 34             	mov    edx,DWORD PTR [edx+0x34]
     7ad:	89 50 34             	mov    DWORD PTR [eax+0x34],edx
								fmm[i] = fm;
     7b0:	ba 00 40 02 00       	mov    edx,0x24000
     7b5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     7b8:	6b c0 38             	imul   eax,eax,0x38
     7bb:	01 d0                	add    eax,edx
     7bd:	8b 55 98             	mov    edx,DWORD PTR [ebp-0x68]
     7c0:	89 10                	mov    DWORD PTR [eax],edx
     7c2:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
     7c5:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     7c8:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
     7cb:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
     7ce:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     7d1:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
     7d4:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
     7d7:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
     7da:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     7dd:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
     7e0:	8b 55 b0             	mov    edx,DWORD PTR [ebp-0x50]
     7e3:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
     7e6:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
     7e9:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
     7ec:	8b 55 b8             	mov    edx,DWORD PTR [ebp-0x48]
     7ef:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
     7f2:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     7f5:	89 50 24             	mov    DWORD PTR [eax+0x24],edx
     7f8:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
     7fb:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
     7fe:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     801:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
     804:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     807:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
     80a:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     80d:	89 50 34             	mov    DWORD PTR [eax+0x34],edx
								new_n = i + 1;
     810:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     813:	83 c0 01             	add    eax,0x1
     816:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				for (i = 0; i < n - 1; i++) {
     819:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
     81d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     820:	83 e8 01             	sub    eax,0x1
     823:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
     826:	0f 82 7f fe ff ff    	jb     6ab <mm_sort_and_merge+0x24>
						}
				}
				n = new_n;
     82c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     82f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		} while (n > 1);
     832:	83 7d ec 01          	cmp    DWORD PTR [ebp-0x14],0x1
     836:	0f 87 5c fe ff ff    	ja     698 <mm_sort_and_merge+0x11>
		/* do the same with the reserved entries */
		do {
				new_n = 1;
     83c:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
				for (i = 0; i < n; i++) {
     843:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     84a:	e9 be 00 00 00       	jmp    90d <mm_sort_and_merge+0x286>
						if (rmm[i].base > rmm[i + 1].base) {
     84f:	ba 00 20 02 00       	mov    edx,0x22000
     854:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     857:	c1 e0 04             	shl    eax,0x4
     85a:	01 d0                	add    eax,edx
     85c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     85f:	8b 00                	mov    eax,DWORD PTR [eax]
     861:	bb 00 20 02 00       	mov    ebx,0x22000
     866:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     869:	83 c1 01             	add    ecx,0x1
     86c:	c1 e1 04             	shl    ecx,0x4
     86f:	01 d9                	add    ecx,ebx
     871:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
     874:	8b 09                	mov    ecx,DWORD PTR [ecx]
     876:	39 c1                	cmp    ecx,eax
     878:	89 df                	mov    edi,ebx
     87a:	19 d7                	sbb    edi,edx
     87c:	0f 83 87 00 00 00    	jae    909 <mm_sort_and_merge+0x282>
								struct rme rm = rmm[i + 1];
     882:	ba 00 20 02 00       	mov    edx,0x22000
     887:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     88a:	83 c0 01             	add    eax,0x1
     88d:	c1 e0 04             	shl    eax,0x4
     890:	01 d0                	add    eax,edx
     892:	8b 10                	mov    edx,DWORD PTR [eax]
     894:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
     897:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     89a:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
     89d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     8a0:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     8a3:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     8a6:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								rmm[i + 1] = rmm[i];
     8a9:	ba 00 20 02 00       	mov    edx,0x22000
     8ae:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     8b1:	c1 e0 04             	shl    eax,0x4
     8b4:	01 c2                	add    edx,eax
     8b6:	b9 00 20 02 00       	mov    ecx,0x22000
     8bb:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     8be:	83 c0 01             	add    eax,0x1
     8c1:	c1 e0 04             	shl    eax,0x4
     8c4:	01 c8                	add    eax,ecx
     8c6:	8b 0a                	mov    ecx,DWORD PTR [edx]
     8c8:	89 08                	mov    DWORD PTR [eax],ecx
     8ca:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
     8cd:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
     8d0:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
     8d3:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
     8d6:	8b 52 0c             	mov    edx,DWORD PTR [edx+0xc]
     8d9:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
								rmm[i] = rm;
     8dc:	ba 00 20 02 00       	mov    edx,0x22000
     8e1:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     8e4:	c1 e0 04             	shl    eax,0x4
     8e7:	01 d0                	add    eax,edx
     8e9:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     8ec:	89 10                	mov    DWORD PTR [eax],edx
     8ee:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     8f1:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     8f4:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     8f7:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
     8fa:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     8fd:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
								new_n = i + 1;
     900:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     903:	83 c0 01             	add    eax,0x1
     906:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				for (i = 0; i < n; i++) {
     909:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
     90d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     910:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
     913:	0f 82 36 ff ff ff    	jb     84f <mm_sort_and_merge+0x1c8>
						}
				}
		} while (n > 1);
     919:	83 7d ec 01          	cmp    DWORD PTR [ebp-0x14],0x1
     91d:	0f 87 19 ff ff ff    	ja     83c <mm_sort_and_merge+0x1b5>

		/* merge adjacent elements */
		for (i = 0; i < fm_ofs - 1; i++)
     923:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     92a:	e9 88 01 00 00       	jmp    ab7 <mm_sort_and_merge+0x430>
				if (fmm[i].base + fmm[i].size >= fmm[i + 1].base) {
     92f:	ba 00 40 02 00       	mov    edx,0x24000
     934:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     937:	6b c0 38             	imul   eax,eax,0x38
     93a:	01 d0                	add    eax,edx
     93c:	8b 08                	mov    ecx,DWORD PTR [eax]
     93e:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     941:	ba 00 40 02 00       	mov    edx,0x24000
     946:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     949:	6b c0 38             	imul   eax,eax,0x38
     94c:	01 d0                	add    eax,edx
     94e:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     951:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     954:	01 c1                	add    ecx,eax
     956:	11 d3                	adc    ebx,edx
     958:	ba 00 40 02 00       	mov    edx,0x24000
     95d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     960:	83 c0 01             	add    eax,0x1
     963:	6b c0 38             	imul   eax,eax,0x38
     966:	01 d0                	add    eax,edx
     968:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     96b:	8b 00                	mov    eax,DWORD PTR [eax]
     96d:	39 c1                	cmp    ecx,eax
     96f:	19 d3                	sbb    ebx,edx
     971:	0f 82 3c 01 00 00    	jb     ab3 <mm_sort_and_merge+0x42c>
						fmm[i].size = (fmm[i + 1].base + fmm[i + 1].size) - fmm[i].base;
     977:	ba 00 40 02 00       	mov    edx,0x24000
     97c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     97f:	83 c0 01             	add    eax,0x1
     982:	6b c0 38             	imul   eax,eax,0x38
     985:	01 d0                	add    eax,edx
     987:	8b 08                	mov    ecx,DWORD PTR [eax]
     989:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     98c:	ba 00 40 02 00       	mov    edx,0x24000
     991:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     994:	83 c0 01             	add    eax,0x1
     997:	6b c0 38             	imul   eax,eax,0x38
     99a:	01 d0                	add    eax,edx
     99c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     99f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     9a2:	01 c8                	add    eax,ecx
     9a4:	11 da                	adc    edx,ebx
     9a6:	bb 00 40 02 00       	mov    ebx,0x24000
     9ab:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     9ae:	6b c9 38             	imul   ecx,ecx,0x38
     9b1:	01 d9                	add    ecx,ebx
     9b3:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
     9b6:	8b 09                	mov    ecx,DWORD PTR [ecx]
     9b8:	bf 00 40 02 00       	mov    edi,0x24000
     9bd:	8b 75 e8             	mov    esi,DWORD PTR [ebp-0x18]
     9c0:	6b f6 38             	imul   esi,esi,0x38
     9c3:	01 fe                	add    esi,edi
     9c5:	29 c8                	sub    eax,ecx
     9c7:	19 da                	sbb    edx,ebx
     9c9:	89 46 08             	mov    DWORD PTR [esi+0x8],eax
     9cc:	89 56 0c             	mov    DWORD PTR [esi+0xc],edx
						if (i + 1 < fm_ofs) {
     9cf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9d2:	8d 50 01             	lea    edx,[eax+0x1]
     9d5:	a1 18 00 00 00       	mov    eax,ds:0x18
     9da:	39 c2                	cmp    edx,eax
     9dc:	0f 83 8b 00 00 00    	jae    a6d <mm_sort_and_merge+0x3e6>
								size_t n;
								for (n = i + 1; n < fm_ofs - 1; n++)
     9e2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9e5:	83 c0 01             	add    eax,0x1
     9e8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     9eb:	eb 73                	jmp    a60 <mm_sort_and_merge+0x3d9>
										fmm[n] = fmm[n + 1];
     9ed:	ba 00 40 02 00       	mov    edx,0x24000
     9f2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     9f5:	83 c0 01             	add    eax,0x1
     9f8:	6b c0 38             	imul   eax,eax,0x38
     9fb:	01 c2                	add    edx,eax
     9fd:	b9 00 40 02 00       	mov    ecx,0x24000
     a02:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     a05:	6b c0 38             	imul   eax,eax,0x38
     a08:	01 c8                	add    eax,ecx
     a0a:	8b 0a                	mov    ecx,DWORD PTR [edx]
     a0c:	89 08                	mov    DWORD PTR [eax],ecx
     a0e:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
     a11:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
     a14:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
     a17:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
     a1a:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
     a1d:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
     a20:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
     a23:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
     a26:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
     a29:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
     a2c:	8b 4a 18             	mov    ecx,DWORD PTR [edx+0x18]
     a2f:	89 48 18             	mov    DWORD PTR [eax+0x18],ecx
     a32:	8b 4a 1c             	mov    ecx,DWORD PTR [edx+0x1c]
     a35:	89 48 1c             	mov    DWORD PTR [eax+0x1c],ecx
     a38:	8b 4a 20             	mov    ecx,DWORD PTR [edx+0x20]
     a3b:	89 48 20             	mov    DWORD PTR [eax+0x20],ecx
     a3e:	8b 4a 24             	mov    ecx,DWORD PTR [edx+0x24]
     a41:	89 48 24             	mov    DWORD PTR [eax+0x24],ecx
     a44:	8b 4a 28             	mov    ecx,DWORD PTR [edx+0x28]
     a47:	89 48 28             	mov    DWORD PTR [eax+0x28],ecx
     a4a:	8b 4a 2c             	mov    ecx,DWORD PTR [edx+0x2c]
     a4d:	89 48 2c             	mov    DWORD PTR [eax+0x2c],ecx
     a50:	8b 4a 30             	mov    ecx,DWORD PTR [edx+0x30]
     a53:	89 48 30             	mov    DWORD PTR [eax+0x30],ecx
     a56:	8b 52 34             	mov    edx,DWORD PTR [edx+0x34]
     a59:	89 50 34             	mov    DWORD PTR [eax+0x34],edx
								for (n = i + 1; n < fm_ofs - 1; n++)
     a5c:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
     a60:	a1 18 00 00 00       	mov    eax,ds:0x18
     a65:	83 e8 01             	sub    eax,0x1
     a68:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
     a6b:	72 80                	jb     9ed <mm_sort_and_merge+0x366>
						}
						fm_ofs--;
     a6d:	a1 18 00 00 00       	mov    eax,ds:0x18
     a72:	83 e8 01             	sub    eax,0x1
     a75:	a3 18 00 00 00       	mov    ds:0x18,eax
						fmm[fm_ofs].base = 0;
     a7a:	ba 00 40 02 00       	mov    edx,0x24000
     a7f:	a1 18 00 00 00       	mov    eax,ds:0x18
     a84:	6b c0 38             	imul   eax,eax,0x38
     a87:	01 d0                	add    eax,edx
     a89:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     a8f:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
						fmm[fm_ofs].size = 0;
     a96:	ba 00 40 02 00       	mov    edx,0x24000
     a9b:	a1 18 00 00 00       	mov    eax,ds:0x18
     aa0:	6b c0 38             	imul   eax,eax,0x38
     aa3:	01 d0                	add    eax,edx
     aa5:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
     aac:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		for (i = 0; i < fm_ofs - 1; i++)
     ab3:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
     ab7:	a1 18 00 00 00       	mov    eax,ds:0x18
     abc:	83 e8 01             	sub    eax,0x1
     abf:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
     ac2:	0f 82 67 fe ff ff    	jb     92f <mm_sort_and_merge+0x2a8>
				}
}
     ac8:	90                   	nop
     ac9:	90                   	nop
     aca:	83 c4 64             	add    esp,0x64
     acd:	5b                   	pop    ebx
     ace:	5e                   	pop    esi
     acf:	5f                   	pop    edi
     ad0:	5d                   	pop    ebp
     ad1:	c3                   	ret

00000ad2 <mm_init_pmu>:
/*************   PHYSICAL MEMORY ALLOCATION   *********************************/
/* returns nonzero if locked */
int mm_init_pmu(struct pmu* p)
{
     ad2:	55                   	push   ebp
     ad3:	89 e5                	mov    ebp,esp
     ad5:	57                   	push   edi
     ad6:	53                   	push   ebx
		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
     ad7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ada:	8d 50 0a             	lea    edx,[eax+0xa]
     add:	b8 ff ff ff ff       	mov    eax,0xffffffff
     ae2:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
     ae7:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
     aec:	0f 94 c0             	sete   al
     aef:	83 f0 01             	xor    eax,0x1
     af2:	84 c0                	test   al,al
     af4:	74 07                	je     afd <mm_init_pmu+0x2b>
				return -1;
     af6:	b8 ff ff ff ff       	mov    eax,0xffffffff
     afb:	eb 63                	jmp    b60 <mm_init_pmu+0x8e>

		/* we're free to initialize (all full) */
		__builtin_memset(p->entries, 0xff, sizeof(p->entries));
     afd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b00:	83 c0 10             	add    eax,0x10
     b03:	b9 f0 0f 00 00       	mov    ecx,0xff0
     b08:	bb ff ff ff ff       	mov    ebx,0xffffffff
     b0d:	89 18                	mov    DWORD PTR [eax],ebx
     b0f:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     b13:	8d 50 04             	lea    edx,[eax+0x4]
     b16:	83 e2 fc             	and    edx,0xfffffffc
     b19:	29 d0                	sub    eax,edx
     b1b:	01 c1                	add    ecx,eax
     b1d:	83 e1 fc             	and    ecx,0xfffffffc
     b20:	c1 e9 02             	shr    ecx,0x2
     b23:	89 d7                	mov    edi,edx
     b25:	89 d8                	mov    eax,ebx
     b27:	f3 ab                	rep stos DWORD PTR es:[edi],eax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
     b29:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b2c:	6a 08                	push   0x8
     b2e:	50                   	push   eax
     b2f:	e8 fc ff ff ff       	call   b30 <mm_init_pmu+0x5e>
     b34:	83 c4 08             	add    esp,0x8
		p->free_ct[3] = 0;
     b37:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b3a:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
		p->free_ct[2] = 0;
     b40:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b43:	66 c7 40 0c 00 00    	mov    WORD PTR [eax+0xc],0x0
		p->free_ct[1] = 0;
     b49:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b4c:	66 c7 40 0a 00 00    	mov    WORD PTR [eax+0xa],0x0
		p->free_ct[0] = 0;
     b52:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b55:	66 c7 40 08 00 00    	mov    WORD PTR [eax+0x8],0x0
		return 0;
     b5b:	b8 00 00 00 00       	mov    eax,0x0
}
     b60:	8d 65 f8             	lea    esp,[ebp-0x8]
     b63:	5b                   	pop    ebx
     b64:	5f                   	pop    edi
     b65:	5d                   	pop    ebp
     b66:	c3                   	ret

00000b67 <mm_init_rcp>:

/* returns nonzero if locked */
int mm_init_rcp(struct pmu* p)
{
     b67:	55                   	push   ebp
     b68:	89 e5                	mov    ebp,esp
     b6a:	57                   	push   edi
     b6b:	53                   	push   ebx
     b6c:	83 ec 20             	sub    esp,0x20
		uint16_t rem, fc[4] = { 4096, 4096, 4096, 4096 };
     b6f:	66 c7 45 d8 00 10    	mov    WORD PTR [ebp-0x28],0x1000
     b75:	66 c7 45 da 00 10    	mov    WORD PTR [ebp-0x26],0x1000
     b7b:	66 c7 45 dc 00 10    	mov    WORD PTR [ebp-0x24],0x1000
     b81:	66 c7 45 de 00 10    	mov    WORD PTR [ebp-0x22],0x1000

		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
     b87:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b8a:	8d 50 0a             	lea    edx,[eax+0xa]
     b8d:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b92:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
     b97:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
     b9c:	0f 94 c0             	sete   al
     b9f:	83 f0 01             	xor    eax,0x1
     ba2:	84 c0                	test   al,al
     ba4:	74 0a                	je     bb0 <mm_init_rcp+0x49>
				return -1;
     ba6:	b8 ff ff ff ff       	mov    eax,0xffffffff
     bab:	e9 75 02 00 00       	jmp    e25 <mm_init_rcp+0x2be>

		/* check if last */
		rem = p->free_ct[3];
     bb0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bb3:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     bb7:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax

		if (rem != 0xffff) {
     bbb:	66 83 7d f6 ff       	cmp    WORD PTR [ebp-0xa],0xffff
     bc0:	0f 84 f4 01 00 00    	je     dba <mm_init_rcp+0x253>
				for (size_t i = 0; i < 4; i++) {
     bc6:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     bcd:	e9 dc 01 00 00       	jmp    dae <mm_init_rcp+0x247>
						if (rem >= 4096) { /* still easy */
     bd2:	66 81 7d f6 ff 0f    	cmp    WORD PTR [ebp-0xa],0xfff
     bd8:	76 42                	jbe    c1c <mm_init_rcp+0xb5>
								/* set everything reclaimable */
								__builtin_memset(&p->entries[i], 0xff,
     bda:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     bdd:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     be3:	8d 50 10             	lea    edx,[eax+0x10]
     be6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     be9:	01 d0                	add    eax,edx
     beb:	b9 fc 03 00 00       	mov    ecx,0x3fc
     bf0:	bb ff ff ff ff       	mov    ebx,0xffffffff
     bf5:	89 18                	mov    DWORD PTR [eax],ebx
     bf7:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     bfb:	8d 50 04             	lea    edx,[eax+0x4]
     bfe:	83 e2 fc             	and    edx,0xfffffffc
     c01:	29 d0                	sub    eax,edx
     c03:	01 c1                	add    ecx,eax
     c05:	83 e1 fc             	and    ecx,0xfffffffc
     c08:	c1 e9 02             	shr    ecx,0x2
     c0b:	89 d7                	mov    edi,edx
     c0d:	89 d8                	mov    eax,ebx
     c0f:	f3 ab                	rep stos DWORD PTR es:[edi],eax
												sizeof(p->entries[i]));
								/* advance */
								rem -= 4096;
     c11:	66 81 6d f6 00 10    	sub    WORD PTR [ebp-0xa],0x1000
     c17:	e9 8e 01 00 00       	jmp    daa <mm_init_rcp+0x243>
						} else {
								/* fill partially (0, 2, 7) */
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     c1c:	66 c7 45 ee 00 00    	mov    WORD PTR [ebp-0x12],0x0
     c22:	66 c7 45 ec 00 00    	mov    WORD PTR [ebp-0x14],0x0
     c28:	eb 6e                	jmp    c98 <mm_init_rcp+0x131>
										uint32_t val = 0;
     c2a:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
										if (rem > of) {
     c31:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     c35:	66 39 45 ec          	cmp    WORD PTR [ebp-0x14],ax
     c39:	73 31                	jae    c6c <mm_init_rcp+0x105>
												if (rem - of >= 32) /* set full */
     c3b:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     c3f:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
     c43:	29 c2                	sub    edx,eax
     c45:	83 fa 1f             	cmp    edx,0x1f
     c48:	7e 09                	jle    c53 <mm_init_rcp+0xec>
														val = 0xffffffff;
     c4a:	c7 45 e8 ff ff ff ff 	mov    DWORD PTR [ebp-0x18],0xffffffff
     c51:	eb 19                	jmp    c6c <mm_init_rcp+0x105>
												else /* set partial */
														val = (1 << (rem - of)) - 1;
     c53:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     c57:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
     c5b:	29 c2                	sub    edx,eax
     c5d:	b8 01 00 00 00       	mov    eax,0x1
     c62:	89 d1                	mov    ecx,edx
     c64:	d3 e0                	shl    eax,cl
     c66:	83 e8 01             	sub    eax,0x1
     c69:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										}
										p->entries[i].lvl0[j] = val;
     c6c:	0f b7 5d ee          	movzx  ebx,WORD PTR [ebp-0x12]
     c70:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     c73:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c76:	89 d0                	mov    eax,edx
     c78:	c1 e0 08             	shl    eax,0x8
     c7b:	29 d0                	sub    eax,edx
     c7d:	01 d8                	add    eax,ebx
     c7f:	8d 50 04             	lea    edx,[eax+0x4]
     c82:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     c85:	89 04 91             	mov    DWORD PTR [ecx+edx*4],eax
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     c88:	66 83 45 ec 20       	add    WORD PTR [ebp-0x14],0x20
     c8d:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     c91:	83 c0 01             	add    eax,0x1
     c94:	66 89 45 ee          	mov    WORD PTR [ebp-0x12],ax
     c98:	66 83 7d ee 7f       	cmp    WORD PTR [ebp-0x12],0x7f
     c9d:	76 8b                	jbe    c2a <mm_init_rcp+0xc3>
								}
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     c9f:	66 c7 45 e6 00 00    	mov    WORD PTR [ebp-0x1a],0x0
     ca5:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
     cab:	e9 9b 00 00 00       	jmp    d4b <mm_init_rcp+0x1e4>
										uint32_t val = 0;
     cb0:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
										if (rem > of) {
     cb7:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     cbb:	66 39 45 e4          	cmp    WORD PTR [ebp-0x1c],ax
     cbf:	73 5b                	jae    d1c <mm_init_rcp+0x1b5>
												if (rem - of >= 128)
     cc1:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     cc5:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     cc9:	29 c2                	sub    edx,eax
     ccb:	83 fa 7f             	cmp    edx,0x7f
     cce:	7e 09                	jle    cd9 <mm_init_rcp+0x172>
														val = 0xffffffff;
     cd0:	c7 45 e0 ff ff ff ff 	mov    DWORD PTR [ebp-0x20],0xffffffff
     cd7:	eb 43                	jmp    d1c <mm_init_rcp+0x1b5>
												else /* set partial */
														val = (1 << rdiv(rem - of, 4)) - 1;
     cd9:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     cdd:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     ce1:	29 c2                	sub    edx,eax
     ce3:	89 d0                	mov    eax,edx
     ce5:	8d 50 03             	lea    edx,[eax+0x3]
     ce8:	85 c0                	test   eax,eax
     cea:	0f 48 c2             	cmovs  eax,edx
     ced:	c1 f8 02             	sar    eax,0x2
     cf0:	89 c1                	mov    ecx,eax
     cf2:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     cf6:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     cfa:	29 c2                	sub    edx,eax
     cfc:	89 d0                	mov    eax,edx
     cfe:	83 e0 03             	and    eax,0x3
     d01:	85 c0                	test   eax,eax
     d03:	0f 95 c0             	setne  al
     d06:	0f b6 c0             	movzx  eax,al
     d09:	01 c8                	add    eax,ecx
     d0b:	ba 01 00 00 00       	mov    edx,0x1
     d10:	89 c1                	mov    ecx,eax
     d12:	d3 e2                	shl    edx,cl
     d14:	89 d0                	mov    eax,edx
     d16:	83 e8 01             	sub    eax,0x1
     d19:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										}
										p->entries[i].lvl2[j] = val;
     d1c:	0f b7 5d e6          	movzx  ebx,WORD PTR [ebp-0x1a]
     d20:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     d23:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d26:	89 d0                	mov    eax,edx
     d28:	c1 e0 08             	shl    eax,0x8
     d2b:	29 d0                	sub    eax,edx
     d2d:	01 d8                	add    eax,ebx
     d2f:	8d 90 c4 00 00 00    	lea    edx,[eax+0xc4]
     d35:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d38:	89 04 91             	mov    DWORD PTR [ecx+edx*4],eax
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     d3b:	66 83 6d e4 80       	sub    WORD PTR [ebp-0x1c],0xff80
     d40:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     d44:	83 c0 01             	add    eax,0x1
     d47:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
     d4b:	66 83 7d e6 1f       	cmp    WORD PTR [ebp-0x1a],0x1f
     d50:	0f 86 5a ff ff ff    	jbe    cb0 <mm_init_rcp+0x149>
								}
								p->entries[i].lvl7 = (1 << rdiv(rem, 32)) - 1;
     d56:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     d5a:	66 c1 e8 05          	shr    ax,0x5
     d5e:	0f b7 d0             	movzx  edx,ax
     d61:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     d65:	83 e0 1f             	and    eax,0x1f
     d68:	66 85 c0             	test   ax,ax
     d6b:	0f 95 c0             	setne  al
     d6e:	0f b6 c0             	movzx  eax,al
     d71:	01 d0                	add    eax,edx
     d73:	ba 01 00 00 00       	mov    edx,0x1
     d78:	89 c1                	mov    ecx,eax
     d7a:	d3 e2                	shl    edx,cl
     d7c:	89 d0                	mov    eax,edx
     d7e:	83 e8 01             	sub    eax,0x1
     d81:	89 c1                	mov    ecx,eax
     d83:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     d86:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d89:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     d8f:	01 d0                	add    eax,edx
     d91:	05 08 04 00 00       	add    eax,0x408
     d96:	89 08                	mov    DWORD PTR [eax],ecx

								/* advance */
								fc[i] = rem;
     d98:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d9b:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     d9f:	66 89 54 45 d8       	mov    WORD PTR [ebp+eax*2-0x28],dx
								rem = 0;
     da4:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
				for (size_t i = 0; i < 4; i++) {
     daa:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     dae:	83 7d f0 03          	cmp    DWORD PTR [ebp-0x10],0x3
     db2:	0f 86 1a fe ff ff    	jbe    bd2 <mm_init_rcp+0x6b>
     db8:	eb 2c                	jmp    de6 <mm_init_rcp+0x27f>
						}
				}
		} else /* very easy: everything is reclaimable */
				__builtin_memset(p->entries, 0xff, sizeof(p->entries));
     dba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dbd:	83 c0 10             	add    eax,0x10
     dc0:	b9 f0 0f 00 00       	mov    ecx,0xff0
     dc5:	bb ff ff ff ff       	mov    ebx,0xffffffff
     dca:	89 18                	mov    DWORD PTR [eax],ebx
     dcc:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     dd0:	8d 50 04             	lea    edx,[eax+0x4]
     dd3:	83 e2 fc             	and    edx,0xfffffffc
     dd6:	29 d0                	sub    eax,edx
     dd8:	01 c1                	add    ecx,eax
     dda:	83 e1 fc             	and    ecx,0xfffffffc
     ddd:	c1 e9 02             	shr    ecx,0x2
     de0:	89 d7                	mov    edi,edx
     de2:	89 d8                	mov    eax,ebx
     de4:	f3 ab                	rep stos DWORD PTR es:[edi],eax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
     de6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     de9:	6a 08                	push   0x8
     deb:	50                   	push   eax
     dec:	e8 fc ff ff ff       	call   ded <mm_init_rcp+0x286>
     df1:	83 c4 08             	add    esp,0x8
		p->free_ct[3] = fc[3];
     df4:	0f b7 55 de          	movzx  edx,WORD PTR [ebp-0x22]
     df8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dfb:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
		p->free_ct[2] = fc[2];
     dff:	0f b7 55 dc          	movzx  edx,WORD PTR [ebp-0x24]
     e03:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e06:	66 89 50 0c          	mov    WORD PTR [eax+0xc],dx
		p->free_ct[1] = fc[1];
     e0a:	0f b7 55 da          	movzx  edx,WORD PTR [ebp-0x26]
     e0e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e11:	66 89 50 0a          	mov    WORD PTR [eax+0xa],dx
		p->free_ct[0] = fc[0];
     e15:	0f b7 55 d8          	movzx  edx,WORD PTR [ebp-0x28]
     e19:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e1c:	66 89 50 08          	mov    WORD PTR [eax+0x8],dx
		return 0;
     e20:	b8 00 00 00 00       	mov    eax,0x0
}
     e25:	8d 65 f8             	lea    esp,[ebp-0x8]
     e28:	5b                   	pop    ebx
     e29:	5f                   	pop    edi
     e2a:	5d                   	pop    ebp
     e2b:	c3                   	ret

00000e2c <mm_pmue_get_range>:
/* assume caller know about locking and has made the right reservations
 * for us to operate freely on the range given by the limits. */
uint32_t mm_pmue_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bsir, uint64_t base)
{
     e2c:	55                   	push   ebp
     e2d:	89 e5                	mov    ebp,esp
     e2f:	53                   	push   ebx
     e30:	83 ec 44             	sub    esp,0x44
     e33:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
     e36:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     e39:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
     e3c:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		uint32_t* bitfield, rv = 0;
     e3f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		/* set the reference */
		switch (lvl) {
     e46:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     e4a:	77 72                	ja     ebe <mm_pmue_get_range+0x92>
     e4c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     e4f:	c1 e0 02             	shl    eax,0x2
     e52:	05 14 00 00 00       	add    eax,0x14
     e57:	8b 00                	mov    eax,DWORD PTR [eax]
     e59:	ff e0                	jmp    eax
				case 7:
						bitfield = &p->lvl7;
     e5b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e5e:	05 f8 03 00 00       	add    eax,0x3f8
     e63:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     e66:	eb 58                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 6:
						bitfield = p->lvl6;
     e68:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e6b:	05 f0 03 00 00       	add    eax,0x3f0
     e70:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     e73:	eb 4b                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 5:
						bitfield = p->lvl5;
     e75:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e78:	05 e0 03 00 00       	add    eax,0x3e0
     e7d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     e80:	eb 3e                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 4:
						bitfield = p->lvl4;
     e82:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e85:	05 c0 03 00 00       	add    eax,0x3c0
     e8a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     e8d:	eb 31                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 3:
						bitfield = p->lvl3;
     e8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e92:	05 80 03 00 00       	add    eax,0x380
     e97:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     e9a:	eb 24                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 2:
						bitfield = p->lvl2;
     e9c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e9f:	05 00 03 00 00       	add    eax,0x300
     ea4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     ea7:	eb 17                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 1:
						bitfield = p->lvl1;
     ea9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     eac:	05 00 02 00 00       	add    eax,0x200
     eb1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     eb4:	eb 0a                	jmp    ec0 <mm_pmue_get_range+0x94>
				case 0:
						bitfield = p->lvl0;
     eb6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     eb9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     ebc:	eb 02                	jmp    ec0 <mm_pmue_get_range+0x94>
				default:
						while (1);
     ebe:	eb fe                	jmp    ebe <mm_pmue_get_range+0x92>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     ec0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ec3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     ec6:	e9 d7 01 00 00       	jmp    10a2 <mm_pmue_get_range+0x276>
				/* test each bit */
				asm goto("bt %0, %1\n"
     ecb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ece:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     ed1:	0f a3 02             	bt     DWORD PTR [edx],eax
     ed4:	0f 82 b4 01 00 00    	jb     108e <mm_pmue_get_range+0x262>
						 "jc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : carry);

				/* we've got a free entry at i */
				if (lvl > 0) {
     eda:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     ede:	0f 84 b7 00 00 00    	je     f9b <mm_pmue_get_range+0x16f>
						uint32_t rv2, prr = *n_pr, bs = 0;
     ee4:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     ee7:	8b 00                	mov    eax,DWORD PTR [eax]
     ee9:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     eec:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
						/* go deeper */
						rv2 = mm_pmue_get_range(p, i * 2, i * 2 + 1,
     ef3:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ef6:	8d 58 ff             	lea    ebx,[eax-0x1]
     ef9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     efc:	01 c0                	add    eax,eax
     efe:	8d 48 01             	lea    ecx,[eax+0x1]
     f01:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f04:	8d 14 00             	lea    edx,[eax+eax*1]
     f07:	83 ec 04             	sub    esp,0x4
     f0a:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     f0d:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     f10:	8d 45 cc             	lea    eax,[ebp-0x34]
     f13:	50                   	push   eax
     f14:	ff 75 24             	push   DWORD PTR [ebp+0x24]
     f17:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     f1a:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
     f1d:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     f20:	53                   	push   ebx
     f21:	51                   	push   ecx
     f22:	52                   	push   edx
     f23:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     f26:	e8 fc ff ff ff       	call   f27 <mm_pmue_get_range+0xfb>
     f2b:	83 c4 30             	add    esp,0x30
     f2e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
								lvl - 1, pg_ct, pr, pr_ct, n_pr, &bs, base);
						/* set counts */
						rv += rv2;
     f31:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f34:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     f37:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f3a:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
						pr += *n_pr - prr;
     f3d:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     f40:	8b 00                	mov    eax,DWORD PTR [eax]
     f42:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     f45:	89 c2                	mov    edx,eax
     f47:	89 d0                	mov    eax,edx
     f49:	01 c0                	add    eax,eax
     f4b:	01 d0                	add    eax,edx
     f4d:	c1 e0 02             	shl    eax,0x2
     f50:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						pr_ct -= *n_pr - prr;
     f53:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     f56:	8b 00                	mov    eax,DWORD PTR [eax]
     f58:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     f5b:	29 c2                	sub    edx,eax
     f5d:	01 55 20             	add    DWORD PTR [ebp+0x20],edx
						/* update by checking bits set in range */
						if (bs == 2) {
     f60:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f63:	83 f8 02             	cmp    eax,0x2
     f66:	75 16                	jne    f7e <mm_pmue_get_range+0x152>
								asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     f68:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f6b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     f6e:	0f ab 02             	bts    DWORD PTR [edx],eax
								(*bsir)++;
     f71:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     f74:	8b 00                	mov    eax,DWORD PTR [eax]
     f76:	8d 50 01             	lea    edx,[eax+0x1]
     f79:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     f7c:	89 10                	mov    DWORD PTR [eax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct & !rv2))
     f7e:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     f82:	0f 84 26 01 00 00    	je     10ae <mm_pmue_get_range+0x282>
     f88:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     f8b:	0b 45 d0             	or     eax,DWORD PTR [ebp-0x30]
     f8e:	85 c0                	test   eax,eax
     f90:	0f 84 18 01 00 00    	je     10ae <mm_pmue_get_range+0x282>
						/* check for done */
						if (!pg_ct)
								break;

				}
				continue;
     f96:	e9 02 01 00 00       	jmp    109d <mm_pmue_get_range+0x271>
						uint64_t b = base + i * 4096, bp = 1;
     f9b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f9e:	c1 e0 0c             	shl    eax,0xc
     fa1:	89 c1                	mov    ecx,eax
     fa3:	bb 00 00 00 00       	mov    ebx,0x0
     fa8:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     fab:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     fae:	01 c8                	add    eax,ecx
     fb0:	11 da                	adc    edx,ebx
     fb2:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     fb5:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     fb8:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     fbf:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     fc6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     fc9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     fcc:	0f ab 02             	bts    DWORD PTR [edx],eax
						if (*n_pr)
     fcf:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     fd2:	8b 00                	mov    eax,DWORD PTR [eax]
     fd4:	85 c0                	test   eax,eax
     fd6:	74 26                	je     ffe <mm_pmue_get_range+0x1d2>
								bp = pr[-1].base + 4096 * pr[-1].count;
     fd8:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     fdb:	83 e8 0c             	sub    eax,0xc
     fde:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     fe1:	8b 00                	mov    eax,DWORD PTR [eax]
     fe3:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     fe6:	83 e9 0c             	sub    ecx,0xc
     fe9:	8b 49 08             	mov    ecx,DWORD PTR [ecx+0x8]
     fec:	c1 e1 0c             	shl    ecx,0xc
     fef:	bb 00 00 00 00       	mov    ebx,0x0
     ff4:	01 c8                	add    eax,ecx
     ff6:	11 da                	adc    edx,ebx
     ff8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     ffb:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						if (b == bp)
     ffe:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1001:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1004:	89 c1                	mov    ecx,eax
    1006:	89 c8                	mov    eax,ecx
    1008:	33 45 e0             	xor    eax,DWORD PTR [ebp-0x20]
    100b:	33 55 e4             	xor    edx,DWORD PTR [ebp-0x1c]
    100e:	09 d0                	or     eax,edx
    1010:	75 11                	jne    1023 <mm_pmue_get_range+0x1f7>
								pr[-1].count++;
    1012:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1015:	83 e8 0c             	sub    eax,0xc
    1018:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    101b:	83 c2 01             	add    edx,0x1
    101e:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    1021:	eb 4e                	jmp    1071 <mm_pmue_get_range+0x245>
								if (!pr_ct) { /* rollback */
    1023:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    1027:	75 1b                	jne    1044 <mm_pmue_get_range+0x218>
										asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
    1029:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    102c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    102f:	0f bb 02             	btc    DWORD PTR [edx],eax
										putstr("rb");
    1032:	83 ec 0c             	sub    esp,0xc
    1035:	68 10 00 00 00       	push   0x10
    103a:	e8 fc ff ff ff       	call   103b <mm_pmue_get_range+0x20f>
    103f:	83 c4 10             	add    esp,0x10
										break;
    1042:	eb 6a                	jmp    10ae <mm_pmue_get_range+0x282>
								pr->base = b;
    1044:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
    1047:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    104a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    104d:	89 01                	mov    DWORD PTR [ecx],eax
    104f:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr->count = 1;
    1052:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1055:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr_ct--;
    105c:	83 6d 20 01          	sub    DWORD PTR [ebp+0x20],0x1
								(*n_pr)++;
    1060:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    1063:	8b 00                	mov    eax,DWORD PTR [eax]
    1065:	8d 50 01             	lea    edx,[eax+0x1]
    1068:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    106b:	89 10                	mov    DWORD PTR [eax],edx
								pr++;
    106d:	83 45 1c 0c          	add    DWORD PTR [ebp+0x1c],0xc
						rv++;
    1071:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						pg_ct--;
    1075:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
						(*bsir)++;
    1079:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    107c:	8b 00                	mov    eax,DWORD PTR [eax]
    107e:	8d 50 01             	lea    edx,[eax+0x1]
    1081:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    1084:	89 10                	mov    DWORD PTR [eax],edx
						if (!pg_ct)
    1086:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    108a:	75 11                	jne    109d <mm_pmue_get_range+0x271>
								break;
    108c:	eb 20                	jmp    10ae <mm_pmue_get_range+0x282>

carry:
				(*bsir)++;
    108e:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    1091:	8b 00                	mov    eax,DWORD PTR [eax]
    1093:	8d 50 01             	lea    edx,[eax+0x1]
    1096:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    1099:	89 10                	mov    DWORD PTR [eax],edx
    109b:	eb 01                	jmp    109e <mm_pmue_get_range+0x272>
				continue;
    109d:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
    109e:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    10a2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10a5:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
    10a8:	0f 83 1d fe ff ff    	jae    ecb <mm_pmue_get_range+0x9f>
		}

		return rv;
    10ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    10b1:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    10b4:	c9                   	leave
    10b5:	c3                   	ret

000010b6 <mm_rcpe_get_range>:

uint32_t mm_rcpe_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bfir, uint64_t base)
{
    10b6:	55                   	push   ebp
    10b7:	89 e5                	mov    ebp,esp
    10b9:	53                   	push   ebx
    10ba:	83 ec 44             	sub    esp,0x44
    10bd:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
    10c0:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    10c3:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
    10c6:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		uint32_t* bitfield, rv = 0;
    10c9:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		/* set the reference */
		switch (lvl) {
    10d0:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
    10d4:	74 14                	je     10ea <mm_rcpe_get_range+0x34>
    10d6:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
    10da:	77 32                	ja     110e <mm_rcpe_get_range+0x58>
    10dc:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    10e0:	74 22                	je     1104 <mm_rcpe_get_range+0x4e>
    10e2:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
    10e6:	74 0f                	je     10f7 <mm_rcpe_get_range+0x41>
    10e8:	eb 24                	jmp    110e <mm_rcpe_get_range+0x58>
				case 7:
						bitfield = &p->lvl7;
    10ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10ed:	05 f8 03 00 00       	add    eax,0x3f8
    10f2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
    10f5:	eb 19                	jmp    1110 <mm_rcpe_get_range+0x5a>
				case 2:
						bitfield = p->lvl2;
    10f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10fa:	05 00 03 00 00       	add    eax,0x300
    10ff:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
    1102:	eb 0c                	jmp    1110 <mm_rcpe_get_range+0x5a>
				case 0:
						bitfield = p->lvl0;
    1104:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1107:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
    110a:	eb 04                	jmp    1110 <mm_rcpe_get_range+0x5a>
    110c:	eb 00                	jmp    110e <mm_rcpe_get_range+0x58>
				default:
						while (1);
    110e:	eb fc                	jmp    110c <mm_rcpe_get_range+0x56>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
    1110:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1113:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1116:	e9 18 02 00 00       	jmp    1333 <mm_rcpe_get_range+0x27d>
				/* test each bit */
				asm goto("bt %0, %1\n"
    111b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    111e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1121:	0f a3 02             	bt     DWORD PTR [edx],eax
    1124:	0f 83 f5 01 00 00    	jae    131f <mm_rcpe_get_range+0x269>
						 "jnc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : nocarry);

				/* we've got a reclaimable entry at i */
				if (lvl > 0) {
    112a:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    112e:	0f 84 e4 00 00 00    	je     1218 <mm_rcpe_get_range+0x162>
						uint32_t rv2, prr = *n_pr, bf = 0, mul;
    1134:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    1137:	8b 00                	mov    eax,DWORD PTR [eax]
    1139:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    113c:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
						mul = (lvl == 2) ? 4 : 32;
    1143:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
    1147:	75 07                	jne    1150 <mm_rcpe_get_range+0x9a>
    1149:	b8 04 00 00 00       	mov    eax,0x4
    114e:	eb 05                	jmp    1155 <mm_rcpe_get_range+0x9f>
    1150:	b8 20 00 00 00       	mov    eax,0x20
    1155:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
						/* go deeper */
						rv2 = mm_rcpe_get_range(p, i * mul, (i + 1) * mul - 1,
    1158:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
    115c:	75 07                	jne    1165 <mm_rcpe_get_range+0xaf>
    115e:	bb 00 00 00 00       	mov    ebx,0x0
    1163:	eb 05                	jmp    116a <mm_rcpe_get_range+0xb4>
    1165:	bb 02 00 00 00       	mov    ebx,0x2
    116a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    116d:	83 c0 01             	add    eax,0x1
    1170:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
    1174:	8d 48 ff             	lea    ecx,[eax-0x1]
    1177:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    117a:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
    117e:	83 ec 04             	sub    esp,0x4
    1181:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    1184:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    1187:	8d 55 c8             	lea    edx,[ebp-0x38]
    118a:	52                   	push   edx
    118b:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    118e:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    1191:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    1194:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1197:	53                   	push   ebx
    1198:	51                   	push   ecx
    1199:	50                   	push   eax
    119a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    119d:	e8 fc ff ff ff       	call   119e <mm_rcpe_get_range+0xe8>
    11a2:	83 c4 30             	add    esp,0x30
    11a5:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								(lvl == 2) ? 0 : 2, pg_ct, pr, pr_ct, n_pr, &bf, base);
						/* set counts */
						rv += rv2;
    11a8:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    11ab:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
    11ae:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    11b1:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
						pr += *n_pr - prr;
    11b4:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    11b7:	8b 00                	mov    eax,DWORD PTR [eax]
    11b9:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
    11bc:	89 c2                	mov    edx,eax
    11be:	89 d0                	mov    eax,edx
    11c0:	01 c0                	add    eax,eax
    11c2:	01 d0                	add    eax,edx
    11c4:	c1 e0 02             	shl    eax,0x2
    11c7:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						pr_ct -= *n_pr - prr;
    11ca:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    11cd:	8b 00                	mov    eax,DWORD PTR [eax]
    11cf:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    11d2:	29 c2                	sub    edx,eax
    11d4:	01 55 20             	add    DWORD PTR [ebp+0x20],edx
						/* update by checking bits free in range */
						if (bf == mul) {
    11d7:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    11da:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    11dd:	75 16                	jne    11f5 <mm_rcpe_get_range+0x13f>
								asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
    11df:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11e2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    11e5:	0f bb 02             	btc    DWORD PTR [edx],eax
								(*bfir)++;
    11e8:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    11eb:	8b 00                	mov    eax,DWORD PTR [eax]
    11ed:	8d 50 01             	lea    edx,[eax+0x1]
    11f0:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    11f3:	89 10                	mov    DWORD PTR [eax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct && !rv2))
    11f5:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    11f9:	0f 84 40 01 00 00    	je     133f <mm_rcpe_get_range+0x289>
    11ff:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    1203:	0f 85 25 01 00 00    	jne    132e <mm_rcpe_get_range+0x278>
    1209:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    120d:	0f 84 2c 01 00 00    	je     133f <mm_rcpe_get_range+0x289>
						bzero((void*)(size_t)b, 4096);
						/* check for done */
						if (!pg_ct)
								break;
				}
				continue;
    1213:	e9 16 01 00 00       	jmp    132e <mm_rcpe_get_range+0x278>
						uint64_t b = base + i * 4096, bp = 1;
    1218:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    121b:	c1 e0 0c             	shl    eax,0xc
    121e:	89 c1                	mov    ecx,eax
    1220:	bb 00 00 00 00       	mov    ebx,0x0
    1225:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1228:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    122b:	01 c8                	add    eax,ecx
    122d:	11 da                	adc    edx,ebx
    122f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1232:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1235:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    123c:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
    1243:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1246:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1249:	0f bb 02             	btc    DWORD PTR [edx],eax
						if (*n_pr)
    124c:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    124f:	8b 00                	mov    eax,DWORD PTR [eax]
    1251:	85 c0                	test   eax,eax
    1253:	74 26                	je     127b <mm_rcpe_get_range+0x1c5>
								bp = pr[-1].base + 4096 * pr[-1].count;
    1255:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1258:	83 e8 0c             	sub    eax,0xc
    125b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    125e:	8b 00                	mov    eax,DWORD PTR [eax]
    1260:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
    1263:	83 e9 0c             	sub    ecx,0xc
    1266:	8b 49 08             	mov    ecx,DWORD PTR [ecx+0x8]
    1269:	c1 e1 0c             	shl    ecx,0xc
    126c:	bb 00 00 00 00       	mov    ebx,0x0
    1271:	01 c8                	add    eax,ecx
    1273:	11 da                	adc    edx,ebx
    1275:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1278:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						if (b == bp)
    127b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    127e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1281:	89 c1                	mov    ecx,eax
    1283:	89 c8                	mov    eax,ecx
    1285:	33 45 e0             	xor    eax,DWORD PTR [ebp-0x20]
    1288:	33 55 e4             	xor    edx,DWORD PTR [ebp-0x1c]
    128b:	09 d0                	or     eax,edx
    128d:	75 11                	jne    12a0 <mm_rcpe_get_range+0x1ea>
								pr[-1].count++;
    128f:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1292:	83 e8 0c             	sub    eax,0xc
    1295:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1298:	83 c2 01             	add    edx,0x1
    129b:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    129e:	eb 4e                	jmp    12ee <mm_rcpe_get_range+0x238>
								if (!pr_ct) { /* rollback */
    12a0:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    12a4:	75 1b                	jne    12c1 <mm_rcpe_get_range+0x20b>
										asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
    12a6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    12a9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    12ac:	0f ab 02             	bts    DWORD PTR [edx],eax
										putstr("rb");
    12af:	83 ec 0c             	sub    esp,0xc
    12b2:	68 10 00 00 00       	push   0x10
    12b7:	e8 fc ff ff ff       	call   12b8 <mm_rcpe_get_range+0x202>
    12bc:	83 c4 10             	add    esp,0x10
										break;
    12bf:	eb 7e                	jmp    133f <mm_rcpe_get_range+0x289>
								pr->base = b;
    12c1:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
    12c4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12c7:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    12ca:	89 01                	mov    DWORD PTR [ecx],eax
    12cc:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr->count = 1;
    12cf:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    12d2:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr_ct--;
    12d9:	83 6d 20 01          	sub    DWORD PTR [ebp+0x20],0x1
								(*n_pr)++;
    12dd:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    12e0:	8b 00                	mov    eax,DWORD PTR [eax]
    12e2:	8d 50 01             	lea    edx,[eax+0x1]
    12e5:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    12e8:	89 10                	mov    DWORD PTR [eax],edx
								pr++;
    12ea:	83 45 1c 0c          	add    DWORD PTR [ebp+0x1c],0xc
						rv++;
    12ee:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						pg_ct--;
    12f2:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
						(*bfir)++;
    12f6:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    12f9:	8b 00                	mov    eax,DWORD PTR [eax]
    12fb:	8d 50 01             	lea    edx,[eax+0x1]
    12fe:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    1301:	89 10                	mov    DWORD PTR [eax],edx
						bzero((void*)(size_t)b, 4096);
    1303:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1306:	83 ec 08             	sub    esp,0x8
    1309:	68 00 10 00 00       	push   0x1000
    130e:	50                   	push   eax
    130f:	e8 fc ff ff ff       	call   1310 <mm_rcpe_get_range+0x25a>
    1314:	83 c4 10             	add    esp,0x10
						if (!pg_ct)
    1317:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    131b:	75 11                	jne    132e <mm_rcpe_get_range+0x278>
								break;
    131d:	eb 20                	jmp    133f <mm_rcpe_get_range+0x289>

nocarry:
				(*bfir)++;
    131f:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    1322:	8b 00                	mov    eax,DWORD PTR [eax]
    1324:	8d 50 01             	lea    edx,[eax+0x1]
    1327:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    132a:	89 10                	mov    DWORD PTR [eax],edx
    132c:	eb 01                	jmp    132f <mm_rcpe_get_range+0x279>
				continue;
    132e:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
    132f:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    1333:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1336:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
    1339:	0f 83 dc fd ff ff    	jae    111b <mm_rcpe_get_range+0x65>
		}

		return rv;
    133f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    1342:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1345:	c9                   	leave
    1346:	c3                   	ret

00001347 <mm_fmrc_get>:

/* is used to really set entries in a pmu/rcp */
uint32_t mm_fmrc_get(struct pmu* p, uint32_t idx, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr, uint64_t base)
{
    1347:	55                   	push   ebp
    1348:	89 e5                	mov    ebp,esp
    134a:	83 ec 48             	sub    esp,0x48
    134d:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    1350:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    1353:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    1356:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		size_t i; uint32_t msk = 0x00000003, rv = 0;
    1359:	c7 45 f0 03 00 00 00 	mov    DWORD PTR [ebp-0x10],0x3
    1360:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		struct pmue* e = &p->entries[idx];
    1367:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    136a:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
    1370:	8d 50 10             	lea    edx,[eax+0x10]
    1373:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1376:	01 d0                	add    eax,edx
    1378:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		/* lock is 2 lvl7 bits wide (256 pages) so use it sparingly */

		/* first skip all full/empty lvl7 ranges (2 at a time) */
		uint32_t prc = 0;
    137b:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		for (i = 0; i < 16; i++) {
    1382:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1389:	e9 5e 01 00 00       	jmp    14ec <mm_fmrc_get+0x1a5>
				uint8_t bt = ((e->lvl7 & msk) >> 2 * i);
    138e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1391:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
    1397:	23 45 f0             	and    eax,DWORD PTR [ebp-0x10]
    139a:	89 c2                	mov    edx,eax
    139c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    139f:	01 c0                	add    eax,eax
    13a1:	89 c1                	mov    ecx,eax
    13a3:	d3 ea                	shr    edx,cl
    13a5:	89 d0                	mov    eax,edx
    13a7:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
				if (free ? (bt != 3) : (bt)) { /* all set/unset */
    13aa:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    13ae:	74 09                	je     13b9 <mm_fmrc_get+0x72>
    13b0:	80 7d e3 03          	cmp    BYTE PTR [ebp-0x1d],0x3
    13b4:	0f 95 c0             	setne  al
    13b7:	eb 07                	jmp    13c0 <mm_fmrc_get+0x79>
    13b9:	80 7d e3 00          	cmp    BYTE PTR [ebp-0x1d],0x0
    13bd:	0f 95 c0             	setne  al
    13c0:	84 c0                	test   al,al
    13c2:	0f 84 1b 01 00 00    	je     14e3 <mm_fmrc_get+0x19c>
						uint32_t rv2 = 0, pcc = prc, bsir = 0;
    13c8:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    13cf:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13d2:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    13d5:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
						/* some bits set: try to lock */
						asm goto("lock bts %0, %1\n"
							"jc %l2\n" : : "r" (idx * 16 + 2 * i),
    13dc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    13df:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    13e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13e9:	01 d0                	add    eax,edx
    13eb:	8d 14 00             	lea    edx,[eax+eax*1]
						asm goto("lock bts %0, %1\n"
    13ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13f1:	f0 0f ab 10          	lock bts DWORD PTR [eax],edx
    13f5:	0f 82 e9 00 00 00    	jb     14e4 <mm_fmrc_get+0x19d>
							"m" (*p->locks) : "cc" : carry);

						/* we hold the lock (else jump to carry) */
						if (free)
    13fb:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    13ff:	74 3c                	je     143d <mm_fmrc_get+0xf6>
								rv2 = mm_pmue_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
    1401:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1404:	01 c0                	add    eax,eax
    1406:	8d 48 01             	lea    ecx,[eax+0x1]
    1409:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    140c:	8d 14 00             	lea    edx,[eax+eax*1]
    140f:	83 ec 04             	sub    esp,0x4
    1412:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    1415:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    1418:	8d 45 d4             	lea    eax,[ebp-0x2c]
    141b:	50                   	push   eax
    141c:	8d 45 d8             	lea    eax,[ebp-0x28]
    141f:	50                   	push   eax
    1420:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    1423:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1426:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1429:	6a 07                	push   0x7
    142b:	51                   	push   ecx
    142c:	52                   	push   edx
    142d:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1430:	e8 fc ff ff ff       	call   1431 <mm_fmrc_get+0xea>
    1435:	83 c4 30             	add    esp,0x30
    1438:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    143b:	eb 3a                	jmp    1477 <mm_fmrc_get+0x130>
										pr, pr_ct, &prc, &bsir, base);
						else
								rv2 = mm_rcpe_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
    143d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1440:	01 c0                	add    eax,eax
    1442:	8d 48 01             	lea    ecx,[eax+0x1]
    1445:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1448:	8d 14 00             	lea    edx,[eax+eax*1]
    144b:	83 ec 04             	sub    esp,0x4
    144e:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    1451:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    1454:	8d 45 d4             	lea    eax,[ebp-0x2c]
    1457:	50                   	push   eax
    1458:	8d 45 d8             	lea    eax,[ebp-0x28]
    145b:	50                   	push   eax
    145c:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    145f:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1462:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1465:	6a 07                	push   0x7
    1467:	51                   	push   ecx
    1468:	52                   	push   edx
    1469:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    146c:	e8 fc ff ff ff       	call   146d <mm_fmrc_get+0x126>
    1471:	83 c4 30             	add    esp,0x30
    1474:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										pr, pr_ct, &prc, &bsir, base);
						pr_ct -= prc - pcc;
    1477:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    147a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    147d:	29 c2                	sub    edx,eax
    147f:	01 55 1c             	add    DWORD PTR [ebp+0x1c],edx
						pr += prc - pcc;
    1482:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1485:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    1488:	89 c2                	mov    edx,eax
    148a:	89 d0                	mov    eax,edx
    148c:	01 c0                	add    eax,eax
    148e:	01 d0                	add    eax,edx
    1490:	c1 e0 02             	shl    eax,0x2
    1493:	01 45 18             	add    DWORD PTR [ebp+0x18],eax
						*n_pr += prc - pcc;
    1496:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    1499:	8b 10                	mov    edx,DWORD PTR [eax]
    149b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    149e:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    14a1:	01 c2                	add    edx,eax
    14a3:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    14a6:	89 10                	mov    DWORD PTR [eax],edx
						rv += rv2;
    14a8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14ab:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						pg_ct -= rv2;
    14ae:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14b1:	29 45 10             	sub    DWORD PTR [ebp+0x10],eax

						/* release lock */
						asm("btr %0, %1\n" : : "r" (idx * 16 + 2 * i),
    14b4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14b7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    14be:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    14c1:	01 d0                	add    eax,edx
    14c3:	8d 14 00             	lea    edx,[eax+eax*1]
    14c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14c9:	0f b3 10             	btr    DWORD PTR [eax],edx
							"m" (*p->locks) : "cc");

						if (!pg_ct || (!pr_ct && !rv2))
    14cc:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    14d0:	74 0c                	je     14de <mm_fmrc_get+0x197>
    14d2:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    14d6:	75 0c                	jne    14e4 <mm_fmrc_get+0x19d>
    14d8:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    14dc:	75 06                	jne    14e4 <mm_fmrc_get+0x19d>
								return rv;
    14de:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14e1:	eb 16                	jmp    14f9 <mm_fmrc_get+0x1b2>
				}
carry:
    14e3:	90                   	nop
				/* advance */
				msk <<= 2;
    14e4:	c1 65 f0 02          	shl    DWORD PTR [ebp-0x10],0x2
		for (i = 0; i < 16; i++) {
    14e8:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    14ec:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
    14f0:	0f 86 98 fe ff ff    	jbe    138e <mm_fmrc_get+0x47>
		}

		return rv;
    14f6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
    14f9:	c9                   	leave
    14fa:	c3                   	ret

000014fb <mm_fmrc_alloc_pm>:

/* used for getting pages which are marked as free/reclaimable */
uint32_t mm_fmrc_alloc_pm(struct fme* fm, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr)
{
    14fb:	55                   	push   ebp
    14fc:	89 e5                	mov    ebp,esp
    14fe:	53                   	push   ebx
    14ff:	83 ec 34             	sub    esp,0x34
		uint32_t rv = 0; uint64_t base = fm->base;
    1502:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1509:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    150c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    150f:	8b 00                	mov    eax,DWORD PTR [eax]
    1511:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1514:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		size_t i, j; uint64_t mem = (free ? fm->pmu : fm->rcp);
    1517:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    151b:	74 0b                	je     1528 <mm_fmrc_alloc_pm+0x2d>
    151d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1520:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1523:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1526:	eb 09                	jmp    1531 <mm_fmrc_alloc_pm+0x36>
    1528:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    152b:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    152e:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1531:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1534:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

		for (i = 0; i < fm->ec; i++) {
    1537:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    153e:	e9 37 01 00 00       	jmp    167a <mm_fmrc_alloc_pm+0x17f>
				struct pmu* p = (void*)(size_t)mem;
    1543:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1546:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* skip if above limit */
				if (mem + 4096 > 0x100000000)
    1549:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    154c:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    154f:	05 00 10 00 00       	add    eax,0x1000
    1554:	83 d2 00             	adc    edx,0x0
    1557:	bb 00 00 00 00       	mov    ebx,0x0
    155c:	b9 01 00 00 00       	mov    ecx,0x1
    1561:	39 c3                	cmp    ebx,eax
    1563:	19 d1                	sbb    ecx,edx
    1565:	0f 82 2c 01 00 00    	jb     1697 <mm_fmrc_alloc_pm+0x19c>
						break;

				/* operate on pmu/rcp */
				if (p->free_ct[0] == 0xffff) {
    156b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    156e:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    1572:	66 83 f8 ff          	cmp    ax,0xffff
    1576:	75 2d                	jne    15a5 <mm_fmrc_alloc_pm+0xaa>
						if (free) {
    1578:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    157c:	74 14                	je     1592 <mm_fmrc_alloc_pm+0x97>
								if (mm_init_pmu(p))
    157e:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1581:	e8 fc ff ff ff       	call   1582 <mm_fmrc_alloc_pm+0x87>
    1586:	83 c4 04             	add    esp,0x4
    1589:	85 c0                	test   eax,eax
    158b:	74 18                	je     15a5 <mm_fmrc_alloc_pm+0xaa>
										continue; /* if locked */
    158d:	e9 e4 00 00 00       	jmp    1676 <mm_fmrc_alloc_pm+0x17b>
						} else {
								if (mm_init_rcp(p))
    1592:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1595:	e8 fc ff ff ff       	call   1596 <mm_fmrc_alloc_pm+0x9b>
    159a:	83 c4 04             	add    esp,0x4
    159d:	85 c0                	test   eax,eax
    159f:	0f 85 d0 00 00 00    	jne    1675 <mm_fmrc_alloc_pm+0x17a>
										continue; /* if locked */
						}
				}

				/* check for free/reclaimable counts */
				for (j = 0; j < 4; j++) {
    15a5:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    15ac:	e9 b8 00 00 00       	jmp    1669 <mm_fmrc_alloc_pm+0x16e>
						if (p->free_ct[j] > 0) {
    15b1:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    15b4:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    15b7:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
    15bc:	66 85 c0             	test   ax,ax
    15bf:	0f 84 95 00 00 00    	je     165a <mm_fmrc_alloc_pm+0x15f>
								uint32_t rv2, np = 0;
    15c5:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
								/* operate on lock */
								rv2 = mm_fmrc_get(p, j, pg_ct, free, pr,
    15cc:	83 ec 0c             	sub    esp,0xc
    15cf:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    15d2:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    15d5:	8d 45 cc             	lea    eax,[ebp-0x34]
    15d8:	50                   	push   eax
    15d9:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    15dc:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    15df:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    15e2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    15e5:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    15e8:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    15eb:	e8 fc ff ff ff       	call   15ec <mm_fmrc_alloc_pm+0xf1>
    15f0:	83 c4 30             	add    esp,0x30
    15f3:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
												pr_ct, &np, base);

								*n_pr += np;
    15f6:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    15f9:	8b 10                	mov    edx,DWORD PTR [eax]
    15fb:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    15fe:	01 c2                	add    edx,eax
    1600:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1603:	89 10                	mov    DWORD PTR [eax],edx
								pr_ct -= np;
    1605:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1608:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
								pr += np;
    160b:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    160e:	89 d0                	mov    eax,edx
    1610:	01 c0                	add    eax,eax
    1612:	01 d0                	add    eax,edx
    1614:	c1 e0 02             	shl    eax,0x2
    1617:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
								rv += rv2;
    161a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    161d:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
								pg_ct -= rv2;
    1620:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1623:	29 45 0c             	sub    DWORD PTR [ebp+0xc],eax
								/* update count */
								p->free_ct[j] -= rv2;
    1626:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1629:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    162c:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
    1631:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1634:	29 d0                	sub    eax,edx
    1636:	89 c1                	mov    ecx,eax
    1638:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    163b:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    163e:	66 89 4c 50 08       	mov    WORD PTR [eax+edx*2+0x8],cx
								/* exit if done or list exhausted (and no extension) */
								if (!pg_ct || (!pr_ct && !rv2))
    1643:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1647:	74 0c                	je     1655 <mm_fmrc_alloc_pm+0x15a>
    1649:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    164d:	75 0b                	jne    165a <mm_fmrc_alloc_pm+0x15f>
    164f:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    1653:	75 05                	jne    165a <mm_fmrc_alloc_pm+0x15f>
										return rv;
    1655:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1658:	eb 41                	jmp    169b <mm_fmrc_alloc_pm+0x1a0>
						}

						/* advance base */
						base += 4096 * 4096;
    165a:	81 45 e8 00 00 00 01 	add    DWORD PTR [ebp-0x18],0x1000000
    1661:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0
				for (j = 0; j < 4; j++) {
    1665:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    1669:	83 7d e0 03          	cmp    DWORD PTR [ebp-0x20],0x3
    166d:	0f 86 3e ff ff ff    	jbe    15b1 <mm_fmrc_alloc_pm+0xb6>
    1673:	eb 01                	jmp    1676 <mm_fmrc_alloc_pm+0x17b>
										continue; /* if locked */
    1675:	90                   	nop
		for (i = 0; i < fm->ec; i++) {
    1676:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    167a:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    167d:	bb 00 00 00 00       	mov    ebx,0x0
    1682:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1685:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1688:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    168b:	39 c1                	cmp    ecx,eax
    168d:	19 d3                	sbb    ebx,edx
    168f:	0f 82 ae fe ff ff    	jb     1543 <mm_fmrc_alloc_pm+0x48>
    1695:	eb 01                	jmp    1698 <mm_fmrc_alloc_pm+0x19d>
						break;
    1697:	90                   	nop
				}
		}

		return rv;
    1698:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    169b:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    169e:	c9                   	leave
    169f:	c3                   	ret

000016a0 <mm_alloc_pm>:

uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct)
{
    16a0:	55                   	push   ebp
    16a1:	89 e5                	mov    ebp,esp
    16a3:	56                   	push   esi
    16a4:	53                   	push   ebx
    16a5:	83 ec 30             	sub    esp,0x30
		size_t i; uint32_t rv = 0, r2 = 0, pr_o = 0;
    16a8:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    16af:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    16b6:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0

retry:
		for (i = fm_begin; i < fm_ofs; i++) {
    16bd:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    16c2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    16c5:	e9 c1 01 00 00       	jmp    188b <mm_alloc_pm+0x1eb>
				/* skip if scrubbing is needed */
				if (!r2 && !fmm[i].free_pages)
    16ca:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    16ce:	75 1f                	jne    16ef <mm_alloc_pm+0x4f>
    16d0:	ba 00 40 02 00       	mov    edx,0x24000
    16d5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16d8:	6b c0 38             	imul   eax,eax,0x38
    16db:	01 d0                	add    eax,edx
    16dd:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    16e0:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    16e3:	89 c1                	mov    ecx,eax
    16e5:	89 c8                	mov    eax,ecx
    16e7:	09 d0                	or     eax,edx
    16e9:	0f 84 94 01 00 00    	je     1883 <mm_alloc_pm+0x1e3>
						continue;

				/* collect free pages */
				if (fmm[i].free_pages) {
    16ef:	ba 00 40 02 00       	mov    edx,0x24000
    16f4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16f7:	6b c0 38             	imul   eax,eax,0x38
    16fa:	01 d0                	add    eax,edx
    16fc:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    16ff:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1702:	89 c1                	mov    ecx,eax
    1704:	89 c8                	mov    eax,ecx
    1706:	09 d0                	or     eax,edx
    1708:	0f 84 af 00 00 00    	je     17bd <mm_alloc_pm+0x11d>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 1, pr + pr_o,
    170e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1711:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    1714:	89 d3                	mov    ebx,edx
    1716:	29 c3                	sub    ebx,eax
    1718:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    171b:	89 d0                	mov    eax,edx
    171d:	01 c0                	add    eax,eax
    171f:	01 d0                	add    eax,edx
    1721:	c1 e0 02             	shl    eax,0x2
    1724:	89 c2                	mov    edx,eax
    1726:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1729:	8d 0c 02             	lea    ecx,[edx+eax*1]
    172c:	ba 00 40 02 00       	mov    edx,0x24000
    1731:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1734:	6b c0 38             	imul   eax,eax,0x38
    1737:	01 c2                	add    edx,eax
    1739:	83 ec 08             	sub    esp,0x8
    173c:	8d 45 e0             	lea    eax,[ebp-0x20]
    173f:	50                   	push   eax
    1740:	53                   	push   ebx
    1741:	51                   	push   ecx
    1742:	6a 01                	push   0x1
    1744:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1747:	52                   	push   edx
    1748:	e8 fc ff ff ff       	call   1749 <mm_alloc_pm+0xa9>
    174d:	83 c4 20             	add    esp,0x20
    1750:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
    1753:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1756:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
    1759:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    175c:	29 45 08             	sub    DWORD PTR [ebp+0x8],eax
						__sync_sub_and_fetch(&fmm[i].free_pages, rv2);
    175f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1762:	ba 00 00 00 00       	mov    edx,0x0
    1767:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    176a:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    176d:	ba 00 40 02 00       	mov    edx,0x24000
    1772:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1775:	6b c0 38             	imul   eax,eax,0x38
    1778:	01 d0                	add    eax,edx
    177a:	8d 70 10             	lea    esi,[eax+0x10]
    177d:	8b 06                	mov    eax,DWORD PTR [esi]
    177f:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    1782:	89 c1                	mov    ecx,eax
    1784:	89 d3                	mov    ebx,edx
    1786:	2b 4d c8             	sub    ecx,DWORD PTR [ebp-0x38]
    1789:	1b 5d cc             	sbb    ebx,DWORD PTR [ebp-0x34]
    178c:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
    178f:	89 5d d4             	mov    DWORD PTR [ebp-0x2c],ebx
    1792:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
    1795:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1798:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    179c:	0f 94 c1             	sete   cl
    179f:	84 c9                	test   cl,cl
    17a1:	74 df                	je     1782 <mm_alloc_pm+0xe2>
						if (pg_ct && !r2) /* skip scrub for now */
    17a3:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    17a7:	74 0a                	je     17b3 <mm_alloc_pm+0x113>
    17a9:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    17ad:	0f 84 d3 00 00 00    	je     1886 <mm_alloc_pm+0x1e6>
								continue;
						else if (!pg_ct)
    17b3:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    17b7:	0f 84 f4 00 00 00    	je     18b1 <mm_alloc_pm+0x211>
								goto done;
				}

				/* check for reclaimable */
				if (r2 && fmm[i].reclaimable_pages) {
    17bd:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    17c1:	0f 84 c0 00 00 00    	je     1887 <mm_alloc_pm+0x1e7>
    17c7:	ba 00 40 02 00       	mov    edx,0x24000
    17cc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    17cf:	6b c0 38             	imul   eax,eax,0x38
    17d2:	01 d0                	add    eax,edx
    17d4:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    17d7:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    17da:	89 c1                	mov    ecx,eax
    17dc:	89 c8                	mov    eax,ecx
    17de:	09 d0                	or     eax,edx
    17e0:	0f 84 a1 00 00 00    	je     1887 <mm_alloc_pm+0x1e7>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 0, pr + pr_o,
    17e6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    17e9:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    17ec:	89 d3                	mov    ebx,edx
    17ee:	29 c3                	sub    ebx,eax
    17f0:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    17f3:	89 d0                	mov    eax,edx
    17f5:	01 c0                	add    eax,eax
    17f7:	01 d0                	add    eax,edx
    17f9:	c1 e0 02             	shl    eax,0x2
    17fc:	89 c2                	mov    edx,eax
    17fe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1801:	8d 0c 02             	lea    ecx,[edx+eax*1]
    1804:	ba 00 40 02 00       	mov    edx,0x24000
    1809:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    180c:	6b c0 38             	imul   eax,eax,0x38
    180f:	01 c2                	add    edx,eax
    1811:	83 ec 08             	sub    esp,0x8
    1814:	8d 45 e0             	lea    eax,[ebp-0x20]
    1817:	50                   	push   eax
    1818:	53                   	push   ebx
    1819:	51                   	push   ecx
    181a:	6a 00                	push   0x0
    181c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    181f:	52                   	push   edx
    1820:	e8 fc ff ff ff       	call   1821 <mm_alloc_pm+0x181>
    1825:	83 c4 20             	add    esp,0x20
    1828:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
    182b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    182e:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
    1831:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1834:	29 45 08             	sub    DWORD PTR [ebp+0x8],eax
						__sync_sub_and_fetch(&fmm[i].reclaimable_pages, rv2);
    1837:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    183a:	ba 00 00 00 00       	mov    edx,0x0
    183f:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1842:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    1845:	ba 00 40 02 00       	mov    edx,0x24000
    184a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    184d:	6b c0 38             	imul   eax,eax,0x38
    1850:	01 d0                	add    eax,edx
    1852:	8d 70 18             	lea    esi,[eax+0x18]
    1855:	8b 06                	mov    eax,DWORD PTR [esi]
    1857:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    185a:	89 c1                	mov    ecx,eax
    185c:	89 d3                	mov    ebx,edx
    185e:	2b 4d c8             	sub    ecx,DWORD PTR [ebp-0x38]
    1861:	1b 5d cc             	sbb    ebx,DWORD PTR [ebp-0x34]
    1864:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
    1867:	89 5d d4             	mov    DWORD PTR [ebp-0x2c],ebx
    186a:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
    186d:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1870:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1874:	0f 94 c1             	sete   cl
    1877:	84 c9                	test   cl,cl
    1879:	74 df                	je     185a <mm_alloc_pm+0x1ba>
						if (!pg_ct)
    187b:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    187f:	74 33                	je     18b4 <mm_alloc_pm+0x214>
    1881:	eb 04                	jmp    1887 <mm_alloc_pm+0x1e7>
						continue;
    1883:	90                   	nop
    1884:	eb 01                	jmp    1887 <mm_alloc_pm+0x1e7>
								continue;
    1886:	90                   	nop
		for (i = fm_begin; i < fm_ofs; i++) {
    1887:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    188b:	a1 18 00 00 00       	mov    eax,ds:0x18
    1890:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1893:	0f 82 31 fe ff ff    	jb     16ca <mm_alloc_pm+0x2a>
								goto done;
				}
		}

		/* scrub enabled */
		if (pg_ct && !r2) {
    1899:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    189d:	74 18                	je     18b7 <mm_alloc_pm+0x217>
    189f:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    18a3:	75 12                	jne    18b7 <mm_alloc_pm+0x217>
				r2 = 1;
    18a5:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
				goto retry;
    18ac:	e9 0c fe ff ff       	jmp    16bd <mm_alloc_pm+0x1d>
								goto done;
    18b1:	90                   	nop
    18b2:	eb 04                	jmp    18b8 <mm_alloc_pm+0x218>
								goto done;
    18b4:	90                   	nop
    18b5:	eb 01                	jmp    18b8 <mm_alloc_pm+0x218>
		}

done:
    18b7:	90                   	nop
		if (!rv) { /* OOM */
    18b8:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    18bc:	75 13                	jne    18d1 <mm_alloc_pm+0x231>
				putstr("OOM");
    18be:	83 ec 0c             	sub    esp,0xc
    18c1:	68 34 00 00 00       	push   0x34
    18c6:	e8 fc ff ff ff       	call   18c7 <mm_alloc_pm+0x227>
    18cb:	83 c4 10             	add    esp,0x10
				while (1);
    18ce:	90                   	nop
    18cf:	eb fd                	jmp    18ce <mm_alloc_pm+0x22e>
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
    18d1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    18d4:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
    18d7:	73 3c                	jae    1915 <mm_alloc_pm+0x275>
				pr[pr_o].base = 0;
    18d9:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    18dc:	89 d0                	mov    eax,edx
    18de:	01 c0                	add    eax,eax
    18e0:	01 d0                	add    eax,edx
    18e2:	c1 e0 02             	shl    eax,0x2
    18e5:	89 c2                	mov    edx,eax
    18e7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18ea:	01 d0                	add    eax,edx
    18ec:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    18f2:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
				pr[pr_o].count = 0;
    18f9:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    18fc:	89 d0                	mov    eax,edx
    18fe:	01 c0                	add    eax,eax
    1900:	01 d0                	add    eax,edx
    1902:	c1 e0 02             	shl    eax,0x2
    1905:	89 c2                	mov    edx,eax
    1907:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    190a:	01 d0                	add    eax,edx
    190c:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
    1913:	eb 4a                	jmp    195f <mm_alloc_pm+0x2bf>
		} else if (pr_o > 1) { /* when list */
    1915:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1918:	83 f8 01             	cmp    eax,0x1
    191b:	76 42                	jbe    195f <mm_alloc_pm+0x2bf>
			put32(pr_o); putstr(" < "); put32(pr_ct); put_nl();
    191d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1920:	83 ec 0c             	sub    esp,0xc
    1923:	50                   	push   eax
    1924:	e8 fc ff ff ff       	call   1925 <mm_alloc_pm+0x285>
    1929:	83 c4 10             	add    esp,0x10
    192c:	83 ec 0c             	sub    esp,0xc
    192f:	68 38 00 00 00       	push   0x38
    1934:	e8 fc ff ff ff       	call   1935 <mm_alloc_pm+0x295>
    1939:	83 c4 10             	add    esp,0x10
    193c:	83 ec 0c             	sub    esp,0xc
    193f:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1942:	e8 fc ff ff ff       	call   1943 <mm_alloc_pm+0x2a3>
    1947:	83 c4 10             	add    esp,0x10
    194a:	e8 fc ff ff ff       	call   194b <mm_alloc_pm+0x2ab>
			puts("pr not null-terminated");
    194f:	83 ec 0c             	sub    esp,0xc
    1952:	68 3c 00 00 00       	push   0x3c
    1957:	e8 fc ff ff ff       	call   1958 <mm_alloc_pm+0x2b8>
    195c:	83 c4 10             	add    esp,0x10
		}
		return rv;
    195f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    1962:	8d 65 f8             	lea    esp,[ebp-0x8]
    1965:	5b                   	pop    ebx
    1966:	5e                   	pop    esi
    1967:	5d                   	pop    ebp
    1968:	c3                   	ret

00001969 <mm_alloc_pm_cont>:

uint32_t mm_alloc_pm_cont(uint32_t pg_ct, struct page_range* pr)
{
    1969:	55                   	push   ebp
    196a:	89 e5                	mov    ebp,esp
		return 0;
    196c:	b8 00 00 00 00       	mov    eax,0x0
}
    1971:	5d                   	pop    ebp
    1972:	c3                   	ret

00001973 <mm_fm_init>:
/******************************************************************************/


/* minimal init, i.e. just mark as invalid */
void mm_fm_init(struct fme* fm, uint32_t ec, uint16_t rec)
{
    1973:	55                   	push   ebp
    1974:	89 e5                	mov    ebp,esp
    1976:	53                   	push   ebx
    1977:	83 ec 1c             	sub    esp,0x1c
    197a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    197d:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		uint64_t b = fm->base - 2 * ec * 4096;
    1981:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1984:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1987:	8b 00                	mov    eax,DWORD PTR [eax]
    1989:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    198c:	c1 e1 0d             	shl    ecx,0xd
    198f:	bb 00 00 00 00       	mov    ebx,0x0
    1994:	29 c8                	sub    eax,ecx
    1996:	19 da                	sbb    edx,ebx
    1998:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    199b:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		uint32_t ec2 = ec;
    199e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19a1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* init the pmu */
redo:
		do {
				struct pmu* p = (void*)(size_t)b;
    19a4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19a7:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (b > 0x100000000 - 4096) /* the rest will be done in the */
    19aa:	ba 00 f0 ff ff       	mov    edx,0xfffff000
    19af:	b8 00 00 00 00       	mov    eax,0x0
    19b4:	3b 55 f0             	cmp    edx,DWORD PTR [ebp-0x10]
    19b7:	1b 45 f4             	sbb    eax,DWORD PTR [ebp-0xc]
    19ba:	72 71                	jb     1a2d <mm_fm_init+0xba>
						return; /* 64-bit/PAE code loaded later */
				else
						b += 4096;
    19bc:	81 45 f0 00 10 00 00 	add    DWORD PTR [ebp-0x10],0x1000
    19c3:	83 55 f4 00          	adc    DWORD PTR [ebp-0xc],0x0

				/* clear the locks */
				bzero(p->locks, sizeof(p->locks));
    19c7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    19ca:	6a 08                	push   0x8
    19cc:	50                   	push   eax
    19cd:	e8 fc ff ff ff       	call   19ce <mm_fm_init+0x5b>
    19d2:	83 c4 08             	add    esp,0x8
				/* invalidate the counts and put rec in the last one */
				p->free_ct[0] = 0xffff;
    19d5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    19d8:	66 c7 40 08 ff ff    	mov    WORD PTR [eax+0x8],0xffff
				p->free_ct[1] = 0xffff;
    19de:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    19e1:	66 c7 40 0a ff ff    	mov    WORD PTR [eax+0xa],0xffff
				p->free_ct[2] = 0xffff;
    19e7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    19ea:	66 c7 40 0c ff ff    	mov    WORD PTR [eax+0xc],0xffff
				p->free_ct[3] = (ec == 1) ? rec : 0xffff;
    19f0:	83 7d 0c 01          	cmp    DWORD PTR [ebp+0xc],0x1
    19f4:	75 06                	jne    19fc <mm_fm_init+0x89>
    19f6:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    19fa:	eb 05                	jmp    1a01 <mm_fm_init+0x8e>
    19fc:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1a01:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    1a04:	66 89 42 0e          	mov    WORD PTR [edx+0xe],ax
		} while (ec--);
    1a08:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a0b:	8d 50 ff             	lea    edx,[eax-0x1]
    1a0e:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
    1a11:	85 c0                	test   eax,eax
    1a13:	75 8f                	jne    19a4 <mm_fm_init+0x31>
		/* also for rcp */
		if (ec2) {
    1a15:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1a19:	74 13                	je     1a2e <mm_fm_init+0xbb>
				ec = ec2;
    1a1b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a1e:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
				ec2 = 0;
    1a21:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				goto redo;
    1a28:	e9 77 ff ff ff       	jmp    19a4 <mm_fm_init+0x31>
						return; /* 64-bit/PAE code loaded later */
    1a2d:	90                   	nop
		}

}
    1a2e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1a31:	c9                   	leave
    1a32:	c3                   	ret

00001a33 <mm_pg64_init>:
				uint32_t idx; /* max 512*512*512 */
		} extra_pts[64];
};

void mm_pg64_init()
{
    1a33:	55                   	push   ebp
    1a34:	89 e5                	mov    ebp,esp
    1a36:	56                   	push   esi
    1a37:	53                   	push   ebx
    1a38:	83 ec 60             	sub    esp,0x60
		struct page_range pr;
		struct vm_pg_ptrs64* vp = vm_mapping;
    1a3b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a40:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		struct pm_pg64_ptrs* pp = (void*)(vp + 1);
    1a43:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a46:	05 28 20 00 00       	add    eax,0x2028
    1a4b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		struct pte64 *p, *p1, *p2, *pl1, *pl2, *pt1, *pt2;
		struct vm_pdpte_ptr *m1, *m2;
		struct vm_pde_ptr *n1, *n2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
    1a4e:	68 28 20 00 00       	push   0x2028
    1a53:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1a56:	e8 fc ff ff ff       	call   1a57 <mm_pg64_init+0x24>
    1a5b:	83 c4 08             	add    esp,0x8
		vp->cur = 0xfffffffffffff000;
    1a5e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a61:	c7 00 00 f0 ff ff    	mov    DWORD PTR [eax],0xfffff000
    1a67:	c7 40 04 ff ff ff ff 	mov    DWORD PTR [eax+0x4],0xffffffff
		bzero(pp, sizeof(*pp));
    1a6e:	68 b4 03 00 00       	push   0x3b4
    1a73:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1a76:	e8 fc ff ff ff       	call   1a77 <mm_pg64_init+0x44>
    1a7b:	83 c4 08             	add    esp,0x8

		/* first get PML4 table (scrubbed i.e. all np) */
		mm_alloc_pm(1, &pr, 1);
    1a7e:	83 ec 04             	sub    esp,0x4
    1a81:	6a 01                	push   0x1
    1a83:	8d 45 a0             	lea    eax,[ebp-0x60]
    1a86:	50                   	push   eax
    1a87:	6a 01                	push   0x1
    1a89:	e8 fc ff ff ff       	call   1a8a <mm_pg64_init+0x57>
    1a8e:	83 c4 10             	add    esp,0x10
		cr3_val = pr.base;
    1a91:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1a94:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1a97:	a3 00 00 00 00       	mov    ds:0x0,eax
    1a9c:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		vp->pml4 = vp->cur; // f -> 10
    1aa2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1aa5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1aa8:	8b 00                	mov    eax,DWORD PTR [eax]
    1aaa:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1aad:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    1ab0:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
		vp->cur -= 4096;
    1ab3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ab6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1ab9:	8b 00                	mov    eax,DWORD PTR [eax]
    1abb:	05 00 f0 ff ff       	add    eax,0xfffff000
    1ac0:	83 d2 ff             	adc    edx,0xffffffff
    1ac3:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1ac6:	89 01                	mov    DWORD PTR [ecx],eax
    1ac8:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		p = (void*)(size_t)pr.base;
    1acb:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1ace:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1ad1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* and create two entries (base+high):
		 * --> first the lower */
		mm_alloc_pm(1, &pr, 1);
    1ad4:	83 ec 04             	sub    esp,0x4
    1ad7:	6a 01                	push   0x1
    1ad9:	8d 45 a0             	lea    eax,[ebp-0x60]
    1adc:	50                   	push   eax
    1add:	6a 01                	push   0x1
    1adf:	e8 fc ff ff ff       	call   1ae0 <mm_pg64_init+0xad>
    1ae4:	83 c4 10             	add    esp,0x10
		p1 = (void*)(size_t)pr.base;
    1ae7:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1aea:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1aed:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		vp->pml4e[0] = vp->cur; // e -> 11
    1af0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1af3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1af6:	8b 00                	mov    eax,DWORD PTR [eax]
    1af8:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1afb:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
    1afe:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
		vp->cur -= 4096;
    1b01:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b04:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1b07:	8b 00                	mov    eax,DWORD PTR [eax]
    1b09:	05 00 f0 ff ff       	add    eax,0xfffff000
    1b0e:	83 d2 ff             	adc    edx,0xffffffff
    1b11:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1b14:	89 01                	mov    DWORD PTR [ecx],eax
    1b16:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		/* and the upper end */
		mm_alloc_pm(1, &pr, 1);
    1b19:	83 ec 04             	sub    esp,0x4
    1b1c:	6a 01                	push   0x1
    1b1e:	8d 45 a0             	lea    eax,[ebp-0x60]
    1b21:	50                   	push   eax
    1b22:	6a 01                	push   0x1
    1b24:	e8 fc ff ff ff       	call   1b25 <mm_pg64_init+0xf2>
    1b29:	83 c4 10             	add    esp,0x10
		p2 = (void*)(size_t)pr.base;
    1b2c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1b2f:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1b32:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		vp->pml4e[511] = vp->cur; // d -> 12
    1b35:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b38:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1b3b:	8b 00                	mov    eax,DWORD PTR [eax]
    1b3d:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1b40:	89 81 08 10 00 00    	mov    DWORD PTR [ecx+0x1008],eax
    1b46:	89 91 0c 10 00 00    	mov    DWORD PTR [ecx+0x100c],edx
		vp->cur -= 4096;
    1b4c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b4f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1b52:	8b 00                	mov    eax,DWORD PTR [eax]
    1b54:	05 00 f0 ff ff       	add    eax,0xfffff000
    1b59:	83 d2 ff             	adc    edx,0xffffffff
    1b5c:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1b5f:	89 01                	mov    DWORD PTR [ecx],eax
    1b61:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		/* p1 and p2 are PDPTs (pointed by PML4E) */

		/* register them in the PML4 (512G per entry) */
		p[0].p = 1;
    1b64:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1b67:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1b6a:	83 ca 01             	or     edx,0x1
    1b6d:	88 10                	mov    BYTE PTR [eax],dl
		p[0].w = 1; /* non-restrictive */
    1b6f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1b72:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1b75:	83 ca 02             	or     edx,0x2
    1b78:	88 10                	mov    BYTE PTR [eax],dl
		p[0].u = 1; /* likewise */
    1b7a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1b7d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1b80:	83 ca 04             	or     edx,0x4
    1b83:	88 10                	mov    BYTE PTR [eax],dl
		p[0].addr = (size_t)p1 / 4096;
    1b85:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1b88:	c1 e8 0c             	shr    eax,0xc
    1b8b:	ba 00 00 00 00       	mov    edx,0x0
    1b90:	81 e2 ff 00 00 00    	and    edx,0xff
    1b96:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    1b99:	89 c3                	mov    ebx,eax
    1b9b:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1ba1:	89 de                	mov    esi,ebx
    1ba3:	c1 e6 0c             	shl    esi,0xc
    1ba6:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1ba8:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1bae:	09 f3                	or     ebx,esi
    1bb0:	89 19                	mov    DWORD PTR [ecx],ebx
    1bb2:	89 c3                	mov    ebx,eax
    1bb4:	c1 eb 14             	shr    ebx,0x14
    1bb7:	89 de                	mov    esi,ebx
    1bb9:	66 81 e6 ff 0f       	and    si,0xfff
    1bbe:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1bc2:	66 81 e3 00 f0       	and    bx,0xf000
    1bc7:	09 f3                	or     ebx,esi
    1bc9:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1bcd:	0f b6 c2             	movzx  eax,dl
    1bd0:	c1 e0 0c             	shl    eax,0xc
    1bd3:	89 c2                	mov    edx,eax
    1bd5:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1bd8:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1bdd:	09 d0                	or     eax,edx
    1bdf:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		p[511].p = 1;
    1be2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1be5:	05 f8 0f 00 00       	add    eax,0xff8
    1bea:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1bed:	83 ca 01             	or     edx,0x1
    1bf0:	88 10                	mov    BYTE PTR [eax],dl
		p[511].w = 1;
    1bf2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1bf5:	05 f8 0f 00 00       	add    eax,0xff8
    1bfa:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1bfd:	83 ca 02             	or     edx,0x2
    1c00:	88 10                	mov    BYTE PTR [eax],dl
		p[511].u = 1;
    1c02:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c05:	05 f8 0f 00 00       	add    eax,0xff8
    1c0a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1c0d:	83 ca 04             	or     edx,0x4
    1c10:	88 10                	mov    BYTE PTR [eax],dl
		p[511].addr = (size_t)p2 / 4096;
    1c12:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c15:	c1 e8 0c             	shr    eax,0xc
    1c18:	89 c2                	mov    edx,eax
    1c1a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c1d:	8d 88 f8 0f 00 00    	lea    ecx,[eax+0xff8]
    1c23:	89 d0                	mov    eax,edx
    1c25:	ba 00 00 00 00       	mov    edx,0x0
    1c2a:	81 e2 ff 00 00 00    	and    edx,0xff
    1c30:	89 c3                	mov    ebx,eax
    1c32:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1c38:	89 de                	mov    esi,ebx
    1c3a:	c1 e6 0c             	shl    esi,0xc
    1c3d:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1c3f:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1c45:	09 f3                	or     ebx,esi
    1c47:	89 19                	mov    DWORD PTR [ecx],ebx
    1c49:	89 c3                	mov    ebx,eax
    1c4b:	c1 eb 14             	shr    ebx,0x14
    1c4e:	89 de                	mov    esi,ebx
    1c50:	66 81 e6 ff 0f       	and    si,0xfff
    1c55:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1c59:	66 81 e3 00 f0       	and    bx,0xf000
    1c5e:	09 f3                	or     ebx,esi
    1c60:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1c64:	0f b6 c2             	movzx  eax,dl
    1c67:	c1 e0 0c             	shl    eax,0xc
    1c6a:	89 c2                	mov    edx,eax
    1c6c:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1c6f:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1c74:	09 d0                	or     eax,edx
    1c76:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax

		/* create the VM mapping of the PDPTEs */
		uint32_t ct = mm_alloc_pm(2, &pr, 1); /* TODO check cont */
    1c79:	83 ec 04             	sub    esp,0x4
    1c7c:	6a 01                	push   0x1
    1c7e:	8d 45 a0             	lea    eax,[ebp-0x60]
    1c81:	50                   	push   eax
    1c82:	6a 02                	push   0x2
    1c84:	e8 fc ff ff ff       	call   1c85 <mm_pg64_init+0x252>
    1c89:	83 c4 10             	add    esp,0x10
    1c8c:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		if (ct != 2) {
    1c8f:	83 7d dc 02          	cmp    DWORD PTR [ebp-0x24],0x2
    1c93:	74 17                	je     1cac <mm_pg64_init+0x279>
la_meme:
    1c95:	90                   	nop
    1c96:	eb 01                	jmp    1c99 <mm_pg64_init+0x266>
		vp->cur -= 8192;
		m1 = (void*)(size_t)pr.base;
		ct = mm_alloc_pm(2, &pr, 1);

		if (ct != 2)
				goto la_meme;
    1c98:	90                   	nop
				puts("unable to alloc two consecutive pages\n");
    1c99:	83 ec 0c             	sub    esp,0xc
    1c9c:	68 54 00 00 00       	push   0x54
    1ca1:	e8 fc ff ff ff       	call   1ca2 <mm_pg64_init+0x26f>
    1ca6:	83 c4 10             	add    esp,0x10
				while (1);
    1ca9:	90                   	nop
    1caa:	eb fd                	jmp    1ca9 <mm_pg64_init+0x276>
		vp->pdpte[0] = vp->cur - 4096; // bc -> 13/14
    1cac:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1caf:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1cb2:	8b 00                	mov    eax,DWORD PTR [eax]
    1cb4:	05 00 f0 ff ff       	add    eax,0xfffff000
    1cb9:	83 d2 ff             	adc    edx,0xffffffff
    1cbc:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1cbf:	89 81 10 10 00 00    	mov    DWORD PTR [ecx+0x1010],eax
    1cc5:	89 91 14 10 00 00    	mov    DWORD PTR [ecx+0x1014],edx
		vp->cur -= 8192;
    1ccb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cce:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1cd1:	8b 00                	mov    eax,DWORD PTR [eax]
    1cd3:	05 00 e0 ff ff       	add    eax,0xffffe000
    1cd8:	83 d2 ff             	adc    edx,0xffffffff
    1cdb:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1cde:	89 01                	mov    DWORD PTR [ecx],eax
    1ce0:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		m1 = (void*)(size_t)pr.base;
    1ce3:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1ce6:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1ce9:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		ct = mm_alloc_pm(2, &pr, 1);
    1cec:	83 ec 04             	sub    esp,0x4
    1cef:	6a 01                	push   0x1
    1cf1:	8d 45 a0             	lea    eax,[ebp-0x60]
    1cf4:	50                   	push   eax
    1cf5:	6a 02                	push   0x2
    1cf7:	e8 fc ff ff ff       	call   1cf8 <mm_pg64_init+0x2c5>
    1cfc:	83 c4 10             	add    esp,0x10
    1cff:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (ct != 2)
    1d02:	83 7d dc 02          	cmp    DWORD PTR [ebp-0x24],0x2
    1d06:	75 90                	jne    1c98 <mm_pg64_init+0x265>

		vp->pdpte[511] = vp->cur - 4096; // 9a 15/16
    1d08:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d0b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1d0e:	8b 00                	mov    eax,DWORD PTR [eax]
    1d10:	05 00 f0 ff ff       	add    eax,0xfffff000
    1d15:	83 d2 ff             	adc    edx,0xffffffff
    1d18:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1d1b:	89 81 08 20 00 00    	mov    DWORD PTR [ecx+0x2008],eax
    1d21:	89 91 0c 20 00 00    	mov    DWORD PTR [ecx+0x200c],edx
		vp->cur -= 8192;
    1d27:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d2a:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1d2d:	8b 00                	mov    eax,DWORD PTR [eax]
    1d2f:	05 00 e0 ff ff       	add    eax,0xffffe000
    1d34:	83 d2 ff             	adc    edx,0xffffffff
    1d37:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1d3a:	89 01                	mov    DWORD PTR [ecx],eax
    1d3c:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		m2 = (void*)(size_t)pr.base;
    1d3f:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1d42:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1d45:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax

		/* Now create two PDs (pointed by PDPTE) (1G per entry) */
		mm_alloc_pm(1, &pr, 1);
    1d48:	83 ec 04             	sub    esp,0x4
    1d4b:	6a 01                	push   0x1
    1d4d:	8d 45 a0             	lea    eax,[ebp-0x60]
    1d50:	50                   	push   eax
    1d51:	6a 01                	push   0x1
    1d53:	e8 fc ff ff ff       	call   1d54 <mm_pg64_init+0x321>
    1d58:	83 c4 10             	add    esp,0x10
		pl1 = (void*)(size_t)pr.base;
    1d5b:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1d5e:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1d61:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		m1->pds[0] = vp->cur; // 8 -> 17
    1d64:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d67:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1d6a:	8b 00                	mov    eax,DWORD PTR [eax]
    1d6c:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    1d6f:	89 01                	mov    DWORD PTR [ecx],eax
    1d71:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		vp->cur -= 4096;
    1d74:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d77:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1d7a:	8b 00                	mov    eax,DWORD PTR [eax]
    1d7c:	05 00 f0 ff ff       	add    eax,0xfffff000
    1d81:	83 d2 ff             	adc    edx,0xffffffff
    1d84:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1d87:	89 01                	mov    DWORD PTR [ecx],eax
    1d89:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		mm_alloc_pm(1, &pr, 1);
    1d8c:	83 ec 04             	sub    esp,0x4
    1d8f:	6a 01                	push   0x1
    1d91:	8d 45 a0             	lea    eax,[ebp-0x60]
    1d94:	50                   	push   eax
    1d95:	6a 01                	push   0x1
    1d97:	e8 fc ff ff ff       	call   1d98 <mm_pg64_init+0x365>
    1d9c:	83 c4 10             	add    esp,0x10
		pl2 = (void*)(size_t)pr.base;
    1d9f:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1da2:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1da5:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		m2->pds[511] = vp->cur; // 7 -> 18
    1da8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1dab:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1dae:	8b 00                	mov    eax,DWORD PTR [eax]
    1db0:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1db3:	89 81 f8 0f 00 00    	mov    DWORD PTR [ecx+0xff8],eax
    1db9:	89 91 fc 0f 00 00    	mov    DWORD PTR [ecx+0xffc],edx
		vp->cur -= 4096;
    1dbf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1dc2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1dc5:	8b 00                	mov    eax,DWORD PTR [eax]
    1dc7:	05 00 f0 ff ff       	add    eax,0xfffff000
    1dcc:	83 d2 ff             	adc    edx,0xffffffff
    1dcf:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1dd2:	89 01                	mov    DWORD PTR [ecx],eax
    1dd4:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		/* pl1 and pl2 are two PDs (2M per PDE) */

		/* register in the two PDPTs */
		p1[0].p = 1;
    1dd7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1dda:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1ddd:	83 ca 01             	or     edx,0x1
    1de0:	88 10                	mov    BYTE PTR [eax],dl
		p1[0].w = 1;
    1de2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1de5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1de8:	83 ca 02             	or     edx,0x2
    1deb:	88 10                	mov    BYTE PTR [eax],dl
		p1[0].u = 1;
    1ded:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1df0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1df3:	83 ca 04             	or     edx,0x4
    1df6:	88 10                	mov    BYTE PTR [eax],dl
		p1[0].addr = (size_t)pl1 / 4096;
    1df8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1dfb:	c1 e8 0c             	shr    eax,0xc
    1dfe:	ba 00 00 00 00       	mov    edx,0x0
    1e03:	81 e2 ff 00 00 00    	and    edx,0xff
    1e09:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    1e0c:	89 c3                	mov    ebx,eax
    1e0e:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1e14:	89 de                	mov    esi,ebx
    1e16:	c1 e6 0c             	shl    esi,0xc
    1e19:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1e1b:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1e21:	09 f3                	or     ebx,esi
    1e23:	89 19                	mov    DWORD PTR [ecx],ebx
    1e25:	89 c3                	mov    ebx,eax
    1e27:	c1 eb 14             	shr    ebx,0x14
    1e2a:	89 de                	mov    esi,ebx
    1e2c:	66 81 e6 ff 0f       	and    si,0xfff
    1e31:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1e35:	66 81 e3 00 f0       	and    bx,0xf000
    1e3a:	09 f3                	or     ebx,esi
    1e3c:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1e40:	0f b6 c2             	movzx  eax,dl
    1e43:	c1 e0 0c             	shl    eax,0xc
    1e46:	89 c2                	mov    edx,eax
    1e48:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1e4b:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1e50:	09 d0                	or     eax,edx
    1e52:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		p2[511].p = 1;
    1e55:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1e58:	05 f8 0f 00 00       	add    eax,0xff8
    1e5d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1e60:	83 ca 01             	or     edx,0x1
    1e63:	88 10                	mov    BYTE PTR [eax],dl
		p2[511].w = 1;
    1e65:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1e68:	05 f8 0f 00 00       	add    eax,0xff8
    1e6d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1e70:	83 ca 02             	or     edx,0x2
    1e73:	88 10                	mov    BYTE PTR [eax],dl
		p2[511].u = 1;
    1e75:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1e78:	05 f8 0f 00 00       	add    eax,0xff8
    1e7d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1e80:	83 ca 04             	or     edx,0x4
    1e83:	88 10                	mov    BYTE PTR [eax],dl
		p2[511].addr = (size_t)pl2 / 4096;
    1e85:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1e88:	c1 e8 0c             	shr    eax,0xc
    1e8b:	89 c2                	mov    edx,eax
    1e8d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1e90:	8d 88 f8 0f 00 00    	lea    ecx,[eax+0xff8]
    1e96:	89 d0                	mov    eax,edx
    1e98:	ba 00 00 00 00       	mov    edx,0x0
    1e9d:	81 e2 ff 00 00 00    	and    edx,0xff
    1ea3:	89 c3                	mov    ebx,eax
    1ea5:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1eab:	89 de                	mov    esi,ebx
    1ead:	c1 e6 0c             	shl    esi,0xc
    1eb0:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1eb2:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1eb8:	09 f3                	or     ebx,esi
    1eba:	89 19                	mov    DWORD PTR [ecx],ebx
    1ebc:	89 c3                	mov    ebx,eax
    1ebe:	c1 eb 14             	shr    ebx,0x14
    1ec1:	89 de                	mov    esi,ebx
    1ec3:	66 81 e6 ff 0f       	and    si,0xfff
    1ec8:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1ecc:	66 81 e3 00 f0       	and    bx,0xf000
    1ed1:	09 f3                	or     ebx,esi
    1ed3:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1ed7:	0f b6 c2             	movzx  eax,dl
    1eda:	c1 e0 0c             	shl    eax,0xc
    1edd:	89 c2                	mov    edx,eax
    1edf:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1ee2:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1ee7:	09 d0                	or     eax,edx
    1ee9:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax

		/* create PT pointer containers */
		mm_alloc_pm(1, &pr, 1);
    1eec:	83 ec 04             	sub    esp,0x4
    1eef:	6a 01                	push   0x1
    1ef1:	8d 45 a0             	lea    eax,[ebp-0x60]
    1ef4:	50                   	push   eax
    1ef5:	6a 01                	push   0x1
    1ef7:	e8 fc ff ff ff       	call   1ef8 <mm_pg64_init+0x4c5>
    1efc:	83 c4 10             	add    esp,0x10
		n1 = (void*)(size_t)pr.base;
    1eff:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1f02:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1f05:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		m1->pdes[0] = vp->cur; // 6 -> 19
    1f08:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1f0b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1f0e:	8b 00                	mov    eax,DWORD PTR [eax]
    1f10:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    1f13:	89 81 00 10 00 00    	mov    DWORD PTR [ecx+0x1000],eax
    1f19:	89 91 04 10 00 00    	mov    DWORD PTR [ecx+0x1004],edx
		vp->cur -= 4096;
    1f1f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1f22:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1f25:	8b 00                	mov    eax,DWORD PTR [eax]
    1f27:	05 00 f0 ff ff       	add    eax,0xfffff000
    1f2c:	83 d2 ff             	adc    edx,0xffffffff
    1f2f:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1f32:	89 01                	mov    DWORD PTR [ecx],eax
    1f34:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		mm_alloc_pm(1, &pr, 1);
    1f37:	83 ec 04             	sub    esp,0x4
    1f3a:	6a 01                	push   0x1
    1f3c:	8d 45 a0             	lea    eax,[ebp-0x60]
    1f3f:	50                   	push   eax
    1f40:	6a 01                	push   0x1
    1f42:	e8 fc ff ff ff       	call   1f43 <mm_pg64_init+0x510>
    1f47:	83 c4 10             	add    esp,0x10
		n2 = (void*)(size_t)pr.base;
    1f4a:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1f4d:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1f50:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		m2->pdes[511] = vp->cur; // 5 -> 1a
    1f53:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1f56:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1f59:	8b 00                	mov    eax,DWORD PTR [eax]
    1f5b:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1f5e:	89 81 f8 1f 00 00    	mov    DWORD PTR [ecx+0x1ff8],eax
    1f64:	89 91 fc 1f 00 00    	mov    DWORD PTR [ecx+0x1ffc],edx
		vp->cur -= 4096;
    1f6a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1f6d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1f70:	8b 00                	mov    eax,DWORD PTR [eax]
    1f72:	05 00 f0 ff ff       	add    eax,0xfffff000
    1f77:	83 d2 ff             	adc    edx,0xffffffff
    1f7a:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1f7d:	89 01                	mov    DWORD PTR [ecx],eax
    1f7f:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx

		/* now create PTs */
		/* one for the first 2MiB */
		mm_alloc_pm(1, &pr, 1);
    1f82:	83 ec 04             	sub    esp,0x4
    1f85:	6a 01                	push   0x1
    1f87:	8d 45 a0             	lea    eax,[ebp-0x60]
    1f8a:	50                   	push   eax
    1f8b:	6a 01                	push   0x1
    1f8d:	e8 fc ff ff ff       	call   1f8e <mm_pg64_init+0x55b>
    1f92:	83 c4 10             	add    esp,0x10
		pt1 = (void*)(size_t)pr.base;
    1f95:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1f98:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1f9b:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		n1->pts[0] = vp->cur; // 4 -> 1b
    1f9e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1fa1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1fa4:	8b 00                	mov    eax,DWORD PTR [eax]
    1fa6:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1fa9:	89 01                	mov    DWORD PTR [ecx],eax
    1fab:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		vp->cur -= 4096;
    1fae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1fb1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1fb4:	8b 00                	mov    eax,DWORD PTR [eax]
    1fb6:	05 00 f0 ff ff       	add    eax,0xfffff000
    1fbb:	83 d2 ff             	adc    edx,0xffffffff
    1fbe:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1fc1:	89 01                	mov    DWORD PTR [ecx],eax
    1fc3:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		/* and one for the last two */
		mm_alloc_pm(1, &pr, 1);
    1fc6:	83 ec 04             	sub    esp,0x4
    1fc9:	6a 01                	push   0x1
    1fcb:	8d 45 a0             	lea    eax,[ebp-0x60]
    1fce:	50                   	push   eax
    1fcf:	6a 01                	push   0x1
    1fd1:	e8 fc ff ff ff       	call   1fd2 <mm_pg64_init+0x59f>
    1fd6:	83 c4 10             	add    esp,0x10
		pt2 = (void*)(size_t)pr.base;
    1fd9:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1fdc:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1fdf:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		n2->pts[511] = vp->cur; // 3 -> 1c
    1fe2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1fe5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1fe8:	8b 00                	mov    eax,DWORD PTR [eax]
    1fea:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    1fed:	89 81 f8 0f 00 00    	mov    DWORD PTR [ecx+0xff8],eax
    1ff3:	89 91 fc 0f 00 00    	mov    DWORD PTR [ecx+0xffc],edx
		vp->cur -= 4096;
    1ff9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ffc:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1fff:	8b 00                	mov    eax,DWORD PTR [eax]
    2001:	05 00 f0 ff ff       	add    eax,0xfffff000
    2006:	83 d2 ff             	adc    edx,0xffffffff
    2009:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    200c:	89 01                	mov    DWORD PTR [ecx],eax
    200e:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx

		/* register them in the directories */
		pl1[0].p = 1;
    2011:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2014:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2017:	83 ca 01             	or     edx,0x1
    201a:	88 10                	mov    BYTE PTR [eax],dl
		pl1[0].w = 1;
    201c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    201f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2022:	83 ca 02             	or     edx,0x2
    2025:	88 10                	mov    BYTE PTR [eax],dl
		pl1[0].u = 1;
    2027:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    202a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    202d:	83 ca 04             	or     edx,0x4
    2030:	88 10                	mov    BYTE PTR [eax],dl
		pl1[0].addr = (size_t)pt1 / 4096;
    2032:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2035:	c1 e8 0c             	shr    eax,0xc
    2038:	ba 00 00 00 00       	mov    edx,0x0
    203d:	81 e2 ff 00 00 00    	and    edx,0xff
    2043:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    2046:	89 c3                	mov    ebx,eax
    2048:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    204e:	89 de                	mov    esi,ebx
    2050:	c1 e6 0c             	shl    esi,0xc
    2053:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2055:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    205b:	09 f3                	or     ebx,esi
    205d:	89 19                	mov    DWORD PTR [ecx],ebx
    205f:	89 c3                	mov    ebx,eax
    2061:	c1 eb 14             	shr    ebx,0x14
    2064:	89 de                	mov    esi,ebx
    2066:	66 81 e6 ff 0f       	and    si,0xfff
    206b:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    206f:	66 81 e3 00 f0       	and    bx,0xf000
    2074:	09 f3                	or     ebx,esi
    2076:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    207a:	0f b6 c2             	movzx  eax,dl
    207d:	c1 e0 0c             	shl    eax,0xc
    2080:	89 c2                	mov    edx,eax
    2082:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2085:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    208a:	09 d0                	or     eax,edx
    208c:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pl2[511].p = 1;
    208f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2092:	05 f8 0f 00 00       	add    eax,0xff8
    2097:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    209a:	83 ca 01             	or     edx,0x1
    209d:	88 10                	mov    BYTE PTR [eax],dl
		pl2[511].w = 1;
    209f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    20a2:	05 f8 0f 00 00       	add    eax,0xff8
    20a7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    20aa:	83 ca 02             	or     edx,0x2
    20ad:	88 10                	mov    BYTE PTR [eax],dl
		pl2[511].u = 1;
    20af:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    20b2:	05 f8 0f 00 00       	add    eax,0xff8
    20b7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    20ba:	83 ca 04             	or     edx,0x4
    20bd:	88 10                	mov    BYTE PTR [eax],dl
		pl2[511].addr = (size_t)pt2 / 4096;
    20bf:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    20c2:	c1 e8 0c             	shr    eax,0xc
    20c5:	89 c2                	mov    edx,eax
    20c7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    20ca:	8d 88 f8 0f 00 00    	lea    ecx,[eax+0xff8]
    20d0:	89 d0                	mov    eax,edx
    20d2:	ba 00 00 00 00       	mov    edx,0x0
    20d7:	81 e2 ff 00 00 00    	and    edx,0xff
    20dd:	89 c3                	mov    ebx,eax
    20df:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    20e5:	89 de                	mov    esi,ebx
    20e7:	c1 e6 0c             	shl    esi,0xc
    20ea:	8b 19                	mov    ebx,DWORD PTR [ecx]
    20ec:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    20f2:	09 f3                	or     ebx,esi
    20f4:	89 19                	mov    DWORD PTR [ecx],ebx
    20f6:	89 c3                	mov    ebx,eax
    20f8:	c1 eb 14             	shr    ebx,0x14
    20fb:	89 de                	mov    esi,ebx
    20fd:	66 81 e6 ff 0f       	and    si,0xfff
    2102:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2106:	66 81 e3 00 f0       	and    bx,0xf000
    210b:	09 f3                	or     ebx,esi
    210d:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2111:	0f b6 c2             	movzx  eax,dl
    2114:	c1 e0 0c             	shl    eax,0xc
    2117:	89 c2                	mov    edx,eax
    2119:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    211c:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2121:	09 d0                	or     eax,edx
    2123:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
    2126:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    212d:	e9 b0 00 00 00       	jmp    21e2 <mm_pg64_init+0x7af>
				/* identity CD */
				pt1[i].p = 1;
    2132:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2135:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    213c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    213f:	01 d0                	add    eax,edx
    2141:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2144:	83 ca 01             	or     edx,0x1
    2147:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].w = 1;
    2149:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    214c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2153:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2156:	01 d0                	add    eax,edx
    2158:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    215b:	83 ca 02             	or     edx,0x2
    215e:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].u = 0;
    2160:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2163:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    216a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    216d:	01 d0                	add    eax,edx
    216f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2172:	83 e2 fb             	and    edx,0xfffffffb
    2175:	88 10                	mov    BYTE PTR [eax],dl
				//pt1[i].xd = 1;
				pt1[i].addr = i; /* identity */
    2177:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    217a:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2181:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2184:	8d 0c 02             	lea    ecx,[edx+eax*1]
    2187:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    218a:	ba 00 00 00 00       	mov    edx,0x0
    218f:	81 e2 ff 00 00 00    	and    edx,0xff
    2195:	89 c3                	mov    ebx,eax
    2197:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    219d:	89 de                	mov    esi,ebx
    219f:	c1 e6 0c             	shl    esi,0xc
    21a2:	8b 19                	mov    ebx,DWORD PTR [ecx]
    21a4:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    21aa:	09 f3                	or     ebx,esi
    21ac:	89 19                	mov    DWORD PTR [ecx],ebx
    21ae:	89 c3                	mov    ebx,eax
    21b0:	c1 eb 14             	shr    ebx,0x14
    21b3:	89 de                	mov    esi,ebx
    21b5:	66 81 e6 ff 0f       	and    si,0xfff
    21ba:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    21be:	66 81 e3 00 f0       	and    bx,0xf000
    21c3:	09 f3                	or     ebx,esi
    21c5:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    21c9:	0f b6 c2             	movzx  eax,dl
    21cc:	c1 e0 0c             	shl    eax,0xc
    21cf:	89 c2                	mov    edx,eax
    21d1:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    21d4:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    21d9:	09 d0                	or     eax,edx
    21db:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		for (size_t i = 0; i < 256; i++) {
    21de:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    21e2:	81 7d f4 ff 00 00 00 	cmp    DWORD PTR [ebp-0xc],0xff
    21e9:	0f 86 43 ff ff ff    	jbe    2132 <mm_pg64_init+0x6ff>
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint64_t bse = 0xffffffffffe00000; /* base of last PD used to calculate idx */
    21ef:	c7 45 b0 00 00 e0 ff 	mov    DWORD PTR [ebp-0x50],0xffe00000
    21f6:	c7 45 b4 ff ff ff ff 	mov    DWORD PTR [ebp-0x4c],0xffffffff
		size_t idx;
		/* first the PML4 */
		idx = (vp->pml4 - bse) / 4096;
    21fd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2200:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2203:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2206:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2209:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    220c:	0f ac d0 0c          	shrd   eax,edx,0xc
    2210:	c1 ea 0c             	shr    edx,0xc
    2213:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2216:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2219:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2220:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2223:	01 d0                	add    eax,edx
    2225:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2228:	83 ca 01             	or     edx,0x1
    222b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    222d:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2230:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2237:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    223a:	01 d0                	add    eax,edx
    223c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    223f:	83 ca 02             	or     edx,0x2
    2242:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0; /* only supervisor access to pts */
    2244:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2247:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    224e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2251:	01 d0                	add    eax,edx
    2253:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2256:	83 e2 fb             	and    edx,0xfffffffb
    2259:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = cr3_val / 4096;
    225b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2260:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    2266:	0f ac d0 0c          	shrd   eax,edx,0xc
    226a:	c1 ea 0c             	shr    edx,0xc
    226d:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2270:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2277:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    227a:	01 d9                	add    ecx,ebx
    227c:	81 e2 ff 00 00 00    	and    edx,0xff
    2282:	89 c3                	mov    ebx,eax
    2284:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    228a:	89 de                	mov    esi,ebx
    228c:	c1 e6 0c             	shl    esi,0xc
    228f:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2291:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2297:	09 f3                	or     ebx,esi
    2299:	89 19                	mov    DWORD PTR [ecx],ebx
    229b:	89 c3                	mov    ebx,eax
    229d:	c1 eb 14             	shr    ebx,0x14
    22a0:	89 de                	mov    esi,ebx
    22a2:	66 81 e6 ff 0f       	and    si,0xfff
    22a7:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    22ab:	66 81 e3 00 f0       	and    bx,0xf000
    22b0:	09 f3                	or     ebx,esi
    22b2:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    22b6:	0f b6 c2             	movzx  eax,dl
    22b9:	c1 e0 0c             	shl    eax,0xc
    22bc:	89 c2                	mov    edx,eax
    22be:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    22c1:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    22c6:	09 d0                	or     eax,edx
    22c8:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    22cb:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    22d1:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    22d4:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    22db:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    22de:	01 c8                	add    eax,ecx
    22e0:	85 d2                	test   edx,edx
    22e2:	0f 95 c2             	setne  dl
    22e5:	89 d1                	mov    ecx,edx
    22e7:	c1 e1 07             	shl    ecx,0x7
    22ea:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    22ee:	83 e2 7f             	and    edx,0x7f
    22f1:	09 ca                	or     edx,ecx
    22f3:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		/* vp is identity mapped -> no need for doing sth. (TODO: protection) */		
		/* then the 2 PDPTs */
		idx = (vp->pml4e[0] - bse) / 4096;
    22f6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    22f9:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    22fc:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    22ff:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2302:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2305:	0f ac d0 0c          	shrd   eax,edx,0xc
    2309:	c1 ea 0c             	shr    edx,0xc
    230c:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    230f:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2312:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2319:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    231c:	01 d0                	add    eax,edx
    231e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2321:	83 ca 01             	or     edx,0x1
    2324:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2326:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2329:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2330:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2333:	01 d0                	add    eax,edx
    2335:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2338:	83 ca 02             	or     edx,0x2
    233b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    233d:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2340:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2347:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    234a:	01 d0                	add    eax,edx
    234c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    234f:	83 e2 fb             	and    edx,0xfffffffb
    2352:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)p1 / 4096;
    2354:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2357:	99                   	cdq
    2358:	0f ac d0 0c          	shrd   eax,edx,0xc
    235c:	c1 ea 0c             	shr    edx,0xc
    235f:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2362:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2369:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    236c:	01 d9                	add    ecx,ebx
    236e:	81 e2 ff 00 00 00    	and    edx,0xff
    2374:	89 c3                	mov    ebx,eax
    2376:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    237c:	89 de                	mov    esi,ebx
    237e:	c1 e6 0c             	shl    esi,0xc
    2381:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2383:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2389:	09 f3                	or     ebx,esi
    238b:	89 19                	mov    DWORD PTR [ecx],ebx
    238d:	89 c3                	mov    ebx,eax
    238f:	c1 eb 14             	shr    ebx,0x14
    2392:	89 de                	mov    esi,ebx
    2394:	66 81 e6 ff 0f       	and    si,0xfff
    2399:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    239d:	66 81 e3 00 f0       	and    bx,0xf000
    23a2:	09 f3                	or     ebx,esi
    23a4:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    23a8:	0f b6 c2             	movzx  eax,dl
    23ab:	c1 e0 0c             	shl    eax,0xc
    23ae:	89 c2                	mov    edx,eax
    23b0:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    23b3:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    23b8:	09 d0                	or     eax,edx
    23ba:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    23bd:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    23c3:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    23c6:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    23cd:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    23d0:	01 c8                	add    eax,ecx
    23d2:	85 d2                	test   edx,edx
    23d4:	0f 95 c2             	setne  dl
    23d7:	89 d1                	mov    ecx,edx
    23d9:	c1 e1 07             	shl    ecx,0x7
    23dc:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    23e0:	83 e2 7f             	and    edx,0x7f
    23e3:	09 ca                	or     edx,ecx
    23e5:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		idx = (vp->pml4e[511] - bse) / 4096;
    23e8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    23eb:	8b 90 0c 10 00 00    	mov    edx,DWORD PTR [eax+0x100c]
    23f1:	8b 80 08 10 00 00    	mov    eax,DWORD PTR [eax+0x1008]
    23f7:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    23fa:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    23fd:	0f ac d0 0c          	shrd   eax,edx,0xc
    2401:	c1 ea 0c             	shr    edx,0xc
    2404:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2407:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    240a:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2411:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2414:	01 d0                	add    eax,edx
    2416:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2419:	83 ca 01             	or     edx,0x1
    241c:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    241e:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2421:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2428:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    242b:	01 d0                	add    eax,edx
    242d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2430:	83 ca 02             	or     edx,0x2
    2433:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2435:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2438:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    243f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2442:	01 d0                	add    eax,edx
    2444:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2447:	83 e2 fb             	and    edx,0xfffffffb
    244a:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)p2 / 4096;
    244c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    244f:	99                   	cdq
    2450:	0f ac d0 0c          	shrd   eax,edx,0xc
    2454:	c1 ea 0c             	shr    edx,0xc
    2457:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    245a:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2461:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2464:	01 d9                	add    ecx,ebx
    2466:	81 e2 ff 00 00 00    	and    edx,0xff
    246c:	89 c3                	mov    ebx,eax
    246e:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2474:	89 de                	mov    esi,ebx
    2476:	c1 e6 0c             	shl    esi,0xc
    2479:	8b 19                	mov    ebx,DWORD PTR [ecx]
    247b:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2481:	09 f3                	or     ebx,esi
    2483:	89 19                	mov    DWORD PTR [ecx],ebx
    2485:	89 c3                	mov    ebx,eax
    2487:	c1 eb 14             	shr    ebx,0x14
    248a:	89 de                	mov    esi,ebx
    248c:	66 81 e6 ff 0f       	and    si,0xfff
    2491:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2495:	66 81 e3 00 f0       	and    bx,0xf000
    249a:	09 f3                	or     ebx,esi
    249c:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    24a0:	0f b6 c2             	movzx  eax,dl
    24a3:	c1 e0 0c             	shl    eax,0xc
    24a6:	89 c2                	mov    edx,eax
    24a8:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    24ab:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    24b0:	09 d0                	or     eax,edx
    24b2:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    24b5:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    24bb:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    24be:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    24c5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    24c8:	01 c8                	add    eax,ecx
    24ca:	85 d2                	test   edx,edx
    24cc:	0f 95 c2             	setne  dl
    24cf:	89 d1                	mov    ecx,edx
    24d1:	c1 e1 07             	shl    ecx,0x7
    24d4:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    24d8:	83 e2 7f             	and    edx,0x7f
    24db:	09 ca                	or     edx,ecx
    24dd:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		/* now the two container structures (each 2 pages size, for PDPTEs(PDs & PDEs)) */
		idx = (vp->pdpte[0] - bse) / 4096;	
    24e0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    24e3:	8b 90 14 10 00 00    	mov    edx,DWORD PTR [eax+0x1014]
    24e9:	8b 80 10 10 00 00    	mov    eax,DWORD PTR [eax+0x1010]
    24ef:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    24f2:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    24f5:	0f ac d0 0c          	shrd   eax,edx,0xc
    24f9:	c1 ea 0c             	shr    edx,0xc
    24fc:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    24ff:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2502:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2509:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    250c:	01 d0                	add    eax,edx
    250e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2511:	83 ca 01             	or     edx,0x1
    2514:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2516:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2519:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2520:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2523:	01 d0                	add    eax,edx
    2525:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2528:	83 ca 02             	or     edx,0x2
    252b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    252d:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2530:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2537:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    253a:	01 d0                	add    eax,edx
    253c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    253f:	83 e2 fb             	and    edx,0xfffffffb
    2542:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)m1 / 4096;
    2544:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2547:	99                   	cdq
    2548:	0f ac d0 0c          	shrd   eax,edx,0xc
    254c:	c1 ea 0c             	shr    edx,0xc
    254f:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2552:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2559:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    255c:	01 d9                	add    ecx,ebx
    255e:	81 e2 ff 00 00 00    	and    edx,0xff
    2564:	89 c3                	mov    ebx,eax
    2566:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    256c:	89 de                	mov    esi,ebx
    256e:	c1 e6 0c             	shl    esi,0xc
    2571:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2573:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2579:	09 f3                	or     ebx,esi
    257b:	89 19                	mov    DWORD PTR [ecx],ebx
    257d:	89 c3                	mov    ebx,eax
    257f:	c1 eb 14             	shr    ebx,0x14
    2582:	89 de                	mov    esi,ebx
    2584:	66 81 e6 ff 0f       	and    si,0xfff
    2589:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    258d:	66 81 e3 00 f0       	and    bx,0xf000
    2592:	09 f3                	or     ebx,esi
    2594:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2598:	0f b6 c2             	movzx  eax,dl
    259b:	c1 e0 0c             	shl    eax,0xc
    259e:	89 c2                	mov    edx,eax
    25a0:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    25a3:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    25a8:	09 d0                	or     eax,edx
    25aa:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    25ad:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    25b3:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    25b6:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    25bd:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    25c0:	01 c8                	add    eax,ecx
    25c2:	85 d2                	test   edx,edx
    25c4:	0f 95 c2             	setne  dl
    25c7:	89 d1                	mov    ecx,edx
    25c9:	c1 e1 07             	shl    ecx,0x7
    25cc:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    25d0:	83 e2 7f             	and    edx,0x7f
    25d3:	09 ca                	or     edx,ecx
    25d5:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		pt2[idx + 1].p = 1;
    25d8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    25db:	83 c0 01             	add    eax,0x1
    25de:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    25e5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    25e8:	01 d0                	add    eax,edx
    25ea:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    25ed:	83 ca 01             	or     edx,0x1
    25f0:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].w = 1;
    25f2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    25f5:	83 c0 01             	add    eax,0x1
    25f8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    25ff:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2602:	01 d0                	add    eax,edx
    2604:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2607:	83 ca 02             	or     edx,0x2
    260a:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].u = 0;
    260c:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    260f:	83 c0 01             	add    eax,0x1
    2612:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2619:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    261c:	01 d0                	add    eax,edx
    261e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2621:	83 e2 fb             	and    edx,0xfffffffb
    2624:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].addr = (uint64_t)m1 / 4096 + 1;
    2626:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2629:	99                   	cdq
    262a:	0f ac d0 0c          	shrd   eax,edx,0xc
    262e:	c1 ea 0c             	shr    edx,0xc
    2631:	83 c0 01             	add    eax,0x1
    2634:	83 d2 00             	adc    edx,0x0
    2637:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    263a:	83 c1 01             	add    ecx,0x1
    263d:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2644:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2647:	01 d9                	add    ecx,ebx
    2649:	81 e2 ff 00 00 00    	and    edx,0xff
    264f:	89 c3                	mov    ebx,eax
    2651:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2657:	89 de                	mov    esi,ebx
    2659:	c1 e6 0c             	shl    esi,0xc
    265c:	8b 19                	mov    ebx,DWORD PTR [ecx]
    265e:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2664:	09 f3                	or     ebx,esi
    2666:	89 19                	mov    DWORD PTR [ecx],ebx
    2668:	89 c3                	mov    ebx,eax
    266a:	c1 eb 14             	shr    ebx,0x14
    266d:	89 de                	mov    esi,ebx
    266f:	66 81 e6 ff 0f       	and    si,0xfff
    2674:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2678:	66 81 e3 00 f0       	and    bx,0xf000
    267d:	09 f3                	or     ebx,esi
    267f:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2683:	0f b6 c2             	movzx  eax,dl
    2686:	c1 e0 0c             	shl    eax,0xc
    2689:	89 c2                	mov    edx,eax
    268b:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    268e:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2693:	09 d0                	or     eax,edx
    2695:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx + 1].xd = (has_nx ? 1 : 0);
    2698:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    269e:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    26a1:	83 c0 01             	add    eax,0x1
    26a4:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    26ab:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    26ae:	01 c8                	add    eax,ecx
    26b0:	85 d2                	test   edx,edx
    26b2:	0f 95 c2             	setne  dl
    26b5:	89 d1                	mov    ecx,edx
    26b7:	c1 e1 07             	shl    ecx,0x7
    26ba:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    26be:	83 e2 7f             	and    edx,0x7f
    26c1:	09 ca                	or     edx,ecx
    26c3:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		idx = (vp->pdpte[511] - bse) / 4096;	
    26c6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    26c9:	8b 90 0c 20 00 00    	mov    edx,DWORD PTR [eax+0x200c]
    26cf:	8b 80 08 20 00 00    	mov    eax,DWORD PTR [eax+0x2008]
    26d5:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    26d8:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    26db:	0f ac d0 0c          	shrd   eax,edx,0xc
    26df:	c1 ea 0c             	shr    edx,0xc
    26e2:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    26e5:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    26e8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    26ef:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    26f2:	01 d0                	add    eax,edx
    26f4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    26f7:	83 ca 01             	or     edx,0x1
    26fa:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    26fc:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    26ff:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2706:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2709:	01 d0                	add    eax,edx
    270b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    270e:	83 ca 02             	or     edx,0x2
    2711:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2713:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2716:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    271d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2720:	01 d0                	add    eax,edx
    2722:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2725:	83 e2 fb             	and    edx,0xfffffffb
    2728:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)m2 / 4096;
    272a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    272d:	99                   	cdq
    272e:	0f ac d0 0c          	shrd   eax,edx,0xc
    2732:	c1 ea 0c             	shr    edx,0xc
    2735:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2738:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    273f:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2742:	01 d9                	add    ecx,ebx
    2744:	81 e2 ff 00 00 00    	and    edx,0xff
    274a:	89 c3                	mov    ebx,eax
    274c:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2752:	89 de                	mov    esi,ebx
    2754:	c1 e6 0c             	shl    esi,0xc
    2757:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2759:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    275f:	09 f3                	or     ebx,esi
    2761:	89 19                	mov    DWORD PTR [ecx],ebx
    2763:	89 c3                	mov    ebx,eax
    2765:	c1 eb 14             	shr    ebx,0x14
    2768:	89 de                	mov    esi,ebx
    276a:	66 81 e6 ff 0f       	and    si,0xfff
    276f:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2773:	66 81 e3 00 f0       	and    bx,0xf000
    2778:	09 f3                	or     ebx,esi
    277a:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    277e:	0f b6 c2             	movzx  eax,dl
    2781:	c1 e0 0c             	shl    eax,0xc
    2784:	89 c2                	mov    edx,eax
    2786:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2789:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    278e:	09 d0                	or     eax,edx
    2790:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2793:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2799:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    279c:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    27a3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    27a6:	01 c8                	add    eax,ecx
    27a8:	85 d2                	test   edx,edx
    27aa:	0f 95 c2             	setne  dl
    27ad:	89 d1                	mov    ecx,edx
    27af:	c1 e1 07             	shl    ecx,0x7
    27b2:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    27b6:	83 e2 7f             	and    edx,0x7f
    27b9:	09 ca                	or     edx,ecx
    27bb:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		pt2[idx + 1].p = 1;
    27be:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    27c1:	83 c0 01             	add    eax,0x1
    27c4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    27cb:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    27ce:	01 d0                	add    eax,edx
    27d0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    27d3:	83 ca 01             	or     edx,0x1
    27d6:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].w = 1;
    27d8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    27db:	83 c0 01             	add    eax,0x1
    27de:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    27e5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    27e8:	01 d0                	add    eax,edx
    27ea:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    27ed:	83 ca 02             	or     edx,0x2
    27f0:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].u = 0;
    27f2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    27f5:	83 c0 01             	add    eax,0x1
    27f8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    27ff:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2802:	01 d0                	add    eax,edx
    2804:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2807:	83 e2 fb             	and    edx,0xfffffffb
    280a:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].addr = (uint64_t)m2 / 4096 + 1;
    280c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    280f:	99                   	cdq
    2810:	0f ac d0 0c          	shrd   eax,edx,0xc
    2814:	c1 ea 0c             	shr    edx,0xc
    2817:	83 c0 01             	add    eax,0x1
    281a:	83 d2 00             	adc    edx,0x0
    281d:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2820:	83 c1 01             	add    ecx,0x1
    2823:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    282a:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    282d:	01 d9                	add    ecx,ebx
    282f:	81 e2 ff 00 00 00    	and    edx,0xff
    2835:	89 c3                	mov    ebx,eax
    2837:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    283d:	89 de                	mov    esi,ebx
    283f:	c1 e6 0c             	shl    esi,0xc
    2842:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2844:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    284a:	09 f3                	or     ebx,esi
    284c:	89 19                	mov    DWORD PTR [ecx],ebx
    284e:	89 c3                	mov    ebx,eax
    2850:	c1 eb 14             	shr    ebx,0x14
    2853:	89 de                	mov    esi,ebx
    2855:	66 81 e6 ff 0f       	and    si,0xfff
    285a:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    285e:	66 81 e3 00 f0       	and    bx,0xf000
    2863:	09 f3                	or     ebx,esi
    2865:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2869:	0f b6 c2             	movzx  eax,dl
    286c:	c1 e0 0c             	shl    eax,0xc
    286f:	89 c2                	mov    edx,eax
    2871:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2874:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2879:	09 d0                	or     eax,edx
    287b:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx + 1].xd = (has_nx ? 1 : 0);
    287e:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2884:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2887:	83 c0 01             	add    eax,0x1
    288a:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2891:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2894:	01 c8                	add    eax,ecx
    2896:	85 d2                	test   edx,edx
    2898:	0f 95 c2             	setne  dl
    289b:	89 d1                	mov    ecx,edx
    289d:	c1 e1 07             	shl    ecx,0x7
    28a0:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    28a4:	83 e2 7f             	and    edx,0x7f
    28a7:	09 ca                	or     edx,ecx
    28a9:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		/* followed by the two PDs */
		idx = (m1->pds[0] - bse) / 4096;
    28ac:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    28af:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    28b2:	8b 00                	mov    eax,DWORD PTR [eax]
    28b4:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    28b7:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    28ba:	0f ac d0 0c          	shrd   eax,edx,0xc
    28be:	c1 ea 0c             	shr    edx,0xc
    28c1:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    28c4:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    28c7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    28ce:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    28d1:	01 d0                	add    eax,edx
    28d3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    28d6:	83 ca 01             	or     edx,0x1
    28d9:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    28db:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    28de:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    28e5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    28e8:	01 d0                	add    eax,edx
    28ea:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    28ed:	83 ca 02             	or     edx,0x2
    28f0:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    28f2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    28f5:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    28fc:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    28ff:	01 d0                	add    eax,edx
    2901:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2904:	83 e2 fb             	and    edx,0xfffffffb
    2907:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pl1 / 4096;
    2909:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    290c:	99                   	cdq
    290d:	0f ac d0 0c          	shrd   eax,edx,0xc
    2911:	c1 ea 0c             	shr    edx,0xc
    2914:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2917:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    291e:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2921:	01 d9                	add    ecx,ebx
    2923:	81 e2 ff 00 00 00    	and    edx,0xff
    2929:	89 c3                	mov    ebx,eax
    292b:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2931:	89 de                	mov    esi,ebx
    2933:	c1 e6 0c             	shl    esi,0xc
    2936:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2938:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    293e:	09 f3                	or     ebx,esi
    2940:	89 19                	mov    DWORD PTR [ecx],ebx
    2942:	89 c3                	mov    ebx,eax
    2944:	c1 eb 14             	shr    ebx,0x14
    2947:	89 de                	mov    esi,ebx
    2949:	66 81 e6 ff 0f       	and    si,0xfff
    294e:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2952:	66 81 e3 00 f0       	and    bx,0xf000
    2957:	09 f3                	or     ebx,esi
    2959:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    295d:	0f b6 c2             	movzx  eax,dl
    2960:	c1 e0 0c             	shl    eax,0xc
    2963:	89 c2                	mov    edx,eax
    2965:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2968:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    296d:	09 d0                	or     eax,edx
    296f:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2972:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2978:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    297b:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2982:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2985:	01 c8                	add    eax,ecx
    2987:	85 d2                	test   edx,edx
    2989:	0f 95 c2             	setne  dl
    298c:	89 d1                	mov    ecx,edx
    298e:	c1 e1 07             	shl    ecx,0x7
    2991:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2995:	83 e2 7f             	and    edx,0x7f
    2998:	09 ca                	or     edx,ecx
    299a:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		idx = (m2->pds[511] - bse) / 4096;
    299d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    29a0:	8b 90 fc 0f 00 00    	mov    edx,DWORD PTR [eax+0xffc]
    29a6:	8b 80 f8 0f 00 00    	mov    eax,DWORD PTR [eax+0xff8]
    29ac:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    29af:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    29b2:	0f ac d0 0c          	shrd   eax,edx,0xc
    29b6:	c1 ea 0c             	shr    edx,0xc
    29b9:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    29bc:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    29bf:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    29c6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    29c9:	01 d0                	add    eax,edx
    29cb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    29ce:	83 ca 01             	or     edx,0x1
    29d1:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    29d3:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    29d6:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    29dd:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    29e0:	01 d0                	add    eax,edx
    29e2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    29e5:	83 ca 02             	or     edx,0x2
    29e8:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    29ea:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    29ed:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    29f4:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    29f7:	01 d0                	add    eax,edx
    29f9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    29fc:	83 e2 fb             	and    edx,0xfffffffb
    29ff:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pl2 / 4096;
    2a01:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2a04:	99                   	cdq
    2a05:	0f ac d0 0c          	shrd   eax,edx,0xc
    2a09:	c1 ea 0c             	shr    edx,0xc
    2a0c:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2a0f:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2a16:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2a19:	01 d9                	add    ecx,ebx
    2a1b:	81 e2 ff 00 00 00    	and    edx,0xff
    2a21:	89 c3                	mov    ebx,eax
    2a23:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2a29:	89 de                	mov    esi,ebx
    2a2b:	c1 e6 0c             	shl    esi,0xc
    2a2e:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2a30:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2a36:	09 f3                	or     ebx,esi
    2a38:	89 19                	mov    DWORD PTR [ecx],ebx
    2a3a:	89 c3                	mov    ebx,eax
    2a3c:	c1 eb 14             	shr    ebx,0x14
    2a3f:	89 de                	mov    esi,ebx
    2a41:	66 81 e6 ff 0f       	and    si,0xfff
    2a46:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2a4a:	66 81 e3 00 f0       	and    bx,0xf000
    2a4f:	09 f3                	or     ebx,esi
    2a51:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2a55:	0f b6 c2             	movzx  eax,dl
    2a58:	c1 e0 0c             	shl    eax,0xc
    2a5b:	89 c2                	mov    edx,eax
    2a5d:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2a60:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2a65:	09 d0                	or     eax,edx
    2a67:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2a6a:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2a70:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2a73:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2a7a:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2a7d:	01 c8                	add    eax,ecx
    2a7f:	85 d2                	test   edx,edx
    2a81:	0f 95 c2             	setne  dl
    2a84:	89 d1                	mov    ecx,edx
    2a86:	c1 e1 07             	shl    ecx,0x7
    2a89:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2a8d:	83 e2 7f             	and    edx,0x7f
    2a90:	09 ca                	or     edx,ecx
    2a92:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		/* and the two PT pointer containers */
		idx = (m1->pdes[0] - bse) / 4096;
    2a95:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2a98:	8b 90 04 10 00 00    	mov    edx,DWORD PTR [eax+0x1004]
    2a9e:	8b 80 00 10 00 00    	mov    eax,DWORD PTR [eax+0x1000]
    2aa4:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2aa7:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2aaa:	0f ac d0 0c          	shrd   eax,edx,0xc
    2aae:	c1 ea 0c             	shr    edx,0xc
    2ab1:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2ab4:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ab7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2abe:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2ac1:	01 d0                	add    eax,edx
    2ac3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2ac6:	83 ca 01             	or     edx,0x1
    2ac9:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2acb:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ace:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2ad5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2ad8:	01 d0                	add    eax,edx
    2ada:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2add:	83 ca 02             	or     edx,0x2
    2ae0:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2ae2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ae5:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2aec:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2aef:	01 d0                	add    eax,edx
    2af1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2af4:	83 e2 fb             	and    edx,0xfffffffb
    2af7:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)n1 / 4096;
    2af9:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2afc:	99                   	cdq
    2afd:	0f ac d0 0c          	shrd   eax,edx,0xc
    2b01:	c1 ea 0c             	shr    edx,0xc
    2b04:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2b07:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2b0e:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2b11:	01 d9                	add    ecx,ebx
    2b13:	81 e2 ff 00 00 00    	and    edx,0xff
    2b19:	89 c3                	mov    ebx,eax
    2b1b:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2b21:	89 de                	mov    esi,ebx
    2b23:	c1 e6 0c             	shl    esi,0xc
    2b26:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2b28:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2b2e:	09 f3                	or     ebx,esi
    2b30:	89 19                	mov    DWORD PTR [ecx],ebx
    2b32:	89 c3                	mov    ebx,eax
    2b34:	c1 eb 14             	shr    ebx,0x14
    2b37:	89 de                	mov    esi,ebx
    2b39:	66 81 e6 ff 0f       	and    si,0xfff
    2b3e:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2b42:	66 81 e3 00 f0       	and    bx,0xf000
    2b47:	09 f3                	or     ebx,esi
    2b49:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2b4d:	0f b6 c2             	movzx  eax,dl
    2b50:	c1 e0 0c             	shl    eax,0xc
    2b53:	89 c2                	mov    edx,eax
    2b55:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2b58:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2b5d:	09 d0                	or     eax,edx
    2b5f:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2b62:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2b68:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2b6b:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2b72:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2b75:	01 c8                	add    eax,ecx
    2b77:	85 d2                	test   edx,edx
    2b79:	0f 95 c2             	setne  dl
    2b7c:	89 d1                	mov    ecx,edx
    2b7e:	c1 e1 07             	shl    ecx,0x7
    2b81:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2b85:	83 e2 7f             	and    edx,0x7f
    2b88:	09 ca                	or     edx,ecx
    2b8a:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		idx = (m2->pdes[511] - bse) / 4096;
    2b8d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2b90:	8b 90 fc 1f 00 00    	mov    edx,DWORD PTR [eax+0x1ffc]
    2b96:	8b 80 f8 1f 00 00    	mov    eax,DWORD PTR [eax+0x1ff8]
    2b9c:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2b9f:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2ba2:	0f ac d0 0c          	shrd   eax,edx,0xc
    2ba6:	c1 ea 0c             	shr    edx,0xc
    2ba9:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2bac:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2baf:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2bb6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2bb9:	01 d0                	add    eax,edx
    2bbb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2bbe:	83 ca 01             	or     edx,0x1
    2bc1:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2bc3:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2bc6:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2bcd:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2bd0:	01 d0                	add    eax,edx
    2bd2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2bd5:	83 ca 02             	or     edx,0x2
    2bd8:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2bda:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2bdd:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2be4:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2be7:	01 d0                	add    eax,edx
    2be9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2bec:	83 e2 fb             	and    edx,0xfffffffb
    2bef:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)n2 / 4096;
    2bf1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2bf4:	99                   	cdq
    2bf5:	0f ac d0 0c          	shrd   eax,edx,0xc
    2bf9:	c1 ea 0c             	shr    edx,0xc
    2bfc:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2bff:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2c06:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2c09:	01 d9                	add    ecx,ebx
    2c0b:	81 e2 ff 00 00 00    	and    edx,0xff
    2c11:	89 c3                	mov    ebx,eax
    2c13:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2c19:	89 de                	mov    esi,ebx
    2c1b:	c1 e6 0c             	shl    esi,0xc
    2c1e:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2c20:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2c26:	09 f3                	or     ebx,esi
    2c28:	89 19                	mov    DWORD PTR [ecx],ebx
    2c2a:	89 c3                	mov    ebx,eax
    2c2c:	c1 eb 14             	shr    ebx,0x14
    2c2f:	89 de                	mov    esi,ebx
    2c31:	66 81 e6 ff 0f       	and    si,0xfff
    2c36:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2c3a:	66 81 e3 00 f0       	and    bx,0xf000
    2c3f:	09 f3                	or     ebx,esi
    2c41:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2c45:	0f b6 c2             	movzx  eax,dl
    2c48:	c1 e0 0c             	shl    eax,0xc
    2c4b:	89 c2                	mov    edx,eax
    2c4d:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2c50:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2c55:	09 d0                	or     eax,edx
    2c57:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2c5a:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2c60:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2c63:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2c6a:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2c6d:	01 c8                	add    eax,ecx
    2c6f:	85 d2                	test   edx,edx
    2c71:	0f 95 c2             	setne  dl
    2c74:	89 d1                	mov    ecx,edx
    2c76:	c1 e1 07             	shl    ecx,0x7
    2c79:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2c7d:	83 e2 7f             	and    edx,0x7f
    2c80:	09 ca                	or     edx,ecx
    2c82:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		/* and finally the PTs */
		idx = (n1->pts[0] - bse) / 4096;
    2c85:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2c88:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2c8b:	8b 00                	mov    eax,DWORD PTR [eax]
    2c8d:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2c90:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2c93:	0f ac d0 0c          	shrd   eax,edx,0xc
    2c97:	c1 ea 0c             	shr    edx,0xc
    2c9a:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2c9d:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ca0:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2ca7:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2caa:	01 d0                	add    eax,edx
    2cac:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2caf:	83 ca 01             	or     edx,0x1
    2cb2:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2cb4:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2cb7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2cbe:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2cc1:	01 d0                	add    eax,edx
    2cc3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2cc6:	83 ca 02             	or     edx,0x2
    2cc9:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2ccb:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2cce:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2cd5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2cd8:	01 d0                	add    eax,edx
    2cda:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2cdd:	83 e2 fb             	and    edx,0xfffffffb
    2ce0:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt1 / 4096;
    2ce2:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2ce5:	99                   	cdq
    2ce6:	0f ac d0 0c          	shrd   eax,edx,0xc
    2cea:	c1 ea 0c             	shr    edx,0xc
    2ced:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2cf0:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2cf7:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2cfa:	01 d9                	add    ecx,ebx
    2cfc:	81 e2 ff 00 00 00    	and    edx,0xff
    2d02:	89 c3                	mov    ebx,eax
    2d04:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2d0a:	89 de                	mov    esi,ebx
    2d0c:	c1 e6 0c             	shl    esi,0xc
    2d0f:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2d11:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2d17:	09 f3                	or     ebx,esi
    2d19:	89 19                	mov    DWORD PTR [ecx],ebx
    2d1b:	89 c3                	mov    ebx,eax
    2d1d:	c1 eb 14             	shr    ebx,0x14
    2d20:	89 de                	mov    esi,ebx
    2d22:	66 81 e6 ff 0f       	and    si,0xfff
    2d27:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2d2b:	66 81 e3 00 f0       	and    bx,0xf000
    2d30:	09 f3                	or     ebx,esi
    2d32:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2d36:	0f b6 c2             	movzx  eax,dl
    2d39:	c1 e0 0c             	shl    eax,0xc
    2d3c:	89 c2                	mov    edx,eax
    2d3e:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2d41:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2d46:	09 d0                	or     eax,edx
    2d48:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2d4b:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2d51:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2d54:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2d5b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2d5e:	01 c8                	add    eax,ecx
    2d60:	85 d2                	test   edx,edx
    2d62:	0f 95 c2             	setne  dl
    2d65:	89 d1                	mov    ecx,edx
    2d67:	c1 e1 07             	shl    ecx,0x7
    2d6a:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2d6e:	83 e2 7f             	and    edx,0x7f
    2d71:	09 ca                	or     edx,ecx
    2d73:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		idx = (n2->pts[511] - bse) / 4096;
    2d76:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d79:	8b 90 fc 0f 00 00    	mov    edx,DWORD PTR [eax+0xffc]
    2d7f:	8b 80 f8 0f 00 00    	mov    eax,DWORD PTR [eax+0xff8]
    2d85:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2d88:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2d8b:	0f ac d0 0c          	shrd   eax,edx,0xc
    2d8f:	c1 ea 0c             	shr    edx,0xc
    2d92:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2d95:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2d98:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2d9f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2da2:	01 d0                	add    eax,edx
    2da4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2da7:	83 ca 01             	or     edx,0x1
    2daa:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2dac:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2daf:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2db6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2db9:	01 d0                	add    eax,edx
    2dbb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2dbe:	83 ca 02             	or     edx,0x2
    2dc1:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2dc3:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2dc6:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2dcd:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2dd0:	01 d0                	add    eax,edx
    2dd2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2dd5:	83 e2 fb             	and    edx,0xfffffffb
    2dd8:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt2 / 4096;
    2dda:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2ddd:	99                   	cdq
    2dde:	0f ac d0 0c          	shrd   eax,edx,0xc
    2de2:	c1 ea 0c             	shr    edx,0xc
    2de5:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2de8:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2def:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2df2:	01 d9                	add    ecx,ebx
    2df4:	81 e2 ff 00 00 00    	and    edx,0xff
    2dfa:	89 c3                	mov    ebx,eax
    2dfc:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2e02:	89 de                	mov    esi,ebx
    2e04:	c1 e6 0c             	shl    esi,0xc
    2e07:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2e09:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2e0f:	09 f3                	or     ebx,esi
    2e11:	89 19                	mov    DWORD PTR [ecx],ebx
    2e13:	89 c3                	mov    ebx,eax
    2e15:	c1 eb 14             	shr    ebx,0x14
    2e18:	89 de                	mov    esi,ebx
    2e1a:	66 81 e6 ff 0f       	and    si,0xfff
    2e1f:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2e23:	66 81 e3 00 f0       	and    bx,0xf000
    2e28:	09 f3                	or     ebx,esi
    2e2a:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2e2e:	0f b6 c2             	movzx  eax,dl
    2e31:	c1 e0 0c             	shl    eax,0xc
    2e34:	89 c2                	mov    edx,eax
    2e36:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2e39:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2e3e:	09 d0                	or     eax,edx
    2e40:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    2e43:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    2e49:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2e4c:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    2e53:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2e56:	01 c8                	add    eax,ecx
    2e58:	85 d2                	test   edx,edx
    2e5a:	0f 95 c2             	setne  dl
    2e5d:	89 d1                	mov    ecx,edx
    2e5f:	c1 e1 07             	shl    ecx,0x7
    2e62:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2e66:	83 e2 7f             	and    edx,0x7f
    2e69:	09 ca                	or     edx,ecx
    2e6b:	88 50 07             	mov    BYTE PTR [eax+0x7],dl

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
    2e6e:	83 ec 04             	sub    esp,0x4
    2e71:	6a 01                	push   0x1
    2e73:	8d 45 a0             	lea    eax,[ebp-0x60]
    2e76:	50                   	push   eax
    2e77:	6a 01                	push   0x1
    2e79:	e8 fc ff ff ff       	call   2e7a <mm_pg64_init+0x1447>
    2e7e:	83 c4 10             	add    esp,0x10
		pm_zero = pr.base;
    2e81:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2e84:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2e87:	a3 00 00 00 00       	mov    ds:0x0,eax
    2e8c:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
    2e92:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2e95:	a3 00 00 00 00       	mov    ds:0x0,eax
		pp->p = p;
    2e9a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2e9d:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2ea0:	89 10                	mov    DWORD PTR [eax],edx
		pp->p1 = p1;
    2ea2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ea5:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2ea8:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pp->p2 = p2;
    2eab:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2eae:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2eb1:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pp->pl1 = pl1;
    2eb4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2eb7:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2eba:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		pp->pl2 = pl2;
    2ebd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ec0:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2ec3:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		pp->pt1 = pt1;
    2ec6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ec9:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    2ecc:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pp->pt2 = pt2;
    2ecf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ed2:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    2ed5:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		pp->m1 = m1;
    2ed8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2edb:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2ede:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		pp->m2 = m2;
    2ee1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ee4:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2ee7:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
		pp->n1 = n1;
    2eea:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2eed:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    2ef0:	89 50 24             	mov    DWORD PTR [eax+0x24],edx
		pp->n2 = n2;
    2ef3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ef6:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    2ef9:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
}
    2efc:	90                   	nop
    2efd:	8d 65 f8             	lea    esp,[ebp-0x8]
    2f00:	5b                   	pop    ebx
    2f01:	5e                   	pop    esi
    2f02:	5d                   	pop    ebp
    2f03:	c3                   	ret

00002f04 <mm_pg36_init>:

void mm_pg36_init()
{
    2f04:	55                   	push   ebp
    2f05:	89 e5                	mov    ebp,esp
    2f07:	57                   	push   edi
    2f08:	56                   	push   esi
    2f09:	53                   	push   ebx
    2f0a:	83 ec 5c             	sub    esp,0x5c
		struct page_range pr;
		struct vm_pg_ptrs36* vp = vm_mapping;
    2f0d:	a1 00 00 00 00       	mov    eax,ds:0x0
    2f12:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		struct pm_pg36_ptrs* pp = (void*)(vp + 1);
    2f15:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f18:	05 4c 20 00 00       	add    eax,0x204c
    2f1d:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		struct pte64 *p[4], *pt1, *pt2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
    2f20:	68 4c 20 00 00       	push   0x204c
    2f25:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2f28:	e8 fc ff ff ff       	call   2f29 <mm_pg36_init+0x25>
    2f2d:	83 c4 08             	add    esp,0x8
		vp->cur = 0xfffff000;
    2f30:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f33:	c7 40 20 00 f0 ff ff 	mov    DWORD PTR [eax+0x20],0xfffff000
		bzero(pp, sizeof(*pp));
    2f3a:	68 20 02 00 00       	push   0x220
    2f3f:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    2f42:	e8 fc ff ff ff       	call   2f43 <mm_pg36_init+0x3f>
    2f47:	83 c4 08             	add    esp,0x8

		/* set CR3 to the base of vp */
		cr3_val = (uint64_t)vp;
    2f4a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f4d:	99                   	cdq
    2f4e:	a3 00 00 00 00       	mov    ds:0x0,eax
    2f53:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* get the 4 page directories */
		for (size_t i = 0; i < 4; i++) {
    2f59:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    2f60:	e9 e3 00 00 00       	jmp    3048 <mm_pg36_init+0x144>
				mm_alloc_pm(1, &pr, 1);
    2f65:	83 ec 04             	sub    esp,0x4
    2f68:	6a 01                	push   0x1
    2f6a:	8d 45 a8             	lea    eax,[ebp-0x58]
    2f6d:	50                   	push   eax
    2f6e:	6a 01                	push   0x1
    2f70:	e8 fc ff ff ff       	call   2f71 <mm_pg36_init+0x6d>
    2f75:	83 c4 10             	add    esp,0x10
				/* VM mapping */
				vp->pdp[i] = vp->cur;
    2f78:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f7b:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    2f7e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f81:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    2f84:	83 c1 08             	add    ecx,0x8
    2f87:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
				vp->cur -= 4096;
    2f8b:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f8e:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2f91:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    2f97:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2f9a:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				/* initialize the 32bt PDPT */
				vp->pdps[i].p = 1;
    2f9d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2fa0:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2fa3:	0f b6 0c d0          	movzx  ecx,BYTE PTR [eax+edx*8]
    2fa7:	83 c9 01             	or     ecx,0x1
    2faa:	88 0c d0             	mov    BYTE PTR [eax+edx*8],cl
				vp->pdps[i].w = 1;
    2fad:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2fb0:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2fb3:	0f b6 0c d0          	movzx  ecx,BYTE PTR [eax+edx*8]
    2fb7:	83 c9 02             	or     ecx,0x2
    2fba:	88 0c d0             	mov    BYTE PTR [eax+edx*8],cl
				vp->pdps[i].u = 1;
    2fbd:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2fc0:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2fc3:	0f b6 0c d0          	movzx  ecx,BYTE PTR [eax+edx*8]
    2fc7:	83 c9 04             	or     ecx,0x4
    2fca:	88 0c d0             	mov    BYTE PTR [eax+edx*8],cl
				vp->pdps[i].addr = pr.base / 4096;
    2fcd:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2fd0:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    2fd3:	0f ac d0 0c          	shrd   eax,edx,0xc
    2fd7:	c1 ea 0c             	shr    edx,0xc
    2fda:	81 e2 ff 00 00 00    	and    edx,0xff
    2fe0:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    2fe3:	8b 5d dc             	mov    ebx,DWORD PTR [ebp-0x24]
    2fe6:	89 c6                	mov    esi,eax
    2fe8:	81 e6 ff ff 0f 00    	and    esi,0xfffff
    2fee:	89 f7                	mov    edi,esi
    2ff0:	c1 e7 0c             	shl    edi,0xc
    2ff3:	8b 34 d9             	mov    esi,DWORD PTR [ecx+ebx*8]
    2ff6:	81 e6 ff 0f 00 00    	and    esi,0xfff
    2ffc:	09 fe                	or     esi,edi
    2ffe:	89 34 d9             	mov    DWORD PTR [ecx+ebx*8],esi
    3001:	89 c6                	mov    esi,eax
    3003:	c1 ee 14             	shr    esi,0x14
    3006:	89 f7                	mov    edi,esi
    3008:	66 81 e7 ff 0f       	and    di,0xfff
    300d:	0f b7 74 d9 04       	movzx  esi,WORD PTR [ecx+ebx*8+0x4]
    3012:	66 81 e6 00 f0       	and    si,0xf000
    3017:	09 fe                	or     esi,edi
    3019:	66 89 74 d9 04       	mov    WORD PTR [ecx+ebx*8+0x4],si
    301e:	0f b6 c2             	movzx  eax,dl
    3021:	c1 e0 0c             	shl    eax,0xc
    3024:	89 c2                	mov    edx,eax
    3026:	8b 44 d9 04          	mov    eax,DWORD PTR [ecx+ebx*8+0x4]
    302a:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    302f:	09 d0                	or     eax,edx
    3031:	89 44 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],eax
				/* and get the physical pointers */
				p[i] = (void*)pr.base;
    3035:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    3038:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    303b:	89 c2                	mov    edx,eax
    303d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3040:	89 54 85 98          	mov    DWORD PTR [ebp+eax*4-0x68],edx
		for (size_t i = 0; i < 4; i++) {
    3044:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    3048:	83 7d dc 03          	cmp    DWORD PTR [ebp-0x24],0x3
    304c:	0f 86 13 ff ff ff    	jbe    2f65 <mm_pg36_init+0x61>
		}


		/* create the VM mapping of the PDPTEs */
		uint32_t ct = mm_alloc_pm(2, &pr, 1); /* TODO check cont */
    3052:	83 ec 04             	sub    esp,0x4
    3055:	6a 01                	push   0x1
    3057:	8d 45 a8             	lea    eax,[ebp-0x58]
    305a:	50                   	push   eax
    305b:	6a 02                	push   0x2
    305d:	e8 fc ff ff ff       	call   305e <mm_pg36_init+0x15a>
    3062:	83 c4 10             	add    esp,0x10
    3065:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax

		/* now allocate the two page tables */
		for (size_t i = 0; i < 2048; i += 2047) { /* 0, 2047 */
    3068:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    306f:	e9 52 01 00 00       	jmp    31c6 <mm_pg36_init+0x2c2>
				struct pte64* pd = p[i / 512];
    3074:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3077:	c1 e8 09             	shr    eax,0x9
    307a:	8b 44 85 98          	mov    eax,DWORD PTR [ebp+eax*4-0x68]
    307e:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				mm_alloc_pm(1, &pr, 1);
    3081:	83 ec 04             	sub    esp,0x4
    3084:	6a 01                	push   0x1
    3086:	8d 45 a8             	lea    eax,[ebp-0x58]
    3089:	50                   	push   eax
    308a:	6a 01                	push   0x1
    308c:	e8 fc ff ff ff       	call   308d <mm_pg36_init+0x189>
    3091:	83 c4 10             	add    esp,0x10
				/* VM mapping */
				vp->pts[i] = vp->cur;
    3094:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3097:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    309a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    309d:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    30a0:	83 c1 0c             	add    ecx,0xc
    30a3:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
				vp->cur -= 4096;
    30a7:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    30aa:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    30ad:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    30b3:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    30b6:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				/* register in PD */
				pd[i % 512].p = 1;
    30b9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    30bc:	25 ff 01 00 00       	and    eax,0x1ff
    30c1:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    30c8:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    30cb:	01 d0                	add    eax,edx
    30cd:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    30d0:	83 ca 01             	or     edx,0x1
    30d3:	88 10                	mov    BYTE PTR [eax],dl
				pd[i % 512].w = 1;
    30d5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    30d8:	25 ff 01 00 00       	and    eax,0x1ff
    30dd:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    30e4:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    30e7:	01 d0                	add    eax,edx
    30e9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    30ec:	83 ca 02             	or     edx,0x2
    30ef:	88 10                	mov    BYTE PTR [eax],dl
				pd[i % 512].u = 0;
    30f1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    30f4:	25 ff 01 00 00       	and    eax,0x1ff
    30f9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3100:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3103:	01 d0                	add    eax,edx
    3105:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3108:	83 e2 fb             	and    edx,0xfffffffb
    310b:	88 10                	mov    BYTE PTR [eax],dl
				pd[i % 512].xd = 0; /* TODO: XD on PT1? */
    310d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3110:	25 ff 01 00 00       	and    eax,0x1ff
    3115:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    311c:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    311f:	01 d0                	add    eax,edx
    3121:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    3125:	83 e2 7f             	and    edx,0x7f
    3128:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				pd[i % 512].addr = pr.base / 4096;
    312b:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    312e:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    3131:	0f ac d0 0c          	shrd   eax,edx,0xc
    3135:	c1 ea 0c             	shr    edx,0xc
    3138:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    313b:	81 e1 ff 01 00 00    	and    ecx,0x1ff
    3141:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    3148:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    314b:	01 d9                	add    ecx,ebx
    314d:	81 e2 ff 00 00 00    	and    edx,0xff
    3153:	89 c3                	mov    ebx,eax
    3155:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    315b:	89 de                	mov    esi,ebx
    315d:	c1 e6 0c             	shl    esi,0xc
    3160:	8b 19                	mov    ebx,DWORD PTR [ecx]
    3162:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3168:	09 f3                	or     ebx,esi
    316a:	89 19                	mov    DWORD PTR [ecx],ebx
    316c:	89 c3                	mov    ebx,eax
    316e:	c1 eb 14             	shr    ebx,0x14
    3171:	89 de                	mov    esi,ebx
    3173:	66 81 e6 ff 0f       	and    si,0xfff
    3178:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    317c:	66 81 e3 00 f0       	and    bx,0xf000
    3181:	09 f3                	or     ebx,esi
    3183:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3187:	0f b6 c2             	movzx  eax,dl
    318a:	c1 e0 0c             	shl    eax,0xc
    318d:	89 c2                	mov    edx,eax
    318f:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    3192:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3197:	09 d0                	or     eax,edx
    3199:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				/* get the physical pointers */
				if (!i)
    319c:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    31a0:	75 0b                	jne    31ad <mm_pg36_init+0x2a9>
						pt1 = (void*)pr.base;
    31a2:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    31a5:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    31a8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    31ab:	eb 12                	jmp    31bf <mm_pg36_init+0x2bb>
				else if (i == 2047)
    31ad:	81 7d d8 ff 07 00 00 	cmp    DWORD PTR [ebp-0x28],0x7ff
    31b4:	75 09                	jne    31bf <mm_pg36_init+0x2bb>
						pt2 = (void*)pr.base;
    31b6:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    31b9:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    31bc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		for (size_t i = 0; i < 2048; i += 2047) { /* 0, 2047 */
    31bf:	81 45 d8 ff 07 00 00 	add    DWORD PTR [ebp-0x28],0x7ff
    31c6:	81 7d d8 ff 07 00 00 	cmp    DWORD PTR [ebp-0x28],0x7ff
    31cd:	0f 86 a1 fe ff ff    	jbe    3074 <mm_pg36_init+0x170>
		}

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
    31d3:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    31da:	e9 b0 00 00 00       	jmp    328f <mm_pg36_init+0x38b>
				/* identity CD */
				pt1[i].p = 1;
    31df:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    31e2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    31e9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    31ec:	01 d0                	add    eax,edx
    31ee:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    31f1:	83 ca 01             	or     edx,0x1
    31f4:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].w = 1;
    31f6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    31f9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3200:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3203:	01 d0                	add    eax,edx
    3205:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3208:	83 ca 02             	or     edx,0x2
    320b:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].u = 0;
    320d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3210:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3217:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    321a:	01 d0                	add    eax,edx
    321c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    321f:	83 e2 fb             	and    edx,0xfffffffb
    3222:	88 10                	mov    BYTE PTR [eax],dl
				//pt1[i].xd = 1;
				pt1[i].addr = i; /* identity */
    3224:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3227:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    322e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3231:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3234:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3237:	ba 00 00 00 00       	mov    edx,0x0
    323c:	81 e2 ff 00 00 00    	and    edx,0xff
    3242:	89 c3                	mov    ebx,eax
    3244:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    324a:	89 de                	mov    esi,ebx
    324c:	c1 e6 0c             	shl    esi,0xc
    324f:	8b 19                	mov    ebx,DWORD PTR [ecx]
    3251:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3257:	09 f3                	or     ebx,esi
    3259:	89 19                	mov    DWORD PTR [ecx],ebx
    325b:	89 c3                	mov    ebx,eax
    325d:	c1 eb 14             	shr    ebx,0x14
    3260:	89 de                	mov    esi,ebx
    3262:	66 81 e6 ff 0f       	and    si,0xfff
    3267:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    326b:	66 81 e3 00 f0       	and    bx,0xf000
    3270:	09 f3                	or     ebx,esi
    3272:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3276:	0f b6 c2             	movzx  eax,dl
    3279:	c1 e0 0c             	shl    eax,0xc
    327c:	89 c2                	mov    edx,eax
    327e:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    3281:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3286:	09 d0                	or     eax,edx
    3288:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		for (size_t i = 0; i < 256; i++) {
    328b:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
    328f:	81 7d d4 ff 00 00 00 	cmp    DWORD PTR [ebp-0x2c],0xff
    3296:	0f 86 43 ff ff ff    	jbe    31df <mm_pg36_init+0x2db>
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint32_t bse = 0xffe00000; /* base of last PT */
    329c:	c7 45 bc 00 00 e0 ff 	mov    DWORD PTR [ebp-0x44],0xffe00000
		size_t idx;
		/* first the four PDs */
		for (size_t i = 0; i < 4; i++) {
    32a3:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    32aa:	e9 f7 00 00 00       	jmp    33a6 <mm_pg36_init+0x4a2>
				idx = (vp->pdp[i] - bse) / 4096;
    32af:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    32b2:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    32b5:	83 c2 08             	add    edx,0x8
    32b8:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    32bc:	2b 45 bc             	sub    eax,DWORD PTR [ebp-0x44]
    32bf:	c1 e8 0c             	shr    eax,0xc
    32c2:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				pt2[idx].p = 1;
    32c5:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    32c8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    32cf:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    32d2:	01 d0                	add    eax,edx
    32d4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    32d7:	83 ca 01             	or     edx,0x1
    32da:	88 10                	mov    BYTE PTR [eax],dl
				pt2[idx].w = 1;
    32dc:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    32df:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    32e6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    32e9:	01 d0                	add    eax,edx
    32eb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    32ee:	83 ca 02             	or     edx,0x2
    32f1:	88 10                	mov    BYTE PTR [eax],dl
				pt2[idx].u = 0; /* only supervisor access to pts */
    32f3:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    32f6:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    32fd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3300:	01 d0                	add    eax,edx
    3302:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3305:	83 e2 fb             	and    edx,0xfffffffb
    3308:	88 10                	mov    BYTE PTR [eax],dl
				pt2[idx].addr = (uint64_t)p[i] / 4096;
    330a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    330d:	8b 44 85 98          	mov    eax,DWORD PTR [ebp+eax*4-0x68]
    3311:	99                   	cdq
    3312:	0f ac d0 0c          	shrd   eax,edx,0xc
    3316:	c1 ea 0c             	shr    edx,0xc
    3319:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
    331c:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    3323:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    3326:	01 d9                	add    ecx,ebx
    3328:	81 e2 ff 00 00 00    	and    edx,0xff
    332e:	89 c3                	mov    ebx,eax
    3330:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    3336:	89 de                	mov    esi,ebx
    3338:	c1 e6 0c             	shl    esi,0xc
    333b:	8b 19                	mov    ebx,DWORD PTR [ecx]
    333d:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3343:	09 f3                	or     ebx,esi
    3345:	89 19                	mov    DWORD PTR [ecx],ebx
    3347:	89 c3                	mov    ebx,eax
    3349:	c1 eb 14             	shr    ebx,0x14
    334c:	89 de                	mov    esi,ebx
    334e:	66 81 e6 ff 0f       	and    si,0xfff
    3353:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    3357:	66 81 e3 00 f0       	and    bx,0xf000
    335c:	09 f3                	or     ebx,esi
    335e:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3362:	0f b6 c2             	movzx  eax,dl
    3365:	c1 e0 0c             	shl    eax,0xc
    3368:	89 c2                	mov    edx,eax
    336a:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    336d:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3372:	09 d0                	or     eax,edx
    3374:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt2[idx].xd = (has_nx ? 1 : 0);
    3377:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    337d:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3380:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    3387:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    338a:	01 c8                	add    eax,ecx
    338c:	85 d2                	test   edx,edx
    338e:	0f 95 c2             	setne  dl
    3391:	89 d1                	mov    ecx,edx
    3393:	c1 e1 07             	shl    ecx,0x7
    3396:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    339a:	83 e2 7f             	and    edx,0x7f
    339d:	09 ca                	or     edx,ecx
    339f:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		for (size_t i = 0; i < 4; i++) {
    33a2:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
    33a6:	83 7d d0 03          	cmp    DWORD PTR [ebp-0x30],0x3
    33aa:	0f 86 ff fe ff ff    	jbe    32af <mm_pg36_init+0x3ab>
		}
		/* vp is identity mapped -> no need for doing sth.
		 * (TODO: protection) */

		/* then the 2 PTs */
		idx = (vp->pts[0] - bse) / 4096;
    33b0:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    33b3:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    33b6:	2b 45 bc             	sub    eax,DWORD PTR [ebp-0x44]
    33b9:	c1 e8 0c             	shr    eax,0xc
    33bc:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
		pt2[idx].p = 1;
    33bf:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    33c2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    33c9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    33cc:	01 d0                	add    eax,edx
    33ce:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    33d1:	83 ca 01             	or     edx,0x1
    33d4:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    33d6:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    33d9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    33e0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    33e3:	01 d0                	add    eax,edx
    33e5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    33e8:	83 ca 02             	or     edx,0x2
    33eb:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    33ed:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    33f0:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    33f7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    33fa:	01 d0                	add    eax,edx
    33fc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    33ff:	83 e2 fb             	and    edx,0xfffffffb
    3402:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt1 / 4096;
    3404:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3407:	99                   	cdq
    3408:	0f ac d0 0c          	shrd   eax,edx,0xc
    340c:	c1 ea 0c             	shr    edx,0xc
    340f:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
    3412:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    3419:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    341c:	01 d9                	add    ecx,ebx
    341e:	81 e2 ff 00 00 00    	and    edx,0xff
    3424:	89 c3                	mov    ebx,eax
    3426:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    342c:	89 de                	mov    esi,ebx
    342e:	c1 e6 0c             	shl    esi,0xc
    3431:	8b 19                	mov    ebx,DWORD PTR [ecx]
    3433:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3439:	09 f3                	or     ebx,esi
    343b:	89 19                	mov    DWORD PTR [ecx],ebx
    343d:	89 c3                	mov    ebx,eax
    343f:	c1 eb 14             	shr    ebx,0x14
    3442:	89 de                	mov    esi,ebx
    3444:	66 81 e6 ff 0f       	and    si,0xfff
    3449:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    344d:	66 81 e3 00 f0       	and    bx,0xf000
    3452:	09 f3                	or     ebx,esi
    3454:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3458:	0f b6 c2             	movzx  eax,dl
    345b:	c1 e0 0c             	shl    eax,0xc
    345e:	89 c2                	mov    edx,eax
    3460:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    3463:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3468:	09 d0                	or     eax,edx
    346a:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    346d:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    3473:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3476:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    347d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3480:	01 c8                	add    eax,ecx
    3482:	85 d2                	test   edx,edx
    3484:	0f 95 c2             	setne  dl
    3487:	89 d1                	mov    ecx,edx
    3489:	c1 e1 07             	shl    ecx,0x7
    348c:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    3490:	83 e2 7f             	and    edx,0x7f
    3493:	09 ca                	or     edx,ecx
    3495:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
		idx = (vp->pts[2047] - bse) / 4096;
    3498:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    349b:	8b 80 30 20 00 00    	mov    eax,DWORD PTR [eax+0x2030]
    34a1:	2b 45 bc             	sub    eax,DWORD PTR [ebp-0x44]
    34a4:	c1 e8 0c             	shr    eax,0xc
    34a7:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
		pt2[idx].p = 1;
    34aa:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    34ad:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    34b4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    34b7:	01 d0                	add    eax,edx
    34b9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    34bc:	83 ca 01             	or     edx,0x1
    34bf:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    34c1:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    34c4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    34cb:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    34ce:	01 d0                	add    eax,edx
    34d0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    34d3:	83 ca 02             	or     edx,0x2
    34d6:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    34d8:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    34db:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    34e2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    34e5:	01 d0                	add    eax,edx
    34e7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    34ea:	83 e2 fb             	and    edx,0xfffffffb
    34ed:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt2 / 4096;
    34ef:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    34f2:	99                   	cdq
    34f3:	0f ac d0 0c          	shrd   eax,edx,0xc
    34f7:	c1 ea 0c             	shr    edx,0xc
    34fa:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
    34fd:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    3504:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    3507:	01 d9                	add    ecx,ebx
    3509:	81 e2 ff 00 00 00    	and    edx,0xff
    350f:	89 c3                	mov    ebx,eax
    3511:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    3517:	89 de                	mov    esi,ebx
    3519:	c1 e6 0c             	shl    esi,0xc
    351c:	8b 19                	mov    ebx,DWORD PTR [ecx]
    351e:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3524:	09 f3                	or     ebx,esi
    3526:	89 19                	mov    DWORD PTR [ecx],ebx
    3528:	89 c3                	mov    ebx,eax
    352a:	c1 eb 14             	shr    ebx,0x14
    352d:	89 de                	mov    esi,ebx
    352f:	66 81 e6 ff 0f       	and    si,0xfff
    3534:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    3538:	66 81 e3 00 f0       	and    bx,0xf000
    353d:	09 f3                	or     ebx,esi
    353f:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3543:	0f b6 c2             	movzx  eax,dl
    3546:	c1 e0 0c             	shl    eax,0xc
    3549:	89 c2                	mov    edx,eax
    354b:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    354e:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3553:	09 d0                	or     eax,edx
    3555:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx].xd = (has_nx ? 1 : 0);
    3558:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    355e:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3561:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    3568:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    356b:	01 c8                	add    eax,ecx
    356d:	85 d2                	test   edx,edx
    356f:	0f 95 c2             	setne  dl
    3572:	89 d1                	mov    ecx,edx
    3574:	c1 e1 07             	shl    ecx,0x7
    3577:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    357b:	83 e2 7f             	and    edx,0x7f
    357e:	09 ca                	or     edx,ecx
    3580:	88 50 07             	mov    BYTE PTR [eax+0x7],dl

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
    3583:	83 ec 04             	sub    esp,0x4
    3586:	6a 01                	push   0x1
    3588:	8d 45 a8             	lea    eax,[ebp-0x58]
    358b:	50                   	push   eax
    358c:	6a 01                	push   0x1
    358e:	e8 fc ff ff ff       	call   358f <mm_pg36_init+0x68b>
    3593:	83 c4 10             	add    esp,0x10
		pm_zero = pr.base;
    3596:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    3599:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    359c:	a3 00 00 00 00       	mov    ds:0x0,eax
    35a1:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
    35a7:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    35aa:	a3 00 00 00 00       	mov    ds:0x0,eax
		pp->p = vp->pdps;
    35af:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    35b2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    35b5:	89 10                	mov    DWORD PTR [eax],edx
		for (size_t i = 0; i < 4; i++)
    35b7:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    35be:	eb 15                	jmp    35d5 <mm_pg36_init+0x6d1>
				pp->pds[i] = p[i];
    35c0:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    35c3:	8b 4c 85 98          	mov    ecx,DWORD PTR [ebp+eax*4-0x68]
    35c7:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    35ca:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    35cd:	89 4c 90 04          	mov    DWORD PTR [eax+edx*4+0x4],ecx
		for (size_t i = 0; i < 4; i++)
    35d1:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
    35d5:	83 7d cc 03          	cmp    DWORD PTR [ebp-0x34],0x3
    35d9:	76 e5                	jbe    35c0 <mm_pg36_init+0x6bc>
		pp->pt1 = pt1;
    35db:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    35de:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    35e1:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pp->pt2 = pt2;
    35e4:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    35e7:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    35ea:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
}
    35ed:	90                   	nop
    35ee:	8d 65 f4             	lea    esp,[ebp-0xc]
    35f1:	5b                   	pop    ebx
    35f2:	5e                   	pop    esi
    35f3:	5f                   	pop    edi
    35f4:	5d                   	pop    ebp
    35f5:	c3                   	ret

000035f6 <mm_pg32_init>:

void mm_pg32_init()
{
    35f6:	55                   	push   ebp
    35f7:	89 e5                	mov    ebp,esp
    35f9:	53                   	push   ebx
    35fa:	83 ec 34             	sub    esp,0x34
		struct page_range pr;
		struct vm_pg_ptrs32* vp = vm_mapping;
    35fd:	a1 00 00 00 00       	mov    eax,ds:0x0
    3602:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct pm_pg32_ptrs* pp = (void*)(vp + 1);
    3605:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3608:	05 20 10 00 00       	add    eax,0x1020
    360d:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		struct pte32 *pd, *pt1, *pt2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
    3610:	68 20 10 00 00       	push   0x1020
    3615:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    3618:	e8 fc ff ff ff       	call   3619 <mm_pg32_init+0x23>
    361d:	83 c4 08             	add    esp,0x8
		vp->cur = 0xfffff000;
    3620:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3623:	c7 00 00 f0 ff ff    	mov    DWORD PTR [eax],0xfffff000
		bzero(pp, sizeof(*pp));
    3629:	68 10 02 00 00       	push   0x210
    362e:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    3631:	e8 fc ff ff ff       	call   3632 <mm_pg32_init+0x3c>
    3636:	83 c4 08             	add    esp,0x8

		/* allocate the PD */
		mm_alloc_pm(1, &pr, 1);
    3639:	83 ec 04             	sub    esp,0x4
    363c:	6a 01                	push   0x1
    363e:	8d 45 c8             	lea    eax,[ebp-0x38]
    3641:	50                   	push   eax
    3642:	6a 01                	push   0x1
    3644:	e8 fc ff ff ff       	call   3645 <mm_pg32_init+0x4f>
    3649:	83 c4 10             	add    esp,0x10
		vp->pd = vp->cur;
    364c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    364f:	8b 10                	mov    edx,DWORD PTR [eax]
    3651:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3654:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		vp->cur -= 4096;
    3657:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    365a:	8b 00                	mov    eax,DWORD PTR [eax]
    365c:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    3662:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3665:	89 10                	mov    DWORD PTR [eax],edx

		/* set CR3 to its base */
		cr3_val = pr.base;
    3667:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    366a:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    366d:	a3 00 00 00 00       	mov    ds:0x0,eax
    3672:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		pd = (void*)pr.base;
    3678:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    367b:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    367e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* now allocate the two page tables */
		for (size_t i = 0; i < 1024; i += 1023) { /* 0, 1023 */
    3681:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    3688:	e9 d2 00 00 00       	jmp    375f <mm_pg32_init+0x169>
				mm_alloc_pm(1, &pr, 1);
    368d:	83 ec 04             	sub    esp,0x4
    3690:	6a 01                	push   0x1
    3692:	8d 45 c8             	lea    eax,[ebp-0x38]
    3695:	50                   	push   eax
    3696:	6a 01                	push   0x1
    3698:	e8 fc ff ff ff       	call   3699 <mm_pg32_init+0xa3>
    369d:	83 c4 10             	add    esp,0x10
				/* VM mapping */
				vp->pts[i] = vp->cur;
    36a0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    36a3:	8b 08                	mov    ecx,DWORD PTR [eax]
    36a5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    36a8:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    36ab:	89 4c 90 08          	mov    DWORD PTR [eax+edx*4+0x8],ecx
				vp->cur -= 4096;
    36af:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    36b2:	8b 00                	mov    eax,DWORD PTR [eax]
    36b4:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    36ba:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    36bd:	89 10                	mov    DWORD PTR [eax],edx
				/* register in PD */
				pd[i].p = 1;
    36bf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    36c2:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    36c9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    36cc:	01 d0                	add    eax,edx
    36ce:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    36d1:	83 ca 01             	or     edx,0x1
    36d4:	88 10                	mov    BYTE PTR [eax],dl
				pd[i].w = 1;
    36d6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    36d9:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    36e0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    36e3:	01 d0                	add    eax,edx
    36e5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    36e8:	83 ca 02             	or     edx,0x2
    36eb:	88 10                	mov    BYTE PTR [eax],dl
				pd[i].u = 0;
    36ed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    36f0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    36f7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    36fa:	01 d0                	add    eax,edx
    36fc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    36ff:	83 e2 fb             	and    edx,0xfffffffb
    3702:	88 10                	mov    BYTE PTR [eax],dl
				pd[i].addr = pr.base / 4096;
    3704:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3707:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    370a:	0f ac d0 0c          	shrd   eax,edx,0xc
    370e:	c1 ea 0c             	shr    edx,0xc
    3711:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    3714:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
    371b:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    371e:	01 d9                	add    ecx,ebx
    3720:	25 ff ff 0f 00       	and    eax,0xfffff
    3725:	c1 e0 0c             	shl    eax,0xc
    3728:	89 c2                	mov    edx,eax
    372a:	8b 01                	mov    eax,DWORD PTR [ecx]
    372c:	25 ff 0f 00 00       	and    eax,0xfff
    3731:	09 d0                	or     eax,edx
    3733:	89 01                	mov    DWORD PTR [ecx],eax
				/* get the physical pointers */
				if (!i)
    3735:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    3739:	75 0b                	jne    3746 <mm_pg32_init+0x150>
						pt1 = (void*)pr.base;
    373b:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    373e:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3741:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    3744:	eb 12                	jmp    3758 <mm_pg32_init+0x162>
				else if (i == 1023)
    3746:	81 7d ec ff 03 00 00 	cmp    DWORD PTR [ebp-0x14],0x3ff
    374d:	75 09                	jne    3758 <mm_pg32_init+0x162>
						pt2 = (void*)pr.base;
    374f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3752:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3755:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		for (size_t i = 0; i < 1024; i += 1023) { /* 0, 1023 */
    3758:	81 45 ec ff 03 00 00 	add    DWORD PTR [ebp-0x14],0x3ff
    375f:	81 7d ec ff 03 00 00 	cmp    DWORD PTR [ebp-0x14],0x3ff
    3766:	0f 86 21 ff ff ff    	jbe    368d <mm_pg32_init+0x97>
		}

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
    376c:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    3773:	eb 72                	jmp    37e7 <mm_pg32_init+0x1f1>
				/* identity CD */
				pt1[i].p = 1;
    3775:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3778:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    377f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3782:	01 d0                	add    eax,edx
    3784:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3787:	83 ca 01             	or     edx,0x1
    378a:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].w = 1;
    378c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    378f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3796:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3799:	01 d0                	add    eax,edx
    379b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    379e:	83 ca 02             	or     edx,0x2
    37a1:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].u = 0;
    37a3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    37a6:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    37ad:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    37b0:	01 d0                	add    eax,edx
    37b2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    37b5:	83 e2 fb             	and    edx,0xfffffffb
    37b8:	88 10                	mov    BYTE PTR [eax],dl
				//pt1[i].xd = 1; <- NOT in 32-bit paging
				pt1[i].addr = i; /* identity */
    37ba:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    37bd:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    37c4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    37c7:	01 d0                	add    eax,edx
    37c9:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    37cc:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    37d2:	89 d1                	mov    ecx,edx
    37d4:	c1 e1 0c             	shl    ecx,0xc
    37d7:	8b 10                	mov    edx,DWORD PTR [eax]
    37d9:	81 e2 ff 0f 00 00    	and    edx,0xfff
    37df:	09 ca                	or     edx,ecx
    37e1:	89 10                	mov    DWORD PTR [eax],edx
		for (size_t i = 0; i < 256; i++) {
    37e3:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
    37e7:	81 7d e8 ff 00 00 00 	cmp    DWORD PTR [ebp-0x18],0xff
    37ee:	76 85                	jbe    3775 <mm_pg32_init+0x17f>
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint32_t bse = 0xffc00000; /* base of last PT */
    37f0:	c7 45 d8 00 00 c0 ff 	mov    DWORD PTR [ebp-0x28],0xffc00000
		size_t idx;
		/* first the PD */
		idx = (vp->pd - bse) / 4096;
    37f7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37fa:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    37fd:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    3800:	c1 e8 0c             	shr    eax,0xc
    3803:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		pt2[idx].p = 1;
    3806:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3809:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3810:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3813:	01 d0                	add    eax,edx
    3815:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3818:	83 ca 01             	or     edx,0x1
    381b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    381d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3820:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3827:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    382a:	01 d0                	add    eax,edx
    382c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    382f:	83 ca 02             	or     edx,0x2
    3832:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0; /* only supervisor access to pts */
    3834:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3837:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    383e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3841:	01 d0                	add    eax,edx
    3843:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3846:	83 e2 fb             	and    edx,0xfffffffb
    3849:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint32_t)pd / 4096;
    384b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    384e:	c1 e8 0c             	shr    eax,0xc
    3851:	89 c2                	mov    edx,eax
    3853:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3856:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    385d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3860:	01 c8                	add    eax,ecx
    3862:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    3868:	89 d1                	mov    ecx,edx
    386a:	c1 e1 0c             	shl    ecx,0xc
    386d:	8b 10                	mov    edx,DWORD PTR [eax]
    386f:	81 e2 ff 0f 00 00    	and    edx,0xfff
    3875:	09 ca                	or     edx,ecx
    3877:	89 10                	mov    DWORD PTR [eax],edx
		/* vp is identity mapped -> no need for doing sth.
		 * (TODO: protection) */

		/* then the 2 PTs */
		idx = (vp->pts[0] - bse) / 4096;
    3879:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    387c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    387f:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    3882:	c1 e8 0c             	shr    eax,0xc
    3885:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		pt2[idx].p = 1;
    3888:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    388b:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3892:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3895:	01 d0                	add    eax,edx
    3897:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    389a:	83 ca 01             	or     edx,0x1
    389d:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    389f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    38a2:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    38a9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    38ac:	01 d0                	add    eax,edx
    38ae:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    38b1:	83 ca 02             	or     edx,0x2
    38b4:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    38b6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    38b9:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    38c0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    38c3:	01 d0                	add    eax,edx
    38c5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    38c8:	83 e2 fb             	and    edx,0xfffffffb
    38cb:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint32_t)pt1 / 4096;
    38cd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    38d0:	c1 e8 0c             	shr    eax,0xc
    38d3:	89 c2                	mov    edx,eax
    38d5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    38d8:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    38df:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    38e2:	01 c8                	add    eax,ecx
    38e4:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    38ea:	89 d1                	mov    ecx,edx
    38ec:	c1 e1 0c             	shl    ecx,0xc
    38ef:	8b 10                	mov    edx,DWORD PTR [eax]
    38f1:	81 e2 ff 0f 00 00    	and    edx,0xfff
    38f7:	09 ca                	or     edx,ecx
    38f9:	89 10                	mov    DWORD PTR [eax],edx
		idx = (vp->pts[1023] - bse) / 4096;
    38fb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    38fe:	8b 80 04 10 00 00    	mov    eax,DWORD PTR [eax+0x1004]
    3904:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    3907:	c1 e8 0c             	shr    eax,0xc
    390a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		pt2[idx].p = 1;
    390d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3910:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3917:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    391a:	01 d0                	add    eax,edx
    391c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    391f:	83 ca 01             	or     edx,0x1
    3922:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    3924:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3927:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    392e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3931:	01 d0                	add    eax,edx
    3933:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3936:	83 ca 02             	or     edx,0x2
    3939:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    393b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    393e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3945:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3948:	01 d0                	add    eax,edx
    394a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    394d:	83 e2 fb             	and    edx,0xfffffffb
    3950:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint32_t)pt2 / 4096;
    3952:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3955:	c1 e8 0c             	shr    eax,0xc
    3958:	89 c2                	mov    edx,eax
    395a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    395d:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    3964:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3967:	01 c8                	add    eax,ecx
    3969:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    396f:	89 d1                	mov    ecx,edx
    3971:	c1 e1 0c             	shl    ecx,0xc
    3974:	8b 10                	mov    edx,DWORD PTR [eax]
    3976:	81 e2 ff 0f 00 00    	and    edx,0xfff
    397c:	09 ca                	or     edx,ecx
    397e:	89 10                	mov    DWORD PTR [eax],edx

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
    3980:	83 ec 04             	sub    esp,0x4
    3983:	6a 01                	push   0x1
    3985:	8d 45 c8             	lea    eax,[ebp-0x38]
    3988:	50                   	push   eax
    3989:	6a 01                	push   0x1
    398b:	e8 fc ff ff ff       	call   398c <mm_pg32_init+0x396>
    3990:	83 c4 10             	add    esp,0x10
		pm_zero = pr.base;
    3993:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3996:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3999:	a3 00 00 00 00       	mov    ds:0x0,eax
    399e:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
    39a4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    39a7:	a3 00 00 00 00       	mov    ds:0x0,eax
		pp->pd = pd;
    39ac:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    39af:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    39b2:	89 10                	mov    DWORD PTR [eax],edx
		pp->pt1 = pt1;
    39b4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    39b7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    39ba:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pp->pt2 = pt2;
    39bd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    39c0:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    39c3:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
}
    39c6:	90                   	nop
    39c7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    39ca:	c9                   	leave
    39cb:	c3                   	ret

000039cc <mm_prepare_paging>:

void mm_prepare_paging(int mode)
{
    39cc:	55                   	push   ebp
    39cd:	89 e5                	mov    ebp,esp
    39cf:	83 ec 08             	sub    esp,0x8
		if (!mode)
    39d2:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    39d6:	75 07                	jne    39df <mm_prepare_paging+0x13>
				mm_pg32_init();
    39d8:	e8 fc ff ff ff       	call   39d9 <mm_prepare_paging+0xd>
		else if (mode == 1)
				mm_pg36_init();
		else
				mm_pg64_init();
}
    39dd:	eb 12                	jmp    39f1 <mm_prepare_paging+0x25>
		else if (mode == 1)
    39df:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    39e3:	75 07                	jne    39ec <mm_prepare_paging+0x20>
				mm_pg36_init();
    39e5:	e8 fc ff ff ff       	call   39e6 <mm_prepare_paging+0x1a>
}
    39ea:	eb 05                	jmp    39f1 <mm_prepare_paging+0x25>
				mm_pg64_init();
    39ec:	e8 fc ff ff ff       	call   39ed <mm_prepare_paging+0x21>
}
    39f1:	90                   	nop
    39f2:	c9                   	leave
    39f3:	c3                   	ret

000039f4 <mm_initialize>:

void mm_initialize(int mode, int nx)
{
    39f4:	55                   	push   ebp
    39f5:	89 e5                	mov    ebp,esp
    39f7:	57                   	push   edi
    39f8:	56                   	push   esi
    39f9:	53                   	push   ebx
    39fa:	83 ec 2c             	sub    esp,0x2c
		/* prepare the BIOS-provided memory map */
		struct mp* map = mem_map;
    39fd:	c7 45 e4 00 00 02 00 	mov    DWORD PTR [ebp-0x1c],0x20000
		has_nx = nx ? 1 : 0;
    3a04:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    3a08:	0f 95 c0             	setne  al
    3a0b:	0f b6 c0             	movzx  eax,al
    3a0e:	a3 00 00 00 00       	mov    ds:0x0,eax
		do {
				if (map->type == 1)
    3a13:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a16:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3a19:	83 f8 01             	cmp    eax,0x1
    3a1c:	75 1f                	jne    3a3d <mm_initialize+0x49>
						mm_add_free(map->base, map->size);
    3a1e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a21:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    3a24:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    3a27:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a2a:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3a2d:	8b 00                	mov    eax,DWORD PTR [eax]
    3a2f:	53                   	push   ebx
    3a30:	51                   	push   ecx
    3a31:	52                   	push   edx
    3a32:	50                   	push   eax
    3a33:	e8 fc ff ff ff       	call   3a34 <mm_initialize+0x40>
    3a38:	83 c4 10             	add    esp,0x10
    3a3b:	eb 1d                	jmp    3a5a <mm_initialize+0x66>
				else
						mm_add_reserved(map->base, map->size);
    3a3d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a40:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    3a43:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    3a46:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a49:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3a4c:	8b 00                	mov    eax,DWORD PTR [eax]
    3a4e:	53                   	push   ebx
    3a4f:	51                   	push   ecx
    3a50:	52                   	push   edx
    3a51:	50                   	push   eax
    3a52:	e8 fc ff ff ff       	call   3a53 <mm_initialize+0x5f>
    3a57:	83 c4 10             	add    esp,0x10
				map++;
    3a5a:	83 45 e4 18          	add    DWORD PTR [ebp-0x1c],0x18
		} while (map->base || map->size || map->type);
    3a5e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a61:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3a64:	8b 00                	mov    eax,DWORD PTR [eax]
    3a66:	89 c1                	mov    ecx,eax
    3a68:	89 c8                	mov    eax,ecx
    3a6a:	09 d0                	or     eax,edx
    3a6c:	75 a5                	jne    3a13 <mm_initialize+0x1f>
    3a6e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a71:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3a74:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3a77:	89 c1                	mov    ecx,eax
    3a79:	89 c8                	mov    eax,ecx
    3a7b:	09 d0                	or     eax,edx
    3a7d:	75 94                	jne    3a13 <mm_initialize+0x1f>
    3a7f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a82:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3a85:	85 c0                	test   eax,eax
    3a87:	75 8a                	jne    3a13 <mm_initialize+0x1f>

		/* now remove overlapping entries */
		map = mem_map;
    3a89:	c7 45 e4 00 00 02 00 	mov    DWORD PTR [ebp-0x1c],0x20000
		do {
				if (map->type != 1)
    3a90:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a93:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3a96:	83 f8 01             	cmp    eax,0x1
    3a99:	74 1d                	je     3ab8 <mm_initialize+0xc4>
						mm_sub_block(map->base, map->size);
    3a9b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3a9e:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    3aa1:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    3aa4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3aa7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3aaa:	8b 00                	mov    eax,DWORD PTR [eax]
    3aac:	53                   	push   ebx
    3aad:	51                   	push   ecx
    3aae:	52                   	push   edx
    3aaf:	50                   	push   eax
    3ab0:	e8 fc ff ff ff       	call   3ab1 <mm_initialize+0xbd>
    3ab5:	83 c4 10             	add    esp,0x10
				map++;
    3ab8:	83 45 e4 18          	add    DWORD PTR [ebp-0x1c],0x18
		} while (map->base || map->size || map->type);
    3abc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3abf:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3ac2:	8b 00                	mov    eax,DWORD PTR [eax]
    3ac4:	89 c1                	mov    ecx,eax
    3ac6:	89 c8                	mov    eax,ecx
    3ac8:	09 d0                	or     eax,edx
    3aca:	75 c4                	jne    3a90 <mm_initialize+0x9c>
    3acc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3acf:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3ad2:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3ad5:	89 c1                	mov    ecx,eax
    3ad7:	89 c8                	mov    eax,ecx
    3ad9:	09 d0                	or     eax,edx
    3adb:	75 b3                	jne    3a90 <mm_initialize+0x9c>
    3add:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3ae0:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3ae3:	85 c0                	test   eax,eax
    3ae5:	75 a9                	jne    3a90 <mm_initialize+0x9c>

		/* sort and merge remaining blocks */
		mm_sort_and_merge();
    3ae7:	e8 fc ff ff ff       	call   3ae8 <mm_initialize+0xf4>

		/* set fm_begin and page-align */
		for (size_t i = 0; i < fm_ofs; i++) {
    3aec:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    3af3:	e9 ea 00 00 00       	jmp    3be2 <mm_initialize+0x1ee>
				if (i && fmm[i - 1].base < 0x100000)
    3af8:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    3afc:	74 2d                	je     3b2b <mm_initialize+0x137>
    3afe:	ba 00 40 02 00       	mov    edx,0x24000
    3b03:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3b06:	6b c0 38             	imul   eax,eax,0x38
    3b09:	83 e8 38             	sub    eax,0x38
    3b0c:	01 d0                	add    eax,edx
    3b0e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3b11:	8b 00                	mov    eax,DWORD PTR [eax]
    3b13:	bb ff ff 0f 00       	mov    ebx,0xfffff
    3b18:	b9 00 00 00 00       	mov    ecx,0x0
    3b1d:	39 c3                	cmp    ebx,eax
    3b1f:	19 d1                	sbb    ecx,edx
    3b21:	72 08                	jb     3b2b <mm_initialize+0x137>
						fm_begin = i; /* works better this way, i.e. base=1 */
    3b23:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3b26:	a3 1c 00 00 00       	mov    ds:0x1c,eax
				if (fmm[i].base % 4096) {
    3b2b:	ba 00 40 02 00       	mov    edx,0x24000
    3b30:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3b33:	6b c0 38             	imul   eax,eax,0x38
    3b36:	01 d0                	add    eax,edx
    3b38:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3b3b:	8b 00                	mov    eax,DWORD PTR [eax]
    3b3d:	25 ff 0f 00 00       	and    eax,0xfff
    3b42:	ba 00 00 00 00       	mov    edx,0x0
    3b47:	89 c1                	mov    ecx,eax
    3b49:	89 c8                	mov    eax,ecx
    3b4b:	09 d0                	or     eax,edx
    3b4d:	0f 84 8b 00 00 00    	je     3bde <mm_initialize+0x1ea>
						fmm[i].size -= fmm[i].base % 4096;
    3b53:	ba 00 40 02 00       	mov    edx,0x24000
    3b58:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3b5b:	6b c0 38             	imul   eax,eax,0x38
    3b5e:	01 d0                	add    eax,edx
    3b60:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3b63:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3b66:	bb 00 40 02 00       	mov    ebx,0x24000
    3b6b:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    3b6e:	6b c9 38             	imul   ecx,ecx,0x38
    3b71:	01 d9                	add    ecx,ebx
    3b73:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
    3b76:	8b 09                	mov    ecx,DWORD PTR [ecx]
    3b78:	81 e1 ff 0f 00 00    	and    ecx,0xfff
    3b7e:	bb 00 00 00 00       	mov    ebx,0x0
    3b83:	bf 00 40 02 00       	mov    edi,0x24000
    3b88:	8b 75 e0             	mov    esi,DWORD PTR [ebp-0x20]
    3b8b:	6b f6 38             	imul   esi,esi,0x38
    3b8e:	01 fe                	add    esi,edi
    3b90:	29 c8                	sub    eax,ecx
    3b92:	19 da                	sbb    edx,ebx
    3b94:	89 46 08             	mov    DWORD PTR [esi+0x8],eax
    3b97:	89 56 0c             	mov    DWORD PTR [esi+0xc],edx
						fmm[i].base += fmm[i].base % 4096;
    3b9a:	ba 00 40 02 00       	mov    edx,0x24000
    3b9f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3ba2:	6b c0 38             	imul   eax,eax,0x38
    3ba5:	01 d0                	add    eax,edx
    3ba7:	8b 08                	mov    ecx,DWORD PTR [eax]
    3ba9:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    3bac:	ba 00 40 02 00       	mov    edx,0x24000
    3bb1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3bb4:	6b c0 38             	imul   eax,eax,0x38
    3bb7:	01 d0                	add    eax,edx
    3bb9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3bbc:	8b 00                	mov    eax,DWORD PTR [eax]
    3bbe:	25 ff 0f 00 00       	and    eax,0xfff
    3bc3:	ba 00 00 00 00       	mov    edx,0x0
    3bc8:	bf 00 40 02 00       	mov    edi,0x24000
    3bcd:	8b 75 e0             	mov    esi,DWORD PTR [ebp-0x20]
    3bd0:	6b f6 38             	imul   esi,esi,0x38
    3bd3:	01 fe                	add    esi,edi
    3bd5:	01 c8                	add    eax,ecx
    3bd7:	11 da                	adc    edx,ebx
    3bd9:	89 06                	mov    DWORD PTR [esi],eax
    3bdb:	89 56 04             	mov    DWORD PTR [esi+0x4],edx
		for (size_t i = 0; i < fm_ofs; i++) {
    3bde:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    3be2:	a1 18 00 00 00       	mov    eax,ds:0x18
    3be7:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    3bea:	0f 82 08 ff ff ff    	jb     3af8 <mm_initialize+0x104>
				}
		}

		/* and print the info for now */
		for (size_t i = 0; i < fm_ofs; i++) {
    3bf0:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    3bf7:	eb 66                	jmp    3c5f <mm_initialize+0x26b>
				put32(i);
    3bf9:	83 ec 0c             	sub    esp,0xc
    3bfc:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    3bff:	e8 fc ff ff ff       	call   3c00 <mm_initialize+0x20c>
    3c04:	83 c4 10             	add    esp,0x10
				put64(fmm[i].base);
    3c07:	ba 00 40 02 00       	mov    edx,0x24000
    3c0c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3c0f:	6b c0 38             	imul   eax,eax,0x38
    3c12:	01 d0                	add    eax,edx
    3c14:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3c17:	8b 00                	mov    eax,DWORD PTR [eax]
    3c19:	83 ec 08             	sub    esp,0x8
    3c1c:	52                   	push   edx
    3c1d:	50                   	push   eax
    3c1e:	e8 fc ff ff ff       	call   3c1f <mm_initialize+0x22b>
    3c23:	83 c4 10             	add    esp,0x10
				putstr("-");
    3c26:	83 ec 0c             	sub    esp,0xc
    3c29:	68 7b 00 00 00       	push   0x7b
    3c2e:	e8 fc ff ff ff       	call   3c2f <mm_initialize+0x23b>
    3c33:	83 c4 10             	add    esp,0x10
				put64(fmm[i].size);
    3c36:	ba 00 40 02 00       	mov    edx,0x24000
    3c3b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3c3e:	6b c0 38             	imul   eax,eax,0x38
    3c41:	01 d0                	add    eax,edx
    3c43:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3c46:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3c49:	83 ec 08             	sub    esp,0x8
    3c4c:	52                   	push   edx
    3c4d:	50                   	push   eax
    3c4e:	e8 fc ff ff ff       	call   3c4f <mm_initialize+0x25b>
    3c53:	83 c4 10             	add    esp,0x10
				put_nl();
    3c56:	e8 fc ff ff ff       	call   3c57 <mm_initialize+0x263>
		for (size_t i = 0; i < fm_ofs; i++) {
    3c5b:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    3c5f:	a1 18 00 00 00       	mov    eax,ds:0x18
    3c64:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
    3c67:	72 90                	jb     3bf9 <mm_initialize+0x205>
		}

		/* set the counts and create the rcp/pmu's,
		 *  -> this time we preallocate them all */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    3c69:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    3c6e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    3c71:	e9 03 02 00 00       	jmp    3e79 <mm_initialize+0x485>
				uint32_t ec, rec;
				fmm[i].reclaimable_pages = fmm[i].size / 4096; /* skip half-pages */
    3c76:	ba 00 40 02 00       	mov    edx,0x24000
    3c7b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3c7e:	6b c0 38             	imul   eax,eax,0x38
    3c81:	01 d0                	add    eax,edx
    3c83:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3c86:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3c89:	bb 00 40 02 00       	mov    ebx,0x24000
    3c8e:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3c91:	6b c9 38             	imul   ecx,ecx,0x38
    3c94:	01 d9                	add    ecx,ebx
    3c96:	0f ac d0 0c          	shrd   eax,edx,0xc
    3c9a:	c1 ea 0c             	shr    edx,0xc
    3c9d:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    3ca0:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
				fmm[i].free_pages = 0;
    3ca3:	ba 00 40 02 00       	mov    edx,0x24000
    3ca8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3cab:	6b c0 38             	imul   eax,eax,0x38
    3cae:	01 d0                	add    eax,edx
    3cb0:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
    3cb7:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
				rec = fmm[i].reclaimable_pages % 16384;
    3cbe:	ba 00 40 02 00       	mov    edx,0x24000
    3cc3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3cc6:	6b c0 38             	imul   eax,eax,0x38
    3cc9:	01 d0                	add    eax,edx
    3ccb:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3cce:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3cd1:	25 ff 3f 00 00       	and    eax,0x3fff
    3cd6:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				ec = (rec ? 1 : 0) + fmm[i].reclaimable_pages / 16384;
    3cd9:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    3cdd:	74 07                	je     3ce6 <mm_initialize+0x2f2>
    3cdf:	b9 01 00 00 00       	mov    ecx,0x1
    3ce4:	eb 05                	jmp    3ceb <mm_initialize+0x2f7>
    3ce6:	b9 00 00 00 00       	mov    ecx,0x0
    3ceb:	ba 00 40 02 00       	mov    edx,0x24000
    3cf0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3cf3:	6b c0 38             	imul   eax,eax,0x38
    3cf6:	01 d0                	add    eax,edx
    3cf8:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3cfb:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3cfe:	0f ac d0 0e          	shrd   eax,edx,0xe
    3d02:	c1 ea 0e             	shr    edx,0xe
    3d05:	01 c8                	add    eax,ecx
    3d07:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* the size will be reduced by 2*ec -> check rec */
				if (rec && (2 * ec > rec))
    3d0a:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    3d0e:	74 0e                	je     3d1e <mm_initialize+0x32a>
    3d10:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3d13:	01 c0                	add    eax,eax
    3d15:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    3d18:	73 04                	jae    3d1e <mm_initialize+0x32a>
						ec--;
    3d1a:	83 6d d4 01          	sub    DWORD PTR [ebp-0x2c],0x1
				fmm[i].reclaimable_pages -= 2 * ec;
    3d1e:	ba 00 40 02 00       	mov    edx,0x24000
    3d23:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3d26:	6b c0 38             	imul   eax,eax,0x38
    3d29:	01 d0                	add    eax,edx
    3d2b:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3d2e:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3d31:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3d34:	01 c9                	add    ecx,ecx
    3d36:	89 ce                	mov    esi,ecx
    3d38:	bf 00 00 00 00       	mov    edi,0x0
    3d3d:	bb 00 40 02 00       	mov    ebx,0x24000
    3d42:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3d45:	6b c9 38             	imul   ecx,ecx,0x38
    3d48:	01 d9                	add    ecx,ebx
    3d4a:	29 f0                	sub    eax,esi
    3d4c:	19 fa                	sbb    edx,edi
    3d4e:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    3d51:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
				rec = fmm[i].reclaimable_pages % 16384;
    3d54:	ba 00 40 02 00       	mov    edx,0x24000
    3d59:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3d5c:	6b c0 38             	imul   eax,eax,0x38
    3d5f:	01 d0                	add    eax,edx
    3d61:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3d64:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3d67:	25 ff 3f 00 00       	and    eax,0x3fff
    3d6c:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				/* make the reservation */
				fmm[i].size -= 2 * ec * 4096;
    3d6f:	ba 00 40 02 00       	mov    edx,0x24000
    3d74:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3d77:	6b c0 38             	imul   eax,eax,0x38
    3d7a:	01 d0                	add    eax,edx
    3d7c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3d7f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3d82:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3d85:	c1 e1 0d             	shl    ecx,0xd
    3d88:	89 ce                	mov    esi,ecx
    3d8a:	bf 00 00 00 00       	mov    edi,0x0
    3d8f:	bb 00 40 02 00       	mov    ebx,0x24000
    3d94:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3d97:	6b c9 38             	imul   ecx,ecx,0x38
    3d9a:	01 d9                	add    ecx,ebx
    3d9c:	29 f0                	sub    eax,esi
    3d9e:	19 fa                	sbb    edx,edi
    3da0:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    3da3:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
				fmm[i].pmu = fmm[i].base;
    3da6:	ba 00 40 02 00       	mov    edx,0x24000
    3dab:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3dae:	6b c0 38             	imul   eax,eax,0x38
    3db1:	01 d0                	add    eax,edx
    3db3:	b9 00 40 02 00       	mov    ecx,0x24000
    3db8:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3dbb:	6b d2 38             	imul   edx,edx,0x38
    3dbe:	01 d1                	add    ecx,edx
    3dc0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3dc3:	8b 00                	mov    eax,DWORD PTR [eax]
    3dc5:	89 41 28             	mov    DWORD PTR [ecx+0x28],eax
    3dc8:	89 51 2c             	mov    DWORD PTR [ecx+0x2c],edx
				fmm[i].rcp = fmm[i].base + ec * 4096;
    3dcb:	ba 00 40 02 00       	mov    edx,0x24000
    3dd0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3dd3:	6b c0 38             	imul   eax,eax,0x38
    3dd6:	01 d0                	add    eax,edx
    3dd8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3ddb:	8b 00                	mov    eax,DWORD PTR [eax]
    3ddd:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3de0:	c1 e1 0c             	shl    ecx,0xc
    3de3:	89 ce                	mov    esi,ecx
    3de5:	bf 00 00 00 00       	mov    edi,0x0
    3dea:	bb 00 40 02 00       	mov    ebx,0x24000
    3def:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3df2:	6b c9 38             	imul   ecx,ecx,0x38
    3df5:	01 d9                	add    ecx,ebx
    3df7:	01 f0                	add    eax,esi
    3df9:	11 fa                	adc    edx,edi
    3dfb:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    3dfe:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
				fmm[i].base += 2 * ec * 4096;
    3e01:	ba 00 40 02 00       	mov    edx,0x24000
    3e06:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3e09:	6b c0 38             	imul   eax,eax,0x38
    3e0c:	01 d0                	add    eax,edx
    3e0e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3e11:	8b 00                	mov    eax,DWORD PTR [eax]
    3e13:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3e16:	c1 e1 0d             	shl    ecx,0xd
    3e19:	89 ce                	mov    esi,ecx
    3e1b:	bf 00 00 00 00       	mov    edi,0x0
    3e20:	bb 00 40 02 00       	mov    ebx,0x24000
    3e25:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3e28:	6b c9 38             	imul   ecx,ecx,0x38
    3e2b:	01 d9                	add    ecx,ebx
    3e2d:	01 f0                	add    eax,esi
    3e2f:	11 fa                	adc    edx,edi
    3e31:	89 01                	mov    DWORD PTR [ecx],eax
    3e33:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				fmm[i].ec = ec;
    3e36:	ba 00 40 02 00       	mov    edx,0x24000
    3e3b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3e3e:	6b c0 38             	imul   eax,eax,0x38
    3e41:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3e44:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3e47:	ba 00 00 00 00       	mov    edx,0x0
    3e4c:	89 41 20             	mov    DWORD PTR [ecx+0x20],eax
    3e4f:	89 51 24             	mov    DWORD PTR [ecx+0x24],edx
				/* and fill if below 4G (use delayed init) */
				mm_fm_init(fmm + i, ec, rec);
    3e52:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    3e55:	0f b7 c0             	movzx  eax,ax
    3e58:	b9 00 40 02 00       	mov    ecx,0x24000
    3e5d:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3e60:	6b d2 38             	imul   edx,edx,0x38
    3e63:	01 ca                	add    edx,ecx
    3e65:	83 ec 04             	sub    esp,0x4
    3e68:	50                   	push   eax
    3e69:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    3e6c:	52                   	push   edx
    3e6d:	e8 fc ff ff ff       	call   3e6e <mm_initialize+0x47a>
    3e72:	83 c4 10             	add    esp,0x10
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    3e75:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    3e79:	a1 18 00 00 00       	mov    eax,ds:0x18
    3e7e:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    3e81:	0f 82 ef fd ff ff    	jb     3c76 <mm_initialize+0x282>
		}

		/* create the page tables */
		mm_prepare_paging(mode);
    3e87:	83 ec 0c             	sub    esp,0xc
    3e8a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3e8d:	e8 fc ff ff ff       	call   3e8e <mm_initialize+0x49a>
    3e92:	83 c4 10             	add    esp,0x10

//		putstr("done");
}
    3e95:	90                   	nop
    3e96:	8d 65 f4             	lea    esp,[ebp-0xc]
    3e99:	5b                   	pop    ebx
    3e9a:	5e                   	pop    esi
    3e9b:	5f                   	pop    edi
    3e9c:	5d                   	pop    ebp
    3e9d:	c3                   	ret

00003e9e <mm_enable_paging>:

void mm_enable_paging(int mode, uint64_t ep)
{
    3e9e:	55                   	push   ebp
    3e9f:	89 e5                	mov    ebp,esp
    3ea1:	83 ec 28             	sub    esp,0x28
    3ea4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3ea7:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    3eaa:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    3ead:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		extern void ep36();
		extern void ep64();
		extern uint64_t ep_ptr;

		/* store the values for transfer */
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
    3eb0:	c7 45 f4 00 40 02 00 	mov    DWORD PTR [ebp-0xc],0x24000
		ptr[-1] = fm_ofs;
    3eb7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3eba:	8d 50 fc             	lea    edx,[eax-0x4]
    3ebd:	a1 18 00 00 00       	mov    eax,ds:0x18
    3ec2:	89 02                	mov    DWORD PTR [edx],eax
		ptr[-2] = fm_begin;
    3ec4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3ec7:	8d 50 f8             	lea    edx,[eax-0x8]
    3eca:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    3ecf:	89 02                	mov    DWORD PTR [edx],eax
		ptr[-3] = rm_count;
    3ed1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3ed4:	8d 50 f4             	lea    edx,[eax-0xc]
    3ed7:	a1 20 00 00 00       	mov    eax,ds:0x20
    3edc:	89 02                	mov    DWORD PTR [edx],eax
		*(uint64_t*)(ptr - 5) = pm_zero;
    3ede:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3ee1:	8d 48 ec             	lea    ecx,[eax-0x14]
    3ee4:	a1 00 00 00 00       	mov    eax,ds:0x0
    3ee9:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    3eef:	89 01                	mov    DWORD PTR [ecx],eax
    3ef1:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		*(uint64_t*)(ptr - 7) = cr3_val;
    3ef4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3ef7:	8d 48 e4             	lea    ecx,[eax-0x1c]
    3efa:	a1 00 00 00 00       	mov    eax,ds:0x0
    3eff:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    3f05:	89 01                	mov    DWORD PTR [ecx],eax
    3f07:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		ptr[-8] = (uint32_t)mode;
    3f0a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3f0d:	8d 50 e0             	lea    edx,[eax-0x20]
    3f10:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3f13:	89 02                	mov    DWORD PTR [edx],eax

		ep_ptr = ep;
    3f15:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3f18:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    3f1b:	a3 00 00 00 00       	mov    ds:0x0,eax
    3f20:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		if (!mode)
    3f26:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    3f2a:	75 07                	jne    3f33 <mm_enable_paging+0x95>
				ep32();
    3f2c:	e8 fc ff ff ff       	call   3f2d <mm_enable_paging+0x8f>
    3f31:	eb 13                	jmp    3f46 <mm_enable_paging+0xa8>
		else if (mode == 1)
    3f33:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    3f37:	75 07                	jne    3f40 <mm_enable_paging+0xa2>
				ep36();
    3f39:	e8 fc ff ff ff       	call   3f3a <mm_enable_paging+0x9c>
    3f3e:	eb 06                	jmp    3f46 <mm_enable_paging+0xa8>
		else
				ep64();
    3f40:	e8 fc ff ff ff       	call   3f41 <mm_enable_paging+0xa3>

		while (1);
    3f45:	90                   	nop
    3f46:	90                   	nop
    3f47:	eb fd                	jmp    3f46 <mm_enable_paging+0xa8>

00003f49 <mm_map64>:
}

void mm_map64(uint64_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    3f49:	55                   	push   ebp
    3f4a:	89 e5                	mov    ebp,esp
    3f4c:	56                   	push   esi
    3f4d:	53                   	push   ebx
    3f4e:	81 ec 90 00 00 00    	sub    esp,0x90
    3f54:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3f57:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
    3f5d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3f60:	89 85 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],eax
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
    3f66:	a1 00 00 00 00       	mov    eax,ds:0x0
    3f6b:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		struct pm_pg64_ptrs* pp = pm_mapping;
    3f6e:	a1 00 00 00 00       	mov    eax,ds:0x0
    3f73:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		uint32_t pml4e, pdpte, pde, pte;
		struct page_range pr_copy = *pr;
    3f76:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    3f79:	8b 10                	mov    edx,DWORD PTR [eax]
    3f7b:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
    3f7e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3f81:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
    3f84:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3f87:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax

		/* physical pointers */
		struct pte64 *p = pp->p;
    3f8a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3f8d:	8b 00                	mov    eax,DWORD PTR [eax]
    3f8f:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		struct pte64* pl = 0;
    3f92:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		struct pte64* pd = 0;
    3f99:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		struct pte64* pt = 0;
    3fa0:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = vaddr & 0x0000ffffffffffff;
    3fa7:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [ebp-0x90]
    3fad:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    3fb3:	81 e2 ff ff 00 00    	and    edx,0xffff
    3fb9:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    3fbc:	89 55 b4             	mov    DWORD PTR [ebp-0x4c],edx
		pml4e = low48 >> 39; /* 512G per PML4E */
    3fbf:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3fc2:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3fc5:	89 d0                	mov    eax,edx
    3fc7:	31 d2                	xor    edx,edx
    3fc9:	c1 e8 07             	shr    eax,0x7
    3fcc:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */
    3fcf:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3fd2:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3fd5:	0f ac d0 1e          	shrd   eax,edx,0x1e
    3fd9:	c1 ea 1e             	shr    edx,0x1e
    3fdc:	25 ff 01 00 00       	and    eax,0x1ff
    3fe1:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */
    3fe4:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3fe7:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3fea:	0f ac d0 15          	shrd   eax,edx,0x15
    3fee:	c1 ea 15             	shr    edx,0x15
    3ff1:	25 ff 01 00 00       	and    eax,0x1ff
    3ff6:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */
    3ff9:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3ffc:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3fff:	0f ac d0 0c          	shrd   eax,edx,0xc
    4003:	c1 ea 0c             	shr    edx,0xc
    4006:	25 ff 01 00 00       	and    eax,0x1ff
    400b:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* create one if not there */
new_pdpt:
		if (!vp->pml4e[pml4e]) {
    400e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4011:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4014:	83 c2 02             	add    edx,0x2
    4017:	8d 14 d0             	lea    edx,[eax+edx*8]
    401a:	8b 02                	mov    eax,DWORD PTR [edx]
    401c:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    401f:	89 c1                	mov    ecx,eax
    4021:	89 c8                	mov    eax,ecx
    4023:	09 d0                	or     eax,edx
    4025:	0f 85 3d 02 00 00    	jne    4268 <mm_map64+0x31f>
				struct page_range pr2;
				/* allocate the PDPT */
				mm_alloc_pm(1, &pr2, 1);
    402b:	83 ec 04             	sub    esp,0x4
    402e:	6a 01                	push   0x1
    4030:	8d 45 90             	lea    eax,[ebp-0x70]
    4033:	50                   	push   eax
    4034:	6a 01                	push   0x1
    4036:	e8 fc ff ff ff       	call   4037 <mm_map64+0xee>
    403b:	83 c4 10             	add    esp,0x10
				vp->pml4e[pml4e] = vp->cur;
    403e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4041:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4044:	8b 00                	mov    eax,DWORD PTR [eax]
    4046:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    4049:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    404c:	83 c3 02             	add    ebx,0x2
    404f:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    4052:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    4056:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4059:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    405c:	8b 00                	mov    eax,DWORD PTR [eax]
    405e:	05 00 f0 ff ff       	add    eax,0xfffff000
    4063:	83 d2 ff             	adc    edx,0xffffffff
    4066:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    4069:	89 01                	mov    DWORD PTR [ecx],eax
    406b:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				pl = (void*)pr2.base;
    406e:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    4071:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    4074:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				/* make it known in VM */
				mm_map64(vp->pml4e[pml4e], &pr2, 1, 0, 1, 0, 0);
    4077:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    407a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    407d:	83 c2 02             	add    edx,0x2
    4080:	8d 14 d0             	lea    edx,[eax+edx*8]
    4083:	8b 02                	mov    eax,DWORD PTR [edx]
    4085:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4088:	6a 00                	push   0x0
    408a:	6a 00                	push   0x0
    408c:	6a 01                	push   0x1
    408e:	6a 00                	push   0x0
    4090:	6a 01                	push   0x1
    4092:	8d 4d 90             	lea    ecx,[ebp-0x70]
    4095:	51                   	push   ecx
    4096:	52                   	push   edx
    4097:	50                   	push   eax
    4098:	e8 fc ff ff ff       	call   4099 <mm_map64+0x150>
    409d:	83 c4 20             	add    esp,0x20

				/* do the same for the map (2 pages) */
				if (mm_alloc_pm(2, &pr2, 1) != 2) {
    40a0:	83 ec 04             	sub    esp,0x4
    40a3:	6a 01                	push   0x1
    40a5:	8d 45 90             	lea    eax,[ebp-0x70]
    40a8:	50                   	push   eax
    40a9:	6a 02                	push   0x2
    40ab:	e8 fc ff ff ff       	call   40ac <mm_map64+0x163>
    40b0:	83 c4 10             	add    esp,0x10
    40b3:	83 f8 02             	cmp    eax,0x2
    40b6:	74 13                	je     40cb <mm_map64+0x182>
						puts("cont alloc 2 failed.");
    40b8:	83 ec 0c             	sub    esp,0xc
    40bb:	68 7d 00 00 00       	push   0x7d
    40c0:	e8 fc ff ff ff       	call   40c1 <mm_map64+0x178>
    40c5:	83 c4 10             	add    esp,0x10
						while (1);
    40c8:	90                   	nop
    40c9:	eb fd                	jmp    40c8 <mm_map64+0x17f>
				}
				vp->pdpte[pml4e] = vp->cur - 4096;
    40cb:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    40ce:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40d1:	8b 00                	mov    eax,DWORD PTR [eax]
    40d3:	05 00 f0 ff ff       	add    eax,0xfffff000
    40d8:	83 d2 ff             	adc    edx,0xffffffff
    40db:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    40de:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    40e1:	81 c3 02 02 00 00    	add    ebx,0x202
    40e7:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    40ea:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 8192;
    40ee:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    40f1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40f4:	8b 00                	mov    eax,DWORD PTR [eax]
    40f6:	05 00 e0 ff ff       	add    eax,0xffffe000
    40fb:	83 d2 ff             	adc    edx,0xffffffff
    40fe:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    4101:	89 01                	mov    DWORD PTR [ecx],eax
    4103:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				/* and make it known in later VM */
				mm_map64(vp->pdpte[pml4e], &pr2, 1, 0, 1, 0, 0);
    4106:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4109:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    410c:	81 c2 02 02 00 00    	add    edx,0x202
    4112:	8d 14 d0             	lea    edx,[eax+edx*8]
    4115:	8b 02                	mov    eax,DWORD PTR [edx]
    4117:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    411a:	6a 00                	push   0x0
    411c:	6a 00                	push   0x0
    411e:	6a 01                	push   0x1
    4120:	6a 00                	push   0x0
    4122:	6a 01                	push   0x1
    4124:	8d 4d 90             	lea    ecx,[ebp-0x70]
    4127:	51                   	push   ecx
    4128:	52                   	push   edx
    4129:	50                   	push   eax
    412a:	e8 fc ff ff ff       	call   412b <mm_map64+0x1e2>
    412f:	83 c4 20             	add    esp,0x20

				/* PMEM ptr */
				m = (void*)pr2.base;
    4132:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    4135:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    4138:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				/* store the physical pointers */
				pp->extra_pdpts[pp->ec_pdpt].idx = pml4e;
    413b:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    413e:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    4142:	0f b7 d0             	movzx  edx,ax
    4145:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    4148:	89 d0                	mov    eax,edx
    414a:	01 c0                	add    eax,eax
    414c:	01 d0                	add    eax,edx
    414e:	c1 e0 02             	shl    eax,0x2
    4151:	01 c8                	add    eax,ecx
    4153:	8d 50 3c             	lea    edx,[eax+0x3c]
    4156:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4159:	89 02                	mov    DWORD PTR [edx],eax
				pp->extra_pdpts[pp->ec_pdpt].pdpt = pl;
    415b:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    415e:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    4162:	0f b7 d0             	movzx  edx,ax
    4165:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    4168:	89 d0                	mov    eax,edx
    416a:	01 c0                	add    eax,eax
    416c:	01 d0                	add    eax,edx
    416e:	c1 e0 02             	shl    eax,0x2
    4171:	01 c8                	add    eax,ecx
    4173:	8d 50 34             	lea    edx,[eax+0x34]
    4176:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4179:	89 02                	mov    DWORD PTR [edx],eax
				pp->extra_pdpts[pp->ec_pdpt++].map = m;
    417b:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    417e:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    4182:	8d 48 01             	lea    ecx,[eax+0x1]
    4185:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    4188:	66 89 4a 2c          	mov    WORD PTR [edx+0x2c],cx
    418c:	0f b7 d0             	movzx  edx,ax
    418f:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    4192:	89 d0                	mov    eax,edx
    4194:	01 c0                	add    eax,eax
    4196:	01 d0                	add    eax,edx
    4198:	c1 e0 02             	shl    eax,0x2
    419b:	01 c8                	add    eax,ecx
    419d:	8d 50 38             	lea    edx,[eax+0x38]
    41a0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    41a3:	89 02                	mov    DWORD PTR [edx],eax
				if (pp->ec_pdpt > 8)
    41a5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    41a8:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    41ac:	66 83 f8 08          	cmp    ax,0x8
    41b0:	76 03                	jbe    41b5 <mm_map64+0x26c>
					while (1); /* exhausted too */
    41b2:	90                   	nop
    41b3:	eb fd                	jmp    41b2 <mm_map64+0x269>

				/* and set the reference in the PML4 */
				p[pml4e].addr = (uint64_t)pl / 4096;
    41b5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    41b8:	99                   	cdq
    41b9:	0f ac d0 0c          	shrd   eax,edx,0xc
    41bd:	c1 ea 0c             	shr    edx,0xc
    41c0:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    41c3:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    41ca:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    41cd:	01 d9                	add    ecx,ebx
    41cf:	81 e2 ff 00 00 00    	and    edx,0xff
    41d5:	89 c3                	mov    ebx,eax
    41d7:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    41dd:	89 de                	mov    esi,ebx
    41df:	c1 e6 0c             	shl    esi,0xc
    41e2:	8b 19                	mov    ebx,DWORD PTR [ecx]
    41e4:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    41ea:	09 f3                	or     ebx,esi
    41ec:	89 19                	mov    DWORD PTR [ecx],ebx
    41ee:	89 c3                	mov    ebx,eax
    41f0:	c1 eb 14             	shr    ebx,0x14
    41f3:	89 de                	mov    esi,ebx
    41f5:	66 81 e6 ff 0f       	and    si,0xfff
    41fa:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    41fe:	66 81 e3 00 f0       	and    bx,0xf000
    4203:	09 f3                	or     ebx,esi
    4205:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4209:	0f b6 c2             	movzx  eax,dl
    420c:	c1 e0 0c             	shl    eax,0xc
    420f:	89 c2                	mov    edx,eax
    4211:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4214:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4219:	09 d0                	or     eax,edx
    421b:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				p[pml4e].u = 1;
    421e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4221:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4228:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    422b:	01 d0                	add    eax,edx
    422d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4230:	83 ca 04             	or     edx,0x4
    4233:	88 10                	mov    BYTE PTR [eax],dl
				p[pml4e].w = 1;
    4235:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4238:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    423f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    4242:	01 d0                	add    eax,edx
    4244:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4247:	83 ca 02             	or     edx,0x2
    424a:	88 10                	mov    BYTE PTR [eax],dl
				p[pml4e].p = 1;
    424c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    424f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4256:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    4259:	01 d0                	add    eax,edx
    425b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    425e:	83 ca 01             	or     edx,0x1
    4261:	88 10                	mov    BYTE PTR [eax],dl
    4263:	e9 be 00 00 00       	jmp    4326 <mm_map64+0x3dd>
		} else { /* find PP in pp */
				for (size_t i = 0; i < pp->ec_pdpt; i++)
    4268:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    426f:	eb 53                	jmp    42c4 <mm_map64+0x37b>
						if (pp->extra_pdpts[i].idx == pml4e) {
    4271:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    4274:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    4277:	89 d0                	mov    eax,edx
    4279:	01 c0                	add    eax,eax
    427b:	01 d0                	add    eax,edx
    427d:	c1 e0 02             	shl    eax,0x2
    4280:	01 c8                	add    eax,ecx
    4282:	83 c0 3c             	add    eax,0x3c
    4285:	8b 00                	mov    eax,DWORD PTR [eax]
    4287:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    428a:	75 34                	jne    42c0 <mm_map64+0x377>
								pl = pp->extra_pdpts[i].pdpt;
    428c:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    428f:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    4292:	89 d0                	mov    eax,edx
    4294:	01 c0                	add    eax,eax
    4296:	01 d0                	add    eax,edx
    4298:	c1 e0 02             	shl    eax,0x2
    429b:	01 c8                	add    eax,ecx
    429d:	83 c0 34             	add    eax,0x34
    42a0:	8b 00                	mov    eax,DWORD PTR [eax]
    42a2:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								m = pp->extra_pdpts[i].map;
    42a5:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    42a8:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    42ab:	89 d0                	mov    eax,edx
    42ad:	01 c0                	add    eax,eax
    42af:	01 d0                	add    eax,edx
    42b1:	c1 e0 02             	shl    eax,0x2
    42b4:	01 c8                	add    eax,ecx
    42b6:	83 c0 38             	add    eax,0x38
    42b9:	8b 00                	mov    eax,DWORD PTR [eax]
    42bb:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								break;
    42be:	eb 13                	jmp    42d3 <mm_map64+0x38a>
				for (size_t i = 0; i < pp->ec_pdpt; i++)
    42c0:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
    42c4:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    42c7:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    42cb:	0f b7 c0             	movzx  eax,ax
    42ce:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    42d1:	72 9e                	jb     4271 <mm_map64+0x328>
						}
				if (!pl) {
    42d3:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    42d7:	75 37                	jne    4310 <mm_map64+0x3c7>
						if (pml4e == 0) {
    42d9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    42dd:	75 14                	jne    42f3 <mm_map64+0x3aa>
								pl = pp->p1;
    42df:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    42e2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    42e5:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								m = pp->m1;
    42e8:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    42eb:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    42ee:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    42f1:	eb 33                	jmp    4326 <mm_map64+0x3dd>
						} else if (pml4e == 511) {
    42f3:	81 7d f4 ff 01 00 00 	cmp    DWORD PTR [ebp-0xc],0x1ff
    42fa:	75 17                	jne    4313 <mm_map64+0x3ca>
								pl = pp->p2;
    42fc:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    42ff:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4302:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								m = pp->m2;
    4305:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4308:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    430b:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    430e:	eb 16                	jmp    4326 <mm_map64+0x3dd>
						}
				}
		}

		/* now go on to the page directory */
new_pd:
    4310:	90                   	nop
    4311:	eb 13                	jmp    4326 <mm_map64+0x3dd>
								puts("pre-paging exhausted.");
    4313:	83 ec 0c             	sub    esp,0xc
    4316:	68 92 00 00 00       	push   0x92
    431b:	e8 fc ff ff ff       	call   431c <mm_map64+0x3d3>
    4320:	83 c4 10             	add    esp,0x10
								while (1);
    4323:	90                   	nop
    4324:	eb fd                	jmp    4323 <mm_map64+0x3da>
		if (!m->pds[pdpte]) {
    4326:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4329:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    432c:	8d 14 d0             	lea    edx,[eax+edx*8]
    432f:	8b 02                	mov    eax,DWORD PTR [edx]
    4331:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4334:	89 c1                	mov    ecx,eax
    4336:	89 c8                	mov    eax,ecx
    4338:	09 d0                	or     eax,edx
    433a:	0f 85 27 02 00 00    	jne    4567 <mm_map64+0x61e>
				struct page_range pr2;
				/* allocate a page directory */
				mm_alloc_pm(1, &pr2, 1);
    4340:	83 ec 04             	sub    esp,0x4
    4343:	6a 01                	push   0x1
    4345:	8d 45 84             	lea    eax,[ebp-0x7c]
    4348:	50                   	push   eax
    4349:	6a 01                	push   0x1
    434b:	e8 fc ff ff ff       	call   434c <mm_map64+0x403>
    4350:	83 c4 10             	add    esp,0x10
				m->pds[pdpte] = vp->cur;
    4353:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4356:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4359:	8b 00                	mov    eax,DWORD PTR [eax]
    435b:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    435e:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
    4361:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    4364:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    4368:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    436b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    436e:	8b 00                	mov    eax,DWORD PTR [eax]
    4370:	05 00 f0 ff ff       	add    eax,0xfffff000
    4375:	83 d2 ff             	adc    edx,0xffffffff
    4378:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    437b:	89 01                	mov    DWORD PTR [ecx],eax
    437d:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				pd = (void*)pr2.base;
    4380:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    4383:	8b 55 88             	mov    edx,DWORD PTR [ebp-0x78]
    4386:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				/* and make it known in later VM */
				mm_map64(m->pds[pdpte], &pr2, 1, 0, 1, 0, 0);
    4389:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    438c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    438f:	8d 14 d0             	lea    edx,[eax+edx*8]
    4392:	8b 02                	mov    eax,DWORD PTR [edx]
    4394:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4397:	6a 00                	push   0x0
    4399:	6a 00                	push   0x0
    439b:	6a 01                	push   0x1
    439d:	6a 00                	push   0x0
    439f:	6a 01                	push   0x1
    43a1:	8d 4d 84             	lea    ecx,[ebp-0x7c]
    43a4:	51                   	push   ecx
    43a5:	52                   	push   edx
    43a6:	50                   	push   eax
    43a7:	e8 fc ff ff ff       	call   43a8 <mm_map64+0x45f>
    43ac:	83 c4 20             	add    esp,0x20

				/* do the same for the map */
				mm_alloc_pm(1, &pr2, 1);
    43af:	83 ec 04             	sub    esp,0x4
    43b2:	6a 01                	push   0x1
    43b4:	8d 45 84             	lea    eax,[ebp-0x7c]
    43b7:	50                   	push   eax
    43b8:	6a 01                	push   0x1
    43ba:	e8 fc ff ff ff       	call   43bb <mm_map64+0x472>
    43bf:	83 c4 10             	add    esp,0x10
				m->pdes[pdpte] = vp->cur;
    43c2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    43c5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    43c8:	8b 00                	mov    eax,DWORD PTR [eax]
    43ca:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    43cd:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
    43d0:	81 c3 00 02 00 00    	add    ebx,0x200
    43d6:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    43d9:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    43dd:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    43e0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    43e3:	8b 00                	mov    eax,DWORD PTR [eax]
    43e5:	05 00 f0 ff ff       	add    eax,0xfffff000
    43ea:	83 d2 ff             	adc    edx,0xffffffff
    43ed:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    43f0:	89 01                	mov    DWORD PTR [ecx],eax
    43f2:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				/* and make it known in later VM */
				mm_map64(m->pdes[pdpte], &pr2, 1, 0, 1, 0, 0);
    43f5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    43f8:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    43fb:	81 c2 00 02 00 00    	add    edx,0x200
    4401:	8d 14 d0             	lea    edx,[eax+edx*8]
    4404:	8b 02                	mov    eax,DWORD PTR [edx]
    4406:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4409:	6a 00                	push   0x0
    440b:	6a 00                	push   0x0
    440d:	6a 01                	push   0x1
    440f:	6a 00                	push   0x0
    4411:	6a 01                	push   0x1
    4413:	8d 4d 84             	lea    ecx,[ebp-0x7c]
    4416:	51                   	push   ecx
    4417:	52                   	push   edx
    4418:	50                   	push   eax
    4419:	e8 fc ff ff ff       	call   441a <mm_map64+0x4d1>
    441e:	83 c4 20             	add    esp,0x20

				/* PMEM pointer */
				n = (void*)pr2.base;
    4421:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    4424:	8b 55 88             	mov    edx,DWORD PTR [ebp-0x78]
    4427:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* store the physical pointers (avoid 0*x) */
				pp->extra_pds[pp->ec_pd].idx = (pml4e << 9) | pdpte;
    442a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    442d:	c1 e0 09             	shl    eax,0x9
    4430:	89 c1                	mov    ecx,eax
    4432:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4435:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    4439:	0f b7 d0             	movzx  edx,ax
    443c:	0b 4d f0             	or     ecx,DWORD PTR [ebp-0x10]
    443f:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    4442:	89 d0                	mov    eax,edx
    4444:	01 c0                	add    eax,eax
    4446:	01 d0                	add    eax,edx
    4448:	c1 e0 02             	shl    eax,0x2
    444b:	01 d8                	add    eax,ebx
    444d:	05 9c 00 00 00       	add    eax,0x9c
    4452:	89 08                	mov    DWORD PTR [eax],ecx
				pp->extra_pds[pp->ec_pd].pd = pd;
    4454:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4457:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    445b:	0f b7 d0             	movzx  edx,ax
    445e:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    4461:	89 d0                	mov    eax,edx
    4463:	01 c0                	add    eax,eax
    4465:	01 d0                	add    eax,edx
    4467:	c1 e0 02             	shl    eax,0x2
    446a:	01 c8                	add    eax,ecx
    446c:	8d 90 94 00 00 00    	lea    edx,[eax+0x94]
    4472:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4475:	89 02                	mov    DWORD PTR [edx],eax
				pp->extra_pds[pp->ec_pd++].map = n;
    4477:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    447a:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    447e:	8d 48 01             	lea    ecx,[eax+0x1]
    4481:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    4484:	66 89 4a 2e          	mov    WORD PTR [edx+0x2e],cx
    4488:	0f b7 d0             	movzx  edx,ax
    448b:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    448e:	89 d0                	mov    eax,edx
    4490:	01 c0                	add    eax,eax
    4492:	01 d0                	add    eax,edx
    4494:	c1 e0 02             	shl    eax,0x2
    4497:	01 c8                	add    eax,ecx
    4499:	8d 90 98 00 00 00    	lea    edx,[eax+0x98]
    449f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    44a2:	89 02                	mov    DWORD PTR [edx],eax
				if (pp->ec_pd > 24)
    44a4:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    44a7:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    44ab:	66 83 f8 18          	cmp    ax,0x18
    44af:	76 03                	jbe    44b4 <mm_map64+0x56b>
					while (1); /* exhausted too */
    44b1:	90                   	nop
    44b2:	eb fd                	jmp    44b1 <mm_map64+0x568>

				/* and set the reference in the PDPT */
				pl[pdpte].addr = (uint64_t)pd / 4096;
    44b4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    44b7:	99                   	cdq
    44b8:	0f ac d0 0c          	shrd   eax,edx,0xc
    44bc:	c1 ea 0c             	shr    edx,0xc
    44bf:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    44c2:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    44c9:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    44cc:	01 d9                	add    ecx,ebx
    44ce:	81 e2 ff 00 00 00    	and    edx,0xff
    44d4:	89 c3                	mov    ebx,eax
    44d6:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    44dc:	89 de                	mov    esi,ebx
    44de:	c1 e6 0c             	shl    esi,0xc
    44e1:	8b 19                	mov    ebx,DWORD PTR [ecx]
    44e3:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    44e9:	09 f3                	or     ebx,esi
    44eb:	89 19                	mov    DWORD PTR [ecx],ebx
    44ed:	89 c3                	mov    ebx,eax
    44ef:	c1 eb 14             	shr    ebx,0x14
    44f2:	89 de                	mov    esi,ebx
    44f4:	66 81 e6 ff 0f       	and    si,0xfff
    44f9:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    44fd:	66 81 e3 00 f0       	and    bx,0xf000
    4502:	09 f3                	or     ebx,esi
    4504:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4508:	0f b6 c2             	movzx  eax,dl
    450b:	c1 e0 0c             	shl    eax,0xc
    450e:	89 c2                	mov    edx,eax
    4510:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4513:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4518:	09 d0                	or     eax,edx
    451a:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pl[pdpte].u = 1;
    451d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4520:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4527:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    452a:	01 d0                	add    eax,edx
    452c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    452f:	83 ca 04             	or     edx,0x4
    4532:	88 10                	mov    BYTE PTR [eax],dl
				pl[pdpte].w = 1;
    4534:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4537:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    453e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4541:	01 d0                	add    eax,edx
    4543:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4546:	83 ca 02             	or     edx,0x2
    4549:	88 10                	mov    BYTE PTR [eax],dl
				pl[pdpte].p = 1;
    454b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    454e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4555:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4558:	01 d0                	add    eax,edx
    455a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    455d:	83 ca 01             	or     edx,0x1
    4560:	88 10                	mov    BYTE PTR [eax],dl
    4562:	e9 df 00 00 00       	jmp    4646 <mm_map64+0x6fd>
		} else {
				uint32_t id = (pml4e << 9) | pdpte;
    4567:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    456a:	c1 e0 09             	shl    eax,0x9
    456d:	0b 45 f0             	or     eax,DWORD PTR [ebp-0x10]
    4570:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
				/* find PD in pp */
				for (size_t i = 0; i < pp->ec_pd; i++)
    4573:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    457a:	eb 59                	jmp    45d5 <mm_map64+0x68c>
						if (pp->extra_pds[i].idx == id) {
    457c:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    457f:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    4582:	89 d0                	mov    eax,edx
    4584:	01 c0                	add    eax,eax
    4586:	01 d0                	add    eax,edx
    4588:	c1 e0 02             	shl    eax,0x2
    458b:	01 c8                	add    eax,ecx
    458d:	05 9c 00 00 00       	add    eax,0x9c
    4592:	8b 00                	mov    eax,DWORD PTR [eax]
    4594:	39 45 ac             	cmp    DWORD PTR [ebp-0x54],eax
    4597:	75 38                	jne    45d1 <mm_map64+0x688>
								pd = pp->extra_pds[i].pd;
    4599:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    459c:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    459f:	89 d0                	mov    eax,edx
    45a1:	01 c0                	add    eax,eax
    45a3:	01 d0                	add    eax,edx
    45a5:	c1 e0 02             	shl    eax,0x2
    45a8:	01 c8                	add    eax,ecx
    45aa:	05 94 00 00 00       	add    eax,0x94
    45af:	8b 00                	mov    eax,DWORD PTR [eax]
    45b1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								n = pp->extra_pds[i].map;
    45b4:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    45b7:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    45ba:	89 d0                	mov    eax,edx
    45bc:	01 c0                	add    eax,eax
    45be:	01 d0                	add    eax,edx
    45c0:	c1 e0 02             	shl    eax,0x2
    45c3:	01 c8                	add    eax,ecx
    45c5:	05 98 00 00 00       	add    eax,0x98
    45ca:	8b 00                	mov    eax,DWORD PTR [eax]
    45cc:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								break;
    45cf:	eb 13                	jmp    45e4 <mm_map64+0x69b>
				for (size_t i = 0; i < pp->ec_pd; i++)
    45d1:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
    45d5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    45d8:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    45dc:	0f b7 c0             	movzx  eax,ax
    45df:	39 45 cc             	cmp    DWORD PTR [ebp-0x34],eax
    45e2:	72 98                	jb     457c <mm_map64+0x633>
						}
				if (!pd) { /* no index -> only default ones left */
    45e4:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    45e8:	75 46                	jne    4630 <mm_map64+0x6e7>
						if (pml4e == 0 && pdpte == 0) {
    45ea:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    45ee:	75 1a                	jne    460a <mm_map64+0x6c1>
    45f0:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    45f4:	75 14                	jne    460a <mm_map64+0x6c1>
								pd = pp->pl1;
    45f6:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    45f9:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    45fc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								n = pp->n1;
    45ff:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4602:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    4605:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    4608:	eb 3c                	jmp    4646 <mm_map64+0x6fd>
						} else if (pml4e == 511 && pdpte == 511) {
    460a:	81 7d f4 ff 01 00 00 	cmp    DWORD PTR [ebp-0xc],0x1ff
    4611:	75 20                	jne    4633 <mm_map64+0x6ea>
    4613:	81 7d f0 ff 01 00 00 	cmp    DWORD PTR [ebp-0x10],0x1ff
    461a:	75 17                	jne    4633 <mm_map64+0x6ea>
								pd = pp->pl2;
    461c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    461f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    4622:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								n = pp->n2;
    4625:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4628:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    462b:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    462e:	eb 16                	jmp    4646 <mm_map64+0x6fd>
						}
				}
		}

		/* now select the page table */
new_pt:
    4630:	90                   	nop
    4631:	eb 13                	jmp    4646 <mm_map64+0x6fd>
								puts("pre-paging exhausted.");
    4633:	83 ec 0c             	sub    esp,0xc
    4636:	68 92 00 00 00       	push   0x92
    463b:	e8 fc ff ff ff       	call   463c <mm_map64+0x6f3>
    4640:	83 c4 10             	add    esp,0x10
								while (1);
    4643:	90                   	nop
    4644:	eb fd                	jmp    4643 <mm_map64+0x6fa>
		if (!n->pts[pde]) {
    4646:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    4649:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    464c:	8d 14 d0             	lea    edx,[eax+edx*8]
    464f:	8b 02                	mov    eax,DWORD PTR [edx]
    4651:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4654:	89 c1                	mov    ecx,eax
    4656:	89 c8                	mov    eax,ecx
    4658:	09 d0                	or     eax,edx
    465a:	0f 85 86 01 00 00    	jne    47e6 <mm_map64+0x89d>
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
    4660:	83 ec 04             	sub    esp,0x4
    4663:	6a 01                	push   0x1
    4665:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
    466b:	50                   	push   eax
    466c:	6a 01                	push   0x1
    466e:	e8 fc ff ff ff       	call   466f <mm_map64+0x726>
    4673:	83 c4 10             	add    esp,0x10
				n->pts[pde] = vp->cur;
    4676:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4679:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    467c:	8b 00                	mov    eax,DWORD PTR [eax]
    467e:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    4681:	8b 5d ec             	mov    ebx,DWORD PTR [ebp-0x14]
    4684:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    4687:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    468b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    468e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4691:	8b 00                	mov    eax,DWORD PTR [eax]
    4693:	05 00 f0 ff ff       	add    eax,0xfffff000
    4698:	83 d2 ff             	adc    edx,0xffffffff
    469b:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    469e:	89 01                	mov    DWORD PTR [ecx],eax
    46a0:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				pt = (void*)pr2.base;
    46a3:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    46a9:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [ebp-0x84]
    46af:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
    46b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    46b5:	c1 e0 12             	shl    eax,0x12
    46b8:	89 c2                	mov    edx,eax
					   	| (pdpte << 9) | pde;
    46ba:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    46bd:	c1 e0 09             	shl    eax,0x9
    46c0:	09 c2                	or     edx,eax
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
    46c2:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    46c5:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    46c9:	0f b7 c8             	movzx  ecx,ax
					   	| (pdpte << 9) | pde;
    46cc:	0b 55 ec             	or     edx,DWORD PTR [ebp-0x14]
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
    46cf:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    46d2:	83 c1 36             	add    ecx,0x36
    46d5:	89 54 c8 08          	mov    DWORD PTR [eax+ecx*8+0x8],edx
				pp->extra_pts[pp->ec_pt++].pt = pt;
    46d9:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    46dc:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    46e0:	8d 48 01             	lea    ecx,[eax+0x1]
    46e3:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    46e6:	66 89 4a 30          	mov    WORD PTR [edx+0x30],cx
    46ea:	0f b7 d0             	movzx  edx,ax
    46ed:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    46f0:	8d 4a 36             	lea    ecx,[edx+0x36]
    46f3:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    46f6:	89 54 c8 04          	mov    DWORD PTR [eax+ecx*8+0x4],edx
				if (pp->ec_pt > 64)
    46fa:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    46fd:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    4701:	66 83 f8 40          	cmp    ax,0x40
    4705:	76 03                	jbe    470a <mm_map64+0x7c1>
					while (1); /* exhausted too */
    4707:	90                   	nop
    4708:	eb fd                	jmp    4707 <mm_map64+0x7be>

				/* and set the reference in the PD */
				pd[pde].addr = (uint64_t)pt / 4096;
    470a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    470d:	99                   	cdq
    470e:	0f ac d0 0c          	shrd   eax,edx,0xc
    4712:	c1 ea 0c             	shr    edx,0xc
    4715:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    4718:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    471f:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    4722:	01 d9                	add    ecx,ebx
    4724:	81 e2 ff 00 00 00    	and    edx,0xff
    472a:	89 c3                	mov    ebx,eax
    472c:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    4732:	89 de                	mov    esi,ebx
    4734:	c1 e6 0c             	shl    esi,0xc
    4737:	8b 19                	mov    ebx,DWORD PTR [ecx]
    4739:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    473f:	09 f3                	or     ebx,esi
    4741:	89 19                	mov    DWORD PTR [ecx],ebx
    4743:	89 c3                	mov    ebx,eax
    4745:	c1 eb 14             	shr    ebx,0x14
    4748:	89 de                	mov    esi,ebx
    474a:	66 81 e6 ff 0f       	and    si,0xfff
    474f:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    4753:	66 81 e3 00 f0       	and    bx,0xf000
    4758:	09 f3                	or     ebx,esi
    475a:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    475e:	0f b6 c2             	movzx  eax,dl
    4761:	c1 e0 0c             	shl    eax,0xc
    4764:	89 c2                	mov    edx,eax
    4766:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4769:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    476e:	09 d0                	or     eax,edx
    4770:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pd[pde].u = 1;
    4773:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4776:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    477d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4780:	01 d0                	add    eax,edx
    4782:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4785:	83 ca 04             	or     edx,0x4
    4788:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
    478a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    478d:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4794:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4797:	01 d0                	add    eax,edx
    4799:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    479c:	83 ca 02             	or     edx,0x2
    479f:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
    47a1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    47a4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    47ab:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    47ae:	01 d0                	add    eax,edx
    47b0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    47b3:	83 ca 01             	or     edx,0x1
    47b6:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map64(n->pts[pde], &pr2, 1, 0, 1, 0, 0);
    47b8:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    47bb:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    47be:	8d 14 d0             	lea    edx,[eax+edx*8]
    47c1:	8b 02                	mov    eax,DWORD PTR [edx]
    47c3:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    47c6:	6a 00                	push   0x0
    47c8:	6a 00                	push   0x0
    47ca:	6a 01                	push   0x1
    47cc:	6a 00                	push   0x0
    47ce:	6a 01                	push   0x1
    47d0:	8d 8d 78 ff ff ff    	lea    ecx,[ebp-0x88]
    47d6:	51                   	push   ecx
    47d7:	52                   	push   edx
    47d8:	50                   	push   eax
    47d9:	e8 fc ff ff ff       	call   47da <mm_map64+0x891>
    47de:	83 c4 20             	add    esp,0x20
    47e1:	e9 d4 02 00 00       	jmp    4aba <mm_map64+0xb71>
		} else {
				uint32_t id = (pml4e << 18) | (pdpte << 9) | pde;
    47e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    47e9:	c1 e0 12             	shl    eax,0x12
    47ec:	89 c2                	mov    edx,eax
    47ee:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    47f1:	c1 e0 09             	shl    eax,0x9
    47f4:	09 d0                	or     eax,edx
    47f6:	0b 45 ec             	or     eax,DWORD PTR [ebp-0x14]
    47f9:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
    47fc:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    4803:	eb 28                	jmp    482d <mm_map64+0x8e4>
						if (pp->extra_pts[i].idx == id) {
    4805:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4808:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    480b:	83 c2 36             	add    edx,0x36
    480e:	8b 44 d0 08          	mov    eax,DWORD PTR [eax+edx*8+0x8]
    4812:	39 45 a8             	cmp    DWORD PTR [ebp-0x58],eax
    4815:	75 12                	jne    4829 <mm_map64+0x8e0>
								pt = pp->extra_pts[i].pt;
    4817:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    481a:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    481d:	83 c2 36             	add    edx,0x36
    4820:	8b 44 d0 04          	mov    eax,DWORD PTR [eax+edx*8+0x4]
    4824:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								break;
    4827:	eb 13                	jmp    483c <mm_map64+0x8f3>
				for (size_t i = 0; i < pp->ec_pt; i++)
    4829:	83 45 c8 01          	add    DWORD PTR [ebp-0x38],0x1
    482d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4830:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    4834:	0f b7 c0             	movzx  eax,ax
    4837:	39 45 c8             	cmp    DWORD PTR [ebp-0x38],eax
    483a:	72 c9                	jb     4805 <mm_map64+0x8bc>
						}
				if (!pt) { /* no index -> only default ones left */
    483c:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    4840:	0f 85 74 02 00 00    	jne    4aba <mm_map64+0xb71>
						if (pml4e == 0 && pdpte == 0 && pde == 0) {
    4846:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    484a:	75 17                	jne    4863 <mm_map64+0x91a>
    484c:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    4850:	75 11                	jne    4863 <mm_map64+0x91a>
    4852:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    4856:	75 0b                	jne    4863 <mm_map64+0x91a>
								pt = pp->pt1;
    4858:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    485b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    485e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    4861:	eb 39                	jmp    489c <mm_map64+0x953>
						} else if (pml4e == 511 && pdpte == 511 && pde == 511) {
    4863:	81 7d f4 ff 01 00 00 	cmp    DWORD PTR [ebp-0xc],0x1ff
    486a:	75 1d                	jne    4889 <mm_map64+0x940>
    486c:	81 7d f0 ff 01 00 00 	cmp    DWORD PTR [ebp-0x10],0x1ff
    4873:	75 14                	jne    4889 <mm_map64+0x940>
    4875:	81 7d ec ff 01 00 00 	cmp    DWORD PTR [ebp-0x14],0x1ff
    487c:	75 0b                	jne    4889 <mm_map64+0x940>
								pt = pp->pt2;
    487e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4881:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    4884:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    4887:	eb 13                	jmp    489c <mm_map64+0x953>
						} else {
								puts("pre-paging exhausted.");
    4889:	83 ec 0c             	sub    esp,0xc
    488c:	68 92 00 00 00       	push   0x92
    4891:	e8 fc ff ff ff       	call   4892 <mm_map64+0x949>
    4896:	83 c4 10             	add    esp,0x10
								while (1);
    4899:	90                   	nop
    489a:	eb fd                	jmp    4899 <mm_map64+0x950>
						}
				}
		}

		/* now map the pages */
		while (prc) {
    489c:	e9 19 02 00 00       	jmp    4aba <mm_map64+0xb71>
#ifdef VM_DIAG
				putb(pte); putc(' '); put32(pr_copy.base); putstr("   ");
#endif
				pt[pte].addr = pr_copy.base / 4096;
    48a1:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    48a4:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    48a7:	0f ac d0 0c          	shrd   eax,edx,0xc
    48ab:	c1 ea 0c             	shr    edx,0xc
    48ae:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    48b1:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    48b8:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    48bb:	01 d9                	add    ecx,ebx
    48bd:	81 e2 ff 00 00 00    	and    edx,0xff
    48c3:	89 c3                	mov    ebx,eax
    48c5:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    48cb:	89 de                	mov    esi,ebx
    48cd:	c1 e6 0c             	shl    esi,0xc
    48d0:	8b 19                	mov    ebx,DWORD PTR [ecx]
    48d2:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    48d8:	09 f3                	or     ebx,esi
    48da:	89 19                	mov    DWORD PTR [ecx],ebx
    48dc:	89 c3                	mov    ebx,eax
    48de:	c1 eb 14             	shr    ebx,0x14
    48e1:	89 de                	mov    esi,ebx
    48e3:	66 81 e6 ff 0f       	and    si,0xfff
    48e8:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    48ec:	66 81 e3 00 f0       	and    bx,0xf000
    48f1:	09 f3                	or     ebx,esi
    48f3:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    48f7:	0f b6 c2             	movzx  eax,dl
    48fa:	c1 e0 0c             	shl    eax,0xc
    48fd:	89 c2                	mov    edx,eax
    48ff:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4902:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4907:	09 d0                	or     eax,edx
    4909:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt[pte].u = (us ? 1 : 0);
    490c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    490f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4916:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4919:	01 d0                	add    eax,edx
    491b:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
    491f:	0f 95 c2             	setne  dl
    4922:	83 e2 01             	and    edx,0x1
    4925:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    492c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    492f:	83 e2 fb             	and    edx,0xfffffffb
    4932:	09 ca                	or     edx,ecx
    4934:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].xd = ((x || !has_nx) ? 0 : 1);
    4936:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    493a:	75 10                	jne    494c <mm_map64+0xa03>
    493c:	a1 00 00 00 00       	mov    eax,ds:0x0
    4941:	85 c0                	test   eax,eax
    4943:	74 07                	je     494c <mm_map64+0xa03>
    4945:	b9 01 00 00 00       	mov    ecx,0x1
    494a:	eb 05                	jmp    4951 <mm_map64+0xa08>
    494c:	b9 00 00 00 00       	mov    ecx,0x0
    4951:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4954:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    495b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    495e:	01 c2                	add    edx,eax
    4960:	89 c8                	mov    eax,ecx
    4962:	83 e0 01             	and    eax,0x1
    4965:	c1 e0 07             	shl    eax,0x7
    4968:	89 c1                	mov    ecx,eax
    496a:	0f b6 42 07          	movzx  eax,BYTE PTR [edx+0x7]
    496e:	83 e0 7f             	and    eax,0x7f
    4971:	09 c8                	or     eax,ecx
    4973:	88 42 07             	mov    BYTE PTR [edx+0x7],al
				pt[pte].w = (w ? 1 : 0);
    4976:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4979:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4980:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4983:	01 d0                	add    eax,edx
    4985:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    4989:	0f 95 c2             	setne  dl
    498c:	83 e2 01             	and    edx,0x1
    498f:	8d 0c 12             	lea    ecx,[edx+edx*1]
    4992:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4995:	83 e2 fd             	and    edx,0xfffffffd
    4998:	09 ca                	or     edx,ecx
    499a:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
    499c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    499f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    49a6:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    49a9:	01 d0                	add    eax,edx
    49ab:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    49ae:	83 ca 01             	or     edx,0x1
    49b1:	88 10                	mov    BYTE PTR [eax],dl
				//pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
    49b3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    49b6:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    49bd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    49c0:	01 d0                	add    eax,edx
    49c2:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    49c6:	0f 95 c2             	setne  dl
    49c9:	83 e2 01             	and    edx,0x1
    49cc:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    49d3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    49d6:	83 e2 f7             	and    edx,0xfffffff7
    49d9:	09 ca                	or     edx,ecx
    49db:	88 10                	mov    BYTE PTR [eax],dl

				/* advance */
				pr_copy.base += 4096;
    49dd:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    49e0:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    49e3:	05 00 10 00 00       	add    eax,0x1000
    49e8:	83 d2 00             	adc    edx,0x0
    49eb:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
    49ee:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
				if (!--pr_copy.count) {
    49f1:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    49f4:	83 e8 01             	sub    eax,0x1
    49f7:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    49fa:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    49fd:	85 c0                	test   eax,eax
    49ff:	75 2d                	jne    4a2e <mm_map64+0xae5>
						if (--prc)
    4a01:	83 6d 14 01          	sub    DWORD PTR [ebp+0x14],0x1
    4a05:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    4a09:	74 18                	je     4a23 <mm_map64+0xada>
								pr_copy = *++pr; /* important: advance then dereference */
    4a0b:	83 45 10 0c          	add    DWORD PTR [ebp+0x10],0xc
    4a0f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    4a12:	8b 10                	mov    edx,DWORD PTR [eax]
    4a14:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
    4a17:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4a1a:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
    4a1d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4a20:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
						if (!pr_copy.count)
    4a23:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    4a26:	85 c0                	test   eax,eax
    4a28:	0f 84 98 00 00 00    	je     4ac6 <mm_map64+0xb7d>
							break; /* skip alloc if done */
				}
				/* allocate if needed */
				if (pte++ == 511) {
    4a2e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4a31:	8d 50 01             	lea    edx,[eax+0x1]
    4a34:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    4a37:	3d ff 01 00 00       	cmp    eax,0x1ff
    4a3c:	75 7c                	jne    4aba <mm_map64+0xb71>
						if (pde++ == 511) {
    4a3e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4a41:	8d 50 01             	lea    edx,[eax+0x1]
    4a44:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    4a47:	3d ff 01 00 00       	cmp    eax,0x1ff
    4a4c:	75 60                	jne    4aae <mm_map64+0xb65>
								if (pdpte++ == 511) {
    4a4e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4a51:	8d 50 01             	lea    edx,[eax+0x1]
    4a54:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    4a57:	3d ff 01 00 00       	cmp    eax,0x1ff
    4a5c:	75 3d                	jne    4a9b <mm_map64+0xb52>
										if (pml4e++ == 511) {
    4a5e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4a61:	8d 50 01             	lea    edx,[eax+0x1]
    4a64:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    4a67:	3d ff 01 00 00       	cmp    eax,0x1ff
    4a6c:	75 13                	jne    4a81 <mm_map64+0xb38>
												puts("End of 16E address space");
    4a6e:	83 ec 0c             	sub    esp,0xc
    4a71:	68 a8 00 00 00       	push   0xa8
    4a76:	e8 fc ff ff ff       	call   4a77 <mm_map64+0xb2e>
    4a7b:	83 c4 10             	add    esp,0x10
												while (1);
    4a7e:	90                   	nop
    4a7f:	eb fd                	jmp    4a7e <mm_map64+0xb35>
										}
										pdpte = 0;
    4a81:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
										pde = 0;
    4a88:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
										pte = 0;
    4a8f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
										goto new_pdpt;
    4a96:	e9 73 f5 ff ff       	jmp    400e <mm_map64+0xc5>
								}
								pde = 0;
    4a9b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
								pte = 0;
    4aa2:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
								goto new_pd;
    4aa9:	e9 78 f8 ff ff       	jmp    4326 <mm_map64+0x3dd>
						}
						pte = 0;
    4aae:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
						goto new_pt;
    4ab5:	e9 8c fb ff ff       	jmp    4646 <mm_map64+0x6fd>
		while (prc) {
    4aba:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    4abe:	0f 85 dd fd ff ff    	jne    48a1 <mm_map64+0x958>
						put64(pr->base);
						put32(pr->count);
						while (1);
				}
		}
}
    4ac4:	eb 01                	jmp    4ac7 <mm_map64+0xb7e>
							break; /* skip alloc if done */
    4ac6:	90                   	nop
}
    4ac7:	90                   	nop
    4ac8:	8d 65 f8             	lea    esp,[ebp-0x8]
    4acb:	5b                   	pop    ebx
    4acc:	5e                   	pop    esi
    4acd:	5d                   	pop    ebp
    4ace:	c3                   	ret

00004acf <mm_map36>:

void mm_map36(uint32_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    4acf:	55                   	push   ebp
    4ad0:	89 e5                	mov    ebp,esp
    4ad2:	56                   	push   esi
    4ad3:	53                   	push   ebx
    4ad4:	83 ec 40             	sub    esp,0x40
		struct vm_pg_ptrs36* vp = vm_mapping;
    4ad7:	a1 00 00 00 00       	mov    eax,ds:0x0
    4adc:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		struct pm_pg36_ptrs* pp = pm_mapping;
    4adf:	a1 00 00 00 00       	mov    eax,ds:0x0
    4ae4:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		uint32_t pdpte, pde, pte;
		struct page_range pr_copy = *pr;
    4ae7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4aea:	8b 10                	mov    edx,DWORD PTR [eax]
    4aec:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    4aef:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4af2:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    4af5:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4af8:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax

		/* physical pointers */
		struct pte64* pd = 0;
    4afb:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		struct pte64* pt = 0;
    4b02:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0

		/* and the PDPTE */
		pdpte = (vaddr & 0xc0000000) >> 30; /* 1G per PDPTE */
    4b09:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4b0c:	c1 e8 1e             	shr    eax,0x1e
    4b0f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		pd = pp->pds[pdpte];
    4b12:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4b15:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4b18:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    4b1c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* and the PDE */
		pde = (vaddr & 0x3fe00000) >> 21; /* 2M per PDE */
    4b1f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4b22:	c1 e8 15             	shr    eax,0x15
    4b25:	25 ff 01 00 00       	and    eax,0x1ff
    4b2a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and finally the PTE */
		pte = (vaddr & 0x1ff000) >> 12; /* 4K per PTE */
    4b2d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4b30:	c1 e8 0c             	shr    eax,0xc
    4b33:	25 ff 01 00 00       	and    eax,0x1ff
    4b38:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* create a PT if not there */
new_pt:
		if (!pd[pde].p) {
    4b3b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4b3e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4b45:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4b48:	01 d0                	add    eax,edx
    4b4a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    4b4d:	83 e0 01             	and    eax,0x1
    4b50:	84 c0                	test   al,al
    4b52:	0f 85 74 01 00 00    	jne    4ccc <mm_map36+0x1fd>
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
    4b58:	83 ec 04             	sub    esp,0x4
    4b5b:	6a 01                	push   0x1
    4b5d:	8d 45 bc             	lea    eax,[ebp-0x44]
    4b60:	50                   	push   eax
    4b61:	6a 01                	push   0x1
    4b63:	e8 fc ff ff ff       	call   4b64 <mm_map36+0x95>
    4b68:	83 c4 10             	add    esp,0x10
				vp->pts[pdpte * 512 + pde] = vp->cur;
    4b6b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4b6e:	c1 e0 09             	shl    eax,0x9
    4b71:	89 c2                	mov    edx,eax
    4b73:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4b76:	8d 0c 02             	lea    ecx,[edx+eax*1]
    4b79:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4b7c:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    4b7f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4b82:	83 c1 0c             	add    ecx,0xc
    4b85:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
				vp->cur -= 4096;
    4b89:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4b8c:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    4b8f:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    4b95:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4b98:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				pt = (void*)pr2.base;
    4b9b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    4b9e:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    4ba1:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = (pdpte << 9) | pde;
    4ba4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4ba7:	c1 e0 09             	shl    eax,0x9
    4baa:	89 c2                	mov    edx,eax
    4bac:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4baf:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    4bb2:	0b 55 f0             	or     edx,DWORD PTR [ebp-0x10]
    4bb5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4bb8:	83 c1 04             	add    ecx,0x4
    4bbb:	89 54 c8 04          	mov    DWORD PTR [eax+ecx*8+0x4],edx
				pp->extra_pts[pp->ec_pt++].pt = pt;
    4bbf:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4bc2:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    4bc5:	8d 48 01             	lea    ecx,[eax+0x1]
    4bc8:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    4bcb:	89 4a 1c             	mov    DWORD PTR [edx+0x1c],ecx
    4bce:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    4bd1:	8d 48 04             	lea    ecx,[eax+0x4]
    4bd4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4bd7:	89 04 ca             	mov    DWORD PTR [edx+ecx*8],eax
				if (pp->ec_pt > 64)
    4bda:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4bdd:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    4be0:	83 f8 40             	cmp    eax,0x40
    4be3:	76 03                	jbe    4be8 <mm_map36+0x119>
					while (1); /* exhausted too */
    4be5:	90                   	nop
    4be6:	eb fd                	jmp    4be5 <mm_map36+0x116>

				/* and set the reference in the PD */
				pd[pde].addr = (uint64_t)pt / 4096;
    4be8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4beb:	99                   	cdq
    4bec:	0f ac d0 0c          	shrd   eax,edx,0xc
    4bf0:	c1 ea 0c             	shr    edx,0xc
    4bf3:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    4bf6:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    4bfd:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    4c00:	01 d9                	add    ecx,ebx
    4c02:	81 e2 ff 00 00 00    	and    edx,0xff
    4c08:	89 c3                	mov    ebx,eax
    4c0a:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    4c10:	89 de                	mov    esi,ebx
    4c12:	c1 e6 0c             	shl    esi,0xc
    4c15:	8b 19                	mov    ebx,DWORD PTR [ecx]
    4c17:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    4c1d:	09 f3                	or     ebx,esi
    4c1f:	89 19                	mov    DWORD PTR [ecx],ebx
    4c21:	89 c3                	mov    ebx,eax
    4c23:	c1 eb 14             	shr    ebx,0x14
    4c26:	89 de                	mov    esi,ebx
    4c28:	66 81 e6 ff 0f       	and    si,0xfff
    4c2d:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    4c31:	66 81 e3 00 f0       	and    bx,0xf000
    4c36:	09 f3                	or     ebx,esi
    4c38:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4c3c:	0f b6 c2             	movzx  eax,dl
    4c3f:	c1 e0 0c             	shl    eax,0xc
    4c42:	89 c2                	mov    edx,eax
    4c44:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4c47:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4c4c:	09 d0                	or     eax,edx
    4c4e:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pd[pde].u = 1;
    4c51:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4c54:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4c5b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4c5e:	01 d0                	add    eax,edx
    4c60:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4c63:	83 ca 04             	or     edx,0x4
    4c66:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
    4c68:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4c6b:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4c72:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4c75:	01 d0                	add    eax,edx
    4c77:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4c7a:	83 ca 02             	or     edx,0x2
    4c7d:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
    4c7f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4c82:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4c89:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4c8c:	01 d0                	add    eax,edx
    4c8e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4c91:	83 ca 01             	or     edx,0x1
    4c94:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map36(vp->pts[pdpte * 512 + pde], &pr2, 1, 0, 1, 0, 0);
    4c96:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4c99:	c1 e0 09             	shl    eax,0x9
    4c9c:	89 c2                	mov    edx,eax
    4c9e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4ca1:	01 c2                	add    edx,eax
    4ca3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4ca6:	83 c2 0c             	add    edx,0xc
    4ca9:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    4cad:	83 ec 04             	sub    esp,0x4
    4cb0:	6a 00                	push   0x0
    4cb2:	6a 00                	push   0x0
    4cb4:	6a 01                	push   0x1
    4cb6:	6a 00                	push   0x0
    4cb8:	6a 01                	push   0x1
    4cba:	8d 55 bc             	lea    edx,[ebp-0x44]
    4cbd:	52                   	push   edx
    4cbe:	50                   	push   eax
    4cbf:	e8 fc ff ff ff       	call   4cc0 <mm_map36+0x1f1>
    4cc4:	83 c4 20             	add    esp,0x20
    4cc7:	e9 90 02 00 00       	jmp    4f5c <mm_map36+0x48d>
		} else {
				uint32_t id = (pdpte << 9) | pde;
    4ccc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4ccf:	c1 e0 09             	shl    eax,0x9
    4cd2:	0b 45 f0             	or     eax,DWORD PTR [ebp-0x10]
    4cd5:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
    4cd8:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    4cdf:	eb 27                	jmp    4d08 <mm_map36+0x239>
						if (pp->extra_pts[i].idx == id) {
    4ce1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4ce4:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    4ce7:	83 c2 04             	add    edx,0x4
    4cea:	8b 44 d0 04          	mov    eax,DWORD PTR [eax+edx*8+0x4]
    4cee:	39 45 d4             	cmp    DWORD PTR [ebp-0x2c],eax
    4cf1:	75 11                	jne    4d04 <mm_map36+0x235>
								pt = pp->extra_pts[i].pt;
    4cf3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4cf6:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    4cf9:	83 c2 04             	add    edx,0x4
    4cfc:	8b 04 d0             	mov    eax,DWORD PTR [eax+edx*8]
    4cff:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								break;
    4d02:	eb 0f                	jmp    4d13 <mm_map36+0x244>
				for (size_t i = 0; i < pp->ec_pt; i++)
    4d04:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    4d08:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4d0b:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    4d0e:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    4d11:	72 ce                	jb     4ce1 <mm_map36+0x212>
						}
				if (!pt) { /* no index -> only default ones left */
    4d13:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    4d17:	0f 85 3f 02 00 00    	jne    4f5c <mm_map36+0x48d>
						if (pdpte == 0 && pde == 0) {
    4d1d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4d21:	75 11                	jne    4d34 <mm_map36+0x265>
    4d23:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    4d27:	75 0b                	jne    4d34 <mm_map36+0x265>
								pt = pp->pt1;
    4d29:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4d2c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    4d2f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    4d32:	eb 2d                	jmp    4d61 <mm_map36+0x292>
						} else if (pdpte == 3 && pde == 511) {
    4d34:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    4d38:	75 14                	jne    4d4e <mm_map36+0x27f>
    4d3a:	81 7d f0 ff 01 00 00 	cmp    DWORD PTR [ebp-0x10],0x1ff
    4d41:	75 0b                	jne    4d4e <mm_map36+0x27f>
								pt = pp->pt2;
    4d43:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4d46:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    4d49:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    4d4c:	eb 13                	jmp    4d61 <mm_map36+0x292>
						} else {
								puts("pre-paging exhausted.");
    4d4e:	83 ec 0c             	sub    esp,0xc
    4d51:	68 92 00 00 00       	push   0x92
    4d56:	e8 fc ff ff ff       	call   4d57 <mm_map36+0x288>
    4d5b:	83 c4 10             	add    esp,0x10
								while (1);
    4d5e:	90                   	nop
    4d5f:	eb fd                	jmp    4d5e <mm_map36+0x28f>
						}
				}
		}

		/* now map the pages */
		while (prc) {
    4d61:	e9 f6 01 00 00       	jmp    4f5c <mm_map36+0x48d>
				pt[pte].addr = pr_copy.base / 4096;
    4d66:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    4d69:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    4d6c:	0f ac d0 0c          	shrd   eax,edx,0xc
    4d70:	c1 ea 0c             	shr    edx,0xc
    4d73:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    4d76:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    4d7d:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    4d80:	01 d9                	add    ecx,ebx
    4d82:	81 e2 ff 00 00 00    	and    edx,0xff
    4d88:	89 c3                	mov    ebx,eax
    4d8a:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    4d90:	89 de                	mov    esi,ebx
    4d92:	c1 e6 0c             	shl    esi,0xc
    4d95:	8b 19                	mov    ebx,DWORD PTR [ecx]
    4d97:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    4d9d:	09 f3                	or     ebx,esi
    4d9f:	89 19                	mov    DWORD PTR [ecx],ebx
    4da1:	89 c3                	mov    ebx,eax
    4da3:	c1 eb 14             	shr    ebx,0x14
    4da6:	89 de                	mov    esi,ebx
    4da8:	66 81 e6 ff 0f       	and    si,0xfff
    4dad:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    4db1:	66 81 e3 00 f0       	and    bx,0xf000
    4db6:	09 f3                	or     ebx,esi
    4db8:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4dbc:	0f b6 c2             	movzx  eax,dl
    4dbf:	c1 e0 0c             	shl    eax,0xc
    4dc2:	89 c2                	mov    edx,eax
    4dc4:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4dc7:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4dcc:	09 d0                	or     eax,edx
    4dce:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt[pte].u = (us ? 1 : 0);
    4dd1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4dd4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4ddb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4dde:	01 d0                	add    eax,edx
    4de0:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    4de4:	0f 95 c2             	setne  dl
    4de7:	83 e2 01             	and    edx,0x1
    4dea:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    4df1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4df4:	83 e2 fb             	and    edx,0xfffffffb
    4df7:	09 ca                	or     edx,ecx
    4df9:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].xd = ((x || !has_nx) ? 0 : 1);
    4dfb:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    4dff:	75 10                	jne    4e11 <mm_map36+0x342>
    4e01:	a1 00 00 00 00       	mov    eax,ds:0x0
    4e06:	85 c0                	test   eax,eax
    4e08:	74 07                	je     4e11 <mm_map36+0x342>
    4e0a:	b9 01 00 00 00       	mov    ecx,0x1
    4e0f:	eb 05                	jmp    4e16 <mm_map36+0x347>
    4e11:	b9 00 00 00 00       	mov    ecx,0x0
    4e16:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4e19:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4e20:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4e23:	01 c2                	add    edx,eax
    4e25:	89 c8                	mov    eax,ecx
    4e27:	83 e0 01             	and    eax,0x1
    4e2a:	c1 e0 07             	shl    eax,0x7
    4e2d:	89 c1                	mov    ecx,eax
    4e2f:	0f b6 42 07          	movzx  eax,BYTE PTR [edx+0x7]
    4e33:	83 e0 7f             	and    eax,0x7f
    4e36:	09 c8                	or     eax,ecx
    4e38:	88 42 07             	mov    BYTE PTR [edx+0x7],al
				pt[pte].w = (w ? 1 : 0);
    4e3b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4e3e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4e45:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4e48:	01 d0                	add    eax,edx
    4e4a:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    4e4e:	0f 95 c2             	setne  dl
    4e51:	83 e2 01             	and    edx,0x1
    4e54:	8d 0c 12             	lea    ecx,[edx+edx*1]
    4e57:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4e5a:	83 e2 fd             	and    edx,0xfffffffd
    4e5d:	09 ca                	or     edx,ecx
    4e5f:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
    4e61:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4e64:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4e6b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4e6e:	01 d0                	add    eax,edx
    4e70:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4e73:	83 ca 01             	or     edx,0x1
    4e76:	88 10                	mov    BYTE PTR [eax],dl
				//pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
    4e78:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4e7b:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4e82:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4e85:	01 d0                	add    eax,edx
    4e87:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    4e8b:	0f 95 c2             	setne  dl
    4e8e:	83 e2 01             	and    edx,0x1
    4e91:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    4e98:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4e9b:	83 e2 f7             	and    edx,0xfffffff7
    4e9e:	09 ca                	or     edx,ecx
    4ea0:	88 10                	mov    BYTE PTR [eax],dl

				/* advance if needed */
				pr_copy.base += 4096;
    4ea2:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    4ea5:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    4ea8:	05 00 10 00 00       	add    eax,0x1000
    4ead:	83 d2 00             	adc    edx,0x0
    4eb0:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    4eb3:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (!--pr_copy.count) {
    4eb6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    4eb9:	83 e8 01             	sub    eax,0x1
    4ebc:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    4ebf:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    4ec2:	85 c0                	test   eax,eax
    4ec4:	75 29                	jne    4eef <mm_map36+0x420>
						if (--prc)
    4ec6:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
    4eca:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    4ece:	74 18                	je     4ee8 <mm_map36+0x419>
								pr_copy = *++pr; /* important: advance then dereference */
    4ed0:	83 45 0c 0c          	add    DWORD PTR [ebp+0xc],0xc
    4ed4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4ed7:	8b 10                	mov    edx,DWORD PTR [eax]
    4ed9:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    4edc:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4edf:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    4ee2:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4ee5:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
						if (!pr_copy.count)
    4ee8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    4eeb:	85 c0                	test   eax,eax
    4eed:	74 79                	je     4f68 <mm_map36+0x499>
							break;
				}
				if (pte++ == 511) {
    4eef:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4ef2:	8d 50 01             	lea    edx,[eax+0x1]
    4ef5:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    4ef8:	3d ff 01 00 00       	cmp    eax,0x1ff
    4efd:	75 5d                	jne    4f5c <mm_map36+0x48d>
						if (pde++ == 511) {
    4eff:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4f02:	8d 50 01             	lea    edx,[eax+0x1]
    4f05:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    4f08:	3d ff 01 00 00       	cmp    eax,0x1ff
    4f0d:	75 41                	jne    4f50 <mm_map36+0x481>
								if (pdpte++ == 3) {
    4f0f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4f12:	8d 50 01             	lea    edx,[eax+0x1]
    4f15:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    4f18:	83 f8 03             	cmp    eax,0x3
    4f1b:	75 13                	jne    4f30 <mm_map36+0x461>
										puts("End of 4G address space");
    4f1d:	83 ec 0c             	sub    esp,0xc
    4f20:	68 c1 00 00 00       	push   0xc1
    4f25:	e8 fc ff ff ff       	call   4f26 <mm_map36+0x457>
    4f2a:	83 c4 10             	add    esp,0x10
										while (1);
    4f2d:	90                   	nop
    4f2e:	eb fd                	jmp    4f2d <mm_map36+0x45e>
								}
								pd = pp->pds[pdpte];
    4f30:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4f33:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4f36:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    4f3a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								pde = 0;
    4f3d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
								pte = 0;
    4f44:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
								goto new_pt;
    4f4b:	e9 eb fb ff ff       	jmp    4b3b <mm_map36+0x6c>
						}
						pte = 0;
    4f50:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						goto new_pt;
    4f57:	e9 df fb ff ff       	jmp    4b3b <mm_map36+0x6c>
		while (prc) {
    4f5c:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    4f60:	0f 85 00 fe ff ff    	jne    4d66 <mm_map36+0x297>
				}
		}
}
    4f66:	eb 01                	jmp    4f69 <mm_map36+0x49a>
							break;
    4f68:	90                   	nop
}
    4f69:	90                   	nop
    4f6a:	8d 65 f8             	lea    esp,[ebp-0x8]
    4f6d:	5b                   	pop    ebx
    4f6e:	5e                   	pop    esi
    4f6f:	5d                   	pop    ebp
    4f70:	c3                   	ret

00004f71 <mm_map32>:

void mm_map32(uint32_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    4f71:	55                   	push   ebp
    4f72:	89 e5                	mov    ebp,esp
    4f74:	53                   	push   ebx
    4f75:	83 ec 44             	sub    esp,0x44
		struct vm_pg_ptrs32* vp = vm_mapping;
    4f78:	a1 00 00 00 00       	mov    eax,ds:0x0
    4f7d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct pm_pg32_ptrs* pp = pm_mapping;
    4f80:	a1 00 00 00 00       	mov    eax,ds:0x0
    4f85:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		uint32_t pde, pte;
		struct page_range pr_copy = *pr;
    4f88:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4f8b:	8b 10                	mov    edx,DWORD PTR [eax]
    4f8d:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    4f90:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4f93:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    4f96:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4f99:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax

		/* physical pointers */
		struct pte32* pd = pp->pd;
    4f9c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4f9f:	8b 00                	mov    eax,DWORD PTR [eax]
    4fa1:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		struct pte32* pt = 0;
    4fa4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0

		/* and the PDE */
		pde = (vaddr & 0xffc00000) >> 22; /* 4M per PDE */
    4fab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4fae:	c1 e8 16             	shr    eax,0x16
    4fb1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* and finally the PTE */
		pte = (vaddr & 0x3ff000) >> 12; /* 4K per PTE */
    4fb4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4fb7:	c1 e8 0c             	shr    eax,0xc
    4fba:	25 ff 03 00 00       	and    eax,0x3ff
    4fbf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

new_pt:
		/* create a PT if not there */
		if (!pd[pde].p) {
    4fc2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4fc5:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4fcc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4fcf:	01 d0                	add    eax,edx
    4fd1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    4fd4:	83 e0 01             	and    eax,0x1
    4fd7:	84 c0                	test   al,al
    4fd9:	0f 85 13 01 00 00    	jne    50f2 <mm_map32+0x181>
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
    4fdf:	83 ec 04             	sub    esp,0x4
    4fe2:	6a 01                	push   0x1
    4fe4:	8d 45 c0             	lea    eax,[ebp-0x40]
    4fe7:	50                   	push   eax
    4fe8:	6a 01                	push   0x1
    4fea:	e8 fc ff ff ff       	call   4feb <mm_map32+0x7a>
    4fef:	83 c4 10             	add    esp,0x10
				vp->pts[pde] = vp->cur;
    4ff2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4ff5:	8b 08                	mov    ecx,DWORD PTR [eax]
    4ff7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4ffa:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4ffd:	89 4c 90 08          	mov    DWORD PTR [eax+edx*4+0x8],ecx
				vp->cur -= 4096;
    5001:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5004:	8b 00                	mov    eax,DWORD PTR [eax]
    5006:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    500c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    500f:	89 10                	mov    DWORD PTR [eax],edx
				pt = (void*)pr2.base;
    5011:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    5014:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    5017:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = pde;
    501a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    501d:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    5020:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5023:	8d 4a 02             	lea    ecx,[edx+0x2]
    5026:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    5029:	89 54 c8 04          	mov    DWORD PTR [eax+ecx*8+0x4],edx
				pp->extra_pts[pp->ec_pt++].pt = pt;
    502d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5030:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    5033:	8d 48 01             	lea    ecx,[eax+0x1]
    5036:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    5039:	89 4a 0c             	mov    DWORD PTR [edx+0xc],ecx
    503c:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    503f:	8d 48 02             	lea    ecx,[eax+0x2]
    5042:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    5045:	89 04 ca             	mov    DWORD PTR [edx+ecx*8],eax
				if (pp->ec_pt > 64)
    5048:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    504b:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    504e:	83 f8 40             	cmp    eax,0x40
    5051:	76 03                	jbe    5056 <mm_map32+0xe5>
					while (1); /* exhausted too */
    5053:	90                   	nop
    5054:	eb fd                	jmp    5053 <mm_map32+0xe2>

				/* and set the reference in the PD */
				pd[pde].addr = (uint32_t)pt / 4096;
    5056:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    5059:	c1 e8 0c             	shr    eax,0xc
    505c:	89 c2                	mov    edx,eax
    505e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    5061:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    5068:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    506b:	01 c8                	add    eax,ecx
    506d:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    5073:	89 d1                	mov    ecx,edx
    5075:	c1 e1 0c             	shl    ecx,0xc
    5078:	8b 10                	mov    edx,DWORD PTR [eax]
    507a:	81 e2 ff 0f 00 00    	and    edx,0xfff
    5080:	09 ca                	or     edx,ecx
    5082:	89 10                	mov    DWORD PTR [eax],edx
				pd[pde].u = 1;
    5084:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    5087:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    508e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    5091:	01 d0                	add    eax,edx
    5093:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    5096:	83 ca 04             	or     edx,0x4
    5099:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
    509b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    509e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    50a5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    50a8:	01 d0                	add    eax,edx
    50aa:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    50ad:	83 ca 02             	or     edx,0x2
    50b0:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
    50b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    50b5:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    50bc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    50bf:	01 d0                	add    eax,edx
    50c1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    50c4:	83 ca 01             	or     edx,0x1
    50c7:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map32(vp->pts[pde], &pr2, 1, 0, 1, 0, 0);
    50c9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    50cc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    50cf:	8b 44 90 08          	mov    eax,DWORD PTR [eax+edx*4+0x8]
    50d3:	83 ec 04             	sub    esp,0x4
    50d6:	6a 00                	push   0x0
    50d8:	6a 00                	push   0x0
    50da:	6a 01                	push   0x1
    50dc:	6a 00                	push   0x0
    50de:	6a 01                	push   0x1
    50e0:	8d 55 c0             	lea    edx,[ebp-0x40]
    50e3:	52                   	push   edx
    50e4:	50                   	push   eax
    50e5:	e8 fc ff ff ff       	call   50e6 <mm_map32+0x175>
    50ea:	83 c4 20             	add    esp,0x20
    50ed:	e9 05 02 00 00       	jmp    52f7 <mm_map32+0x386>
		} else {
				uint32_t id = pde;
    50f2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    50f5:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
    50f8:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    50ff:	eb 27                	jmp    5128 <mm_map32+0x1b7>
						if (pp->extra_pts[i].idx == id) {
    5101:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5104:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    5107:	83 c2 02             	add    edx,0x2
    510a:	8b 44 d0 04          	mov    eax,DWORD PTR [eax+edx*8+0x4]
    510e:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    5111:	75 11                	jne    5124 <mm_map32+0x1b3>
								pt = pp->extra_pts[i].pt;
    5113:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5116:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    5119:	83 c2 02             	add    edx,0x2
    511c:	8b 04 d0             	mov    eax,DWORD PTR [eax+edx*8]
    511f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								break;
    5122:	eb 0f                	jmp    5133 <mm_map32+0x1c2>
				for (size_t i = 0; i < pp->ec_pt; i++)
    5124:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
    5128:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    512b:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    512e:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    5131:	72 ce                	jb     5101 <mm_map32+0x190>
						}
				if (!pt) { /* no index -> only default ones left */
    5133:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    5137:	0f 85 ba 01 00 00    	jne    52f7 <mm_map32+0x386>
						if (pde == 0) {
    513d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    5141:	75 0e                	jne    5151 <mm_map32+0x1e0>
								pt = pp->pt1;
    5143:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5146:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    5149:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    514c:	e9 a6 01 00 00       	jmp    52f7 <mm_map32+0x386>
						} else if (pde == 1023) {
    5151:	81 7d f4 ff 03 00 00 	cmp    DWORD PTR [ebp-0xc],0x3ff
    5158:	75 0e                	jne    5168 <mm_map32+0x1f7>
								pt = pp->pt2;
    515a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    515d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5160:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    5163:	e9 8f 01 00 00       	jmp    52f7 <mm_map32+0x386>
						} else {
								puts("pre-paging exhausted.");
    5168:	83 ec 0c             	sub    esp,0xc
    516b:	68 92 00 00 00       	push   0x92
    5170:	e8 fc ff ff ff       	call   5171 <mm_map32+0x200>
    5175:	83 c4 10             	add    esp,0x10
								nput32(pde, 0);
    5178:	83 ec 08             	sub    esp,0x8
    517b:	6a 00                	push   0x0
    517d:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    5180:	e8 fc ff ff ff       	call   5181 <mm_map32+0x210>
    5185:	83 c4 10             	add    esp,0x10
								nput32(pte, 0);
    5188:	83 ec 08             	sub    esp,0x8
    518b:	6a 00                	push   0x0
    518d:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    5190:	e8 fc ff ff ff       	call   5191 <mm_map32+0x220>
    5195:	83 c4 10             	add    esp,0x10
								put32(vaddr);
    5198:	83 ec 0c             	sub    esp,0xc
    519b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    519e:	e8 fc ff ff ff       	call   519f <mm_map32+0x22e>
    51a3:	83 c4 10             	add    esp,0x10
								while (1);
    51a6:	90                   	nop
    51a7:	eb fd                	jmp    51a6 <mm_map32+0x235>
				}
		}

		/* now map the pages */
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
    51a9:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    51ac:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    51af:	0f ac d0 0c          	shrd   eax,edx,0xc
    51b3:	c1 ea 0c             	shr    edx,0xc
    51b6:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    51b9:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
    51c0:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    51c3:	01 d9                	add    ecx,ebx
    51c5:	25 ff ff 0f 00       	and    eax,0xfffff
    51ca:	c1 e0 0c             	shl    eax,0xc
    51cd:	89 c2                	mov    edx,eax
    51cf:	8b 01                	mov    eax,DWORD PTR [ecx]
    51d1:	25 ff 0f 00 00       	and    eax,0xfff
    51d6:	09 d0                	or     eax,edx
    51d8:	89 01                	mov    DWORD PTR [ecx],eax
				pt[pte].u = (us ? 1 : 0);
    51da:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    51dd:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    51e4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    51e7:	01 d0                	add    eax,edx
    51e9:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    51ed:	0f 95 c2             	setne  dl
    51f0:	83 e2 01             	and    edx,0x1
    51f3:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    51fa:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    51fd:	83 e2 fb             	and    edx,0xfffffffb
    5200:	09 ca                	or     edx,ecx
    5202:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].w = (w ? 1 : 0);
    5204:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    5207:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    520e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    5211:	01 d0                	add    eax,edx
    5213:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    5217:	0f 95 c2             	setne  dl
    521a:	83 e2 01             	and    edx,0x1
    521d:	8d 0c 12             	lea    ecx,[edx+edx*1]
    5220:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    5223:	83 e2 fd             	and    edx,0xfffffffd
    5226:	09 ca                	or     edx,ecx
    5228:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
    522a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    522d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    5234:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    5237:	01 d0                	add    eax,edx
    5239:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    523c:	83 ca 01             	or     edx,0x1
    523f:	88 10                	mov    BYTE PTR [eax],dl
//				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
    5241:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    5244:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    524b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    524e:	01 d0                	add    eax,edx
    5250:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    5254:	0f 95 c2             	setne  dl
    5257:	83 e2 01             	and    edx,0x1
    525a:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    5261:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    5264:	83 e2 f7             	and    edx,0xfffffff7
    5267:	09 ca                	or     edx,ecx
    5269:	88 10                	mov    BYTE PTR [eax],dl

				/* advance if needed */
				pr_copy.base += 4096;
    526b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    526e:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    5271:	05 00 10 00 00       	add    eax,0x1000
    5276:	83 d2 00             	adc    edx,0x0
    5279:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    527c:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
				if (!--pr_copy.count) {
    527f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    5282:	83 e8 01             	sub    eax,0x1
    5285:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    5288:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    528b:	85 c0                	test   eax,eax
    528d:	75 29                	jne    52b8 <mm_map32+0x347>
						if (--prc)
    528f:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
    5293:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    5297:	74 18                	je     52b1 <mm_map32+0x340>
								pr_copy = *++pr; /* important: advance then dereference */
    5299:	83 45 0c 0c          	add    DWORD PTR [ebp+0xc],0xc
    529d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    52a0:	8b 10                	mov    edx,DWORD PTR [eax]
    52a2:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    52a5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    52a8:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    52ab:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    52ae:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						if (!pr_copy.count)
    52b1:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    52b4:	85 c0                	test   eax,eax
    52b6:	74 4b                	je     5303 <mm_map32+0x392>
							break;
				}
				if (pte++ == 1023) {
    52b8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    52bb:	8d 50 01             	lea    edx,[eax+0x1]
    52be:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    52c1:	3d ff 03 00 00       	cmp    eax,0x3ff
    52c6:	75 2f                	jne    52f7 <mm_map32+0x386>
						if (pde++ == 1023) {
    52c8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    52cb:	8d 50 01             	lea    edx,[eax+0x1]
    52ce:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    52d1:	3d ff 03 00 00       	cmp    eax,0x3ff
    52d6:	75 13                	jne    52eb <mm_map32+0x37a>
								puts("end of 4G address space");
    52d8:	83 ec 0c             	sub    esp,0xc
    52db:	68 d9 00 00 00       	push   0xd9
    52e0:	e8 fc ff ff ff       	call   52e1 <mm_map32+0x370>
    52e5:	83 c4 10             	add    esp,0x10
								while (1);
    52e8:	90                   	nop
    52e9:	eb fd                	jmp    52e8 <mm_map32+0x377>
						}
						pte = 0;
    52eb:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
						goto new_pt;
    52f2:	e9 cb fc ff ff       	jmp    4fc2 <mm_map32+0x51>
		while (prc) {
    52f7:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    52fb:	0f 85 a8 fe ff ff    	jne    51a9 <mm_map32+0x238>
				}
		}
}
    5301:	eb 01                	jmp    5304 <mm_map32+0x393>
							break;
    5303:	90                   	nop
}
    5304:	90                   	nop
    5305:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    5308:	c9                   	leave
    5309:	c3                   	ret

0000530a <mm_perform_mapping>:

void mm_perform_mapping(int mode, uint64_t ofs, struct page_range* pr, int prc,
			   uint64_t vaddr, uint64_t fs, uint64_t ms, struct page_range* pr2,
			   int pr2c, int x, int w)
{
    530a:	55                   	push   ebp
    530b:	89 e5                	mov    ebp,esp
    530d:	56                   	push   esi
    530e:	53                   	push   ebx
    530f:	83 ec 60             	sub    esp,0x60
    5312:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    5315:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    5318:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    531b:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
    531e:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    5321:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    5324:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    5327:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
    532a:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    532d:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    5330:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    5333:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    5336:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
    5339:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    533c:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
    533f:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
		uint64_t cur = vaddr; int pro = 0;
    5342:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    5345:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    5348:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    534b:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    534e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		uint64_t po = ofs / 4096;
    5355:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    5358:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    535b:	0f ac d0 0c          	shrd   eax,edx,0xc
    535f:	c1 ea 0c             	shr    edx,0xc
    5362:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    5365:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		size_t padding = ofs % 4096;
    5368:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    536b:	25 ff 0f 00 00       	and    eax,0xfff
    5370:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		size_t zeros;
		size_t pcf, pcm;
		size_t pcf_c;

		/* calculate the page counts */
		pcf_c = pcf = rdiv(padding + fs, 4096); /* count of pages from file */
    5373:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    5376:	bb 00 00 00 00       	mov    ebx,0x0
    537b:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    537e:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    5381:	01 c8                	add    eax,ecx
    5383:	11 da                	adc    edx,ebx
    5385:	0f ac d0 0c          	shrd   eax,edx,0xc
    5389:	c1 ea 0c             	shr    edx,0xc
    538c:	89 c6                	mov    esi,eax
    538e:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    5391:	bb 00 00 00 00       	mov    ebx,0x0
    5396:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    5399:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    539c:	01 c8                	add    eax,ecx
    539e:	11 da                	adc    edx,ebx
    53a0:	25 ff 0f 00 00       	and    eax,0xfff
    53a5:	ba 00 00 00 00       	mov    edx,0x0
    53aa:	89 c1                	mov    ecx,eax
    53ac:	89 c8                	mov    eax,ecx
    53ae:	09 d0                	or     eax,edx
    53b0:	74 07                	je     53b9 <mm_perform_mapping+0xaf>
    53b2:	b8 01 00 00 00       	mov    eax,0x1
    53b7:	eb 05                	jmp    53be <mm_perform_mapping+0xb4>
    53b9:	b8 00 00 00 00       	mov    eax,0x0
    53be:	01 f0                	add    eax,esi
    53c0:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    53c3:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    53c6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		pcm = rdiv(padding + ms, 4096); /* count of pages in memory */
    53c9:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    53cc:	bb 00 00 00 00       	mov    ebx,0x0
    53d1:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    53d4:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    53d7:	01 c8                	add    eax,ecx
    53d9:	11 da                	adc    edx,ebx
    53db:	0f ac d0 0c          	shrd   eax,edx,0xc
    53df:	c1 ea 0c             	shr    edx,0xc
    53e2:	89 c6                	mov    esi,eax
    53e4:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    53e7:	bb 00 00 00 00       	mov    ebx,0x0
    53ec:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    53ef:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    53f2:	01 c8                	add    eax,ecx
    53f4:	11 da                	adc    edx,ebx
    53f6:	25 ff 0f 00 00       	and    eax,0xfff
    53fb:	ba 00 00 00 00       	mov    edx,0x0
    5400:	89 c1                	mov    ecx,eax
    5402:	89 c8                	mov    eax,ecx
    5404:	09 d0                	or     eax,edx
    5406:	74 07                	je     540f <mm_perform_mapping+0x105>
    5408:	b8 01 00 00 00       	mov    eax,0x1
    540d:	eb 05                	jmp    5414 <mm_perform_mapping+0x10a>
    540f:	b8 00 00 00 00       	mov    eax,0x0
    5414:	01 f0                	add    eax,esi
    5416:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		/* and the number of zero bytes on the last file page */
		zeros = (padding + fs) % 4096;
    5419:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    541c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    541f:	01 d0                	add    eax,edx
    5421:	25 ff 0f 00 00       	and    eax,0xfff
    5426:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (zeros)
    5429:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    542d:	74 0b                	je     543a <mm_perform_mapping+0x130>
				zeros = 4096 - zeros;
    542f:	b8 00 10 00 00       	mov    eax,0x1000
    5434:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    5437:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* fix the alignment */
		if (padding)
    543a:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    543e:	0f 84 8b 00 00 00    	je     54cf <mm_perform_mapping+0x1c5>
				cur -= padding;
    5444:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    5447:	ba 00 00 00 00       	mov    edx,0x0
    544c:	29 45 f0             	sub    DWORD PTR [ebp-0x10],eax
    544f:	19 55 f4             	sbb    DWORD PTR [ebp-0xc],edx
		/* first build the page ranges for the mapping */
		while (po) {
    5452:	eb 7b                	jmp    54cf <mm_perform_mapping+0x1c5>
				if (pr->count > po) {
    5454:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    5457:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    545a:	ba 00 00 00 00       	mov    edx,0x0
    545f:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    5462:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    5465:	19 d1                	sbb    ecx,edx
    5467:	73 34                	jae    549d <mm_perform_mapping+0x193>
						/* we found the start */
						pr2->base = pr->base + po * 4096;
    5469:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    546c:	8b 08                	mov    ecx,DWORD PTR [eax]
    546e:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    5471:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5474:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    5477:	0f a4 c2 0c          	shld   edx,eax,0xc
    547b:	c1 e0 0c             	shl    eax,0xc
    547e:	01 c8                	add    eax,ecx
    5480:	11 da                	adc    edx,ebx
    5482:	8b 4d 34             	mov    ecx,DWORD PTR [ebp+0x34]
    5485:	89 01                	mov    DWORD PTR [ecx],eax
    5487:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
						pr2->count = pr->count - po;
    548a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    548d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    5490:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5493:	29 c2                	sub    edx,eax
    5495:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5498:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
						break;
    549b:	eb 3e                	jmp    54db <mm_perform_mapping+0x1d1>
				} else {
						po -= pr->count;
    549d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    54a0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    54a3:	ba 00 00 00 00       	mov    edx,0x0
    54a8:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
    54ab:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
						pr++;
    54ae:	83 45 14 0c          	add    DWORD PTR [ebp+0x14],0xc
						if (!--prc) { /* no there */
    54b2:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
    54b6:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    54ba:	75 13                	jne    54cf <mm_perform_mapping+0x1c5>
								puts("offset not found in ELF.");
    54bc:	83 ec 0c             	sub    esp,0xc
    54bf:	68 f1 00 00 00       	push   0xf1
    54c4:	e8 fc ff ff ff       	call   54c5 <mm_perform_mapping+0x1bb>
    54c9:	83 c4 10             	add    esp,0x10
								while (1);
    54cc:	90                   	nop
    54cd:	eb fd                	jmp    54cc <mm_perform_mapping+0x1c2>
		while (po) {
    54cf:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    54d2:	0b 45 e4             	or     eax,DWORD PTR [ebp-0x1c]
    54d5:	0f 85 79 ff ff ff    	jne    5454 <mm_perform_mapping+0x14a>
						}
				}
		}

		/* now pr2 is already pointing in the right direction */
		while (pcf_c > pr2[pro].count) {
    54db:	eb 6e                	jmp    554b <mm_perform_mapping+0x241>
				pcf_c -= pr2[pro].count;
    54dd:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    54e0:	89 d0                	mov    eax,edx
    54e2:	01 c0                	add    eax,eax
    54e4:	01 d0                	add    eax,edx
    54e6:	c1 e0 02             	shl    eax,0x2
    54e9:	89 c2                	mov    edx,eax
    54eb:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    54ee:	01 d0                	add    eax,edx
    54f0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    54f3:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
				/* discontinuity -> new pr needed */
				if (!prc || !pr2c) {
    54f6:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    54fa:	74 06                	je     5502 <mm_perform_mapping+0x1f8>
    54fc:	83 7d 38 00          	cmp    DWORD PTR [ebp+0x38],0x0
    5500:	75 13                	jne    5515 <mm_perform_mapping+0x20b>
						puts("out of PRCs");
    5502:	83 ec 0c             	sub    esp,0xc
    5505:	68 0a 01 00 00       	push   0x10a
    550a:	e8 fc ff ff ff       	call   550b <mm_perform_mapping+0x201>
    550f:	83 c4 10             	add    esp,0x10
						while (1);
    5512:	90                   	nop
    5513:	eb fd                	jmp    5512 <mm_perform_mapping+0x208>
				}
#ifdef VM_DIAG
				puts("discontinuity: new pr2");
#endif
				pro++; pr2c--; pr++; prc--;
    5515:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    5519:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    551d:	83 45 14 0c          	add    DWORD PTR [ebp+0x14],0xc
    5521:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
				pr2[pro] = *pr;
    5525:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5528:	89 d0                	mov    eax,edx
    552a:	01 c0                	add    eax,eax
    552c:	01 d0                	add    eax,edx
    552e:	c1 e0 02             	shl    eax,0x2
    5531:	89 c2                	mov    edx,eax
    5533:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5536:	01 c2                	add    edx,eax
    5538:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    553b:	8b 08                	mov    ecx,DWORD PTR [eax]
    553d:	89 0a                	mov    DWORD PTR [edx],ecx
    553f:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    5542:	89 4a 04             	mov    DWORD PTR [edx+0x4],ecx
    5545:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5548:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
		while (pcf_c > pr2[pro].count) {
    554b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    554e:	89 d0                	mov    eax,edx
    5550:	01 c0                	add    eax,eax
    5552:	01 d0                	add    eax,edx
    5554:	c1 e0 02             	shl    eax,0x2
    5557:	89 c2                	mov    edx,eax
    5559:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    555c:	01 d0                	add    eax,edx
    555e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5561:	3b 45 d8             	cmp    eax,DWORD PTR [ebp-0x28]
    5564:	0f 82 73 ff ff ff    	jb     54dd <mm_perform_mapping+0x1d3>
		}
		if (pcf_c) { /* restrict last pr to actual size in memory */
    556a:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    556e:	74 19                	je     5589 <mm_perform_mapping+0x27f>
				pr2[pro].count = pcf_c;
    5570:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5573:	89 d0                	mov    eax,edx
    5575:	01 c0                	add    eax,eax
    5577:	01 d0                	add    eax,edx
    5579:	c1 e0 02             	shl    eax,0x2
    557c:	89 c2                	mov    edx,eax
    557e:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5581:	01 c2                	add    edx,eax
    5583:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    5586:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
		}
		/* and zero */
		if (zeros) {
    5589:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    558d:	0f 84 1f 01 00 00    	je     56b2 <mm_perform_mapping+0x3a8>
				/* duplicate the critical last page */
				void* end = (void*)(pr2[pro].base + 4096 * --pr2[pro].count);
    5593:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5596:	89 d0                	mov    eax,edx
    5598:	01 c0                	add    eax,eax
    559a:	01 d0                	add    eax,edx
    559c:	c1 e0 02             	shl    eax,0x2
    559f:	89 c2                	mov    edx,eax
    55a1:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    55a4:	01 d0                	add    eax,edx
    55a6:	8b 08                	mov    ecx,DWORD PTR [eax]
    55a8:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    55ab:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    55ae:	89 d0                	mov    eax,edx
    55b0:	01 c0                	add    eax,eax
    55b2:	01 d0                	add    eax,edx
    55b4:	c1 e0 02             	shl    eax,0x2
    55b7:	89 c2                	mov    edx,eax
    55b9:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    55bc:	01 d0                	add    eax,edx
    55be:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    55c1:	83 ea 01             	sub    edx,0x1
    55c4:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    55c7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    55ca:	c1 e0 0c             	shl    eax,0xc
    55cd:	ba 00 00 00 00       	mov    edx,0x0
    55d2:	01 c8                	add    eax,ecx
    55d4:	11 da                	adc    edx,ebx
    55d6:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				pro++; /* and advance for a new entry for the duplicate */
    55d9:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
				if (mm_alloc_pm(1, pr2 + pro, --pr2c)) {
    55dd:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    55e1:	8b 4d 38             	mov    ecx,DWORD PTR [ebp+0x38]
    55e4:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    55e7:	89 d0                	mov    eax,edx
    55e9:	01 c0                	add    eax,eax
    55eb:	01 d0                	add    eax,edx
    55ed:	c1 e0 02             	shl    eax,0x2
    55f0:	89 c2                	mov    edx,eax
    55f2:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    55f5:	01 d0                	add    eax,edx
    55f7:	83 ec 04             	sub    esp,0x4
    55fa:	51                   	push   ecx
    55fb:	50                   	push   eax
    55fc:	6a 01                	push   0x1
    55fe:	e8 fc ff ff ff       	call   55ff <mm_perform_mapping+0x2f5>
    5603:	83 c4 10             	add    esp,0x10
    5606:	85 c0                	test   eax,eax
    5608:	0f 84 91 00 00 00    	je     569f <mm_perform_mapping+0x395>
						void* dst = (void*)pr2[pro].base;
    560e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5611:	89 d0                	mov    eax,edx
    5613:	01 c0                	add    eax,eax
    5615:	01 d0                	add    eax,edx
    5617:	c1 e0 02             	shl    eax,0x2
    561a:	89 c2                	mov    edx,eax
    561c:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    561f:	01 d0                	add    eax,edx
    5621:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5624:	8b 00                	mov    eax,DWORD PTR [eax]
    5626:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
						mem_cpy(dst, end, 4096 - zeros);
    5629:	b8 00 10 00 00       	mov    eax,0x1000
    562e:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    5631:	83 ec 04             	sub    esp,0x4
    5634:	50                   	push   eax
    5635:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    5638:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
    563b:	e8 fc ff ff ff       	call   563c <mm_perform_mapping+0x332>
    5640:	83 c4 10             	add    esp,0x10
#ifdef VM_DIAG
						putstr("allocated page duplicate at "); put64((uint64_t)dst); put_nl();
#endif
						if (!pr2[pro - 1].count) { /* remove zero length */
    5643:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5646:	89 d0                	mov    eax,edx
    5648:	01 c0                	add    eax,eax
    564a:	01 d0                	add    eax,edx
    564c:	c1 e0 02             	shl    eax,0x2
    564f:	8d 50 f4             	lea    edx,[eax-0xc]
    5652:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5655:	01 d0                	add    eax,edx
    5657:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    565a:	85 c0                	test   eax,eax
    565c:	75 54                	jne    56b2 <mm_perform_mapping+0x3a8>
								puts("removing mapping, was:");
								for (int o = 0; o < pro; o++) {
									put64(pr2[o].base); putc(' '); put32(pr2[o].count); put_nl();
								}
#endif
								pr2[pro - 1] = pr2[pro];
    565e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5661:	89 d0                	mov    eax,edx
    5663:	01 c0                	add    eax,eax
    5665:	01 d0                	add    eax,edx
    5667:	c1 e0 02             	shl    eax,0x2
    566a:	89 c2                	mov    edx,eax
    566c:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    566f:	01 c2                	add    edx,eax
    5671:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    5674:	89 c8                	mov    eax,ecx
    5676:	01 c0                	add    eax,eax
    5678:	01 c8                	add    eax,ecx
    567a:	c1 e0 02             	shl    eax,0x2
    567d:	8d 48 f4             	lea    ecx,[eax-0xc]
    5680:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5683:	01 c8                	add    eax,ecx
    5685:	8b 0a                	mov    ecx,DWORD PTR [edx]
    5687:	89 08                	mov    DWORD PTR [eax],ecx
    5689:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    568c:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    568f:	8b 52 08             	mov    edx,DWORD PTR [edx+0x8]
    5692:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
								pr2c++; pro--;
    5695:	83 45 38 01          	add    DWORD PTR [ebp+0x38],0x1
    5699:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
    569d:	eb 13                	jmp    56b2 <mm_perform_mapping+0x3a8>
						}
				} else {
						puts("unable to duplicate page");
    569f:	83 ec 0c             	sub    esp,0xc
    56a2:	68 16 01 00 00       	push   0x116
    56a7:	e8 fc ff ff ff       	call   56a8 <mm_perform_mapping+0x39e>
    56ac:	83 c4 10             	add    esp,0x10
						while (1);
    56af:	90                   	nop
    56b0:	eb fd                	jmp    56af <mm_perform_mapping+0x3a5>
				}
				//bzero(end - zeros, zeros);
		}

		/* advance */
		pro++;
    56b2:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
		pr2c--;
    56b6:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1

		/* now add the zero pages */
		if (pcm > pcf) {
    56ba:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    56bd:	39 45 c4             	cmp    DWORD PTR [ebp-0x3c],eax
    56c0:	0f 83 c6 00 00 00    	jae    578c <mm_perform_mapping+0x482>
				size_t zc = pcm - pcf;
    56c6:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    56c9:	2b 45 c4             	sub    eax,DWORD PTR [ebp-0x3c]
    56cc:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
#ifdef VM_DIAG
				putstr("zero count: "); put32(zc); put_nl();
#endif
				if (w) {
    56cf:	83 7d 40 00          	cmp    DWORD PTR [ebp+0x40],0x0
    56d3:	0f 84 91 00 00 00    	je     576a <mm_perform_mapping+0x460>
						zc -= mm_alloc_pm(zc, pr2 + pro, pr2c);
    56d9:	8b 4d 38             	mov    ecx,DWORD PTR [ebp+0x38]
    56dc:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    56df:	89 d0                	mov    eax,edx
    56e1:	01 c0                	add    eax,eax
    56e3:	01 d0                	add    eax,edx
    56e5:	c1 e0 02             	shl    eax,0x2
    56e8:	89 c2                	mov    edx,eax
    56ea:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    56ed:	01 d0                	add    eax,edx
    56ef:	83 ec 04             	sub    esp,0x4
    56f2:	51                   	push   ecx
    56f3:	50                   	push   eax
    56f4:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    56f7:	e8 fc ff ff ff       	call   56f8 <mm_perform_mapping+0x3ee>
    56fc:	83 c4 10             	add    esp,0x10
    56ff:	29 45 d4             	sub    DWORD PTR [ebp-0x2c],eax
#ifdef VM_DIAG
						putstr("zero mem at "); put64((pr2 + pro)->base);
						putstr(" for "); put32((pr2 + pro)->count); puts("pages");
#endif
						pro++; pr2c--;
    5702:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    5706:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    570a:	eb 6a                	jmp    5776 <mm_perform_mapping+0x46c>
				} else { /* use the single zero page (wastes many ranges) */
						while (zc && pr2c) {
								pr2[pro].base = pm_zero;
    570c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    570f:	89 d0                	mov    eax,edx
    5711:	01 c0                	add    eax,eax
    5713:	01 d0                	add    eax,edx
    5715:	c1 e0 02             	shl    eax,0x2
    5718:	89 c2                	mov    edx,eax
    571a:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    571d:	8d 0c 02             	lea    ecx,[edx+eax*1]
    5720:	a1 00 00 00 00       	mov    eax,ds:0x0
    5725:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    572b:	89 01                	mov    DWORD PTR [ecx],eax
    572d:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr2[pro++].count = 1;
    5730:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    5733:	8d 50 01             	lea    edx,[eax+0x1]
    5736:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    5739:	89 c2                	mov    edx,eax
    573b:	89 d0                	mov    eax,edx
    573d:	01 c0                	add    eax,eax
    573f:	01 d0                	add    eax,edx
    5741:	c1 e0 02             	shl    eax,0x2
    5744:	89 c2                	mov    edx,eax
    5746:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5749:	01 d0                	add    eax,edx
    574b:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr2c--; zc--;
    5752:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    5756:	83 6d d4 01          	sub    DWORD PTR [ebp-0x2c],0x1
								/* TODO: reprogram by using multiple calls */
								puts("zero-page used");
    575a:	83 ec 0c             	sub    esp,0xc
    575d:	68 2f 01 00 00       	push   0x12f
    5762:	e8 fc ff ff ff       	call   5763 <mm_perform_mapping+0x459>
    5767:	83 c4 10             	add    esp,0x10
						while (zc && pr2c) {
    576a:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    576e:	74 06                	je     5776 <mm_perform_mapping+0x46c>
    5770:	83 7d 38 00          	cmp    DWORD PTR [ebp+0x38],0x0
    5774:	75 96                	jne    570c <mm_perform_mapping+0x402>
						}
				}
				if (zc) {
    5776:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    577a:	74 10                	je     578c <mm_perform_mapping+0x482>
						puts("unable to zero-pad .bss-like section.");
    577c:	83 ec 0c             	sub    esp,0xc
    577f:	68 40 01 00 00       	push   0x140
    5784:	e8 fc ff ff ff       	call   5785 <mm_perform_mapping+0x47b>
    5789:	83 c4 10             	add    esp,0x10
		}

		/* TODO: handle overlap of W and X if wanted */

		/* we now have built the mapping in pr2 with pro valid ranges */
		if (cur < 0x100000) { /* identity map -> .trampo */
    578c:	ba ff ff 0f 00       	mov    edx,0xfffff
    5791:	b8 00 00 00 00       	mov    eax,0x0
    5796:	3b 55 f0             	cmp    edx,DWORD PTR [ebp-0x10]
    5799:	1b 45 f4             	sbb    eax,DWORD PTR [ebp-0xc]
    579c:	72 7c                	jb     581a <mm_perform_mapping+0x510>
				void* ptr = (void*)cur;
    579e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    57a1:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				for (int i = 0; i < pro; i++) {
    57a4:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    57ab:	eb 63                	jmp    5810 <mm_perform_mapping+0x506>
						mem_cpy(ptr, (void*)pr2[i].base, pr2[i].count * 4096);
    57ad:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    57b0:	89 d0                	mov    eax,edx
    57b2:	01 c0                	add    eax,eax
    57b4:	01 d0                	add    eax,edx
    57b6:	c1 e0 02             	shl    eax,0x2
    57b9:	89 c2                	mov    edx,eax
    57bb:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    57be:	01 d0                	add    eax,edx
    57c0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    57c3:	c1 e0 0c             	shl    eax,0xc
    57c6:	89 c1                	mov    ecx,eax
    57c8:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    57cb:	89 d0                	mov    eax,edx
    57cd:	01 c0                	add    eax,eax
    57cf:	01 d0                	add    eax,edx
    57d1:	c1 e0 02             	shl    eax,0x2
    57d4:	89 c2                	mov    edx,eax
    57d6:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    57d9:	01 d0                	add    eax,edx
    57db:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    57de:	8b 00                	mov    eax,DWORD PTR [eax]
    57e0:	83 ec 04             	sub    esp,0x4
    57e3:	51                   	push   ecx
    57e4:	50                   	push   eax
    57e5:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    57e8:	e8 fc ff ff ff       	call   57e9 <mm_perform_mapping+0x4df>
    57ed:	83 c4 10             	add    esp,0x10
						ptr += pr2[i].count * 4096;
    57f0:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    57f3:	89 d0                	mov    eax,edx
    57f5:	01 c0                	add    eax,eax
    57f7:	01 d0                	add    eax,edx
    57f9:	c1 e0 02             	shl    eax,0x2
    57fc:	89 c2                	mov    edx,eax
    57fe:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5801:	01 d0                	add    eax,edx
    5803:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5806:	c1 e0 0c             	shl    eax,0xc
    5809:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
				for (int i = 0; i < pro; i++) {
    580c:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
    5810:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    5813:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
    5816:	7c 95                	jl     57ad <mm_perform_mapping+0x4a3>
				}
				return; /* TODO: possible NX setup */
    5818:	eb 6c                	jmp    5886 <mm_perform_mapping+0x57c>
		for (int o = 0; o < pro; o++) {
			put32(o); putstr(": "); put64(pr2[o].base); putstr(" "); put32(pr2[o].count); put_nl();
		}
#endif

		if (!mode)
    581a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    581e:	75 21                	jne    5841 <mm_perform_mapping+0x537>
				mm_map32((uint32_t)cur, pr2, pro, x, w, 0, 0);
    5820:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    5823:	83 ec 04             	sub    esp,0x4
    5826:	6a 00                	push   0x0
    5828:	6a 00                	push   0x0
    582a:	ff 75 40             	push   DWORD PTR [ebp+0x40]
    582d:	ff 75 3c             	push   DWORD PTR [ebp+0x3c]
    5830:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    5833:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    5836:	50                   	push   eax
    5837:	e8 fc ff ff ff       	call   5838 <mm_perform_mapping+0x52e>
    583c:	83 c4 20             	add    esp,0x20
    583f:	eb 45                	jmp    5886 <mm_perform_mapping+0x57c>
		else if (mode == 1)
    5841:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    5845:	75 21                	jne    5868 <mm_perform_mapping+0x55e>
				mm_map36((uint32_t)cur, pr2, pro, x, w, 0, 0);
    5847:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    584a:	83 ec 04             	sub    esp,0x4
    584d:	6a 00                	push   0x0
    584f:	6a 00                	push   0x0
    5851:	ff 75 40             	push   DWORD PTR [ebp+0x40]
    5854:	ff 75 3c             	push   DWORD PTR [ebp+0x3c]
    5857:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    585a:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    585d:	50                   	push   eax
    585e:	e8 fc ff ff ff       	call   585f <mm_perform_mapping+0x555>
    5863:	83 c4 20             	add    esp,0x20
    5866:	eb 1e                	jmp    5886 <mm_perform_mapping+0x57c>
		else
				mm_map64(cur, pr2, pro, x, w, 0, 0);
    5868:	6a 00                	push   0x0
    586a:	6a 00                	push   0x0
    586c:	ff 75 40             	push   DWORD PTR [ebp+0x40]
    586f:	ff 75 3c             	push   DWORD PTR [ebp+0x3c]
    5872:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    5875:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    5878:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    587b:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    587e:	e8 fc ff ff ff       	call   587f <mm_perform_mapping+0x575>
    5883:	83 c4 20             	add    esp,0x20
}
    5886:	8d 65 f8             	lea    esp,[ebp-0x8]
    5889:	5b                   	pop    ebx
    588a:	5e                   	pop    esi
    588b:	5d                   	pop    ebp
    588c:	c3                   	ret

0000588d <mm_mmap>:


void mm_mmap(int mode, uint64_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    588d:	55                   	push   ebp
    588e:	89 e5                	mov    ebp,esp
    5890:	83 ec 18             	sub    esp,0x18
    5893:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    5896:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    5899:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    589c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!mode)
    589f:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    58a3:	75 23                	jne    58c8 <mm_mmap+0x3b>
				mm_map32((uint32_t)vaddr, pr, prc, x, w, wc, us);
    58a5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    58a8:	83 ec 04             	sub    esp,0x4
    58ab:	ff 75 28             	push   DWORD PTR [ebp+0x28]
    58ae:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    58b1:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    58b4:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    58b7:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    58ba:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    58bd:	50                   	push   eax
    58be:	e8 fc ff ff ff       	call   58bf <mm_mmap+0x32>
    58c3:	83 c4 20             	add    esp,0x20
		else if (mode == 1)
				mm_map36((uint32_t)vaddr, pr, prc, x, w, wc, us);
		else
				mm_map64(vaddr, pr, prc, x, w, wc, us);
}
    58c6:	eb 49                	jmp    5911 <mm_mmap+0x84>
		else if (mode == 1)
    58c8:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    58cc:	75 23                	jne    58f1 <mm_mmap+0x64>
				mm_map36((uint32_t)vaddr, pr, prc, x, w, wc, us);
    58ce:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    58d1:	83 ec 04             	sub    esp,0x4
    58d4:	ff 75 28             	push   DWORD PTR [ebp+0x28]
    58d7:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    58da:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    58dd:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    58e0:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    58e3:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    58e6:	50                   	push   eax
    58e7:	e8 fc ff ff ff       	call   58e8 <mm_mmap+0x5b>
    58ec:	83 c4 20             	add    esp,0x20
}
    58ef:	eb 20                	jmp    5911 <mm_mmap+0x84>
				mm_map64(vaddr, pr, prc, x, w, wc, us);
    58f1:	ff 75 28             	push   DWORD PTR [ebp+0x28]
    58f4:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    58f7:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    58fa:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    58fd:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    5900:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    5903:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    5906:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    5909:	e8 fc ff ff ff       	call   590a <mm_mmap+0x7d>
    590e:	83 c4 20             	add    esp,0x20
}
    5911:	90                   	nop
    5912:	c9                   	leave
    5913:	c3                   	ret

00005914 <mm_register_video_memory>:

void* mm_register_video_memory(int mode, uint64_t vga_pmem, uint64_t vga_pmem_size)
{
    5914:	55                   	push   ebp
    5915:	89 e5                	mov    ebp,esp
    5917:	53                   	push   ebx
    5918:	83 ec 44             	sub    esp,0x44
    591b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    591e:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    5921:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    5924:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    5927:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    592a:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    592d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    5930:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		struct vmdesc vd, *pvd;
		struct page_range pr = { vga_pmem, rdiv(vga_pmem_size, 4096) };
    5933:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    5936:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    5939:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    593c:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
    593f:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    5942:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    5945:	0f ac d0 0c          	shrd   eax,edx,0xc
    5949:	c1 ea 0c             	shr    edx,0xc
    594c:	89 c1                	mov    ecx,eax
    594e:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    5951:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    5954:	25 ff 0f 00 00       	and    eax,0xfff
    5959:	ba 00 00 00 00       	mov    edx,0x0
    595e:	89 c3                	mov    ebx,eax
    5960:	89 d8                	mov    eax,ebx
    5962:	09 d0                	or     eax,edx
    5964:	74 07                	je     596d <mm_register_video_memory+0x59>
    5966:	b8 01 00 00 00       	mov    eax,0x1
    596b:	eb 05                	jmp    5972 <mm_register_video_memory+0x5e>
    596d:	b8 00 00 00 00       	mov    eax,0x0
    5972:	01 c8                	add    eax,ecx
    5974:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		vd.vga_base = vga_pmem;
    5977:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    597a:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    597d:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    5980:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
		vd.vga_size = vga_pmem_size;
    5983:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    5986:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    5989:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    598c:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
		vd.vga_virt = VM_VIDEO_MEMORY;
    598f:	c7 45 ec 00 00 00 e0 	mov    DWORD PTR [ebp-0x14],0xe0000000
    5996:	c7 45 f0 ff ff ff ff 	mov    DWORD PTR [ebp-0x10],0xffffffff
		if (!mode)
    599d:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    59a1:	75 0f                	jne    59b2 <mm_register_video_memory+0x9e>
			pvd = &((struct vm_pg_ptrs32*)vm_mapping)->video_memory;
    59a3:	a1 00 00 00 00       	mov    eax,ds:0x0
    59a8:	05 08 10 00 00       	add    eax,0x1008
    59ad:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    59b0:	eb 22                	jmp    59d4 <mm_register_video_memory+0xc0>
		else if (mode == 1)
    59b2:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    59b6:	75 0f                	jne    59c7 <mm_register_video_memory+0xb3>
			pvd = &((struct vm_pg_ptrs36*)vm_mapping)->video_memory;
    59b8:	a1 00 00 00 00       	mov    eax,ds:0x0
    59bd:	05 34 20 00 00       	add    eax,0x2034
    59c2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    59c5:	eb 0d                	jmp    59d4 <mm_register_video_memory+0xc0>
		else
			pvd = &((struct vm_pg_ptrs64*)vm_mapping)->video_memory;
    59c7:	a1 00 00 00 00       	mov    eax,ds:0x0
    59cc:	05 10 20 00 00       	add    eax,0x2010
    59d1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		mm_mmap(mode, vd.vga_virt, &pr, 1, 0, 1, 1, 0);
    59d4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    59d7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    59da:	83 ec 0c             	sub    esp,0xc
    59dd:	6a 00                	push   0x0
    59df:	6a 01                	push   0x1
    59e1:	6a 01                	push   0x1
    59e3:	6a 00                	push   0x0
    59e5:	6a 01                	push   0x1
    59e7:	8d 4d d0             	lea    ecx,[ebp-0x30]
    59ea:	51                   	push   ecx
    59eb:	52                   	push   edx
    59ec:	50                   	push   eax
    59ed:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    59f0:	e8 fc ff ff ff       	call   59f1 <mm_register_video_memory+0xdd>
    59f5:	83 c4 30             	add    esp,0x30
		*pvd = vd;
    59f8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    59fb:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    59fe:	89 10                	mov    DWORD PTR [eax],edx
    5a00:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    5a03:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    5a06:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    5a09:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    5a0c:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    5a0f:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    5a12:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5a15:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
    5a18:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    5a1b:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		return pvd;
    5a1e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    5a21:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    5a24:	c9                   	leave
    5a25:	c3                   	ret

00005a26 <mm_preallocate_maps>:

void mm_preallocate_maps(int mode)
{
    5a26:	55                   	push   ebp
    5a27:	89 e5                	mov    ebp,esp
    5a29:	57                   	push   edi
    5a2a:	56                   	push   esi
    5a2b:	53                   	push   ebx
    5a2c:	83 ec 6c             	sub    esp,0x6c
			struct page_range pr;
			uint64_t mem_ranges[] = {
    5a2f:	8d 45 88             	lea    eax,[ebp-0x78]
    5a32:	bb c0 01 00 00       	mov    ebx,0x1c0
    5a37:	ba 14 00 00 00       	mov    edx,0x14
    5a3c:	89 c7                	mov    edi,eax
    5a3e:	89 de                	mov    esi,ebx
    5a40:	89 d1                	mov    ecx,edx
    5a42:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
				VM_QND_BASE, 1
			}, *mr_pt;


			/* Pre-allocate the required ranges */
			for (mr_pt = &mem_ranges[0]; (mr_pt - mem_ranges) < 10; mr_pt += 2) {
    5a44:	8d 45 88             	lea    eax,[ebp-0x78]
    5a47:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    5a4a:	e9 c9 00 00 00       	jmp    5b18 <mm_preallocate_maps+0xf2>
					/* get some inital space for tables / stuff */
					putstr("allocating map for "); put64(mr_pt[0]);
    5a4f:	83 ec 0c             	sub    esp,0xc
    5a52:	68 66 01 00 00       	push   0x166
    5a57:	e8 fc ff ff ff       	call   5a58 <mm_preallocate_maps+0x32>
    5a5c:	83 c4 10             	add    esp,0x10
    5a5f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5a62:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5a65:	8b 00                	mov    eax,DWORD PTR [eax]
    5a67:	83 ec 08             	sub    esp,0x8
    5a6a:	52                   	push   edx
    5a6b:	50                   	push   eax
    5a6c:	e8 fc ff ff ff       	call   5a6d <mm_preallocate_maps+0x47>
    5a71:	83 c4 10             	add    esp,0x10
					putstr(" of count "); put64(mr_pt[1]); put_nl();
    5a74:	83 ec 0c             	sub    esp,0xc
    5a77:	68 7a 01 00 00       	push   0x17a
    5a7c:	e8 fc ff ff ff       	call   5a7d <mm_preallocate_maps+0x57>
    5a81:	83 c4 10             	add    esp,0x10
    5a84:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5a87:	83 c0 08             	add    eax,0x8
    5a8a:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5a8d:	8b 00                	mov    eax,DWORD PTR [eax]
    5a8f:	83 ec 08             	sub    esp,0x8
    5a92:	52                   	push   edx
    5a93:	50                   	push   eax
    5a94:	e8 fc ff ff ff       	call   5a95 <mm_preallocate_maps+0x6f>
    5a99:	83 c4 10             	add    esp,0x10
    5a9c:	e8 fc ff ff ff       	call   5a9d <mm_preallocate_maps+0x77>
					mm_alloc_pm(mr_pt[1], &pr, 1);
    5aa1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5aa4:	83 c0 08             	add    eax,0x8
    5aa7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5aaa:	8b 00                	mov    eax,DWORD PTR [eax]
    5aac:	89 c2                	mov    edx,eax
    5aae:	83 ec 04             	sub    esp,0x4
    5ab1:	6a 01                	push   0x1
    5ab3:	8d 45 d8             	lea    eax,[ebp-0x28]
    5ab6:	50                   	push   eax
    5ab7:	52                   	push   edx
    5ab8:	e8 fc ff ff ff       	call   5ab9 <mm_preallocate_maps+0x93>
    5abd:	83 c4 10             	add    esp,0x10
					if (pr.count < mr_pt[1]) {
    5ac0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5ac3:	89 c1                	mov    ecx,eax
    5ac5:	bb 00 00 00 00       	mov    ebx,0x0
    5aca:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5acd:	83 c0 08             	add    eax,0x8
    5ad0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5ad3:	8b 00                	mov    eax,DWORD PTR [eax]
    5ad5:	39 c1                	cmp    ecx,eax
    5ad7:	19 d3                	sbb    ebx,edx
    5ad9:	73 13                	jae    5aee <mm_preallocate_maps+0xc8>
							putstr("unable to allocate basic memory");
    5adb:	83 ec 0c             	sub    esp,0xc
    5ade:	68 88 01 00 00       	push   0x188
    5ae3:	e8 fc ff ff ff       	call   5ae4 <mm_preallocate_maps+0xbe>
    5ae8:	83 c4 10             	add    esp,0x10
							while (1);
    5aeb:	90                   	nop
    5aec:	eb fd                	jmp    5aeb <mm_preallocate_maps+0xc5>
					}
					/* and then map it accordingly */
					mm_mmap(mode, mr_pt[0], &pr, 1, 0, 1, 0, 0);
    5aee:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5af1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5af4:	8b 00                	mov    eax,DWORD PTR [eax]
    5af6:	83 ec 0c             	sub    esp,0xc
    5af9:	6a 00                	push   0x0
    5afb:	6a 00                	push   0x0
    5afd:	6a 01                	push   0x1
    5aff:	6a 00                	push   0x0
    5b01:	6a 01                	push   0x1
    5b03:	8d 4d d8             	lea    ecx,[ebp-0x28]
    5b06:	51                   	push   ecx
    5b07:	52                   	push   edx
    5b08:	50                   	push   eax
    5b09:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    5b0c:	e8 fc ff ff ff       	call   5b0d <mm_preallocate_maps+0xe7>
    5b11:	83 c4 30             	add    esp,0x30
			for (mr_pt = &mem_ranges[0]; (mr_pt - mem_ranges) < 10; mr_pt += 2) {
    5b14:	83 45 e4 10          	add    DWORD PTR [ebp-0x1c],0x10
    5b18:	8d 45 88             	lea    eax,[ebp-0x78]
    5b1b:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    5b1e:	29 c2                	sub    edx,eax
    5b20:	83 fa 48             	cmp    edx,0x48
    5b23:	0f 8e 26 ff ff ff    	jle    5a4f <mm_preallocate_maps+0x29>
			}

			puts("done");
    5b29:	83 ec 0c             	sub    esp,0xc
    5b2c:	68 a8 01 00 00       	push   0x1a8
    5b31:	e8 fc ff ff ff       	call   5b32 <mm_preallocate_maps+0x10c>
    5b36:	83 c4 10             	add    esp,0x10
}
    5b39:	90                   	nop
    5b3a:	8d 65 f4             	lea    esp,[ebp-0xc]
    5b3d:	5b                   	pop    ebx
    5b3e:	5e                   	pop    esi
    5b3f:	5f                   	pop    edi
    5b40:	5d                   	pop    ebp
    5b41:	c3                   	ret
