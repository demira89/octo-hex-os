
vga_mode.o:     file format elf32-i386


Disassembly of section .text:

00000000 <call_int16>:
void* vga_pmem = (void*)0xb8000;
size_t vga_pmem_size = 0x8000; /* b8000-c0000 color TM */
const char* vga_font = NULL;

char call_int16(uint16_t ax)
{
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 18             	sub    esp,0x18
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
		extern void rm_int16();
		extern uint16_t vga_ax;
		extern uint16_t vga_rv;
		vga_ax = ax;
       d:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
      11:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		rm_int16();
      17:	e8 fc ff ff ff       	call   18 <call_int16+0x18>
		return (vga_rv & 0xff);
      1c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
}
      23:	c9                   	leave
      24:	c3                   	ret

00000025 <call_int15>:

void call_int15(uint32_t mus)
{
      25:	55                   	push   ebp
      26:	89 e5                	mov    ebp,esp
      28:	83 ec 08             	sub    esp,0x8
		extern void rm_int15();
		extern uint16_t vga_cx;
		extern uint16_t vga_dx;
		vga_dx = mus & 0xffff;
      2b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      2e:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		vga_cx = mus >> 16;
      34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      37:	c1 e8 10             	shr    eax,0x10
      3a:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		rm_int15();
      40:	e8 fc ff ff ff       	call   41 <call_int15+0x1c>
}
      45:	90                   	nop
      46:	c9                   	leave
      47:	c3                   	ret

00000048 <call_vga_int10>:

uint16_t call_vga_int10(uint16_t func, uint16_t sel, void* buf, uint16_t* bcd_regs)
{
      48:	55                   	push   ebp
      49:	89 e5                	mov    ebp,esp
      4b:	83 ec 18             	sub    esp,0x18
      4e:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      51:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      54:	66 89 55 f4          	mov    WORD PTR [ebp-0xc],dx
      58:	66 89 45 f0          	mov    WORD PTR [ebp-0x10],ax
		extern uint16_t vga_di;
		extern uint16_t vga_rv;
		extern uint16_t vga_rv2;
		extern uint16_t vga_rv3;
		extern uint16_t vga_rv4;
		if ((size_t)buf > 0x100000)
      5c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      5f:	3d 00 00 10 00       	cmp    eax,0x100000
      64:	76 0a                	jbe    70 <call_vga_int10+0x28>
				return -1;
      66:	b8 ff ff ff ff       	mov    eax,0xffffffff
      6b:	e9 bc 00 00 00       	jmp    12c <call_vga_int10+0xe4>
		vga_es = (size_t)buf / 0x10;
      70:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      73:	c1 e8 04             	shr    eax,0x4
      76:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		vga_di = (size_t)buf % 0x10;
      7c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      7f:	83 e0 0f             	and    eax,0xf
      82:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		vga_ax = func;
      88:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
      8c:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		vga_cx = sel;
      92:	0f b7 45 f0          	movzx  eax,WORD PTR [ebp-0x10]
      96:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		if (bcd_regs) {
      9c:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
      a0:	74 26                	je     c8 <call_vga_int10+0x80>
				vga_bx = bcd_regs[0];
      a2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      a5:	0f b7 00             	movzx  eax,WORD PTR [eax]
      a8:	66 a3 00 00 00 00    	mov    ds:0x0,ax
				vga_cx = bcd_regs[1];
      ae:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      b1:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
      b5:	66 a3 00 00 00 00    	mov    ds:0x0,ax
				vga_dx = bcd_regs[2];
      bb:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      be:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
      c2:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		}
		rm_vga_int10();
      c8:	e8 fc ff ff ff       	call   c9 <call_vga_int10+0x81>
		if (bcd_regs) {
      cd:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
      d1:	74 52                	je     125 <call_vga_int10+0xdd>
				bcd_regs[0] = vga_rv2;
      d3:	0f b7 15 00 00 00 00 	movzx  edx,WORD PTR ds:0x0
      da:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      dd:	66 89 10             	mov    WORD PTR [eax],dx
				bcd_regs[1] = vga_rv3;
      e0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      e3:	8d 50 02             	lea    edx,[eax+0x2]
      e6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
      ed:	66 89 02             	mov    WORD PTR [edx],ax
				bcd_regs[2] = vga_rv4;
      f0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      f3:	8d 50 04             	lea    edx,[eax+0x4]
      f6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
      fd:	66 89 02             	mov    WORD PTR [edx],ax
				if (func == 0x1130) {
     100:	66 81 7d f4 30 11    	cmp    WORD PTR [ebp-0xc],0x1130
     106:	75 1d                	jne    125 <call_vga_int10+0xdd>
						bcd_regs[0] = vga_es;
     108:	0f b7 15 00 00 00 00 	movzx  edx,WORD PTR ds:0x0
     10f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     112:	66 89 10             	mov    WORD PTR [eax],dx
						bcd_regs[1] = vga_bp;
     115:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     118:	8d 50 02             	lea    edx,[eax+0x2]
     11b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
     122:	66 89 02             	mov    WORD PTR [edx],ax
				}
		}
		return vga_rv;
     125:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
}
     12c:	c9                   	leave
     12d:	c3                   	ret

0000012e <draw_vga>:
//#endif

#define yesno(q) ((q)?("yes"):("no "))

void draw_vga(void* ptr, const char* fnt, struct vbe_modeinfo* mi)
{
     12e:	55                   	push   ebp
     12f:	89 e5                	mov    ebp,esp
     131:	83 ec 50             	sub    esp,0x50
		size_t i, j, k, l;
		const char* str[8] = {"!!!!##12_.,!", "Hello World!",
     134:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
     13b:	c7 45 c0 0d 00 00 00 	mov    DWORD PTR [ebp-0x40],0xd
     142:	c7 45 c4 1a 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x1a
     149:	c7 45 c8 24 00 00 00 	mov    DWORD PTR [ebp-0x38],0x24
     150:	c7 45 cc 2d 00 00 00 	mov    DWORD PTR [ebp-0x34],0x2d
     157:	c7 45 d0 3a 00 00 00 	mov    DWORD PTR [ebp-0x30],0x3a
     15e:	c7 45 d4 3f 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x3f
     165:	c7 45 d8 4b 00 00 00 	mov    DWORD PTR [ebp-0x28],0x4b
		"123456789", "ANTIDOTE", "\"§$%&/&/()=", "\t\b\023\001", "Aoijb9erh45", "ZT  iojwe =====+"};
		const char* cr;
		for (l = 0; l < 8; l++) {
     16c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     173:	e9 78 01 00 00       	jmp    2f0 <draw_vga+0x1c2>
				void* mem = ptr + l * 16 * mi->bpsl_lm;
     178:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     17b:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     17f:	0f b7 c0             	movzx  eax,ax
     182:	0f af 45 f0          	imul   eax,DWORD PTR [ebp-0x10]
     186:	c1 e0 04             	shl    eax,0x4
     189:	89 c2                	mov    edx,eax
     18b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     18e:	01 d0                	add    eax,edx
     190:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				for (i = 0; i < 16; i++) {
     193:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     19a:	e9 43 01 00 00       	jmp    2e2 <draw_vga+0x1b4>
						void* mp = mem + i * mi->bpsl_lm;
     19f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     1a2:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     1a6:	0f b7 c0             	movzx  eax,ax
     1a9:	0f af 45 fc          	imul   eax,DWORD PTR [ebp-0x4]
     1ad:	89 c2                	mov    edx,eax
     1af:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     1b2:	01 d0                	add    eax,edx
     1b4:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						const char* s2 = str[l];
     1b7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1ba:	8b 44 85 bc          	mov    eax,DWORD PTR [ebp+eax*4-0x44]
     1be:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						for (k = 0; k < mi->bpsl_lm * 8 / 8 / mi->btpp; k++) {
     1c1:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     1c8:	e9 ee 00 00 00       	jmp    2bb <draw_vga+0x18d>
								if (!*s2)
     1cd:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     1d0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     1d3:	84 c0                	test   al,al
     1d5:	0f 84 02 01 00 00    	je     2dd <draw_vga+0x1af>
										break;
								cr = fnt + ((uint32_t)*(uint8_t*)s2 * 16);
     1db:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     1de:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     1e1:	0f b6 c0             	movzx  eax,al
     1e4:	c1 e0 04             	shl    eax,0x4
     1e7:	89 c2                	mov    edx,eax
     1e9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1ec:	01 d0                	add    eax,edx
     1ee:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								s2++;
     1f1:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
								for (j = 0; j < 8; j++) {
     1f5:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
     1fc:	e9 ac 00 00 00       	jmp    2ad <draw_vga+0x17f>
										/* put up to 8 white pixels */
										int set = ((cr[i] & (1 << (7 - j))) != 0);
     201:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     204:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     207:	01 d0                	add    eax,edx
     209:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     20c:	0f be d0             	movsx  edx,al
     20f:	b8 07 00 00 00       	mov    eax,0x7
     214:	2b 45 f8             	sub    eax,DWORD PTR [ebp-0x8]
     217:	89 c1                	mov    ecx,eax
     219:	d3 fa                	sar    edx,cl
     21b:	89 d0                	mov    eax,edx
     21d:	83 e0 01             	and    eax,0x1
     220:	85 c0                	test   eax,eax
     222:	0f 95 c0             	setne  al
     225:	0f b6 c0             	movzx  eax,al
     228:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
										if (mi->btpp == 16) {
     22b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     22e:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     232:	3c 10                	cmp    al,0x10
     234:	75 14                	jne    24a <draw_vga+0x11c>
												if (set)
     236:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     23a:	74 08                	je     244 <draw_vga+0x116>
														*(uint16_t*)mp = 0xffff;
     23c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     23f:	66 c7 00 ff ff       	mov    WORD PTR [eax],0xffff
												//else
												//		*(uint16_t*)mp = 0x0000;
												mp += 2;
     244:	83 45 ec 02          	add    DWORD PTR [ebp-0x14],0x2
     248:	eb 5f                	jmp    2a9 <draw_vga+0x17b>
										} else if (mi->btpp == 24) {
     24a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     24d:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     251:	3c 18                	cmp    al,0x18
     253:	75 24                	jne    279 <draw_vga+0x14b>
												if (set)
     255:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     259:	74 08                	je     263 <draw_vga+0x135>
														*(uint16_t*)mp = 0xffff;
     25b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     25e:	66 c7 00 ff ff       	mov    WORD PTR [eax],0xffff
												//else
												//		*(uint16_t*)mp = 0x0000;
												mp += 2;
     263:	83 45 ec 02          	add    DWORD PTR [ebp-0x14],0x2
												if (set)
     267:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     26b:	74 06                	je     273 <draw_vga+0x145>
														*(uint8_t*)mp = 0xff;
     26d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     270:	c6 00 ff             	mov    BYTE PTR [eax],0xff
												//else
												//		*(uint8_t*)mp = 0x00;
												mp++;
     273:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     277:	eb 30                	jmp    2a9 <draw_vga+0x17b>
										} else if (mi->btpp == 32) {
     279:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     27c:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     280:	3c 20                	cmp    al,0x20
     282:	75 15                	jne    299 <draw_vga+0x16b>
												if (set)
     284:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     288:	74 09                	je     293 <draw_vga+0x165>
														*(uint32_t*)mp = 0x00ffffff;
     28a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     28d:	c7 00 ff ff ff 00    	mov    DWORD PTR [eax],0xffffff
												//else
												//		*(uint32_t*)mp = 0x00000000;
												mp += 4;
     293:	83 45 ec 04          	add    DWORD PTR [ebp-0x14],0x4
     297:	eb 10                	jmp    2a9 <draw_vga+0x17b>
										} else { /* 8 or other */
												if (set)
     299:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     29d:	74 06                	je     2a5 <draw_vga+0x177>
														*(uint8_t*)mp = 0x0f;
     29f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     2a2:	c6 00 0f             	mov    BYTE PTR [eax],0xf
												//else
												//		*(uint8_t*)mp = 0xf0;
												mp++;
     2a5:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
								for (j = 0; j < 8; j++) {
     2a9:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
     2ad:	83 7d f8 07          	cmp    DWORD PTR [ebp-0x8],0x7
     2b1:	0f 86 4a ff ff ff    	jbe    201 <draw_vga+0xd3>
						for (k = 0; k < mi->bpsl_lm * 8 / 8 / mi->btpp; k++) {
     2b7:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     2bb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2be:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     2c2:	0f b7 c0             	movzx  eax,ax
     2c5:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     2c8:	0f b6 52 19          	movzx  edx,BYTE PTR [edx+0x19]
     2cc:	0f b6 ca             	movzx  ecx,dl
     2cf:	99                   	cdq
     2d0:	f7 f9                	idiv   ecx
     2d2:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
     2d5:	0f 82 f2 fe ff ff    	jb     1cd <draw_vga+0x9f>
     2db:	eb 01                	jmp    2de <draw_vga+0x1b0>
										break;
     2dd:	90                   	nop
				for (i = 0; i < 16; i++) {
     2de:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     2e2:	83 7d fc 0f          	cmp    DWORD PTR [ebp-0x4],0xf
     2e6:	0f 86 b3 fe ff ff    	jbe    19f <draw_vga+0x71>
		for (l = 0; l < 8; l++) {
     2ec:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     2f0:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
     2f4:	0f 86 7e fe ff ff    	jbe    178 <draw_vga+0x4a>
										}
								}
						}
				}
		}
}
     2fa:	90                   	nop
     2fb:	90                   	nop
     2fc:	c9                   	leave
     2fd:	c3                   	ret

000002fe <vga_list_modes>:

int vga_list_modes(int base_num, uint16_t* ml, int test)
{
     2fe:	55                   	push   ebp
     2ff:	89 e5                	mov    ebp,esp
     301:	53                   	push   ebx
     302:	81 ec 44 01 00 00    	sub    esp,0x144
		int ct = base_num, ln = 0; char *font, *txt; uint16_t r0[3];
     308:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     30b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     30e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!ml) {
     315:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     319:	75 1a                	jne    335 <vga_list_modes+0x37>
				puts("none");
     31b:	83 ec 0c             	sub    esp,0xc
     31e:	68 5c 00 00 00       	push   0x5c
     323:	e8 fc ff ff ff       	call   324 <vga_list_modes+0x26>
     328:	83 c4 10             	add    esp,0x10
				return 0;
     32b:	b8 00 00 00 00       	mov    eax,0x0
     330:	e9 7b 07 00 00       	jmp    ab0 <vga_list_modes+0x7b2>
		}
		/* save the font (returns es:bp) (rm accessible stack) */
		r0[0] = 0x0600;
     335:	66 c7 45 ca 00 06    	mov    WORD PTR [ebp-0x36],0x600
		call_vga_int10(0x1130, 0, NULL, r0);
     33b:	8d 45 ca             	lea    eax,[ebp-0x36]
     33e:	50                   	push   eax
     33f:	6a 00                	push   0x0
     341:	6a 00                	push   0x0
     343:	68 30 11 00 00       	push   0x1130
     348:	e8 fc ff ff ff       	call   349 <vga_list_modes+0x4b>
     34d:	83 c4 10             	add    esp,0x10
		vga_font = font = (char*)(((uint32_t)r0[0] << 4) + (r0[1] & 0xffff));
     350:	0f b7 45 ca          	movzx  eax,WORD PTR [ebp-0x36]
     354:	0f b7 c0             	movzx  eax,ax
     357:	c1 e0 04             	shl    eax,0x4
     35a:	89 c2                	mov    edx,eax
     35c:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
     360:	0f b7 c0             	movzx  eax,ax
     363:	01 d0                	add    eax,edx
     365:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     368:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     36b:	a3 00 00 00 00       	mov    ds:0x0,eax
		/*memcpy(font, ft, 4096);*/
		if (test) {
     370:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     374:	74 1a                	je     390 <vga_list_modes+0x92>
				txt = FM_VGA_TEST;
     376:	c7 45 ec 00 00 05 00 	mov    DWORD PTR [ebp-0x14],0x50000
				bzero(txt, 8000);
     37d:	83 ec 08             	sub    esp,0x8
     380:	68 40 1f 00 00       	push   0x1f40
     385:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     388:	e8 fc ff ff ff       	call   389 <vga_list_modes+0x8b>
     38d:	83 c4 10             	add    esp,0x10
		}
		puts("NMBR VGA  WIDTHxHGT RGB TM  SUP LFB BPP BPSL");
     390:	83 ec 0c             	sub    esp,0xc
     393:	68 64 00 00 00       	push   0x64
     398:	e8 fc ff ff ff       	call   399 <vga_list_modes+0x9b>
     39d:	83 c4 10             	add    esp,0x10
		while (*ml != 0xffff) {
     3a0:	e9 dd 06 00 00       	jmp    a82 <vga_list_modes+0x784>
				char buf[256];
				bzero(buf, 256);
     3a5:	83 ec 08             	sub    esp,0x8
     3a8:	68 00 01 00 00       	push   0x100
     3ad:	8d 85 c4 fe ff ff    	lea    eax,[ebp-0x13c]
     3b3:	50                   	push   eax
     3b4:	e8 fc ff ff ff       	call   3b5 <vga_list_modes+0xb7>
     3b9:	83 c4 10             	add    esp,0x10
				if (call_vga_int10(0x4f01, *ml, buf, NULL) == 0x004f) {
     3bc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3bf:	0f b7 00             	movzx  eax,WORD PTR [eax]
     3c2:	0f b7 c0             	movzx  eax,ax
     3c5:	6a 00                	push   0x0
     3c7:	8d 95 c4 fe ff ff    	lea    edx,[ebp-0x13c]
     3cd:	52                   	push   edx
     3ce:	50                   	push   eax
     3cf:	68 01 4f 00 00       	push   0x4f01
     3d4:	e8 fc ff ff ff       	call   3d5 <vga_list_modes+0xd7>
     3d9:	83 c4 10             	add    esp,0x10
     3dc:	66 83 f8 4f          	cmp    ax,0x4f
     3e0:	0f 85 90 06 00 00    	jne    a76 <vga_list_modes+0x778>
						struct vbe_modeinfo* mi = (struct vbe_modeinfo*)buf;
     3e6:	8d 85 c4 fe ff ff    	lea    eax,[ebp-0x13c]
     3ec:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						nput32(ct++, 3);
     3ef:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3f2:	8d 50 01             	lea    edx,[eax+0x1]
     3f5:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     3f8:	83 ec 08             	sub    esp,0x8
     3fb:	6a 03                	push   0x3
     3fd:	50                   	push   eax
     3fe:	e8 fc ff ff ff       	call   3ff <vga_list_modes+0x101>
     403:	83 c4 10             	add    esp,0x10
						putstr(": ");
     406:	83 ec 0c             	sub    esp,0xc
     409:	68 91 00 00 00       	push   0x91
     40e:	e8 fc ff ff ff       	call   40f <vga_list_modes+0x111>
     413:	83 c4 10             	add    esp,0x10
						put16s(*ml);
     416:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     419:	0f b7 00             	movzx  eax,WORD PTR [eax]
     41c:	0f b7 c0             	movzx  eax,ax
     41f:	83 ec 0c             	sub    esp,0xc
     422:	50                   	push   eax
     423:	e8 fc ff ff ff       	call   424 <vga_list_modes+0x126>
     428:	83 c4 10             	add    esp,0x10
						nput32(mi->width, 4);
     42b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     42e:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
     432:	0f b7 c0             	movzx  eax,ax
     435:	83 ec 08             	sub    esp,0x8
     438:	6a 04                	push   0x4
     43a:	50                   	push   eax
     43b:	e8 fc ff ff ff       	call   43c <vga_list_modes+0x13e>
     440:	83 c4 10             	add    esp,0x10
						putstr("x");
     443:	83 ec 0c             	sub    esp,0xc
     446:	68 94 00 00 00       	push   0x94
     44b:	e8 fc ff ff ff       	call   44c <vga_list_modes+0x14e>
     450:	83 c4 10             	add    esp,0x10
						nput32(mi->height, -4);
     453:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     456:	0f b7 40 14          	movzx  eax,WORD PTR [eax+0x14]
     45a:	0f b7 c0             	movzx  eax,ax
     45d:	83 ec 08             	sub    esp,0x8
     460:	6a fc                	push   0xfffffffc
     462:	50                   	push   eax
     463:	e8 fc ff ff ff       	call   464 <vga_list_modes+0x166>
     468:	83 c4 10             	add    esp,0x10
						putstr(" ");
     46b:	83 ec 0c             	sub    esp,0xc
     46e:	68 96 00 00 00       	push   0x96
     473:	e8 fc ff ff ff       	call   474 <vga_list_modes+0x176>
     478:	83 c4 10             	add    esp,0x10
						nput32(mi->rdmsz, 0);
     47b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     47e:	0f b6 40 1f          	movzx  eax,BYTE PTR [eax+0x1f]
     482:	0f b6 c0             	movzx  eax,al
     485:	83 ec 08             	sub    esp,0x8
     488:	6a 00                	push   0x0
     48a:	50                   	push   eax
     48b:	e8 fc ff ff ff       	call   48c <vga_list_modes+0x18e>
     490:	83 c4 10             	add    esp,0x10
						nput32(mi->grmsz, 0);
     493:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     496:	0f b6 40 21          	movzx  eax,BYTE PTR [eax+0x21]
     49a:	0f b6 c0             	movzx  eax,al
     49d:	83 ec 08             	sub    esp,0x8
     4a0:	6a 00                	push   0x0
     4a2:	50                   	push   eax
     4a3:	e8 fc ff ff ff       	call   4a4 <vga_list_modes+0x1a6>
     4a8:	83 c4 10             	add    esp,0x10
						nput32(mi->blmsz, 0);
     4ab:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     4ae:	0f b6 40 23          	movzx  eax,BYTE PTR [eax+0x23]
     4b2:	0f b6 c0             	movzx  eax,al
     4b5:	83 ec 08             	sub    esp,0x8
     4b8:	6a 00                	push   0x0
     4ba:	50                   	push   eax
     4bb:	e8 fc ff ff ff       	call   4bc <vga_list_modes+0x1be>
     4c0:	83 c4 10             	add    esp,0x10
						putstr(" ");
     4c3:	83 ec 0c             	sub    esp,0xc
     4c6:	68 96 00 00 00       	push   0x96
     4cb:	e8 fc ff ff ff       	call   4cc <vga_list_modes+0x1ce>
     4d0:	83 c4 10             	add    esp,0x10
						putstr(yesno(!(mi->attr & 16)));
     4d3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     4d6:	0f b7 00             	movzx  eax,WORD PTR [eax]
     4d9:	0f b7 c0             	movzx  eax,ax
     4dc:	83 e0 10             	and    eax,0x10
     4df:	85 c0                	test   eax,eax
     4e1:	75 07                	jne    4ea <vga_list_modes+0x1ec>
     4e3:	b8 98 00 00 00       	mov    eax,0x98
     4e8:	eb 05                	jmp    4ef <vga_list_modes+0x1f1>
     4ea:	b8 9c 00 00 00       	mov    eax,0x9c
     4ef:	83 ec 0c             	sub    esp,0xc
     4f2:	50                   	push   eax
     4f3:	e8 fc ff ff ff       	call   4f4 <vga_list_modes+0x1f6>
     4f8:	83 c4 10             	add    esp,0x10
						putstr(" ");
     4fb:	83 ec 0c             	sub    esp,0xc
     4fe:	68 96 00 00 00       	push   0x96
     503:	e8 fc ff ff ff       	call   504 <vga_list_modes+0x206>
     508:	83 c4 10             	add    esp,0x10
						putstr(yesno(mi->attr & 1));
     50b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     50e:	0f b7 00             	movzx  eax,WORD PTR [eax]
     511:	0f b7 c0             	movzx  eax,ax
     514:	83 e0 01             	and    eax,0x1
     517:	85 c0                	test   eax,eax
     519:	74 07                	je     522 <vga_list_modes+0x224>
     51b:	b8 98 00 00 00       	mov    eax,0x98
     520:	eb 05                	jmp    527 <vga_list_modes+0x229>
     522:	b8 9c 00 00 00       	mov    eax,0x9c
     527:	83 ec 0c             	sub    esp,0xc
     52a:	50                   	push   eax
     52b:	e8 fc ff ff ff       	call   52c <vga_list_modes+0x22e>
     530:	83 c4 10             	add    esp,0x10
						putstr(" ");
     533:	83 ec 0c             	sub    esp,0xc
     536:	68 96 00 00 00       	push   0x96
     53b:	e8 fc ff ff ff       	call   53c <vga_list_modes+0x23e>
     540:	83 c4 10             	add    esp,0x10
						putstr(yesno(mi->attr & 128));
     543:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     546:	0f b7 00             	movzx  eax,WORD PTR [eax]
     549:	0f b7 c0             	movzx  eax,ax
     54c:	25 80 00 00 00       	and    eax,0x80
     551:	85 c0                	test   eax,eax
     553:	74 07                	je     55c <vga_list_modes+0x25e>
     555:	b8 98 00 00 00       	mov    eax,0x98
     55a:	eb 05                	jmp    561 <vga_list_modes+0x263>
     55c:	b8 9c 00 00 00       	mov    eax,0x9c
     561:	83 ec 0c             	sub    esp,0xc
     564:	50                   	push   eax
     565:	e8 fc ff ff ff       	call   566 <vga_list_modes+0x268>
     56a:	83 c4 10             	add    esp,0x10
						putstr(" ");
     56d:	83 ec 0c             	sub    esp,0xc
     570:	68 96 00 00 00       	push   0x96
     575:	e8 fc ff ff ff       	call   576 <vga_list_modes+0x278>
     57a:	83 c4 10             	add    esp,0x10
						nput32(mi->btpp, 3);
     57d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     580:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     584:	0f b6 c0             	movzx  eax,al
     587:	83 ec 08             	sub    esp,0x8
     58a:	6a 03                	push   0x3
     58c:	50                   	push   eax
     58d:	e8 fc ff ff ff       	call   58e <vga_list_modes+0x290>
     592:	83 c4 10             	add    esp,0x10
						putstr(" ");
     595:	83 ec 0c             	sub    esp,0xc
     598:	68 96 00 00 00       	push   0x96
     59d:	e8 fc ff ff ff       	call   59e <vga_list_modes+0x2a0>
     5a2:	83 c4 10             	add    esp,0x10
						nput32(mi->bpsl, 4);
     5a5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     5a8:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     5ac:	0f b7 c0             	movzx  eax,ax
     5af:	83 ec 08             	sub    esp,0x8
     5b2:	6a 04                	push   0x4
     5b4:	50                   	push   eax
     5b5:	e8 fc ff ff ff       	call   5b6 <vga_list_modes+0x2b8>
     5ba:	83 c4 10             	add    esp,0x10
						put_nl();
     5bd:	e8 fc ff ff ff       	call   5be <vga_list_modes+0x2c0>
						if (ct % 24 == 0) {
     5c2:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     5c5:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
     5ca:	89 c8                	mov    eax,ecx
     5cc:	f7 ea                	imul   edx
     5ce:	c1 fa 02             	sar    edx,0x2
     5d1:	89 c8                	mov    eax,ecx
     5d3:	c1 f8 1f             	sar    eax,0x1f
     5d6:	29 c2                	sub    edx,eax
     5d8:	89 d0                	mov    eax,edx
     5da:	01 c0                	add    eax,eax
     5dc:	01 d0                	add    eax,edx
     5de:	c1 e0 03             	shl    eax,0x3
     5e1:	29 c1                	sub    ecx,eax
     5e3:	89 ca                	mov    edx,ecx
     5e5:	85 d2                	test   edx,edx
     5e7:	75 32                	jne    61b <vga_list_modes+0x31d>
								/* pause for display */
								puts("--More--");
     5e9:	83 ec 0c             	sub    esp,0xc
     5ec:	68 a0 00 00 00       	push   0xa0
     5f1:	e8 fc ff ff ff       	call   5f2 <vga_list_modes+0x2f4>
     5f6:	83 c4 10             	add    esp,0x10
								call_int16(0);
     5f9:	83 ec 0c             	sub    esp,0xc
     5fc:	6a 00                	push   0x0
     5fe:	e8 fc ff ff ff       	call   5ff <vga_list_modes+0x301>
     603:	83 c4 10             	add    esp,0x10
								put_nl();
     606:	e8 fc ff ff ff       	call   607 <vga_list_modes+0x309>
								puts("NMBR VGA WIDTHxHGT RGB TM  SUP LFB BPP BPSL");
     60b:	83 ec 0c             	sub    esp,0xc
     60e:	68 ac 00 00 00       	push   0xac
     613:	e8 fc ff ff ff       	call   614 <vga_list_modes+0x316>
     618:	83 c4 10             	add    esp,0x10
						}
						if (test && (mi->attr & 128)) { /* test LFB only */
     61b:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     61f:	0f 84 59 04 00 00    	je     a7e <vga_list_modes+0x780>
     625:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     628:	0f b7 00             	movzx  eax,WORD PTR [eax]
     62b:	0f b7 c0             	movzx  eax,ax
     62e:	25 80 00 00 00       	and    eax,0x80
     633:	85 c0                	test   eax,eax
     635:	0f 84 43 04 00 00    	je     a7e <vga_list_modes+0x780>
								uint16_t regs[3] = {0, 0, 0};
     63b:	66 c7 45 c4 00 00    	mov    WORD PTR [ebp-0x3c],0x0
     641:	66 c7 45 c6 00 00    	mov    WORD PTR [ebp-0x3a],0x0
     647:	66 c7 45 c8 00 00    	mov    WORD PTR [ebp-0x38],0x0
								size_t i; void* mpt;
								/* save textmode text */
								mem_cpy(txt + ln * 160, (void*)0xb8000, 4000);
     64d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     650:	89 d0                	mov    eax,edx
     652:	c1 e0 02             	shl    eax,0x2
     655:	01 d0                	add    eax,edx
     657:	c1 e0 05             	shl    eax,0x5
     65a:	89 c2                	mov    edx,eax
     65c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     65f:	01 d0                	add    eax,edx
     661:	83 ec 04             	sub    esp,0x4
     664:	68 a0 0f 00 00       	push   0xfa0
     669:	68 00 80 0b 00       	push   0xb8000
     66e:	50                   	push   eax
     66f:	e8 fc ff ff ff       	call   670 <vga_list_modes+0x372>
     674:	83 c4 10             	add    esp,0x10
								if (ln++ == 4000) {
     677:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     67a:	8d 50 01             	lea    edx,[eax+0x1]
     67d:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
     680:	3d a0 0f 00 00       	cmp    eax,0xfa0
     685:	75 20                	jne    6a7 <vga_list_modes+0x3a9>
										mem_cpy(txt, txt + 160, 7840);
     687:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     68a:	05 a0 00 00 00       	add    eax,0xa0
     68f:	83 ec 04             	sub    esp,0x4
     692:	68 a0 1e 00 00       	push   0x1ea0
     697:	50                   	push   eax
     698:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     69b:	e8 fc ff ff ff       	call   69c <vga_list_modes+0x39e>
     6a0:	83 c4 10             	add    esp,0x10
										ln--;
     6a3:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1
								}
								/* display window info */
								putstr("window1 at ");
     6a7:	83 ec 0c             	sub    esp,0xc
     6aa:	68 d8 00 00 00       	push   0xd8
     6af:	e8 fc ff ff ff       	call   6b0 <vga_list_modes+0x3b2>
     6b4:	83 c4 10             	add    esp,0x10
								put32(mi->w1seg * 0x10);
     6b7:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     6ba:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
     6be:	0f b7 c0             	movzx  eax,ax
     6c1:	c1 e0 04             	shl    eax,0x4
     6c4:	83 ec 0c             	sub    esp,0xc
     6c7:	50                   	push   eax
     6c8:	e8 fc ff ff ff       	call   6c9 <vga_list_modes+0x3cb>
     6cd:	83 c4 10             	add    esp,0x10
								put_nl();
     6d0:	e8 fc ff ff ff       	call   6d1 <vga_list_modes+0x3d3>
								putstr("window2 at ");
     6d5:	83 ec 0c             	sub    esp,0xc
     6d8:	68 e4 00 00 00       	push   0xe4
     6dd:	e8 fc ff ff ff       	call   6de <vga_list_modes+0x3e0>
     6e2:	83 c4 10             	add    esp,0x10
								put32(mi->w2seg * 0x10);
     6e5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     6e8:	0f b7 40 0a          	movzx  eax,WORD PTR [eax+0xa]
     6ec:	0f b7 c0             	movzx  eax,ax
     6ef:	c1 e0 04             	shl    eax,0x4
     6f2:	83 ec 0c             	sub    esp,0xc
     6f5:	50                   	push   eax
     6f6:	e8 fc ff ff ff       	call   6f7 <vga_list_modes+0x3f9>
     6fb:	83 c4 10             	add    esp,0x10
								put_nl();
     6fe:	e8 fc ff ff ff       	call   6ff <vga_list_modes+0x401>
								putstr("window size: ");
     703:	83 ec 0c             	sub    esp,0xc
     706:	68 f0 00 00 00       	push   0xf0
     70b:	e8 fc ff ff ff       	call   70c <vga_list_modes+0x40e>
     710:	83 c4 10             	add    esp,0x10
								put32(mi->wsiz * 1024);
     713:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     716:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     71a:	0f b7 c0             	movzx  eax,ax
     71d:	c1 e0 0a             	shl    eax,0xa
     720:	83 ec 0c             	sub    esp,0xc
     723:	50                   	push   eax
     724:	e8 fc ff ff ff       	call   725 <vga_list_modes+0x427>
     729:	83 c4 10             	add    esp,0x10
								put_nl();
     72c:	e8 fc ff ff ff       	call   72d <vga_list_modes+0x42f>
								putstr("window granularity: ");
     731:	83 ec 0c             	sub    esp,0xc
     734:	68 fe 00 00 00       	push   0xfe
     739:	e8 fc ff ff ff       	call   73a <vga_list_modes+0x43c>
     73e:	83 c4 10             	add    esp,0x10
								put32(mi->wgran * 1024);
     741:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     744:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     748:	0f b7 c0             	movzx  eax,ax
     74b:	c1 e0 0a             	shl    eax,0xa
     74e:	83 ec 0c             	sub    esp,0xc
     751:	50                   	push   eax
     752:	e8 fc ff ff ff       	call   753 <vga_list_modes+0x455>
     757:	83 c4 10             	add    esp,0x10
								put_nl();
     75a:	e8 fc ff ff ff       	call   75b <vga_list_modes+0x45d>
								putstr("scrmsz: ");
     75f:	83 ec 0c             	sub    esp,0xc
     762:	68 13 01 00 00       	push   0x113
     767:	e8 fc ff ff ff       	call   768 <vga_list_modes+0x46a>
     76c:	83 c4 10             	add    esp,0x10
								nput32((uint32_t)mi->bpsl * (uint32_t)mi->height, 0);
     76f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     772:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     776:	0f b7 d0             	movzx  edx,ax
     779:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     77c:	0f b7 40 14          	movzx  eax,WORD PTR [eax+0x14]
     780:	0f b7 c0             	movzx  eax,ax
     783:	0f af c2             	imul   eax,edx
     786:	83 ec 08             	sub    esp,0x8
     789:	6a 00                	push   0x0
     78b:	50                   	push   eax
     78c:	e8 fc ff ff ff       	call   78d <vga_list_modes+0x48f>
     791:	83 c4 10             	add    esp,0x10
								put_nl();
     794:	e8 fc ff ff ff       	call   795 <vga_list_modes+0x497>
								putstr("scrmsz_l: ");
     799:	83 ec 0c             	sub    esp,0xc
     79c:	68 1c 01 00 00       	push   0x11c
     7a1:	e8 fc ff ff ff       	call   7a2 <vga_list_modes+0x4a4>
     7a6:	83 c4 10             	add    esp,0x10
								nput32((uint32_t)mi->bpsl_lm * (uint32_t)mi->height, 0);
     7a9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7ac:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     7b0:	0f b7 d0             	movzx  edx,ax
     7b3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7b6:	0f b7 40 14          	movzx  eax,WORD PTR [eax+0x14]
     7ba:	0f b7 c0             	movzx  eax,ax
     7bd:	0f af c2             	imul   eax,edx
     7c0:	83 ec 08             	sub    esp,0x8
     7c3:	6a 00                	push   0x0
     7c5:	50                   	push   eax
     7c6:	e8 fc ff ff ff       	call   7c7 <vga_list_modes+0x4c9>
     7cb:	83 c4 10             	add    esp,0x10
								put_nl();
     7ce:	e8 fc ff ff ff       	call   7cf <vga_list_modes+0x4d1>
								putstr("LFB at ");
     7d3:	83 ec 0c             	sub    esp,0xc
     7d6:	68 27 01 00 00       	push   0x127
     7db:	e8 fc ff ff ff       	call   7dc <vga_list_modes+0x4de>
     7e0:	83 c4 10             	add    esp,0x10
								put32((uint32_t)mi->plfb);
     7e3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7e6:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     7e9:	83 ec 0c             	sub    esp,0xc
     7ec:	50                   	push   eax
     7ed:	e8 fc ff ff ff       	call   7ee <vga_list_modes+0x4f0>
     7f2:	83 c4 10             	add    esp,0x10
								put_nl();
     7f5:	e8 fc ff ff ff       	call   7f6 <vga_list_modes+0x4f8>
								/* switch to mode */
								puts("switching mode...");
     7fa:	83 ec 0c             	sub    esp,0xc
     7fd:	68 2f 01 00 00       	push   0x12f
     802:	e8 fc ff ff ff       	call   803 <vga_list_modes+0x505>
     807:	83 c4 10             	add    esp,0x10
								call_int15(500000); // 500 ms
     80a:	83 ec 0c             	sub    esp,0xc
     80d:	68 20 a1 07 00       	push   0x7a120
     812:	e8 fc ff ff ff       	call   813 <vga_list_modes+0x515>
     817:	83 c4 10             	add    esp,0x10
								//for (i = 0; i < UINT_MAX / 8; i++);
								if (mi->attr & 128)
     81a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     81d:	0f b7 00             	movzx  eax,WORD PTR [eax]
     820:	0f b7 c0             	movzx  eax,ax
     823:	25 80 00 00 00       	and    eax,0x80
     828:	85 c0                	test   eax,eax
     82a:	74 0f                	je     83b <vga_list_modes+0x53d>
										regs[0] = *ml | 0x4000;
     82c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     82f:	0f b7 00             	movzx  eax,WORD PTR [eax]
     832:	80 cc 40             	or     ah,0x40
     835:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
     839:	eb 0a                	jmp    845 <vga_list_modes+0x547>
								else
										regs[0] = *ml;
     83b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     83e:	0f b7 00             	movzx  eax,WORD PTR [eax]
     841:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
								if (call_vga_int10(0x4f02, 0, NULL, regs) != 0x004f) {
     845:	8d 45 c4             	lea    eax,[ebp-0x3c]
     848:	50                   	push   eax
     849:	6a 00                	push   0x0
     84b:	6a 00                	push   0x0
     84d:	68 02 4f 00 00       	push   0x4f02
     852:	e8 fc ff ff ff       	call   853 <vga_list_modes+0x555>
     857:	83 c4 10             	add    esp,0x10
     85a:	66 83 f8 4f          	cmp    ax,0x4f
     85e:	74 21                	je     881 <vga_list_modes+0x583>
										puts("Unable to switch modes");
     860:	83 ec 0c             	sub    esp,0xc
     863:	68 41 01 00 00       	push   0x141
     868:	e8 fc ff ff ff       	call   869 <vga_list_modes+0x56b>
     86d:	83 c4 10             	add    esp,0x10
										*ml = 0; ct--;
     870:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     873:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
     878:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
     87c:	e9 01 02 00 00       	jmp    a82 <vga_list_modes+0x784>
										continue;
								}
								/* TEST the framebuffer */
								video_mode.bpsl = mi->bpsl_lm;
     881:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     884:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     888:	0f b7 c0             	movzx  eax,ax
     88b:	a3 0c 00 00 00       	mov    ds:0xc,eax
								video_mode.gm_bts = mi->btpp;
     890:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     893:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     897:	a2 01 00 00 00       	mov    ds:0x1,al
								video_mode.btpp = rdiv(mi->btpp, 8);
     89c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     89f:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     8a3:	c0 e8 03             	shr    al,0x3
     8a6:	89 c2                	mov    edx,eax
     8a8:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     8ab:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     8af:	83 e0 07             	and    eax,0x7
     8b2:	84 c0                	test   al,al
     8b4:	0f 95 c0             	setne  al
     8b7:	01 d0                	add    eax,edx
     8b9:	a2 02 00 00 00       	mov    ds:0x2,al
								video_mode.is_textmode = 0;
     8be:	c6 05 00 00 00 00 00 	mov    BYTE PTR ds:0x0,0x0
								video_mode.width = mi->width;
     8c5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     8c8:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
     8cc:	0f b7 c0             	movzx  eax,ax
     8cf:	a3 04 00 00 00       	mov    ds:0x4,eax
								video_mode.height = mi->height;
     8d4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     8d7:	0f b7 40 14          	movzx  eax,WORD PTR [eax+0x14]
     8db:	0f b7 c0             	movzx  eax,ax
     8de:	a3 08 00 00 00       	mov    ds:0x8,eax
								if (mi->attr & 128)
     8e3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     8e6:	0f b7 00             	movzx  eax,WORD PTR [eax]
     8e9:	0f b7 c0             	movzx  eax,ax
     8ec:	25 80 00 00 00       	and    eax,0x80
     8f1:	85 c0                	test   eax,eax
     8f3:	74 15                	je     90a <vga_list_modes+0x60c>
										mpt = vga_mem_ptr = mi->plfb;
     8f5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     8f8:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     8fb:	a3 00 00 00 00       	mov    ds:0x0,eax
     900:	a1 00 00 00 00       	mov    eax,ds:0x0
     905:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     908:	eb 72                	jmp    97c <vga_list_modes+0x67e>
								else {
										mpt = vga_mem_ptr = (void*)((size_t)mi->w1seg * 0x10);
     90a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     90d:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
     911:	0f b7 c0             	movzx  eax,ax
     914:	c1 e0 04             	shl    eax,0x4
     917:	a3 00 00 00 00       	mov    ds:0x0,eax
     91c:	a1 00 00 00 00       	mov    eax,ds:0x0
     921:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										/* check window size */
										video_mode.bpsl = mi->bpsl;
     924:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     927:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     92b:	0f b7 c0             	movzx  eax,ax
     92e:	a3 0c 00 00 00       	mov    ds:0xc,eax
										if (mi->wsiz * 1024 < video_mode.height * mi->bpsl)
     933:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     936:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     93a:	0f b7 c0             	movzx  eax,ax
     93d:	c1 e0 0a             	shl    eax,0xa
     940:	89 c1                	mov    ecx,eax
     942:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
     948:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     94b:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     94f:	0f b7 c0             	movzx  eax,ax
     952:	0f af c2             	imul   eax,edx
     955:	39 c1                	cmp    ecx,eax
     957:	7d 23                	jge    97c <vga_list_modes+0x67e>
												video_mode.height = mi->wsiz * 1024 / mi->bpsl;
     959:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     95c:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     960:	0f b7 c0             	movzx  eax,ax
     963:	c1 e0 0a             	shl    eax,0xa
     966:	89 c1                	mov    ecx,eax
     968:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     96b:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     96f:	0f b7 d8             	movzx  ebx,ax
     972:	89 c8                	mov    eax,ecx
     974:	99                   	cdq
     975:	f7 fb                	idiv   ebx
     977:	a3 08 00 00 00       	mov    ds:0x8,eax
								//		while (inb(0x3da) & 0x08);
								//		while (!(inb(0x3da) & 0x08));
								//		framebuffer_redraw(&fb);
								//		for (i = 0; i < UINT_MAX / 1000; i++);
								//}
								vga_mem_ptr = (void*)0xb8000;
     97c:	c7 05 00 00 00 00 00 80 0b 00 	mov    DWORD PTR ds:0x0,0xb8000
								/* fill graphics */
								uint32_t val = 0x310f00ff;
     986:	c7 45 e0 ff 00 0f 31 	mov    DWORD PTR [ebp-0x20],0x310f00ff
								for (size_t k = 0; k < 10/*UINT_MAX*/; k++) {
     98d:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
     994:	e9 84 00 00 00       	jmp    a1d <vga_list_modes+0x71f>
										char* ptr = (char*)mpt;
     999:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     99c:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										for (i = 0; i < video_mode.height * video_mode.bpsl; i += 4) {
     99f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     9a6:	eb 11                	jmp    9b9 <vga_list_modes+0x6bb>
												*(uint32_t*)(ptr + i) = val;
     9a8:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     9ab:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9ae:	01 c2                	add    edx,eax
     9b0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     9b3:	89 02                	mov    DWORD PTR [edx],eax
										for (i = 0; i < video_mode.height * video_mode.bpsl; i += 4) {
     9b5:	83 45 e8 04          	add    DWORD PTR [ebp-0x18],0x4
     9b9:	a1 08 00 00 00       	mov    eax,ds:0x8
     9be:	89 c2                	mov    edx,eax
     9c0:	a1 0c 00 00 00       	mov    eax,ds:0xc
     9c5:	0f af c2             	imul   eax,edx
     9c8:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
     9cb:	72 db                	jb     9a8 <vga_list_modes+0x6aa>
										}
										draw_vga(ptr, font, mi);
     9cd:	83 ec 04             	sub    esp,0x4
     9d0:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     9d3:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     9d6:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     9d9:	e8 fc ff ff ff       	call   9da <vga_list_modes+0x6dc>
     9de:	83 c4 10             	add    esp,0x10
										//for (i = 0; i < UINT_MAX / 20; i++);
										call_int15(100000); // 100 ms
     9e1:	83 ec 0c             	sub    esp,0xc
     9e4:	68 a0 86 01 00       	push   0x186a0
     9e9:	e8 fc ff ff ff       	call   9ea <vga_list_modes+0x6ec>
     9ee:	83 c4 10             	add    esp,0x10
										val = val * 0x42936 - val % 34;
     9f1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     9f4:	69 d8 36 29 04 00    	imul   ebx,eax,0x42936
     9fa:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     9fd:	ba f1 f0 f0 f0       	mov    edx,0xf0f0f0f1
     a02:	89 c8                	mov    eax,ecx
     a04:	f7 e2                	mul    edx
     a06:	89 d0                	mov    eax,edx
     a08:	c1 e8 05             	shr    eax,0x5
     a0b:	6b d0 22             	imul   edx,eax,0x22
     a0e:	89 c8                	mov    eax,ecx
     a10:	29 d0                	sub    eax,edx
     a12:	29 c3                	sub    ebx,eax
     a14:	89 da                	mov    edx,ebx
     a16:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
								for (size_t k = 0; k < 10/*UINT_MAX*/; k++) {
     a19:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
     a1d:	83 7d dc 09          	cmp    DWORD PTR [ebp-0x24],0x9
     a21:	0f 86 72 ff ff ff    	jbe    999 <vga_list_modes+0x69b>
								}
								/* wait */
								//for (i = 0; i < UINT_MAX / 4; i++);
								call_int15(500000); // 500 ms
     a27:	83 ec 0c             	sub    esp,0xc
     a2a:	68 20 a1 07 00       	push   0x7a120
     a2f:	e8 fc ff ff ff       	call   a30 <vga_list_modes+0x732>
     a34:	83 c4 10             	add    esp,0x10
								/* restore mode */
								call_vga_int10(0x0003, 0, NULL, NULL);
     a37:	6a 00                	push   0x0
     a39:	6a 00                	push   0x0
     a3b:	6a 00                	push   0x0
     a3d:	6a 03                	push   0x3
     a3f:	e8 fc ff ff ff       	call   a40 <vga_list_modes+0x742>
     a44:	83 c4 10             	add    esp,0x10
								mem_cpy((void*)0xb8000, txt + (ln - 1) * 160, 4000);
     a47:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a4a:	8d 50 ff             	lea    edx,[eax-0x1]
     a4d:	89 d0                	mov    eax,edx
     a4f:	c1 e0 02             	shl    eax,0x2
     a52:	01 d0                	add    eax,edx
     a54:	c1 e0 05             	shl    eax,0x5
     a57:	89 c2                	mov    edx,eax
     a59:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a5c:	01 d0                	add    eax,edx
     a5e:	83 ec 04             	sub    esp,0x4
     a61:	68 a0 0f 00 00       	push   0xfa0
     a66:	50                   	push   eax
     a67:	68 00 80 0b 00       	push   0xb8000
     a6c:	e8 fc ff ff ff       	call   a6d <vga_list_modes+0x76f>
     a71:	83 c4 10             	add    esp,0x10
     a74:	eb 08                	jmp    a7e <vga_list_modes+0x780>
						}
				} else /* remove nonviable modes */
						*ml = 0;
     a76:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a79:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
				ml++;
     a7e:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
		while (*ml != 0xffff) {
     a82:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a85:	0f b7 00             	movzx  eax,WORD PTR [eax]
     a88:	66 83 f8 ff          	cmp    ax,0xffff
     a8c:	0f 85 13 f9 ff ff    	jne    3a5 <vga_list_modes+0xa7>
		}
		if (ct == base_num)
     a92:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a95:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
     a98:	75 10                	jne    aaa <vga_list_modes+0x7ac>
				puts("none");
     a9a:	83 ec 0c             	sub    esp,0xc
     a9d:	68 5c 00 00 00       	push   0x5c
     aa2:	e8 fc ff ff ff       	call   aa3 <vga_list_modes+0x7a5>
     aa7:	83 c4 10             	add    esp,0x10
		return ct - base_num;
     aaa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     aad:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
}
     ab0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     ab3:	c9                   	leave
     ab4:	c3                   	ret

00000ab5 <switch_to_mode>:

int switch_to_mode(uint16_t m)
{
     ab5:	55                   	push   ebp
     ab6:	89 e5                	mov    ebp,esp
     ab8:	53                   	push   ebx
     ab9:	81 ec d4 10 00 00    	sub    esp,0x10d4
     abf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ac2:	66 89 85 34 ef ff ff 	mov    WORD PTR [ebp-0x10cc],ax
		char buf[256], txt[4000];
		struct vbe_modeinfo* mi = (struct vbe_modeinfo*)buf;
     ac9:	8d 85 e4 fe ff ff    	lea    eax,[ebp-0x11c]
     acf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		putstr("switching to mode ");
     ad2:	83 ec 0c             	sub    esp,0xc
     ad5:	68 58 01 00 00       	push   0x158
     ada:	e8 fc ff ff ff       	call   adb <switch_to_mode+0x26>
     adf:	83 c4 10             	add    esp,0x10
		put16s(m);
     ae2:	0f b7 85 34 ef ff ff 	movzx  eax,WORD PTR [ebp-0x10cc]
     ae9:	83 ec 0c             	sub    esp,0xc
     aec:	50                   	push   eax
     aed:	e8 fc ff ff ff       	call   aee <switch_to_mode+0x39>
     af2:	83 c4 10             	add    esp,0x10
		put_nl();
     af5:	e8 fc ff ff ff       	call   af6 <switch_to_mode+0x41>
		/* get the description */
		if (call_vga_int10(0x4f01, m, buf, NULL) == 0x004f) {
     afa:	0f b7 85 34 ef ff ff 	movzx  eax,WORD PTR [ebp-0x10cc]
     b01:	6a 00                	push   0x0
     b03:	8d 95 e4 fe ff ff    	lea    edx,[ebp-0x11c]
     b09:	52                   	push   edx
     b0a:	50                   	push   eax
     b0b:	68 01 4f 00 00       	push   0x4f01
     b10:	e8 fc ff ff ff       	call   b11 <switch_to_mode+0x5c>
     b15:	83 c4 10             	add    esp,0x10
     b18:	66 83 f8 4f          	cmp    ax,0x4f
     b1c:	0f 85 f8 02 00 00    	jne    e1a <switch_to_mode+0x365>
				if (mi->btpp != 4 || mi->attr & 128) {
     b22:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b25:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     b29:	3c 04                	cmp    al,0x4
     b2b:	75 16                	jne    b43 <switch_to_mode+0x8e>
     b2d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b30:	0f b7 00             	movzx  eax,WORD PTR [eax]
     b33:	0f b7 c0             	movzx  eax,ax
     b36:	25 80 00 00 00       	and    eax,0x80
     b3b:	85 c0                	test   eax,eax
     b3d:	0f 84 c0 02 00 00    	je     e03 <switch_to_mode+0x34e>
						uint16_t regs[3] = {0, 0, 0};
     b43:	66 c7 85 3e ef ff ff 00 00 	mov    WORD PTR [ebp-0x10c2],0x0
     b4c:	66 c7 85 40 ef ff ff 00 00 	mov    WORD PTR [ebp-0x10c0],0x0
     b55:	66 c7 85 42 ef ff ff 00 00 	mov    WORD PTR [ebp-0x10be],0x0
						char* txt2; size_t nx, ny;
						/* save the text */
						mem_cpy(txt, (void*)0xb8000, 4000);
     b5e:	83 ec 04             	sub    esp,0x4
     b61:	68 a0 0f 00 00       	push   0xfa0
     b66:	68 00 80 0b 00       	push   0xb8000
     b6b:	8d 85 44 ef ff ff    	lea    eax,[ebp-0x10bc]
     b71:	50                   	push   eax
     b72:	e8 fc ff ff ff       	call   b73 <switch_to_mode+0xbe>
     b77:	83 c4 10             	add    esp,0x10
						/* switch the mode */
						if (mi->attr & 128)
     b7a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b7d:	0f b7 00             	movzx  eax,WORD PTR [eax]
     b80:	0f b7 c0             	movzx  eax,ax
     b83:	25 80 00 00 00       	and    eax,0x80
     b88:	85 c0                	test   eax,eax
     b8a:	74 13                	je     b9f <switch_to_mode+0xea>
								regs[0] = m | 0x4000;
     b8c:	0f b7 85 34 ef ff ff 	movzx  eax,WORD PTR [ebp-0x10cc]
     b93:	80 cc 40             	or     ah,0x40
     b96:	66 89 85 3e ef ff ff 	mov    WORD PTR [ebp-0x10c2],ax
     b9d:	eb 0e                	jmp    bad <switch_to_mode+0xf8>
						else
								regs[0] = m;
     b9f:	0f b7 85 34 ef ff ff 	movzx  eax,WORD PTR [ebp-0x10cc]
     ba6:	66 89 85 3e ef ff ff 	mov    WORD PTR [ebp-0x10c2],ax
						if (call_vga_int10(0x4f02, 0, NULL, regs) != 0x004f) {
     bad:	8d 85 3e ef ff ff    	lea    eax,[ebp-0x10c2]
     bb3:	50                   	push   eax
     bb4:	6a 00                	push   0x0
     bb6:	6a 00                	push   0x0
     bb8:	68 02 4f 00 00       	push   0x4f02
     bbd:	e8 fc ff ff ff       	call   bbe <switch_to_mode+0x109>
     bc2:	83 c4 10             	add    esp,0x10
     bc5:	66 83 f8 4f          	cmp    ax,0x4f
     bc9:	74 1a                	je     be5 <switch_to_mode+0x130>
								puts("Unable to switch modes");
     bcb:	83 ec 0c             	sub    esp,0xc
     bce:	68 41 01 00 00       	push   0x141
     bd3:	e8 fc ff ff ff       	call   bd4 <switch_to_mode+0x11f>
     bd8:	83 c4 10             	add    esp,0x10
								return 0;
     bdb:	b8 00 00 00 00       	mov    eax,0x0
     be0:	e9 3a 02 00 00       	jmp    e1f <switch_to_mode+0x36a>
						}
						/* set up the mode description */
						video_mode.bpsl = mi->bpsl_lm;
     be5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     be8:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     bec:	0f b7 c0             	movzx  eax,ax
     bef:	a3 0c 00 00 00       	mov    ds:0xc,eax
						video_mode.gm_bts = mi->btpp;
     bf4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     bf7:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     bfb:	a2 01 00 00 00       	mov    ds:0x1,al
						video_mode.btpp = rdiv(mi->btpp, 8);
     c00:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c03:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     c07:	c0 e8 03             	shr    al,0x3
     c0a:	89 c2                	mov    edx,eax
     c0c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c0f:	0f b6 40 19          	movzx  eax,BYTE PTR [eax+0x19]
     c13:	83 e0 07             	and    eax,0x7
     c16:	84 c0                	test   al,al
     c18:	0f 95 c0             	setne  al
     c1b:	01 d0                	add    eax,edx
     c1d:	a2 02 00 00 00       	mov    ds:0x2,al
						video_mode.is_textmode = 0;
     c22:	c6 05 00 00 00 00 00 	mov    BYTE PTR ds:0x0,0x0
						video_mode.width = mi->width;
     c29:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c2c:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
     c30:	0f b7 c0             	movzx  eax,ax
     c33:	a3 04 00 00 00       	mov    ds:0x4,eax
						video_mode.height = mi->height;
     c38:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c3b:	0f b7 40 14          	movzx  eax,WORD PTR [eax+0x14]
     c3f:	0f b7 c0             	movzx  eax,ax
     c42:	a3 08 00 00 00       	mov    ds:0x8,eax
						if (mi->attr & 128) {
     c47:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c4a:	0f b7 00             	movzx  eax,WORD PTR [eax]
     c4d:	0f b7 c0             	movzx  eax,ax
     c50:	25 80 00 00 00       	and    eax,0x80
     c55:	85 c0                	test   eax,eax
     c57:	74 76                	je     ccf <switch_to_mode+0x21a>
								vga_mem_ptr = mi->plfb;
     c59:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c5c:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     c5f:	a3 00 00 00 00       	mov    ds:0x0,eax
								vga_pmem = mi->plfb;
     c64:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c67:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     c6a:	a3 00 00 00 00       	mov    ds:0x0,eax
								vga_pmem_size = (mi->bpsl_lm * video_mode.height) * (1 + mi->nim_lm);
     c6f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c72:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     c76:	0f b7 d0             	movzx  edx,ax
     c79:	a1 08 00 00 00       	mov    eax,ds:0x8
     c7e:	0f af c2             	imul   eax,edx
     c81:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c84:	0f b6 52 35          	movzx  edx,BYTE PTR [edx+0x35]
     c88:	0f b6 d2             	movzx  edx,dl
     c8b:	83 c2 01             	add    edx,0x1
     c8e:	0f af c2             	imul   eax,edx
     c91:	a3 00 00 00 00       	mov    ds:0x0,eax
								if (!vga_pmem_size)
     c96:	a1 00 00 00 00       	mov    eax,ds:0x0
     c9b:	85 c0                	test   eax,eax
     c9d:	0f 85 b2 00 00 00    	jne    d55 <switch_to_mode+0x2a0>
										vga_pmem_size = mi->bpsl * video_mode.height * (1 + mi->nim_lm);
     ca3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ca6:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     caa:	0f b7 d0             	movzx  edx,ax
     cad:	a1 08 00 00 00       	mov    eax,ds:0x8
     cb2:	0f af c2             	imul   eax,edx
     cb5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     cb8:	0f b6 52 35          	movzx  edx,BYTE PTR [edx+0x35]
     cbc:	0f b6 d2             	movzx  edx,dl
     cbf:	83 c2 01             	add    edx,0x1
     cc2:	0f af c2             	imul   eax,edx
     cc5:	a3 00 00 00 00       	mov    ds:0x0,eax
     cca:	e9 86 00 00 00       	jmp    d55 <switch_to_mode+0x2a0>
						} else {
								vga_mem_ptr = (void*)((size_t)mi->w1seg * 0x10);
     ccf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cd2:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
     cd6:	0f b7 c0             	movzx  eax,ax
     cd9:	c1 e0 04             	shl    eax,0x4
     cdc:	a3 00 00 00 00       	mov    ds:0x0,eax
								/* check window size */
								video_mode.bpsl = mi->bpsl;
     ce1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ce4:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     ce8:	0f b7 c0             	movzx  eax,ax
     ceb:	a3 0c 00 00 00       	mov    ds:0xc,eax
								if (mi->wsiz * 1024 < video_mode.height * mi->bpsl)
     cf0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cf3:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     cf7:	0f b7 c0             	movzx  eax,ax
     cfa:	c1 e0 0a             	shl    eax,0xa
     cfd:	89 c1                	mov    ecx,eax
     cff:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
     d05:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d08:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     d0c:	0f b7 c0             	movzx  eax,ax
     d0f:	0f af c2             	imul   eax,edx
     d12:	39 c1                	cmp    ecx,eax
     d14:	7d 23                	jge    d39 <switch_to_mode+0x284>
										video_mode.height = mi->wsiz * 1024 / mi->bpsl;
     d16:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d19:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     d1d:	0f b7 c0             	movzx  eax,ax
     d20:	c1 e0 0a             	shl    eax,0xa
     d23:	89 c1                	mov    ecx,eax
     d25:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d28:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     d2c:	0f b7 d8             	movzx  ebx,ax
     d2f:	89 c8                	mov    eax,ecx
     d31:	99                   	cdq
     d32:	f7 fb                	idiv   ebx
     d34:	a3 08 00 00 00       	mov    ds:0x8,eax
								vga_pmem = vga_mem_ptr;
     d39:	a1 00 00 00 00       	mov    eax,ds:0x0
     d3e:	a3 00 00 00 00       	mov    ds:0x0,eax
								vga_pmem_size = mi->wsiz * 1024;
     d43:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d46:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     d4a:	0f b7 c0             	movzx  eax,ax
     d4d:	c1 e0 0a             	shl    eax,0xa
     d50:	a3 00 00 00 00       	mov    ds:0x0,eax
						}
						/* create a new text buffer */
						nx = video_mode.width / 8;
     d55:	a1 04 00 00 00       	mov    eax,ds:0x4
     d5a:	8d 50 07             	lea    edx,[eax+0x7]
     d5d:	85 c0                	test   eax,eax
     d5f:	0f 48 c2             	cmovs  eax,edx
     d62:	c1 f8 03             	sar    eax,0x3
     d65:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						ny = video_mode.height / 16; /* maybe history later on */
     d68:	a1 08 00 00 00       	mov    eax,ds:0x8
     d6d:	8d 50 0f             	lea    edx,[eax+0xf]
     d70:	85 c0                	test   eax,eax
     d72:	0f 48 c2             	cmovs  eax,edx
     d75:	c1 f8 04             	sar    eax,0x4
     d78:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

						txt2 = FM_VGA_TEST; /* FIXME: use allocator */
     d7b:	c7 45 e4 00 00 05 00 	mov    DWORD PTR [ebp-0x1c],0x50000
						bzero(txt2, 2 * nx * ny);
     d82:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     d85:	0f af 45 e8          	imul   eax,DWORD PTR [ebp-0x18]
     d89:	01 c0                	add    eax,eax
     d8b:	83 ec 08             	sub    esp,0x8
     d8e:	50                   	push   eax
     d8f:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     d92:	e8 fc ff ff ff       	call   d93 <switch_to_mode+0x2de>
     d97:	83 c4 10             	add    esp,0x10
						//txt2 = kzalloc(2 * nx * ny); /* or die alloc */

						/* copy the buffer */
						for (size_t i = 0; i < min(ny, 25); i++)
     d9a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     da1:	eb 47                	jmp    dea <switch_to_mode+0x335>
								mem_cpy(txt2 + 2 * i * nx, txt + 2 * i * 80, min(80, nx));
     da3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     da6:	ba 50 00 00 00       	mov    edx,0x50
     dab:	39 d0                	cmp    eax,edx
     dad:	89 d1                	mov    ecx,edx
     daf:	0f 46 c8             	cmovbe ecx,eax
     db2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     db5:	89 d0                	mov    eax,edx
     db7:	c1 e0 02             	shl    eax,0x2
     dba:	01 d0                	add    eax,edx
     dbc:	c1 e0 05             	shl    eax,0x5
     dbf:	89 c2                	mov    edx,eax
     dc1:	8d 85 44 ef ff ff    	lea    eax,[ebp-0x10bc]
     dc7:	01 c2                	add    edx,eax
     dc9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dcc:	0f af 45 ec          	imul   eax,DWORD PTR [ebp-0x14]
     dd0:	8d 1c 00             	lea    ebx,[eax+eax*1]
     dd3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     dd6:	01 d8                	add    eax,ebx
     dd8:	83 ec 04             	sub    esp,0x4
     ddb:	51                   	push   ecx
     ddc:	52                   	push   edx
     ddd:	50                   	push   eax
     dde:	e8 fc ff ff ff       	call   ddf <switch_to_mode+0x32a>
     de3:	83 c4 10             	add    esp,0x10
						for (size_t i = 0; i < min(ny, 25); i++)
     de6:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     dea:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     ded:	ba 19 00 00 00       	mov    edx,0x19
     df2:	39 d0                	cmp    eax,edx
     df4:	0f 47 c2             	cmova  eax,edx
     df7:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
     dfa:	72 a7                	jb     da3 <switch_to_mode+0x2ee>
						/* create the framebuffer */
						return -1;
     dfc:	b8 ff ff ff ff       	mov    eax,0xffffffff
     e01:	eb 1c                	jmp    e1f <switch_to_mode+0x36a>
//						kio_fb_resize();
//						puts("done setting up the framebuffer");
//						framebuffer_redraw(&fb_initial);
//						return 1;
				} else {
						puts("4-bit modes without LFB are not supported");
     e03:	83 ec 0c             	sub    esp,0xc
     e06:	68 6c 01 00 00       	push   0x16c
     e0b:	e8 fc ff ff ff       	call   e0c <switch_to_mode+0x357>
     e10:	83 c4 10             	add    esp,0x10
						return 0;
     e13:	b8 00 00 00 00       	mov    eax,0x0
     e18:	eb 05                	jmp    e1f <switch_to_mode+0x36a>
				}
		} else
				return 0;
     e1a:	b8 00 00 00 00       	mov    eax,0x0
}
     e1f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     e22:	c9                   	leave
     e23:	c3                   	ret

00000e24 <farchar>:

const char* farchar(far_ptr p)
{
     e24:	55                   	push   ebp
     e25:	89 e5                	mov    ebp,esp
		return (char*)(((p & 0xffff0000) >> 12) + (p & 0xffff));
     e27:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e2a:	c1 e8 0c             	shr    eax,0xc
     e2d:	25 f0 ff 0f 00       	and    eax,0xffff0
     e32:	89 c2                	mov    edx,eax
     e34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e37:	0f b7 c0             	movzx  eax,ax
     e3a:	01 d0                	add    eax,edx
}
     e3c:	5d                   	pop    ebp
     e3d:	c3                   	ret

00000e3e <vga_init>:

void vga_init(int mode)
{
     e3e:	55                   	push   ebp
     e3f:	89 e5                	mov    ebp,esp
     e41:	57                   	push   edi
     e42:	53                   	push   ebx
     e43:	81 ec 40 02 00 00    	sub    esp,0x240
		char vg_buf[512] = "VBE2"; int test = 0;
     e49:	c7 85 bc fd ff ff 56 42 45 32 	mov    DWORD PTR [ebp-0x244],0x32454256
     e53:	8d 95 c0 fd ff ff    	lea    edx,[ebp-0x240]
     e59:	b8 00 00 00 00       	mov    eax,0x0
     e5e:	b9 7f 00 00 00       	mov    ecx,0x7f
     e63:	89 d7                	mov    edi,edx
     e65:	f3 ab                	rep stos DWORD PTR es:[edi],eax
     e67:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		puts("VGA mode detection:");
     e6e:	83 ec 0c             	sub    esp,0xc
     e71:	68 96 01 00 00       	push   0x196
     e76:	e8 fc ff ff ff       	call   e77 <vga_init+0x39>
     e7b:	83 c4 10             	add    esp,0x10
		puts("Test each mode (y/n)?");
     e7e:	83 ec 0c             	sub    esp,0xc
     e81:	68 aa 01 00 00       	push   0x1aa
     e86:	e8 fc ff ff ff       	call   e87 <vga_init+0x49>
     e8b:	83 c4 10             	add    esp,0x10
		do {
				char c = call_int16(0);
     e8e:	83 ec 0c             	sub    esp,0xc
     e91:	6a 00                	push   0x0
     e93:	e8 fc ff ff ff       	call   e94 <vga_init+0x56>
     e98:	83 c4 10             	add    esp,0x10
     e9b:	88 45 d3             	mov    BYTE PTR [ebp-0x2d],al
				if (c == 'y') {
     e9e:	80 7d d3 79          	cmp    BYTE PTR [ebp-0x2d],0x79
     ea2:	75 09                	jne    ead <vga_init+0x6f>
						test = 1;
     ea4:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
						break;
     eab:	eb 09                	jmp    eb6 <vga_init+0x78>
				} else if (c == 'n')
     ead:	80 7d d3 6e          	cmp    BYTE PTR [ebp-0x2d],0x6e
     eb1:	74 02                	je     eb5 <vga_init+0x77>
		do {
     eb3:	eb d9                	jmp    e8e <vga_init+0x50>
						break;
     eb5:	90                   	nop
		} while (1);

		/* enable SSE if present */
		extern void enable_sse();
		enable_sse();
     eb6:	e8 fc ff ff ff       	call   eb7 <vga_init+0x79>

		bzero(vg_buf + 4, 508);
     ebb:	8d 85 bc fd ff ff    	lea    eax,[ebp-0x244]
     ec1:	83 c0 04             	add    eax,0x4
     ec4:	83 ec 08             	sub    esp,0x8
     ec7:	68 fc 01 00 00       	push   0x1fc
     ecc:	50                   	push   eax
     ecd:	e8 fc ff ff ff       	call   ece <vga_init+0x90>
     ed2:	83 c4 10             	add    esp,0x10
		if (call_vga_int10(0x4f00, 0, vg_buf, NULL) != 0x004f) {
     ed5:	6a 00                	push   0x0
     ed7:	8d 85 bc fd ff ff    	lea    eax,[ebp-0x244]
     edd:	50                   	push   eax
     ede:	6a 00                	push   0x0
     ee0:	68 00 4f 00 00       	push   0x4f00
     ee5:	e8 fc ff ff ff       	call   ee6 <vga_init+0xa8>
     eea:	83 c4 10             	add    esp,0x10
     eed:	66 83 f8 4f          	cmp    ax,0x4f
     ef1:	74 13                	je     f06 <vga_init+0xc8>
				puts("VESA BIOS extensions not supported");
     ef3:	83 ec 0c             	sub    esp,0xc
     ef6:	68 c0 01 00 00       	push   0x1c0
     efb:	e8 fc ff ff ff       	call   efc <vga_init+0xbe>
     f00:	83 c4 10             	add    esp,0x10
				while (1);
     f03:	90                   	nop
     f04:	eb fd                	jmp    f03 <vga_init+0xc5>
				return;
		}
		struct vbe_info* vi = (struct vbe_info*)vg_buf; size_t ml_cap = 0x100;
     f06:	8d 85 bc fd ff ff    	lea    eax,[ebp-0x244]
     f0c:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     f0f:	c7 45 f0 00 01 00 00 	mov    DWORD PTR [ebp-0x10],0x100
		uint16_t* mode_list = (uint16_t*)farchar(vi->mode_ptr); uint16_t m;
     f16:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f19:	8b 40 0e             	mov    eax,DWORD PTR [eax+0xe]
     f1c:	83 ec 0c             	sub    esp,0xc
     f1f:	50                   	push   eax
     f20:	e8 fc ff ff ff       	call   f21 <vga_init+0xe3>
     f25:	83 c4 10             	add    esp,0x10
     f28:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		int ml_base = 1, ml_ct = 0, num;
     f2b:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
     f32:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		/* fill the mode list 0x100-0x1ff and others */
		if (mode_list)
     f39:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     f3d:	74 18                	je     f57 <vga_init+0x119>
				while (*mode_list++ != 0xffff)
     f3f:	eb 04                	jmp    f45 <vga_init+0x107>
						ml_cap++;
     f41:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
				while (*mode_list++ != 0xffff)
     f45:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f48:	8d 50 02             	lea    edx,[eax+0x2]
     f4b:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     f4e:	0f b7 00             	movzx  eax,WORD PTR [eax]
     f51:	66 83 f8 ff          	cmp    ax,0xffff
     f55:	75 ea                	jne    f41 <vga_init+0x103>
		mode_list = FM_VGA_MODELIST; /* POINTER to fixed memory */
     f57:	c7 45 ec 00 80 04 00 	mov    DWORD PTR [ebp-0x14],0x48000
		for (m = 0x100; m < 0x200; m++)
     f5e:	66 c7 45 ea 00 01    	mov    WORD PTR [ebp-0x16],0x100
     f64:	eb 23                	jmp    f89 <vga_init+0x14b>
				mode_list[m - 0x100] = m;
     f66:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
     f6a:	05 00 ff ff 7f       	add    eax,0x7fffff00
     f6f:	8d 14 00             	lea    edx,[eax+eax*1]
     f72:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f75:	01 c2                	add    edx,eax
     f77:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
     f7b:	66 89 02             	mov    WORD PTR [edx],ax
		for (m = 0x100; m < 0x200; m++)
     f7e:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
     f82:	83 c0 01             	add    eax,0x1
     f85:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
     f89:	66 81 7d ea ff 01    	cmp    WORD PTR [ebp-0x16],0x1ff
     f8f:	76 d5                	jbe    f66 <vga_init+0x128>
		/* now add the other entries */
		m = 0x100;
     f91:	66 c7 45 ea 00 01    	mov    WORD PTR [ebp-0x16],0x100
		for (uint16_t* mp = (uint16_t*)farchar(vi->mode_ptr); mp != NULL; mp++) {
     f97:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f9a:	8b 40 0e             	mov    eax,DWORD PTR [eax+0xe]
     f9d:	83 ec 0c             	sub    esp,0xc
     fa0:	50                   	push   eax
     fa1:	e8 fc ff ff ff       	call   fa2 <vga_init+0x164>
     fa6:	83 c4 10             	add    esp,0x10
     fa9:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     fac:	eb 47                	jmp    ff5 <vga_init+0x1b7>
				if (*mp == 0xffff)
     fae:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     fb1:	0f b7 00             	movzx  eax,WORD PTR [eax]
     fb4:	66 83 f8 ff          	cmp    ax,0xffff
     fb8:	74 43                	je     ffd <vga_init+0x1bf>
						break;
				if (*mp >= 0x200 || *mp < 0x100)
     fba:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     fbd:	0f b7 00             	movzx  eax,WORD PTR [eax]
     fc0:	66 3d ff 01          	cmp    ax,0x1ff
     fc4:	77 0c                	ja     fd2 <vga_init+0x194>
     fc6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     fc9:	0f b7 00             	movzx  eax,WORD PTR [eax]
     fcc:	66 3d ff 00          	cmp    ax,0xff
     fd0:	77 1f                	ja     ff1 <vga_init+0x1b3>
						mode_list[m++] = *mp;
     fd2:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
     fd6:	8d 50 01             	lea    edx,[eax+0x1]
     fd9:	66 89 55 ea          	mov    WORD PTR [ebp-0x16],dx
     fdd:	0f b7 c0             	movzx  eax,ax
     fe0:	8d 14 00             	lea    edx,[eax+eax*1]
     fe3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     fe6:	01 c2                	add    edx,eax
     fe8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     feb:	0f b7 00             	movzx  eax,WORD PTR [eax]
     fee:	66 89 02             	mov    WORD PTR [edx],ax
		for (uint16_t* mp = (uint16_t*)farchar(vi->mode_ptr); mp != NULL; mp++) {
     ff1:	83 45 d8 02          	add    DWORD PTR [ebp-0x28],0x2
     ff5:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
     ff9:	75 b3                	jne    fae <vga_init+0x170>
     ffb:	eb 01                	jmp    ffe <vga_init+0x1c0>
						break;
     ffd:	90                   	nop
		}
		mode_list[m] = 0xffff;
     ffe:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    1002:	8d 14 00             	lea    edx,[eax+eax*1]
    1005:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1008:	01 d0                	add    eax,edx
    100a:	66 c7 00 ff ff       	mov    WORD PTR [eax],0xffff
		/* print the info */
		putstr("Signature: ");
    100f:	83 ec 0c             	sub    esp,0xc
    1012:	68 e3 01 00 00       	push   0x1e3
    1017:	e8 fc ff ff ff       	call   1018 <vga_init+0x1da>
    101c:	83 c4 10             	add    esp,0x10
		nputstr(vi->sig, 4);
    101f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1022:	83 ec 08             	sub    esp,0x8
    1025:	6a 04                	push   0x4
    1027:	50                   	push   eax
    1028:	e8 fc ff ff ff       	call   1029 <vga_init+0x1eb>
    102d:	83 c4 10             	add    esp,0x10
		put_nl();
    1030:	e8 fc ff ff ff       	call   1031 <vga_init+0x1f3>
		putstr("VBE version: ");
    1035:	83 ec 0c             	sub    esp,0xc
    1038:	68 ef 01 00 00       	push   0x1ef
    103d:	e8 fc ff ff ff       	call   103e <vga_init+0x200>
    1042:	83 c4 10             	add    esp,0x10
		nput32(vi->major_version, 0);
    1045:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1048:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
    104c:	0f b6 c0             	movzx  eax,al
    104f:	83 ec 08             	sub    esp,0x8
    1052:	6a 00                	push   0x0
    1054:	50                   	push   eax
    1055:	e8 fc ff ff ff       	call   1056 <vga_init+0x218>
    105a:	83 c4 10             	add    esp,0x10
		putstr(".");
    105d:	83 ec 0c             	sub    esp,0xc
    1060:	68 fd 01 00 00       	push   0x1fd
    1065:	e8 fc ff ff ff       	call   1066 <vga_init+0x228>
    106a:	83 c4 10             	add    esp,0x10
		nput32(vi->minor_version, 0);
    106d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1070:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
    1074:	0f b6 c0             	movzx  eax,al
    1077:	83 ec 08             	sub    esp,0x8
    107a:	6a 00                	push   0x0
    107c:	50                   	push   eax
    107d:	e8 fc ff ff ff       	call   107e <vga_init+0x240>
    1082:	83 c4 10             	add    esp,0x10
		put_nl();
    1085:	e8 fc ff ff ff       	call   1086 <vga_init+0x248>
		putstr("OEM: ");
    108a:	83 ec 0c             	sub    esp,0xc
    108d:	68 ff 01 00 00       	push   0x1ff
    1092:	e8 fc ff ff ff       	call   1093 <vga_init+0x255>
    1097:	83 c4 10             	add    esp,0x10
		putstr(farchar(vi->oem_name));
    109a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    109d:	8b 40 06             	mov    eax,DWORD PTR [eax+0x6]
    10a0:	83 ec 0c             	sub    esp,0xc
    10a3:	50                   	push   eax
    10a4:	e8 fc ff ff ff       	call   10a5 <vga_init+0x267>
    10a9:	83 c4 10             	add    esp,0x10
    10ac:	83 ec 0c             	sub    esp,0xc
    10af:	50                   	push   eax
    10b0:	e8 fc ff ff ff       	call   10b1 <vga_init+0x273>
    10b5:	83 c4 10             	add    esp,0x10
		put_nl();
    10b8:	e8 fc ff ff ff       	call   10b9 <vga_init+0x27b>
		putstr("Video memory: ");
    10bd:	83 ec 0c             	sub    esp,0xc
    10c0:	68 05 02 00 00       	push   0x205
    10c5:	e8 fc ff ff ff       	call   10c6 <vga_init+0x288>
    10ca:	83 c4 10             	add    esp,0x10
		nput32(vi->vmem * 64 / 1024, 0);
    10cd:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    10d0:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
    10d4:	0f b7 c0             	movzx  eax,ax
    10d7:	8d 50 0f             	lea    edx,[eax+0xf]
    10da:	85 c0                	test   eax,eax
    10dc:	0f 48 c2             	cmovs  eax,edx
    10df:	c1 f8 04             	sar    eax,0x4
    10e2:	83 ec 08             	sub    esp,0x8
    10e5:	6a 00                	push   0x0
    10e7:	50                   	push   eax
    10e8:	e8 fc ff ff ff       	call   10e9 <vga_init+0x2ab>
    10ed:	83 c4 10             	add    esp,0x10
		putstr("M");
    10f0:	83 ec 0c             	sub    esp,0xc
    10f3:	68 14 02 00 00       	push   0x214
    10f8:	e8 fc ff ff ff       	call   10f9 <vga_init+0x2bb>
    10fd:	83 c4 10             	add    esp,0x10
		put_nl();
    1100:	e8 fc ff ff ff       	call   1101 <vga_init+0x2c3>
		putstr("Capabilities: ");
    1105:	83 ec 0c             	sub    esp,0xc
    1108:	68 16 02 00 00       	push   0x216
    110d:	e8 fc ff ff ff       	call   110e <vga_init+0x2d0>
    1112:	83 c4 10             	add    esp,0x10
		if (vi->caps & 1)
    1115:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1118:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    111b:	83 e0 01             	and    eax,0x1
    111e:	85 c0                	test   eax,eax
    1120:	74 10                	je     1132 <vga_init+0x2f4>
				putstr("8-Bit DAC ");
    1122:	83 ec 0c             	sub    esp,0xc
    1125:	68 25 02 00 00       	push   0x225
    112a:	e8 fc ff ff ff       	call   112b <vga_init+0x2ed>
    112f:	83 c4 10             	add    esp,0x10
		if (vi->caps & 2)
    1132:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1135:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    1138:	83 e0 02             	and    eax,0x2
    113b:	85 c0                	test   eax,eax
    113d:	74 10                	je     114f <vga_init+0x311>
				putstr("non-VGA ");
    113f:	83 ec 0c             	sub    esp,0xc
    1142:	68 30 02 00 00       	push   0x230
    1147:	e8 fc ff ff ff       	call   1148 <vga_init+0x30a>
    114c:	83 c4 10             	add    esp,0x10
		if (vi->caps & 4)
    114f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1152:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    1155:	83 e0 04             	and    eax,0x4
    1158:	85 c0                	test   eax,eax
    115a:	74 10                	je     116c <vga_init+0x32e>
				putstr("pDAC w/ blank ");
    115c:	83 ec 0c             	sub    esp,0xc
    115f:	68 39 02 00 00       	push   0x239
    1164:	e8 fc ff ff ff       	call   1165 <vga_init+0x327>
    1169:	83 c4 10             	add    esp,0x10
		if (vi->caps & 8)
    116c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    116f:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    1172:	83 e0 08             	and    eax,0x8
    1175:	85 c0                	test   eax,eax
    1177:	74 10                	je     1189 <vga_init+0x34b>
				putstr("VBE/AF ");
    1179:	83 ec 0c             	sub    esp,0xc
    117c:	68 48 02 00 00       	push   0x248
    1181:	e8 fc ff ff ff       	call   1182 <vga_init+0x344>
    1186:	83 c4 10             	add    esp,0x10
		if (vi->caps & 16)
    1189:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    118c:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    118f:	83 e0 10             	and    eax,0x10
    1192:	85 c0                	test   eax,eax
    1194:	74 10                	je     11a6 <vga_init+0x368>
				putstr("EDA for FB ");
    1196:	83 ec 0c             	sub    esp,0xc
    1199:	68 50 02 00 00       	push   0x250
    119e:	e8 fc ff ff ff       	call   119f <vga_init+0x361>
    11a3:	83 c4 10             	add    esp,0x10
		if (vi->caps & 32)
    11a6:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    11a9:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    11ac:	83 e0 20             	and    eax,0x20
    11af:	85 c0                	test   eax,eax
    11b1:	74 10                	je     11c3 <vga_init+0x385>
				putstr("HW cursor ");
    11b3:	83 ec 0c             	sub    esp,0xc
    11b6:	68 5c 02 00 00       	push   0x25c
    11bb:	e8 fc ff ff ff       	call   11bc <vga_init+0x37e>
    11c0:	83 c4 10             	add    esp,0x10
		if (vi->caps & 64)
    11c3:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    11c6:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    11c9:	83 e0 40             	and    eax,0x40
    11cc:	85 c0                	test   eax,eax
    11ce:	74 10                	je     11e0 <vga_init+0x3a2>
				putstr("HW clipping ");
    11d0:	83 ec 0c             	sub    esp,0xc
    11d3:	68 67 02 00 00       	push   0x267
    11d8:	e8 fc ff ff ff       	call   11d9 <vga_init+0x39b>
    11dd:	83 c4 10             	add    esp,0x10
		if (vi->caps & 128)
    11e0:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    11e3:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    11e6:	25 80 00 00 00       	and    eax,0x80
    11eb:	85 c0                	test   eax,eax
    11ed:	74 10                	je     11ff <vga_init+0x3c1>
				putstr("Transparent BitBLT");
    11ef:	83 ec 0c             	sub    esp,0xc
    11f2:	68 74 02 00 00       	push   0x274
    11f7:	e8 fc ff ff ff       	call   11f8 <vga_init+0x3ba>
    11fc:	83 c4 10             	add    esp,0x10
		put_nl();
    11ff:	e8 fc ff ff ff       	call   1200 <vga_init+0x3c2>
		putstr("hexval: ");
    1204:	83 ec 0c             	sub    esp,0xc
    1207:	68 87 02 00 00       	push   0x287
    120c:	e8 fc ff ff ff       	call   120d <vga_init+0x3cf>
    1211:	83 c4 10             	add    esp,0x10
		put32(vi->caps);
    1214:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1217:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    121a:	83 ec 0c             	sub    esp,0xc
    121d:	50                   	push   eax
    121e:	e8 fc ff ff ff       	call   121f <vga_init+0x3e1>
    1223:	83 c4 10             	add    esp,0x10
		put_nl();
    1226:	e8 fc ff ff ff       	call   1227 <vga_init+0x3e9>
		if (vi->major_version >= 2) {
    122b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    122e:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
    1232:	3c 01                	cmp    al,0x1
    1234:	0f 86 aa 01 00 00    	jbe    13e4 <vga_init+0x5a6>
				putstr("OEM software version: ");
    123a:	83 ec 0c             	sub    esp,0xc
    123d:	68 90 02 00 00       	push   0x290
    1242:	e8 fc ff ff ff       	call   1243 <vga_init+0x405>
    1247:	83 c4 10             	add    esp,0x10
				nput32(vi->vbe2.major_version, 0);
    124a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    124d:	0f b6 40 15          	movzx  eax,BYTE PTR [eax+0x15]
    1251:	0f b6 c0             	movzx  eax,al
    1254:	83 ec 08             	sub    esp,0x8
    1257:	6a 00                	push   0x0
    1259:	50                   	push   eax
    125a:	e8 fc ff ff ff       	call   125b <vga_init+0x41d>
    125f:	83 c4 10             	add    esp,0x10
				putstr(".");
    1262:	83 ec 0c             	sub    esp,0xc
    1265:	68 fd 01 00 00       	push   0x1fd
    126a:	e8 fc ff ff ff       	call   126b <vga_init+0x42d>
    126f:	83 c4 10             	add    esp,0x10
				nput32(vi->vbe2.minor_version, 0);
    1272:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1275:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1279:	0f b6 c0             	movzx  eax,al
    127c:	83 ec 08             	sub    esp,0x8
    127f:	6a 00                	push   0x0
    1281:	50                   	push   eax
    1282:	e8 fc ff ff ff       	call   1283 <vga_init+0x445>
    1287:	83 c4 10             	add    esp,0x10
				put_nl();
    128a:	e8 fc ff ff ff       	call   128b <vga_init+0x44d>
				putstr("Vendor: ");
    128f:	83 ec 0c             	sub    esp,0xc
    1292:	68 a7 02 00 00       	push   0x2a7
    1297:	e8 fc ff ff ff       	call   1298 <vga_init+0x45a>
    129c:	83 c4 10             	add    esp,0x10
				putstr(farchar(vi->vbe2.vendor_name));
    129f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    12a2:	8b 40 16             	mov    eax,DWORD PTR [eax+0x16]
    12a5:	83 ec 0c             	sub    esp,0xc
    12a8:	50                   	push   eax
    12a9:	e8 fc ff ff ff       	call   12aa <vga_init+0x46c>
    12ae:	83 c4 10             	add    esp,0x10
    12b1:	83 ec 0c             	sub    esp,0xc
    12b4:	50                   	push   eax
    12b5:	e8 fc ff ff ff       	call   12b6 <vga_init+0x478>
    12ba:	83 c4 10             	add    esp,0x10
				put_nl();
    12bd:	e8 fc ff ff ff       	call   12be <vga_init+0x480>
				putstr("Product: ");
    12c2:	83 ec 0c             	sub    esp,0xc
    12c5:	68 b0 02 00 00       	push   0x2b0
    12ca:	e8 fc ff ff ff       	call   12cb <vga_init+0x48d>
    12cf:	83 c4 10             	add    esp,0x10
				putstr(farchar(vi->vbe2.product_name));
    12d2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    12d5:	8b 40 1a             	mov    eax,DWORD PTR [eax+0x1a]
    12d8:	83 ec 0c             	sub    esp,0xc
    12db:	50                   	push   eax
    12dc:	e8 fc ff ff ff       	call   12dd <vga_init+0x49f>
    12e1:	83 c4 10             	add    esp,0x10
    12e4:	83 ec 0c             	sub    esp,0xc
    12e7:	50                   	push   eax
    12e8:	e8 fc ff ff ff       	call   12e9 <vga_init+0x4ab>
    12ed:	83 c4 10             	add    esp,0x10
				put_nl();
    12f0:	e8 fc ff ff ff       	call   12f1 <vga_init+0x4b3>
				putstr("Product rev: ");
    12f5:	83 ec 0c             	sub    esp,0xc
    12f8:	68 ba 02 00 00       	push   0x2ba
    12fd:	e8 fc ff ff ff       	call   12fe <vga_init+0x4c0>
    1302:	83 c4 10             	add    esp,0x10
				putstr(farchar(vi->vbe2.product_revision));
    1305:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1308:	8b 40 1e             	mov    eax,DWORD PTR [eax+0x1e]
    130b:	83 ec 0c             	sub    esp,0xc
    130e:	50                   	push   eax
    130f:	e8 fc ff ff ff       	call   1310 <vga_init+0x4d2>
    1314:	83 c4 10             	add    esp,0x10
    1317:	83 ec 0c             	sub    esp,0xc
    131a:	50                   	push   eax
    131b:	e8 fc ff ff ff       	call   131c <vga_init+0x4de>
    1320:	83 c4 10             	add    esp,0x10
				put_nl();
    1323:	e8 fc ff ff ff       	call   1324 <vga_init+0x4e6>
				//for (size_t i = 0; i < UINT_MAX / 3; i++);
				call_int15(1000000); // 1000 ms
    1328:	83 ec 0c             	sub    esp,0xc
    132b:	68 40 42 0f 00       	push   0xf4240
    1330:	e8 fc ff ff ff       	call   1331 <vga_init+0x4f3>
    1335:	83 c4 10             	add    esp,0x10
				if (vi->caps & 8) {
    1338:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    133b:	8b 40 0a             	mov    eax,DWORD PTR [eax+0xa]
    133e:	83 e0 08             	and    eax,0x8
    1341:	85 c0                	test   eax,eax
    1343:	0f 84 ab 00 00 00    	je     13f4 <vga_init+0x5b6>
						putstr("VBE/AF version: ");
    1349:	83 ec 0c             	sub    esp,0xc
    134c:	68 c8 02 00 00       	push   0x2c8
    1351:	e8 fc ff ff ff       	call   1352 <vga_init+0x514>
    1356:	83 c4 10             	add    esp,0x10
						nput32(vi->vbe2.af_version >> 8, 0);
    1359:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    135c:	0f b7 40 22          	movzx  eax,WORD PTR [eax+0x22]
    1360:	66 c1 e8 08          	shr    ax,0x8
    1364:	0f b7 c0             	movzx  eax,ax
    1367:	83 ec 08             	sub    esp,0x8
    136a:	6a 00                	push   0x0
    136c:	50                   	push   eax
    136d:	e8 fc ff ff ff       	call   136e <vga_init+0x530>
    1372:	83 c4 10             	add    esp,0x10
						putstr(".");
    1375:	83 ec 0c             	sub    esp,0xc
    1378:	68 fd 01 00 00       	push   0x1fd
    137d:	e8 fc ff ff ff       	call   137e <vga_init+0x540>
    1382:	83 c4 10             	add    esp,0x10
						nput32(vi->vbe2.af_version & 0xff, 0);
    1385:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1388:	0f b7 40 22          	movzx  eax,WORD PTR [eax+0x22]
    138c:	0f b7 c0             	movzx  eax,ax
    138f:	0f b6 c0             	movzx  eax,al
    1392:	83 ec 08             	sub    esp,0x8
    1395:	6a 00                	push   0x0
    1397:	50                   	push   eax
    1398:	e8 fc ff ff ff       	call   1399 <vga_init+0x55b>
    139d:	83 c4 10             	add    esp,0x10
						put_nl();
    13a0:	e8 fc ff ff ff       	call   13a1 <vga_init+0x563>
						puts("Accelerated video modes:");
    13a5:	83 ec 0c             	sub    esp,0xc
    13a8:	68 d9 02 00 00       	push   0x2d9
    13ad:	e8 fc ff ff ff       	call   13ae <vga_init+0x570>
    13b2:	83 c4 10             	add    esp,0x10
						ml_ct = vga_list_modes(ml_base, (uint16_t*)farchar(vi->vbe2.acc_modes), test);
    13b5:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    13b8:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    13bb:	83 ec 0c             	sub    esp,0xc
    13be:	50                   	push   eax
    13bf:	e8 fc ff ff ff       	call   13c0 <vga_init+0x582>
    13c4:	83 c4 10             	add    esp,0x10
    13c7:	83 ec 04             	sub    esp,0x4
    13ca:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    13cd:	50                   	push   eax
    13ce:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    13d1:	e8 fc ff ff ff       	call   13d2 <vga_init+0x594>
    13d6:	83 c4 10             	add    esp,0x10
    13d9:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						ml_base += ml_ct; /* distinguish accelerated modes */
    13dc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13df:	01 45 e4             	add    DWORD PTR [ebp-0x1c],eax
    13e2:	eb 10                	jmp    13f4 <vga_init+0x5b6>
				}
		} else	
				call_int15(1000000); // 1000 ms
    13e4:	83 ec 0c             	sub    esp,0xc
    13e7:	68 40 42 0f 00       	push   0xf4240
    13ec:	e8 fc ff ff ff       	call   13ed <vga_init+0x5af>
    13f1:	83 c4 10             	add    esp,0x10
				//for (size_t i = 0; i < UINT_MAX / 3; i++);
		puts("Video modes:");
    13f4:	83 ec 0c             	sub    esp,0xc
    13f7:	68 f2 02 00 00       	push   0x2f2
    13fc:	e8 fc ff ff ff       	call   13fd <vga_init+0x5bf>
    1401:	83 c4 10             	add    esp,0x10
		ml_ct += vga_list_modes(ml_base, mode_list, test);
    1404:	83 ec 04             	sub    esp,0x4
    1407:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    140a:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    140d:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1410:	e8 fc ff ff ff       	call   1411 <vga_init+0x5d3>
    1415:	83 c4 10             	add    esp,0x10
    1418:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
    141b:	eb 01                	jmp    141e <vga_init+0x5e0>
				put_nl();
				goto read;
		}
		/* switch to the selected mode */
		if (!switch_to_mode(m))
				goto read;
    141d:	90                   	nop
		num = 0;
    141e:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		putstr("please select mode to use (1-");
    1425:	83 ec 0c             	sub    esp,0xc
    1428:	68 ff 02 00 00       	push   0x2ff
    142d:	e8 fc ff ff ff       	call   142e <vga_init+0x5f0>
    1432:	83 c4 10             	add    esp,0x10
		nput32(ml_ct, 0);
    1435:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1438:	83 ec 08             	sub    esp,0x8
    143b:	6a 00                	push   0x0
    143d:	50                   	push   eax
    143e:	e8 fc ff ff ff       	call   143f <vga_init+0x601>
    1443:	83 c4 10             	add    esp,0x10
		putstr("): ");
    1446:	83 ec 0c             	sub    esp,0xc
    1449:	68 1d 03 00 00       	push   0x31d
    144e:	e8 fc ff ff ff       	call   144f <vga_init+0x611>
    1453:	83 c4 10             	add    esp,0x10
				char c = call_int16(0);
    1456:	83 ec 0c             	sub    esp,0xc
    1459:	6a 00                	push   0x0
    145b:	e8 fc ff ff ff       	call   145c <vga_init+0x61e>
    1460:	83 c4 10             	add    esp,0x10
    1463:	88 45 cb             	mov    BYTE PTR [ebp-0x35],al
				if (c >= '0' && c <= '9') {
    1466:	80 7d cb 2f          	cmp    BYTE PTR [ebp-0x35],0x2f
    146a:	7e 40                	jle    14ac <vga_init+0x66e>
    146c:	80 7d cb 39          	cmp    BYTE PTR [ebp-0x35],0x39
    1470:	7f 3a                	jg     14ac <vga_init+0x66e>
						char* sr = " ";
    1472:	c7 45 c4 96 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x96
						num = 10 * num + (c - '0');
    1479:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    147c:	89 d0                	mov    eax,edx
    147e:	c1 e0 02             	shl    eax,0x2
    1481:	01 d0                	add    eax,edx
    1483:	01 c0                	add    eax,eax
    1485:	89 c2                	mov    edx,eax
    1487:	0f be 45 cb          	movsx  eax,BYTE PTR [ebp-0x35]
    148b:	83 e8 30             	sub    eax,0x30
    148e:	01 d0                	add    eax,edx
    1490:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						sr[0] = c;
    1493:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1496:	0f b6 55 cb          	movzx  edx,BYTE PTR [ebp-0x35]
    149a:	88 10                	mov    BYTE PTR [eax],dl
						putstr(sr);
    149c:	83 ec 0c             	sub    esp,0xc
    149f:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    14a2:	e8 fc ff ff ff       	call   14a3 <vga_init+0x665>
    14a7:	83 c4 10             	add    esp,0x10
				if (c >= '0' && c <= '9') {
    14aa:	eb 40                	jmp    14ec <vga_init+0x6ae>
				} else if (c == '\n' || c == '\r') {
    14ac:	80 7d cb 0a          	cmp    BYTE PTR [ebp-0x35],0xa
    14b0:	74 06                	je     14b8 <vga_init+0x67a>
    14b2:	80 7d cb 0d          	cmp    BYTE PTR [ebp-0x35],0xd
    14b6:	75 0e                	jne    14c6 <vga_init+0x688>
						put_nl();
    14b8:	e8 fc ff ff ff       	call   14b9 <vga_init+0x67b>
						break;
    14bd:	90                   	nop
		if (num > 0 && num < ml_base) {
    14be:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    14c2:	7e 66                	jle    152a <vga_init+0x6ec>
    14c4:	eb 2b                	jmp    14f1 <vga_init+0x6b3>
				} else if (c == '\b') {
    14c6:	80 7d cb 08          	cmp    BYTE PTR [ebp-0x35],0x8
    14ca:	75 8a                	jne    1456 <vga_init+0x618>
						num /= 10;
    14cc:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    14cf:	ba 67 66 66 66       	mov    edx,0x66666667
    14d4:	89 c8                	mov    eax,ecx
    14d6:	f7 ea                	imul   edx
    14d8:	89 d0                	mov    eax,edx
    14da:	c1 f8 02             	sar    eax,0x2
    14dd:	c1 f9 1f             	sar    ecx,0x1f
    14e0:	89 ca                	mov    edx,ecx
    14e2:	29 d0                	sub    eax,edx
    14e4:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						unputc();
    14e7:	e8 fc ff ff ff       	call   14e8 <vga_init+0x6aa>
		do {
    14ec:	e9 65 ff ff ff       	jmp    1456 <vga_init+0x618>
		if (num > 0 && num < ml_base) {
    14f1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    14f4:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
    14f7:	7d 31                	jge    152a <vga_init+0x6ec>
				uint16_t* mp = (uint16_t*)farchar(vi->vbe2.acc_modes);
    14f9:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    14fc:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    14ff:	83 ec 0c             	sub    esp,0xc
    1502:	50                   	push   eax
    1503:	e8 fc ff ff ff       	call   1504 <vga_init+0x6c6>
    1508:	83 c4 10             	add    esp,0x10
    150b:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				m = mp[num - 1];
    150e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1511:	05 ff ff ff 7f       	add    eax,0x7fffffff
    1516:	8d 14 00             	lea    edx,[eax+eax*1]
    1519:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    151c:	01 d0                	add    eax,edx
    151e:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1521:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
		if (num > 0 && num < ml_base) {
    1525:	e9 8f 00 00 00       	jmp    15b9 <vga_init+0x77b>
		} else if (num == 0)
    152a:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    152e:	0f 84 fd 00 00 00    	je     1631 <vga_init+0x7f3>
		else if (num <= ml_ct) {
    1534:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1537:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    153a:	7f 42                	jg     157e <vga_init+0x740>
				uint16_t* mp = mode_list;
    153c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    153f:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				while (num > ml_base) {
    1542:	eb 15                	jmp    1559 <vga_init+0x71b>
						if (*mp++)
    1544:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1547:	8d 50 02             	lea    edx,[eax+0x2]
    154a:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
    154d:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1550:	66 85 c0             	test   ax,ax
    1553:	74 04                	je     1559 <vga_init+0x71b>
								num--;
    1555:	83 6d dc 01          	sub    DWORD PTR [ebp-0x24],0x1
				while (num > ml_base) {
    1559:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    155c:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
    155f:	7f e3                	jg     1544 <vga_init+0x706>
				while (!*mp)
    1561:	eb 04                	jmp    1567 <vga_init+0x729>
						mp++;
    1563:	83 45 d4 02          	add    DWORD PTR [ebp-0x2c],0x2
				while (!*mp)
    1567:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    156a:	0f b7 00             	movzx  eax,WORD PTR [eax]
    156d:	66 85 c0             	test   ax,ax
    1570:	74 f1                	je     1563 <vga_init+0x725>
				m = *mp;
    1572:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1575:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1578:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
    157c:	eb 3b                	jmp    15b9 <vga_init+0x77b>
				putstr("The value ");
    157e:	83 ec 0c             	sub    esp,0xc
    1581:	68 21 03 00 00       	push   0x321
    1586:	e8 fc ff ff ff       	call   1587 <vga_init+0x749>
    158b:	83 c4 10             	add    esp,0x10
				nput32(num, 0);
    158e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1591:	83 ec 08             	sub    esp,0x8
    1594:	6a 00                	push   0x0
    1596:	50                   	push   eax
    1597:	e8 fc ff ff ff       	call   1598 <vga_init+0x75a>
    159c:	83 c4 10             	add    esp,0x10
				puts(" is out of range");
    159f:	83 ec 0c             	sub    esp,0xc
    15a2:	68 2c 03 00 00       	push   0x32c
    15a7:	e8 fc ff ff ff       	call   15a8 <vga_init+0x76a>
    15ac:	83 c4 10             	add    esp,0x10
				put_nl();
    15af:	e8 fc ff ff ff       	call   15b0 <vga_init+0x772>
				goto read;
    15b4:	e9 65 fe ff ff       	jmp    141e <vga_init+0x5e0>
		if (!switch_to_mode(m))
    15b9:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    15bd:	83 ec 0c             	sub    esp,0xc
    15c0:	50                   	push   eax
    15c1:	e8 fc ff ff ff       	call   15c2 <vga_init+0x784>
    15c6:	83 c4 10             	add    esp,0x10
    15c9:	85 c0                	test   eax,eax
    15cb:	0f 84 4c fe ff ff    	je     141d <vga_init+0x5df>

		/* now map the memory */
		void* ptr2 = mm_register_video_memory(mode,
    15d1:	a1 00 00 00 00       	mov    eax,ds:0x0
    15d6:	89 c1                	mov    ecx,eax
    15d8:	bb 00 00 00 00       	mov    ebx,0x0
						(uint32_t)vga_pmem, (uint32_t)vga_pmem_size);
    15dd:	a1 00 00 00 00       	mov    eax,ds:0x0
		void* ptr2 = mm_register_video_memory(mode,
    15e2:	ba 00 00 00 00       	mov    edx,0x0
    15e7:	83 ec 0c             	sub    esp,0xc
    15ea:	53                   	push   ebx
    15eb:	51                   	push   ecx
    15ec:	52                   	push   edx
    15ed:	50                   	push   eax
    15ee:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15f1:	e8 fc ff ff ff       	call   15f2 <vga_init+0x7b4>
    15f6:	83 c4 20             	add    esp,0x20
    15f9:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		/* and copy the video_mode structure */
		video_mode.fnt = (uint32_t)vga_font;
    15fc:	a1 00 00 00 00       	mov    eax,ds:0x0
    1601:	a3 10 00 00 00       	mov    ds:0x10,eax
		video_mode.txt = (uint32_t)FM_VGA_TEST;
    1606:	c7 05 14 00 00 00 00 00 05 00 	mov    DWORD PTR ds:0x14,0x50000
		video_mode.ptr = (uint32_t)ptr2;
    1610:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1613:	a3 18 00 00 00       	mov    ds:0x18,eax
		mem_cpy(FM_VIDEO_MODE, &video_mode, sizeof(video_mode));
    1618:	83 ec 04             	sub    esp,0x4
    161b:	6a 1c                	push   0x1c
    161d:	68 00 00 00 00       	push   0x0
    1622:	68 00 f0 04 00       	push   0x4f000
    1627:	e8 fc ff ff ff       	call   1628 <vga_init+0x7ea>
    162c:	83 c4 10             	add    esp,0x10
    162f:	eb 01                	jmp    1632 <vga_init+0x7f4>
				return;
    1631:	90                   	nop
}
    1632:	8d 65 f8             	lea    esp,[ebp-0x8]
    1635:	5b                   	pop    ebx
    1636:	5f                   	pop    edi
    1637:	5d                   	pop    ebp
    1638:	c3                   	ret
