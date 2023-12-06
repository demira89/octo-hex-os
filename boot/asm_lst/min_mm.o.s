
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
     318:	a1 10 00 00 00       	mov    eax,ds:0x10
     31d:	6b c0 38             	imul   eax,eax,0x38
     320:	01 d0                	add    eax,edx
     322:	6a 38                	push   0x38
     324:	50                   	push   eax
     325:	e8 fc ff ff ff       	call   326 <mm_add_free+0x39>
     32a:	83 c4 08             	add    esp,0x8
		fmm[fm_ofs].base = b;
     32d:	ba 00 40 02 00       	mov    edx,0x24000
     332:	a1 10 00 00 00       	mov    eax,ds:0x10
     337:	6b c0 38             	imul   eax,eax,0x38
     33a:	8d 0c 02             	lea    ecx,[edx+eax*1]
     33d:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     340:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     343:	89 01                	mov    DWORD PTR [ecx],eax
     345:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		fmm[fm_ofs++].size = s;
     348:	b9 00 40 02 00       	mov    ecx,0x24000
     34d:	a1 10 00 00 00       	mov    eax,ds:0x10
     352:	8d 50 01             	lea    edx,[eax+0x1]
     355:	89 15 10 00 00 00    	mov    DWORD PTR ds:0x10,edx
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
     394:	a1 18 00 00 00       	mov    eax,ds:0x18
     399:	c1 e0 04             	shl    eax,0x4
     39c:	8d 0c 02             	lea    ecx,[edx+eax*1]
     39f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     3a2:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     3a5:	89 01                	mov    DWORD PTR [ecx],eax
     3a7:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		rmm[rm_count++].size = s;
     3aa:	b9 00 20 02 00       	mov    ecx,0x22000
     3af:	a1 18 00 00 00       	mov    eax,ds:0x18
     3b4:	8d 50 01             	lea    edx,[eax+0x1]
     3b7:	89 15 18 00 00 00    	mov    DWORD PTR ds:0x18,edx
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
     4c9:	a1 10 00 00 00       	mov    eax,ds:0x10
     4ce:	39 c2                	cmp    edx,eax
     4d0:	0f 83 ab 01 00 00    	jae    681 <mm_sub_block+0x2b0>
												fmm[ofs--] = fmm[--fm_ofs];
     4d6:	ba 00 40 02 00       	mov    edx,0x24000
     4db:	a1 10 00 00 00       	mov    eax,ds:0x10
     4e0:	83 e8 01             	sub    eax,0x1
     4e3:	a3 10 00 00 00       	mov    ds:0x10,eax
     4e8:	a1 10 00 00 00       	mov    eax,ds:0x10
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
     55c:	a1 10 00 00 00       	mov    eax,ds:0x10
     561:	6b c0 38             	imul   eax,eax,0x38
     564:	01 d0                	add    eax,edx
     566:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     56c:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
												fmm[fm_ofs].size = 0;
     573:	ba 00 40 02 00       	mov    edx,0x24000
     578:	a1 10 00 00 00       	mov    eax,ds:0x10
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
     60a:	a1 10 00 00 00       	mov    eax,ds:0x10
     60f:	6b c0 38             	imul   eax,eax,0x38
     612:	8d 0c 02             	lea    ecx,[edx+eax*1]
     615:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     618:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     61b:	89 01                	mov    DWORD PTR [ecx],eax
     61d:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								fmm[fm_ofs++].size = end2 - end;
     620:	b9 00 40 02 00       	mov    ecx,0x24000
     625:	a1 10 00 00 00       	mov    eax,ds:0x10
     62a:	8d 50 01             	lea    edx,[eax+0x1]
     62d:	89 15 10 00 00 00    	mov    DWORD PTR ds:0x10,edx
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
     66e:	a1 10 00 00 00       	mov    eax,ds:0x10
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
     690:	a1 10 00 00 00       	mov    eax,ds:0x10
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
     9d5:	a1 10 00 00 00       	mov    eax,ds:0x10
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
     a60:	a1 10 00 00 00       	mov    eax,ds:0x10
     a65:	83 e8 01             	sub    eax,0x1
     a68:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
     a6b:	72 80                	jb     9ed <mm_sort_and_merge+0x366>
						}
						fm_ofs--;
     a6d:	a1 10 00 00 00       	mov    eax,ds:0x10
     a72:	83 e8 01             	sub    eax,0x1
     a75:	a3 10 00 00 00       	mov    ds:0x10,eax
						fmm[fm_ofs].base = 0;
     a7a:	ba 00 40 02 00       	mov    edx,0x24000
     a7f:	a1 10 00 00 00       	mov    eax,ds:0x10
     a84:	6b c0 38             	imul   eax,eax,0x38
     a87:	01 d0                	add    eax,edx
     a89:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     a8f:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
						fmm[fm_ofs].size = 0;
     a96:	ba 00 40 02 00       	mov    edx,0x24000
     a9b:	a1 10 00 00 00       	mov    eax,ds:0x10
     aa0:	6b c0 38             	imul   eax,eax,0x38
     aa3:	01 d0                	add    eax,edx
     aa5:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
     aac:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		for (i = 0; i < fm_ofs - 1; i++)
     ab3:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
     ab7:	a1 10 00 00 00       	mov    eax,ds:0x10
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
    16bd:	a1 14 00 00 00       	mov    eax,ds:0x14
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
    188b:	a1 10 00 00 00       	mov    eax,ds:0x10
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
		pl2[511].addr = (size_t)pt2	/ 4096;
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
				pt1[i].u = 1;
    2160:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2163:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    216a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    216d:	01 d0                	add    eax,edx
    216f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2172:	83 ca 04             	or     edx,0x4
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
		uint64_t bse = 0xffffffffffe00000; /* last PD */
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
		/* vp is identity mapped -> no need for doing sth. (TODO: protection) */		
		/* then the 2 PDPTs */
		idx = (vp->pml4e[0] - bse) / 4096;
    22cb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    22ce:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    22d1:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    22d4:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    22d7:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    22da:	0f ac d0 0c          	shrd   eax,edx,0xc
    22de:	c1 ea 0c             	shr    edx,0xc
    22e1:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    22e4:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    22e7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    22ee:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    22f1:	01 d0                	add    eax,edx
    22f3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    22f6:	83 ca 01             	or     edx,0x1
    22f9:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    22fb:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    22fe:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2305:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2308:	01 d0                	add    eax,edx
    230a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    230d:	83 ca 02             	or     edx,0x2
    2310:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2312:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2315:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    231c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    231f:	01 d0                	add    eax,edx
    2321:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2324:	83 e2 fb             	and    edx,0xfffffffb
    2327:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)p1 / 4096;
    2329:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    232c:	99                   	cdq
    232d:	0f ac d0 0c          	shrd   eax,edx,0xc
    2331:	c1 ea 0c             	shr    edx,0xc
    2334:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2337:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    233e:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2341:	01 d9                	add    ecx,ebx
    2343:	81 e2 ff 00 00 00    	and    edx,0xff
    2349:	89 c3                	mov    ebx,eax
    234b:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2351:	89 de                	mov    esi,ebx
    2353:	c1 e6 0c             	shl    esi,0xc
    2356:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2358:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    235e:	09 f3                	or     ebx,esi
    2360:	89 19                	mov    DWORD PTR [ecx],ebx
    2362:	89 c3                	mov    ebx,eax
    2364:	c1 eb 14             	shr    ebx,0x14
    2367:	89 de                	mov    esi,ebx
    2369:	66 81 e6 ff 0f       	and    si,0xfff
    236e:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2372:	66 81 e3 00 f0       	and    bx,0xf000
    2377:	09 f3                	or     ebx,esi
    2379:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    237d:	0f b6 c2             	movzx  eax,dl
    2380:	c1 e0 0c             	shl    eax,0xc
    2383:	89 c2                	mov    edx,eax
    2385:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2388:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    238d:	09 d0                	or     eax,edx
    238f:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		idx = (vp->pml4e[511] - bse) / 4096;
    2392:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2395:	8b 90 0c 10 00 00    	mov    edx,DWORD PTR [eax+0x100c]
    239b:	8b 80 08 10 00 00    	mov    eax,DWORD PTR [eax+0x1008]
    23a1:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    23a4:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    23a7:	0f ac d0 0c          	shrd   eax,edx,0xc
    23ab:	c1 ea 0c             	shr    edx,0xc
    23ae:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    23b1:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    23b4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    23bb:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    23be:	01 d0                	add    eax,edx
    23c0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    23c3:	83 ca 01             	or     edx,0x1
    23c6:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    23c8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    23cb:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    23d2:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    23d5:	01 d0                	add    eax,edx
    23d7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    23da:	83 ca 02             	or     edx,0x2
    23dd:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    23df:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    23e2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    23e9:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    23ec:	01 d0                	add    eax,edx
    23ee:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    23f1:	83 e2 fb             	and    edx,0xfffffffb
    23f4:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)p2 / 4096;
    23f6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    23f9:	99                   	cdq
    23fa:	0f ac d0 0c          	shrd   eax,edx,0xc
    23fe:	c1 ea 0c             	shr    edx,0xc
    2401:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2404:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    240b:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    240e:	01 d9                	add    ecx,ebx
    2410:	81 e2 ff 00 00 00    	and    edx,0xff
    2416:	89 c3                	mov    ebx,eax
    2418:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    241e:	89 de                	mov    esi,ebx
    2420:	c1 e6 0c             	shl    esi,0xc
    2423:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2425:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    242b:	09 f3                	or     ebx,esi
    242d:	89 19                	mov    DWORD PTR [ecx],ebx
    242f:	89 c3                	mov    ebx,eax
    2431:	c1 eb 14             	shr    ebx,0x14
    2434:	89 de                	mov    esi,ebx
    2436:	66 81 e6 ff 0f       	and    si,0xfff
    243b:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    243f:	66 81 e3 00 f0       	and    bx,0xf000
    2444:	09 f3                	or     ebx,esi
    2446:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    244a:	0f b6 c2             	movzx  eax,dl
    244d:	c1 e0 0c             	shl    eax,0xc
    2450:	89 c2                	mov    edx,eax
    2452:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2455:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    245a:	09 d0                	or     eax,edx
    245c:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		/* now the two container structures (each 2 pages size, for PDPTEs(PDs & PDEs)) */
		idx = (vp->pdpte[0] - bse) / 4096;	
    245f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2462:	8b 90 14 10 00 00    	mov    edx,DWORD PTR [eax+0x1014]
    2468:	8b 80 10 10 00 00    	mov    eax,DWORD PTR [eax+0x1010]
    246e:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2471:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2474:	0f ac d0 0c          	shrd   eax,edx,0xc
    2478:	c1 ea 0c             	shr    edx,0xc
    247b:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    247e:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2481:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2488:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    248b:	01 d0                	add    eax,edx
    248d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2490:	83 ca 01             	or     edx,0x1
    2493:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2495:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2498:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    249f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    24a2:	01 d0                	add    eax,edx
    24a4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    24a7:	83 ca 02             	or     edx,0x2
    24aa:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    24ac:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    24af:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    24b6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    24b9:	01 d0                	add    eax,edx
    24bb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    24be:	83 e2 fb             	and    edx,0xfffffffb
    24c1:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)m1 / 4096;
    24c3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24c6:	99                   	cdq
    24c7:	0f ac d0 0c          	shrd   eax,edx,0xc
    24cb:	c1 ea 0c             	shr    edx,0xc
    24ce:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    24d1:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    24d8:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    24db:	01 d9                	add    ecx,ebx
    24dd:	81 e2 ff 00 00 00    	and    edx,0xff
    24e3:	89 c3                	mov    ebx,eax
    24e5:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    24eb:	89 de                	mov    esi,ebx
    24ed:	c1 e6 0c             	shl    esi,0xc
    24f0:	8b 19                	mov    ebx,DWORD PTR [ecx]
    24f2:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    24f8:	09 f3                	or     ebx,esi
    24fa:	89 19                	mov    DWORD PTR [ecx],ebx
    24fc:	89 c3                	mov    ebx,eax
    24fe:	c1 eb 14             	shr    ebx,0x14
    2501:	89 de                	mov    esi,ebx
    2503:	66 81 e6 ff 0f       	and    si,0xfff
    2508:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    250c:	66 81 e3 00 f0       	and    bx,0xf000
    2511:	09 f3                	or     ebx,esi
    2513:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2517:	0f b6 c2             	movzx  eax,dl
    251a:	c1 e0 0c             	shl    eax,0xc
    251d:	89 c2                	mov    edx,eax
    251f:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2522:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2527:	09 d0                	or     eax,edx
    2529:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx + 1].p = 1;
    252c:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    252f:	83 c0 01             	add    eax,0x1
    2532:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2539:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    253c:	01 d0                	add    eax,edx
    253e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2541:	83 ca 01             	or     edx,0x1
    2544:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].w = 1;
    2546:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2549:	83 c0 01             	add    eax,0x1
    254c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2553:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2556:	01 d0                	add    eax,edx
    2558:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    255b:	83 ca 02             	or     edx,0x2
    255e:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].u = 0;
    2560:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2563:	83 c0 01             	add    eax,0x1
    2566:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    256d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2570:	01 d0                	add    eax,edx
    2572:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2575:	83 e2 fb             	and    edx,0xfffffffb
    2578:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].addr = (uint64_t)m1 / 4096 + 1;
    257a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    257d:	99                   	cdq
    257e:	0f ac d0 0c          	shrd   eax,edx,0xc
    2582:	c1 ea 0c             	shr    edx,0xc
    2585:	83 c0 01             	add    eax,0x1
    2588:	83 d2 00             	adc    edx,0x0
    258b:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    258e:	83 c1 01             	add    ecx,0x1
    2591:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2598:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    259b:	01 d9                	add    ecx,ebx
    259d:	81 e2 ff 00 00 00    	and    edx,0xff
    25a3:	89 c3                	mov    ebx,eax
    25a5:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    25ab:	89 de                	mov    esi,ebx
    25ad:	c1 e6 0c             	shl    esi,0xc
    25b0:	8b 19                	mov    ebx,DWORD PTR [ecx]
    25b2:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    25b8:	09 f3                	or     ebx,esi
    25ba:	89 19                	mov    DWORD PTR [ecx],ebx
    25bc:	89 c3                	mov    ebx,eax
    25be:	c1 eb 14             	shr    ebx,0x14
    25c1:	89 de                	mov    esi,ebx
    25c3:	66 81 e6 ff 0f       	and    si,0xfff
    25c8:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    25cc:	66 81 e3 00 f0       	and    bx,0xf000
    25d1:	09 f3                	or     ebx,esi
    25d3:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    25d7:	0f b6 c2             	movzx  eax,dl
    25da:	c1 e0 0c             	shl    eax,0xc
    25dd:	89 c2                	mov    edx,eax
    25df:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    25e2:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    25e7:	09 d0                	or     eax,edx
    25e9:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		idx = (vp->pdpte[511] - bse) / 4096;	
    25ec:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    25ef:	8b 90 0c 20 00 00    	mov    edx,DWORD PTR [eax+0x200c]
    25f5:	8b 80 08 20 00 00    	mov    eax,DWORD PTR [eax+0x2008]
    25fb:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    25fe:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2601:	0f ac d0 0c          	shrd   eax,edx,0xc
    2605:	c1 ea 0c             	shr    edx,0xc
    2608:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    260b:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    260e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2615:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2618:	01 d0                	add    eax,edx
    261a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    261d:	83 ca 01             	or     edx,0x1
    2620:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2622:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2625:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    262c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    262f:	01 d0                	add    eax,edx
    2631:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2634:	83 ca 02             	or     edx,0x2
    2637:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2639:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    263c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2643:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2646:	01 d0                	add    eax,edx
    2648:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    264b:	83 e2 fb             	and    edx,0xfffffffb
    264e:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)m2 / 4096;
    2650:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2653:	99                   	cdq
    2654:	0f ac d0 0c          	shrd   eax,edx,0xc
    2658:	c1 ea 0c             	shr    edx,0xc
    265b:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    265e:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2665:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2668:	01 d9                	add    ecx,ebx
    266a:	81 e2 ff 00 00 00    	and    edx,0xff
    2670:	89 c3                	mov    ebx,eax
    2672:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2678:	89 de                	mov    esi,ebx
    267a:	c1 e6 0c             	shl    esi,0xc
    267d:	8b 19                	mov    ebx,DWORD PTR [ecx]
    267f:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2685:	09 f3                	or     ebx,esi
    2687:	89 19                	mov    DWORD PTR [ecx],ebx
    2689:	89 c3                	mov    ebx,eax
    268b:	c1 eb 14             	shr    ebx,0x14
    268e:	89 de                	mov    esi,ebx
    2690:	66 81 e6 ff 0f       	and    si,0xfff
    2695:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2699:	66 81 e3 00 f0       	and    bx,0xf000
    269e:	09 f3                	or     ebx,esi
    26a0:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    26a4:	0f b6 c2             	movzx  eax,dl
    26a7:	c1 e0 0c             	shl    eax,0xc
    26aa:	89 c2                	mov    edx,eax
    26ac:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    26af:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    26b4:	09 d0                	or     eax,edx
    26b6:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		pt2[idx + 1].p = 1;
    26b9:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    26bc:	83 c0 01             	add    eax,0x1
    26bf:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    26c6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    26c9:	01 d0                	add    eax,edx
    26cb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    26ce:	83 ca 01             	or     edx,0x1
    26d1:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].w = 1;
    26d3:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    26d6:	83 c0 01             	add    eax,0x1
    26d9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    26e0:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    26e3:	01 d0                	add    eax,edx
    26e5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    26e8:	83 ca 02             	or     edx,0x2
    26eb:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].u = 0;
    26ed:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    26f0:	83 c0 01             	add    eax,0x1
    26f3:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    26fa:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    26fd:	01 d0                	add    eax,edx
    26ff:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2702:	83 e2 fb             	and    edx,0xfffffffb
    2705:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx + 1].addr = (uint64_t)m2 / 4096 + 1;
    2707:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    270a:	99                   	cdq
    270b:	0f ac d0 0c          	shrd   eax,edx,0xc
    270f:	c1 ea 0c             	shr    edx,0xc
    2712:	83 c0 01             	add    eax,0x1
    2715:	83 d2 00             	adc    edx,0x0
    2718:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    271b:	83 c1 01             	add    ecx,0x1
    271e:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2725:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2728:	01 d9                	add    ecx,ebx
    272a:	81 e2 ff 00 00 00    	and    edx,0xff
    2730:	89 c3                	mov    ebx,eax
    2732:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2738:	89 de                	mov    esi,ebx
    273a:	c1 e6 0c             	shl    esi,0xc
    273d:	8b 19                	mov    ebx,DWORD PTR [ecx]
    273f:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2745:	09 f3                	or     ebx,esi
    2747:	89 19                	mov    DWORD PTR [ecx],ebx
    2749:	89 c3                	mov    ebx,eax
    274b:	c1 eb 14             	shr    ebx,0x14
    274e:	89 de                	mov    esi,ebx
    2750:	66 81 e6 ff 0f       	and    si,0xfff
    2755:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2759:	66 81 e3 00 f0       	and    bx,0xf000
    275e:	09 f3                	or     ebx,esi
    2760:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2764:	0f b6 c2             	movzx  eax,dl
    2767:	c1 e0 0c             	shl    eax,0xc
    276a:	89 c2                	mov    edx,eax
    276c:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    276f:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2774:	09 d0                	or     eax,edx
    2776:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		/* followed by the two PDs */
		idx = (m1->pds[0] - bse) / 4096;
    2779:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    277c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    277f:	8b 00                	mov    eax,DWORD PTR [eax]
    2781:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2784:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2787:	0f ac d0 0c          	shrd   eax,edx,0xc
    278b:	c1 ea 0c             	shr    edx,0xc
    278e:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2791:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2794:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    279b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    279e:	01 d0                	add    eax,edx
    27a0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    27a3:	83 ca 01             	or     edx,0x1
    27a6:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    27a8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    27ab:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    27b2:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    27b5:	01 d0                	add    eax,edx
    27b7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    27ba:	83 ca 02             	or     edx,0x2
    27bd:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    27bf:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    27c2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    27c9:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    27cc:	01 d0                	add    eax,edx
    27ce:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    27d1:	83 e2 fb             	and    edx,0xfffffffb
    27d4:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pl1 / 4096;
    27d6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    27d9:	99                   	cdq
    27da:	0f ac d0 0c          	shrd   eax,edx,0xc
    27de:	c1 ea 0c             	shr    edx,0xc
    27e1:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    27e4:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    27eb:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    27ee:	01 d9                	add    ecx,ebx
    27f0:	81 e2 ff 00 00 00    	and    edx,0xff
    27f6:	89 c3                	mov    ebx,eax
    27f8:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    27fe:	89 de                	mov    esi,ebx
    2800:	c1 e6 0c             	shl    esi,0xc
    2803:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2805:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    280b:	09 f3                	or     ebx,esi
    280d:	89 19                	mov    DWORD PTR [ecx],ebx
    280f:	89 c3                	mov    ebx,eax
    2811:	c1 eb 14             	shr    ebx,0x14
    2814:	89 de                	mov    esi,ebx
    2816:	66 81 e6 ff 0f       	and    si,0xfff
    281b:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    281f:	66 81 e3 00 f0       	and    bx,0xf000
    2824:	09 f3                	or     ebx,esi
    2826:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    282a:	0f b6 c2             	movzx  eax,dl
    282d:	c1 e0 0c             	shl    eax,0xc
    2830:	89 c2                	mov    edx,eax
    2832:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2835:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    283a:	09 d0                	or     eax,edx
    283c:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		idx = (m2->pds[511] - bse) / 4096;
    283f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2842:	8b 90 fc 0f 00 00    	mov    edx,DWORD PTR [eax+0xffc]
    2848:	8b 80 f8 0f 00 00    	mov    eax,DWORD PTR [eax+0xff8]
    284e:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2851:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2854:	0f ac d0 0c          	shrd   eax,edx,0xc
    2858:	c1 ea 0c             	shr    edx,0xc
    285b:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    285e:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2861:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2868:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    286b:	01 d0                	add    eax,edx
    286d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2870:	83 ca 01             	or     edx,0x1
    2873:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2875:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2878:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    287f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2882:	01 d0                	add    eax,edx
    2884:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2887:	83 ca 02             	or     edx,0x2
    288a:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    288c:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    288f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2896:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2899:	01 d0                	add    eax,edx
    289b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    289e:	83 e2 fb             	and    edx,0xfffffffb
    28a1:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pl2 / 4096;
    28a3:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    28a6:	99                   	cdq
    28a7:	0f ac d0 0c          	shrd   eax,edx,0xc
    28ab:	c1 ea 0c             	shr    edx,0xc
    28ae:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    28b1:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    28b8:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    28bb:	01 d9                	add    ecx,ebx
    28bd:	81 e2 ff 00 00 00    	and    edx,0xff
    28c3:	89 c3                	mov    ebx,eax
    28c5:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    28cb:	89 de                	mov    esi,ebx
    28cd:	c1 e6 0c             	shl    esi,0xc
    28d0:	8b 19                	mov    ebx,DWORD PTR [ecx]
    28d2:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    28d8:	09 f3                	or     ebx,esi
    28da:	89 19                	mov    DWORD PTR [ecx],ebx
    28dc:	89 c3                	mov    ebx,eax
    28de:	c1 eb 14             	shr    ebx,0x14
    28e1:	89 de                	mov    esi,ebx
    28e3:	66 81 e6 ff 0f       	and    si,0xfff
    28e8:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    28ec:	66 81 e3 00 f0       	and    bx,0xf000
    28f1:	09 f3                	or     ebx,esi
    28f3:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    28f7:	0f b6 c2             	movzx  eax,dl
    28fa:	c1 e0 0c             	shl    eax,0xc
    28fd:	89 c2                	mov    edx,eax
    28ff:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2902:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2907:	09 d0                	or     eax,edx
    2909:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		/* and the two PT pointer containers */
		idx = (m1->pdes[0] - bse) / 4096;
    290c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    290f:	8b 90 04 10 00 00    	mov    edx,DWORD PTR [eax+0x1004]
    2915:	8b 80 00 10 00 00    	mov    eax,DWORD PTR [eax+0x1000]
    291b:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    291e:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2921:	0f ac d0 0c          	shrd   eax,edx,0xc
    2925:	c1 ea 0c             	shr    edx,0xc
    2928:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    292b:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    292e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2935:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2938:	01 d0                	add    eax,edx
    293a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    293d:	83 ca 01             	or     edx,0x1
    2940:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2942:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2945:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    294c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    294f:	01 d0                	add    eax,edx
    2951:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2954:	83 ca 02             	or     edx,0x2
    2957:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2959:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    295c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2963:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2966:	01 d0                	add    eax,edx
    2968:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    296b:	83 e2 fb             	and    edx,0xfffffffb
    296e:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)n1 / 4096;
    2970:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2973:	99                   	cdq
    2974:	0f ac d0 0c          	shrd   eax,edx,0xc
    2978:	c1 ea 0c             	shr    edx,0xc
    297b:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    297e:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2985:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2988:	01 d9                	add    ecx,ebx
    298a:	81 e2 ff 00 00 00    	and    edx,0xff
    2990:	89 c3                	mov    ebx,eax
    2992:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2998:	89 de                	mov    esi,ebx
    299a:	c1 e6 0c             	shl    esi,0xc
    299d:	8b 19                	mov    ebx,DWORD PTR [ecx]
    299f:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    29a5:	09 f3                	or     ebx,esi
    29a7:	89 19                	mov    DWORD PTR [ecx],ebx
    29a9:	89 c3                	mov    ebx,eax
    29ab:	c1 eb 14             	shr    ebx,0x14
    29ae:	89 de                	mov    esi,ebx
    29b0:	66 81 e6 ff 0f       	and    si,0xfff
    29b5:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    29b9:	66 81 e3 00 f0       	and    bx,0xf000
    29be:	09 f3                	or     ebx,esi
    29c0:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    29c4:	0f b6 c2             	movzx  eax,dl
    29c7:	c1 e0 0c             	shl    eax,0xc
    29ca:	89 c2                	mov    edx,eax
    29cc:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    29cf:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    29d4:	09 d0                	or     eax,edx
    29d6:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		idx = (m2->pdes[511] - bse) / 4096;
    29d9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    29dc:	8b 90 fc 1f 00 00    	mov    edx,DWORD PTR [eax+0x1ffc]
    29e2:	8b 80 f8 1f 00 00    	mov    eax,DWORD PTR [eax+0x1ff8]
    29e8:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    29eb:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    29ee:	0f ac d0 0c          	shrd   eax,edx,0xc
    29f2:	c1 ea 0c             	shr    edx,0xc
    29f5:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    29f8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    29fb:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2a02:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2a05:	01 d0                	add    eax,edx
    2a07:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2a0a:	83 ca 01             	or     edx,0x1
    2a0d:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2a0f:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2a12:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2a19:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2a1c:	01 d0                	add    eax,edx
    2a1e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2a21:	83 ca 02             	or     edx,0x2
    2a24:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2a26:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2a29:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2a30:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2a33:	01 d0                	add    eax,edx
    2a35:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2a38:	83 e2 fb             	and    edx,0xfffffffb
    2a3b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)n2 / 4096;
    2a3d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2a40:	99                   	cdq
    2a41:	0f ac d0 0c          	shrd   eax,edx,0xc
    2a45:	c1 ea 0c             	shr    edx,0xc
    2a48:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2a4b:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2a52:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2a55:	01 d9                	add    ecx,ebx
    2a57:	81 e2 ff 00 00 00    	and    edx,0xff
    2a5d:	89 c3                	mov    ebx,eax
    2a5f:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2a65:	89 de                	mov    esi,ebx
    2a67:	c1 e6 0c             	shl    esi,0xc
    2a6a:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2a6c:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2a72:	09 f3                	or     ebx,esi
    2a74:	89 19                	mov    DWORD PTR [ecx],ebx
    2a76:	89 c3                	mov    ebx,eax
    2a78:	c1 eb 14             	shr    ebx,0x14
    2a7b:	89 de                	mov    esi,ebx
    2a7d:	66 81 e6 ff 0f       	and    si,0xfff
    2a82:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2a86:	66 81 e3 00 f0       	and    bx,0xf000
    2a8b:	09 f3                	or     ebx,esi
    2a8d:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2a91:	0f b6 c2             	movzx  eax,dl
    2a94:	c1 e0 0c             	shl    eax,0xc
    2a97:	89 c2                	mov    edx,eax
    2a99:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2a9c:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2aa1:	09 d0                	or     eax,edx
    2aa3:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		/* and finally the PTs */
		idx = (n1->pts[0] - bse) / 4096;
    2aa6:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2aa9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2aac:	8b 00                	mov    eax,DWORD PTR [eax]
    2aae:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2ab1:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2ab4:	0f ac d0 0c          	shrd   eax,edx,0xc
    2ab8:	c1 ea 0c             	shr    edx,0xc
    2abb:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2abe:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ac1:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2ac8:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2acb:	01 d0                	add    eax,edx
    2acd:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2ad0:	83 ca 01             	or     edx,0x1
    2ad3:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2ad5:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ad8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2adf:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2ae2:	01 d0                	add    eax,edx
    2ae4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2ae7:	83 ca 02             	or     edx,0x2
    2aea:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2aec:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2aef:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2af6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2af9:	01 d0                	add    eax,edx
    2afb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2afe:	83 e2 fb             	and    edx,0xfffffffb
    2b01:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt1 / 4096;
    2b03:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2b06:	99                   	cdq
    2b07:	0f ac d0 0c          	shrd   eax,edx,0xc
    2b0b:	c1 ea 0c             	shr    edx,0xc
    2b0e:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2b11:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2b18:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2b1b:	01 d9                	add    ecx,ebx
    2b1d:	81 e2 ff 00 00 00    	and    edx,0xff
    2b23:	89 c3                	mov    ebx,eax
    2b25:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2b2b:	89 de                	mov    esi,ebx
    2b2d:	c1 e6 0c             	shl    esi,0xc
    2b30:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2b32:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2b38:	09 f3                	or     ebx,esi
    2b3a:	89 19                	mov    DWORD PTR [ecx],ebx
    2b3c:	89 c3                	mov    ebx,eax
    2b3e:	c1 eb 14             	shr    ebx,0x14
    2b41:	89 de                	mov    esi,ebx
    2b43:	66 81 e6 ff 0f       	and    si,0xfff
    2b48:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2b4c:	66 81 e3 00 f0       	and    bx,0xf000
    2b51:	09 f3                	or     ebx,esi
    2b53:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2b57:	0f b6 c2             	movzx  eax,dl
    2b5a:	c1 e0 0c             	shl    eax,0xc
    2b5d:	89 c2                	mov    edx,eax
    2b5f:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2b62:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2b67:	09 d0                	or     eax,edx
    2b69:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		idx = (n2->pts[511] - bse) / 4096;
    2b6c:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2b6f:	8b 90 fc 0f 00 00    	mov    edx,DWORD PTR [eax+0xffc]
    2b75:	8b 80 f8 0f 00 00    	mov    eax,DWORD PTR [eax+0xff8]
    2b7b:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    2b7e:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    2b81:	0f ac d0 0c          	shrd   eax,edx,0xc
    2b85:	c1 ea 0c             	shr    edx,0xc
    2b88:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pt2[idx].p = 1;
    2b8b:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2b8e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2b95:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2b98:	01 d0                	add    eax,edx
    2b9a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2b9d:	83 ca 01             	or     edx,0x1
    2ba0:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    2ba2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2ba5:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2bac:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2baf:	01 d0                	add    eax,edx
    2bb1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2bb4:	83 ca 02             	or     edx,0x2
    2bb7:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    2bb9:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2bbc:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2bc3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2bc6:	01 d0                	add    eax,edx
    2bc8:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2bcb:	83 e2 fb             	and    edx,0xfffffffb
    2bce:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt2 / 4096;
    2bd0:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2bd3:	99                   	cdq
    2bd4:	0f ac d0 0c          	shrd   eax,edx,0xc
    2bd8:	c1 ea 0c             	shr    edx,0xc
    2bdb:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    2bde:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2be5:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    2be8:	01 d9                	add    ecx,ebx
    2bea:	81 e2 ff 00 00 00    	and    edx,0xff
    2bf0:	89 c3                	mov    ebx,eax
    2bf2:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2bf8:	89 de                	mov    esi,ebx
    2bfa:	c1 e6 0c             	shl    esi,0xc
    2bfd:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2bff:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2c05:	09 f3                	or     ebx,esi
    2c07:	89 19                	mov    DWORD PTR [ecx],ebx
    2c09:	89 c3                	mov    ebx,eax
    2c0b:	c1 eb 14             	shr    ebx,0x14
    2c0e:	89 de                	mov    esi,ebx
    2c10:	66 81 e6 ff 0f       	and    si,0xfff
    2c15:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2c19:	66 81 e3 00 f0       	and    bx,0xf000
    2c1e:	09 f3                	or     ebx,esi
    2c20:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2c24:	0f b6 c2             	movzx  eax,dl
    2c27:	c1 e0 0c             	shl    eax,0xc
    2c2a:	89 c2                	mov    edx,eax
    2c2c:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2c2f:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2c34:	09 d0                	or     eax,edx
    2c36:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
    2c39:	83 ec 04             	sub    esp,0x4
    2c3c:	6a 01                	push   0x1
    2c3e:	8d 45 a0             	lea    eax,[ebp-0x60]
    2c41:	50                   	push   eax
    2c42:	6a 01                	push   0x1
    2c44:	e8 fc ff ff ff       	call   2c45 <mm_pg64_init+0x1212>
    2c49:	83 c4 10             	add    esp,0x10
		pm_zero = pr.base;
    2c4c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2c4f:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2c52:	a3 00 00 00 00       	mov    ds:0x0,eax
    2c57:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
    2c5d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c60:	a3 00 00 00 00       	mov    ds:0x0,eax
		pp->p = p;
    2c65:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c68:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2c6b:	89 10                	mov    DWORD PTR [eax],edx
		pp->p1 = p1;
    2c6d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c70:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2c73:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pp->p2 = p2;
    2c76:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c79:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2c7c:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pp->pl1 = pl1;
    2c7f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c82:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2c85:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		pp->pl2 = pl2;
    2c88:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c8b:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2c8e:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		pp->pt1 = pt1;
    2c91:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c94:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    2c97:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pp->pt2 = pt2;
    2c9a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2c9d:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    2ca0:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		pp->m1 = m1;
    2ca3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ca6:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2ca9:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		pp->m2 = m2;
    2cac:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2caf:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2cb2:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
		pp->n1 = n1;
    2cb5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2cb8:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    2cbb:	89 50 24             	mov    DWORD PTR [eax+0x24],edx
		pp->n2 = n2;
    2cbe:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2cc1:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    2cc4:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
}
    2cc7:	90                   	nop
    2cc8:	8d 65 f8             	lea    esp,[ebp-0x8]
    2ccb:	5b                   	pop    ebx
    2ccc:	5e                   	pop    esi
    2ccd:	5d                   	pop    ebp
    2cce:	c3                   	ret

00002ccf <mm_pg36_init>:

void mm_pg36_init()
{
    2ccf:	55                   	push   ebp
    2cd0:	89 e5                	mov    ebp,esp
    2cd2:	57                   	push   edi
    2cd3:	56                   	push   esi
    2cd4:	53                   	push   ebx
    2cd5:	83 ec 5c             	sub    esp,0x5c
		struct page_range pr;
		struct vm_pg_ptrs36* vp = vm_mapping;
    2cd8:	a1 00 00 00 00       	mov    eax,ds:0x0
    2cdd:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		struct pm_pg36_ptrs* pp = (void*)(vp + 1);
    2ce0:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2ce3:	05 4c 20 00 00       	add    eax,0x204c
    2ce8:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		struct pte64 *p[4], *pt1, *pt2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
    2ceb:	68 4c 20 00 00       	push   0x204c
    2cf0:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2cf3:	e8 fc ff ff ff       	call   2cf4 <mm_pg36_init+0x25>
    2cf8:	83 c4 08             	add    esp,0x8
		vp->cur = 0xfffff000;
    2cfb:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2cfe:	c7 40 20 00 f0 ff ff 	mov    DWORD PTR [eax+0x20],0xfffff000
		bzero(pp, sizeof(*pp));
    2d05:	68 20 02 00 00       	push   0x220
    2d0a:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    2d0d:	e8 fc ff ff ff       	call   2d0e <mm_pg36_init+0x3f>
    2d12:	83 c4 08             	add    esp,0x8

		/* set CR3 to the base of vp */
		cr3_val = (uint64_t)vp;
    2d15:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d18:	99                   	cdq
    2d19:	a3 00 00 00 00       	mov    ds:0x0,eax
    2d1e:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* get the 4 page directories */
		for (size_t i = 0; i < 4; i++) {
    2d24:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    2d2b:	e9 e3 00 00 00       	jmp    2e13 <mm_pg36_init+0x144>
				mm_alloc_pm(1, &pr, 1);
    2d30:	83 ec 04             	sub    esp,0x4
    2d33:	6a 01                	push   0x1
    2d35:	8d 45 a8             	lea    eax,[ebp-0x58]
    2d38:	50                   	push   eax
    2d39:	6a 01                	push   0x1
    2d3b:	e8 fc ff ff ff       	call   2d3c <mm_pg36_init+0x6d>
    2d40:	83 c4 10             	add    esp,0x10
				/* VM mapping */
				vp->pdp[i] = vp->cur;
    2d43:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d46:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    2d49:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d4c:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    2d4f:	83 c1 08             	add    ecx,0x8
    2d52:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
				vp->cur -= 4096;
    2d56:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d59:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2d5c:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    2d62:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d65:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				/* initialize the 32bt PDPT */
				vp->pdps[i].p = 1;
    2d68:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d6b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2d6e:	0f b6 0c d0          	movzx  ecx,BYTE PTR [eax+edx*8]
    2d72:	83 c9 01             	or     ecx,0x1
    2d75:	88 0c d0             	mov    BYTE PTR [eax+edx*8],cl
				vp->pdps[i].w = 1;
    2d78:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d7b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2d7e:	0f b6 0c d0          	movzx  ecx,BYTE PTR [eax+edx*8]
    2d82:	83 c9 02             	or     ecx,0x2
    2d85:	88 0c d0             	mov    BYTE PTR [eax+edx*8],cl
				vp->pdps[i].u = 1;
    2d88:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d8b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2d8e:	0f b6 0c d0          	movzx  ecx,BYTE PTR [eax+edx*8]
    2d92:	83 c9 04             	or     ecx,0x4
    2d95:	88 0c d0             	mov    BYTE PTR [eax+edx*8],cl
				vp->pdps[i].addr = pr.base / 4096;
    2d98:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2d9b:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    2d9e:	0f ac d0 0c          	shrd   eax,edx,0xc
    2da2:	c1 ea 0c             	shr    edx,0xc
    2da5:	81 e2 ff 00 00 00    	and    edx,0xff
    2dab:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    2dae:	8b 5d dc             	mov    ebx,DWORD PTR [ebp-0x24]
    2db1:	89 c6                	mov    esi,eax
    2db3:	81 e6 ff ff 0f 00    	and    esi,0xfffff
    2db9:	89 f7                	mov    edi,esi
    2dbb:	c1 e7 0c             	shl    edi,0xc
    2dbe:	8b 34 d9             	mov    esi,DWORD PTR [ecx+ebx*8]
    2dc1:	81 e6 ff 0f 00 00    	and    esi,0xfff
    2dc7:	09 fe                	or     esi,edi
    2dc9:	89 34 d9             	mov    DWORD PTR [ecx+ebx*8],esi
    2dcc:	89 c6                	mov    esi,eax
    2dce:	c1 ee 14             	shr    esi,0x14
    2dd1:	89 f7                	mov    edi,esi
    2dd3:	66 81 e7 ff 0f       	and    di,0xfff
    2dd8:	0f b7 74 d9 04       	movzx  esi,WORD PTR [ecx+ebx*8+0x4]
    2ddd:	66 81 e6 00 f0       	and    si,0xf000
    2de2:	09 fe                	or     esi,edi
    2de4:	66 89 74 d9 04       	mov    WORD PTR [ecx+ebx*8+0x4],si
    2de9:	0f b6 c2             	movzx  eax,dl
    2dec:	c1 e0 0c             	shl    eax,0xc
    2def:	89 c2                	mov    edx,eax
    2df1:	8b 44 d9 04          	mov    eax,DWORD PTR [ecx+ebx*8+0x4]
    2df5:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2dfa:	09 d0                	or     eax,edx
    2dfc:	89 44 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],eax
				/* and get the physical pointers */
				p[i] = (void*)pr.base;
    2e00:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2e03:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    2e06:	89 c2                	mov    edx,eax
    2e08:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2e0b:	89 54 85 98          	mov    DWORD PTR [ebp+eax*4-0x68],edx
		for (size_t i = 0; i < 4; i++) {
    2e0f:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    2e13:	83 7d dc 03          	cmp    DWORD PTR [ebp-0x24],0x3
    2e17:	0f 86 13 ff ff ff    	jbe    2d30 <mm_pg36_init+0x61>
		}


		/* create the VM mapping of the PDPTEs */
		uint32_t ct = mm_alloc_pm(2, &pr, 1); /* TODO check cont */
    2e1d:	83 ec 04             	sub    esp,0x4
    2e20:	6a 01                	push   0x1
    2e22:	8d 45 a8             	lea    eax,[ebp-0x58]
    2e25:	50                   	push   eax
    2e26:	6a 02                	push   0x2
    2e28:	e8 fc ff ff ff       	call   2e29 <mm_pg36_init+0x15a>
    2e2d:	83 c4 10             	add    esp,0x10
    2e30:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax

		/* now allocate the two page tables */
		for (size_t i = 0; i < 2048; i += 2047) { /* 0, 2047 */
    2e33:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    2e3a:	e9 52 01 00 00       	jmp    2f91 <mm_pg36_init+0x2c2>
				struct pte64* pd = p[i / 512];
    2e3f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2e42:	c1 e8 09             	shr    eax,0x9
    2e45:	8b 44 85 98          	mov    eax,DWORD PTR [ebp+eax*4-0x68]
    2e49:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				mm_alloc_pm(1, &pr, 1);
    2e4c:	83 ec 04             	sub    esp,0x4
    2e4f:	6a 01                	push   0x1
    2e51:	8d 45 a8             	lea    eax,[ebp-0x58]
    2e54:	50                   	push   eax
    2e55:	6a 01                	push   0x1
    2e57:	e8 fc ff ff ff       	call   2e58 <mm_pg36_init+0x189>
    2e5c:	83 c4 10             	add    esp,0x10
				/* VM mapping */
				vp->pts[i] = vp->cur;
    2e5f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2e62:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    2e65:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2e68:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    2e6b:	83 c1 0c             	add    ecx,0xc
    2e6e:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
				vp->cur -= 4096;
    2e72:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2e75:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2e78:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    2e7e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2e81:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				/* register in PD */
				pd[i % 512].p = 1;
    2e84:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2e87:	25 ff 01 00 00       	and    eax,0x1ff
    2e8c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2e93:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    2e96:	01 d0                	add    eax,edx
    2e98:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2e9b:	83 ca 01             	or     edx,0x1
    2e9e:	88 10                	mov    BYTE PTR [eax],dl
				pd[i % 512].w = 1;
    2ea0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2ea3:	25 ff 01 00 00       	and    eax,0x1ff
    2ea8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2eaf:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    2eb2:	01 d0                	add    eax,edx
    2eb4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2eb7:	83 ca 02             	or     edx,0x2
    2eba:	88 10                	mov    BYTE PTR [eax],dl
				pd[i % 512].u = 0;
    2ebc:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2ebf:	25 ff 01 00 00       	and    eax,0x1ff
    2ec4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2ecb:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    2ece:	01 d0                	add    eax,edx
    2ed0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2ed3:	83 e2 fb             	and    edx,0xfffffffb
    2ed6:	88 10                	mov    BYTE PTR [eax],dl
				pd[i % 512].xd = 0; /* TODO: XD on PT1? */
    2ed8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2edb:	25 ff 01 00 00       	and    eax,0x1ff
    2ee0:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2ee7:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    2eea:	01 d0                	add    eax,edx
    2eec:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    2ef0:	83 e2 7f             	and    edx,0x7f
    2ef3:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				pd[i % 512].addr = pr.base / 4096;
    2ef6:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2ef9:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    2efc:	0f ac d0 0c          	shrd   eax,edx,0xc
    2f00:	c1 ea 0c             	shr    edx,0xc
    2f03:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    2f06:	81 e1 ff 01 00 00    	and    ecx,0x1ff
    2f0c:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    2f13:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    2f16:	01 d9                	add    ecx,ebx
    2f18:	81 e2 ff 00 00 00    	and    edx,0xff
    2f1e:	89 c3                	mov    ebx,eax
    2f20:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2f26:	89 de                	mov    esi,ebx
    2f28:	c1 e6 0c             	shl    esi,0xc
    2f2b:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2f2d:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2f33:	09 f3                	or     ebx,esi
    2f35:	89 19                	mov    DWORD PTR [ecx],ebx
    2f37:	89 c3                	mov    ebx,eax
    2f39:	c1 eb 14             	shr    ebx,0x14
    2f3c:	89 de                	mov    esi,ebx
    2f3e:	66 81 e6 ff 0f       	and    si,0xfff
    2f43:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2f47:	66 81 e3 00 f0       	and    bx,0xf000
    2f4c:	09 f3                	or     ebx,esi
    2f4e:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2f52:	0f b6 c2             	movzx  eax,dl
    2f55:	c1 e0 0c             	shl    eax,0xc
    2f58:	89 c2                	mov    edx,eax
    2f5a:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2f5d:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2f62:	09 d0                	or     eax,edx
    2f64:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				/* get the physical pointers */
				if (!i)
    2f67:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    2f6b:	75 0b                	jne    2f78 <mm_pg36_init+0x2a9>
						pt1 = (void*)pr.base;
    2f6d:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2f70:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    2f73:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    2f76:	eb 12                	jmp    2f8a <mm_pg36_init+0x2bb>
				else if (i == 2047)
    2f78:	81 7d d8 ff 07 00 00 	cmp    DWORD PTR [ebp-0x28],0x7ff
    2f7f:	75 09                	jne    2f8a <mm_pg36_init+0x2bb>
						pt2 = (void*)pr.base;
    2f81:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2f84:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    2f87:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		for (size_t i = 0; i < 2048; i += 2047) { /* 0, 2047 */
    2f8a:	81 45 d8 ff 07 00 00 	add    DWORD PTR [ebp-0x28],0x7ff
    2f91:	81 7d d8 ff 07 00 00 	cmp    DWORD PTR [ebp-0x28],0x7ff
    2f98:	0f 86 a1 fe ff ff    	jbe    2e3f <mm_pg36_init+0x170>
		}

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
    2f9e:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    2fa5:	e9 b0 00 00 00       	jmp    305a <mm_pg36_init+0x38b>
				/* identity CD */
				pt1[i].p = 1;
    2faa:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2fad:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2fb4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2fb7:	01 d0                	add    eax,edx
    2fb9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2fbc:	83 ca 01             	or     edx,0x1
    2fbf:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].w = 1;
    2fc1:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2fc4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2fcb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2fce:	01 d0                	add    eax,edx
    2fd0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2fd3:	83 ca 02             	or     edx,0x2
    2fd6:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].u = 1;
    2fd8:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2fdb:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2fe2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2fe5:	01 d0                	add    eax,edx
    2fe7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2fea:	83 ca 04             	or     edx,0x4
    2fed:	88 10                	mov    BYTE PTR [eax],dl
				//pt1[i].xd = 1;
				pt1[i].addr = i; /* identity */
    2fef:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2ff2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    2ff9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2ffc:	8d 0c 02             	lea    ecx,[edx+eax*1]
    2fff:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3002:	ba 00 00 00 00       	mov    edx,0x0
    3007:	81 e2 ff 00 00 00    	and    edx,0xff
    300d:	89 c3                	mov    ebx,eax
    300f:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    3015:	89 de                	mov    esi,ebx
    3017:	c1 e6 0c             	shl    esi,0xc
    301a:	8b 19                	mov    ebx,DWORD PTR [ecx]
    301c:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3022:	09 f3                	or     ebx,esi
    3024:	89 19                	mov    DWORD PTR [ecx],ebx
    3026:	89 c3                	mov    ebx,eax
    3028:	c1 eb 14             	shr    ebx,0x14
    302b:	89 de                	mov    esi,ebx
    302d:	66 81 e6 ff 0f       	and    si,0xfff
    3032:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    3036:	66 81 e3 00 f0       	and    bx,0xf000
    303b:	09 f3                	or     ebx,esi
    303d:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3041:	0f b6 c2             	movzx  eax,dl
    3044:	c1 e0 0c             	shl    eax,0xc
    3047:	89 c2                	mov    edx,eax
    3049:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    304c:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3051:	09 d0                	or     eax,edx
    3053:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		for (size_t i = 0; i < 256; i++) {
    3056:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
    305a:	81 7d d4 ff 00 00 00 	cmp    DWORD PTR [ebp-0x2c],0xff
    3061:	0f 86 43 ff ff ff    	jbe    2faa <mm_pg36_init+0x2db>
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint32_t bse = 0xffe00000; /* base of last PT */
    3067:	c7 45 bc 00 00 e0 ff 	mov    DWORD PTR [ebp-0x44],0xffe00000
		size_t idx;
		/* first the four PDs */
		for (size_t i = 0; i < 4; i++) {
    306e:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    3075:	e9 cc 00 00 00       	jmp    3146 <mm_pg36_init+0x477>
				idx = (vp->pdp[i] - bse) / 4096;
    307a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    307d:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    3080:	83 c2 08             	add    edx,0x8
    3083:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    3087:	2b 45 bc             	sub    eax,DWORD PTR [ebp-0x44]
    308a:	c1 e8 0c             	shr    eax,0xc
    308d:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				pt2[idx].p = 1;
    3090:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3093:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    309a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    309d:	01 d0                	add    eax,edx
    309f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    30a2:	83 ca 01             	or     edx,0x1
    30a5:	88 10                	mov    BYTE PTR [eax],dl
				pt2[idx].w = 1;
    30a7:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    30aa:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    30b1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    30b4:	01 d0                	add    eax,edx
    30b6:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    30b9:	83 ca 02             	or     edx,0x2
    30bc:	88 10                	mov    BYTE PTR [eax],dl
				pt2[idx].u = 0; /* only supervisor access to pts */
    30be:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    30c1:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    30c8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    30cb:	01 d0                	add    eax,edx
    30cd:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    30d0:	83 e2 fb             	and    edx,0xfffffffb
    30d3:	88 10                	mov    BYTE PTR [eax],dl
				pt2[idx].addr = (uint64_t)p[i] / 4096;
    30d5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    30d8:	8b 44 85 98          	mov    eax,DWORD PTR [ebp+eax*4-0x68]
    30dc:	99                   	cdq
    30dd:	0f ac d0 0c          	shrd   eax,edx,0xc
    30e1:	c1 ea 0c             	shr    edx,0xc
    30e4:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
    30e7:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    30ee:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    30f1:	01 d9                	add    ecx,ebx
    30f3:	81 e2 ff 00 00 00    	and    edx,0xff
    30f9:	89 c3                	mov    ebx,eax
    30fb:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    3101:	89 de                	mov    esi,ebx
    3103:	c1 e6 0c             	shl    esi,0xc
    3106:	8b 19                	mov    ebx,DWORD PTR [ecx]
    3108:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    310e:	09 f3                	or     ebx,esi
    3110:	89 19                	mov    DWORD PTR [ecx],ebx
    3112:	89 c3                	mov    ebx,eax
    3114:	c1 eb 14             	shr    ebx,0x14
    3117:	89 de                	mov    esi,ebx
    3119:	66 81 e6 ff 0f       	and    si,0xfff
    311e:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    3122:	66 81 e3 00 f0       	and    bx,0xf000
    3127:	09 f3                	or     ebx,esi
    3129:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    312d:	0f b6 c2             	movzx  eax,dl
    3130:	c1 e0 0c             	shl    eax,0xc
    3133:	89 c2                	mov    edx,eax
    3135:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    3138:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    313d:	09 d0                	or     eax,edx
    313f:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		for (size_t i = 0; i < 4; i++) {
    3142:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
    3146:	83 7d d0 03          	cmp    DWORD PTR [ebp-0x30],0x3
    314a:	0f 86 2a ff ff ff    	jbe    307a <mm_pg36_init+0x3ab>
		}
		/* vp is identity mapped -> no need for doing sth.
		 * (TODO: protection) */

		/* then the 2 PTs */
		idx = (vp->pts[0] - bse) / 4096;
    3150:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3153:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    3156:	2b 45 bc             	sub    eax,DWORD PTR [ebp-0x44]
    3159:	c1 e8 0c             	shr    eax,0xc
    315c:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
		pt2[idx].p = 1;
    315f:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3162:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3169:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    316c:	01 d0                	add    eax,edx
    316e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3171:	83 ca 01             	or     edx,0x1
    3174:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    3176:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3179:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3180:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3183:	01 d0                	add    eax,edx
    3185:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3188:	83 ca 02             	or     edx,0x2
    318b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    318d:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3190:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3197:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    319a:	01 d0                	add    eax,edx
    319c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    319f:	83 e2 fb             	and    edx,0xfffffffb
    31a2:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt1 / 4096;
    31a4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    31a7:	99                   	cdq
    31a8:	0f ac d0 0c          	shrd   eax,edx,0xc
    31ac:	c1 ea 0c             	shr    edx,0xc
    31af:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
    31b2:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    31b9:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    31bc:	01 d9                	add    ecx,ebx
    31be:	81 e2 ff 00 00 00    	and    edx,0xff
    31c4:	89 c3                	mov    ebx,eax
    31c6:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    31cc:	89 de                	mov    esi,ebx
    31ce:	c1 e6 0c             	shl    esi,0xc
    31d1:	8b 19                	mov    ebx,DWORD PTR [ecx]
    31d3:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    31d9:	09 f3                	or     ebx,esi
    31db:	89 19                	mov    DWORD PTR [ecx],ebx
    31dd:	89 c3                	mov    ebx,eax
    31df:	c1 eb 14             	shr    ebx,0x14
    31e2:	89 de                	mov    esi,ebx
    31e4:	66 81 e6 ff 0f       	and    si,0xfff
    31e9:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    31ed:	66 81 e3 00 f0       	and    bx,0xf000
    31f2:	09 f3                	or     ebx,esi
    31f4:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    31f8:	0f b6 c2             	movzx  eax,dl
    31fb:	c1 e0 0c             	shl    eax,0xc
    31fe:	89 c2                	mov    edx,eax
    3200:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    3203:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3208:	09 d0                	or     eax,edx
    320a:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
		idx = (vp->pts[2047] - bse) / 4096;
    320d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3210:	8b 80 30 20 00 00    	mov    eax,DWORD PTR [eax+0x2030]
    3216:	2b 45 bc             	sub    eax,DWORD PTR [ebp-0x44]
    3219:	c1 e8 0c             	shr    eax,0xc
    321c:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
		pt2[idx].p = 1;
    321f:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3222:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3229:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    322c:	01 d0                	add    eax,edx
    322e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3231:	83 ca 01             	or     edx,0x1
    3234:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    3236:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3239:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3240:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3243:	01 d0                	add    eax,edx
    3245:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3248:	83 ca 02             	or     edx,0x2
    324b:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    324d:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3250:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3257:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    325a:	01 d0                	add    eax,edx
    325c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    325f:	83 e2 fb             	and    edx,0xfffffffb
    3262:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint64_t)pt2 / 4096;
    3264:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3267:	99                   	cdq
    3268:	0f ac d0 0c          	shrd   eax,edx,0xc
    326c:	c1 ea 0c             	shr    edx,0xc
    326f:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
    3272:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    3279:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    327c:	01 d9                	add    ecx,ebx
    327e:	81 e2 ff 00 00 00    	and    edx,0xff
    3284:	89 c3                	mov    ebx,eax
    3286:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    328c:	89 de                	mov    esi,ebx
    328e:	c1 e6 0c             	shl    esi,0xc
    3291:	8b 19                	mov    ebx,DWORD PTR [ecx]
    3293:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3299:	09 f3                	or     ebx,esi
    329b:	89 19                	mov    DWORD PTR [ecx],ebx
    329d:	89 c3                	mov    ebx,eax
    329f:	c1 eb 14             	shr    ebx,0x14
    32a2:	89 de                	mov    esi,ebx
    32a4:	66 81 e6 ff 0f       	and    si,0xfff
    32a9:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    32ad:	66 81 e3 00 f0       	and    bx,0xf000
    32b2:	09 f3                	or     ebx,esi
    32b4:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    32b8:	0f b6 c2             	movzx  eax,dl
    32bb:	c1 e0 0c             	shl    eax,0xc
    32be:	89 c2                	mov    edx,eax
    32c0:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    32c3:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    32c8:	09 d0                	or     eax,edx
    32ca:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
    32cd:	83 ec 04             	sub    esp,0x4
    32d0:	6a 01                	push   0x1
    32d2:	8d 45 a8             	lea    eax,[ebp-0x58]
    32d5:	50                   	push   eax
    32d6:	6a 01                	push   0x1
    32d8:	e8 fc ff ff ff       	call   32d9 <mm_pg36_init+0x60a>
    32dd:	83 c4 10             	add    esp,0x10
		pm_zero = pr.base;
    32e0:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    32e3:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    32e6:	a3 00 00 00 00       	mov    ds:0x0,eax
    32eb:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
    32f1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    32f4:	a3 00 00 00 00       	mov    ds:0x0,eax
		pp->p = vp->pdps;
    32f9:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    32fc:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    32ff:	89 10                	mov    DWORD PTR [eax],edx
		for (size_t i = 0; i < 4; i++)
    3301:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    3308:	eb 15                	jmp    331f <mm_pg36_init+0x650>
				pp->pds[i] = p[i];
    330a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    330d:	8b 4c 85 98          	mov    ecx,DWORD PTR [ebp+eax*4-0x68]
    3311:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3314:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3317:	89 4c 90 04          	mov    DWORD PTR [eax+edx*4+0x4],ecx
		for (size_t i = 0; i < 4; i++)
    331b:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
    331f:	83 7d cc 03          	cmp    DWORD PTR [ebp-0x34],0x3
    3323:	76 e5                	jbe    330a <mm_pg36_init+0x63b>
		pp->pt1 = pt1;
    3325:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3328:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    332b:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pp->pt2 = pt2;
    332e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3331:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3334:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
}
    3337:	90                   	nop
    3338:	8d 65 f4             	lea    esp,[ebp-0xc]
    333b:	5b                   	pop    ebx
    333c:	5e                   	pop    esi
    333d:	5f                   	pop    edi
    333e:	5d                   	pop    ebp
    333f:	c3                   	ret

00003340 <mm_pg32_init>:

void mm_pg32_init()
{
    3340:	55                   	push   ebp
    3341:	89 e5                	mov    ebp,esp
    3343:	53                   	push   ebx
    3344:	83 ec 34             	sub    esp,0x34
		struct page_range pr;
		struct vm_pg_ptrs32* vp = vm_mapping;
    3347:	a1 00 00 00 00       	mov    eax,ds:0x0
    334c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct pm_pg32_ptrs* pp = (void*)(vp + 1);
    334f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3352:	05 20 10 00 00       	add    eax,0x1020
    3357:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		struct pte32 *pd, *pt1, *pt2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
    335a:	68 20 10 00 00       	push   0x1020
    335f:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    3362:	e8 fc ff ff ff       	call   3363 <mm_pg32_init+0x23>
    3367:	83 c4 08             	add    esp,0x8
		vp->cur = 0xfffff000;
    336a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    336d:	c7 00 00 f0 ff ff    	mov    DWORD PTR [eax],0xfffff000
		bzero(pp, sizeof(*pp));
    3373:	68 10 02 00 00       	push   0x210
    3378:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    337b:	e8 fc ff ff ff       	call   337c <mm_pg32_init+0x3c>
    3380:	83 c4 08             	add    esp,0x8

		/* allocate the PD */
		mm_alloc_pm(1, &pr, 1);
    3383:	83 ec 04             	sub    esp,0x4
    3386:	6a 01                	push   0x1
    3388:	8d 45 c8             	lea    eax,[ebp-0x38]
    338b:	50                   	push   eax
    338c:	6a 01                	push   0x1
    338e:	e8 fc ff ff ff       	call   338f <mm_pg32_init+0x4f>
    3393:	83 c4 10             	add    esp,0x10
		vp->pd = vp->cur;
    3396:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3399:	8b 10                	mov    edx,DWORD PTR [eax]
    339b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    339e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		vp->cur -= 4096;
    33a1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    33a4:	8b 00                	mov    eax,DWORD PTR [eax]
    33a6:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    33ac:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    33af:	89 10                	mov    DWORD PTR [eax],edx

		/* set CR3 to its base */
		cr3_val = pr.base;
    33b1:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    33b4:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    33b7:	a3 00 00 00 00       	mov    ds:0x0,eax
    33bc:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		pd = (void*)pr.base;
    33c2:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    33c5:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    33c8:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* now allocate the two page tables */
		for (size_t i = 0; i < 1024; i += 1023) { /* 0, 1023 */
    33cb:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    33d2:	e9 d2 00 00 00       	jmp    34a9 <mm_pg32_init+0x169>
				mm_alloc_pm(1, &pr, 1);
    33d7:	83 ec 04             	sub    esp,0x4
    33da:	6a 01                	push   0x1
    33dc:	8d 45 c8             	lea    eax,[ebp-0x38]
    33df:	50                   	push   eax
    33e0:	6a 01                	push   0x1
    33e2:	e8 fc ff ff ff       	call   33e3 <mm_pg32_init+0xa3>
    33e7:	83 c4 10             	add    esp,0x10
				/* VM mapping */
				vp->pts[i] = vp->cur;
    33ea:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    33ed:	8b 08                	mov    ecx,DWORD PTR [eax]
    33ef:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    33f2:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    33f5:	89 4c 90 08          	mov    DWORD PTR [eax+edx*4+0x8],ecx
				vp->cur -= 4096;
    33f9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    33fc:	8b 00                	mov    eax,DWORD PTR [eax]
    33fe:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    3404:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3407:	89 10                	mov    DWORD PTR [eax],edx
				/* register in PD */
				pd[i].p = 1;
    3409:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    340c:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3413:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3416:	01 d0                	add    eax,edx
    3418:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    341b:	83 ca 01             	or     edx,0x1
    341e:	88 10                	mov    BYTE PTR [eax],dl
				pd[i].w = 1;
    3420:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3423:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    342a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    342d:	01 d0                	add    eax,edx
    342f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3432:	83 ca 02             	or     edx,0x2
    3435:	88 10                	mov    BYTE PTR [eax],dl
				pd[i].u = 0;
    3437:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    343a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3441:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3444:	01 d0                	add    eax,edx
    3446:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3449:	83 e2 fb             	and    edx,0xfffffffb
    344c:	88 10                	mov    BYTE PTR [eax],dl
				pd[i].addr = pr.base / 4096;
    344e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3451:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3454:	0f ac d0 0c          	shrd   eax,edx,0xc
    3458:	c1 ea 0c             	shr    edx,0xc
    345b:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    345e:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
    3465:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    3468:	01 d9                	add    ecx,ebx
    346a:	25 ff ff 0f 00       	and    eax,0xfffff
    346f:	c1 e0 0c             	shl    eax,0xc
    3472:	89 c2                	mov    edx,eax
    3474:	8b 01                	mov    eax,DWORD PTR [ecx]
    3476:	25 ff 0f 00 00       	and    eax,0xfff
    347b:	09 d0                	or     eax,edx
    347d:	89 01                	mov    DWORD PTR [ecx],eax
				/* get the physical pointers */
				if (!i)
    347f:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    3483:	75 0b                	jne    3490 <mm_pg32_init+0x150>
						pt1 = (void*)pr.base;
    3485:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3488:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    348b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    348e:	eb 12                	jmp    34a2 <mm_pg32_init+0x162>
				else if (i == 1023)
    3490:	81 7d ec ff 03 00 00 	cmp    DWORD PTR [ebp-0x14],0x3ff
    3497:	75 09                	jne    34a2 <mm_pg32_init+0x162>
						pt2 = (void*)pr.base;
    3499:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    349c:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    349f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		for (size_t i = 0; i < 1024; i += 1023) { /* 0, 1023 */
    34a2:	81 45 ec ff 03 00 00 	add    DWORD PTR [ebp-0x14],0x3ff
    34a9:	81 7d ec ff 03 00 00 	cmp    DWORD PTR [ebp-0x14],0x3ff
    34b0:	0f 86 21 ff ff ff    	jbe    33d7 <mm_pg32_init+0x97>
		}

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
    34b6:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    34bd:	eb 72                	jmp    3531 <mm_pg32_init+0x1f1>
				/* identity CD */
				pt1[i].p = 1;
    34bf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    34c2:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    34c9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    34cc:	01 d0                	add    eax,edx
    34ce:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    34d1:	83 ca 01             	or     edx,0x1
    34d4:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].w = 1;
    34d6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    34d9:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    34e0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    34e3:	01 d0                	add    eax,edx
    34e5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    34e8:	83 ca 02             	or     edx,0x2
    34eb:	88 10                	mov    BYTE PTR [eax],dl
				pt1[i].u = 1;
    34ed:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    34f0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    34f7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    34fa:	01 d0                	add    eax,edx
    34fc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    34ff:	83 ca 04             	or     edx,0x4
    3502:	88 10                	mov    BYTE PTR [eax],dl
				//pt1[i].xd = 1; <- NOT in 32-bit paging
				pt1[i].addr = i; /* identity */
    3504:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3507:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    350e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3511:	01 d0                	add    eax,edx
    3513:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    3516:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    351c:	89 d1                	mov    ecx,edx
    351e:	c1 e1 0c             	shl    ecx,0xc
    3521:	8b 10                	mov    edx,DWORD PTR [eax]
    3523:	81 e2 ff 0f 00 00    	and    edx,0xfff
    3529:	09 ca                	or     edx,ecx
    352b:	89 10                	mov    DWORD PTR [eax],edx
		for (size_t i = 0; i < 256; i++) {
    352d:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
    3531:	81 7d e8 ff 00 00 00 	cmp    DWORD PTR [ebp-0x18],0xff
    3538:	76 85                	jbe    34bf <mm_pg32_init+0x17f>
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint32_t bse = 0xffc00000; /* base of last PT */
    353a:	c7 45 d8 00 00 c0 ff 	mov    DWORD PTR [ebp-0x28],0xffc00000
		size_t idx;
		/* first the PD */
		idx = (vp->pd - bse) / 4096;
    3541:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3544:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3547:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    354a:	c1 e8 0c             	shr    eax,0xc
    354d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		pt2[idx].p = 1;
    3550:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3553:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    355a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    355d:	01 d0                	add    eax,edx
    355f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3562:	83 ca 01             	or     edx,0x1
    3565:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    3567:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    356a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3571:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3574:	01 d0                	add    eax,edx
    3576:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3579:	83 ca 02             	or     edx,0x2
    357c:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0; /* only supervisor access to pts */
    357e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3581:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3588:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    358b:	01 d0                	add    eax,edx
    358d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3590:	83 e2 fb             	and    edx,0xfffffffb
    3593:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint32_t)pd / 4096;
    3595:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3598:	c1 e8 0c             	shr    eax,0xc
    359b:	89 c2                	mov    edx,eax
    359d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    35a0:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    35a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    35aa:	01 c8                	add    eax,ecx
    35ac:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    35b2:	89 d1                	mov    ecx,edx
    35b4:	c1 e1 0c             	shl    ecx,0xc
    35b7:	8b 10                	mov    edx,DWORD PTR [eax]
    35b9:	81 e2 ff 0f 00 00    	and    edx,0xfff
    35bf:	09 ca                	or     edx,ecx
    35c1:	89 10                	mov    DWORD PTR [eax],edx
		/* vp is identity mapped -> no need for doing sth.
		 * (TODO: protection) */

		/* then the 2 PTs */
		idx = (vp->pts[0] - bse) / 4096;
    35c3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    35c6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    35c9:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    35cc:	c1 e8 0c             	shr    eax,0xc
    35cf:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		pt2[idx].p = 1;
    35d2:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    35d5:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    35dc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    35df:	01 d0                	add    eax,edx
    35e1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    35e4:	83 ca 01             	or     edx,0x1
    35e7:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    35e9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    35ec:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    35f3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    35f6:	01 d0                	add    eax,edx
    35f8:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    35fb:	83 ca 02             	or     edx,0x2
    35fe:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    3600:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3603:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    360a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    360d:	01 d0                	add    eax,edx
    360f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3612:	83 e2 fb             	and    edx,0xfffffffb
    3615:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint32_t)pt1 / 4096;
    3617:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    361a:	c1 e8 0c             	shr    eax,0xc
    361d:	89 c2                	mov    edx,eax
    361f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3622:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    3629:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    362c:	01 c8                	add    eax,ecx
    362e:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    3634:	89 d1                	mov    ecx,edx
    3636:	c1 e1 0c             	shl    ecx,0xc
    3639:	8b 10                	mov    edx,DWORD PTR [eax]
    363b:	81 e2 ff 0f 00 00    	and    edx,0xfff
    3641:	09 ca                	or     edx,ecx
    3643:	89 10                	mov    DWORD PTR [eax],edx
		idx = (vp->pts[1023] - bse) / 4096;
    3645:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3648:	8b 80 04 10 00 00    	mov    eax,DWORD PTR [eax+0x1004]
    364e:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    3651:	c1 e8 0c             	shr    eax,0xc
    3654:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		pt2[idx].p = 1;
    3657:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    365a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3661:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3664:	01 d0                	add    eax,edx
    3666:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3669:	83 ca 01             	or     edx,0x1
    366c:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].w = 1;
    366e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3671:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    3678:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    367b:	01 d0                	add    eax,edx
    367d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3680:	83 ca 02             	or     edx,0x2
    3683:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].u = 0;
    3685:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3688:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    368f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3692:	01 d0                	add    eax,edx
    3694:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3697:	83 e2 fb             	and    edx,0xfffffffb
    369a:	88 10                	mov    BYTE PTR [eax],dl
		pt2[idx].addr = (uint32_t)pt2 / 4096;
    369c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    369f:	c1 e8 0c             	shr    eax,0xc
    36a2:	89 c2                	mov    edx,eax
    36a4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    36a7:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    36ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    36b1:	01 c8                	add    eax,ecx
    36b3:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    36b9:	89 d1                	mov    ecx,edx
    36bb:	c1 e1 0c             	shl    ecx,0xc
    36be:	8b 10                	mov    edx,DWORD PTR [eax]
    36c0:	81 e2 ff 0f 00 00    	and    edx,0xfff
    36c6:	09 ca                	or     edx,ecx
    36c8:	89 10                	mov    DWORD PTR [eax],edx

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
    36ca:	83 ec 04             	sub    esp,0x4
    36cd:	6a 01                	push   0x1
    36cf:	8d 45 c8             	lea    eax,[ebp-0x38]
    36d2:	50                   	push   eax
    36d3:	6a 01                	push   0x1
    36d5:	e8 fc ff ff ff       	call   36d6 <mm_pg32_init+0x396>
    36da:	83 c4 10             	add    esp,0x10
		pm_zero = pr.base;
    36dd:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    36e0:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    36e3:	a3 00 00 00 00       	mov    ds:0x0,eax
    36e8:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
    36ee:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    36f1:	a3 00 00 00 00       	mov    ds:0x0,eax
		pp->pd = pd;
    36f6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    36f9:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    36fc:	89 10                	mov    DWORD PTR [eax],edx
		pp->pt1 = pt1;
    36fe:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3701:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3704:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pp->pt2 = pt2;
    3707:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    370a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    370d:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
}
    3710:	90                   	nop
    3711:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    3714:	c9                   	leave
    3715:	c3                   	ret

00003716 <mm_prepare_paging>:

void mm_prepare_paging(int mode)
{
    3716:	55                   	push   ebp
    3717:	89 e5                	mov    ebp,esp
    3719:	83 ec 08             	sub    esp,0x8
		if (!mode)
    371c:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    3720:	75 07                	jne    3729 <mm_prepare_paging+0x13>
				mm_pg32_init();
    3722:	e8 fc ff ff ff       	call   3723 <mm_prepare_paging+0xd>
		else if (mode == 1)
				mm_pg36_init();
		else
				mm_pg64_init();
}
    3727:	eb 12                	jmp    373b <mm_prepare_paging+0x25>
		else if (mode == 1)
    3729:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    372d:	75 07                	jne    3736 <mm_prepare_paging+0x20>
				mm_pg36_init();
    372f:	e8 fc ff ff ff       	call   3730 <mm_prepare_paging+0x1a>
}
    3734:	eb 05                	jmp    373b <mm_prepare_paging+0x25>
				mm_pg64_init();
    3736:	e8 fc ff ff ff       	call   3737 <mm_prepare_paging+0x21>
}
    373b:	90                   	nop
    373c:	c9                   	leave
    373d:	c3                   	ret

0000373e <mm_initialize>:

void mm_initialize(int mode)
{
    373e:	55                   	push   ebp
    373f:	89 e5                	mov    ebp,esp
    3741:	57                   	push   edi
    3742:	56                   	push   esi
    3743:	53                   	push   ebx
    3744:	83 ec 2c             	sub    esp,0x2c
		/* prepare the BIOS-provided memory map */
		struct mp* map = mem_map;
    3747:	c7 45 e4 00 00 02 00 	mov    DWORD PTR [ebp-0x1c],0x20000
		do {
				if (map->type == 1)
    374e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3751:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3754:	83 f8 01             	cmp    eax,0x1
    3757:	75 1f                	jne    3778 <mm_initialize+0x3a>
						mm_add_free(map->base, map->size);
    3759:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    375c:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    375f:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    3762:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3765:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3768:	8b 00                	mov    eax,DWORD PTR [eax]
    376a:	53                   	push   ebx
    376b:	51                   	push   ecx
    376c:	52                   	push   edx
    376d:	50                   	push   eax
    376e:	e8 fc ff ff ff       	call   376f <mm_initialize+0x31>
    3773:	83 c4 10             	add    esp,0x10
    3776:	eb 1d                	jmp    3795 <mm_initialize+0x57>
				else
						mm_add_reserved(map->base, map->size);
    3778:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    377b:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    377e:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    3781:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3784:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3787:	8b 00                	mov    eax,DWORD PTR [eax]
    3789:	53                   	push   ebx
    378a:	51                   	push   ecx
    378b:	52                   	push   edx
    378c:	50                   	push   eax
    378d:	e8 fc ff ff ff       	call   378e <mm_initialize+0x50>
    3792:	83 c4 10             	add    esp,0x10
				map++;
    3795:	83 45 e4 18          	add    DWORD PTR [ebp-0x1c],0x18
		} while (map->base || map->size || map->type);
    3799:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    379c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    379f:	8b 00                	mov    eax,DWORD PTR [eax]
    37a1:	89 c1                	mov    ecx,eax
    37a3:	89 c8                	mov    eax,ecx
    37a5:	09 d0                	or     eax,edx
    37a7:	75 a5                	jne    374e <mm_initialize+0x10>
    37a9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37ac:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    37af:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    37b2:	89 c1                	mov    ecx,eax
    37b4:	89 c8                	mov    eax,ecx
    37b6:	09 d0                	or     eax,edx
    37b8:	75 94                	jne    374e <mm_initialize+0x10>
    37ba:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37bd:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    37c0:	85 c0                	test   eax,eax
    37c2:	75 8a                	jne    374e <mm_initialize+0x10>

		/* now remove overlapping entries */
		map = mem_map;
    37c4:	c7 45 e4 00 00 02 00 	mov    DWORD PTR [ebp-0x1c],0x20000
		do {
				if (map->type != 1)
    37cb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37ce:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    37d1:	83 f8 01             	cmp    eax,0x1
    37d4:	74 1d                	je     37f3 <mm_initialize+0xb5>
						mm_sub_block(map->base, map->size);
    37d6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37d9:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    37dc:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    37df:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37e2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    37e5:	8b 00                	mov    eax,DWORD PTR [eax]
    37e7:	53                   	push   ebx
    37e8:	51                   	push   ecx
    37e9:	52                   	push   edx
    37ea:	50                   	push   eax
    37eb:	e8 fc ff ff ff       	call   37ec <mm_initialize+0xae>
    37f0:	83 c4 10             	add    esp,0x10
				map++;
    37f3:	83 45 e4 18          	add    DWORD PTR [ebp-0x1c],0x18
		} while (map->base || map->size || map->type);
    37f7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37fa:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    37fd:	8b 00                	mov    eax,DWORD PTR [eax]
    37ff:	89 c1                	mov    ecx,eax
    3801:	89 c8                	mov    eax,ecx
    3803:	09 d0                	or     eax,edx
    3805:	75 c4                	jne    37cb <mm_initialize+0x8d>
    3807:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    380a:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    380d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3810:	89 c1                	mov    ecx,eax
    3812:	89 c8                	mov    eax,ecx
    3814:	09 d0                	or     eax,edx
    3816:	75 b3                	jne    37cb <mm_initialize+0x8d>
    3818:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    381b:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    381e:	85 c0                	test   eax,eax
    3820:	75 a9                	jne    37cb <mm_initialize+0x8d>

		/* sort and merge remaining blocks */
		mm_sort_and_merge();
    3822:	e8 fc ff ff ff       	call   3823 <mm_initialize+0xe5>

		/* set fm_begin and page-align */
		for (size_t i = 0; i < fm_ofs; i++) {
    3827:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    382e:	e9 ea 00 00 00       	jmp    391d <mm_initialize+0x1df>
				if (i && fmm[i - 1].base < 0x100000)
    3833:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    3837:	74 2d                	je     3866 <mm_initialize+0x128>
    3839:	ba 00 40 02 00       	mov    edx,0x24000
    383e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3841:	6b c0 38             	imul   eax,eax,0x38
    3844:	83 e8 38             	sub    eax,0x38
    3847:	01 d0                	add    eax,edx
    3849:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    384c:	8b 00                	mov    eax,DWORD PTR [eax]
    384e:	bb ff ff 0f 00       	mov    ebx,0xfffff
    3853:	b9 00 00 00 00       	mov    ecx,0x0
    3858:	39 c3                	cmp    ebx,eax
    385a:	19 d1                	sbb    ecx,edx
    385c:	72 08                	jb     3866 <mm_initialize+0x128>
						fm_begin = i; /* works better this way, i.e. base=1 */
    385e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3861:	a3 14 00 00 00       	mov    ds:0x14,eax
				if (fmm[i].base % 4096) {
    3866:	ba 00 40 02 00       	mov    edx,0x24000
    386b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    386e:	6b c0 38             	imul   eax,eax,0x38
    3871:	01 d0                	add    eax,edx
    3873:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3876:	8b 00                	mov    eax,DWORD PTR [eax]
    3878:	25 ff 0f 00 00       	and    eax,0xfff
    387d:	ba 00 00 00 00       	mov    edx,0x0
    3882:	89 c1                	mov    ecx,eax
    3884:	89 c8                	mov    eax,ecx
    3886:	09 d0                	or     eax,edx
    3888:	0f 84 8b 00 00 00    	je     3919 <mm_initialize+0x1db>
						fmm[i].size -= fmm[i].base % 4096;
    388e:	ba 00 40 02 00       	mov    edx,0x24000
    3893:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3896:	6b c0 38             	imul   eax,eax,0x38
    3899:	01 d0                	add    eax,edx
    389b:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    389e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    38a1:	bb 00 40 02 00       	mov    ebx,0x24000
    38a6:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    38a9:	6b c9 38             	imul   ecx,ecx,0x38
    38ac:	01 d9                	add    ecx,ebx
    38ae:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
    38b1:	8b 09                	mov    ecx,DWORD PTR [ecx]
    38b3:	81 e1 ff 0f 00 00    	and    ecx,0xfff
    38b9:	bb 00 00 00 00       	mov    ebx,0x0
    38be:	bf 00 40 02 00       	mov    edi,0x24000
    38c3:	8b 75 e0             	mov    esi,DWORD PTR [ebp-0x20]
    38c6:	6b f6 38             	imul   esi,esi,0x38
    38c9:	01 fe                	add    esi,edi
    38cb:	29 c8                	sub    eax,ecx
    38cd:	19 da                	sbb    edx,ebx
    38cf:	89 46 08             	mov    DWORD PTR [esi+0x8],eax
    38d2:	89 56 0c             	mov    DWORD PTR [esi+0xc],edx
						fmm[i].base += fmm[i].base % 4096;
    38d5:	ba 00 40 02 00       	mov    edx,0x24000
    38da:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    38dd:	6b c0 38             	imul   eax,eax,0x38
    38e0:	01 d0                	add    eax,edx
    38e2:	8b 08                	mov    ecx,DWORD PTR [eax]
    38e4:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    38e7:	ba 00 40 02 00       	mov    edx,0x24000
    38ec:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    38ef:	6b c0 38             	imul   eax,eax,0x38
    38f2:	01 d0                	add    eax,edx
    38f4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    38f7:	8b 00                	mov    eax,DWORD PTR [eax]
    38f9:	25 ff 0f 00 00       	and    eax,0xfff
    38fe:	ba 00 00 00 00       	mov    edx,0x0
    3903:	bf 00 40 02 00       	mov    edi,0x24000
    3908:	8b 75 e0             	mov    esi,DWORD PTR [ebp-0x20]
    390b:	6b f6 38             	imul   esi,esi,0x38
    390e:	01 fe                	add    esi,edi
    3910:	01 c8                	add    eax,ecx
    3912:	11 da                	adc    edx,ebx
    3914:	89 06                	mov    DWORD PTR [esi],eax
    3916:	89 56 04             	mov    DWORD PTR [esi+0x4],edx
		for (size_t i = 0; i < fm_ofs; i++) {
    3919:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    391d:	a1 10 00 00 00       	mov    eax,ds:0x10
    3922:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    3925:	0f 82 08 ff ff ff    	jb     3833 <mm_initialize+0xf5>
				}
		}

		/* and print the info for now */
		for (size_t i = 0; i < fm_ofs; i++) {
    392b:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    3932:	eb 66                	jmp    399a <mm_initialize+0x25c>
				put32(i);
    3934:	83 ec 0c             	sub    esp,0xc
    3937:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    393a:	e8 fc ff ff ff       	call   393b <mm_initialize+0x1fd>
    393f:	83 c4 10             	add    esp,0x10
				put64(fmm[i].base);
    3942:	ba 00 40 02 00       	mov    edx,0x24000
    3947:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    394a:	6b c0 38             	imul   eax,eax,0x38
    394d:	01 d0                	add    eax,edx
    394f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3952:	8b 00                	mov    eax,DWORD PTR [eax]
    3954:	83 ec 08             	sub    esp,0x8
    3957:	52                   	push   edx
    3958:	50                   	push   eax
    3959:	e8 fc ff ff ff       	call   395a <mm_initialize+0x21c>
    395e:	83 c4 10             	add    esp,0x10
				putstr("-");
    3961:	83 ec 0c             	sub    esp,0xc
    3964:	68 7b 00 00 00       	push   0x7b
    3969:	e8 fc ff ff ff       	call   396a <mm_initialize+0x22c>
    396e:	83 c4 10             	add    esp,0x10
				put64(fmm[i].size);
    3971:	ba 00 40 02 00       	mov    edx,0x24000
    3976:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3979:	6b c0 38             	imul   eax,eax,0x38
    397c:	01 d0                	add    eax,edx
    397e:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3981:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3984:	83 ec 08             	sub    esp,0x8
    3987:	52                   	push   edx
    3988:	50                   	push   eax
    3989:	e8 fc ff ff ff       	call   398a <mm_initialize+0x24c>
    398e:	83 c4 10             	add    esp,0x10
				put_nl();
    3991:	e8 fc ff ff ff       	call   3992 <mm_initialize+0x254>
		for (size_t i = 0; i < fm_ofs; i++) {
    3996:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    399a:	a1 10 00 00 00       	mov    eax,ds:0x10
    399f:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
    39a2:	72 90                	jb     3934 <mm_initialize+0x1f6>
		}

		/* set the counts and create the rcp/pmu's,
		 *  -> this time we preallocate them all */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    39a4:	a1 14 00 00 00       	mov    eax,ds:0x14
    39a9:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    39ac:	e9 03 02 00 00       	jmp    3bb4 <mm_initialize+0x476>
				uint32_t ec, rec;
				fmm[i].reclaimable_pages = fmm[i].size / 4096; /* skip half-pages */
    39b1:	ba 00 40 02 00       	mov    edx,0x24000
    39b6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    39b9:	6b c0 38             	imul   eax,eax,0x38
    39bc:	01 d0                	add    eax,edx
    39be:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    39c1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    39c4:	bb 00 40 02 00       	mov    ebx,0x24000
    39c9:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    39cc:	6b c9 38             	imul   ecx,ecx,0x38
    39cf:	01 d9                	add    ecx,ebx
    39d1:	0f ac d0 0c          	shrd   eax,edx,0xc
    39d5:	c1 ea 0c             	shr    edx,0xc
    39d8:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    39db:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
				fmm[i].free_pages = 0;
    39de:	ba 00 40 02 00       	mov    edx,0x24000
    39e3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    39e6:	6b c0 38             	imul   eax,eax,0x38
    39e9:	01 d0                	add    eax,edx
    39eb:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
    39f2:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
				rec = fmm[i].reclaimable_pages % 16384;
    39f9:	ba 00 40 02 00       	mov    edx,0x24000
    39fe:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3a01:	6b c0 38             	imul   eax,eax,0x38
    3a04:	01 d0                	add    eax,edx
    3a06:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3a09:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3a0c:	25 ff 3f 00 00       	and    eax,0x3fff
    3a11:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				ec = (rec ? 1 : 0) + fmm[i].reclaimable_pages / 16384;
    3a14:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    3a18:	74 07                	je     3a21 <mm_initialize+0x2e3>
    3a1a:	b9 01 00 00 00       	mov    ecx,0x1
    3a1f:	eb 05                	jmp    3a26 <mm_initialize+0x2e8>
    3a21:	b9 00 00 00 00       	mov    ecx,0x0
    3a26:	ba 00 40 02 00       	mov    edx,0x24000
    3a2b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3a2e:	6b c0 38             	imul   eax,eax,0x38
    3a31:	01 d0                	add    eax,edx
    3a33:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3a36:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3a39:	0f ac d0 0e          	shrd   eax,edx,0xe
    3a3d:	c1 ea 0e             	shr    edx,0xe
    3a40:	01 c8                	add    eax,ecx
    3a42:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* the size will be reduced by 2*ec -> check rec */
				if (rec && (2 * ec > rec))
    3a45:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    3a49:	74 0e                	je     3a59 <mm_initialize+0x31b>
    3a4b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3a4e:	01 c0                	add    eax,eax
    3a50:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    3a53:	73 04                	jae    3a59 <mm_initialize+0x31b>
						ec--;
    3a55:	83 6d d4 01          	sub    DWORD PTR [ebp-0x2c],0x1
				fmm[i].reclaimable_pages -= 2 * ec;
    3a59:	ba 00 40 02 00       	mov    edx,0x24000
    3a5e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3a61:	6b c0 38             	imul   eax,eax,0x38
    3a64:	01 d0                	add    eax,edx
    3a66:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3a69:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3a6c:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3a6f:	01 c9                	add    ecx,ecx
    3a71:	89 ce                	mov    esi,ecx
    3a73:	bf 00 00 00 00       	mov    edi,0x0
    3a78:	bb 00 40 02 00       	mov    ebx,0x24000
    3a7d:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3a80:	6b c9 38             	imul   ecx,ecx,0x38
    3a83:	01 d9                	add    ecx,ebx
    3a85:	29 f0                	sub    eax,esi
    3a87:	19 fa                	sbb    edx,edi
    3a89:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    3a8c:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
				rec = fmm[i].reclaimable_pages % 16384;
    3a8f:	ba 00 40 02 00       	mov    edx,0x24000
    3a94:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3a97:	6b c0 38             	imul   eax,eax,0x38
    3a9a:	01 d0                	add    eax,edx
    3a9c:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    3a9f:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3aa2:	25 ff 3f 00 00       	and    eax,0x3fff
    3aa7:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				/* make the reservation */
				fmm[i].size -= 2 * ec * 4096;
    3aaa:	ba 00 40 02 00       	mov    edx,0x24000
    3aaf:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3ab2:	6b c0 38             	imul   eax,eax,0x38
    3ab5:	01 d0                	add    eax,edx
    3ab7:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3aba:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3abd:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3ac0:	c1 e1 0d             	shl    ecx,0xd
    3ac3:	89 ce                	mov    esi,ecx
    3ac5:	bf 00 00 00 00       	mov    edi,0x0
    3aca:	bb 00 40 02 00       	mov    ebx,0x24000
    3acf:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3ad2:	6b c9 38             	imul   ecx,ecx,0x38
    3ad5:	01 d9                	add    ecx,ebx
    3ad7:	29 f0                	sub    eax,esi
    3ad9:	19 fa                	sbb    edx,edi
    3adb:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    3ade:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
				fmm[i].pmu = fmm[i].base;
    3ae1:	ba 00 40 02 00       	mov    edx,0x24000
    3ae6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3ae9:	6b c0 38             	imul   eax,eax,0x38
    3aec:	01 d0                	add    eax,edx
    3aee:	b9 00 40 02 00       	mov    ecx,0x24000
    3af3:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3af6:	6b d2 38             	imul   edx,edx,0x38
    3af9:	01 d1                	add    ecx,edx
    3afb:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3afe:	8b 00                	mov    eax,DWORD PTR [eax]
    3b00:	89 41 28             	mov    DWORD PTR [ecx+0x28],eax
    3b03:	89 51 2c             	mov    DWORD PTR [ecx+0x2c],edx
				fmm[i].rcp = fmm[i].base + ec * 4096;
    3b06:	ba 00 40 02 00       	mov    edx,0x24000
    3b0b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3b0e:	6b c0 38             	imul   eax,eax,0x38
    3b11:	01 d0                	add    eax,edx
    3b13:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3b16:	8b 00                	mov    eax,DWORD PTR [eax]
    3b18:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3b1b:	c1 e1 0c             	shl    ecx,0xc
    3b1e:	89 ce                	mov    esi,ecx
    3b20:	bf 00 00 00 00       	mov    edi,0x0
    3b25:	bb 00 40 02 00       	mov    ebx,0x24000
    3b2a:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3b2d:	6b c9 38             	imul   ecx,ecx,0x38
    3b30:	01 d9                	add    ecx,ebx
    3b32:	01 f0                	add    eax,esi
    3b34:	11 fa                	adc    edx,edi
    3b36:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    3b39:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
				fmm[i].base += 2 * ec * 4096;
    3b3c:	ba 00 40 02 00       	mov    edx,0x24000
    3b41:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3b44:	6b c0 38             	imul   eax,eax,0x38
    3b47:	01 d0                	add    eax,edx
    3b49:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3b4c:	8b 00                	mov    eax,DWORD PTR [eax]
    3b4e:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    3b51:	c1 e1 0d             	shl    ecx,0xd
    3b54:	89 ce                	mov    esi,ecx
    3b56:	bf 00 00 00 00       	mov    edi,0x0
    3b5b:	bb 00 40 02 00       	mov    ebx,0x24000
    3b60:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    3b63:	6b c9 38             	imul   ecx,ecx,0x38
    3b66:	01 d9                	add    ecx,ebx
    3b68:	01 f0                	add    eax,esi
    3b6a:	11 fa                	adc    edx,edi
    3b6c:	89 01                	mov    DWORD PTR [ecx],eax
    3b6e:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				fmm[i].ec = ec;
    3b71:	ba 00 40 02 00       	mov    edx,0x24000
    3b76:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3b79:	6b c0 38             	imul   eax,eax,0x38
    3b7c:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3b7f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3b82:	ba 00 00 00 00       	mov    edx,0x0
    3b87:	89 41 20             	mov    DWORD PTR [ecx+0x20],eax
    3b8a:	89 51 24             	mov    DWORD PTR [ecx+0x24],edx
				/* and fill if below 4G (use delayed init) */
				mm_fm_init(fmm + i, ec, rec);
    3b8d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    3b90:	0f b7 c0             	movzx  eax,ax
    3b93:	b9 00 40 02 00       	mov    ecx,0x24000
    3b98:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3b9b:	6b d2 38             	imul   edx,edx,0x38
    3b9e:	01 ca                	add    edx,ecx
    3ba0:	83 ec 04             	sub    esp,0x4
    3ba3:	50                   	push   eax
    3ba4:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    3ba7:	52                   	push   edx
    3ba8:	e8 fc ff ff ff       	call   3ba9 <mm_initialize+0x46b>
    3bad:	83 c4 10             	add    esp,0x10
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    3bb0:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    3bb4:	a1 10 00 00 00       	mov    eax,ds:0x10
    3bb9:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    3bbc:	0f 82 ef fd ff ff    	jb     39b1 <mm_initialize+0x273>
		}

		/* create the page tables */
		mm_prepare_paging(mode);
    3bc2:	83 ec 0c             	sub    esp,0xc
    3bc5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3bc8:	e8 fc ff ff ff       	call   3bc9 <mm_initialize+0x48b>
    3bcd:	83 c4 10             	add    esp,0x10

//		putstr("done");
}
    3bd0:	90                   	nop
    3bd1:	8d 65 f4             	lea    esp,[ebp-0xc]
    3bd4:	5b                   	pop    ebx
    3bd5:	5e                   	pop    esi
    3bd6:	5f                   	pop    edi
    3bd7:	5d                   	pop    ebp
    3bd8:	c3                   	ret

00003bd9 <mm_enable_paging>:

void mm_enable_paging(int mode, uint64_t ep)
{
    3bd9:	55                   	push   ebp
    3bda:	89 e5                	mov    ebp,esp
    3bdc:	83 ec 28             	sub    esp,0x28
    3bdf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3be2:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    3be5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    3be8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		extern void ep36();
		extern void ep64();
		extern uint64_t ep_ptr;

		/* store the values for transfer */
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
    3beb:	c7 45 f4 00 40 02 00 	mov    DWORD PTR [ebp-0xc],0x24000
		ptr[-1] = fm_ofs;
    3bf2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3bf5:	8d 50 fc             	lea    edx,[eax-0x4]
    3bf8:	a1 10 00 00 00       	mov    eax,ds:0x10
    3bfd:	89 02                	mov    DWORD PTR [edx],eax
		ptr[-2] = fm_begin;
    3bff:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3c02:	8d 50 f8             	lea    edx,[eax-0x8]
    3c05:	a1 14 00 00 00       	mov    eax,ds:0x14
    3c0a:	89 02                	mov    DWORD PTR [edx],eax
		ptr[-3] = rm_count;
    3c0c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3c0f:	8d 50 f4             	lea    edx,[eax-0xc]
    3c12:	a1 18 00 00 00       	mov    eax,ds:0x18
    3c17:	89 02                	mov    DWORD PTR [edx],eax
		*(uint64_t*)(ptr - 5) = pm_zero;
    3c19:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3c1c:	8d 48 ec             	lea    ecx,[eax-0x14]
    3c1f:	a1 00 00 00 00       	mov    eax,ds:0x0
    3c24:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    3c2a:	89 01                	mov    DWORD PTR [ecx],eax
    3c2c:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		*(uint64_t*)(ptr - 7) = cr3_val;
    3c2f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3c32:	8d 48 e4             	lea    ecx,[eax-0x1c]
    3c35:	a1 00 00 00 00       	mov    eax,ds:0x0
    3c3a:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    3c40:	89 01                	mov    DWORD PTR [ecx],eax
    3c42:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		ptr[-8] = (uint32_t)mode;
    3c45:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3c48:	8d 50 e0             	lea    edx,[eax-0x20]
    3c4b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3c4e:	89 02                	mov    DWORD PTR [edx],eax

		ep_ptr = ep;
    3c50:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3c53:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    3c56:	a3 00 00 00 00       	mov    ds:0x0,eax
    3c5b:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx

		if (!mode)
    3c61:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    3c65:	75 07                	jne    3c6e <mm_enable_paging+0x95>
				ep32();
    3c67:	e8 fc ff ff ff       	call   3c68 <mm_enable_paging+0x8f>
    3c6c:	eb 13                	jmp    3c81 <mm_enable_paging+0xa8>
		else if (mode == 1)
    3c6e:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    3c72:	75 07                	jne    3c7b <mm_enable_paging+0xa2>
				ep36();
    3c74:	e8 fc ff ff ff       	call   3c75 <mm_enable_paging+0x9c>
    3c79:	eb 06                	jmp    3c81 <mm_enable_paging+0xa8>
		else
				ep64();
    3c7b:	e8 fc ff ff ff       	call   3c7c <mm_enable_paging+0xa3>

		while (1);
    3c80:	90                   	nop
    3c81:	90                   	nop
    3c82:	eb fd                	jmp    3c81 <mm_enable_paging+0xa8>

00003c84 <mm_map64>:
}

void mm_map64(uint64_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    3c84:	55                   	push   ebp
    3c85:	89 e5                	mov    ebp,esp
    3c87:	56                   	push   esi
    3c88:	53                   	push   ebx
    3c89:	81 ec 90 00 00 00    	sub    esp,0x90
    3c8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3c92:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
    3c98:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3c9b:	89 85 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],eax
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
    3ca1:	a1 00 00 00 00       	mov    eax,ds:0x0
    3ca6:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		struct pm_pg64_ptrs* pp = pm_mapping;
    3ca9:	a1 00 00 00 00       	mov    eax,ds:0x0
    3cae:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		uint32_t pml4e, pdpte, pde, pte;
		struct page_range pr_copy = *pr;
    3cb1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    3cb4:	8b 10                	mov    edx,DWORD PTR [eax]
    3cb6:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
    3cb9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3cbc:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
    3cbf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3cc2:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax

		/* physical pointers */
		struct pte64 *p = pp->p;
    3cc5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3cc8:	8b 00                	mov    eax,DWORD PTR [eax]
    3cca:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		struct pte64* pl = 0;
    3ccd:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		struct pte64* pd = 0;
    3cd4:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		struct pte64* pt = 0;
    3cdb:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = vaddr & 0x0000ffffffffffff;
    3ce2:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [ebp-0x90]
    3ce8:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    3cee:	81 e2 ff ff 00 00    	and    edx,0xffff
    3cf4:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    3cf7:	89 55 b4             	mov    DWORD PTR [ebp-0x4c],edx
		pml4e = low48 >> 39; /* 512G per PML4E */
    3cfa:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3cfd:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3d00:	89 d0                	mov    eax,edx
    3d02:	31 d2                	xor    edx,edx
    3d04:	c1 e8 07             	shr    eax,0x7
    3d07:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */
    3d0a:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3d0d:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3d10:	0f ac d0 1e          	shrd   eax,edx,0x1e
    3d14:	c1 ea 1e             	shr    edx,0x1e
    3d17:	25 ff 01 00 00       	and    eax,0x1ff
    3d1c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */
    3d1f:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3d22:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3d25:	0f ac d0 15          	shrd   eax,edx,0x15
    3d29:	c1 ea 15             	shr    edx,0x15
    3d2c:	25 ff 01 00 00       	and    eax,0x1ff
    3d31:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */
    3d34:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3d37:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    3d3a:	0f ac d0 0c          	shrd   eax,edx,0xc
    3d3e:	c1 ea 0c             	shr    edx,0xc
    3d41:	25 ff 01 00 00       	and    eax,0x1ff
    3d46:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* create one if not there */
new_pdpt:
		if (!vp->pml4e[pml4e]) {
    3d49:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3d4c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3d4f:	83 c2 02             	add    edx,0x2
    3d52:	8d 14 d0             	lea    edx,[eax+edx*8]
    3d55:	8b 02                	mov    eax,DWORD PTR [edx]
    3d57:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    3d5a:	89 c1                	mov    ecx,eax
    3d5c:	89 c8                	mov    eax,ecx
    3d5e:	09 d0                	or     eax,edx
    3d60:	0f 85 3d 02 00 00    	jne    3fa3 <mm_map64+0x31f>
				struct page_range pr2;
				/* allocate the PDPT */
				mm_alloc_pm(1, &pr2, 1);
    3d66:	83 ec 04             	sub    esp,0x4
    3d69:	6a 01                	push   0x1
    3d6b:	8d 45 90             	lea    eax,[ebp-0x70]
    3d6e:	50                   	push   eax
    3d6f:	6a 01                	push   0x1
    3d71:	e8 fc ff ff ff       	call   3d72 <mm_map64+0xee>
    3d76:	83 c4 10             	add    esp,0x10
				vp->pml4e[pml4e] = vp->cur;
    3d79:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3d7c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3d7f:	8b 00                	mov    eax,DWORD PTR [eax]
    3d81:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    3d84:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    3d87:	83 c3 02             	add    ebx,0x2
    3d8a:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    3d8d:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    3d91:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3d94:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3d97:	8b 00                	mov    eax,DWORD PTR [eax]
    3d99:	05 00 f0 ff ff       	add    eax,0xfffff000
    3d9e:	83 d2 ff             	adc    edx,0xffffffff
    3da1:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    3da4:	89 01                	mov    DWORD PTR [ecx],eax
    3da6:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				pl = (void*)pr2.base;
    3da9:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    3dac:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    3daf:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				/* make it known in VM */
				mm_map64(vp->pml4e[pml4e], &pr2, 1, 1, 1, 1, 0);
    3db2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3db5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3db8:	83 c2 02             	add    edx,0x2
    3dbb:	8d 14 d0             	lea    edx,[eax+edx*8]
    3dbe:	8b 02                	mov    eax,DWORD PTR [edx]
    3dc0:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    3dc3:	6a 00                	push   0x0
    3dc5:	6a 01                	push   0x1
    3dc7:	6a 01                	push   0x1
    3dc9:	6a 01                	push   0x1
    3dcb:	6a 01                	push   0x1
    3dcd:	8d 4d 90             	lea    ecx,[ebp-0x70]
    3dd0:	51                   	push   ecx
    3dd1:	52                   	push   edx
    3dd2:	50                   	push   eax
    3dd3:	e8 fc ff ff ff       	call   3dd4 <mm_map64+0x150>
    3dd8:	83 c4 20             	add    esp,0x20
				/* do the same for the map (2 pages) */
				if (mm_alloc_pm(2, &pr2, 1) != 2) {
    3ddb:	83 ec 04             	sub    esp,0x4
    3dde:	6a 01                	push   0x1
    3de0:	8d 45 90             	lea    eax,[ebp-0x70]
    3de3:	50                   	push   eax
    3de4:	6a 02                	push   0x2
    3de6:	e8 fc ff ff ff       	call   3de7 <mm_map64+0x163>
    3deb:	83 c4 10             	add    esp,0x10
    3dee:	83 f8 02             	cmp    eax,0x2
    3df1:	74 13                	je     3e06 <mm_map64+0x182>
						puts("cont alloc 2 failed.");
    3df3:	83 ec 0c             	sub    esp,0xc
    3df6:	68 7d 00 00 00       	push   0x7d
    3dfb:	e8 fc ff ff ff       	call   3dfc <mm_map64+0x178>
    3e00:	83 c4 10             	add    esp,0x10
						while (1);
    3e03:	90                   	nop
    3e04:	eb fd                	jmp    3e03 <mm_map64+0x17f>
				}
				vp->pdpte[pml4e] = vp->cur - 4096;
    3e06:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e09:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3e0c:	8b 00                	mov    eax,DWORD PTR [eax]
    3e0e:	05 00 f0 ff ff       	add    eax,0xfffff000
    3e13:	83 d2 ff             	adc    edx,0xffffffff
    3e16:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    3e19:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    3e1c:	81 c3 02 02 00 00    	add    ebx,0x202
    3e22:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    3e25:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 8192;
    3e29:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e2c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3e2f:	8b 00                	mov    eax,DWORD PTR [eax]
    3e31:	05 00 e0 ff ff       	add    eax,0xffffe000
    3e36:	83 d2 ff             	adc    edx,0xffffffff
    3e39:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    3e3c:	89 01                	mov    DWORD PTR [ecx],eax
    3e3e:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				m = (void*)pr2.base;
    3e41:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    3e44:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
    3e47:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				/* store the physical pointers */
				pp->extra_pdpts[pp->ec_pdpt].idx = pml4e;
    3e4a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3e4d:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    3e51:	0f b7 d0             	movzx  edx,ax
    3e54:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    3e57:	89 d0                	mov    eax,edx
    3e59:	01 c0                	add    eax,eax
    3e5b:	01 d0                	add    eax,edx
    3e5d:	c1 e0 02             	shl    eax,0x2
    3e60:	01 c8                	add    eax,ecx
    3e62:	8d 50 3c             	lea    edx,[eax+0x3c]
    3e65:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3e68:	89 02                	mov    DWORD PTR [edx],eax
				pp->extra_pdpts[pp->ec_pdpt].pdpt = pl;
    3e6a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3e6d:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    3e71:	0f b7 d0             	movzx  edx,ax
    3e74:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    3e77:	89 d0                	mov    eax,edx
    3e79:	01 c0                	add    eax,eax
    3e7b:	01 d0                	add    eax,edx
    3e7d:	c1 e0 02             	shl    eax,0x2
    3e80:	01 c8                	add    eax,ecx
    3e82:	8d 50 34             	lea    edx,[eax+0x34]
    3e85:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3e88:	89 02                	mov    DWORD PTR [edx],eax
				pp->extra_pdpts[pp->ec_pdpt++].map = m;
    3e8a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3e8d:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    3e91:	8d 48 01             	lea    ecx,[eax+0x1]
    3e94:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    3e97:	66 89 4a 2c          	mov    WORD PTR [edx+0x2c],cx
    3e9b:	0f b7 d0             	movzx  edx,ax
    3e9e:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    3ea1:	89 d0                	mov    eax,edx
    3ea3:	01 c0                	add    eax,eax
    3ea5:	01 d0                	add    eax,edx
    3ea7:	c1 e0 02             	shl    eax,0x2
    3eaa:	01 c8                	add    eax,ecx
    3eac:	8d 50 38             	lea    edx,[eax+0x38]
    3eaf:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3eb2:	89 02                	mov    DWORD PTR [edx],eax
				if (pp->ec_pdpt > 8)
    3eb4:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3eb7:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    3ebb:	66 83 f8 08          	cmp    ax,0x8
    3ebf:	76 03                	jbe    3ec4 <mm_map64+0x240>
					while (1); /* exhausted too */
    3ec1:	90                   	nop
    3ec2:	eb fd                	jmp    3ec1 <mm_map64+0x23d>

				/* and set the reference in the PML4 */
				p[pml4e].addr = (uint64_t)pl / 4096;
    3ec4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3ec7:	99                   	cdq
    3ec8:	0f ac d0 0c          	shrd   eax,edx,0xc
    3ecc:	c1 ea 0c             	shr    edx,0xc
    3ecf:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    3ed2:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    3ed9:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3edc:	01 d9                	add    ecx,ebx
    3ede:	81 e2 ff 00 00 00    	and    edx,0xff
    3ee4:	89 c3                	mov    ebx,eax
    3ee6:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    3eec:	89 de                	mov    esi,ebx
    3eee:	c1 e6 0c             	shl    esi,0xc
    3ef1:	8b 19                	mov    ebx,DWORD PTR [ecx]
    3ef3:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    3ef9:	09 f3                	or     ebx,esi
    3efb:	89 19                	mov    DWORD PTR [ecx],ebx
    3efd:	89 c3                	mov    ebx,eax
    3eff:	c1 eb 14             	shr    ebx,0x14
    3f02:	89 de                	mov    esi,ebx
    3f04:	66 81 e6 ff 0f       	and    si,0xfff
    3f09:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    3f0d:	66 81 e3 00 f0       	and    bx,0xf000
    3f12:	09 f3                	or     ebx,esi
    3f14:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    3f18:	0f b6 c2             	movzx  eax,dl
    3f1b:	c1 e0 0c             	shl    eax,0xc
    3f1e:	89 c2                	mov    edx,eax
    3f20:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    3f23:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    3f28:	09 d0                	or     eax,edx
    3f2a:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				p[pml4e].u = 1;
    3f2d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3f30:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3f37:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f3a:	01 d0                	add    eax,edx
    3f3c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3f3f:	83 ca 04             	or     edx,0x4
    3f42:	88 10                	mov    BYTE PTR [eax],dl
				p[pml4e].w = 1;
    3f44:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3f47:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3f4e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f51:	01 d0                	add    eax,edx
    3f53:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3f56:	83 ca 02             	or     edx,0x2
    3f59:	88 10                	mov    BYTE PTR [eax],dl
				p[pml4e].p = 1;
    3f5b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3f5e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    3f65:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f68:	01 d0                	add    eax,edx
    3f6a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    3f6d:	83 ca 01             	or     edx,0x1
    3f70:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map64(vp->pdpte[pml4e], &pr2, 1, 1, 1, 1, 0);
    3f72:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3f75:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3f78:	81 c2 02 02 00 00    	add    edx,0x202
    3f7e:	8d 14 d0             	lea    edx,[eax+edx*8]
    3f81:	8b 02                	mov    eax,DWORD PTR [edx]
    3f83:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    3f86:	6a 00                	push   0x0
    3f88:	6a 01                	push   0x1
    3f8a:	6a 01                	push   0x1
    3f8c:	6a 01                	push   0x1
    3f8e:	6a 01                	push   0x1
    3f90:	8d 4d 90             	lea    ecx,[ebp-0x70]
    3f93:	51                   	push   ecx
    3f94:	52                   	push   edx
    3f95:	50                   	push   eax
    3f96:	e8 fc ff ff ff       	call   3f97 <mm_map64+0x313>
    3f9b:	83 c4 20             	add    esp,0x20
    3f9e:	e9 be 00 00 00       	jmp    4061 <mm_map64+0x3dd>

		} else { /* find PP in pp */
				for (size_t i = 0; i < pp->ec_pdpt; i++)
    3fa3:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    3faa:	eb 53                	jmp    3fff <mm_map64+0x37b>
						if (pp->extra_pdpts[i].idx == pml4e) {
    3fac:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    3faf:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    3fb2:	89 d0                	mov    eax,edx
    3fb4:	01 c0                	add    eax,eax
    3fb6:	01 d0                	add    eax,edx
    3fb8:	c1 e0 02             	shl    eax,0x2
    3fbb:	01 c8                	add    eax,ecx
    3fbd:	83 c0 3c             	add    eax,0x3c
    3fc0:	8b 00                	mov    eax,DWORD PTR [eax]
    3fc2:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    3fc5:	75 34                	jne    3ffb <mm_map64+0x377>
								pl = pp->extra_pdpts[i].pdpt;
    3fc7:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    3fca:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    3fcd:	89 d0                	mov    eax,edx
    3fcf:	01 c0                	add    eax,eax
    3fd1:	01 d0                	add    eax,edx
    3fd3:	c1 e0 02             	shl    eax,0x2
    3fd6:	01 c8                	add    eax,ecx
    3fd8:	83 c0 34             	add    eax,0x34
    3fdb:	8b 00                	mov    eax,DWORD PTR [eax]
    3fdd:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								m = pp->extra_pdpts[i].map;
    3fe0:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    3fe3:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    3fe6:	89 d0                	mov    eax,edx
    3fe8:	01 c0                	add    eax,eax
    3fea:	01 d0                	add    eax,edx
    3fec:	c1 e0 02             	shl    eax,0x2
    3fef:	01 c8                	add    eax,ecx
    3ff1:	83 c0 38             	add    eax,0x38
    3ff4:	8b 00                	mov    eax,DWORD PTR [eax]
    3ff6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								break;
    3ff9:	eb 13                	jmp    400e <mm_map64+0x38a>
				for (size_t i = 0; i < pp->ec_pdpt; i++)
    3ffb:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
    3fff:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4002:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    4006:	0f b7 c0             	movzx  eax,ax
    4009:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    400c:	72 9e                	jb     3fac <mm_map64+0x328>
						}
				if (!pl) {
    400e:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    4012:	75 37                	jne    404b <mm_map64+0x3c7>
						if (pml4e == 0) {
    4014:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4018:	75 14                	jne    402e <mm_map64+0x3aa>
								pl = pp->p1;
    401a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    401d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    4020:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								m = pp->m1;
    4023:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4026:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    4029:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    402c:	eb 33                	jmp    4061 <mm_map64+0x3dd>
						} else if (pml4e == 511) {
    402e:	81 7d f4 ff 01 00 00 	cmp    DWORD PTR [ebp-0xc],0x1ff
    4035:	75 17                	jne    404e <mm_map64+0x3ca>
								pl = pp->p2;
    4037:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    403a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    403d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								m = pp->m2;
    4040:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4043:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    4046:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    4049:	eb 16                	jmp    4061 <mm_map64+0x3dd>
						}
				}
		}

		/* now go on to the page directory */
new_pd:
    404b:	90                   	nop
    404c:	eb 13                	jmp    4061 <mm_map64+0x3dd>
								puts("pre-paging exhausted.");
    404e:	83 ec 0c             	sub    esp,0xc
    4051:	68 92 00 00 00       	push   0x92
    4056:	e8 fc ff ff ff       	call   4057 <mm_map64+0x3d3>
    405b:	83 c4 10             	add    esp,0x10
								while (1);
    405e:	90                   	nop
    405f:	eb fd                	jmp    405e <mm_map64+0x3da>
		if (!m->pds[pdpte]) {
    4061:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4064:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    4067:	8d 14 d0             	lea    edx,[eax+edx*8]
    406a:	8b 02                	mov    eax,DWORD PTR [edx]
    406c:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    406f:	89 c1                	mov    ecx,eax
    4071:	89 c8                	mov    eax,ecx
    4073:	09 d0                	or     eax,edx
    4075:	0f 85 fb 01 00 00    	jne    4276 <mm_map64+0x5f2>
				struct page_range pr2;
				/* allocate a page directory */
				mm_alloc_pm(1, &pr2, 1);
    407b:	83 ec 04             	sub    esp,0x4
    407e:	6a 01                	push   0x1
    4080:	8d 45 84             	lea    eax,[ebp-0x7c]
    4083:	50                   	push   eax
    4084:	6a 01                	push   0x1
    4086:	e8 fc ff ff ff       	call   4087 <mm_map64+0x403>
    408b:	83 c4 10             	add    esp,0x10
				m->pds[pdpte] = vp->cur;
    408e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4091:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4094:	8b 00                	mov    eax,DWORD PTR [eax]
    4096:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    4099:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
    409c:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    409f:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    40a3:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    40a6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40a9:	8b 00                	mov    eax,DWORD PTR [eax]
    40ab:	05 00 f0 ff ff       	add    eax,0xfffff000
    40b0:	83 d2 ff             	adc    edx,0xffffffff
    40b3:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    40b6:	89 01                	mov    DWORD PTR [ecx],eax
    40b8:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				pd = (void*)pr2.base;
    40bb:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    40be:	8b 55 88             	mov    edx,DWORD PTR [ebp-0x78]
    40c1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				/* do the same for the map */
				mm_alloc_pm(1, &pr2, 1);
    40c4:	83 ec 04             	sub    esp,0x4
    40c7:	6a 01                	push   0x1
    40c9:	8d 45 84             	lea    eax,[ebp-0x7c]
    40cc:	50                   	push   eax
    40cd:	6a 01                	push   0x1
    40cf:	e8 fc ff ff ff       	call   40d0 <mm_map64+0x44c>
    40d4:	83 c4 10             	add    esp,0x10
				m->pdes[pdpte] = vp->cur;
    40d7:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    40da:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40dd:	8b 00                	mov    eax,DWORD PTR [eax]
    40df:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    40e2:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
    40e5:	81 c3 00 02 00 00    	add    ebx,0x200
    40eb:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    40ee:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    40f2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    40f5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40f8:	8b 00                	mov    eax,DWORD PTR [eax]
    40fa:	05 00 f0 ff ff       	add    eax,0xfffff000
    40ff:	83 d2 ff             	adc    edx,0xffffffff
    4102:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    4105:	89 01                	mov    DWORD PTR [ecx],eax
    4107:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				n = (void*)pr2.base;
    410a:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    410d:	8b 55 88             	mov    edx,DWORD PTR [ebp-0x78]
    4110:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* store the physical pointers (avoid 0*x) */
				pp->extra_pds[pp->ec_pd].idx = (pml4e << 9) | pdpte;
    4113:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4116:	c1 e0 09             	shl    eax,0x9
    4119:	89 c1                	mov    ecx,eax
    411b:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    411e:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    4122:	0f b7 d0             	movzx  edx,ax
    4125:	0b 4d f0             	or     ecx,DWORD PTR [ebp-0x10]
    4128:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    412b:	89 d0                	mov    eax,edx
    412d:	01 c0                	add    eax,eax
    412f:	01 d0                	add    eax,edx
    4131:	c1 e0 02             	shl    eax,0x2
    4134:	01 d8                	add    eax,ebx
    4136:	05 9c 00 00 00       	add    eax,0x9c
    413b:	89 08                	mov    DWORD PTR [eax],ecx
				pp->extra_pds[pp->ec_pd].pd = pd;
    413d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4140:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    4144:	0f b7 d0             	movzx  edx,ax
    4147:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    414a:	89 d0                	mov    eax,edx
    414c:	01 c0                	add    eax,eax
    414e:	01 d0                	add    eax,edx
    4150:	c1 e0 02             	shl    eax,0x2
    4153:	01 c8                	add    eax,ecx
    4155:	8d 90 94 00 00 00    	lea    edx,[eax+0x94]
    415b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    415e:	89 02                	mov    DWORD PTR [edx],eax
				pp->extra_pds[pp->ec_pd++].map = n;
    4160:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4163:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    4167:	8d 48 01             	lea    ecx,[eax+0x1]
    416a:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    416d:	66 89 4a 2e          	mov    WORD PTR [edx+0x2e],cx
    4171:	0f b7 d0             	movzx  edx,ax
    4174:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    4177:	89 d0                	mov    eax,edx
    4179:	01 c0                	add    eax,eax
    417b:	01 d0                	add    eax,edx
    417d:	c1 e0 02             	shl    eax,0x2
    4180:	01 c8                	add    eax,ecx
    4182:	8d 90 98 00 00 00    	lea    edx,[eax+0x98]
    4188:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    418b:	89 02                	mov    DWORD PTR [edx],eax
				if (pp->ec_pd > 24)
    418d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4190:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    4194:	66 83 f8 18          	cmp    ax,0x18
    4198:	76 03                	jbe    419d <mm_map64+0x519>
					while (1); /* exhausted too */
    419a:	90                   	nop
    419b:	eb fd                	jmp    419a <mm_map64+0x516>

				/* and set the reference in the PDPT */
				pl[pdpte].addr = (uint64_t)pd / 4096;
    419d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    41a0:	99                   	cdq
    41a1:	0f ac d0 0c          	shrd   eax,edx,0xc
    41a5:	c1 ea 0c             	shr    edx,0xc
    41a8:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    41ab:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    41b2:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    41b5:	01 d9                	add    ecx,ebx
    41b7:	81 e2 ff 00 00 00    	and    edx,0xff
    41bd:	89 c3                	mov    ebx,eax
    41bf:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    41c5:	89 de                	mov    esi,ebx
    41c7:	c1 e6 0c             	shl    esi,0xc
    41ca:	8b 19                	mov    ebx,DWORD PTR [ecx]
    41cc:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    41d2:	09 f3                	or     ebx,esi
    41d4:	89 19                	mov    DWORD PTR [ecx],ebx
    41d6:	89 c3                	mov    ebx,eax
    41d8:	c1 eb 14             	shr    ebx,0x14
    41db:	89 de                	mov    esi,ebx
    41dd:	66 81 e6 ff 0f       	and    si,0xfff
    41e2:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    41e6:	66 81 e3 00 f0       	and    bx,0xf000
    41eb:	09 f3                	or     ebx,esi
    41ed:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    41f1:	0f b6 c2             	movzx  eax,dl
    41f4:	c1 e0 0c             	shl    eax,0xc
    41f7:	89 c2                	mov    edx,eax
    41f9:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    41fc:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4201:	09 d0                	or     eax,edx
    4203:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pl[pdpte].u = 1;
    4206:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4209:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4210:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4213:	01 d0                	add    eax,edx
    4215:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4218:	83 ca 04             	or     edx,0x4
    421b:	88 10                	mov    BYTE PTR [eax],dl
				pl[pdpte].w = 1;
    421d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4220:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4227:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    422a:	01 d0                	add    eax,edx
    422c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    422f:	83 ca 02             	or     edx,0x2
    4232:	88 10                	mov    BYTE PTR [eax],dl
				pl[pdpte].p = 1;
    4234:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4237:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    423e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4241:	01 d0                	add    eax,edx
    4243:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4246:	83 ca 01             	or     edx,0x1
    4249:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map64(m->pds[pdpte], &pr2, 1, 1, 1, 1, 0);
    424b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    424e:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    4251:	8d 14 d0             	lea    edx,[eax+edx*8]
    4254:	8b 02                	mov    eax,DWORD PTR [edx]
    4256:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4259:	6a 00                	push   0x0
    425b:	6a 01                	push   0x1
    425d:	6a 01                	push   0x1
    425f:	6a 01                	push   0x1
    4261:	6a 01                	push   0x1
    4263:	8d 4d 84             	lea    ecx,[ebp-0x7c]
    4266:	51                   	push   ecx
    4267:	52                   	push   edx
    4268:	50                   	push   eax
    4269:	e8 fc ff ff ff       	call   426a <mm_map64+0x5e6>
    426e:	83 c4 20             	add    esp,0x20
    4271:	e9 df 00 00 00       	jmp    4355 <mm_map64+0x6d1>
		} else {
				uint32_t id = (pml4e << 9) | pdpte;
    4276:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4279:	c1 e0 09             	shl    eax,0x9
    427c:	0b 45 f0             	or     eax,DWORD PTR [ebp-0x10]
    427f:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
				/* find PD in pp */
				for (size_t i = 0; i < pp->ec_pd; i++)
    4282:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    4289:	eb 59                	jmp    42e4 <mm_map64+0x660>
						if (pp->extra_pds[i].idx == id) {
    428b:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    428e:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    4291:	89 d0                	mov    eax,edx
    4293:	01 c0                	add    eax,eax
    4295:	01 d0                	add    eax,edx
    4297:	c1 e0 02             	shl    eax,0x2
    429a:	01 c8                	add    eax,ecx
    429c:	05 9c 00 00 00       	add    eax,0x9c
    42a1:	8b 00                	mov    eax,DWORD PTR [eax]
    42a3:	39 45 ac             	cmp    DWORD PTR [ebp-0x54],eax
    42a6:	75 38                	jne    42e0 <mm_map64+0x65c>
								pd = pp->extra_pds[i].pd;
    42a8:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    42ab:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    42ae:	89 d0                	mov    eax,edx
    42b0:	01 c0                	add    eax,eax
    42b2:	01 d0                	add    eax,edx
    42b4:	c1 e0 02             	shl    eax,0x2
    42b7:	01 c8                	add    eax,ecx
    42b9:	05 94 00 00 00       	add    eax,0x94
    42be:	8b 00                	mov    eax,DWORD PTR [eax]
    42c0:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								n = pp->extra_pds[i].map;
    42c3:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    42c6:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    42c9:	89 d0                	mov    eax,edx
    42cb:	01 c0                	add    eax,eax
    42cd:	01 d0                	add    eax,edx
    42cf:	c1 e0 02             	shl    eax,0x2
    42d2:	01 c8                	add    eax,ecx
    42d4:	05 98 00 00 00       	add    eax,0x98
    42d9:	8b 00                	mov    eax,DWORD PTR [eax]
    42db:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								break;
    42de:	eb 13                	jmp    42f3 <mm_map64+0x66f>
				for (size_t i = 0; i < pp->ec_pd; i++)
    42e0:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
    42e4:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    42e7:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    42eb:	0f b7 c0             	movzx  eax,ax
    42ee:	39 45 cc             	cmp    DWORD PTR [ebp-0x34],eax
    42f1:	72 98                	jb     428b <mm_map64+0x607>
						}
				if (!pd) { /* no index -> only default ones left */
    42f3:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    42f7:	75 46                	jne    433f <mm_map64+0x6bb>
						if (pml4e == 0 && pdpte == 0) {
    42f9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    42fd:	75 1a                	jne    4319 <mm_map64+0x695>
    42ff:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    4303:	75 14                	jne    4319 <mm_map64+0x695>
								pd = pp->pl1;
    4305:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4308:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    430b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								n = pp->n1;
    430e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4311:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    4314:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    4317:	eb 3c                	jmp    4355 <mm_map64+0x6d1>
						} else if (pml4e == 511 && pdpte == 511) {
    4319:	81 7d f4 ff 01 00 00 	cmp    DWORD PTR [ebp-0xc],0x1ff
    4320:	75 20                	jne    4342 <mm_map64+0x6be>
    4322:	81 7d f0 ff 01 00 00 	cmp    DWORD PTR [ebp-0x10],0x1ff
    4329:	75 17                	jne    4342 <mm_map64+0x6be>
								pd = pp->pl2;
    432b:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    432e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    4331:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								n = pp->n2;
    4334:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4337:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    433a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    433d:	eb 16                	jmp    4355 <mm_map64+0x6d1>
						}
				}
		}

		/* now select the page table */
new_pt:
    433f:	90                   	nop
    4340:	eb 13                	jmp    4355 <mm_map64+0x6d1>
								puts("pre-paging exhausted.");
    4342:	83 ec 0c             	sub    esp,0xc
    4345:	68 92 00 00 00       	push   0x92
    434a:	e8 fc ff ff ff       	call   434b <mm_map64+0x6c7>
    434f:	83 c4 10             	add    esp,0x10
								while (1);
    4352:	90                   	nop
    4353:	eb fd                	jmp    4352 <mm_map64+0x6ce>
		if (!n->pts[pde]) {
    4355:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    4358:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    435b:	8d 14 d0             	lea    edx,[eax+edx*8]
    435e:	8b 02                	mov    eax,DWORD PTR [edx]
    4360:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    4363:	89 c1                	mov    ecx,eax
    4365:	89 c8                	mov    eax,ecx
    4367:	09 d0                	or     eax,edx
    4369:	0f 85 86 01 00 00    	jne    44f5 <mm_map64+0x871>
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
    436f:	83 ec 04             	sub    esp,0x4
    4372:	6a 01                	push   0x1
    4374:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
    437a:	50                   	push   eax
    437b:	6a 01                	push   0x1
    437d:	e8 fc ff ff ff       	call   437e <mm_map64+0x6fa>
    4382:	83 c4 10             	add    esp,0x10
				n->pts[pde] = vp->cur;
    4385:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4388:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    438b:	8b 00                	mov    eax,DWORD PTR [eax]
    438d:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    4390:	8b 5d ec             	mov    ebx,DWORD PTR [ebp-0x14]
    4393:	89 04 d9             	mov    DWORD PTR [ecx+ebx*8],eax
    4396:	89 54 d9 04          	mov    DWORD PTR [ecx+ebx*8+0x4],edx
				vp->cur -= 4096;
    439a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    439d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    43a0:	8b 00                	mov    eax,DWORD PTR [eax]
    43a2:	05 00 f0 ff ff       	add    eax,0xfffff000
    43a7:	83 d2 ff             	adc    edx,0xffffffff
    43aa:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    43ad:	89 01                	mov    DWORD PTR [ecx],eax
    43af:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				pt = (void*)pr2.base;
    43b2:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    43b8:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [ebp-0x84]
    43be:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
    43c1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43c4:	c1 e0 12             	shl    eax,0x12
    43c7:	89 c2                	mov    edx,eax
					   	| (pdpte << 9) | pde;
    43c9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    43cc:	c1 e0 09             	shl    eax,0x9
    43cf:	09 c2                	or     edx,eax
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
    43d1:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    43d4:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    43d8:	0f b7 c8             	movzx  ecx,ax
					   	| (pdpte << 9) | pde;
    43db:	0b 55 ec             	or     edx,DWORD PTR [ebp-0x14]
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
    43de:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    43e1:	83 c1 36             	add    ecx,0x36
    43e4:	89 54 c8 08          	mov    DWORD PTR [eax+ecx*8+0x8],edx
				pp->extra_pts[pp->ec_pt++].pt = pt;
    43e8:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    43eb:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    43ef:	8d 48 01             	lea    ecx,[eax+0x1]
    43f2:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    43f5:	66 89 4a 30          	mov    WORD PTR [edx+0x30],cx
    43f9:	0f b7 d0             	movzx  edx,ax
    43fc:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    43ff:	8d 4a 36             	lea    ecx,[edx+0x36]
    4402:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    4405:	89 54 c8 04          	mov    DWORD PTR [eax+ecx*8+0x4],edx
				if (pp->ec_pt > 64)
    4409:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    440c:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    4410:	66 83 f8 40          	cmp    ax,0x40
    4414:	76 03                	jbe    4419 <mm_map64+0x795>
					while (1); /* exhausted too */
    4416:	90                   	nop
    4417:	eb fd                	jmp    4416 <mm_map64+0x792>

				/* and set the reference in the PD */
				pd[pde].addr = (uint64_t)pt / 4096;
    4419:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    441c:	99                   	cdq
    441d:	0f ac d0 0c          	shrd   eax,edx,0xc
    4421:	c1 ea 0c             	shr    edx,0xc
    4424:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    4427:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    442e:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    4431:	01 d9                	add    ecx,ebx
    4433:	81 e2 ff 00 00 00    	and    edx,0xff
    4439:	89 c3                	mov    ebx,eax
    443b:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    4441:	89 de                	mov    esi,ebx
    4443:	c1 e6 0c             	shl    esi,0xc
    4446:	8b 19                	mov    ebx,DWORD PTR [ecx]
    4448:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    444e:	09 f3                	or     ebx,esi
    4450:	89 19                	mov    DWORD PTR [ecx],ebx
    4452:	89 c3                	mov    ebx,eax
    4454:	c1 eb 14             	shr    ebx,0x14
    4457:	89 de                	mov    esi,ebx
    4459:	66 81 e6 ff 0f       	and    si,0xfff
    445e:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    4462:	66 81 e3 00 f0       	and    bx,0xf000
    4467:	09 f3                	or     ebx,esi
    4469:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    446d:	0f b6 c2             	movzx  eax,dl
    4470:	c1 e0 0c             	shl    eax,0xc
    4473:	89 c2                	mov    edx,eax
    4475:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4478:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    447d:	09 d0                	or     eax,edx
    447f:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pd[pde].u = 1;
    4482:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4485:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    448c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    448f:	01 d0                	add    eax,edx
    4491:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4494:	83 ca 04             	or     edx,0x4
    4497:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
    4499:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    449c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    44a3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    44a6:	01 d0                	add    eax,edx
    44a8:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    44ab:	83 ca 02             	or     edx,0x2
    44ae:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
    44b0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    44b3:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    44ba:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    44bd:	01 d0                	add    eax,edx
    44bf:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    44c2:	83 ca 01             	or     edx,0x1
    44c5:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map64(n->pts[pde], &pr2, 1, 1, 1, 1, 0);
    44c7:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    44ca:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    44cd:	8d 14 d0             	lea    edx,[eax+edx*8]
    44d0:	8b 02                	mov    eax,DWORD PTR [edx]
    44d2:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    44d5:	6a 00                	push   0x0
    44d7:	6a 01                	push   0x1
    44d9:	6a 01                	push   0x1
    44db:	6a 01                	push   0x1
    44dd:	6a 01                	push   0x1
    44df:	8d 8d 78 ff ff ff    	lea    ecx,[ebp-0x88]
    44e5:	51                   	push   ecx
    44e6:	52                   	push   edx
    44e7:	50                   	push   eax
    44e8:	e8 fc ff ff ff       	call   44e9 <mm_map64+0x865>
    44ed:	83 c4 20             	add    esp,0x20
    44f0:	e9 b2 02 00 00       	jmp    47a7 <mm_map64+0xb23>
		} else {
				uint32_t id = (pml4e << 18) | (pdpte << 9) | pde;
    44f5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    44f8:	c1 e0 12             	shl    eax,0x12
    44fb:	89 c2                	mov    edx,eax
    44fd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4500:	c1 e0 09             	shl    eax,0x9
    4503:	09 d0                	or     eax,edx
    4505:	0b 45 ec             	or     eax,DWORD PTR [ebp-0x14]
    4508:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
    450b:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    4512:	eb 28                	jmp    453c <mm_map64+0x8b8>
						if (pp->extra_pts[i].idx == id) {
    4514:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4517:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    451a:	83 c2 36             	add    edx,0x36
    451d:	8b 44 d0 08          	mov    eax,DWORD PTR [eax+edx*8+0x8]
    4521:	39 45 a8             	cmp    DWORD PTR [ebp-0x58],eax
    4524:	75 12                	jne    4538 <mm_map64+0x8b4>
								pt = pp->extra_pts[i].pt;
    4526:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4529:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    452c:	83 c2 36             	add    edx,0x36
    452f:	8b 44 d0 04          	mov    eax,DWORD PTR [eax+edx*8+0x4]
    4533:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								break;
    4536:	eb 13                	jmp    454b <mm_map64+0x8c7>
				for (size_t i = 0; i < pp->ec_pt; i++)
    4538:	83 45 c8 01          	add    DWORD PTR [ebp-0x38],0x1
    453c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    453f:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    4543:	0f b7 c0             	movzx  eax,ax
    4546:	39 45 c8             	cmp    DWORD PTR [ebp-0x38],eax
    4549:	72 c9                	jb     4514 <mm_map64+0x890>
						}
				if (!pt) { /* no index -> only default ones left */
    454b:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    454f:	0f 85 52 02 00 00    	jne    47a7 <mm_map64+0xb23>
						if (pml4e == 0 && pdpte == 0 && pde == 0) {
    4555:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4559:	75 17                	jne    4572 <mm_map64+0x8ee>
    455b:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    455f:	75 11                	jne    4572 <mm_map64+0x8ee>
    4561:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    4565:	75 0b                	jne    4572 <mm_map64+0x8ee>
								pt = pp->pt1;
    4567:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    456a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    456d:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    4570:	eb 39                	jmp    45ab <mm_map64+0x927>
						} else if (pml4e == 511 && pdpte == 511 && pde == 511) {
    4572:	81 7d f4 ff 01 00 00 	cmp    DWORD PTR [ebp-0xc],0x1ff
    4579:	75 1d                	jne    4598 <mm_map64+0x914>
    457b:	81 7d f0 ff 01 00 00 	cmp    DWORD PTR [ebp-0x10],0x1ff
    4582:	75 14                	jne    4598 <mm_map64+0x914>
    4584:	81 7d ec ff 01 00 00 	cmp    DWORD PTR [ebp-0x14],0x1ff
    458b:	75 0b                	jne    4598 <mm_map64+0x914>
								pt = pp->pt2;
    458d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4590:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    4593:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    4596:	eb 13                	jmp    45ab <mm_map64+0x927>
						} else {
								puts("pre-paging exhausted.");
    4598:	83 ec 0c             	sub    esp,0xc
    459b:	68 92 00 00 00       	push   0x92
    45a0:	e8 fc ff ff ff       	call   45a1 <mm_map64+0x91d>
    45a5:	83 c4 10             	add    esp,0x10
								while (1);
    45a8:	90                   	nop
    45a9:	eb fd                	jmp    45a8 <mm_map64+0x924>
						}
				}
		}

		/* now map the pages */
		while (prc) {
    45ab:	e9 f7 01 00 00       	jmp    47a7 <mm_map64+0xb23>
				pt[pte].addr = pr_copy.base / 4096;
    45b0:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    45b3:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    45b6:	0f ac d0 0c          	shrd   eax,edx,0xc
    45ba:	c1 ea 0c             	shr    edx,0xc
    45bd:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    45c0:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    45c7:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    45ca:	01 d9                	add    ecx,ebx
    45cc:	81 e2 ff 00 00 00    	and    edx,0xff
    45d2:	89 c3                	mov    ebx,eax
    45d4:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    45da:	89 de                	mov    esi,ebx
    45dc:	c1 e6 0c             	shl    esi,0xc
    45df:	8b 19                	mov    ebx,DWORD PTR [ecx]
    45e1:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    45e7:	09 f3                	or     ebx,esi
    45e9:	89 19                	mov    DWORD PTR [ecx],ebx
    45eb:	89 c3                	mov    ebx,eax
    45ed:	c1 eb 14             	shr    ebx,0x14
    45f0:	89 de                	mov    esi,ebx
    45f2:	66 81 e6 ff 0f       	and    si,0xfff
    45f7:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    45fb:	66 81 e3 00 f0       	and    bx,0xf000
    4600:	09 f3                	or     ebx,esi
    4602:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4606:	0f b6 c2             	movzx  eax,dl
    4609:	c1 e0 0c             	shl    eax,0xc
    460c:	89 c2                	mov    edx,eax
    460e:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4611:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4616:	09 d0                	or     eax,edx
    4618:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt[pte].u = (us ? 1 : 0);
    461b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    461e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4625:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4628:	01 d0                	add    eax,edx
    462a:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
    462e:	0f 95 c2             	setne  dl
    4631:	83 e2 01             	and    edx,0x1
    4634:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    463b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    463e:	83 e2 fb             	and    edx,0xfffffffb
    4641:	09 ca                	or     edx,ecx
    4643:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].xd = (x ? 0 : 1);
    4645:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4648:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    464f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4652:	01 d0                	add    eax,edx
    4654:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    4658:	0f 94 c2             	sete   dl
    465b:	89 d1                	mov    ecx,edx
    465d:	c1 e1 07             	shl    ecx,0x7
    4660:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    4664:	83 e2 7f             	and    edx,0x7f
    4667:	09 ca                	or     edx,ecx
    4669:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				pt[pte].w = (w ? 1 : 0);
    466c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    466f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4676:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4679:	01 d0                	add    eax,edx
    467b:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    467f:	0f 95 c2             	setne  dl
    4682:	83 e2 01             	and    edx,0x1
    4685:	8d 0c 12             	lea    ecx,[edx+edx*1]
    4688:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    468b:	83 e2 fd             	and    edx,0xfffffffd
    468e:	09 ca                	or     edx,ecx
    4690:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
    4692:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4695:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    469c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    469f:	01 d0                	add    eax,edx
    46a1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    46a4:	83 ca 01             	or     edx,0x1
    46a7:	88 10                	mov    BYTE PTR [eax],dl
				//pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
    46a9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    46ac:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    46b3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    46b6:	01 d0                	add    eax,edx
    46b8:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    46bc:	0f 95 c2             	setne  dl
    46bf:	83 e2 01             	and    edx,0x1
    46c2:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    46c9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    46cc:	83 e2 f7             	and    edx,0xfffffff7
    46cf:	09 ca                	or     edx,ecx
    46d1:	88 10                	mov    BYTE PTR [eax],dl
				/* advance */
				if (pte++ == 511) {
    46d3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    46d6:	8d 50 01             	lea    edx,[eax+0x1]
    46d9:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    46dc:	3d ff 01 00 00       	cmp    eax,0x1ff
    46e1:	75 7c                	jne    475f <mm_map64+0xadb>
						if (pde++ == 511) {
    46e3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    46e6:	8d 50 01             	lea    edx,[eax+0x1]
    46e9:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    46ec:	3d ff 01 00 00       	cmp    eax,0x1ff
    46f1:	75 60                	jne    4753 <mm_map64+0xacf>
								if (pdpte++ == 511) {
    46f3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    46f6:	8d 50 01             	lea    edx,[eax+0x1]
    46f9:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    46fc:	3d ff 01 00 00       	cmp    eax,0x1ff
    4701:	75 3d                	jne    4740 <mm_map64+0xabc>
										if (pml4e++ == 511) {
    4703:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4706:	8d 50 01             	lea    edx,[eax+0x1]
    4709:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    470c:	3d ff 01 00 00       	cmp    eax,0x1ff
    4711:	75 13                	jne    4726 <mm_map64+0xaa2>
												puts("End of 16E address space");
    4713:	83 ec 0c             	sub    esp,0xc
    4716:	68 a8 00 00 00       	push   0xa8
    471b:	e8 fc ff ff ff       	call   471c <mm_map64+0xa98>
    4720:	83 c4 10             	add    esp,0x10
												while (1);
    4723:	90                   	nop
    4724:	eb fd                	jmp    4723 <mm_map64+0xa9f>
										}
										pdpte = 0;
    4726:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
										pde = 0;
    472d:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
										pte = 0;
    4734:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
										goto new_pdpt;
    473b:	e9 09 f6 ff ff       	jmp    3d49 <mm_map64+0xc5>
								}
								pde = 0;
    4740:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
								pte = 0;
    4747:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
								goto new_pd;
    474e:	e9 0e f9 ff ff       	jmp    4061 <mm_map64+0x3dd>
						}
						pte = 0;
    4753:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
						goto new_pt;
    475a:	e9 f6 fb ff ff       	jmp    4355 <mm_map64+0x6d1>
						put32(prc);
						put64(pr->base);
						put32(pr->count);
						while (1);
				}
				pr_copy.base += 4096;
    475f:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    4762:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    4765:	05 00 10 00 00       	add    eax,0x1000
    476a:	83 d2 00             	adc    edx,0x0
    476d:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
    4770:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
				if (!--pr_copy.count) {
    4773:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    4776:	83 e8 01             	sub    eax,0x1
    4779:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    477c:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    477f:	85 c0                	test   eax,eax
    4781:	75 24                	jne    47a7 <mm_map64+0xb23>
						if (--prc)
    4783:	83 6d 14 01          	sub    DWORD PTR [ebp+0x14],0x1
    4787:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    478b:	74 1a                	je     47a7 <mm_map64+0xb23>
								pr_copy = *pr++;
    478d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    4790:	8d 50 0c             	lea    edx,[eax+0xc]
    4793:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    4796:	8b 10                	mov    edx,DWORD PTR [eax]
    4798:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
    479b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    479e:	89 55 a0             	mov    DWORD PTR [ebp-0x60],edx
    47a1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    47a4:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
		while (prc) {
    47a7:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    47ab:	0f 85 ff fd ff ff    	jne    45b0 <mm_map64+0x92c>
				}
		}
}
    47b1:	90                   	nop
    47b2:	90                   	nop
    47b3:	8d 65 f8             	lea    esp,[ebp-0x8]
    47b6:	5b                   	pop    ebx
    47b7:	5e                   	pop    esi
    47b8:	5d                   	pop    ebp
    47b9:	c3                   	ret

000047ba <mm_map36>:

void mm_map36(uint32_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    47ba:	55                   	push   ebp
    47bb:	89 e5                	mov    ebp,esp
    47bd:	56                   	push   esi
    47be:	53                   	push   ebx
    47bf:	83 ec 40             	sub    esp,0x40
		struct vm_pg_ptrs36* vp = vm_mapping;
    47c2:	a1 00 00 00 00       	mov    eax,ds:0x0
    47c7:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		struct pm_pg36_ptrs* pp = pm_mapping;
    47ca:	a1 00 00 00 00       	mov    eax,ds:0x0
    47cf:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		uint32_t pdpte, pde, pte;
		struct page_range pr_copy = *pr;
    47d2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    47d5:	8b 10                	mov    edx,DWORD PTR [eax]
    47d7:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    47da:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    47dd:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    47e0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    47e3:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax

		/* physical pointers */
		struct pte64* pd = 0;
    47e6:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		struct pte64* pt = 0;
    47ed:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0

		/* and the PDPTE */
		pdpte = (vaddr & 0xc0000000) >> 30; /* 1G per PDPTE */
    47f4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    47f7:	c1 e8 1e             	shr    eax,0x1e
    47fa:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		pd = pp->pds[pdpte];
    47fd:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4800:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4803:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    4807:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* and the PDE */
		pde = (vaddr & 0x3fe00000) >> 21; /* 2M per PDE */
    480a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    480d:	c1 e8 15             	shr    eax,0x15
    4810:	25 ff 01 00 00       	and    eax,0x1ff
    4815:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and finally the PTE */
		pte = (vaddr & 0x1ff000) >> 12; /* 4K per PTE */
    4818:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    481b:	c1 e8 0c             	shr    eax,0xc
    481e:	25 ff 01 00 00       	and    eax,0x1ff
    4823:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* create a PT if not there */
new_pt:
		if (!pd[pde].p) {
    4826:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4829:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4830:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4833:	01 d0                	add    eax,edx
    4835:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    4838:	83 e0 01             	and    eax,0x1
    483b:	84 c0                	test   al,al
    483d:	0f 85 74 01 00 00    	jne    49b7 <mm_map36+0x1fd>
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
    4843:	83 ec 04             	sub    esp,0x4
    4846:	6a 01                	push   0x1
    4848:	8d 45 bc             	lea    eax,[ebp-0x44]
    484b:	50                   	push   eax
    484c:	6a 01                	push   0x1
    484e:	e8 fc ff ff ff       	call   484f <mm_map36+0x95>
    4853:	83 c4 10             	add    esp,0x10
				vp->pts[pdpte * 512 + pde] = vp->cur;
    4856:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4859:	c1 e0 09             	shl    eax,0x9
    485c:	89 c2                	mov    edx,eax
    485e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4861:	8d 0c 02             	lea    ecx,[edx+eax*1]
    4864:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4867:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    486a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    486d:	83 c1 0c             	add    ecx,0xc
    4870:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
				vp->cur -= 4096;
    4874:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4877:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    487a:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    4880:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4883:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				pt = (void*)pr2.base;
    4886:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    4889:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    488c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = (pdpte << 9) | pde;
    488f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4892:	c1 e0 09             	shl    eax,0x9
    4895:	89 c2                	mov    edx,eax
    4897:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    489a:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    489d:	0b 55 f0             	or     edx,DWORD PTR [ebp-0x10]
    48a0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    48a3:	83 c1 04             	add    ecx,0x4
    48a6:	89 54 c8 04          	mov    DWORD PTR [eax+ecx*8+0x4],edx
				pp->extra_pts[pp->ec_pt++].pt = pt;
    48aa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    48ad:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    48b0:	8d 48 01             	lea    ecx,[eax+0x1]
    48b3:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    48b6:	89 4a 1c             	mov    DWORD PTR [edx+0x1c],ecx
    48b9:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    48bc:	8d 48 04             	lea    ecx,[eax+0x4]
    48bf:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    48c2:	89 04 ca             	mov    DWORD PTR [edx+ecx*8],eax
				if (pp->ec_pt > 64)
    48c5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    48c8:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    48cb:	83 f8 40             	cmp    eax,0x40
    48ce:	76 03                	jbe    48d3 <mm_map36+0x119>
					while (1); /* exhausted too */
    48d0:	90                   	nop
    48d1:	eb fd                	jmp    48d0 <mm_map36+0x116>

				/* and set the reference in the PD */
				pd[pde].addr = (uint64_t)pt / 4096;
    48d3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    48d6:	99                   	cdq
    48d7:	0f ac d0 0c          	shrd   eax,edx,0xc
    48db:	c1 ea 0c             	shr    edx,0xc
    48de:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    48e1:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    48e8:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    48eb:	01 d9                	add    ecx,ebx
    48ed:	81 e2 ff 00 00 00    	and    edx,0xff
    48f3:	89 c3                	mov    ebx,eax
    48f5:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    48fb:	89 de                	mov    esi,ebx
    48fd:	c1 e6 0c             	shl    esi,0xc
    4900:	8b 19                	mov    ebx,DWORD PTR [ecx]
    4902:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    4908:	09 f3                	or     ebx,esi
    490a:	89 19                	mov    DWORD PTR [ecx],ebx
    490c:	89 c3                	mov    ebx,eax
    490e:	c1 eb 14             	shr    ebx,0x14
    4911:	89 de                	mov    esi,ebx
    4913:	66 81 e6 ff 0f       	and    si,0xfff
    4918:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    491c:	66 81 e3 00 f0       	and    bx,0xf000
    4921:	09 f3                	or     ebx,esi
    4923:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4927:	0f b6 c2             	movzx  eax,dl
    492a:	c1 e0 0c             	shl    eax,0xc
    492d:	89 c2                	mov    edx,eax
    492f:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4932:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4937:	09 d0                	or     eax,edx
    4939:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pd[pde].u = 1;
    493c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    493f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4946:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4949:	01 d0                	add    eax,edx
    494b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    494e:	83 ca 04             	or     edx,0x4
    4951:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
    4953:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4956:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    495d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4960:	01 d0                	add    eax,edx
    4962:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4965:	83 ca 02             	or     edx,0x2
    4968:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
    496a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    496d:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4974:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4977:	01 d0                	add    eax,edx
    4979:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    497c:	83 ca 01             	or     edx,0x1
    497f:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map36(vp->pts[pdpte * 512 + pde], &pr2, 1, 1, 1, 1, 0);
    4981:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4984:	c1 e0 09             	shl    eax,0x9
    4987:	89 c2                	mov    edx,eax
    4989:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    498c:	01 c2                	add    edx,eax
    498e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4991:	83 c2 0c             	add    edx,0xc
    4994:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    4998:	83 ec 04             	sub    esp,0x4
    499b:	6a 00                	push   0x0
    499d:	6a 01                	push   0x1
    499f:	6a 01                	push   0x1
    49a1:	6a 01                	push   0x1
    49a3:	6a 01                	push   0x1
    49a5:	8d 55 bc             	lea    edx,[ebp-0x44]
    49a8:	52                   	push   edx
    49a9:	50                   	push   eax
    49aa:	e8 fc ff ff ff       	call   49ab <mm_map36+0x1f1>
    49af:	83 c4 20             	add    esp,0x20
    49b2:	e9 4b 02 00 00       	jmp    4c02 <mm_map36+0x448>
		} else {
				uint32_t id = (pdpte << 9) | pde;
    49b7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    49ba:	c1 e0 09             	shl    eax,0x9
    49bd:	0b 45 f0             	or     eax,DWORD PTR [ebp-0x10]
    49c0:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
    49c3:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    49ca:	eb 27                	jmp    49f3 <mm_map36+0x239>
						if (pp->extra_pts[i].idx == id) {
    49cc:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    49cf:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    49d2:	83 c2 04             	add    edx,0x4
    49d5:	8b 44 d0 04          	mov    eax,DWORD PTR [eax+edx*8+0x4]
    49d9:	39 45 d4             	cmp    DWORD PTR [ebp-0x2c],eax
    49dc:	75 11                	jne    49ef <mm_map36+0x235>
								pt = pp->extra_pts[i].pt;
    49de:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    49e1:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    49e4:	83 c2 04             	add    edx,0x4
    49e7:	8b 04 d0             	mov    eax,DWORD PTR [eax+edx*8]
    49ea:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								break;
    49ed:	eb 0f                	jmp    49fe <mm_map36+0x244>
				for (size_t i = 0; i < pp->ec_pt; i++)
    49ef:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    49f3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    49f6:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    49f9:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    49fc:	72 ce                	jb     49cc <mm_map36+0x212>
						}
				if (!pt) { /* no index -> only default ones left */
    49fe:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    4a02:	0f 85 fa 01 00 00    	jne    4c02 <mm_map36+0x448>
						if (pdpte == 0 && pde == 0) {
    4a08:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4a0c:	75 11                	jne    4a1f <mm_map36+0x265>
    4a0e:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    4a12:	75 0b                	jne    4a1f <mm_map36+0x265>
								pt = pp->pt1;
    4a14:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4a17:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    4a1a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    4a1d:	eb 2d                	jmp    4a4c <mm_map36+0x292>
						} else if (pdpte == 3 && pde == 511) {
    4a1f:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    4a23:	75 14                	jne    4a39 <mm_map36+0x27f>
    4a25:	81 7d f0 ff 01 00 00 	cmp    DWORD PTR [ebp-0x10],0x1ff
    4a2c:	75 0b                	jne    4a39 <mm_map36+0x27f>
								pt = pp->pt2;
    4a2e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4a31:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    4a34:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    4a37:	eb 13                	jmp    4a4c <mm_map36+0x292>
						} else {
								puts("pre-paging exhausted.");
    4a39:	83 ec 0c             	sub    esp,0xc
    4a3c:	68 92 00 00 00       	push   0x92
    4a41:	e8 fc ff ff ff       	call   4a42 <mm_map36+0x288>
    4a46:	83 c4 10             	add    esp,0x10
								while (1);
    4a49:	90                   	nop
    4a4a:	eb fd                	jmp    4a49 <mm_map36+0x28f>
						}
				}
		}

		/* now map the pages */
		while (prc) {
    4a4c:	e9 b1 01 00 00       	jmp    4c02 <mm_map36+0x448>
				pt[pte].addr = pr_copy.base / 4096;
    4a51:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    4a54:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    4a57:	0f ac d0 0c          	shrd   eax,edx,0xc
    4a5b:	c1 ea 0c             	shr    edx,0xc
    4a5e:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    4a61:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    4a68:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    4a6b:	01 d9                	add    ecx,ebx
    4a6d:	81 e2 ff 00 00 00    	and    edx,0xff
    4a73:	89 c3                	mov    ebx,eax
    4a75:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    4a7b:	89 de                	mov    esi,ebx
    4a7d:	c1 e6 0c             	shl    esi,0xc
    4a80:	8b 19                	mov    ebx,DWORD PTR [ecx]
    4a82:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    4a88:	09 f3                	or     ebx,esi
    4a8a:	89 19                	mov    DWORD PTR [ecx],ebx
    4a8c:	89 c3                	mov    ebx,eax
    4a8e:	c1 eb 14             	shr    ebx,0x14
    4a91:	89 de                	mov    esi,ebx
    4a93:	66 81 e6 ff 0f       	and    si,0xfff
    4a98:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    4a9c:	66 81 e3 00 f0       	and    bx,0xf000
    4aa1:	09 f3                	or     ebx,esi
    4aa3:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    4aa7:	0f b6 c2             	movzx  eax,dl
    4aaa:	c1 e0 0c             	shl    eax,0xc
    4aad:	89 c2                	mov    edx,eax
    4aaf:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    4ab2:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    4ab7:	09 d0                	or     eax,edx
    4ab9:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt[pte].u = (us ? 1 : 0);
    4abc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4abf:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4ac6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4ac9:	01 d0                	add    eax,edx
    4acb:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    4acf:	0f 95 c2             	setne  dl
    4ad2:	83 e2 01             	and    edx,0x1
    4ad5:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    4adc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4adf:	83 e2 fb             	and    edx,0xfffffffb
    4ae2:	09 ca                	or     edx,ecx
    4ae4:	88 10                	mov    BYTE PTR [eax],dl
	//			pt[pte].xd = (x ? 0 : 1); /* TODO: check if XD is supp */
				pt[pte].w = (w ? 1 : 0);
    4ae6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4ae9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4af0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4af3:	01 d0                	add    eax,edx
    4af5:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    4af9:	0f 95 c2             	setne  dl
    4afc:	83 e2 01             	and    edx,0x1
    4aff:	8d 0c 12             	lea    ecx,[edx+edx*1]
    4b02:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4b05:	83 e2 fd             	and    edx,0xfffffffd
    4b08:	09 ca                	or     edx,ecx
    4b0a:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
    4b0c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4b0f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4b16:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4b19:	01 d0                	add    eax,edx
    4b1b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4b1e:	83 ca 01             	or     edx,0x1
    4b21:	88 10                	mov    BYTE PTR [eax],dl
				//pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
    4b23:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4b26:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    4b2d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4b30:	01 d0                	add    eax,edx
    4b32:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    4b36:	0f 95 c2             	setne  dl
    4b39:	83 e2 01             	and    edx,0x1
    4b3c:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    4b43:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4b46:	83 e2 f7             	and    edx,0xfffffff7
    4b49:	09 ca                	or     edx,ecx
    4b4b:	88 10                	mov    BYTE PTR [eax],dl
				/* advance */
				if (pte++ == 511) {
    4b4d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4b50:	8d 50 01             	lea    edx,[eax+0x1]
    4b53:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    4b56:	3d ff 01 00 00       	cmp    eax,0x1ff
    4b5b:	75 5d                	jne    4bba <mm_map36+0x400>
						if (pde++ == 511) {
    4b5d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4b60:	8d 50 01             	lea    edx,[eax+0x1]
    4b63:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    4b66:	3d ff 01 00 00       	cmp    eax,0x1ff
    4b6b:	75 41                	jne    4bae <mm_map36+0x3f4>
								if (pdpte++ == 3) {
    4b6d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4b70:	8d 50 01             	lea    edx,[eax+0x1]
    4b73:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    4b76:	83 f8 03             	cmp    eax,0x3
    4b79:	75 13                	jne    4b8e <mm_map36+0x3d4>
										puts("End of 4G address space");
    4b7b:	83 ec 0c             	sub    esp,0xc
    4b7e:	68 c1 00 00 00       	push   0xc1
    4b83:	e8 fc ff ff ff       	call   4b84 <mm_map36+0x3ca>
    4b88:	83 c4 10             	add    esp,0x10
										while (1);
    4b8b:	90                   	nop
    4b8c:	eb fd                	jmp    4b8b <mm_map36+0x3d1>
								}
								pd = pp->pds[pdpte];
    4b8e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    4b91:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4b94:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
    4b98:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								pde = 0;
    4b9b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
								pte = 0;
    4ba2:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
								goto new_pt;
    4ba9:	e9 78 fc ff ff       	jmp    4826 <mm_map36+0x6c>
						}
						pte = 0;
    4bae:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						goto new_pt;
    4bb5:	e9 6c fc ff ff       	jmp    4826 <mm_map36+0x6c>
				}
				pr_copy.base += 4096;
    4bba:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    4bbd:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    4bc0:	05 00 10 00 00       	add    eax,0x1000
    4bc5:	83 d2 00             	adc    edx,0x0
    4bc8:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    4bcb:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (!--pr_copy.count) {
    4bce:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    4bd1:	83 e8 01             	sub    eax,0x1
    4bd4:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    4bd7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    4bda:	85 c0                	test   eax,eax
    4bdc:	75 24                	jne    4c02 <mm_map36+0x448>
						if (--prc)
    4bde:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
    4be2:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    4be6:	74 1a                	je     4c02 <mm_map36+0x448>
								pr_copy = *pr++;
    4be8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4beb:	8d 50 0c             	lea    edx,[eax+0xc]
    4bee:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
    4bf1:	8b 10                	mov    edx,DWORD PTR [eax]
    4bf3:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    4bf6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4bf9:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    4bfc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4bff:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		while (prc) {
    4c02:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    4c06:	0f 85 45 fe ff ff    	jne    4a51 <mm_map36+0x297>
				}
		}
}
    4c0c:	90                   	nop
    4c0d:	90                   	nop
    4c0e:	8d 65 f8             	lea    esp,[ebp-0x8]
    4c11:	5b                   	pop    ebx
    4c12:	5e                   	pop    esi
    4c13:	5d                   	pop    ebp
    4c14:	c3                   	ret

00004c15 <mm_map32>:

void mm_map32(uint32_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    4c15:	55                   	push   ebp
    4c16:	89 e5                	mov    ebp,esp
    4c18:	53                   	push   ebx
    4c19:	83 ec 44             	sub    esp,0x44
		struct vm_pg_ptrs32* vp = vm_mapping;
    4c1c:	a1 00 00 00 00       	mov    eax,ds:0x0
    4c21:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct pm_pg32_ptrs* pp = pm_mapping;
    4c24:	a1 00 00 00 00       	mov    eax,ds:0x0
    4c29:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		uint32_t pde, pte;
		struct page_range pr_copy = *pr;
    4c2c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4c2f:	8b 10                	mov    edx,DWORD PTR [eax]
    4c31:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    4c34:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4c37:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    4c3a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4c3d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax

		/* physical pointers */
		struct pte32* pd = pp->pd;
    4c40:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4c43:	8b 00                	mov    eax,DWORD PTR [eax]
    4c45:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		struct pte32* pt = 0;
    4c48:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0

		/* and the PDE */
		pde = (vaddr & 0xffc00000) >> 22; /* 4M per PDE */
    4c4f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4c52:	c1 e8 16             	shr    eax,0x16
    4c55:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* and finally the PTE */
		pte = (vaddr & 0x3ff000) >> 12; /* 4K per PTE */
    4c58:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4c5b:	c1 e8 0c             	shr    eax,0xc
    4c5e:	25 ff 03 00 00       	and    eax,0x3ff
    4c63:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

new_pt:
		/* create a PT if not there */
		if (!pd[pde].p) {
    4c66:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4c69:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4c70:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4c73:	01 d0                	add    eax,edx
    4c75:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    4c78:	83 e0 01             	and    eax,0x1
    4c7b:	84 c0                	test   al,al
    4c7d:	0f 85 13 01 00 00    	jne    4d96 <mm_map32+0x181>
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
    4c83:	83 ec 04             	sub    esp,0x4
    4c86:	6a 01                	push   0x1
    4c88:	8d 45 c0             	lea    eax,[ebp-0x40]
    4c8b:	50                   	push   eax
    4c8c:	6a 01                	push   0x1
    4c8e:	e8 fc ff ff ff       	call   4c8f <mm_map32+0x7a>
    4c93:	83 c4 10             	add    esp,0x10
				vp->pts[pde] = vp->cur;
    4c96:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4c99:	8b 08                	mov    ecx,DWORD PTR [eax]
    4c9b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4c9e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4ca1:	89 4c 90 08          	mov    DWORD PTR [eax+edx*4+0x8],ecx
				vp->cur -= 4096;
    4ca5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4ca8:	8b 00                	mov    eax,DWORD PTR [eax]
    4caa:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
    4cb0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4cb3:	89 10                	mov    DWORD PTR [eax],edx
				pt = (void*)pr2.base;
    4cb5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    4cb8:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    4cbb:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = pde;
    4cbe:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4cc1:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    4cc4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4cc7:	8d 4a 02             	lea    ecx,[edx+0x2]
    4cca:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4ccd:	89 54 c8 04          	mov    DWORD PTR [eax+ecx*8+0x4],edx
				pp->extra_pts[pp->ec_pt++].pt = pt;
    4cd1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4cd4:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    4cd7:	8d 48 01             	lea    ecx,[eax+0x1]
    4cda:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    4cdd:	89 4a 0c             	mov    DWORD PTR [edx+0xc],ecx
    4ce0:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    4ce3:	8d 48 02             	lea    ecx,[eax+0x2]
    4ce6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4ce9:	89 04 ca             	mov    DWORD PTR [edx+ecx*8],eax
				if (pp->ec_pt > 64)
    4cec:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4cef:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    4cf2:	83 f8 40             	cmp    eax,0x40
    4cf5:	76 03                	jbe    4cfa <mm_map32+0xe5>
					while (1); /* exhausted too */
    4cf7:	90                   	nop
    4cf8:	eb fd                	jmp    4cf7 <mm_map32+0xe2>

				/* and set the reference in the PD */
				pd[pde].addr = (uint32_t)pt / 4096;
    4cfa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4cfd:	c1 e8 0c             	shr    eax,0xc
    4d00:	89 c2                	mov    edx,eax
    4d02:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4d05:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
    4d0c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4d0f:	01 c8                	add    eax,ecx
    4d11:	81 e2 ff ff 0f 00    	and    edx,0xfffff
    4d17:	89 d1                	mov    ecx,edx
    4d19:	c1 e1 0c             	shl    ecx,0xc
    4d1c:	8b 10                	mov    edx,DWORD PTR [eax]
    4d1e:	81 e2 ff 0f 00 00    	and    edx,0xfff
    4d24:	09 ca                	or     edx,ecx
    4d26:	89 10                	mov    DWORD PTR [eax],edx
				pd[pde].u = 1;
    4d28:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4d2b:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4d32:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4d35:	01 d0                	add    eax,edx
    4d37:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4d3a:	83 ca 04             	or     edx,0x4
    4d3d:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
    4d3f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4d42:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4d49:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4d4c:	01 d0                	add    eax,edx
    4d4e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4d51:	83 ca 02             	or     edx,0x2
    4d54:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
    4d56:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4d59:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4d60:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    4d63:	01 d0                	add    eax,edx
    4d65:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4d68:	83 ca 01             	or     edx,0x1
    4d6b:	88 10                	mov    BYTE PTR [eax],dl

				/* and make it known in later VM */
				mm_map32(vp->pts[pde], &pr2, 1, 1, 1, 1, 0);
    4d6d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4d70:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4d73:	8b 44 90 08          	mov    eax,DWORD PTR [eax+edx*4+0x8]
    4d77:	83 ec 04             	sub    esp,0x4
    4d7a:	6a 00                	push   0x0
    4d7c:	6a 01                	push   0x1
    4d7e:	6a 01                	push   0x1
    4d80:	6a 01                	push   0x1
    4d82:	6a 01                	push   0x1
    4d84:	8d 55 c0             	lea    edx,[ebp-0x40]
    4d87:	52                   	push   edx
    4d88:	50                   	push   eax
    4d89:	e8 fc ff ff ff       	call   4d8a <mm_map32+0x175>
    4d8e:	83 c4 20             	add    esp,0x20
    4d91:	e9 00 02 00 00       	jmp    4f96 <mm_map32+0x381>
		} else {
				uint32_t id = pde;
    4d96:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4d99:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
    4d9c:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    4da3:	eb 27                	jmp    4dcc <mm_map32+0x1b7>
						if (pp->extra_pts[i].idx == id) {
    4da5:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4da8:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    4dab:	83 c2 02             	add    edx,0x2
    4dae:	8b 44 d0 04          	mov    eax,DWORD PTR [eax+edx*8+0x4]
    4db2:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    4db5:	75 11                	jne    4dc8 <mm_map32+0x1b3>
								pt = pp->extra_pts[i].pt;
    4db7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4dba:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    4dbd:	83 c2 02             	add    edx,0x2
    4dc0:	8b 04 d0             	mov    eax,DWORD PTR [eax+edx*8]
    4dc3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								break;
    4dc6:	eb 0f                	jmp    4dd7 <mm_map32+0x1c2>
				for (size_t i = 0; i < pp->ec_pt; i++)
    4dc8:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
    4dcc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4dcf:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    4dd2:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    4dd5:	72 ce                	jb     4da5 <mm_map32+0x190>
						}
				if (!pt) { /* no index -> only default ones left */
    4dd7:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    4ddb:	0f 85 b5 01 00 00    	jne    4f96 <mm_map32+0x381>
						if (pde == 0) {
    4de1:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4de5:	75 0e                	jne    4df5 <mm_map32+0x1e0>
								pt = pp->pt1;
    4de7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4dea:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    4ded:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    4df0:	e9 a1 01 00 00       	jmp    4f96 <mm_map32+0x381>
						} else if (pde == 1023) {
    4df5:	81 7d f4 ff 03 00 00 	cmp    DWORD PTR [ebp-0xc],0x3ff
    4dfc:	75 0e                	jne    4e0c <mm_map32+0x1f7>
								pt = pp->pt2;
    4dfe:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    4e01:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4e04:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    4e07:	e9 8a 01 00 00       	jmp    4f96 <mm_map32+0x381>
						} else {
								puts("pre-paging exhausted.");
    4e0c:	83 ec 0c             	sub    esp,0xc
    4e0f:	68 92 00 00 00       	push   0x92
    4e14:	e8 fc ff ff ff       	call   4e15 <mm_map32+0x200>
    4e19:	83 c4 10             	add    esp,0x10
								nput32(pde, 0);
    4e1c:	83 ec 08             	sub    esp,0x8
    4e1f:	6a 00                	push   0x0
    4e21:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    4e24:	e8 fc ff ff ff       	call   4e25 <mm_map32+0x210>
    4e29:	83 c4 10             	add    esp,0x10
								nput32(pte, 0);
    4e2c:	83 ec 08             	sub    esp,0x8
    4e2f:	6a 00                	push   0x0
    4e31:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    4e34:	e8 fc ff ff ff       	call   4e35 <mm_map32+0x220>
    4e39:	83 c4 10             	add    esp,0x10
								put32(vaddr);
    4e3c:	83 ec 0c             	sub    esp,0xc
    4e3f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    4e42:	e8 fc ff ff ff       	call   4e43 <mm_map32+0x22e>
    4e47:	83 c4 10             	add    esp,0x10
								while (1);
    4e4a:	90                   	nop
    4e4b:	eb fd                	jmp    4e4a <mm_map32+0x235>
				}
		}

		/* now map the pages */
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
    4e4d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    4e50:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    4e53:	0f ac d0 0c          	shrd   eax,edx,0xc
    4e57:	c1 ea 0c             	shr    edx,0xc
    4e5a:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    4e5d:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
    4e64:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    4e67:	01 d9                	add    ecx,ebx
    4e69:	25 ff ff 0f 00       	and    eax,0xfffff
    4e6e:	c1 e0 0c             	shl    eax,0xc
    4e71:	89 c2                	mov    edx,eax
    4e73:	8b 01                	mov    eax,DWORD PTR [ecx]
    4e75:	25 ff 0f 00 00       	and    eax,0xfff
    4e7a:	09 d0                	or     eax,edx
    4e7c:	89 01                	mov    DWORD PTR [ecx],eax
				pt[pte].u = (us ? 1 : 0);
    4e7e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4e81:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4e88:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4e8b:	01 d0                	add    eax,edx
    4e8d:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
    4e91:	0f 95 c2             	setne  dl
    4e94:	83 e2 01             	and    edx,0x1
    4e97:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    4e9e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4ea1:	83 e2 fb             	and    edx,0xfffffffb
    4ea4:	09 ca                	or     edx,ecx
    4ea6:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].w = (w ? 1 : 0);
    4ea8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4eab:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4eb2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4eb5:	01 d0                	add    eax,edx
    4eb7:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    4ebb:	0f 95 c2             	setne  dl
    4ebe:	83 e2 01             	and    edx,0x1
    4ec1:	8d 0c 12             	lea    ecx,[edx+edx*1]
    4ec4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4ec7:	83 e2 fd             	and    edx,0xfffffffd
    4eca:	09 ca                	or     edx,ecx
    4ecc:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
    4ece:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4ed1:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4ed8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4edb:	01 d0                	add    eax,edx
    4edd:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4ee0:	83 ca 01             	or     edx,0x1
    4ee3:	88 10                	mov    BYTE PTR [eax],dl
//				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
    4ee5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4ee8:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    4eef:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4ef2:	01 d0                	add    eax,edx
    4ef4:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
    4ef8:	0f 95 c2             	setne  dl
    4efb:	83 e2 01             	and    edx,0x1
    4efe:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    4f05:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    4f08:	83 e2 f7             	and    edx,0xfffffff7
    4f0b:	09 ca                	or     edx,ecx
    4f0d:	88 10                	mov    BYTE PTR [eax],dl
				/* advance */
				if (pte++ == 1023) {
    4f0f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4f12:	8d 50 01             	lea    edx,[eax+0x1]
    4f15:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    4f18:	3d ff 03 00 00       	cmp    eax,0x3ff
    4f1d:	75 2f                	jne    4f4e <mm_map32+0x339>
						if (pde++ == 1023) {
    4f1f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4f22:	8d 50 01             	lea    edx,[eax+0x1]
    4f25:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    4f28:	3d ff 03 00 00       	cmp    eax,0x3ff
    4f2d:	75 13                	jne    4f42 <mm_map32+0x32d>
								puts("end of 4G address space");
    4f2f:	83 ec 0c             	sub    esp,0xc
    4f32:	68 d9 00 00 00       	push   0xd9
    4f37:	e8 fc ff ff ff       	call   4f38 <mm_map32+0x323>
    4f3c:	83 c4 10             	add    esp,0x10
								while (1);
    4f3f:	90                   	nop
    4f40:	eb fd                	jmp    4f3f <mm_map32+0x32a>
						}
						pte = 0;
    4f42:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
						goto new_pt;
    4f49:	e9 18 fd ff ff       	jmp    4c66 <mm_map32+0x51>
				}
				pr_copy.base += 4096;
    4f4e:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    4f51:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    4f54:	05 00 10 00 00       	add    eax,0x1000
    4f59:	83 d2 00             	adc    edx,0x0
    4f5c:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    4f5f:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
				if (!--pr_copy.count) {
    4f62:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    4f65:	83 e8 01             	sub    eax,0x1
    4f68:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    4f6b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    4f6e:	85 c0                	test   eax,eax
    4f70:	75 24                	jne    4f96 <mm_map32+0x381>
						if (--prc)
    4f72:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
    4f76:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    4f7a:	74 1a                	je     4f96 <mm_map32+0x381>
								pr_copy = *pr++;
    4f7c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4f7f:	8d 50 0c             	lea    edx,[eax+0xc]
    4f82:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
    4f85:	8b 10                	mov    edx,DWORD PTR [eax]
    4f87:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    4f8a:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4f8d:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    4f90:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4f93:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		while (prc) {
    4f96:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    4f9a:	0f 85 ad fe ff ff    	jne    4e4d <mm_map32+0x238>
				}
		}
}
    4fa0:	90                   	nop
    4fa1:	90                   	nop
    4fa2:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    4fa5:	c9                   	leave
    4fa6:	c3                   	ret

00004fa7 <mm_perform_mapping>:

void mm_perform_mapping(int mode, uint64_t ofs, struct page_range* pr, int prc,
			   uint64_t vaddr, uint64_t fs, uint64_t ms, struct page_range* pr2,
			   int pr2c, int x, int w)
{
    4fa7:	55                   	push   ebp
    4fa8:	89 e5                	mov    ebp,esp
    4faa:	56                   	push   esi
    4fab:	53                   	push   ebx
    4fac:	83 ec 60             	sub    esp,0x60
    4faf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4fb2:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    4fb5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    4fb8:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
    4fbb:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    4fbe:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    4fc1:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    4fc4:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
    4fc7:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    4fca:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    4fcd:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
    4fd0:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    4fd3:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
    4fd6:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    4fd9:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
    4fdc:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
		uint64_t cur = vaddr; int pro = 0;
    4fdf:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    4fe2:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    4fe5:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    4fe8:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    4feb:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		uint64_t po = ofs / 4096;
    4ff2:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    4ff5:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    4ff8:	0f ac d0 0c          	shrd   eax,edx,0xc
    4ffc:	c1 ea 0c             	shr    edx,0xc
    4fff:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    5002:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		size_t padding = ofs % 4096;
    5005:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    5008:	25 ff 0f 00 00       	and    eax,0xfff
    500d:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		size_t zeros;
		size_t pcf, pcm;
		size_t pcf_c;

		/* calculate the page counts */
		pcf_c = pcf = rdiv(padding + fs, 4096); /* count of pages from file */
    5010:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    5013:	bb 00 00 00 00       	mov    ebx,0x0
    5018:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    501b:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    501e:	01 c8                	add    eax,ecx
    5020:	11 da                	adc    edx,ebx
    5022:	0f ac d0 0c          	shrd   eax,edx,0xc
    5026:	c1 ea 0c             	shr    edx,0xc
    5029:	89 c6                	mov    esi,eax
    502b:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    502e:	bb 00 00 00 00       	mov    ebx,0x0
    5033:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    5036:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    5039:	01 c8                	add    eax,ecx
    503b:	11 da                	adc    edx,ebx
    503d:	25 ff 0f 00 00       	and    eax,0xfff
    5042:	ba 00 00 00 00       	mov    edx,0x0
    5047:	89 c1                	mov    ecx,eax
    5049:	89 c8                	mov    eax,ecx
    504b:	09 d0                	or     eax,edx
    504d:	74 07                	je     5056 <mm_perform_mapping+0xaf>
    504f:	b8 01 00 00 00       	mov    eax,0x1
    5054:	eb 05                	jmp    505b <mm_perform_mapping+0xb4>
    5056:	b8 00 00 00 00       	mov    eax,0x0
    505b:	01 f0                	add    eax,esi
    505d:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    5060:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    5063:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		pcm = rdiv(padding + ms, 4096); /* count of pages in memory */
    5066:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    5069:	bb 00 00 00 00       	mov    ebx,0x0
    506e:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    5071:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    5074:	01 c8                	add    eax,ecx
    5076:	11 da                	adc    edx,ebx
    5078:	0f ac d0 0c          	shrd   eax,edx,0xc
    507c:	c1 ea 0c             	shr    edx,0xc
    507f:	89 c6                	mov    esi,eax
    5081:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    5084:	bb 00 00 00 00       	mov    ebx,0x0
    5089:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    508c:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    508f:	01 c8                	add    eax,ecx
    5091:	11 da                	adc    edx,ebx
    5093:	25 ff 0f 00 00       	and    eax,0xfff
    5098:	ba 00 00 00 00       	mov    edx,0x0
    509d:	89 c1                	mov    ecx,eax
    509f:	89 c8                	mov    eax,ecx
    50a1:	09 d0                	or     eax,edx
    50a3:	74 07                	je     50ac <mm_perform_mapping+0x105>
    50a5:	b8 01 00 00 00       	mov    eax,0x1
    50aa:	eb 05                	jmp    50b1 <mm_perform_mapping+0x10a>
    50ac:	b8 00 00 00 00       	mov    eax,0x0
    50b1:	01 f0                	add    eax,esi
    50b3:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		/* and the number of zero bytes on the last file page */
		zeros = (padding + fs) % 4096;
    50b6:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    50b9:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    50bc:	01 d0                	add    eax,edx
    50be:	25 ff 0f 00 00       	and    eax,0xfff
    50c3:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (zeros)
    50c6:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    50ca:	74 0b                	je     50d7 <mm_perform_mapping+0x130>
				zeros = 4096 - zeros;
    50cc:	b8 00 10 00 00       	mov    eax,0x1000
    50d1:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    50d4:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* fix the alignment */
		if (padding)
    50d7:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    50db:	0f 84 8b 00 00 00    	je     516c <mm_perform_mapping+0x1c5>
				cur -= padding;
    50e1:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    50e4:	ba 00 00 00 00       	mov    edx,0x0
    50e9:	29 45 f0             	sub    DWORD PTR [ebp-0x10],eax
    50ec:	19 55 f4             	sbb    DWORD PTR [ebp-0xc],edx
		/* first build the page ranges for the mapping */
		while (po) {
    50ef:	eb 7b                	jmp    516c <mm_perform_mapping+0x1c5>
				if (pr->count > po) {
    50f1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    50f4:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    50f7:	ba 00 00 00 00       	mov    edx,0x0
    50fc:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    50ff:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    5102:	19 d1                	sbb    ecx,edx
    5104:	73 34                	jae    513a <mm_perform_mapping+0x193>
						/* we found the start */
						pr2->base = pr->base + po * 4096;
    5106:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    5109:	8b 08                	mov    ecx,DWORD PTR [eax]
    510b:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    510e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5111:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    5114:	0f a4 c2 0c          	shld   edx,eax,0xc
    5118:	c1 e0 0c             	shl    eax,0xc
    511b:	01 c8                	add    eax,ecx
    511d:	11 da                	adc    edx,ebx
    511f:	8b 4d 34             	mov    ecx,DWORD PTR [ebp+0x34]
    5122:	89 01                	mov    DWORD PTR [ecx],eax
    5124:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
						pr2->count = pr->count - po;
    5127:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    512a:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    512d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5130:	29 c2                	sub    edx,eax
    5132:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5135:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
						break;
    5138:	eb 3e                	jmp    5178 <mm_perform_mapping+0x1d1>
				} else {
						po -= pr->count;
    513a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    513d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5140:	ba 00 00 00 00       	mov    edx,0x0
    5145:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
    5148:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
						pr++;
    514b:	83 45 14 0c          	add    DWORD PTR [ebp+0x14],0xc
						if (!--prc) { /* no there */
    514f:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
    5153:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    5157:	75 13                	jne    516c <mm_perform_mapping+0x1c5>
								puts("offset not found in ELF.");
    5159:	83 ec 0c             	sub    esp,0xc
    515c:	68 f1 00 00 00       	push   0xf1
    5161:	e8 fc ff ff ff       	call   5162 <mm_perform_mapping+0x1bb>
    5166:	83 c4 10             	add    esp,0x10
								while (1);
    5169:	90                   	nop
    516a:	eb fd                	jmp    5169 <mm_perform_mapping+0x1c2>
		while (po) {
    516c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    516f:	0b 45 e4             	or     eax,DWORD PTR [ebp-0x1c]
    5172:	0f 85 79 ff ff ff    	jne    50f1 <mm_perform_mapping+0x14a>
						}
				}
		}

		/* now pr2 is already pointing in the right direction */
		while (pcf_c > pr2[pro].count) {
    5178:	eb 6e                	jmp    51e8 <mm_perform_mapping+0x241>
				pcf_c -= pr2[pro].count;
    517a:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    517d:	89 d0                	mov    eax,edx
    517f:	01 c0                	add    eax,eax
    5181:	01 d0                	add    eax,edx
    5183:	c1 e0 02             	shl    eax,0x2
    5186:	89 c2                	mov    edx,eax
    5188:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    518b:	01 d0                	add    eax,edx
    518d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5190:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
				/* discontinuity -> new pr needed */
				if (!prc || !pr2c) {
    5193:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    5197:	74 06                	je     519f <mm_perform_mapping+0x1f8>
    5199:	83 7d 38 00          	cmp    DWORD PTR [ebp+0x38],0x0
    519d:	75 13                	jne    51b2 <mm_perform_mapping+0x20b>
						puts("out of PRCs");
    519f:	83 ec 0c             	sub    esp,0xc
    51a2:	68 0a 01 00 00       	push   0x10a
    51a7:	e8 fc ff ff ff       	call   51a8 <mm_perform_mapping+0x201>
    51ac:	83 c4 10             	add    esp,0x10
						while (1);
    51af:	90                   	nop
    51b0:	eb fd                	jmp    51af <mm_perform_mapping+0x208>
				}
				pro++; pr2c--; pr++; prc--;
    51b2:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    51b6:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    51ba:	83 45 14 0c          	add    DWORD PTR [ebp+0x14],0xc
    51be:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
				pr2[pro] = *pr;
    51c2:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    51c5:	89 d0                	mov    eax,edx
    51c7:	01 c0                	add    eax,eax
    51c9:	01 d0                	add    eax,edx
    51cb:	c1 e0 02             	shl    eax,0x2
    51ce:	89 c2                	mov    edx,eax
    51d0:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    51d3:	01 c2                	add    edx,eax
    51d5:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    51d8:	8b 08                	mov    ecx,DWORD PTR [eax]
    51da:	89 0a                	mov    DWORD PTR [edx],ecx
    51dc:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    51df:	89 4a 04             	mov    DWORD PTR [edx+0x4],ecx
    51e2:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    51e5:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
		while (pcf_c > pr2[pro].count) {
    51e8:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    51eb:	89 d0                	mov    eax,edx
    51ed:	01 c0                	add    eax,eax
    51ef:	01 d0                	add    eax,edx
    51f1:	c1 e0 02             	shl    eax,0x2
    51f4:	89 c2                	mov    edx,eax
    51f6:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    51f9:	01 d0                	add    eax,edx
    51fb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    51fe:	3b 45 d8             	cmp    eax,DWORD PTR [ebp-0x28]
    5201:	0f 82 73 ff ff ff    	jb     517a <mm_perform_mapping+0x1d3>
		}
		if (pcf_c) { /* restrict last pr */
    5207:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    520b:	74 19                	je     5226 <mm_perform_mapping+0x27f>
				pr2[pro].count = pcf_c;
    520d:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5210:	89 d0                	mov    eax,edx
    5212:	01 c0                	add    eax,eax
    5214:	01 d0                	add    eax,edx
    5216:	c1 e0 02             	shl    eax,0x2
    5219:	89 c2                	mov    edx,eax
    521b:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    521e:	01 c2                	add    edx,eax
    5220:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    5223:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
		}
		/* and zero */
		if (zeros) {
    5226:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    522a:	0f 84 1f 01 00 00    	je     534f <mm_perform_mapping+0x3a8>
				/* duplicate the critical last page */
				void* end = (void*)(pr2[pro].base + 4096 * --pr2[pro].count);
    5230:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5233:	89 d0                	mov    eax,edx
    5235:	01 c0                	add    eax,eax
    5237:	01 d0                	add    eax,edx
    5239:	c1 e0 02             	shl    eax,0x2
    523c:	89 c2                	mov    edx,eax
    523e:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5241:	01 d0                	add    eax,edx
    5243:	8b 08                	mov    ecx,DWORD PTR [eax]
    5245:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    5248:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    524b:	89 d0                	mov    eax,edx
    524d:	01 c0                	add    eax,eax
    524f:	01 d0                	add    eax,edx
    5251:	c1 e0 02             	shl    eax,0x2
    5254:	89 c2                	mov    edx,eax
    5256:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5259:	01 d0                	add    eax,edx
    525b:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    525e:	83 ea 01             	sub    edx,0x1
    5261:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    5264:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5267:	c1 e0 0c             	shl    eax,0xc
    526a:	ba 00 00 00 00       	mov    edx,0x0
    526f:	01 c8                	add    eax,ecx
    5271:	11 da                	adc    edx,ebx
    5273:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				pro++;
    5276:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
				if (mm_alloc_pm(1, pr2 + pro, --pr2c)) {
    527a:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    527e:	8b 4d 38             	mov    ecx,DWORD PTR [ebp+0x38]
    5281:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    5284:	89 d0                	mov    eax,edx
    5286:	01 c0                	add    eax,eax
    5288:	01 d0                	add    eax,edx
    528a:	c1 e0 02             	shl    eax,0x2
    528d:	89 c2                	mov    edx,eax
    528f:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5292:	01 d0                	add    eax,edx
    5294:	83 ec 04             	sub    esp,0x4
    5297:	51                   	push   ecx
    5298:	50                   	push   eax
    5299:	6a 01                	push   0x1
    529b:	e8 fc ff ff ff       	call   529c <mm_perform_mapping+0x2f5>
    52a0:	83 c4 10             	add    esp,0x10
    52a3:	85 c0                	test   eax,eax
    52a5:	0f 84 91 00 00 00    	je     533c <mm_perform_mapping+0x395>
						void* dst = (void*)pr2[pro].base;
    52ab:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    52ae:	89 d0                	mov    eax,edx
    52b0:	01 c0                	add    eax,eax
    52b2:	01 d0                	add    eax,edx
    52b4:	c1 e0 02             	shl    eax,0x2
    52b7:	89 c2                	mov    edx,eax
    52b9:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    52bc:	01 d0                	add    eax,edx
    52be:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    52c1:	8b 00                	mov    eax,DWORD PTR [eax]
    52c3:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
						mem_cpy(dst, end, 4096 - zeros);
    52c6:	b8 00 10 00 00       	mov    eax,0x1000
    52cb:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    52ce:	83 ec 04             	sub    esp,0x4
    52d1:	50                   	push   eax
    52d2:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    52d5:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
    52d8:	e8 fc ff ff ff       	call   52d9 <mm_perform_mapping+0x332>
    52dd:	83 c4 10             	add    esp,0x10
						if (!pr2[pro - 1].count) { /* remove zero length */
    52e0:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    52e3:	89 d0                	mov    eax,edx
    52e5:	01 c0                	add    eax,eax
    52e7:	01 d0                	add    eax,edx
    52e9:	c1 e0 02             	shl    eax,0x2
    52ec:	8d 50 f4             	lea    edx,[eax-0xc]
    52ef:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    52f2:	01 d0                	add    eax,edx
    52f4:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    52f7:	85 c0                	test   eax,eax
    52f9:	75 54                	jne    534f <mm_perform_mapping+0x3a8>
								pr2[pro - 1] = pr2[pro];
    52fb:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    52fe:	89 d0                	mov    eax,edx
    5300:	01 c0                	add    eax,eax
    5302:	01 d0                	add    eax,edx
    5304:	c1 e0 02             	shl    eax,0x2
    5307:	89 c2                	mov    edx,eax
    5309:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    530c:	01 c2                	add    edx,eax
    530e:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    5311:	89 c8                	mov    eax,ecx
    5313:	01 c0                	add    eax,eax
    5315:	01 c8                	add    eax,ecx
    5317:	c1 e0 02             	shl    eax,0x2
    531a:	8d 48 f4             	lea    ecx,[eax-0xc]
    531d:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5320:	01 c8                	add    eax,ecx
    5322:	8b 0a                	mov    ecx,DWORD PTR [edx]
    5324:	89 08                	mov    DWORD PTR [eax],ecx
    5326:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    5329:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    532c:	8b 52 08             	mov    edx,DWORD PTR [edx+0x8]
    532f:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
								pr2c++; pro--;
    5332:	83 45 38 01          	add    DWORD PTR [ebp+0x38],0x1
    5336:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
    533a:	eb 13                	jmp    534f <mm_perform_mapping+0x3a8>
						}
				} else {
						puts("unable to duplicate page");
    533c:	83 ec 0c             	sub    esp,0xc
    533f:	68 16 01 00 00       	push   0x116
    5344:	e8 fc ff ff ff       	call   5345 <mm_perform_mapping+0x39e>
    5349:	83 c4 10             	add    esp,0x10
						while (1);
    534c:	90                   	nop
    534d:	eb fd                	jmp    534c <mm_perform_mapping+0x3a5>
				}
				//bzero(end - zeros, zeros);
		}

		/* advance */
		pro++;
    534f:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
		pr2c--;
    5353:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1

		/* now add the zero pages */
		if (pcm > pcf) {
    5357:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    535a:	39 45 c4             	cmp    DWORD PTR [ebp-0x3c],eax
    535d:	0f 83 c6 00 00 00    	jae    5429 <mm_perform_mapping+0x482>
				size_t zc = pcm - pcf;
    5363:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    5366:	2b 45 c4             	sub    eax,DWORD PTR [ebp-0x3c]
    5369:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (w) {
    536c:	83 7d 40 00          	cmp    DWORD PTR [ebp+0x40],0x0
    5370:	0f 84 91 00 00 00    	je     5407 <mm_perform_mapping+0x460>
						zc -= mm_alloc_pm(zc, pr2 + pro, pr2c);
    5376:	8b 4d 38             	mov    ecx,DWORD PTR [ebp+0x38]
    5379:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    537c:	89 d0                	mov    eax,edx
    537e:	01 c0                	add    eax,eax
    5380:	01 d0                	add    eax,edx
    5382:	c1 e0 02             	shl    eax,0x2
    5385:	89 c2                	mov    edx,eax
    5387:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    538a:	01 d0                	add    eax,edx
    538c:	83 ec 04             	sub    esp,0x4
    538f:	51                   	push   ecx
    5390:	50                   	push   eax
    5391:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    5394:	e8 fc ff ff ff       	call   5395 <mm_perform_mapping+0x3ee>
    5399:	83 c4 10             	add    esp,0x10
    539c:	29 45 d4             	sub    DWORD PTR [ebp-0x2c],eax
						pro++; pr2c--;
    539f:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    53a3:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    53a7:	eb 6a                	jmp    5413 <mm_perform_mapping+0x46c>
				} else { /* use the single zero page (wastes many ranges) */
						while (zc && pr2c) {
								pr2[pro].base = pm_zero;
    53a9:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    53ac:	89 d0                	mov    eax,edx
    53ae:	01 c0                	add    eax,eax
    53b0:	01 d0                	add    eax,edx
    53b2:	c1 e0 02             	shl    eax,0x2
    53b5:	89 c2                	mov    edx,eax
    53b7:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    53ba:	8d 0c 02             	lea    ecx,[edx+eax*1]
    53bd:	a1 00 00 00 00       	mov    eax,ds:0x0
    53c2:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    53c8:	89 01                	mov    DWORD PTR [ecx],eax
    53ca:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr2[pro++].count = 1;
    53cd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    53d0:	8d 50 01             	lea    edx,[eax+0x1]
    53d3:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    53d6:	89 c2                	mov    edx,eax
    53d8:	89 d0                	mov    eax,edx
    53da:	01 c0                	add    eax,eax
    53dc:	01 d0                	add    eax,edx
    53de:	c1 e0 02             	shl    eax,0x2
    53e1:	89 c2                	mov    edx,eax
    53e3:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    53e6:	01 d0                	add    eax,edx
    53e8:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr2c--; zc--;
    53ef:	83 6d 38 01          	sub    DWORD PTR [ebp+0x38],0x1
    53f3:	83 6d d4 01          	sub    DWORD PTR [ebp-0x2c],0x1
								/* TODO: reprogram by using multiple calls */
								puts("zero-page used");
    53f7:	83 ec 0c             	sub    esp,0xc
    53fa:	68 2f 01 00 00       	push   0x12f
    53ff:	e8 fc ff ff ff       	call   5400 <mm_perform_mapping+0x459>
    5404:	83 c4 10             	add    esp,0x10
						while (zc && pr2c) {
    5407:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    540b:	74 06                	je     5413 <mm_perform_mapping+0x46c>
    540d:	83 7d 38 00          	cmp    DWORD PTR [ebp+0x38],0x0
    5411:	75 96                	jne    53a9 <mm_perform_mapping+0x402>
						}
				}
				if (zc) {
    5413:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    5417:	74 10                	je     5429 <mm_perform_mapping+0x482>
						puts("unable to zero-pad .bss-like section.");
    5419:	83 ec 0c             	sub    esp,0xc
    541c:	68 40 01 00 00       	push   0x140
    5421:	e8 fc ff ff ff       	call   5422 <mm_perform_mapping+0x47b>
    5426:	83 c4 10             	add    esp,0x10
		}

		/* TODO: handle overlap of W and X if wanted */

		/* we now have built the mapping in pr2 with pro valid ranges */
		if (cur < 0x100000) { /* identity map -> .trampo */
    5429:	ba ff ff 0f 00       	mov    edx,0xfffff
    542e:	b8 00 00 00 00       	mov    eax,0x0
    5433:	3b 55 f0             	cmp    edx,DWORD PTR [ebp-0x10]
    5436:	1b 45 f4             	sbb    eax,DWORD PTR [ebp-0xc]
    5439:	72 7c                	jb     54b7 <mm_perform_mapping+0x510>
				void* ptr = (void*)cur;
    543b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    543e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				for (int i = 0; i < pro; i++) {
    5441:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    5448:	eb 63                	jmp    54ad <mm_perform_mapping+0x506>
						mem_cpy(ptr, (void*)pr2[i].base, pr2[i].count * 4096);
    544a:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    544d:	89 d0                	mov    eax,edx
    544f:	01 c0                	add    eax,eax
    5451:	01 d0                	add    eax,edx
    5453:	c1 e0 02             	shl    eax,0x2
    5456:	89 c2                	mov    edx,eax
    5458:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    545b:	01 d0                	add    eax,edx
    545d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    5460:	c1 e0 0c             	shl    eax,0xc
    5463:	89 c1                	mov    ecx,eax
    5465:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    5468:	89 d0                	mov    eax,edx
    546a:	01 c0                	add    eax,eax
    546c:	01 d0                	add    eax,edx
    546e:	c1 e0 02             	shl    eax,0x2
    5471:	89 c2                	mov    edx,eax
    5473:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    5476:	01 d0                	add    eax,edx
    5478:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    547b:	8b 00                	mov    eax,DWORD PTR [eax]
    547d:	83 ec 04             	sub    esp,0x4
    5480:	51                   	push   ecx
    5481:	50                   	push   eax
    5482:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    5485:	e8 fc ff ff ff       	call   5486 <mm_perform_mapping+0x4df>
    548a:	83 c4 10             	add    esp,0x10
						ptr += pr2[i].count * 4096;
    548d:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    5490:	89 d0                	mov    eax,edx
    5492:	01 c0                	add    eax,eax
    5494:	01 d0                	add    eax,edx
    5496:	c1 e0 02             	shl    eax,0x2
    5499:	89 c2                	mov    edx,eax
    549b:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    549e:	01 d0                	add    eax,edx
    54a0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    54a3:	c1 e0 0c             	shl    eax,0xc
    54a6:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
				for (int i = 0; i < pro; i++) {
    54a9:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
    54ad:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    54b0:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
    54b3:	7c 95                	jl     544a <mm_perform_mapping+0x4a3>
				}
				return; /* TODO: possible NX setup */
    54b5:	eb 6c                	jmp    5523 <mm_perform_mapping+0x57c>
		}

		if (!mode)
    54b7:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    54bb:	75 21                	jne    54de <mm_perform_mapping+0x537>
				mm_map32((uint32_t)cur, pr2, pro, x, w, 0, 0);
    54bd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    54c0:	83 ec 04             	sub    esp,0x4
    54c3:	6a 00                	push   0x0
    54c5:	6a 00                	push   0x0
    54c7:	ff 75 40             	push   DWORD PTR [ebp+0x40]
    54ca:	ff 75 3c             	push   DWORD PTR [ebp+0x3c]
    54cd:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    54d0:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    54d3:	50                   	push   eax
    54d4:	e8 fc ff ff ff       	call   54d5 <mm_perform_mapping+0x52e>
    54d9:	83 c4 20             	add    esp,0x20
    54dc:	eb 45                	jmp    5523 <mm_perform_mapping+0x57c>
		else if (mode == 1)
    54de:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    54e2:	75 21                	jne    5505 <mm_perform_mapping+0x55e>
				mm_map36((uint32_t)cur, pr2, pro, x, w, 0, 0);
    54e4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    54e7:	83 ec 04             	sub    esp,0x4
    54ea:	6a 00                	push   0x0
    54ec:	6a 00                	push   0x0
    54ee:	ff 75 40             	push   DWORD PTR [ebp+0x40]
    54f1:	ff 75 3c             	push   DWORD PTR [ebp+0x3c]
    54f4:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    54f7:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    54fa:	50                   	push   eax
    54fb:	e8 fc ff ff ff       	call   54fc <mm_perform_mapping+0x555>
    5500:	83 c4 20             	add    esp,0x20
    5503:	eb 1e                	jmp    5523 <mm_perform_mapping+0x57c>
		else
				mm_map64(cur, pr2, pro, x, w, 0, 0);
    5505:	6a 00                	push   0x0
    5507:	6a 00                	push   0x0
    5509:	ff 75 40             	push   DWORD PTR [ebp+0x40]
    550c:	ff 75 3c             	push   DWORD PTR [ebp+0x3c]
    550f:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    5512:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    5515:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    5518:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    551b:	e8 fc ff ff ff       	call   551c <mm_perform_mapping+0x575>
    5520:	83 c4 20             	add    esp,0x20
}
    5523:	8d 65 f8             	lea    esp,[ebp-0x8]
    5526:	5b                   	pop    ebx
    5527:	5e                   	pop    esi
    5528:	5d                   	pop    ebp
    5529:	c3                   	ret

0000552a <mm_mmap>:


void mm_mmap(int mode, uint64_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
    552a:	55                   	push   ebp
    552b:	89 e5                	mov    ebp,esp
    552d:	83 ec 18             	sub    esp,0x18
    5530:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    5533:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    5536:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    5539:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!mode)
    553c:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    5540:	75 23                	jne    5565 <mm_mmap+0x3b>
				mm_map32((uint32_t)vaddr, pr, prc, x, w, wc, us);
    5542:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    5545:	83 ec 04             	sub    esp,0x4
    5548:	ff 75 28             	push   DWORD PTR [ebp+0x28]
    554b:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    554e:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    5551:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    5554:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    5557:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    555a:	50                   	push   eax
    555b:	e8 fc ff ff ff       	call   555c <mm_mmap+0x32>
    5560:	83 c4 20             	add    esp,0x20
		else if (mode == 1)
				mm_map36((uint32_t)vaddr, pr, prc, x, w, wc, us);
		else
				mm_map64(vaddr, pr, prc, x, w, wc, us);
}
    5563:	eb 49                	jmp    55ae <mm_mmap+0x84>
		else if (mode == 1)
    5565:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    5569:	75 23                	jne    558e <mm_mmap+0x64>
				mm_map36((uint32_t)vaddr, pr, prc, x, w, wc, us);
    556b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    556e:	83 ec 04             	sub    esp,0x4
    5571:	ff 75 28             	push   DWORD PTR [ebp+0x28]
    5574:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    5577:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    557a:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    557d:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    5580:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    5583:	50                   	push   eax
    5584:	e8 fc ff ff ff       	call   5585 <mm_mmap+0x5b>
    5589:	83 c4 20             	add    esp,0x20
}
    558c:	eb 20                	jmp    55ae <mm_mmap+0x84>
				mm_map64(vaddr, pr, prc, x, w, wc, us);
    558e:	ff 75 28             	push   DWORD PTR [ebp+0x28]
    5591:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    5594:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    5597:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    559a:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    559d:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    55a0:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    55a3:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    55a6:	e8 fc ff ff ff       	call   55a7 <mm_mmap+0x7d>
    55ab:	83 c4 20             	add    esp,0x20
}
    55ae:	90                   	nop
    55af:	c9                   	leave
    55b0:	c3                   	ret

000055b1 <mm_register_video_memory>:

void* mm_register_video_memory(int mode, uint64_t vga_pmem, uint64_t vga_pmem_size)
{
    55b1:	55                   	push   ebp
    55b2:	89 e5                	mov    ebp,esp
    55b4:	53                   	push   ebx
    55b5:	83 ec 44             	sub    esp,0x44
    55b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    55bb:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    55be:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    55c1:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    55c4:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    55c7:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    55ca:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    55cd:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		struct vmdesc vd, *pvd;
		struct page_range pr = { vga_pmem, rdiv(vga_pmem_size, 4096) };
    55d0:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    55d3:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    55d6:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    55d9:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
    55dc:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    55df:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    55e2:	0f ac d0 0c          	shrd   eax,edx,0xc
    55e6:	c1 ea 0c             	shr    edx,0xc
    55e9:	89 c1                	mov    ecx,eax
    55eb:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    55ee:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    55f1:	25 ff 0f 00 00       	and    eax,0xfff
    55f6:	ba 00 00 00 00       	mov    edx,0x0
    55fb:	89 c3                	mov    ebx,eax
    55fd:	89 d8                	mov    eax,ebx
    55ff:	09 d0                	or     eax,edx
    5601:	74 07                	je     560a <mm_register_video_memory+0x59>
    5603:	b8 01 00 00 00       	mov    eax,0x1
    5608:	eb 05                	jmp    560f <mm_register_video_memory+0x5e>
    560a:	b8 00 00 00 00       	mov    eax,0x0
    560f:	01 c8                	add    eax,ecx
    5611:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		vd.vga_base = vga_pmem;
    5614:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    5617:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    561a:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    561d:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
		vd.vga_size = vga_pmem_size;
    5620:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    5623:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    5626:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    5629:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
		vd.vga_virt = VM_VIDEO_MEMORY;
    562c:	c7 45 ec 00 00 00 e0 	mov    DWORD PTR [ebp-0x14],0xe0000000
    5633:	c7 45 f0 ff ff ff ff 	mov    DWORD PTR [ebp-0x10],0xffffffff
		if (!mode)
    563a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    563e:	75 0f                	jne    564f <mm_register_video_memory+0x9e>
			pvd = &((struct vm_pg_ptrs32*)vm_mapping)->video_memory;
    5640:	a1 00 00 00 00       	mov    eax,ds:0x0
    5645:	05 08 10 00 00       	add    eax,0x1008
    564a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    564d:	eb 22                	jmp    5671 <mm_register_video_memory+0xc0>
		else if (mode == 1)
    564f:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    5653:	75 0f                	jne    5664 <mm_register_video_memory+0xb3>
			pvd = &((struct vm_pg_ptrs36*)vm_mapping)->video_memory;
    5655:	a1 00 00 00 00       	mov    eax,ds:0x0
    565a:	05 34 20 00 00       	add    eax,0x2034
    565f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    5662:	eb 0d                	jmp    5671 <mm_register_video_memory+0xc0>
		else
			pvd = &((struct vm_pg_ptrs64*)vm_mapping)->video_memory;
    5664:	a1 00 00 00 00       	mov    eax,ds:0x0
    5669:	05 10 20 00 00       	add    eax,0x2010
    566e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		mm_mmap(mode, vd.vga_virt, &pr, 1, 0, 1, 1, 0);
    5671:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    5674:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    5677:	83 ec 0c             	sub    esp,0xc
    567a:	6a 00                	push   0x0
    567c:	6a 01                	push   0x1
    567e:	6a 01                	push   0x1
    5680:	6a 00                	push   0x0
    5682:	6a 01                	push   0x1
    5684:	8d 4d d0             	lea    ecx,[ebp-0x30]
    5687:	51                   	push   ecx
    5688:	52                   	push   edx
    5689:	50                   	push   eax
    568a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    568d:	e8 fc ff ff ff       	call   568e <mm_register_video_memory+0xdd>
    5692:	83 c4 30             	add    esp,0x30
		*pvd = vd;
    5695:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    5698:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    569b:	89 10                	mov    DWORD PTR [eax],edx
    569d:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    56a0:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    56a3:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    56a6:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    56a9:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    56ac:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    56af:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    56b2:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
    56b5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    56b8:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		return pvd;
    56bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    56be:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    56c1:	c9                   	leave
    56c2:	c3                   	ret

000056c3 <mm_preallocate_maps>:

void mm_preallocate_maps(int mode)
{
    56c3:	55                   	push   ebp
    56c4:	89 e5                	mov    ebp,esp
    56c6:	57                   	push   edi
    56c7:	56                   	push   esi
    56c8:	53                   	push   ebx
    56c9:	83 ec 6c             	sub    esp,0x6c
			struct page_range pr;
			uint64_t mem_ranges[] = {
    56cc:	8d 45 88             	lea    eax,[ebp-0x78]
    56cf:	bb c0 01 00 00       	mov    ebx,0x1c0
    56d4:	ba 14 00 00 00       	mov    edx,0x14
    56d9:	89 c7                	mov    edi,eax
    56db:	89 de                	mov    esi,ebx
    56dd:	89 d1                	mov    ecx,edx
    56df:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
				VM_QND_BASE, 1
			}, *mr_pt;


			/* Pre-allocate the required ranges */
			for (mr_pt = &mem_ranges[0]; (mr_pt - mem_ranges) < 10; mr_pt += 2) {
    56e1:	8d 45 88             	lea    eax,[ebp-0x78]
    56e4:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    56e7:	e9 c9 00 00 00       	jmp    57b5 <mm_preallocate_maps+0xf2>
					/* get some inital space for tables / stuff */
					putstr("allocating map for "); put64(mr_pt[0]);
    56ec:	83 ec 0c             	sub    esp,0xc
    56ef:	68 66 01 00 00       	push   0x166
    56f4:	e8 fc ff ff ff       	call   56f5 <mm_preallocate_maps+0x32>
    56f9:	83 c4 10             	add    esp,0x10
    56fc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    56ff:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5702:	8b 00                	mov    eax,DWORD PTR [eax]
    5704:	83 ec 08             	sub    esp,0x8
    5707:	52                   	push   edx
    5708:	50                   	push   eax
    5709:	e8 fc ff ff ff       	call   570a <mm_preallocate_maps+0x47>
    570e:	83 c4 10             	add    esp,0x10
					putstr(" of count "); put64(mr_pt[1]); put_nl();
    5711:	83 ec 0c             	sub    esp,0xc
    5714:	68 7a 01 00 00       	push   0x17a
    5719:	e8 fc ff ff ff       	call   571a <mm_preallocate_maps+0x57>
    571e:	83 c4 10             	add    esp,0x10
    5721:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5724:	83 c0 08             	add    eax,0x8
    5727:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    572a:	8b 00                	mov    eax,DWORD PTR [eax]
    572c:	83 ec 08             	sub    esp,0x8
    572f:	52                   	push   edx
    5730:	50                   	push   eax
    5731:	e8 fc ff ff ff       	call   5732 <mm_preallocate_maps+0x6f>
    5736:	83 c4 10             	add    esp,0x10
    5739:	e8 fc ff ff ff       	call   573a <mm_preallocate_maps+0x77>
					mm_alloc_pm(mr_pt[1], &pr, 1);
    573e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    5741:	83 c0 08             	add    eax,0x8
    5744:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5747:	8b 00                	mov    eax,DWORD PTR [eax]
    5749:	89 c2                	mov    edx,eax
    574b:	83 ec 04             	sub    esp,0x4
    574e:	6a 01                	push   0x1
    5750:	8d 45 d8             	lea    eax,[ebp-0x28]
    5753:	50                   	push   eax
    5754:	52                   	push   edx
    5755:	e8 fc ff ff ff       	call   5756 <mm_preallocate_maps+0x93>
    575a:	83 c4 10             	add    esp,0x10
					if (pr.count < mr_pt[1]) {
    575d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    5760:	89 c1                	mov    ecx,eax
    5762:	bb 00 00 00 00       	mov    ebx,0x0
    5767:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    576a:	83 c0 08             	add    eax,0x8
    576d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5770:	8b 00                	mov    eax,DWORD PTR [eax]
    5772:	39 c1                	cmp    ecx,eax
    5774:	19 d3                	sbb    ebx,edx
    5776:	73 13                	jae    578b <mm_preallocate_maps+0xc8>
							putstr("unable to allocate basic memory");
    5778:	83 ec 0c             	sub    esp,0xc
    577b:	68 88 01 00 00       	push   0x188
    5780:	e8 fc ff ff ff       	call   5781 <mm_preallocate_maps+0xbe>
    5785:	83 c4 10             	add    esp,0x10
							while (1);
    5788:	90                   	nop
    5789:	eb fd                	jmp    5788 <mm_preallocate_maps+0xc5>
					}
					/* and then map it accordingly */
					mm_mmap(mode, mr_pt[0], &pr, 1, 0, 1, 0, 0);
    578b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    578e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    5791:	8b 00                	mov    eax,DWORD PTR [eax]
    5793:	83 ec 0c             	sub    esp,0xc
    5796:	6a 00                	push   0x0
    5798:	6a 00                	push   0x0
    579a:	6a 01                	push   0x1
    579c:	6a 00                	push   0x0
    579e:	6a 01                	push   0x1
    57a0:	8d 4d d8             	lea    ecx,[ebp-0x28]
    57a3:	51                   	push   ecx
    57a4:	52                   	push   edx
    57a5:	50                   	push   eax
    57a6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    57a9:	e8 fc ff ff ff       	call   57aa <mm_preallocate_maps+0xe7>
    57ae:	83 c4 30             	add    esp,0x30
			for (mr_pt = &mem_ranges[0]; (mr_pt - mem_ranges) < 10; mr_pt += 2) {
    57b1:	83 45 e4 10          	add    DWORD PTR [ebp-0x1c],0x10
    57b5:	8d 45 88             	lea    eax,[ebp-0x78]
    57b8:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    57bb:	29 c2                	sub    edx,eax
    57bd:	83 fa 48             	cmp    edx,0x48
    57c0:	0f 8e 26 ff ff ff    	jle    56ec <mm_preallocate_maps+0x29>
			}

			puts("done");
    57c6:	83 ec 0c             	sub    esp,0xc
    57c9:	68 a8 01 00 00       	push   0x1a8
    57ce:	e8 fc ff ff ff       	call   57cf <mm_preallocate_maps+0x10c>
    57d3:	83 c4 10             	add    esp,0x10
}
    57d6:	90                   	nop
    57d7:	8d 65 f4             	lea    esp,[ebp-0xc]
    57da:	5b                   	pop    ebx
    57db:	5e                   	pop    esi
    57dc:	5f                   	pop    edi
    57dd:	5d                   	pop    ebp
    57de:	c3                   	ret
