
longmath.o:     file format elf32-i386


Disassembly of section .text:

00000000 <__umoddi3>:
		return q;
}

UDWtype
__umoddi3 (UDWtype u, UDWtype v)
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 60             	sub    esp,0x60
   6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   9:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
   c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   f:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
  12:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  15:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
  18:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
  1b:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
  1e:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
  21:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
  24:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
  27:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
  2a:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
  2d:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
  30:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
  33:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
  36:	8d 45 b8             	lea    eax,[ebp-0x48]
  39:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		UDWtype q = 0, r = n, y = d;
  3c:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
  43:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
  4a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
  4d:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
  50:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
  53:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
  56:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  59:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
  5c:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
  5f:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (y <= r)
  62:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
  65:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
  68:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
  6b:	89 d0                	mov    eax,edx
  6d:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
  70:	0f 82 4f 01 00 00    	jb     1c5 <__umoddi3+0x1c5>
				lz1 = __builtin_clzll (d);
  76:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  79:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
  7c:	85 d2                	test   edx,edx
  7e:	74 08                	je     88 <__umoddi3+0x88>
  80:	0f bd c2             	bsr    eax,edx
  83:	83 f0 1f             	xor    eax,0x1f
  86:	eb 09                	jmp    91 <__umoddi3+0x91>
  88:	0f bd c0             	bsr    eax,eax
  8b:	83 f0 1f             	xor    eax,0x1f
  8e:	83 c0 20             	add    eax,0x20
  91:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				lz2 = __builtin_clzll (n);
  94:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
  97:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
  9a:	85 d2                	test   edx,edx
  9c:	74 08                	je     a6 <__umoddi3+0xa6>
  9e:	0f bd c2             	bsr    eax,edx
  a1:	83 f0 1f             	xor    eax,0x1f
  a4:	eb 09                	jmp    af <__umoddi3+0xaf>
  a6:	0f bd c0             	bsr    eax,eax
  a9:	83 f0 1f             	xor    eax,0x1f
  ac:	83 c0 20             	add    eax,0x20
  af:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				k = lz1 - lz2;
  b2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
  b5:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
  b8:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				y = (y << k);
  bb:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
  be:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
  c1:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
  c4:	0f a5 c2             	shld   edx,eax,cl
  c7:	d3 e0                	shl    eax,cl
  c9:	f6 c1 20             	test   cl,0x20
  cc:	74 04                	je     d2 <__umoddi3+0xd2>
  ce:	89 c2                	mov    edx,eax
  d0:	31 c0                	xor    eax,eax
  d2:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
  d5:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (r >= y)
  d8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
  db:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
  de:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
  e1:	89 d0                	mov    eax,edx
  e3:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
  e6:	72 2d                	jb     115 <__umoddi3+0x115>
						r = r - y;
  e8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
  eb:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
  ee:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
  f1:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						q =  (1ULL << k);
  f4:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
  f7:	b8 01 00 00 00       	mov    eax,0x1
  fc:	ba 00 00 00 00       	mov    edx,0x0
 101:	0f a5 c2             	shld   edx,eax,cl
 104:	d3 e0                	shl    eax,cl
 106:	f6 c1 20             	test   cl,0x20
 109:	74 04                	je     10f <__umoddi3+0x10f>
 10b:	89 c2                	mov    edx,eax
 10d:	31 c0                	xor    eax,eax
 10f:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
 112:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (k > 0)
 115:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
 119:	0f 84 a6 00 00 00    	je     1c5 <__umoddi3+0x1c5>
						y = y >> 1;
 11f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 122:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 125:	0f ac d0 01          	shrd   eax,edx,0x1
 129:	d1 ea                	shr    edx,1
 12b:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 12e:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						i = k;
 131:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
 134:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								if (r >= y)
 137:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 13a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 13d:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 140:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
 143:	19 d1                	sbb    ecx,edx
 145:	72 1e                	jb     165 <__umoddi3+0x165>
										r = ((r - y) << 1) + 1;
 147:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 14a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 14d:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
 150:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
 153:	01 c0                	add    eax,eax
 155:	11 d2                	adc    edx,edx
 157:	83 c0 01             	add    eax,0x1
 15a:	83 d2 00             	adc    edx,0x0
 15d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 160:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
 163:	eb 10                	jmp    175 <__umoddi3+0x175>
										r =  (r << 1);
 165:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 168:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 16b:	01 c0                	add    eax,eax
 16d:	11 d2                	adc    edx,edx
 16f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 172:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
								i = i - 1;
 175:	83 6d c0 01          	sub    DWORD PTR [ebp-0x40],0x1
						} while (i != 0);
 179:	83 7d c0 00          	cmp    DWORD PTR [ebp-0x40],0x0
 17d:	75 b8                	jne    137 <__umoddi3+0x137>
						q = q + r;
 17f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 182:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 185:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
 188:	11 55 e4             	adc    DWORD PTR [ebp-0x1c],edx
						r = r >> k;
 18b:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 18e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 191:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 194:	0f ad d0             	shrd   eax,edx,cl
 197:	d3 ea                	shr    edx,cl
 199:	f6 c1 20             	test   cl,0x20
 19c:	74 04                	je     1a2 <__umoddi3+0x1a2>
 19e:	89 d0                	mov    eax,edx
 1a0:	31 d2                	xor    edx,edx
 1a2:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 1a5:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
						q = q - (r << k);
 1a8:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 1ab:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 1ae:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 1b1:	0f a5 c2             	shld   edx,eax,cl
 1b4:	d3 e0                	shl    eax,cl
 1b6:	f6 c1 20             	test   cl,0x20
 1b9:	74 04                	je     1bf <__umoddi3+0x1bf>
 1bb:	89 c2                	mov    edx,eax
 1bd:	31 c0                	xor    eax,eax
 1bf:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
 1c2:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
		if (rp)
 1c5:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 1c9:	74 0e                	je     1d9 <__umoddi3+0x1d9>
				*rp = r;
 1cb:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
 1ce:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 1d1:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 1d4:	89 01                	mov    DWORD PTR [ecx],eax
 1d6:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		UDWtype w;

		(void) __udivmoddi4 (u, v, &w);

		return w;
 1d9:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
 1dc:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
}
 1df:	c9                   	leave
 1e0:	c3                   	ret

000001e1 <__udivdi3>:

UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
 1e1:	55                   	push   ebp
 1e2:	89 e5                	mov    ebp,esp
 1e4:	83 ec 50             	sub    esp,0x50
 1e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 1ea:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
 1ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 1f0:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
 1f3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 1f6:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
 1f9:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 1fc:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
 1ff:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
 202:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 205:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
 208:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
 20b:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
 20e:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
 211:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 214:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
 217:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		UDWtype q = 0, r = n, y = d;
 21e:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
 225:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 22c:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
 22f:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
 232:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 235:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
 238:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 23b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 23e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 241:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (y <= r)
 244:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 247:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 24a:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
 24d:	89 d0                	mov    eax,edx
 24f:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
 252:	0f 82 4f 01 00 00    	jb     3a7 <__udivdi3+0x1c6>
				lz1 = __builtin_clzll (d);
 258:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 25b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 25e:	85 d2                	test   edx,edx
 260:	74 08                	je     26a <__udivdi3+0x89>
 262:	0f bd c2             	bsr    eax,edx
 265:	83 f0 1f             	xor    eax,0x1f
 268:	eb 09                	jmp    273 <__udivdi3+0x92>
 26a:	0f bd c0             	bsr    eax,eax
 26d:	83 f0 1f             	xor    eax,0x1f
 270:	83 c0 20             	add    eax,0x20
 273:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				lz2 = __builtin_clzll (n);
 276:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
 279:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
 27c:	85 d2                	test   edx,edx
 27e:	74 08                	je     288 <__udivdi3+0xa7>
 280:	0f bd c2             	bsr    eax,edx
 283:	83 f0 1f             	xor    eax,0x1f
 286:	eb 09                	jmp    291 <__udivdi3+0xb0>
 288:	0f bd c0             	bsr    eax,eax
 28b:	83 f0 1f             	xor    eax,0x1f
 28e:	83 c0 20             	add    eax,0x20
 291:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				k = lz1 - lz2;
 294:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
 297:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
 29a:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				y = (y << k);
 29d:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 2a0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 2a3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 2a6:	0f a5 c2             	shld   edx,eax,cl
 2a9:	d3 e0                	shl    eax,cl
 2ab:	f6 c1 20             	test   cl,0x20
 2ae:	74 04                	je     2b4 <__udivdi3+0xd3>
 2b0:	89 c2                	mov    edx,eax
 2b2:	31 c0                	xor    eax,eax
 2b4:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 2b7:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (r >= y)
 2ba:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 2bd:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 2c0:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
 2c3:	89 d0                	mov    eax,edx
 2c5:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
 2c8:	72 2d                	jb     2f7 <__udivdi3+0x116>
						r = r - y;
 2ca:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 2cd:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 2d0:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
 2d3:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						q =  (1ULL << k);
 2d6:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 2d9:	b8 01 00 00 00       	mov    eax,0x1
 2de:	ba 00 00 00 00       	mov    edx,0x0
 2e3:	0f a5 c2             	shld   edx,eax,cl
 2e6:	d3 e0                	shl    eax,cl
 2e8:	f6 c1 20             	test   cl,0x20
 2eb:	74 04                	je     2f1 <__udivdi3+0x110>
 2ed:	89 c2                	mov    edx,eax
 2ef:	31 c0                	xor    eax,eax
 2f1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
 2f4:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (k > 0)
 2f7:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
 2fb:	0f 84 a6 00 00 00    	je     3a7 <__udivdi3+0x1c6>
						y = y >> 1;
 301:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 304:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 307:	0f ac d0 01          	shrd   eax,edx,0x1
 30b:	d1 ea                	shr    edx,1
 30d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 310:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						i = k;
 313:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
 316:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								if (r >= y)
 319:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 31c:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 31f:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 322:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
 325:	19 d1                	sbb    ecx,edx
 327:	72 1e                	jb     347 <__udivdi3+0x166>
										r = ((r - y) << 1) + 1;
 329:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 32c:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 32f:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
 332:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
 335:	01 c0                	add    eax,eax
 337:	11 d2                	adc    edx,edx
 339:	83 c0 01             	add    eax,0x1
 33c:	83 d2 00             	adc    edx,0x0
 33f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 342:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
 345:	eb 10                	jmp    357 <__udivdi3+0x176>
										r =  (r << 1);
 347:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 34a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 34d:	01 c0                	add    eax,eax
 34f:	11 d2                	adc    edx,edx
 351:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 354:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
								i = i - 1;
 357:	83 6d c0 01          	sub    DWORD PTR [ebp-0x40],0x1
						} while (i != 0);
 35b:	83 7d c0 00          	cmp    DWORD PTR [ebp-0x40],0x0
 35f:	75 b8                	jne    319 <__udivdi3+0x138>
						q = q + r;
 361:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 364:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 367:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
 36a:	11 55 e4             	adc    DWORD PTR [ebp-0x1c],edx
						r = r >> k;
 36d:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 370:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 373:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 376:	0f ad d0             	shrd   eax,edx,cl
 379:	d3 ea                	shr    edx,cl
 37b:	f6 c1 20             	test   cl,0x20
 37e:	74 04                	je     384 <__udivdi3+0x1a3>
 380:	89 d0                	mov    eax,edx
 382:	31 d2                	xor    edx,edx
 384:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 387:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
						q = q - (r << k);
 38a:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 38d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 390:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 393:	0f a5 c2             	shld   edx,eax,cl
 396:	d3 e0                	shl    eax,cl
 398:	f6 c1 20             	test   cl,0x20
 39b:	74 04                	je     3a1 <__udivdi3+0x1c0>
 39d:	89 c2                	mov    edx,eax
 39f:	31 c0                	xor    eax,eax
 3a1:	29 45 e0             	sub    DWORD PTR [ebp-0x20],eax
 3a4:	19 55 e4             	sbb    DWORD PTR [ebp-0x1c],edx
		if (rp)
 3a7:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 3ab:	74 0e                	je     3bb <__udivdi3+0x1da>
				*rp = r;
 3ad:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
 3b0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 3b3:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 3b6:	89 01                	mov    DWORD PTR [ecx],eax
 3b8:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return q;
 3bb:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 3be:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
		return __udivmoddi4 (n, d, (UDWtype *) 0);
}
 3c1:	c9                   	leave
 3c2:	c3                   	ret

000003c3 <__moddi3>:

DWtype
__moddi3 (DWtype u, DWtype v)
{
 3c3:	55                   	push   ebp
 3c4:	89 e5                	mov    ebp,esp
 3c6:	53                   	push   ebx
 3c7:	83 ec 74             	sub    esp,0x74
 3ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 3cd:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
 3d0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 3d3:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
 3d6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 3d9:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
 3dc:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 3df:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		Wtype c = 0;
 3e2:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		DWunion uu = {.ll = u};
 3e9:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
 3ec:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
 3ef:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
 3f2:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
		DWunion vv = {.ll = v};
 3f5:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
 3f8:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
 3fb:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
 3fe:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		DWtype w;
	
		if (uu.s.high < 0)
 401:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
 404:	85 c0                	test   eax,eax
 406:	79 16                	jns    41e <__moddi3+0x5b>
				c = ~c,
 408:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
					uu.ll = -uu.ll;
 40b:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
 40e:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
 411:	f7 d8                	neg    eax
 413:	83 d2 00             	adc    edx,0x0
 416:	f7 da                	neg    edx
 418:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
 41b:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
		if (vv.s.high < 0)
 41e:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
 421:	85 c0                	test   eax,eax
 423:	79 13                	jns    438 <__moddi3+0x75>
				vv.ll = -vv.ll;
 425:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
 428:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
 42b:	f7 d8                	neg    eax
 42d:	83 d2 00             	adc    edx,0x0
 430:	f7 da                	neg    edx
 432:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
 435:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
	
		(void) __udivmoddi4 (uu.ll, vv.ll, (UDWtype*)&w);
 438:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
 43b:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
 43e:	89 c1                	mov    ecx,eax
 440:	89 d3                	mov    ebx,edx
 442:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
 445:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
 448:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 44b:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
 44e:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 451:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 454:	8d 45 98             	lea    eax,[ebp-0x68]
 457:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		UDWtype q = 0, r = n, y = d;
 45a:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
 461:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
 468:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 46b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 46e:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 471:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
 474:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 477:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 47a:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 47d:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
		if (y <= r)
 480:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 483:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 486:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
 489:	89 d0                	mov    eax,edx
 48b:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
 48e:	0f 82 4f 01 00 00    	jb     5e3 <__moddi3+0x220>
				lz1 = __builtin_clzll (d);
 494:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 497:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 49a:	85 d2                	test   edx,edx
 49c:	74 08                	je     4a6 <__moddi3+0xe3>
 49e:	0f bd c2             	bsr    eax,edx
 4a1:	83 f0 1f             	xor    eax,0x1f
 4a4:	eb 09                	jmp    4af <__moddi3+0xec>
 4a6:	0f bd c0             	bsr    eax,eax
 4a9:	83 f0 1f             	xor    eax,0x1f
 4ac:	83 c0 20             	add    eax,0x20
 4af:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				lz2 = __builtin_clzll (n);
 4b2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 4b5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 4b8:	85 d2                	test   edx,edx
 4ba:	74 08                	je     4c4 <__moddi3+0x101>
 4bc:	0f bd c2             	bsr    eax,edx
 4bf:	83 f0 1f             	xor    eax,0x1f
 4c2:	eb 09                	jmp    4cd <__moddi3+0x10a>
 4c4:	0f bd c0             	bsr    eax,eax
 4c7:	83 f0 1f             	xor    eax,0x1f
 4ca:	83 c0 20             	add    eax,0x20
 4cd:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				k = lz1 - lz2;
 4d0:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 4d3:	2b 45 b8             	sub    eax,DWORD PTR [ebp-0x48]
 4d6:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				y = (y << k);
 4d9:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
 4dc:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 4df:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 4e2:	0f a5 c2             	shld   edx,eax,cl
 4e5:	d3 e0                	shl    eax,cl
 4e7:	f6 c1 20             	test   cl,0x20
 4ea:	74 04                	je     4f0 <__moddi3+0x12d>
 4ec:	89 c2                	mov    edx,eax
 4ee:	31 c0                	xor    eax,eax
 4f0:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 4f3:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
				if (r >= y)
 4f6:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 4f9:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 4fc:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
 4ff:	89 d0                	mov    eax,edx
 501:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
 504:	72 2d                	jb     533 <__moddi3+0x170>
						r = r - y;
 506:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 509:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 50c:	29 45 c8             	sub    DWORD PTR [ebp-0x38],eax
 50f:	19 55 cc             	sbb    DWORD PTR [ebp-0x34],edx
						q =  (1ULL << k);
 512:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
 515:	b8 01 00 00 00       	mov    eax,0x1
 51a:	ba 00 00 00 00       	mov    edx,0x0
 51f:	0f a5 c2             	shld   edx,eax,cl
 522:	d3 e0                	shl    eax,cl
 524:	f6 c1 20             	test   cl,0x20
 527:	74 04                	je     52d <__moddi3+0x16a>
 529:	89 c2                	mov    edx,eax
 52b:	31 c0                	xor    eax,eax
 52d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 530:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				if (k > 0)
 533:	83 7d b4 00          	cmp    DWORD PTR [ebp-0x4c],0x0
 537:	0f 84 a6 00 00 00    	je     5e3 <__moddi3+0x220>
						y = y >> 1;
 53d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 540:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 543:	0f ac d0 01          	shrd   eax,edx,0x1
 547:	d1 ea                	shr    edx,1
 549:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 54c:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
						i = k;
 54f:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
 552:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								if (r >= y)
 555:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 558:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 55b:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
 55e:	39 45 c8             	cmp    DWORD PTR [ebp-0x38],eax
 561:	19 d1                	sbb    ecx,edx
 563:	72 1e                	jb     583 <__moddi3+0x1c0>
										r = ((r - y) << 1) + 1;
 565:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 568:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 56b:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
 56e:	1b 55 c4             	sbb    edx,DWORD PTR [ebp-0x3c]
 571:	01 c0                	add    eax,eax
 573:	11 d2                	adc    edx,edx
 575:	83 c0 01             	add    eax,0x1
 578:	83 d2 00             	adc    edx,0x0
 57b:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 57e:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
 581:	eb 10                	jmp    593 <__moddi3+0x1d0>
										r =  (r << 1);
 583:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 586:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 589:	01 c0                	add    eax,eax
 58b:	11 d2                	adc    edx,edx
 58d:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 590:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
								i = i - 1;
 593:	83 6d b0 01          	sub    DWORD PTR [ebp-0x50],0x1
						} while (i != 0);
 597:	83 7d b0 00          	cmp    DWORD PTR [ebp-0x50],0x0
 59b:	75 b8                	jne    555 <__moddi3+0x192>
						q = q + r;
 59d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 5a0:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 5a3:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
 5a6:	11 55 d4             	adc    DWORD PTR [ebp-0x2c],edx
						r = r >> k;
 5a9:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
 5ac:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 5af:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 5b2:	0f ad d0             	shrd   eax,edx,cl
 5b5:	d3 ea                	shr    edx,cl
 5b7:	f6 c1 20             	test   cl,0x20
 5ba:	74 04                	je     5c0 <__moddi3+0x1fd>
 5bc:	89 d0                	mov    eax,edx
 5be:	31 d2                	xor    edx,edx
 5c0:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 5c3:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						q = q - (r << k);
 5c6:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
 5c9:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 5cc:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 5cf:	0f a5 c2             	shld   edx,eax,cl
 5d2:	d3 e0                	shl    eax,cl
 5d4:	f6 c1 20             	test   cl,0x20
 5d7:	74 04                	je     5dd <__moddi3+0x21a>
 5d9:	89 c2                	mov    edx,eax
 5db:	31 c0                	xor    eax,eax
 5dd:	29 45 d0             	sub    DWORD PTR [ebp-0x30],eax
 5e0:	19 55 d4             	sbb    DWORD PTR [ebp-0x2c],edx
		if (rp)
 5e3:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 5e7:	74 0e                	je     5f7 <__moddi3+0x234>
				*rp = r;
 5e9:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 5ec:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 5ef:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 5f2:	89 01                	mov    DWORD PTR [ecx],eax
 5f4:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		if (c)
 5f7:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 5fb:	74 13                	je     610 <__moddi3+0x24d>
				w = -w;
 5fd:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
 600:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
 603:	f7 d8                	neg    eax
 605:	83 d2 00             	adc    edx,0x0
 608:	f7 da                	neg    edx
 60a:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
 60d:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
	
		return w;
 610:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
 613:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
}
 616:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 619:	c9                   	leave
 61a:	c3                   	ret

0000061b <__divdi3>:

DWtype
__divdi3 (DWtype u, DWtype v)
{
 61b:	55                   	push   ebp
 61c:	89 e5                	mov    ebp,esp
 61e:	53                   	push   ebx
 61f:	83 ec 74             	sub    esp,0x74
 622:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 625:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
 628:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 62b:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
 62e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 631:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
 634:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 637:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		Wtype c = 0;
 63a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		DWunion uu = {.ll = u};
 641:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
 644:	8b 55 94             	mov    edx,DWORD PTR [ebp-0x6c]
 647:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
 64a:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		DWunion vv = {.ll = v};
 64d:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
 650:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
 653:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
 656:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
		DWtype w;
	
		if (uu.s.high < 0)
 659:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
 65c:	85 c0                	test   eax,eax
 65e:	79 16                	jns    676 <__divdi3+0x5b>
				c = ~c,
 660:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
				  uu.ll = -uu.ll;
 663:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
 666:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
 669:	f7 d8                	neg    eax
 66b:	83 d2 00             	adc    edx,0x0
 66e:	f7 da                	neg    edx
 670:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
 673:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		if (vv.s.high < 0)
 676:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
 679:	85 c0                	test   eax,eax
 67b:	79 16                	jns    693 <__divdi3+0x78>
				c = ~c,
 67d:	f7 55 f4             	not    DWORD PTR [ebp-0xc]
				  vv.ll = -vv.ll;
 680:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
 683:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
 686:	f7 d8                	neg    eax
 688:	83 d2 00             	adc    edx,0x0
 68b:	f7 da                	neg    edx
 68d:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
 690:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
	
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
 693:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
 696:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
 699:	89 c1                	mov    ecx,eax
 69b:	89 d3                	mov    ebx,edx
 69d:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
 6a0:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
 6a3:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
 6a6:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
 6a9:	89 4d d8             	mov    DWORD PTR [ebp-0x28],ecx
 6ac:	89 5d dc             	mov    DWORD PTR [ebp-0x24],ebx
 6af:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		UDWtype q = 0, r = n, y = d;
 6b6:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
 6bd:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
 6c4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6c7:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 6ca:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 6cd:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
 6d0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 6d3:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 6d6:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
 6d9:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
		if (y <= r)
 6dc:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 6df:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 6e2:	3b 45 b8             	cmp    eax,DWORD PTR [ebp-0x48]
 6e5:	89 d0                	mov    eax,edx
 6e7:	1b 45 bc             	sbb    eax,DWORD PTR [ebp-0x44]
 6ea:	0f 82 4f 01 00 00    	jb     83f <__divdi3+0x224>
				lz1 = __builtin_clzll (d);
 6f0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 6f3:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 6f6:	85 d2                	test   edx,edx
 6f8:	74 08                	je     702 <__divdi3+0xe7>
 6fa:	0f bd c2             	bsr    eax,edx
 6fd:	83 f0 1f             	xor    eax,0x1f
 700:	eb 09                	jmp    70b <__divdi3+0xf0>
 702:	0f bd c0             	bsr    eax,eax
 705:	83 f0 1f             	xor    eax,0x1f
 708:	83 c0 20             	add    eax,0x20
 70b:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				lz2 = __builtin_clzll (n);
 70e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 711:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 714:	85 d2                	test   edx,edx
 716:	74 08                	je     720 <__divdi3+0x105>
 718:	0f bd c2             	bsr    eax,edx
 71b:	83 f0 1f             	xor    eax,0x1f
 71e:	eb 09                	jmp    729 <__divdi3+0x10e>
 720:	0f bd c0             	bsr    eax,eax
 723:	83 f0 1f             	xor    eax,0x1f
 726:	83 c0 20             	add    eax,0x20
 729:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
				k = lz1 - lz2;
 72c:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
 72f:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
 732:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
				y = (y << k);
 735:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
 738:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
 73b:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 73e:	0f a5 c2             	shld   edx,eax,cl
 741:	d3 e0                	shl    eax,cl
 743:	f6 c1 20             	test   cl,0x20
 746:	74 04                	je     74c <__divdi3+0x131>
 748:	89 c2                	mov    edx,eax
 74a:	31 c0                	xor    eax,eax
 74c:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
 74f:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
				if (r >= y)
 752:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 755:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 758:	3b 45 b8             	cmp    eax,DWORD PTR [ebp-0x48]
 75b:	89 d0                	mov    eax,edx
 75d:	1b 45 bc             	sbb    eax,DWORD PTR [ebp-0x44]
 760:	72 2d                	jb     78f <__divdi3+0x174>
						r = r - y;
 762:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
 765:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 768:	29 45 c0             	sub    DWORD PTR [ebp-0x40],eax
 76b:	19 55 c4             	sbb    DWORD PTR [ebp-0x3c],edx
						q =  (1ULL << k);
 76e:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
 771:	b8 01 00 00 00       	mov    eax,0x1
 776:	ba 00 00 00 00       	mov    edx,0x0
 77b:	0f a5 c2             	shld   edx,eax,cl
 77e:	d3 e0                	shl    eax,cl
 780:	f6 c1 20             	test   cl,0x20
 783:	74 04                	je     789 <__divdi3+0x16e>
 785:	89 c2                	mov    edx,eax
 787:	31 c0                	xor    eax,eax
 789:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 78c:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (k > 0)
 78f:	83 7d ac 00          	cmp    DWORD PTR [ebp-0x54],0x0
 793:	0f 84 a6 00 00 00    	je     83f <__divdi3+0x224>
						y = y >> 1;
 799:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
 79c:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 79f:	0f ac d0 01          	shrd   eax,edx,0x1
 7a3:	d1 ea                	shr    edx,1
 7a5:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
 7a8:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
						i = k;
 7ab:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
 7ae:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
								if (r >= y)
 7b1:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
 7b4:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 7b7:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
 7ba:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
 7bd:	19 d1                	sbb    ecx,edx
 7bf:	72 1e                	jb     7df <__divdi3+0x1c4>
										r = ((r - y) << 1) + 1;
 7c1:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 7c4:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 7c7:	2b 45 b8             	sub    eax,DWORD PTR [ebp-0x48]
 7ca:	1b 55 bc             	sbb    edx,DWORD PTR [ebp-0x44]
 7cd:	01 c0                	add    eax,eax
 7cf:	11 d2                	adc    edx,edx
 7d1:	83 c0 01             	add    eax,0x1
 7d4:	83 d2 00             	adc    edx,0x0
 7d7:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 7da:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
 7dd:	eb 10                	jmp    7ef <__divdi3+0x1d4>
										r =  (r << 1);
 7df:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 7e2:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 7e5:	01 c0                	add    eax,eax
 7e7:	11 d2                	adc    edx,edx
 7e9:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 7ec:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								i = i - 1;
 7ef:	83 6d a8 01          	sub    DWORD PTR [ebp-0x58],0x1
						} while (i != 0);
 7f3:	83 7d a8 00          	cmp    DWORD PTR [ebp-0x58],0x0
 7f7:	75 b8                	jne    7b1 <__divdi3+0x196>
						q = q + r;
 7f9:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 7fc:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 7ff:	01 45 c8             	add    DWORD PTR [ebp-0x38],eax
 802:	11 55 cc             	adc    DWORD PTR [ebp-0x34],edx
						r = r >> k;
 805:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
 808:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 80b:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 80e:	0f ad d0             	shrd   eax,edx,cl
 811:	d3 ea                	shr    edx,cl
 813:	f6 c1 20             	test   cl,0x20
 816:	74 04                	je     81c <__divdi3+0x201>
 818:	89 d0                	mov    eax,edx
 81a:	31 d2                	xor    edx,edx
 81c:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 81f:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
						q = q - (r << k);
 822:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
 825:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 828:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 82b:	0f a5 c2             	shld   edx,eax,cl
 82e:	d3 e0                	shl    eax,cl
 830:	f6 c1 20             	test   cl,0x20
 833:	74 04                	je     839 <__divdi3+0x21e>
 835:	89 c2                	mov    edx,eax
 837:	31 c0                	xor    eax,eax
 839:	29 45 c8             	sub    DWORD PTR [ebp-0x38],eax
 83c:	19 55 cc             	sbb    DWORD PTR [ebp-0x34],edx
		if (rp)
 83f:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
 843:	74 0e                	je     853 <__divdi3+0x238>
				*rp = r;
 845:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
 848:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 84b:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 84e:	89 01                	mov    DWORD PTR [ecx],eax
 850:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return q;
 853:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
 856:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
		w = __udivmoddi4 (uu.ll, vv.ll, (UDWtype *) 0);
 859:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 85c:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (c)
 85f:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 863:	74 0a                	je     86f <__divdi3+0x254>
				w = -w;
 865:	f7 5d e8             	neg    DWORD PTR [ebp-0x18]
 868:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0
 86c:	f7 5d ec             	neg    DWORD PTR [ebp-0x14]
	
		return w;
 86f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 872:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
}
 875:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 878:	c9                   	leave
 879:	c3                   	ret
