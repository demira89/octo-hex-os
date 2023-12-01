
ahci.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <bsr>:
		} clh;
		struct ahci_ct_e* entry;
		uint32_t max_prdtl;
}; /* 70bt size -> slab allocator? DONE */

struct ahci_ct_pool {
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 18          	sub    rsp,0x18
       8:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		uint32_t prdt_cap;
		struct ahci_ct_pool* next;
       b:	0f bd 45 ec          	bsr    eax,DWORD PTR [rbp-0x14]
       f:	75 05                	jne    16 <bsr+0x16>
      11:	b8 ff ff ff ff       	mov    eax,0xffffffff
      16:	ff c0                	inc    eax
      18:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		uint32_t mask; /* not alloc always 1 */
		struct ahci_ct_e {
				uint16_t port, slot; /* dbg info? */
				struct ahci_cmdtbl* ptr;
      1b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
				uint64_t pmem;
      1e:	c9                   	leave
      1f:	c3                   	ret

0000000000000020 <bsf>:
		} tables[32];
};
      20:	55                   	push   rbp
      21:	48 89 e5             	mov    rbp,rsp
      24:	48 83 ec 18          	sub    rsp,0x18
      28:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi

/* Forward declarations:
      2b:	0f bc 45 ec          	bsf    eax,DWORD PTR [rbp-0x14]
      2f:	75 05                	jne    36 <bsf+0x16>
      31:	b8 ff ff ff ff       	mov    eax,0xffffffff
      36:	ff c0                	inc    eax
      38:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
 * */
void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st);
void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc);
      3b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
int ahci_handle_command_error(struct ahci_device* ad, struct cmd_ctx* cc, uint32_t tfd);
      3e:	c9                   	leave
      3f:	c3                   	ret

0000000000000040 <__list_add>:
		/* limit is 4MiB per PRDT (BUT! PM!=contiguous) */
find:
		if (!cc->entry) /* else: max_prdtl still valid */
				cc->entry = ahci_find_cmdtbl(ad, ct);
		if (cc->entry) {
				cc->entry->port = cc->port;
      40:	55                   	push   rbp
      41:	48 89 e5             	mov    rbp,rsp
      44:	48 83 ec 18          	sub    rsp,0x18
      48:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
      4c:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
      50:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
				cc->entry->slot = slt;
      54:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      58:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
      5c:	48 89 10             	mov    QWORD PTR [rax],rdx
				cc->slot = slt;
      5f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      63:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
      67:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		} else
      6b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      6f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      73:	48 89 10             	mov    QWORD PTR [rax],rdx
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);
      76:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      7a:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
      7e:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx

      82:	90                   	nop
      83:	c9                   	leave
      84:	c3                   	ret

0000000000000085 <__list_del>:
		if (!cc->entry && ct > 8) { /* divide by twoish */
				int log = bsr(ct) - 1;
				uint32_t new_ct = (1 << log);
      85:	55                   	push   rbp
      86:	48 89 e5             	mov    rbp,rsp
      89:	48 83 ec 08          	sub    rsp,0x8
      8d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
				if (new_ct == ct)
      91:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      95:	48 8b 00             	mov    rax,QWORD PTR [rax]
      98:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
      9c:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
      a0:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
						new_ct >>= 1;
      a4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      a8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
      ac:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
      b0:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
      b3:	48 89 10             	mov    QWORD PTR [rax],rdx
				ct = new_ct;
      b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      ba:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
				goto find;
      c2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      c6:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		} else if (!cc->entry) { /* none available */
      cd:	90                   	nop
      ce:	c9                   	leave
      cf:	c3                   	ret

00000000000000d0 <list_add>:
				/* skip command processing on this port */
				abprintf("waiting for cmdtbl to become available.\n");
				list_add(&cc->lst, lh);
      d0:	55                   	push   rbp
      d1:	48 89 e5             	mov    rbp,rsp
      d4:	48 83 ec 10          	sub    rsp,0x10
      d8:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
      dc:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
				return;
      e0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      e4:	48 83 c0 10          	add    rax,0x10
      e8:	48 89 c7             	mov    rdi,rax
      eb:	e8 00 00 00 00       	call   f0 <list_add+0x20>
		}
      f0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      f4:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
      f8:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
      fc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     100:	48 89 ce             	mov    rsi,rcx
     103:	48 89 c7             	mov    rdi,rax
     106:	e8 35 ff ff ff       	call   40 <__list_add>

     10b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     10f:	48 83 c0 10          	add    rax,0x10
     113:	48 89 c7             	mov    rdi,rax
     116:	e8 00 00 00 00       	call   11b <list_add+0x4b>
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
     11b:	90                   	nop
     11c:	c9                   	leave
     11d:	c3                   	ret

000000000000011e <list_add_tail>:
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
		/* now build the command */
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
     11e:	55                   	push   rbp
     11f:	48 89 e5             	mov    rbp,rsp
     122:	48 83 ec 10          	sub    rsp,0x10
     126:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     12a:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		if (p->cmd.atapi) { /* ATAPI */
     12e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     132:	48 83 c0 10          	add    rax,0x10
     136:	48 89 c7             	mov    rdi,rax
     139:	e8 00 00 00 00       	call   13e <list_add_tail+0x20>
				switch (cc->c) {
     13e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     142:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     145:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     149:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     14d:	48 89 ce             	mov    rsi,rcx
     150:	48 89 c7             	mov    rdi,rax
     153:	e8 e8 fe ff ff       	call   40 <__list_add>
						case disk_cmd_identify:
     158:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     15c:	48 83 c0 10          	add    rax,0x10
     160:	48 89 c7             	mov    rdi,rax
     163:	e8 00 00 00 00       	call   168 <list_add_tail+0x4a>
								rv = atapi_build_packet_device_identify(ad, cc);
     168:	90                   	nop
     169:	c9                   	leave
     16a:	c3                   	ret

000000000000016b <list_del>:
								break;
						case disk_cmd_read:
						case disk_cmd_write:
     16b:	55                   	push   rbp
     16c:	48 89 e5             	mov    rbp,rsp
     16f:	48 83 ec 10          	sub    rsp,0x10
     173:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     177:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
						case disk_cmd_trim:
     17b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     17f:	48 83 c0 10          	add    rax,0x10
     183:	48 89 c7             	mov    rdi,rax
     186:	e8 00 00 00 00       	call   18b <list_del+0x20>
								die("not implemented yet!\n");
     18b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     18f:	48 89 c7             	mov    rdi,rax
     192:	e8 ee fe ff ff       	call   85 <__list_del>
								break;
     197:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     19b:	48 83 c0 10          	add    rax,0x10
     19f:	48 89 c7             	mov    rdi,rax
     1a2:	e8 00 00 00 00       	call   1a7 <list_del+0x3c>
						default:
     1a7:	90                   	nop
     1a8:	c9                   	leave
     1a9:	c3                   	ret

00000000000001aa <list_empty>:
								die("The command %x should not end up here.\n", cc->c);
								break;
				}
     1aa:	55                   	push   rbp
     1ab:	48 89 e5             	mov    rbp,rsp
     1ae:	48 83 ec 08          	sub    rsp,0x8
     1b2:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		} else {
     1b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ba:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     1be:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
     1c2:	0f 94 c0             	sete   al
     1c5:	0f b6 c0             	movzx  eax,al
				switch (cc->c) { /* ATA */
     1c8:	c9                   	leave
     1c9:	c3                   	ret

00000000000001ca <checksum_memory>:
				}

		//		/* print the STATUS */
		//		cprintf(KFMT_WARN, "STATUS: diag=%x err=%x cmd=%x clb=%x\n",
		//						p->scr1.diag, p->scr1.err, p->pXcmd, p->pXclb);

     1ca:	55                   	push   rbp
     1cb:	48 89 e5             	mov    rbp,rsp
     1ce:	48 83 ec 20          	sub    rsp,0x20
     1d2:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     1d6:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
				/* and tell the IH about it */
     1da:	c6 45 ff 00          	mov    BYTE PTR [rbp-0x1],0x0
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
     1de:	eb 12                	jmp    1f2 <checksum_memory+0x28>
				abprintf("issued the command successfully.\n");
     1e0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     1e4:	48 8d 50 01          	lea    rdx,[rax+0x1]
     1e8:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
     1ec:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     1ef:	00 45 ff             	add    BYTE PTR [rbp-0x1],al
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
     1f2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     1f6:	48 8d 50 ff          	lea    rdx,[rax-0x1]
     1fa:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
     1fe:	48 85 c0             	test   rax,rax
     201:	75 dd                	jne    1e0 <checksum_memory+0x16>
		} else {
     203:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
				/* slot became used: parallel access to
     207:	c9                   	leave
     208:	c3                   	ret

0000000000000209 <convert_ata_string>:
		uint16_t checksum_validity : 8; /* 0xa5 */
		uint16_t checksum : 8; /* sum of all bytes incl. -> 0 */
} __attribute__ ((packed));

static inline void convert_ata_string(uint16_t* str, size_t len)
{
     209:	55                   	push   rbp
     20a:	48 89 e5             	mov    rbp,rsp
     20d:	48 83 ec 20          	sub    rsp,0x20
     211:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     215:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		size_t i; char* s = (char*)str;
     219:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     21d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		for (i = 0; i < len; i++) /* xchg ah, al */
     221:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     229:	eb 48                	jmp    273 <convert_ata_string+0x6a>
				str[i] = ((str[i] >> 8) | (str[i] << 8));
     22b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     22f:	48 8d 14 00          	lea    rdx,[rax+rax*1]
     233:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     237:	48 01 d0             	add    rax,rdx
     23a:	0f b7 00             	movzx  eax,WORD PTR [rax]
     23d:	66 c1 e8 08          	shr    ax,0x8
     241:	89 c1                	mov    ecx,eax
     243:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     247:	48 8d 14 00          	lea    rdx,[rax+rax*1]
     24b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     24f:	48 01 d0             	add    rax,rdx
     252:	0f b7 00             	movzx  eax,WORD PTR [rax]
     255:	c1 e0 08             	shl    eax,0x8
     258:	09 c1                	or     ecx,eax
     25a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     25e:	48 8d 14 00          	lea    rdx,[rax+rax*1]
     262:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     266:	48 01 d0             	add    rax,rdx
     269:	89 ca                	mov    edx,ecx
     26b:	66 89 10             	mov    WORD PTR [rax],dx
		for (i = 0; i < len; i++) /* xchg ah, al */
     26e:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     273:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     277:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
     27b:	72 ae                	jb     22b <convert_ata_string+0x22>
		/* possibly null terminate by eliminating spaces */
		i = 2 * i - 1;
     27d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     281:	48 01 c0             	add    rax,rax
     284:	48 83 e8 01          	sub    rax,0x1
     288:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (i && s[i] == ' ')
     28c:	eb 05                	jmp    293 <convert_ata_string+0x8a>
				i--;
     28e:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
		while (i && s[i] == ' ')
     293:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     298:	74 12                	je     2ac <convert_ata_string+0xa3>
     29a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     29e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2a2:	48 01 d0             	add    rax,rdx
     2a5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     2a8:	3c 20                	cmp    al,0x20
     2aa:	74 e2                	je     28e <convert_ata_string+0x85>
		if (i + 1 < len)
     2ac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2b0:	48 83 c0 01          	add    rax,0x1
     2b4:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
     2b8:	73 12                	jae    2cc <convert_ata_string+0xc3>
				s[i + 1] = '\0';
     2ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2be:	48 8d 50 01          	lea    rdx,[rax+0x1]
     2c2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2c6:	48 01 d0             	add    rax,rdx
     2c9:	c6 00 00             	mov    BYTE PTR [rax],0x0
}
     2cc:	90                   	nop
     2cd:	c9                   	leave
     2ce:	c3                   	ret

00000000000002cf <ata_build_device_identify>:
{
     2cf:	55                   	push   rbp
     2d0:	48 89 e5             	mov    rbp,rsp
     2d3:	48 83 ec 50          	sub    rsp,0x50
     2d7:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     2db:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		struct ahci_cmdtbl* t = ctx->entry->ptr;
     2df:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     2e3:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     2e7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     2eb:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		struct sata_reg_h2d* r = &t->cfis.rh2d;
     2ef:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     2f3:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
     2f7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     2fb:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
     2ff:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
     303:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		uint16_t bc1 = 512, bc2 = 0;
     30b:	66 c7 45 ee 00 02    	mov    WORD PTR [rbp-0x12],0x200
     311:	66 c7 45 ec 00 00    	mov    WORD PTR [rbp-0x14],0x0
		if (ctx->max_prdtl < 1)
     317:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     31b:	8b 80 80 00 00 00    	mov    eax,DWORD PTR [rax+0x80]
     321:	85 c0                	test   eax,eax
     323:	75 0a                	jne    32f <ata_build_device_identify+0x60>
				return -1;
     325:	b8 ff ff ff ff       	mov    eax,0xffffffff
     32a:	e9 de 03 00 00       	jmp    70d <ata_build_device_identify+0x43e>
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
     32f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     333:	8b 80 80 00 00 00    	mov    eax,DWORD PTR [rax+0x80]
     339:	89 c0                	mov    eax,eax
     33b:	48 83 c0 08          	add    rax,0x8
     33f:	48 c1 e0 04          	shl    rax,0x4
     343:	48 89 c2             	mov    rdx,rax
     346:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     34a:	48 89 d6             	mov    rsi,rdx
     34d:	48 89 c7             	mov    rdi,rax
     350:	e8 00 00 00 00       	call   355 <ata_build_device_identify+0x86>
		r->fis_type = FIS_REG_H2D;
     355:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     359:	c6 00 27             	mov    BYTE PTR [rax],0x27
		r->pm_port = ctx->pmprt;
     35c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     360:	0f b7 40 38          	movzx  eax,WORD PTR [rax+0x38]
     364:	83 e0 0f             	and    eax,0xf
     367:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     36b:	83 e0 0f             	and    eax,0xf
     36e:	89 c1                	mov    ecx,eax
     370:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
     374:	83 e0 f0             	and    eax,0xfffffff0
     377:	09 c8                	or     eax,ecx
     379:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
		r->res0 = 0;
     37c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     380:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     384:	83 e2 8f             	and    edx,0xffffff8f
     387:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
		r->c = 1;
     38a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     38e:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     392:	83 ca 80             	or     edx,0xffffff80
     395:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
		r->command = ATA_CMD_IDENTIFY_DEVICE;
     398:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     39c:	c6 40 02 ec          	mov    BYTE PTR [rax+0x2],0xec
		r->feat_high = r->feat_low = 0; /* N/A */
     3a0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3a4:	c6 40 03 00          	mov    BYTE PTR [rax+0x3],0x0
     3a8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3ac:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3]
     3b0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3b4:	88 50 0b             	mov    BYTE PTR [rax+0xb],dl
		r->lba_high = r->lba_low = 0; /* N/A */
     3b7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3bb:	0f b6 50 04          	movzx  edx,BYTE PTR [rax+0x4]
     3bf:	83 e2 00             	and    edx,0x0
     3c2:	88 50 04             	mov    BYTE PTR [rax+0x4],dl
     3c5:	0f b6 50 05          	movzx  edx,BYTE PTR [rax+0x5]
     3c9:	83 e2 00             	and    edx,0x0
     3cc:	88 50 05             	mov    BYTE PTR [rax+0x5],dl
     3cf:	0f b6 50 06          	movzx  edx,BYTE PTR [rax+0x6]
     3d3:	83 e2 00             	and    edx,0x0
     3d6:	88 50 06             	mov    BYTE PTR [rax+0x6],dl
     3d9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3dd:	0f b6 50 04          	movzx  edx,BYTE PTR [rax+0x4]
     3e1:	0f b6 48 05          	movzx  ecx,BYTE PTR [rax+0x5]
     3e5:	48 c1 e1 08          	shl    rcx,0x8
     3e9:	48 09 ca             	or     rdx,rcx
     3ec:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
     3f0:	48 c1 e0 10          	shl    rax,0x10
     3f4:	48 09 d0             	or     rax,rdx
     3f7:	89 c2                	mov    edx,eax
     3f9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3fd:	89 d1                	mov    ecx,edx
     3ff:	0f b6 f1             	movzx  esi,cl
     402:	0f b6 48 08          	movzx  ecx,BYTE PTR [rax+0x8]
     406:	83 e1 00             	and    ecx,0x0
     409:	09 f1                	or     ecx,esi
     40b:	88 48 08             	mov    BYTE PTR [rax+0x8],cl
     40e:	89 d1                	mov    ecx,edx
     410:	c1 e9 08             	shr    ecx,0x8
     413:	89 c9                	mov    ecx,ecx
     415:	0f b6 f1             	movzx  esi,cl
     418:	0f b6 48 09          	movzx  ecx,BYTE PTR [rax+0x9]
     41c:	83 e1 00             	and    ecx,0x0
     41f:	09 f1                	or     ecx,esi
     421:	88 48 09             	mov    BYTE PTR [rax+0x9],cl
     424:	c1 ea 10             	shr    edx,0x10
     427:	89 d2                	mov    edx,edx
     429:	0f b6 ca             	movzx  ecx,dl
     42c:	0f b6 50 0a          	movzx  edx,BYTE PTR [rax+0xa]
     430:	83 e2 00             	and    edx,0x0
     433:	09 ca                	or     edx,ecx
     435:	88 50 0a             	mov    BYTE PTR [rax+0xa],dl
		r->count = 0; /* N/A */
     438:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     43c:	66 c7 40 0c 00 00    	mov    WORD PTR [rax+0xc],0x0
		r->device = 0; /* bit4 is transport dependent */
     442:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     446:	c6 40 07 00          	mov    BYTE PTR [rax+0x7],0x0
		r->icc = 0;
     44a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     44e:	c6 40 0e 00          	mov    BYTE PTR [rax+0xe],0x0
		r->control = 0;
     452:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     456:	c6 40 0f 00          	mov    BYTE PTR [rax+0xf],0x0
		r->res1 = 0;
     45a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     45e:	c7 40 10 00 00 00 00 	mov    DWORD PTR [rax+0x10],0x0
		if (!ptr) {
     465:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
     46a:	75 69                	jne    4d5 <ata_build_device_identify+0x206>
				ptr = ad->identify_data[ctx->entry->port].ptr;
     46c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     470:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     474:	0f b7 00             	movzx  eax,WORD PTR [rax]
     477:	0f b7 c0             	movzx  eax,ax
     47a:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
     47e:	48 63 d0             	movsxd rdx,eax
     481:	48 89 d0             	mov    rax,rdx
     484:	48 01 c0             	add    rax,rax
     487:	48 01 d0             	add    rax,rdx
     48a:	48 c1 e0 03          	shl    rax,0x3
     48e:	48 01 c8             	add    rax,rcx
     491:	48 05 20 02 00 00    	add    rax,0x220
     497:	48 8b 00             	mov    rax,QWORD PTR [rax]
     49a:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				b1 = ad->identify_data[ctx->entry->port].pm;
     49e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     4a2:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     4a6:	0f b7 00             	movzx  eax,WORD PTR [rax]
     4a9:	0f b7 c0             	movzx  eax,ax
     4ac:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
     4b0:	48 63 d0             	movsxd rdx,eax
     4b3:	48 89 d0             	mov    rax,rdx
     4b6:	48 01 c0             	add    rax,rax
     4b9:	48 01 d0             	add    rax,rdx
     4bc:	48 c1 e0 03          	shl    rax,0x3
     4c0:	48 01 c8             	add    rax,rcx
     4c3:	48 05 28 02 00 00    	add    rax,0x228
     4c9:	48 8b 00             	mov    rax,QWORD PTR [rax]
     4cc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     4d0:	e9 9c 00 00 00       	jmp    571 <ata_build_device_identify+0x2a2>
				size_t ofs = (size_t)ptr % 4096;
     4d5:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     4d9:	25 ff 0f 00 00       	and    eax,0xfff
     4de:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				b1 = mm_page_get_pmem(&mm_kernel, ptr);
     4e2:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     4e6:	48 89 c6             	mov    rsi,rax
     4e9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     4f0:	e8 00 00 00 00       	call   4f5 <ata_build_device_identify+0x226>
     4f5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (4096 - ofs < 512) { /* across pages */
     4f9:	b8 00 10 00 00       	mov    eax,0x1000
     4fe:	48 2b 45 c8          	sub    rax,QWORD PTR [rbp-0x38]
     502:	48 3d ff 01 00 00    	cmp    rax,0x1ff
     508:	77 5f                	ja     569 <ata_build_device_identify+0x29a>
						bc1 = 4096 - ofs;
     50a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     50e:	89 c2                	mov    edx,eax
     510:	b8 00 10 00 00       	mov    eax,0x1000
     515:	29 d0                	sub    eax,edx
     517:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
						bc2 = 512 - (4096 - ofs);
     51b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     51f:	66 2d 00 0e          	sub    ax,0xe00
     523:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
						b2 = mm_page_get_pmem(&mm_kernel, ptr + bc1);
     527:	0f b7 55 ee          	movzx  edx,WORD PTR [rbp-0x12]
     52b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     52f:	48 01 d0             	add    rax,rdx
     532:	48 89 c6             	mov    rsi,rax
     535:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     53c:	e8 00 00 00 00       	call   541 <ata_build_device_identify+0x272>
     541:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (b2 == b1 + 4096) {
     545:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     549:	48 05 00 10 00 00    	add    rax,0x1000
     54f:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     553:	75 14                	jne    569 <ata_build_device_identify+0x29a>
								bc1 = 512; bc2 = 0;
     555:	66 c7 45 ee 00 02    	mov    WORD PTR [rbp-0x12],0x200
     55b:	66 c7 45 ec 00 00    	mov    WORD PTR [rbp-0x14],0x0
								b2 = 0;
     561:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				b1 += ofs;
     569:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     56d:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		abprintf("IDENTIFY: %016llx %p\n", ctx->entry->pmem, t);
     571:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     575:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     579:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     57d:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     581:	48 89 c6             	mov    rsi,rax
     584:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     58b:	b8 00 00 00 00       	mov    eax,0x0
     590:	e8 00 00 00 00       	call   595 <ata_build_device_identify+0x2c6>
		abprintf("b1: %016llx\n", b1);
     595:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     599:	48 89 c6             	mov    rsi,rax
     59c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     5a3:	b8 00 00 00 00       	mov    eax,0x0
     5a8:	e8 00 00 00 00       	call   5ad <ata_build_device_identify+0x2de>
		t->prdts[0].dba64 = b1;
     5ad:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5b1:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     5b5:	48 89 90 80 00 00 00 	mov    QWORD PTR [rax+0x80],rdx
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
     5bc:	0f b7 45 ee          	movzx  eax,WORD PTR [rbp-0x12]
     5c0:	83 e8 01             	sub    eax,0x1
     5c3:	25 ff ff 3f 00       	and    eax,0x3fffff
     5c8:	89 c2                	mov    edx,eax
     5ca:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5ce:	89 d1                	mov    ecx,edx
     5d0:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     5d6:	8b 90 8c 00 00 00    	mov    edx,DWORD PTR [rax+0x8c]
     5dc:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     5e2:	09 ca                	or     edx,ecx
     5e4:	89 90 8c 00 00 00    	mov    DWORD PTR [rax+0x8c],edx
		t->prdts[0].I = 1; /* interrupt on completion */
     5ea:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5ee:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [rax+0x8f]
     5f5:	83 ca 80             	or     edx,0xffffff80
     5f8:	88 90 8f 00 00 00    	mov    BYTE PTR [rax+0x8f],dl
		if (b2) {
     5fe:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     603:	74 7e                	je     683 <ata_build_device_identify+0x3b4>
				if (ctx->max_prdtl < 2)
     605:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     609:	8b 80 80 00 00 00    	mov    eax,DWORD PTR [rax+0x80]
     60f:	83 f8 01             	cmp    eax,0x1
     612:	77 0a                	ja     61e <ata_build_device_identify+0x34f>
						return -1; /* TODO: word alignment */
     614:	b8 ff ff ff ff       	mov    eax,0xffffffff
     619:	e9 ef 00 00 00       	jmp    70d <ata_build_device_identify+0x43e>
				t->prdts[1].dba64 = b2;
     61e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     622:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     626:	48 89 90 90 00 00 00 	mov    QWORD PTR [rax+0x90],rdx
				t->prdts[1].dbc = bc2 - 1; /* IDENTIFY returns 512bt */
     62d:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
     631:	83 e8 01             	sub    eax,0x1
     634:	25 ff ff 3f 00       	and    eax,0x3fffff
     639:	89 c2                	mov    edx,eax
     63b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     63f:	89 d1                	mov    ecx,edx
     641:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     647:	8b 90 9c 00 00 00    	mov    edx,DWORD PTR [rax+0x9c]
     64d:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     653:	09 ca                	or     edx,ecx
     655:	89 90 9c 00 00 00    	mov    DWORD PTR [rax+0x9c],edx
				t->prdts[1].I = 1; /* interrupt on completion */
     65b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     65f:	0f b6 90 9f 00 00 00 	movzx  edx,BYTE PTR [rax+0x9f]
     666:	83 ca 80             	or     edx,0xffffff80
     669:	88 90 9f 00 00 00    	mov    BYTE PTR [rax+0x9f],dl
				t->prdts[0].I = 0; /* not too early */
     66f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     673:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [rax+0x8f]
     67a:	83 e2 7f             	and    edx,0x7f
     67d:	88 90 8f 00 00 00    	mov    BYTE PTR [rax+0x8f],dl
		ctx->clh.prdtl = b2 ? 2 : 1;
     683:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     688:	74 07                	je     691 <ata_build_device_identify+0x3c2>
     68a:	ba 02 00 00 00       	mov    edx,0x2
     68f:	eb 05                	jmp    696 <ata_build_device_identify+0x3c7>
     691:	ba 01 00 00 00       	mov    edx,0x1
     696:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     69a:	66 89 50 70          	mov    WORD PTR [rax+0x70],dx
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
     69e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6a2:	0f b7 40 38          	movzx  eax,WORD PTR [rax+0x38]
     6a6:	c1 e0 0c             	shl    eax,0xc
     6a9:	66 0d 05 04          	or     ax,0x405
     6ad:	89 c2                	mov    edx,eax
     6af:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6b3:	66 89 50 72          	mov    WORD PTR [rax+0x72],dx
		ctx->cont_ctx = NULL;
     6b7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6bb:	48 c7 40 60 00 00 00 00 	mov    QWORD PTR [rax+0x60],0x0
		ctx->cur_buf = NULL;
     6c3:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6c7:	48 c7 40 58 00 00 00 00 	mov    QWORD PTR [rax+0x58],0x0
		ctx->bts_left = 0;
     6cf:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6d3:	48 c7 40 68 00 00 00 00 	mov    QWORD PTR [rax+0x68],0x0
		if (ctx->status) {
     6db:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6df:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     6e3:	48 85 c0             	test   rax,rax
     6e6:	74 20                	je     708 <ata_build_device_identify+0x439>
				ctx->status->bts_cur = 0;
     6e8:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6ec:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     6f0:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
				ctx->status->bts_left = 512; /* bts_left in ctx is internal */
     6f8:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     6fc:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     700:	48 c7 40 08 00 02 00 00 	mov    QWORD PTR [rax+0x8],0x200
		return 0;
     708:	b8 00 00 00 00       	mov    eax,0x0
}
     70d:	c9                   	leave
     70e:	c3                   	ret

000000000000070f <atapi_build_packet_device_identify>:
{
     70f:	55                   	push   rbp
     710:	48 89 e5             	mov    rbp,rsp
     713:	48 83 ec 10          	sub    rsp,0x10
     717:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     71b:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		printf("ATAPI IDENTIFY PACKET DEVICE %p %p\n", ad, ctx);
     71f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     723:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     727:	48 89 c6             	mov    rsi,rax
     72a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     731:	b8 00 00 00 00       	mov    eax,0x0
     736:	e8 00 00 00 00       	call   73b <atapi_build_packet_device_identify+0x2c>
		return -1;
     73b:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     740:	c9                   	leave
     741:	c3                   	ret

0000000000000742 <ata_build_read_dma_ext>:
{
     742:	55                   	push   rbp
     743:	48 89 e5             	mov    rbp,rsp
     746:	48 83 ec 40          	sub    rsp,0x40
     74a:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     74e:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		struct ahci_cmdtbl* t = ctx->entry->ptr;
     752:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     756:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     75a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     75e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		struct sata_reg_h2d* r = &t->cfis.rh2d;
     762:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     766:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
     76a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     76e:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
     772:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     776:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		uint16_t bc1 = 512, bc2 = 0;
     77e:	66 c7 45 de 00 02    	mov    WORD PTR [rbp-0x22],0x200
     784:	66 c7 45 dc 00 00    	mov    WORD PTR [rbp-0x24],0x0
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
     78a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     78e:	8b 80 80 00 00 00    	mov    eax,DWORD PTR [rax+0x80]
     794:	89 c0                	mov    eax,eax
     796:	48 83 c0 08          	add    rax,0x8
     79a:	48 c1 e0 04          	shl    rax,0x4
     79e:	48 89 c2             	mov    rdx,rax
     7a1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     7a5:	48 89 d6             	mov    rsi,rdx
     7a8:	48 89 c7             	mov    rdi,rax
     7ab:	e8 00 00 00 00       	call   7b0 <ata_build_read_dma_ext+0x6e>
		r->fis_type = FIS_REG_H2D;
     7b0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7b4:	c6 00 27             	mov    BYTE PTR [rax],0x27
		r->pm_port = ctx->pmprt;
     7b7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     7bb:	0f b7 40 38          	movzx  eax,WORD PTR [rax+0x38]
     7bf:	83 e0 0f             	and    eax,0xf
     7c2:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     7c6:	83 e0 0f             	and    eax,0xf
     7c9:	89 c1                	mov    ecx,eax
     7cb:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
     7cf:	83 e0 f0             	and    eax,0xfffffff0
     7d2:	09 c8                	or     eax,ecx
     7d4:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
		r->res0 = 0;
     7d7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7db:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     7df:	83 e2 8f             	and    edx,0xffffff8f
     7e2:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
		r->c = 1;
     7e5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7e9:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     7ed:	83 ca 80             	or     edx,0xffffff80
     7f0:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
		r->command = ATA_CMD_READ_DMA_EXT;
     7f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7f7:	c6 40 02 25          	mov    BYTE PTR [rax+0x2],0x25
		r->feat_high = r->feat_low = 0; /* reserved */
     7fb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7ff:	c6 40 03 00          	mov    BYTE PTR [rax+0x3],0x0
     803:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     807:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3]
     80b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     80f:	88 50 0b             	mov    BYTE PTR [rax+0xb],dl
		r->lba_high = (uint32_t)((ctx->lba >> 24) & 0x00ffffff);
     812:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     816:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     81a:	48 c1 e8 18          	shr    rax,0x18
     81e:	89 c2                	mov    edx,eax
     820:	81 e2 ff ff ff 00    	and    edx,0xffffff
     826:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     82a:	89 d1                	mov    ecx,edx
     82c:	0f b6 f1             	movzx  esi,cl
     82f:	0f b6 48 08          	movzx  ecx,BYTE PTR [rax+0x8]
     833:	83 e1 00             	and    ecx,0x0
     836:	09 f1                	or     ecx,esi
     838:	88 48 08             	mov    BYTE PTR [rax+0x8],cl
     83b:	89 d1                	mov    ecx,edx
     83d:	c1 e9 08             	shr    ecx,0x8
     840:	89 c9                	mov    ecx,ecx
     842:	0f b6 f1             	movzx  esi,cl
     845:	0f b6 48 09          	movzx  ecx,BYTE PTR [rax+0x9]
     849:	83 e1 00             	and    ecx,0x0
     84c:	09 f1                	or     ecx,esi
     84e:	88 48 09             	mov    BYTE PTR [rax+0x9],cl
     851:	c1 ea 10             	shr    edx,0x10
     854:	89 d2                	mov    edx,edx
     856:	0f b6 ca             	movzx  ecx,dl
     859:	0f b6 50 0a          	movzx  edx,BYTE PTR [rax+0xa]
     85d:	83 e2 00             	and    edx,0x0
     860:	09 ca                	or     edx,ecx
     862:	88 50 0a             	mov    BYTE PTR [rax+0xa],dl
		r->lba_low = (uint32_t)(ctx->lba & 0x00ffffff);
     865:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     869:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     86d:	89 c2                	mov    edx,eax
     86f:	81 e2 ff ff ff 00    	and    edx,0xffffff
     875:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     879:	89 d1                	mov    ecx,edx
     87b:	0f b6 f1             	movzx  esi,cl
     87e:	0f b6 48 04          	movzx  ecx,BYTE PTR [rax+0x4]
     882:	83 e1 00             	and    ecx,0x0
     885:	09 f1                	or     ecx,esi
     887:	88 48 04             	mov    BYTE PTR [rax+0x4],cl
     88a:	89 d1                	mov    ecx,edx
     88c:	c1 e9 08             	shr    ecx,0x8
     88f:	89 c9                	mov    ecx,ecx
     891:	0f b6 f1             	movzx  esi,cl
     894:	0f b6 48 05          	movzx  ecx,BYTE PTR [rax+0x5]
     898:	83 e1 00             	and    ecx,0x0
     89b:	09 f1                	or     ecx,esi
     89d:	88 48 05             	mov    BYTE PTR [rax+0x5],cl
     8a0:	c1 ea 10             	shr    edx,0x10
     8a3:	89 d2                	mov    edx,edx
     8a5:	0f b6 ca             	movzx  ecx,dl
     8a8:	0f b6 50 06          	movzx  edx,BYTE PTR [rax+0x6]
     8ac:	83 e2 00             	and    edx,0x0
     8af:	09 ca                	or     edx,ecx
     8b1:	88 50 06             	mov    BYTE PTR [rax+0x6],dl
		r->count = 1/*ctx->ct / 512*/; /* log sector count (first identify )*/
     8b4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     8b8:	66 c7 40 0c 01 00    	mov    WORD PTR [rax+0xc],0x1
		r->device = (1 << 6); /* bit6 shall be set to one */
     8be:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     8c2:	c6 40 07 40          	mov    BYTE PTR [rax+0x7],0x40
		r->icc = 0;
     8c6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     8ca:	c6 40 0e 00          	mov    BYTE PTR [rax+0xe],0x0
		r->control = 0;
     8ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     8d2:	c6 40 0f 00          	mov    BYTE PTR [rax+0xf],0x0
		r->res1 = 0;
     8d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     8da:	c7 40 10 00 00 00 00 	mov    DWORD PTR [rax+0x10],0x0
		if (!ptr) {
     8e1:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     8e6:	0f 85 47 01 00 00    	jne    a33 <ata_build_read_dma_ext+0x2f1>
				ptr = ad->identify_data[ctx->entry->port].ptr;
     8ec:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     8f0:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     8f4:	0f b7 00             	movzx  eax,WORD PTR [rax]
     8f7:	0f b7 c0             	movzx  eax,ax
     8fa:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
     8fe:	48 63 d0             	movsxd rdx,eax
     901:	48 89 d0             	mov    rax,rdx
     904:	48 01 c0             	add    rax,rax
     907:	48 01 d0             	add    rax,rdx
     90a:	48 c1 e0 03          	shl    rax,0x3
     90e:	48 01 c8             	add    rax,rcx
     911:	48 05 20 02 00 00    	add    rax,0x220
     917:	48 8b 00             	mov    rax,QWORD PTR [rax]
     91a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				b1 = ad->identify_data[ctx->entry->port].pm;
     91e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     922:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     926:	0f b7 00             	movzx  eax,WORD PTR [rax]
     929:	0f b7 c0             	movzx  eax,ax
     92c:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
     930:	48 63 d0             	movsxd rdx,eax
     933:	48 89 d0             	mov    rax,rdx
     936:	48 01 c0             	add    rax,rax
     939:	48 01 d0             	add    rax,rdx
     93c:	48 c1 e0 03          	shl    rax,0x3
     940:	48 01 c8             	add    rax,rcx
     943:	48 05 28 02 00 00    	add    rax,0x228
     949:	48 8b 00             	mov    rax,QWORD PTR [rax]
     94c:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		abprintf("READ DMA EXT: %016llx %p\n", ctx->entry->pmem, t);
     950:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     954:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
     958:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     95c:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     960:	48 89 c6             	mov    rsi,rax
     963:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     96a:	b8 00 00 00 00       	mov    eax,0x0
     96f:	e8 00 00 00 00       	call   974 <ata_build_read_dma_ext+0x232>
		abprintf("b1: %016llx\n", b1);
     974:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     978:	48 89 c6             	mov    rsi,rax
     97b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     982:	b8 00 00 00 00       	mov    eax,0x0
     987:	e8 00 00 00 00       	call   98c <ata_build_read_dma_ext+0x24a>
		t->prdts[0].dba64 = b1;
     98c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     990:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     994:	48 89 90 80 00 00 00 	mov    QWORD PTR [rax+0x80],rdx
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
     99b:	0f b7 45 de          	movzx  eax,WORD PTR [rbp-0x22]
     99f:	83 e8 01             	sub    eax,0x1
     9a2:	25 ff ff 3f 00       	and    eax,0x3fffff
     9a7:	89 c2                	mov    edx,eax
     9a9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     9ad:	89 d1                	mov    ecx,edx
     9af:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     9b5:	8b 90 8c 00 00 00    	mov    edx,DWORD PTR [rax+0x8c]
     9bb:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     9c1:	09 ca                	or     edx,ecx
     9c3:	89 90 8c 00 00 00    	mov    DWORD PTR [rax+0x8c],edx
		t->prdts[0].I = 1; /* interrupt on completion */
     9c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     9cd:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [rax+0x8f]
     9d4:	83 ca 80             	or     edx,0xffffff80
     9d7:	88 90 8f 00 00 00    	mov    BYTE PTR [rax+0x8f],dl
		ctx->clh.prdtl = 1;
     9dd:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     9e1:	66 c7 40 70 01 00    	mov    WORD PTR [rax+0x70],0x1
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
     9e7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     9eb:	0f b7 40 38          	movzx  eax,WORD PTR [rax+0x38]
     9ef:	c1 e0 0c             	shl    eax,0xc
     9f2:	66 0d 05 04          	or     ax,0x405
     9f6:	89 c2                	mov    edx,eax
     9f8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     9fc:	66 89 50 72          	mov    WORD PTR [rax+0x72],dx
		ctx->cont_ctx = NULL;
     a00:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     a04:	48 c7 40 60 00 00 00 00 	mov    QWORD PTR [rax+0x60],0x0
		ctx->cur_buf = NULL;
     a0c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     a10:	48 c7 40 58 00 00 00 00 	mov    QWORD PTR [rax+0x58],0x0
		ctx->bts_left = 0;
     a18:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     a1c:	48 c7 40 68 00 00 00 00 	mov    QWORD PTR [rax+0x68],0x0
		if (ctx->status) {
     a24:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     a28:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     a2c:	48 85 c0             	test   rax,rax
     a2f:	74 52                	je     a83 <ata_build_read_dma_ext+0x341>
     a31:	eb 30                	jmp    a63 <ata_build_read_dma_ext+0x321>
				die("not there yet!\n");
     a33:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     a3a:	bf 0c 00 00 00       	mov    edi,0xc
     a3f:	b8 00 00 00 00       	mov    eax,0x0
     a44:	e8 00 00 00 00       	call   a49 <ata_build_read_dma_ext+0x307>
     a49:	b8 00 00 00 00       	mov    eax,0x0
     a4e:	e8 00 00 00 00       	call   a53 <ata_build_read_dma_ext+0x311>
     a53:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a5a:	e8 00 00 00 00       	call   a5f <ata_build_read_dma_ext+0x31d>
     a5f:	fa                   	cli
     a60:	f4                   	hlt
     a61:	eb fd                	jmp    a60 <ata_build_read_dma_ext+0x31e>
				ctx->status->bts_left = 122123;
     a63:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     a67:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     a6b:	48 c7 40 08 0b dd 01 00 	mov    QWORD PTR [rax+0x8],0x1dd0b
				ctx->status->bts_cur = bc2;
     a73:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     a77:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     a7b:	0f b7 55 dc          	movzx  edx,WORD PTR [rbp-0x24]
     a7f:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		return 0;
     a83:	b8 00 00 00 00       	mov    eax,0x0
}
     a88:	c9                   	leave
     a89:	c3                   	ret

0000000000000a8a <capstr>:
{
     a8a:	55                   	push   rbp
     a8b:	48 89 e5             	mov    rbp,rsp
     a8e:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
     a95:	89 bd 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],edi
     a9b:	89 b5 38 ff ff ff    	mov    DWORD PTR [rbp-0xc8],esi
     aa1:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
     aa8:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
     aaf:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
     ab6:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
     abd:	84 c0                	test   al,al
     abf:	74 20                	je     ae1 <capstr+0x57>
     ac1:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
     ac5:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
     ac9:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
     acd:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
     ad1:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
     ad5:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
     ad9:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
     add:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
		const char** rv = (const char**)(&limit + 1);
     ae1:	48 8d 85 38 ff ff ff 	lea    rax,[rbp-0xc8]
     ae8:	48 83 c0 04          	add    rax,0x4
     aec:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
		return rv[min(idx, limit)];
     af3:	8b 85 38 ff ff ff    	mov    eax,DWORD PTR [rbp-0xc8]
     af9:	39 85 3c ff ff ff    	cmp    DWORD PTR [rbp-0xc4],eax
     aff:	7d 0e                	jge    b0f <capstr+0x85>
     b01:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
     b07:	48 98                	cdqe
     b09:	48 c1 e0 03          	shl    rax,0x3
     b0d:	eb 0c                	jmp    b1b <capstr+0x91>
     b0f:	8b 85 38 ff ff ff    	mov    eax,DWORD PTR [rbp-0xc8]
     b15:	48 98                	cdqe
     b17:	48 c1 e0 03          	shl    rax,0x3
     b1b:	48 8b 95 48 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xb8]
     b22:	48 01 d0             	add    rax,rdx
     b25:	48 8b 00             	mov    rax,QWORD PTR [rax]
}
     b28:	c9                   	leave
     b29:	c3                   	ret

0000000000000b2a <ahci_allocate_context>:
{
     b2a:	55                   	push   rbp
     b2b:	48 89 e5             	mov    rbp,rsp
     b2e:	48 83 ec 30          	sub    rsp,0x30
     b32:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		rv = list_cut_first_entry(&ad->ctxs, struct cmd_ctx, lst);
     b36:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b3a:	48 05 28 0b 00 00    	add    rax,0xb28
     b40:	48 89 c7             	mov    rdi,rax
     b43:	e8 62 f6 ff ff       	call   1aa <list_empty>
     b48:	85 c0                	test   eax,eax
     b4a:	75 6d                	jne    bb9 <ahci_allocate_context+0x8f>
     b4c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b50:	48 05 38 0b 00 00    	add    rax,0xb38
     b56:	48 89 c7             	mov    rdi,rax
     b59:	e8 00 00 00 00       	call   b5e <ahci_allocate_context+0x34>
     b5e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b62:	48 05 28 0b 00 00    	add    rax,0xb28
     b68:	48 89 c7             	mov    rdi,rax
     b6b:	e8 3a f6 ff ff       	call   1aa <list_empty>
     b70:	85 c0                	test   eax,eax
     b72:	75 15                	jne    b89 <ahci_allocate_context+0x5f>
     b74:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b78:	48 8b 80 30 0b 00 00 	mov    rax,QWORD PTR [rax+0xb30]
     b7f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     b83:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     b87:	eb 05                	jmp    b8e <ahci_allocate_context+0x64>
     b89:	b8 00 00 00 00       	mov    eax,0x0
     b8e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     b92:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b97:	74 0c                	je     ba5 <ahci_allocate_context+0x7b>
     b99:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b9d:	48 89 c7             	mov    rdi,rax
     ba0:	e8 e0 f4 ff ff       	call   85 <__list_del>
     ba5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ba9:	48 05 38 0b 00 00    	add    rax,0xb38
     baf:	48 89 c7             	mov    rdi,rax
     bb2:	e8 00 00 00 00       	call   bb7 <ahci_allocate_context+0x8d>
     bb7:	eb 08                	jmp    bc1 <ahci_allocate_context+0x97>
     bb9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     bc1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bc5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!rv)
     bc9:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     bce:	75 0e                	jne    bde <ahci_allocate_context+0xb4>
				rv = kzalloc(sizeof(*rv));
     bd0:	bf 88 00 00 00       	mov    edi,0x88
     bd5:	e8 00 00 00 00       	call   bda <ahci_allocate_context+0xb0>
     bda:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		return rv;
     bde:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
     be2:	c9                   	leave
     be3:	c3                   	ret

0000000000000be4 <ahci_destroy_context>:
{
     be4:	55                   	push   rbp
     be5:	48 89 e5             	mov    rbp,rsp
     be8:	48 83 ec 10          	sub    rsp,0x10
     bec:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     bf0:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		bzero(cc, sizeof(*cc));
     bf4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bf8:	be 88 00 00 00       	mov    esi,0x88
     bfd:	48 89 c7             	mov    rdi,rax
     c00:	e8 00 00 00 00       	call   c05 <ahci_destroy_context+0x21>
		list_add_tail(&cc->lst, &ad->ctxs);
     c05:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c09:	48 8d 90 28 0b 00 00 	lea    rdx,[rax+0xb28]
     c10:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c14:	48 89 d6             	mov    rsi,rdx
     c17:	48 89 c7             	mov    rdi,rax
     c1a:	e8 ff f4 ff ff       	call   11e <list_add_tail>
}
     c1f:	90                   	nop
     c20:	c9                   	leave
     c21:	c3                   	ret

0000000000000c22 <ahci_handle_command_error>:
{
     c22:	55                   	push   rbp
     c23:	48 89 e5             	mov    rbp,rsp
     c26:	48 83 ec 20          	sub    rsp,0x20
     c2a:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     c2e:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     c32:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
		if (cc->c == disk_cmd_identify) {
     c35:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c39:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     c3c:	85 c0                	test   eax,eax
     c3e:	75 07                	jne    c47 <ahci_handle_command_error+0x25>
				return -1;
     c40:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c45:	eb 3d                	jmp    c84 <ahci_handle_command_error+0x62>
				if (cc->status)
     c47:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c4b:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     c4f:	48 85 c0             	test   rax,rax
     c52:	74 0e                	je     c62 <ahci_handle_command_error+0x40>
						cc->status->state = cmd_state_abort;
     c54:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c58:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     c5c:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
				if (cc->wq_wake)
     c62:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c66:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
     c6a:	48 85 c0             	test   rax,rax
     c6d:	74 10                	je     c7f <ahci_handle_command_error+0x5d>
						wake_up_external_event(cc->wq_wake);
     c6f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c73:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
     c77:	48 89 c7             	mov    rdi,rax
     c7a:	e8 00 00 00 00       	call   c7f <ahci_handle_command_error+0x5d>
				return -1;
     c7f:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     c84:	c9                   	leave
     c85:	c3                   	ret

0000000000000c86 <ahci_port_handle_tfes_regular>:
{
     c86:	55                   	push   rbp
     c87:	48 89 e5             	mov    rbp,rsp
     c8a:	48 83 ec 60          	sub    rsp,0x60
     c8e:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     c92:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
     c96:	89 55 ac             	mov    DWORD PTR [rbp-0x54],edx
		uint32_t ci = p->pXci; /* all pending commands */
     c99:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     c9d:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
     ca0:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		uint16_t slt = p->cmd.ccs; /* the offending one */
     ca3:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     ca7:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     caa:	c1 e8 08             	shr    eax,0x8
     cad:	83 e0 1f             	and    eax,0x1f
     cb0:	0f b6 c0             	movzx  eax,al
     cb3:	66 89 45 f2          	mov    WORD PTR [rbp-0xe],ax
		p->cmd.st = 0;
     cb7:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     cbb:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
     cbe:	83 e0 fe             	and    eax,0xfffffffe
     cc1:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		abiprintf("slot which caused task file error: %u\n", slt);
     cc4:	0f b7 45 f2          	movzx  eax,WORD PTR [rbp-0xe]
     cc8:	89 c6                	mov    esi,eax
     cca:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     cd1:	b8 00 00 00 00       	mov    eax,0x0
     cd6:	e8 00 00 00 00       	call   cdb <ahci_port_handle_tfes_regular+0x55>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     cdb:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
     cdf:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     ce2:	48 63 d0             	movsxd rdx,eax
     ce5:	48 89 d0             	mov    rax,rdx
     ce8:	48 01 c0             	add    rax,rax
     ceb:	48 01 d0             	add    rax,rdx
     cee:	48 c1 e0 03          	shl    rax,0x3
     cf2:	48 01 c8             	add    rax,rcx
     cf5:	48 05 28 08 00 00    	add    rax,0x828
     cfb:	48 8b 00             	mov    rax,QWORD PTR [rax]
     cfe:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     d02:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d06:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     d0a:	e9 a1 01 00 00       	jmp    eb0 <ahci_port_handle_tfes_regular+0x22a>
				struct cmd_ctx* cc = cc2; /* we're clearing the list */
     d0f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     d13:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				list_del_and_prepare_continue(cc2, &ad->proc_cmds[pt], lst);
     d17:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     d1b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
     d1f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     d23:	48 8b 00             	mov    rax,QWORD PTR [rax]
     d26:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
     d2a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     d2e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     d32:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     d35:	48 63 d0             	movsxd rdx,eax
     d38:	48 89 d0             	mov    rax,rdx
     d3b:	48 01 c0             	add    rax,rax
     d3e:	48 01 d0             	add    rax,rdx
     d41:	48 c1 e0 03          	shl    rax,0x3
     d45:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
     d4c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d50:	48 01 c2             	add    rdx,rax
     d53:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     d57:	48 89 d6             	mov    rsi,rdx
     d5a:	48 89 c7             	mov    rdi,rax
     d5d:	e8 09 f4 ff ff       	call   16b <list_del>
				abiprintf("inside slt: %u\n", cc->slot);
     d62:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d66:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     d6a:	0f b7 c0             	movzx  eax,ax
     d6d:	89 c6                	mov    esi,eax
     d6f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     d76:	b8 00 00 00 00       	mov    eax,0x0
     d7b:	e8 00 00 00 00       	call   d80 <ahci_port_handle_tfes_regular+0xfa>
				if (cc->slot == slt) {
     d80:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d84:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     d88:	66 39 45 f2          	cmp    WORD PTR [rbp-0xe],ax
     d8c:	0f 85 a8 00 00 00    	jne    e3a <ahci_port_handle_tfes_regular+0x1b4>
								slt, pt, p->tfd.err, p->tfd.sts);
     d92:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d96:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     d99:	0f b6 f0             	movzx  esi,al
								slt, pt, p->tfd.err, p->tfd.sts);
     d9c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     da0:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
     da3:	0f b6 c4             	movzx  eax,ah
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     da6:	0f b6 c8             	movzx  ecx,al
     da9:	0f b7 45 f2          	movzx  eax,WORD PTR [rbp-0xe]
     dad:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
     db0:	41 89 f0             	mov    r8d,esi
     db3:	89 c6                	mov    esi,eax
     db5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     dbc:	b8 00 00 00 00       	mov    eax,0x0
     dc1:	e8 00 00 00 00       	call   dc6 <ahci_port_handle_tfes_regular+0x140>
						if (-1 == ahci_handle_command_error(ad, cc, p->pXtfd)) {
     dc6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     dca:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
     dcd:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     dd1:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     dd5:	48 89 ce             	mov    rsi,rcx
     dd8:	48 89 c7             	mov    rdi,rax
     ddb:	e8 00 00 00 00       	call   de0 <ahci_port_handle_tfes_regular+0x15a>
     de0:	83 f8 ff             	cmp    eax,0xffffffff
     de3:	75 2f                	jne    e14 <ahci_port_handle_tfes_regular+0x18e>
								ahci_release_cmdtbl(ad, cc->entry);
     de5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     de9:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
     ded:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     df1:	48 89 d6             	mov    rsi,rdx
     df4:	48 89 c7             	mov    rdi,rax
     df7:	e8 00 00 00 00       	call   dfc <ahci_port_handle_tfes_regular+0x176>
								ahci_destroy_context(ad, cc);
     dfc:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     e00:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e04:	48 89 d6             	mov    rsi,rdx
     e07:	48 89 c7             	mov    rdi,rax
     e0a:	e8 00 00 00 00       	call   e0f <ahci_port_handle_tfes_regular+0x189>
     e0f:	e9 88 00 00 00       	jmp    e9c <ahci_port_handle_tfes_regular+0x216>
								abiprintf("command reissued.\n");
     e14:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e1b:	b8 00 00 00 00       	mov    eax,0x0
     e20:	e8 00 00 00 00       	call   e25 <ahci_port_handle_tfes_regular+0x19f>
								ahci_reissue_command(ad, cc);
     e25:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     e29:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e2d:	48 89 d6             	mov    rsi,rdx
     e30:	48 89 c7             	mov    rdi,rax
     e33:	e8 00 00 00 00       	call   e38 <ahci_port_handle_tfes_regular+0x1b2>
     e38:	eb 62                	jmp    e9c <ahci_port_handle_tfes_regular+0x216>
						if (ci & (1 << cc->slot)) {
     e3a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     e3e:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     e42:	0f b7 c0             	movzx  eax,ax
     e45:	ba 01 00 00 00       	mov    edx,0x1
     e4a:	89 c1                	mov    ecx,eax
     e4c:	d3 e2                	shl    edx,cl
     e4e:	89 d0                	mov    eax,edx
     e50:	23 45 f4             	and    eax,DWORD PTR [rbp-0xc]
     e53:	85 c0                	test   eax,eax
     e55:	74 15                	je     e6c <ahci_port_handle_tfes_regular+0x1e6>
								ahci_reissue_command(ad, cc);
     e57:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     e5b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e5f:	48 89 d6             	mov    rsi,rdx
     e62:	48 89 c7             	mov    rdi,rax
     e65:	e8 00 00 00 00       	call   e6a <ahci_port_handle_tfes_regular+0x1e4>
     e6a:	eb 30                	jmp    e9c <ahci_port_handle_tfes_regular+0x216>
								die("not implemented\n");
     e6c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     e73:	bf 0c 00 00 00       	mov    edi,0xc
     e78:	b8 00 00 00 00       	mov    eax,0x0
     e7d:	e8 00 00 00 00       	call   e82 <ahci_port_handle_tfes_regular+0x1fc>
     e82:	b8 00 00 00 00       	mov    eax,0x0
     e87:	e8 00 00 00 00       	call   e8c <ahci_port_handle_tfes_regular+0x206>
     e8c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e93:	e8 00 00 00 00       	call   e98 <ahci_port_handle_tfes_regular+0x212>
     e98:	fa                   	cli
     e99:	f4                   	hlt
     e9a:	eb fd                	jmp    e99 <ahci_port_handle_tfes_regular+0x213>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     e9c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ea0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ea4:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
     ea8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     eac:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     eb0:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     eb4:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     eb7:	48 63 d0             	movsxd rdx,eax
     eba:	48 89 d0             	mov    rax,rdx
     ebd:	48 01 c0             	add    rax,rax
     ec0:	48 01 d0             	add    rax,rdx
     ec3:	48 c1 e0 03          	shl    rax,0x3
     ec7:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
     ece:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ed2:	48 01 d0             	add    rax,rdx
     ed5:	48 39 c1             	cmp    rcx,rax
     ed8:	0f 85 31 fe ff ff    	jne    d0f <ahci_port_handle_tfes_regular+0x89>
		ahci_issue_command(ad, pt, 0 /* TODO: handle pmport */, host_cmd_reset,
     ede:	8b 75 ac             	mov    esi,DWORD PTR [rbp-0x54]
     ee1:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ee5:	48 83 ec 08          	sub    rsp,0x8
     ee9:	6a 00                	push   0x0
     eeb:	6a 00                	push   0x0
     eed:	6a 00                	push   0x0
     eef:	41 b9 00 00 00 00    	mov    r9d,0x0
     ef5:	41 b8 00 00 00 00    	mov    r8d,0x0
     efb:	b9 82 00 00 00       	mov    ecx,0x82
     f00:	ba 00 00 00 00       	mov    edx,0x0
     f05:	48 89 c7             	mov    rdi,rax
     f08:	e8 00 00 00 00       	call   f0d <ahci_port_handle_tfes_regular+0x287>
     f0d:	48 83 c4 20          	add    rsp,0x20
}
     f11:	90                   	nop
     f12:	c9                   	leave
     f13:	c3                   	ret

0000000000000f14 <ahci_port_handle_tfes_ncq>:
{
     f14:	55                   	push   rbp
     f15:	48 89 e5             	mov    rbp,rsp
     f18:	48 83 ec 20          	sub    rsp,0x20
     f1c:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     f20:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     f24:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
		die("not implemented!\n");
     f27:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f2e:	bf 0c 00 00 00       	mov    edi,0xc
     f33:	b8 00 00 00 00       	mov    eax,0x0
     f38:	e8 00 00 00 00       	call   f3d <ahci_port_handle_tfes_ncq+0x29>
     f3d:	b8 00 00 00 00       	mov    eax,0x0
     f42:	e8 00 00 00 00       	call   f47 <ahci_port_handle_tfes_ncq+0x33>
     f47:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f4e:	e8 00 00 00 00       	call   f53 <ahci_port_handle_tfes_ncq+0x3f>
     f53:	fa                   	cli
     f54:	f4                   	hlt
     f55:	eb fd                	jmp    f54 <ahci_port_handle_tfes_ncq+0x40>

0000000000000f57 <ahci_port_handle_pcs_cominit>:
{
     f57:	55                   	push   rbp
     f58:	48 89 e5             	mov    rbp,rsp
     f5b:	48 83 ec 20          	sub    rsp,0x20
     f5f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     f63:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     f67:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
		die("not implemented!\n");
     f6a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f71:	bf 0c 00 00 00       	mov    edi,0xc
     f76:	b8 00 00 00 00       	mov    eax,0x0
     f7b:	e8 00 00 00 00       	call   f80 <ahci_port_handle_pcs_cominit+0x29>
     f80:	b8 00 00 00 00       	mov    eax,0x0
     f85:	e8 00 00 00 00       	call   f8a <ahci_port_handle_pcs_cominit+0x33>
     f8a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f91:	e8 00 00 00 00       	call   f96 <ahci_port_handle_pcs_cominit+0x3f>
     f96:	fa                   	cli
     f97:	f4                   	hlt
     f98:	eb fd                	jmp    f97 <ahci_port_handle_pcs_cominit+0x40>

0000000000000f9a <ahci_port_check_finished_commands>:
{
     f9a:	55                   	push   rbp
     f9b:	48 89 e5             	mov    rbp,rsp
     f9e:	48 83 ec 60          	sub    rsp,0x60
     fa2:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     fa6:	89 75 a4             	mov    DWORD PTR [rbp-0x5c],esi
     fa9:	89 55 a0             	mov    DWORD PTR [rbp-0x60],edx
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
     fac:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
     fb0:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     fb3:	48 63 d0             	movsxd rdx,eax
     fb6:	48 89 d0             	mov    rax,rdx
     fb9:	48 01 c0             	add    rax,rax
     fbc:	48 01 d0             	add    rax,rdx
     fbf:	48 c1 e0 03          	shl    rax,0x3
     fc3:	48 01 c8             	add    rax,rcx
     fc6:	48 05 28 08 00 00    	add    rax,0x828
     fcc:	48 8b 00             	mov    rax,QWORD PTR [rax]
     fcf:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     fd3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     fd7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     fdb:	e9 f7 02 00 00       	jmp    12d7 <ahci_port_check_finished_commands+0x33d>
				if (!(ci & (1 << cc->slot))) { /* slot was cleared */
     fe0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fe4:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     fe8:	0f b7 c0             	movzx  eax,ax
     feb:	ba 01 00 00 00       	mov    edx,0x1
     ff0:	89 c1                	mov    ecx,eax
     ff2:	d3 e2                	shl    edx,cl
     ff4:	89 d0                	mov    eax,edx
     ff6:	23 45 a0             	and    eax,DWORD PTR [rbp-0x60]
     ff9:	85 c0                	test   eax,eax
     ffb:	0f 85 a4 02 00 00    	jne    12a5 <ahci_port_check_finished_commands+0x30b>
						uint16_t prdtl; uint32_t bc = 0, bc0 = 0;
    1001:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
    1008:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
						if ((prdtl = d->command_lists[pt]->chdrs[cc->slot].prdtl)) {
    100f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1013:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
    1016:	48 63 d2             	movsxd rdx,edx
    1019:	48 83 c2 02          	add    rdx,0x2
    101d:	48 8b 54 d0 08       	mov    rdx,QWORD PTR [rax+rdx*8+0x8]
    1022:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1026:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
    102a:	0f b7 c0             	movzx  eax,ax
    102d:	48 98                	cdqe
    102f:	48 c1 e0 05          	shl    rax,0x5
    1033:	48 01 d0             	add    rax,rdx
    1036:	48 83 c0 02          	add    rax,0x2
    103a:	0f b7 00             	movzx  eax,WORD PTR [rax]
    103d:	66 89 45 f6          	mov    WORD PTR [rbp-0xa],ax
    1041:	66 83 7d f6 00       	cmp    WORD PTR [rbp-0xa],0x0
    1046:	74 65                	je     10ad <ahci_port_check_finished_commands+0x113>
								bc0 = d->command_lists[pt]->chdrs[cc->slot].prdbc;
    1048:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    104c:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
    104f:	48 63 d2             	movsxd rdx,edx
    1052:	48 83 c2 02          	add    rdx,0x2
    1056:	48 8b 54 d0 08       	mov    rdx,QWORD PTR [rax+rdx*8+0x8]
    105b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    105f:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
    1063:	0f b7 c0             	movzx  eax,ax
    1066:	48 98                	cdqe
    1068:	48 c1 e0 05          	shl    rax,0x5
    106c:	48 01 d0             	add    rax,rdx
    106f:	48 83 c0 04          	add    rax,0x4
    1073:	8b 00                	mov    eax,DWORD PTR [rax]
    1075:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								struct ahci_prdt* pr = cc->entry->ptr->prdts;
    1078:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    107c:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    1080:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1084:	48 83 e8 80          	sub    rax,0xffffffffffffff80
    1088:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
								while (prdtl--)
    108c:	eb 0f                	jmp    109d <ahci_port_check_finished_commands+0x103>
										bc += pr->dbc;
    108e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1092:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    1095:	25 ff ff 3f 00       	and    eax,0x3fffff
    109a:	01 45 f0             	add    DWORD PTR [rbp-0x10],eax
								while (prdtl--)
    109d:	0f b7 45 f6          	movzx  eax,WORD PTR [rbp-0xa]
    10a1:	8d 50 ff             	lea    edx,[rax-0x1]
    10a4:	66 89 55 f6          	mov    WORD PTR [rbp-0xa],dx
    10a8:	66 85 c0             	test   ax,ax
    10ab:	75 e1                	jne    108e <ahci_port_check_finished_commands+0xf4>
						if (!cc->cont_ctx && !cc->bts_left) {
    10ad:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10b1:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
    10b5:	48 85 c0             	test   rax,rax
    10b8:	0f 85 34 01 00 00    	jne    11f2 <ahci_port_check_finished_commands+0x258>
    10be:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10c2:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    10c6:	48 85 c0             	test   rax,rax
    10c9:	0f 85 23 01 00 00    	jne    11f2 <ahci_port_check_finished_commands+0x258>
								if (cc->c == disk_cmd_identify) {
    10cf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10d3:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    10d6:	85 c0                	test   eax,eax
    10d8:	0f 85 87 00 00 00    	jne    1165 <ahci_port_check_finished_commands+0x1cb>
										struct cmd_ctx* cc2 = cc;
    10de:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10e2:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
										abiprintf("identify host command issued\n");
    10e6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    10ed:	b8 00 00 00 00       	mov    eax,0x0
    10f2:	e8 00 00 00 00       	call   10f7 <ahci_port_check_finished_commands+0x15d>
										cc->c = host_cmd_process_identify;
    10f7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10fb:	c7 40 18 80 00 00 00 	mov    DWORD PTR [rax+0x18],0x80
										list_del_and_prepare_continue(cc, &d->proc_cmds[pt], lst);
    1102:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1106:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    110a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    110e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1111:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    1115:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1119:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    111d:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1120:	48 63 d0             	movsxd rdx,eax
    1123:	48 89 d0             	mov    rax,rdx
    1126:	48 01 c0             	add    rax,rax
    1129:	48 01 d0             	add    rax,rdx
    112c:	48 c1 e0 03          	shl    rax,0x3
    1130:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    1137:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    113b:	48 01 c2             	add    rdx,rax
    113e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1142:	48 89 d6             	mov    rsi,rdx
    1145:	48 89 c7             	mov    rdi,rax
    1148:	e8 1e f0 ff ff       	call   16b <list_del>
										ahci_reissue_command(d, cc2); /* worker has to work */
    114d:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1151:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1155:	48 89 d6             	mov    rsi,rdx
    1158:	48 89 c7             	mov    rdi,rax
    115b:	e8 00 00 00 00       	call   1160 <ahci_port_check_finished_commands+0x1c6>
										continue;
    1160:	e9 5e 01 00 00       	jmp    12c3 <ahci_port_check_finished_commands+0x329>
										if (cc->status) {
    1165:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1169:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    116d:	48 85 c0             	test   rax,rax
    1170:	74 33                	je     11a5 <ahci_port_check_finished_commands+0x20b>
												cc->status->state = cmd_state_completed;
    1172:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1176:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    117a:	c7 00 03 00 00 00    	mov    DWORD PTR [rax],0x3
												cc->status->bts_cur = bc;
    1180:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1184:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    1188:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    118b:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
												cc->status->bts_left = bc0 - bc;
    118f:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1192:	2b 45 f0             	sub    eax,DWORD PTR [rbp-0x10]
    1195:	89 c2                	mov    edx,eax
    1197:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    119b:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    119f:	89 d2                	mov    edx,edx
    11a1:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										if (cc->wq_wake)
    11a5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11a9:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    11ad:	48 85 c0             	test   rax,rax
    11b0:	74 10                	je     11c2 <ahci_port_check_finished_commands+0x228>
												wake_up_external_event(cc->wq_wake);
    11b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11b6:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    11ba:	48 89 c7             	mov    rdi,rax
    11bd:	e8 00 00 00 00       	call   11c2 <ahci_port_check_finished_commands+0x228>
								die("command w/o info finished.\n");
    11c2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    11c9:	bf 0c 00 00 00       	mov    edi,0xc
    11ce:	b8 00 00 00 00       	mov    eax,0x0
    11d3:	e8 00 00 00 00       	call   11d8 <ahci_port_check_finished_commands+0x23e>
    11d8:	b8 00 00 00 00       	mov    eax,0x0
    11dd:	e8 00 00 00 00       	call   11e2 <ahci_port_check_finished_commands+0x248>
    11e2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    11e9:	e8 00 00 00 00       	call   11ee <ahci_port_check_finished_commands+0x254>
    11ee:	fa                   	cli
    11ef:	f4                   	hlt
    11f0:	eb fd                	jmp    11ef <ahci_port_check_finished_commands+0x255>
								if (bc0 == bc) {
    11f2:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    11f5:	3b 45 f0             	cmp    eax,DWORD PTR [rbp-0x10]
    11f8:	75 4b                	jne    1245 <ahci_port_check_finished_commands+0x2ab>
										if (cc->status) {
    11fa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11fe:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    1202:	48 85 c0             	test   rax,rax
    1205:	74 6e                	je     1275 <ahci_port_check_finished_commands+0x2db>
												cc->status->bts_cur += bc;
    1207:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    120b:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    120f:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    1213:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    1216:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    121a:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    121e:	48 01 ca             	add    rdx,rcx
    1221:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
												cc->status->bts_left -= bc;
    1225:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1229:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    122d:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
    1231:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    1234:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1238:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    123c:	48 29 d1             	sub    rcx,rdx
    123f:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
    1243:	eb 30                	jmp    1275 <ahci_port_check_finished_commands+0x2db>
										die("incomplete transfer\n"); /* possible by design of intr? */
    1245:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    124c:	bf 0c 00 00 00       	mov    edi,0xc
    1251:	b8 00 00 00 00       	mov    eax,0x0
    1256:	e8 00 00 00 00       	call   125b <ahci_port_check_finished_commands+0x2c1>
    125b:	b8 00 00 00 00       	mov    eax,0x0
    1260:	e8 00 00 00 00       	call   1265 <ahci_port_check_finished_commands+0x2cb>
    1265:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    126c:	e8 00 00 00 00       	call   1271 <ahci_port_check_finished_commands+0x2d7>
    1271:	fa                   	cli
    1272:	f4                   	hlt
    1273:	eb fd                	jmp    1272 <ahci_port_check_finished_commands+0x2d8>
								die("not implemented yet!\n");
    1275:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    127c:	bf 0c 00 00 00       	mov    edi,0xc
    1281:	b8 00 00 00 00       	mov    eax,0x0
    1286:	e8 00 00 00 00       	call   128b <ahci_port_check_finished_commands+0x2f1>
    128b:	b8 00 00 00 00       	mov    eax,0x0
    1290:	e8 00 00 00 00       	call   1295 <ahci_port_check_finished_commands+0x2fb>
    1295:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    129c:	e8 00 00 00 00       	call   12a1 <ahci_port_check_finished_commands+0x307>
    12a1:	fa                   	cli
    12a2:	f4                   	hlt
    12a3:	eb fd                	jmp    12a2 <ahci_port_check_finished_commands+0x308>
						iprintf("slot %u still active\n", cc->slot);
    12a5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12a9:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
    12ad:	0f b7 c0             	movzx  eax,ax
    12b0:	89 c6                	mov    esi,eax
    12b2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    12b9:	b8 00 00 00 00       	mov    eax,0x0
    12be:	e8 00 00 00 00       	call   12c3 <ahci_port_check_finished_commands+0x329>
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
    12c3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12c7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    12cb:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    12cf:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    12d3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    12d7:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    12db:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    12de:	48 63 d0             	movsxd rdx,eax
    12e1:	48 89 d0             	mov    rax,rdx
    12e4:	48 01 c0             	add    rax,rax
    12e7:	48 01 d0             	add    rax,rdx
    12ea:	48 c1 e0 03          	shl    rax,0x3
    12ee:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    12f5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    12f9:	48 01 d0             	add    rax,rdx
    12fc:	48 39 c1             	cmp    rcx,rax
    12ff:	0f 85 db fc ff ff    	jne    fe0 <ahci_port_check_finished_commands+0x46>
}
    1305:	90                   	nop
    1306:	90                   	nop
    1307:	c9                   	leave
    1308:	c3                   	ret

0000000000001309 <ahci_port_intr>:
{
    1309:	55                   	push   rbp
    130a:	48 89 e5             	mov    rbp,rsp
    130d:	48 83 ec 30          	sub    rsp,0x30
    1311:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1315:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		struct ahci_port* p = &d->ptr->port[pt];
    1318:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    131c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1320:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    1323:	48 63 d2             	movsxd rdx,edx
    1326:	48 83 c2 02          	add    rdx,0x2
    132a:	48 c1 e2 07          	shl    rdx,0x7
    132e:	48 01 d0             	add    rax,rdx
    1331:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		uint32_t is = p->pXis, cm = 0; /* unaffected by mask */
    1335:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1339:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    133c:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    133f:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		uint32_t ci = p->pXci; /* check if still set */
    1346:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    134a:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    134d:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		if (is & (1 << 5)) { /* DPS: data processed (PRD&I), commands must use C bit */
    1350:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1353:	83 e0 20             	and    eax,0x20
    1356:	85 c0                	test   eax,eax
    1358:	74 18                	je     1372 <ahci_port_intr+0x69>
				ahci_port_check_finished_commands(d, pt, ci);
    135a:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    135d:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
    1360:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1364:	89 ce                	mov    esi,ecx
    1366:	48 89 c7             	mov    rdi,rax
    1369:	e8 00 00 00 00       	call   136e <ahci_port_intr+0x65>
				cm |= (1 << 5);
    136e:	83 4d fc 20          	or     DWORD PTR [rbp-0x4],0x20
		if (is & (1 << 0)) { /* D2H FIS (more reliable) */
    1372:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1375:	83 e0 01             	and    eax,0x1
    1378:	85 c0                	test   eax,eax
    137a:	74 18                	je     1394 <ahci_port_intr+0x8b>
				ahci_port_check_finished_commands(d, pt, ci);
    137c:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    137f:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
    1382:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1386:	89 ce                	mov    esi,ecx
    1388:	48 89 c7             	mov    rdi,rax
    138b:	e8 00 00 00 00       	call   1390 <ahci_port_intr+0x87>
				cm |= 1;
    1390:	83 4d fc 01          	or     DWORD PTR [rbp-0x4],0x1
		if (is & (1 << 6)) { /* PCS */
    1394:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1397:	83 e0 40             	and    eax,0x40
    139a:	85 c0                	test   eax,eax
    139c:	74 38                	je     13d6 <ahci_port_intr+0xcd>
				abiprintf("PCS on port %d received, resetting...\n", pt);
    139e:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    13a1:	89 c6                	mov    esi,eax
    13a3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    13aa:	b8 00 00 00 00       	mov    eax,0x0
    13af:	e8 00 00 00 00       	call   13b4 <ahci_port_intr+0xab>
				p->pXserr = 0xffffffff;
    13b4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13b8:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
				ahci_reset_port(d->ptr, p);
    13bf:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    13c3:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    13c7:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    13cb:	48 89 d6             	mov    rsi,rdx
    13ce:	48 89 c7             	mov    rdi,rax
    13d1:	e8 00 00 00 00       	call   13d6 <ahci_port_intr+0xcd>
		if (is & (1 << 30)) { /* we need to restart the command engine */
    13d6:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    13d9:	25 00 00 00 40       	and    eax,0x40000000
    13de:	85 c0                	test   eax,eax
    13e0:	74 1d                	je     13ff <ahci_port_intr+0xf6>
				ahci_port_handle_tfes_regular(d, p, pt);
    13e2:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    13e5:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    13e9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    13ed:	48 89 ce             	mov    rsi,rcx
    13f0:	48 89 c7             	mov    rdi,rax
    13f3:	e8 00 00 00 00       	call   13f8 <ahci_port_intr+0xef>
				cm |= (1 << 30);
    13f8:	81 4d fc 00 00 00 40 	or     DWORD PTR [rbp-0x4],0x40000000
		cm |= p->pXie;
    13ff:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1403:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1406:	09 45 fc             	or     DWORD PTR [rbp-0x4],eax
		abiprintf("port cm: %x\n", cm);
    1409:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    140c:	89 c6                	mov    esi,eax
    140e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1415:	b8 00 00 00 00       	mov    eax,0x0
    141a:	e8 00 00 00 00       	call   141f <ahci_port_intr+0x116>
		p->pXis = cm;
    141f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1423:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1426:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
}
    1429:	90                   	nop
    142a:	c9                   	leave
    142b:	c3                   	ret

000000000000142c <ahci_handle_interrupt>:
{
    142c:	55                   	push   rbp
    142d:	48 89 e5             	mov    rbp,rsp
    1430:	48 83 ec 20          	sub    rsp,0x20
    1434:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1438:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		uint32_t is = d->ptr->intr, clm = 0;
    143b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    143f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1443:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1446:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
    1449:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		for (int i = 0; i < 32; i++) {
    1450:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1457:	eb 3b                	jmp    1494 <ahci_handle_interrupt+0x68>
				if (is & (1 << i)) {
    1459:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    145c:	ba 01 00 00 00       	mov    edx,0x1
    1461:	89 c1                	mov    ecx,eax
    1463:	d3 e2                	shl    edx,cl
    1465:	89 d0                	mov    eax,edx
    1467:	23 45 f4             	and    eax,DWORD PTR [rbp-0xc]
    146a:	85 c0                	test   eax,eax
    146c:	74 22                	je     1490 <ahci_handle_interrupt+0x64>
						ahci_port_intr(d, i);
    146e:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1471:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1475:	89 d6                	mov    esi,edx
    1477:	48 89 c7             	mov    rdi,rax
    147a:	e8 00 00 00 00       	call   147f <ahci_handle_interrupt+0x53>
						clm |= (1 << i);
    147f:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1482:	ba 01 00 00 00       	mov    edx,0x1
    1487:	89 c1                	mov    ecx,eax
    1489:	d3 e2                	shl    edx,cl
    148b:	89 d0                	mov    eax,edx
    148d:	09 45 fc             	or     DWORD PTR [rbp-0x4],eax
		for (int i = 0; i < 32; i++) {
    1490:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    1494:	83 7d f8 1f          	cmp    DWORD PTR [rbp-0x8],0x1f
    1498:	7e bf                	jle    1459 <ahci_handle_interrupt+0x2d>
		d->ptr->intr = clm;
    149a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    149e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    14a2:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    14a5:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
}
    14a8:	90                   	nop
    14a9:	c9                   	leave
    14aa:	c3                   	ret

00000000000014ab <ahci_irq>:
{
    14ab:	55                   	push   rbp
    14ac:	48 89 e5             	mov    rbp,rsp
    14af:	48 83 ec 30          	sub    rsp,0x30
    14b3:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    14b6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 14bd <ahci_irq+0x12>
    14bd:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    14c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14c5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    14c9:	e9 8a 00 00 00       	jmp    1558 <ahci_irq+0xad>
				if (d->dev->dev->intr_line == irq) {
    14ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14d2:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    14d6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    14d9:	0f b6 40 09          	movzx  eax,BYTE PTR [rax+0x9]
    14dd:	0f b6 c0             	movzx  eax,al
    14e0:	39 45 dc             	cmp    DWORD PTR [rbp-0x24],eax
    14e3:	75 5f                	jne    1544 <ahci_irq+0x99>
						if (pci_check_interrupt(d->dev->dev)) {
    14e5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14e9:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    14ed:	48 8b 00             	mov    rax,QWORD PTR [rax]
    14f0:	48 89 c7             	mov    rdi,rax
    14f3:	e8 00 00 00 00       	call   14f8 <ahci_irq+0x4d>
    14f8:	85 c0                	test   eax,eax
    14fa:	74 1c                	je     1518 <ahci_irq+0x6d>
								ahci_handle_interrupt(d->dev, irq);
    14fc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1500:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1504:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    1507:	89 d6                	mov    esi,edx
    1509:	48 89 c7             	mov    rdi,rax
    150c:	e8 00 00 00 00       	call   1511 <ahci_irq+0x66>
								return 1;
    1511:	b8 01 00 00 00       	mov    eax,0x1
    1516:	eb 68                	jmp    1580 <ahci_irq+0xd5>
								if (d->dev->ptr->intr) {
    1518:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    151c:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1520:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1524:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1527:	85 c0                	test   eax,eax
    1529:	74 19                	je     1544 <ahci_irq+0x99>
										ahci_handle_interrupt(d->dev, irq);
    152b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    152f:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1533:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    1536:	89 d6                	mov    esi,edx
    1538:	48 89 c7             	mov    rdi,rax
    153b:	e8 00 00 00 00       	call   1540 <ahci_irq+0x95>
										rv++;
    1540:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    1544:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1548:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    154c:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1550:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1554:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1558:	48 81 7d f8 00 00 00 00 	cmp    QWORD PTR [rbp-0x8],0x0
    1560:	0f 85 68 ff ff ff    	jne    14ce <ahci_irq+0x23>
		if (!rv)
    1566:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    156a:	75 11                	jne    157d <ahci_irq+0xd2>
				abiprintf("ignored non AHCI interrupt\n");
    156c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1573:	b8 00 00 00 00       	mov    eax,0x0
    1578:	e8 00 00 00 00       	call   157d <ahci_irq+0xd2>
		return rv;
    157d:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
    1580:	c9                   	leave
    1581:	c3                   	ret

0000000000001582 <ahci_find_slot>:
{
    1582:	55                   	push   rbp
    1583:	48 89 e5             	mov    rbp,rsp
    1586:	48 83 ec 20          	sub    rsp,0x20
    158a:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    158e:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		uint32_t bitmask = (p->pXci/* NCQ: | p->pXsact*/);
    1591:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1595:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    1598:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		for (int i = 0; i < cmd_ct; i++) {
    159b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    15a2:	eb 16                	jmp    15ba <ahci_find_slot+0x38>
				if (!(bitmask & 1))
    15a4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    15a7:	83 e0 01             	and    eax,0x1
    15aa:	85 c0                	test   eax,eax
    15ac:	75 05                	jne    15b3 <ahci_find_slot+0x31>
						return i;
    15ae:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15b1:	eb 14                	jmp    15c7 <ahci_find_slot+0x45>
				bitmask >>= 1;
    15b3:	d1 6d fc             	shr    DWORD PTR [rbp-0x4],1
		for (int i = 0; i < cmd_ct; i++) {
    15b6:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    15ba:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15bd:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
    15c0:	7c e2                	jl     15a4 <ahci_find_slot+0x22>
		return -1;
    15c2:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    15c7:	c9                   	leave
    15c8:	c3                   	ret

00000000000015c9 <ahci_release_cmdtbl>:
{
    15c9:	55                   	push   rbp
    15ca:	48 89 e5             	mov    rbp,rsp
    15cd:	48 83 ec 30          	sub    rsp,0x30
    15d1:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    15d5:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    15d9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    15dd:	48 8b 80 18 05 00 00 	mov    rax,QWORD PTR [rax+0x518]
    15e4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    15e8:	e9 ed 00 00 00       	jmp    16da <ahci_release_cmdtbl+0x111>
				ptrdiff_t ofs = ctp->tables - entry;
    15ed:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15f1:	48 83 c0 18          	add    rax,0x18
    15f5:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
    15f9:	48 c1 f8 03          	sar    rax,0x3
    15fd:	48 89 c2             	mov    rdx,rax
    1600:	48 b8 ab aa aa aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaab
    160a:	48 0f af c2          	imul   rax,rdx
    160e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (ofs >= 0 && ofs < 32) {
    1612:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    1617:	0f 88 b1 00 00 00    	js     16ce <ahci_release_cmdtbl+0x105>
    161d:	48 83 7d f0 1f       	cmp    QWORD PTR [rbp-0x10],0x1f
    1622:	0f 8f a6 00 00 00    	jg     16ce <ahci_release_cmdtbl+0x105>
						uint16_t p = entry->port, slt = entry->slot;
    1628:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    162c:	0f b7 00             	movzx  eax,WORD PTR [rax]
    162f:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
    1633:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1637:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    163b:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
						entry->port = entry->slot = 0xffff;
    163f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1643:	66 c7 40 02 ff ff    	mov    WORD PTR [rax+0x2],0xffff
    1649:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    164d:	0f b7 50 02          	movzx  edx,WORD PTR [rax+0x2]
    1651:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1655:	66 89 10             	mov    WORD PTR [rax],dx
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    1658:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    165c:	ba 01 00 00 00       	mov    edx,0x1
    1661:	89 c1                	mov    ecx,eax
    1663:	d3 e2                	shl    edx,cl
    1665:	89 d0                	mov    eax,edx
    1667:	89 c7                	mov    edi,eax
								~(1 << ofs)))) {
    1669:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    166d:	ba 01 00 00 00       	mov    edx,0x1
    1672:	89 c1                	mov    ecx,eax
    1674:	d3 e2                	shl    edx,cl
    1676:	89 d0                	mov    eax,edx
    1678:	f7 d0                	not    eax
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    167a:	41 89 c0             	mov    r8d,eax
    167d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1681:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1685:	8b 02                	mov    eax,DWORD PTR [rdx]
    1687:	89 c6                	mov    esi,eax
    1689:	89 c1                	mov    ecx,eax
    168b:	44 21 c1             	and    ecx,r8d
    168e:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1692:	0f 94 c1             	sete   cl
    1695:	84 c9                	test   cl,cl
    1697:	74 ee                	je     1687 <ahci_release_cmdtbl+0xbe>
    1699:	89 f8                	mov    eax,edi
    169b:	21 f0                	and    eax,esi
    169d:	85 c0                	test   eax,eax
    169f:	75 46                	jne    16e7 <ahci_release_cmdtbl+0x11e>
								abprintf("attempt to release command table at %p"
    16a1:	0f b7 4d ec          	movzx  ecx,WORD PTR [rbp-0x14]
    16a5:	0f b7 55 ee          	movzx  edx,WORD PTR [rbp-0x12]
    16a9:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    16ad:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    16b1:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    16b5:	49 89 f0             	mov    r8,rsi
    16b8:	48 89 c6             	mov    rsi,rax
    16bb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    16c2:	b8 00 00 00 00       	mov    eax,0x0
    16c7:	e8 00 00 00 00       	call   16cc <ahci_release_cmdtbl+0x103>
						break;
    16cc:	eb 19                	jmp    16e7 <ahci_release_cmdtbl+0x11e>
				ctp = ctp->next;
    16ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16d2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    16d6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    16da:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    16df:	0f 85 08 ff ff ff    	jne    15ed <ahci_release_cmdtbl+0x24>
}
    16e5:	eb 01                	jmp    16e8 <ahci_release_cmdtbl+0x11f>
						break;
    16e7:	90                   	nop
}
    16e8:	90                   	nop
    16e9:	c9                   	leave
    16ea:	c3                   	ret

00000000000016eb <ahci_find_cmdtbl>:
{
    16eb:	55                   	push   rbp
    16ec:	48 89 e5             	mov    rbp,rsp
    16ef:	48 83 ec 20          	sub    rsp,0x20
    16f3:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    16f7:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    16fa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16fe:	48 8b 80 18 05 00 00 	mov    rax,QWORD PTR [rax+0x518]
    1705:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    1709:	e9 a5 00 00 00       	jmp    17b3 <ahci_find_cmdtbl+0xc8>
				if (ctp->prdt_cap >= prdt_ct) {
    170e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1712:	8b 00                	mov    eax,DWORD PTR [rax]
    1714:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
    1717:	0f 82 8a 00 00 00    	jb     17a7 <ahci_find_cmdtbl+0xbc>
Pos1:
    171d:	90                   	nop
						bit = bsf(~ctp->mask); /* 1 based */
    171e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1722:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1725:	f7 d0                	not    eax
    1727:	89 c7                	mov    edi,eax
    1729:	e8 f2 e8 ff ff       	call   20 <bsf>
    172e:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if (bit--) {
    1731:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1734:	8d 50 ff             	lea    edx,[rax-0x1]
    1737:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    173a:	85 c0                	test   eax,eax
    173c:	74 69                	je     17a7 <ahci_find_cmdtbl+0xbc>
								if (!((1 << bit) & __sync_fetch_and_or(&ctp->mask, 1 << bit))) {
    173e:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1741:	ba 01 00 00 00       	mov    edx,0x1
    1746:	89 c1                	mov    ecx,eax
    1748:	d3 e2                	shl    edx,cl
    174a:	89 d0                	mov    eax,edx
    174c:	89 c7                	mov    edi,eax
    174e:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1751:	ba 01 00 00 00       	mov    edx,0x1
    1756:	89 c1                	mov    ecx,eax
    1758:	d3 e2                	shl    edx,cl
    175a:	89 d0                	mov    eax,edx
    175c:	41 89 c0             	mov    r8d,eax
    175f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1763:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1767:	8b 02                	mov    eax,DWORD PTR [rdx]
    1769:	89 c6                	mov    esi,eax
    176b:	89 c1                	mov    ecx,eax
    176d:	44 09 c1             	or     ecx,r8d
    1770:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1774:	0f 94 c1             	sete   cl
    1777:	84 c9                	test   cl,cl
    1779:	74 ee                	je     1769 <ahci_find_cmdtbl+0x7e>
    177b:	89 f8                	mov    eax,edi
    177d:	21 f0                	and    eax,esi
    177f:	85 c0                	test   eax,eax
    1781:	75 9b                	jne    171e <ahci_find_cmdtbl+0x33>
										return &ctp->tables[bit];
    1783:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1786:	48 63 d0             	movsxd rdx,eax
    1789:	48 89 d0             	mov    rax,rdx
    178c:	48 01 c0             	add    rax,rax
    178f:	48 01 d0             	add    rax,rdx
    1792:	48 c1 e0 03          	shl    rax,0x3
    1796:	48 8d 50 10          	lea    rdx,[rax+0x10]
    179a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    179e:	48 01 d0             	add    rax,rdx
    17a1:	48 83 c0 08          	add    rax,0x8
    17a5:	eb 60                	jmp    1807 <ahci_find_cmdtbl+0x11c>
				ctp = ctp->next;
    17a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    17ab:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    17af:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    17b3:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    17b8:	0f 85 50 ff ff ff    	jne    170e <ahci_find_cmdtbl+0x23>
		if (jiffies - warn_time > HZ * 300) {
    17be:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17c5 <ahci_find_cmdtbl+0xda>
    17c5:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    17c8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17cf <ahci_find_cmdtbl+0xe4>
    17cf:	48 29 c2             	sub    rdx,rax
    17d2:	48 81 fa cc 8d 00 00 	cmp    rdx,0x8dcc
    17d9:	76 27                	jbe    1802 <ahci_find_cmdtbl+0x117>
				warn_time = jiffies;
    17db:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17e2 <ahci_find_cmdtbl+0xf7>
    17e2:	48 8b 00             	mov    rax,QWORD PTR [rax]
    17e5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17ec <ahci_find_cmdtbl+0x101>
				cprintf(KFMT_INFO, "Command table pool exhausted.\nI/O performance"
    17ec:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    17f3:	bf 0b 00 00 00       	mov    edi,0xb
    17f8:	b8 00 00 00 00       	mov    eax,0x0
    17fd:	e8 00 00 00 00       	call   1802 <ahci_find_cmdtbl+0x117>
		return NULL;
    1802:	b8 00 00 00 00       	mov    eax,0x0
}
    1807:	c9                   	leave
    1808:	c3                   	ret

0000000000001809 <ahci_process_host_command>:
{
    1809:	55                   	push   rbp
    180a:	48 89 e5             	mov    rbp,rsp
    180d:	48 83 ec 50          	sub    rsp,0x50
    1811:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    1815:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
    1819:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
		switch (cc->c) {
    181d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1821:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1824:	3d 80 00 00 00       	cmp    eax,0x80
    1829:	74 10                	je     183b <ahci_process_host_command+0x32>
    182b:	3d 82 00 00 00       	cmp    eax,0x82
    1830:	0f 84 bd 04 00 00    	je     1cf3 <ahci_process_host_command+0x4ea>
    1836:	e9 d6 05 00 00       	jmp    1e11 <ahci_process_host_command+0x608>
						struct ata_identify* id = ad->identify_data[cc->port].ptr;
    183b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    183f:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    1843:	0f b7 c0             	movzx  eax,ax
    1846:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    184a:	48 63 d0             	movsxd rdx,eax
    184d:	48 89 d0             	mov    rax,rdx
    1850:	48 01 c0             	add    rax,rax
    1853:	48 01 d0             	add    rax,rdx
    1856:	48 c1 e0 03          	shl    rax,0x3
    185a:	48 01 c8             	add    rax,rcx
    185d:	48 05 20 02 00 00    	add    rax,0x220
    1863:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1866:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						int comp = 1, su = 0, pt = cc->port;
    186a:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
    1871:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1878:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    187c:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    1880:	0f b7 c0             	movzx  eax,ax
    1883:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC
    1886:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    188a:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    188e:	66 3d c8 37          	cmp    ax,0x37c8
    1892:	74 0e                	je     18a2 <ahci_process_host_command+0x99>
								|| id->specific_configuration == ATA_SC_NO_SPIN_UP_INC)
    1894:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1898:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    189c:	66 3d 73 8c          	cmp    ax,0x8c73
    18a0:	75 07                	jne    18a9 <ahci_process_host_command+0xa0>
								comp = 0;
    18a2:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP
    18a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18ad:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    18b1:	66 3d 8c 73          	cmp    ax,0x738c
    18b5:	74 0e                	je     18c5 <ahci_process_host_command+0xbc>
								|| id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC)
    18b7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18bb:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    18bf:	66 3d c8 37          	cmp    ax,0x37c8
    18c3:	75 07                	jne    18cc <ahci_process_host_command+0xc3>
								su = 1;
    18c5:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [rbp-0x8],0x1
						if (comp && id->checksum_validity == 0xa5) {
    18cc:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    18d0:	74 70                	je     1942 <ahci_process_host_command+0x139>
    18d2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18d6:	0f b6 80 fe 01 00 00 	movzx  eax,BYTE PTR [rax+0x1fe]
    18dd:	3c a5                	cmp    al,0xa5
    18df:	75 61                	jne    1942 <ahci_process_host_command+0x139>
								if (checksum_memory(id, sizeof(*id))) {
    18e1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18e5:	be 00 02 00 00       	mov    esi,0x200
    18ea:	48 89 c7             	mov    rdi,rax
    18ed:	e8 d8 e8 ff ff       	call   1ca <checksum_memory>
    18f2:	84 c0                	test   al,al
    18f4:	74 4c                	je     1942 <ahci_process_host_command+0x139>
										cc->c = disk_cmd_identify;
    18f6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    18fa:	c7 40 18 00 00 00 00 	mov    DWORD PTR [rax+0x18],0x0
										cc->ptr = NULL;
    1901:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1905:	48 c7 40 30 00 00 00 00 	mov    QWORD PTR [rax+0x30],0x0
										cc->cur_buf = NULL;
    190d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1911:	48 c7 40 58 00 00 00 00 	mov    QWORD PTR [rax+0x58],0x0
										printf("Invalid IDENTIFY received: reissuing...\n");
    1919:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1920:	b8 00 00 00 00       	mov    eax,0x0
    1925:	e8 00 00 00 00       	call   192a <ahci_process_host_command+0x121>
										ahci_reissue_command(ad, cc);
    192a:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    192e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1932:	48 89 d6             	mov    rsi,rdx
    1935:	48 89 c7             	mov    rdi,rax
    1938:	e8 00 00 00 00       	call   193d <ahci_process_host_command+0x134>
										return; /* we reuse cc */
    193d:	e9 33 05 00 00       	jmp    1e75 <ahci_process_host_command+0x66c>
						if (comp) {
    1942:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1946:	0f 84 6d 03 00 00    	je     1cb9 <ahci_process_host_command+0x4b0>
								uint64_t max_sec = 0; uint32_t lpp = 1, lls = 512, lof = 0;
    194c:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1954:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
    195b:	c7 45 e8 00 02 00 00 	mov    DWORD PTR [rbp-0x18],0x200
    1962:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0
    1969:	eb 01                	jmp    196c <ahci_process_host_command+0x163>
								goto is_comp;				
    196b:	90                   	nop
								convert_ata_string(id->model_number, 20);
    196c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1970:	48 83 c0 36          	add    rax,0x36
    1974:	be 14 00 00 00       	mov    esi,0x14
    1979:	48 89 c7             	mov    rdi,rax
    197c:	e8 88 e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->additional_product_identifier, 4);
    1981:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1985:	48 05 54 01 00 00    	add    rax,0x154
    198b:	be 04 00 00 00       	mov    esi,0x4
    1990:	48 89 c7             	mov    rdi,rax
    1993:	e8 71 e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->current_media_manufacturer, 10);
    1998:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    199c:	48 05 88 01 00 00    	add    rax,0x188
    19a2:	be 0a 00 00 00       	mov    esi,0xa
    19a7:	48 89 c7             	mov    rdi,rax
    19aa:	e8 5a e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->current_media_serial_number, 20);
    19af:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19b3:	48 05 60 01 00 00    	add    rax,0x160
    19b9:	be 14 00 00 00       	mov    esi,0x14
    19be:	48 89 c7             	mov    rdi,rax
    19c1:	e8 43 e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->firmware_rev, 4);
    19c6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19ca:	48 83 c0 2e          	add    rax,0x2e
    19ce:	be 04 00 00 00       	mov    esi,0x4
    19d3:	48 89 c7             	mov    rdi,rax
    19d6:	e8 2e e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->serial_number, 10);
    19db:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19df:	48 83 c0 14          	add    rax,0x14
    19e3:	be 0a 00 00 00       	mov    esi,0xa
    19e8:	48 89 c7             	mov    rdi,rax
    19eb:	e8 19 e8 ff ff       	call   209 <convert_ata_string>
								if (!id->lba_supp) {
    19f0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19f4:	0f b6 40 63          	movzx  eax,BYTE PTR [rax+0x63]
    19f8:	83 e0 02             	and    eax,0x2
    19fb:	84 c0                	test   al,al
    19fd:	75 0a                	jne    1a09 <ahci_process_host_command+0x200>
										max_sec = -1; /* CHS? ATAncient */
    19ff:	48 c7 45 f0 ff ff ff ff 	mov    QWORD PTR [rbp-0x10],0xffffffffffffffff
    1a07:	eb 42                	jmp    1a4b <ahci_process_host_command+0x242>
								} else if (id->has_lba48 || id->has_lba48_alt)
    1a09:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a0d:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [rax+0xa7]
    1a14:	83 e0 04             	and    eax,0x4
    1a17:	84 c0                	test   al,al
    1a19:	75 12                	jne    1a2d <ahci_process_host_command+0x224>
    1a1b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a1f:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [rax+0xad]
    1a26:	83 e0 04             	and    eax,0x4
    1a29:	84 c0                	test   al,al
    1a2b:	74 11                	je     1a3e <ahci_process_host_command+0x235>
										max_sec = id->num_logical_sectors;
    1a2d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a31:	48 8b 80 c8 00 00 00 	mov    rax,QWORD PTR [rax+0xc8]
    1a38:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    1a3c:	eb 0d                	jmp    1a4b <ahci_process_host_command+0x242>
										max_sec = id->max_lba28;
    1a3e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a42:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
    1a45:	89 c0                	mov    eax,eax
    1a47:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
								if (id->has_multiple_logical_per_physical_sectors) {
    1a4b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a4f:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [rax+0xd5]
    1a56:	83 e0 20             	and    eax,0x20
    1a59:	84 c0                	test   al,al
    1a5b:	74 1f                	je     1a7c <ahci_process_host_command+0x273>
										lpp = 1 << id->num_pwr2_logical_per_phys;
    1a5d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a61:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [rax+0xd4]
    1a68:	83 e0 0f             	and    eax,0xf
    1a6b:	0f b6 c0             	movzx  eax,al
    1a6e:	ba 01 00 00 00       	mov    edx,0x1
    1a73:	89 c1                	mov    ecx,eax
    1a75:	d3 e2                	shl    edx,cl
    1a77:	89 d0                	mov    eax,edx
    1a79:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								if (id->logical_sector_longer_than_512bt) {
    1a7c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a80:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [rax+0xd5]
    1a87:	83 e0 10             	and    eax,0x10
    1a8a:	84 c0                	test   al,al
    1a8c:	74 31                	je     1abf <ahci_process_host_command+0x2b6>
										lls = 2 * id->logical_sector_size;
    1a8e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a92:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [rax+0xea]
    1a98:	01 c0                	add    eax,eax
    1a9a:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
										lof = id->logical_sector_offset;
    1a9d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1aa1:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [rax+0x1a2]
    1aa8:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [rax+0x1a3]
    1aaf:	83 e0 3f             	and    eax,0x3f
    1ab2:	48 c1 e0 08          	shl    rax,0x8
    1ab6:	48 09 d0             	or     rax,rdx
    1ab9:	0f b7 c0             	movzx  eax,ax
    1abc:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
												(char*)id->current_media_manufacturer, (char*)id->current_media_serial_number);
    1abf:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ac3:	48 8d b8 60 01 00 00 	lea    rdi,[rax+0x160]
    1aca:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ace:	48 8d b0 88 01 00 00 	lea    rsi,[rax+0x188]
												(char*)id->serial_number, (char*)id->firmware_rev,
    1ad5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ad9:	4c 8d 48 2e          	lea    r9,[rax+0x2e]
    1add:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ae1:	4c 8d 40 14          	lea    r8,[rax+0x14]
												pt, (char*)id->model_number, (char*)id->additional_product_identifier,
    1ae5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ae9:	48 8d 88 54 01 00 00 	lea    rcx,[rax+0x154]
    1af0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1af4:	48 8d 50 36          	lea    rdx,[rax+0x36]
								printf("IDENTIFY on port %u: %.40s %.8s %.20s %.8s\nMedia: %.20s %.40s\n",
    1af8:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    1afb:	57                   	push   rdi
    1afc:	56                   	push   rsi
    1afd:	89 c6                	mov    esi,eax
    1aff:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b06:	b8 00 00 00 00       	mov    eax,0x0
    1b0b:	e8 00 00 00 00       	call   1b10 <ahci_process_host_command+0x307>
    1b10:	48 83 c4 10          	add    rsp,0x10
										capstr(id->form_factor, 6, "", "5.25\"", "3.5\"", "2.5\"", "1.8\"", "<1.8\"", ""),
    1b14:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b18:	0f b6 80 50 01 00 00 	movzx  eax,BYTE PTR [rax+0x150]
    1b1f:	83 e0 0f             	and    eax,0xf
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b22:	0f b6 c0             	movzx  eax,al
    1b25:	48 83 ec 08          	sub    rsp,0x8
    1b29:	68 00 00 00 00       	push   0x0
    1b2e:	68 00 00 00 00       	push   0x0
    1b33:	68 00 00 00 00       	push   0x0
    1b38:	49 c7 c1 00 00 00 00 	mov    r9,0x0
    1b3f:	49 c7 c0 00 00 00 00 	mov    r8,0x0
    1b46:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    1b4d:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1b54:	be 06 00 00 00       	mov    esi,0x6
    1b59:	89 c7                	mov    edi,eax
    1b5b:	b8 00 00 00 00       	mov    eax,0x0
    1b60:	e8 00 00 00 00       	call   1b65 <ahci_process_host_command+0x35c>
    1b65:	48 83 c4 20          	add    rsp,0x20
    1b69:	48 89 c7             	mov    rdi,rax
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    1b6c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b70:	0f b6 40 63          	movzx  eax,BYTE PTR [rax+0x63]
    1b74:	83 e0 02             	and    eax,0x2
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b77:	84 c0                	test   al,al
    1b79:	74 24                	je     1b9f <ahci_process_host_command+0x396>
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    1b7b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b7f:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [rax+0xa7]
    1b86:	83 e0 04             	and    eax,0x4
    1b89:	84 c0                	test   al,al
    1b8b:	74 09                	je     1b96 <ahci_process_host_command+0x38d>
    1b8d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1b94:	eb 10                	jmp    1ba6 <ahci_process_host_command+0x39d>
    1b96:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1b9d:	eb 07                	jmp    1ba6 <ahci_process_host_command+0x39d>
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b9f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
										id->ata_version_major, id->ata_version_minor,
    1ba6:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1baa:	0f b7 92 a2 00 00 00 	movzx  edx,WORD PTR [rdx+0xa2]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1bb1:	0f b7 d2             	movzx  edx,dx
										id->ata_version_major, id->ata_version_minor,
    1bb4:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    1bb8:	0f b7 89 a0 00 00 00 	movzx  ecx,WORD PTR [rcx+0xa0]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1bbf:	0f b7 f1             	movzx  esi,cx
    1bc2:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1bc6:	49 89 c9             	mov    r9,rcx
    1bc9:	49 89 f8             	mov    r8,rdi
    1bcc:	48 89 c1             	mov    rcx,rax
    1bcf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1bd6:	b8 00 00 00 00       	mov    eax,0x0
    1bdb:	e8 00 00 00 00       	call   1be0 <ahci_process_host_command+0x3d7>
								printf("Logical sectors: size: %u offset: %u num_per_phys: %u\n", lls, lof, lpp);
    1be0:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
    1be3:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    1be6:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1be9:	89 c6                	mov    esi,eax
    1beb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1bf2:	b8 00 00 00 00       	mov    eax,0x0
    1bf7:	e8 00 00 00 00       	call   1bfc <ahci_process_host_command+0x3f3>
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    1bfc:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1bff:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1c04:	48 c1 e8 28          	shr    rax,0x28
    1c08:	48 89 c7             	mov    rdi,rax
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    1c0b:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1c0e:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1c13:	48 c1 e8 1e          	shr    rax,0x1e
    1c17:	48 89 c6             	mov    rsi,rax
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1c1a:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1c1d:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1c22:	48 c1 e8 14          	shr    rax,0x14
    1c26:	48 89 c1             	mov    rcx,rax
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1c29:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1c2c:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1c31:	48 c1 e8 0a          	shr    rax,0xa
    1c35:	48 89 c2             	mov    rdx,rax
    1c38:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1c3b:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
    1c40:	49 89 f9             	mov    r9,rdi
    1c43:	49 89 f0             	mov    r8,rsi
    1c46:	48 89 c6             	mov    rsi,rax
    1c49:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c50:	b8 00 00 00 00       	mov    eax,0x0
    1c55:	e8 00 00 00 00       	call   1c5a <ahci_process_host_command+0x451>
								if (!id->is_not_ata) {
    1c5a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c5e:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    1c62:	83 e0 80             	and    eax,0xffffff80
    1c65:	84 c0                	test   al,al
    1c67:	0f 85 dd 01 00 00    	jne    1e4a <ahci_process_host_command+0x641>
										if (register_ata_device(ad, p, 0, id))
    1c6d:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1c71:	48 8b 75 c0          	mov    rsi,QWORD PTR [rbp-0x40]
    1c75:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1c79:	48 89 d1             	mov    rcx,rdx
    1c7c:	ba 00 00 00 00       	mov    edx,0x0
    1c81:	48 89 c7             	mov    rdi,rax
    1c84:	e8 00 00 00 00       	call   1c89 <ahci_process_host_command+0x480>
    1c89:	85 c0                	test   eax,eax
    1c8b:	74 16                	je     1ca3 <ahci_process_host_command+0x49a>
												printf("Registered device in file system.\n");
    1c8d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c94:	b8 00 00 00 00       	mov    eax,0x0
    1c99:	e8 00 00 00 00       	call   1c9e <ahci_process_host_command+0x495>
						break;
    1c9e:	e9 a7 01 00 00       	jmp    1e4a <ahci_process_host_command+0x641>
												printf("Failed to register device.\n");
    1ca3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1caa:	b8 00 00 00 00       	mov    eax,0x0
    1caf:	e8 00 00 00 00       	call   1cb4 <ahci_process_host_command+0x4ab>
						break;
    1cb4:	e9 91 01 00 00       	jmp    1e4a <ahci_process_host_command+0x641>
						} else if (su) {
    1cb9:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1cbd:	0f 84 a8 fc ff ff    	je     196b <ahci_process_host_command+0x162>
								die("spin-up by SET FEATURES not supported yet!\n");
    1cc3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1cca:	bf 0c 00 00 00       	mov    edi,0xc
    1ccf:	b8 00 00 00 00       	mov    eax,0x0
    1cd4:	e8 00 00 00 00       	call   1cd9 <ahci_process_host_command+0x4d0>
    1cd9:	b8 00 00 00 00       	mov    eax,0x0
    1cde:	e8 00 00 00 00       	call   1ce3 <ahci_process_host_command+0x4da>
    1ce3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cea:	e8 00 00 00 00       	call   1cef <ahci_process_host_command+0x4e6>
    1cef:	fa                   	cli
    1cf0:	f4                   	hlt
    1cf1:	eb fd                	jmp    1cf0 <ahci_process_host_command+0x4e7>
						int timeout = 50; /* up to 500 ms */
    1cf3:	c7 45 e0 32 00 00 00 	mov    DWORD PTR [rbp-0x20],0x32
						p->cmd.st = 0;
    1cfa:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1cfe:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    1d01:	83 e0 fe             	and    eax,0xfffffffe
    1d04:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						while (p->cmd.cr && timeout--)
    1d07:	eb 0a                	jmp    1d13 <ahci_process_host_command+0x50a>
								mdelay(10);
    1d09:	bf 0a 00 00 00       	mov    edi,0xa
    1d0e:	e8 00 00 00 00       	call   1d13 <ahci_process_host_command+0x50a>
						while (p->cmd.cr && timeout--)
    1d13:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d17:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1d1a:	c1 e8 0f             	shr    eax,0xf
    1d1d:	83 e0 01             	and    eax,0x1
    1d20:	84 c0                	test   al,al
    1d22:	74 0d                	je     1d31 <ahci_process_host_command+0x528>
    1d24:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1d27:	8d 50 ff             	lea    edx,[rax-0x1]
    1d2a:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
    1d2d:	85 c0                	test   eax,eax
    1d2f:	75 d8                	jne    1d09 <ahci_process_host_command+0x500>
						if (p->cmd.cr) {
    1d31:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d35:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1d38:	c1 e8 0f             	shr    eax,0xf
    1d3b:	83 e0 01             	and    eax,0x1
    1d3e:	84 c0                	test   al,al
    1d40:	74 50                	je     1d92 <ahci_process_host_command+0x589>
full_reset:
    1d42:	90                   	nop
    1d43:	eb 01                	jmp    1d46 <ahci_process_host_command+0x53d>
										goto full_reset;
    1d45:	90                   	nop
										p - ad->ptr->port);
    1d46:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1d4a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1d4e:	48 05 00 01 00 00    	add    rax,0x100
    1d54:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1d58:	48 29 c2             	sub    rdx,rax
								abprintf("performing full port reset on port %zd\n",
    1d5b:	48 89 d0             	mov    rax,rdx
    1d5e:	48 c1 f8 07          	sar    rax,0x7
    1d62:	48 89 c6             	mov    rsi,rax
    1d65:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d6c:	b8 00 00 00 00       	mov    eax,0x0
    1d71:	e8 00 00 00 00       	call   1d76 <ahci_process_host_command+0x56d>
								ahci_reset_port(ad->ptr, p);
    1d76:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1d7a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1d7e:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1d82:	48 89 d6             	mov    rsi,rdx
    1d85:	48 89 c7             	mov    rdi,rax
    1d88:	e8 00 00 00 00       	call   1d8d <ahci_process_host_command+0x584>
						break;
    1d8d:	e9 b9 00 00 00       	jmp    1e4b <ahci_process_host_command+0x642>
								p->pXserr = 0xffffffff;
    1d92:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d96:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
								p->pXis = 0xffffffff; /* likewise */
    1d9d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1da1:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [rax+0x10],0xffffffff
								if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    1da8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1dac:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    1daf:	0f b6 c0             	movzx  eax,al
    1db2:	25 88 00 00 00       	and    eax,0x88
    1db7:	85 c0                	test   eax,eax
    1db9:	75 8a                	jne    1d45 <ahci_process_host_command+0x53c>
								p->cmd.st = 1;
    1dbb:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1dbf:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    1dc2:	83 c8 01             	or     eax,0x1
    1dc5:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1dc8:	b8 32 00 00 00       	mov    eax,0x32
    1dcd:	2b 45 e0             	sub    eax,DWORD PTR [rbp-0x20]
    1dd0:	89 c2                	mov    edx,eax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1dd2:	89 d0                	mov    eax,edx
    1dd4:	c1 e0 02             	shl    eax,0x2
    1dd7:	01 d0                	add    eax,edx
    1dd9:	01 c0                	add    eax,eax
    1ddb:	89 c1                	mov    ecx,eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1ddd:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1de1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1de5:	48 05 00 01 00 00    	add    rax,0x100
    1deb:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1def:	48 29 c2             	sub    rdx,rax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1df2:	48 89 d0             	mov    rax,rdx
    1df5:	48 c1 f8 07          	sar    rax,0x7
    1df9:	89 ca                	mov    edx,ecx
    1dfb:	48 89 c6             	mov    rsi,rax
    1dfe:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e05:	b8 00 00 00 00       	mov    eax,0x0
    1e0a:	e8 00 00 00 00       	call   1e0f <ahci_process_host_command+0x606>
						break;
    1e0f:	eb 3a                	jmp    1e4b <ahci_process_host_command+0x642>
						die("someone messed up! command=%x\n", cc->c);
    1e11:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1e15:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1e18:	89 c2                	mov    edx,eax
    1e1a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e21:	bf 0c 00 00 00       	mov    edi,0xc
    1e26:	b8 00 00 00 00       	mov    eax,0x0
    1e2b:	e8 00 00 00 00       	call   1e30 <ahci_process_host_command+0x627>
    1e30:	b8 00 00 00 00       	mov    eax,0x0
    1e35:	e8 00 00 00 00       	call   1e3a <ahci_process_host_command+0x631>
    1e3a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e41:	e8 00 00 00 00       	call   1e46 <ahci_process_host_command+0x63d>
    1e46:	fa                   	cli
    1e47:	f4                   	hlt
    1e48:	eb fd                	jmp    1e47 <ahci_process_host_command+0x63e>
						break;
    1e4a:	90                   	nop
		ahci_release_cmdtbl(ad, cc->entry);
    1e4b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1e4f:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    1e53:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1e57:	48 89 d6             	mov    rsi,rdx
    1e5a:	48 89 c7             	mov    rdi,rax
    1e5d:	e8 00 00 00 00       	call   1e62 <ahci_process_host_command+0x659>
		ahci_destroy_context(ad, cc);
    1e62:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    1e66:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1e6a:	48 89 d6             	mov    rsi,rdx
    1e6d:	48 89 c7             	mov    rdi,rax
    1e70:	e8 00 00 00 00       	call   1e75 <ahci_process_host_command+0x66c>
}
    1e75:	c9                   	leave
    1e76:	c3                   	ret

0000000000001e77 <ahci_process_command>:
{
    1e77:	55                   	push   rbp
    1e78:	48 89 e5             	mov    rbp,rsp
    1e7b:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    1e82:	48 89 7d 88          	mov    QWORD PTR [rbp-0x78],rdi
    1e86:	48 89 75 80          	mov    QWORD PTR [rbp-0x80],rsi
    1e8a:	48 89 95 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdx
		struct cmd_ctx* cc; int slt, rv, pt = p - ad->ptr->port; uint32_t ct;
    1e91:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1e95:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e99:	48 05 00 01 00 00    	add    rax,0x100
    1e9f:	48 8b 55 80          	mov    rdx,QWORD PTR [rbp-0x80]
    1ea3:	48 29 c2             	sub    rdx,rax
    1ea6:	48 89 d0             	mov    rax,rdx
    1ea9:	48 c1 f8 07          	sar    rax,0x7
    1ead:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
		struct ahci_cmdlst* cl = ad->command_lists[pt];
    1eb0:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1eb4:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    1eb7:	48 63 d2             	movsxd rdx,edx
    1eba:	48 83 c2 02          	add    rdx,0x2
    1ebe:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    1ec3:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (!cl)
    1ec7:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    1ecc:	75 18                	jne    1ee6 <ahci_process_command+0x6f>
				abprintf("Ignoring command on port %d as it's command"
    1ece:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1ed1:	89 c6                	mov    esi,eax
    1ed3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1eda:	b8 00 00 00 00       	mov    eax,0x0
    1edf:	e8 00 00 00 00       	call   1ee4 <ahci_process_command+0x6d>
    1ee4:	eb 01                	jmp    1ee7 <ahci_process_command+0x70>
next_cmd:
    1ee6:	90                   	nop
		slt = ahci_find_slot(p, ad->num_cmd); /* does not reserve -> no cleanup */
    1ee7:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1eeb:	0f b7 40 12          	movzx  eax,WORD PTR [rax+0x12]
    1eef:	0f b7 d0             	movzx  edx,ax
    1ef2:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1ef6:	89 d6                	mov    esi,edx
    1ef8:	48 89 c7             	mov    rdi,rax
    1efb:	e8 00 00 00 00       	call   1f00 <ahci_process_command+0x89>
    1f00:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
		if (slt == -1) /* still full */
    1f03:	83 7d c4 ff          	cmp    DWORD PTR [rbp-0x3c],0xffffffff
    1f07:	0f 84 49 07 00 00    	je     2656 <ahci_process_command+0x7df>
		if (!p->cmd.st) {
    1f0d:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1f11:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1f14:	83 e0 01             	and    eax,0x1
    1f17:	84 c0                	test   al,al
    1f19:	0f 85 c6 00 00 00    	jne    1fe5 <ahci_process_command+0x16e>
				abprintf("waiting for reset host command on port %d\n", pt);
    1f1f:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1f22:	89 c6                	mov    esi,eax
    1f24:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f2b:	b8 00 00 00 00       	mov    eax,0x0
    1f30:	e8 00 00 00 00       	call   1f35 <ahci_process_command+0xbe>
				cc = list_cut_first_entry_where(lh, struct cmd_ctx, lst,
    1f35:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    1f3d:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f44:	48 89 c7             	mov    rdi,rax
    1f47:	e8 5e e2 ff ff       	call   1aa <list_empty>
    1f4c:	85 c0                	test   eax,eax
    1f4e:	0f 85 84 00 00 00    	jne    1fd8 <ahci_process_command+0x161>
    1f54:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f5b:	48 83 c0 10          	add    rax,0x10
    1f5f:	48 89 c7             	mov    rdi,rax
    1f62:	e8 00 00 00 00       	call   1f67 <ahci_process_command+0xf0>
    1f67:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f6e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f72:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
    1f76:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1f7a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1f7e:	eb 38                	jmp    1fb8 <ahci_process_command+0x141>
    1f80:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f84:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1f87:	3d 82 00 00 00       	cmp    eax,0x82
    1f8c:	75 16                	jne    1fa4 <ahci_process_command+0x12d>
    1f8e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f92:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f96:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f9a:	48 89 c7             	mov    rdi,rax
    1f9d:	e8 e3 e0 ff ff       	call   85 <__list_del>
    1fa2:	eb 21                	jmp    1fc5 <ahci_process_command+0x14e>
    1fa4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fa8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1fac:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
    1fb0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1fb4:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1fb8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fbc:	48 39 85 78 ff ff ff 	cmp    QWORD PTR [rbp-0x88],rax
    1fc3:	75 bb                	jne    1f80 <ahci_process_command+0x109>
    1fc5:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1fcc:	48 83 c0 10          	add    rax,0x10
    1fd0:	48 89 c7             	mov    rdi,rax
    1fd3:	e8 00 00 00 00       	call   1fd8 <ahci_process_command+0x161>
    1fd8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1fdc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1fe0:	e9 a8 00 00 00       	jmp    208d <ahci_process_command+0x216>
				abprintf("processing command in slot %d on port %d\n", slt, pt);
    1fe5:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    1fe8:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1feb:	89 c6                	mov    esi,eax
    1fed:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ff4:	b8 00 00 00 00       	mov    eax,0x0
    1ff9:	e8 00 00 00 00       	call   1ffe <ahci_process_command+0x187>
				cc = list_cut_first_entry(lh, struct cmd_ctx, lst);
    1ffe:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2005:	48 89 c7             	mov    rdi,rax
    2008:	e8 9d e1 ff ff       	call   1aa <list_empty>
    200d:	85 c0                	test   eax,eax
    200f:	75 6c                	jne    207d <ahci_process_command+0x206>
    2011:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2018:	48 83 c0 10          	add    rax,0x10
    201c:	48 89 c7             	mov    rdi,rax
    201f:	e8 00 00 00 00       	call   2024 <ahci_process_command+0x1ad>
    2024:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    202b:	48 89 c7             	mov    rdi,rax
    202e:	e8 77 e1 ff ff       	call   1aa <list_empty>
    2033:	85 c0                	test   eax,eax
    2035:	75 15                	jne    204c <ahci_process_command+0x1d5>
    2037:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    203e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2042:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2046:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    204a:	eb 05                	jmp    2051 <ahci_process_command+0x1da>
    204c:	b8 00 00 00 00       	mov    eax,0x0
    2051:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    2055:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    205a:	74 0c                	je     2068 <ahci_process_command+0x1f1>
    205c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2060:	48 89 c7             	mov    rdi,rax
    2063:	e8 1d e0 ff ff       	call   85 <__list_del>
    2068:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    206f:	48 83 c0 10          	add    rax,0x10
    2073:	48 89 c7             	mov    rdi,rax
    2076:	e8 00 00 00 00       	call   207b <ahci_process_command+0x204>
    207b:	eb 08                	jmp    2085 <ahci_process_command+0x20e>
    207d:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    2085:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2089:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!cc) { /* the command vanished?/or isn't posted yet */
    208d:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    2092:	75 16                	jne    20aa <ahci_process_command+0x233>
				abprintf("command vanished\n");
    2094:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    209b:	b8 00 00 00 00       	mov    eax,0x0
    20a0:	e8 00 00 00 00       	call   20a5 <ahci_process_command+0x22e>
				return;
    20a5:	e9 ad 05 00 00       	jmp    2657 <ahci_process_command+0x7e0>
		if (cc->c == host_cmd_resend) {
    20aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20ae:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    20b1:	3d 81 00 00 00       	cmp    eax,0x81
    20b6:	75 0c                	jne    20c4 <ahci_process_command+0x24d>
				rv = 0;
    20b8:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
				goto issue;
    20bf:	e9 75 03 00 00       	jmp    2439 <ahci_process_command+0x5c2>
		} else if (cc->c >= host_cmd_process_identify) {
    20c4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20c8:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    20cb:	83 f8 7f             	cmp    eax,0x7f
    20ce:	76 1c                	jbe    20ec <ahci_process_command+0x275>
				ahci_process_host_command(ad, p, cc);
    20d0:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    20d4:	48 8b 4d 80          	mov    rcx,QWORD PTR [rbp-0x80]
    20d8:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    20dc:	48 89 ce             	mov    rsi,rcx
    20df:	48 89 c7             	mov    rdi,rax
    20e2:	e8 00 00 00 00       	call   20e7 <ahci_process_command+0x270>
				goto incr;
    20e7:	e9 44 05 00 00       	jmp    2630 <ahci_process_command+0x7b9>
		if (cc->ptr) {
    20ec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20f0:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    20f4:	48 85 c0             	test   rax,rax
    20f7:	74 6e                	je     2167 <ahci_process_command+0x2f0>
				/*void* ptr2; */uint64_t s = cc->ct;
    20f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20fd:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    2101:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
				ct = rdiv(s, 4096) + 1; /* first guess */
    2105:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2109:	48 c1 e8 0c          	shr    rax,0xc
    210d:	89 c2                	mov    edx,eax
    210f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2113:	25 ff 0f 00 00       	and    eax,0xfff
    2118:	48 85 c0             	test   rax,rax
    211b:	74 07                	je     2124 <ahci_process_command+0x2ad>
    211d:	b8 01 00 00 00       	mov    eax,0x1
    2122:	eb 05                	jmp    2129 <ahci_process_command+0x2b2>
    2124:	b8 00 00 00 00       	mov    eax,0x0
    2129:	01 d0                	add    eax,edx
    212b:	83 c0 01             	add    eax,0x1
    212e:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				if (ct > 8) {
    2131:	83 7d f0 08          	cmp    DWORD PTR [rbp-0x10],0x8
    2135:	76 4b                	jbe    2182 <ahci_process_command+0x30b>
						die("implement this later.\n");
    2137:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    213e:	bf 0c 00 00 00       	mov    edi,0xc
    2143:	b8 00 00 00 00       	mov    eax,0x0
    2148:	e8 00 00 00 00       	call   214d <ahci_process_command+0x2d6>
    214d:	b8 00 00 00 00       	mov    eax,0x0
    2152:	e8 00 00 00 00       	call   2157 <ahci_process_command+0x2e0>
    2157:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    215e:	e8 00 00 00 00       	call   2163 <ahci_process_command+0x2ec>
    2163:	fa                   	cli
    2164:	f4                   	hlt
    2165:	eb fd                	jmp    2164 <ahci_process_command+0x2ed>
		} else if (cc->c == disk_cmd_identify) {
    2167:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    216b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    216e:	85 c0                	test   eax,eax
    2170:	75 09                	jne    217b <ahci_process_command+0x304>
				ct = 1;
    2172:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [rbp-0x10],0x1
    2179:	eb 07                	jmp    2182 <ahci_process_command+0x30b>
				ct = 0;
    217b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
		if (!cc->entry) /* else: max_prdtl still valid */
    2182:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2186:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    218a:	48 85 c0             	test   rax,rax
    218d:	75 19                	jne    21a8 <ahci_process_command+0x331>
				cc->entry = ahci_find_cmdtbl(ad, ct);
    218f:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    2192:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2196:	89 d6                	mov    esi,edx
    2198:	48 89 c7             	mov    rdi,rax
    219b:	e8 00 00 00 00       	call   21a0 <ahci_process_command+0x329>
    21a0:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    21a4:	48 89 42 78          	mov    QWORD PTR [rdx+0x78],rax
		if (cc->entry) {
    21a8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21ac:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    21b0:	48 85 c0             	test   rax,rax
    21b3:	74 31                	je     21e6 <ahci_process_command+0x36f>
				cc->entry->port = cc->port;
    21b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21b9:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    21bd:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    21c1:	0f b7 52 50          	movzx  edx,WORD PTR [rdx+0x50]
    21c5:	66 89 10             	mov    WORD PTR [rax],dx
				cc->entry->slot = slt;
    21c8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21cc:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    21d0:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    21d3:	66 89 50 02          	mov    WORD PTR [rax+0x2],dx
				cc->slot = slt;
    21d7:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    21da:	89 c2                	mov    edx,eax
    21dc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21e0:	66 89 50 52          	mov    WORD PTR [rax+0x52],dx
    21e4:	eb 16                	jmp    21fc <ahci_process_command+0x385>
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);
    21e6:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    21e9:	89 c6                	mov    esi,eax
    21eb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21f2:	b8 00 00 00 00       	mov    eax,0x0
    21f7:	e8 00 00 00 00       	call   21fc <ahci_process_command+0x385>
		if (!cc->entry && ct > 8) { /* divide by twoish */
    21fc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2200:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2204:	48 85 c0             	test   rax,rax
    2207:	75 3d                	jne    2246 <ahci_process_command+0x3cf>
    2209:	83 7d f0 08          	cmp    DWORD PTR [rbp-0x10],0x8
    220d:	76 37                	jbe    2246 <ahci_process_command+0x3cf>
				int log = bsr(ct) - 1;
    220f:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    2212:	89 c7                	mov    edi,eax
    2214:	e8 e7 dd ff ff       	call   0 <bsr>
    2219:	83 e8 01             	sub    eax,0x1
    221c:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
				uint32_t new_ct = (1 << log);
    221f:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2222:	ba 01 00 00 00       	mov    edx,0x1
    2227:	89 c1                	mov    ecx,eax
    2229:	d3 e2                	shl    edx,cl
    222b:	89 d0                	mov    eax,edx
    222d:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
				if (new_ct == ct)
    2230:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    2233:	3b 45 f0             	cmp    eax,DWORD PTR [rbp-0x10]
    2236:	75 03                	jne    223b <ahci_process_command+0x3c4>
						new_ct >>= 1;
    2238:	d1 6d d4             	shr    DWORD PTR [rbp-0x2c],1
				ct = new_ct;
    223b:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    223e:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				goto find;
    2241:	e9 3c ff ff ff       	jmp    2182 <ahci_process_command+0x30b>
		} else if (!cc->entry) { /* none available */
    2246:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    224a:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    224e:	48 85 c0             	test   rax,rax
    2251:	75 2c                	jne    227f <ahci_process_command+0x408>
				abprintf("waiting for cmdtbl to become available.\n");
    2253:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    225a:	b8 00 00 00 00       	mov    eax,0x0
    225f:	e8 00 00 00 00       	call   2264 <ahci_process_command+0x3ed>
				list_add(&cc->lst, lh);
    2264:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2268:	48 8b 95 78 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x88]
    226f:	48 89 d6             	mov    rsi,rdx
    2272:	48 89 c7             	mov    rdi,rax
    2275:	e8 56 de ff ff       	call   d0 <list_add>
				return;
    227a:	e9 d8 03 00 00       	jmp    2657 <ahci_process_command+0x7e0>
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    227f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2283:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2287:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    228b:	0f b7 c8             	movzx  ecx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    228e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2292:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2296:	0f b7 00             	movzx  eax,WORD PTR [rax]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    2299:	0f b7 d0             	movzx  edx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    229c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    22a0:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    22a4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    22a8:	48 89 c6             	mov    rsi,rax
    22ab:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    22b2:	b8 00 00 00 00       	mov    eax,0x0
    22b7:	e8 00 00 00 00       	call   22bc <ahci_process_command+0x445>
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
    22bc:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    22bf:	ba 08 00 00 00       	mov    edx,0x8
    22c4:	39 d0                	cmp    eax,edx
    22c6:	0f 43 d0             	cmovae edx,eax
    22c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    22cd:	89 90 80 00 00 00    	mov    DWORD PTR [rax+0x80],edx
		if (p->cmd.atapi) { /* ATAPI */
    22d3:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    22d7:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    22da:	c1 e8 18             	shr    eax,0x18
    22dd:	83 e0 01             	and    eax,0x1
    22e0:	84 c0                	test   al,al
    22e2:	0f 84 99 00 00 00    	je     2381 <ahci_process_command+0x50a>
				switch (cc->c) {
    22e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    22ec:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    22ef:	85 c0                	test   eax,eax
    22f1:	74 0a                	je     22fd <ahci_process_command+0x486>
    22f3:	83 e8 01             	sub    eax,0x1
    22f6:	83 f8 02             	cmp    eax,0x2
    22f9:	77 4d                	ja     2348 <ahci_process_command+0x4d1>
    22fb:	eb 1b                	jmp    2318 <ahci_process_command+0x4a1>
								rv = atapi_build_packet_device_identify(ad, cc);
    22fd:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2301:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2305:	48 89 d6             	mov    rsi,rdx
    2308:	48 89 c7             	mov    rdi,rax
    230b:	e8 00 00 00 00       	call   2310 <ahci_process_command+0x499>
    2310:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								break;
    2313:	e9 21 01 00 00       	jmp    2439 <ahci_process_command+0x5c2>
								die("not implemented yet!\n");
    2318:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    231f:	bf 0c 00 00 00       	mov    edi,0xc
    2324:	b8 00 00 00 00       	mov    eax,0x0
    2329:	e8 00 00 00 00       	call   232e <ahci_process_command+0x4b7>
    232e:	b8 00 00 00 00       	mov    eax,0x0
    2333:	e8 00 00 00 00       	call   2338 <ahci_process_command+0x4c1>
    2338:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    233f:	e8 00 00 00 00       	call   2344 <ahci_process_command+0x4cd>
    2344:	fa                   	cli
    2345:	f4                   	hlt
    2346:	eb fd                	jmp    2345 <ahci_process_command+0x4ce>
								die("The command %x should not end up here.\n", cc->c);
    2348:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    234c:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    234f:	89 c2                	mov    edx,eax
    2351:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2358:	bf 0c 00 00 00       	mov    edi,0xc
    235d:	b8 00 00 00 00       	mov    eax,0x0
    2362:	e8 00 00 00 00       	call   2367 <ahci_process_command+0x4f0>
    2367:	b8 00 00 00 00       	mov    eax,0x0
    236c:	e8 00 00 00 00       	call   2371 <ahci_process_command+0x4fa>
    2371:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2378:	e8 00 00 00 00       	call   237d <ahci_process_command+0x506>
    237d:	fa                   	cli
    237e:	f4                   	hlt
    237f:	eb fd                	jmp    237e <ahci_process_command+0x507>
				switch (cc->c) { /* ATA */
    2381:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2385:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2388:	83 f8 03             	cmp    eax,0x3
    238b:	77 73                	ja     2400 <ahci_process_command+0x589>
    238d:	83 f8 02             	cmp    eax,0x2
    2390:	73 3e                	jae    23d0 <ahci_process_command+0x559>
    2392:	85 c0                	test   eax,eax
    2394:	74 07                	je     239d <ahci_process_command+0x526>
    2396:	83 f8 01             	cmp    eax,0x1
    2399:	74 1d                	je     23b8 <ahci_process_command+0x541>
    239b:	eb 63                	jmp    2400 <ahci_process_command+0x589>
								rv = ata_build_device_identify(ad, cc);
    239d:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    23a1:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    23a5:	48 89 d6             	mov    rsi,rdx
    23a8:	48 89 c7             	mov    rdi,rax
    23ab:	e8 00 00 00 00       	call   23b0 <ahci_process_command+0x539>
    23b0:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								break;
    23b3:	e9 81 00 00 00       	jmp    2439 <ahci_process_command+0x5c2>
								rv = ata_build_read_dma_ext(ad, cc);
    23b8:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    23bc:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    23c0:	48 89 d6             	mov    rsi,rdx
    23c3:	48 89 c7             	mov    rdi,rax
    23c6:	e8 00 00 00 00       	call   23cb <ahci_process_command+0x554>
    23cb:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								break;
    23ce:	eb 69                	jmp    2439 <ahci_process_command+0x5c2>
								die("not implemented yet!\n");
    23d0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    23d7:	bf 0c 00 00 00       	mov    edi,0xc
    23dc:	b8 00 00 00 00       	mov    eax,0x0
    23e1:	e8 00 00 00 00       	call   23e6 <ahci_process_command+0x56f>
    23e6:	b8 00 00 00 00       	mov    eax,0x0
    23eb:	e8 00 00 00 00       	call   23f0 <ahci_process_command+0x579>
    23f0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    23f7:	e8 00 00 00 00       	call   23fc <ahci_process_command+0x585>
    23fc:	fa                   	cli
    23fd:	f4                   	hlt
    23fe:	eb fd                	jmp    23fd <ahci_process_command+0x586>
								die("The command %x should not end up here.\n", cc->c);
    2400:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2404:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2407:	89 c2                	mov    edx,eax
    2409:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2410:	bf 0c 00 00 00       	mov    edi,0xc
    2415:	b8 00 00 00 00       	mov    eax,0x0
    241a:	e8 00 00 00 00       	call   241f <ahci_process_command+0x5a8>
    241f:	b8 00 00 00 00       	mov    eax,0x0
    2424:	e8 00 00 00 00       	call   2429 <ahci_process_command+0x5b2>
    2429:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2430:	e8 00 00 00 00       	call   2435 <ahci_process_command+0x5be>
    2435:	fa                   	cli
    2436:	f4                   	hlt
    2437:	eb fd                	jmp    2436 <ahci_process_command+0x5bf>
		if (rv) { /* cleanup */
    2439:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    243d:	74 68                	je     24a7 <ahci_process_command+0x630>
				abprintf("ignored malformed command on port %u\n", cc->port);
    243f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2443:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2447:	0f b7 c0             	movzx  eax,ax
    244a:	89 c6                	mov    esi,eax
    244c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2453:	b8 00 00 00 00       	mov    eax,0x0
    2458:	e8 00 00 00 00       	call   245d <ahci_process_command+0x5e6>
				if (cc->status)
    245d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2461:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2465:	48 85 c0             	test   rax,rax
    2468:	74 0e                	je     2478 <ahci_process_command+0x601>
						cc->status->state = cmd_state_abort;
    246a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    246e:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2472:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
				ahci_release_cmdtbl(ad, cc->entry);
    2478:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    247c:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    2480:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2484:	48 89 d6             	mov    rsi,rdx
    2487:	48 89 c7             	mov    rdi,rax
    248a:	e8 00 00 00 00       	call   248f <ahci_process_command+0x618>
				ahci_destroy_context(ad, cc);
    248f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2493:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2497:	48 89 d6             	mov    rsi,rdx
    249a:	48 89 c7             	mov    rdi,rax
    249d:	e8 00 00 00 00       	call   24a2 <ahci_process_command+0x62b>
    24a2:	e9 89 01 00 00       	jmp    2630 <ahci_process_command+0x7b9>
		} else if (!(p->pXci & (1 << slt))) {/* issue it on the port p slot slt */
    24a7:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    24ab:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    24ae:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    24b1:	be 01 00 00 00       	mov    esi,0x1
    24b6:	89 c1                	mov    ecx,eax
    24b8:	d3 e6                	shl    esi,cl
    24ba:	89 f0                	mov    eax,esi
    24bc:	21 d0                	and    eax,edx
    24be:	85 c0                	test   eax,eax
    24c0:	0f 85 3a 01 00 00    	jne    2600 <ahci_process_command+0x789>
				struct ahci_cmdhdr* ch = &ad->command_lists[cc->port]->chdrs[slt];
    24c6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    24ca:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    24ce:	0f b7 d0             	movzx  edx,ax
    24d1:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    24d5:	48 63 d2             	movsxd rdx,edx
    24d8:	48 83 c2 02          	add    rdx,0x2
    24dc:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    24e1:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    24e4:	48 63 d2             	movsxd rdx,edx
    24e7:	48 c1 e2 05          	shl    rdx,0x5
    24eb:	48 01 d0             	add    rax,rdx
    24ee:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
				bzero(ch, sizeof(*ch));
    24f2:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    24f6:	be 20 00 00 00       	mov    esi,0x20
    24fb:	48 89 c7             	mov    rdi,rax
    24fe:	e8 00 00 00 00       	call   2503 <ahci_process_command+0x68c>
				ch->ctba64 = cc->entry->pmem;
    2503:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2507:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    250b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    250f:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2513:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				ch->prdtl = cc->clh.prdtl;
    2517:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    251b:	0f b7 50 70          	movzx  edx,WORD PTR [rax+0x70]
    251f:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2523:	66 89 50 02          	mov    WORD PTR [rax+0x2],dx
				ch->flags = cc->clh.flg;
    2527:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    252b:	0f b7 50 72          	movzx  edx,WORD PTR [rax+0x72]
    252f:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2533:	66 89 10             	mov    WORD PTR [rax],dx
				if (p->cmd.st) {
    2536:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    253a:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    253d:	83 e0 01             	and    eax,0x1
    2540:	84 c0                	test   al,al
    2542:	74 32                	je     2576 <ahci_process_command+0x6ff>
						p->pXci = (1 << slt);
    2544:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    2547:	ba 01 00 00 00       	mov    edx,0x1
    254c:	89 c1                	mov    ecx,eax
    254e:	d3 e2                	shl    edx,cl
    2550:	89 d0                	mov    eax,edx
    2552:	89 c2                	mov    edx,eax
    2554:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2558:	89 50 38             	mov    DWORD PTR [rax+0x38],edx
						if (cc->status)
    255b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    255f:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2563:	48 85 c0             	test   rax,rax
    2566:	74 0e                	je     2576 <ahci_process_command+0x6ff>
								cc->status->state = cmd_state_issued;
    2568:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    256c:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2570:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
				if (!p->cmd.st) {
    2576:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    257a:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    257d:	83 e0 01             	and    eax,0x1
    2580:	84 c0                	test   al,al
    2582:	75 31                	jne    25b5 <ahci_process_command+0x73e>
						abprintf("command will be sent later\n");
    2584:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    258b:	b8 00 00 00 00       	mov    eax,0x0
    2590:	e8 00 00 00 00       	call   2595 <ahci_process_command+0x71e>
						cc->c = host_cmd_resend;
    2595:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2599:	c7 40 18 81 00 00 00 	mov    DWORD PTR [rax+0x18],0x81
						ahci_reissue_command(ad, cc);
    25a0:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    25a4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    25a8:	48 89 d6             	mov    rsi,rdx
    25ab:	48 89 c7             	mov    rdi,rax
    25ae:	e8 00 00 00 00       	call   25b3 <ahci_process_command+0x73c>
						goto incr; /* skip putting into proc_cmds */
    25b3:	eb 7b                	jmp    2630 <ahci_process_command+0x7b9>
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
    25b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    25b9:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    25bd:	0f b7 c0             	movzx  eax,ax
    25c0:	48 63 d0             	movsxd rdx,eax
    25c3:	48 89 d0             	mov    rax,rdx
    25c6:	48 01 c0             	add    rax,rax
    25c9:	48 01 d0             	add    rax,rdx
    25cc:	48 c1 e0 03          	shl    rax,0x3
    25d0:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    25d7:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    25db:	48 01 c2             	add    rdx,rax
    25de:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    25e2:	48 89 d6             	mov    rsi,rdx
    25e5:	48 89 c7             	mov    rdi,rax
    25e8:	e8 31 db ff ff       	call   11e <list_add_tail>
				abprintf("issued the command successfully.\n");
    25ed:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25f4:	b8 00 00 00 00       	mov    eax,0x0
    25f9:	e8 00 00 00 00       	call   25fe <ahci_process_command+0x787>
    25fe:	eb 30                	jmp    2630 <ahci_process_command+0x7b9>
				 * inherently single threaded structure? */
				die("error posting command\n");
    2600:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2607:	bf 0c 00 00 00       	mov    edi,0xc
    260c:	b8 00 00 00 00       	mov    eax,0x0
    2611:	e8 00 00 00 00       	call   2616 <ahci_process_command+0x79f>
    2616:	b8 00 00 00 00       	mov    eax,0x0
    261b:	e8 00 00 00 00       	call   2620 <ahci_process_command+0x7a9>
    2620:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2627:	e8 00 00 00 00       	call   262c <ahci_process_command+0x7b5>
    262c:	fa                   	cli
    262d:	f4                   	hlt
    262e:	eb fd                	jmp    262d <ahci_process_command+0x7b6>
		}

		/* process next command */
incr:
		__sync_fetch_and_sub(&ad->pending_ct, 1);
    2630:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2634:	48 05 20 0b 00 00    	add    rax,0xb20
    263a:	f0 83 28 01          	lock sub DWORD PTR [rax],0x1
		if (!list_empty(lh))
    263e:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2645:	48 89 c7             	mov    rdi,rax
    2648:	e8 5d db ff ff       	call   1aa <list_empty>
    264d:	85 c0                	test   eax,eax
    264f:	75 06                	jne    2657 <ahci_process_command+0x7e0>
				goto next_cmd;
    2651:	e9 91 f8 ff ff       	jmp    1ee7 <ahci_process_command+0x70>
				return;
    2656:	90                   	nop
}
    2657:	c9                   	leave
    2658:	c3                   	ret

0000000000002659 <ahci_worker>:

void ahci_worker(void* dat)
{
    2659:	55                   	push   rbp
    265a:	48 89 e5             	mov    rbp,rsp
    265d:	48 83 ec 30          	sub    rsp,0x30
    2661:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct ahci_device* ad = dat;
    2665:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2669:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax

		printf("AHCI worker is running\n");
    266d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2674:	b8 00 00 00 00       	mov    eax,0x0
    2679:	e8 00 00 00 00       	call   267e <ahci_worker+0x25>
		while (1) {
				uint32_t ps = ad->ptr->ports;
    267e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2682:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2686:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    2689:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    268c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2690:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2694:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2697:	d1 e8                	shr    eax,1
    2699:	83 e0 01             	and    eax,0x1
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    269c:	0f b6 c8             	movzx  ecx,al
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    269f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    26a3:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    26a7:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    26aa:	c1 e8 1f             	shr    eax,0x1f
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    26ad:	0f b6 d0             	movzx  edx,al
    26b0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    26b4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    26b8:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    26bb:	89 c6                	mov    esi,eax
    26bd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    26c4:	b8 00 00 00 00       	mov    eax,0x0
    26c9:	e8 00 00 00 00       	call   26ce <ahci_worker+0x75>
				for (int i = 0; i < 32; i++)
    26ce:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    26d5:	e9 49 01 00 00       	jmp    2823 <ahci_worker+0x1ca>
						if (ps & (1 << i)) {
    26da:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    26dd:	ba 01 00 00 00       	mov    edx,0x1
    26e2:	89 c1                	mov    ecx,eax
    26e4:	d3 e2                	shl    edx,cl
    26e6:	89 d0                	mov    eax,edx
    26e8:	23 45 ec             	and    eax,DWORD PTR [rbp-0x14]
    26eb:	85 c0                	test   eax,eax
    26ed:	0f 84 2c 01 00 00    	je     281f <ahci_worker+0x1c6>
//										ad->ptr->port[i].scr0.ipm, ad->ptr[i].port[i].pXserr);
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    26f3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    26f7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    26fb:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    26fe:	48 63 d2             	movsxd rdx,edx
    2701:	48 c1 e2 07          	shl    rdx,0x7
    2705:	48 01 d0             	add    rax,rdx
    2708:	48 05 34 01 00 00    	add    rax,0x134
    270e:	44 8b 08             	mov    r9d,DWORD PTR [rax]
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    2711:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2715:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2719:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    271c:	48 63 d2             	movsxd rdx,edx
    271f:	48 c1 e2 07          	shl    rdx,0x7
    2723:	48 01 d0             	add    rax,rdx
    2726:	48 05 38 01 00 00    	add    rax,0x138
    272c:	44 8b 00             	mov    r8d,DWORD PTR [rax]
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    272f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2733:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2737:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    273a:	48 63 d2             	movsxd rdx,edx
    273d:	48 c1 e2 07          	shl    rdx,0x7
    2741:	48 01 d0             	add    rax,rdx
    2744:	48 05 20 01 00 00    	add    rax,0x120
    274a:	8b 00                	mov    eax,DWORD PTR [rax]
    274c:	0f b6 c4             	movzx  eax,ah
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    274f:	0f b6 f8             	movzx  edi,al
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    2752:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2756:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    275a:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    275d:	48 63 d2             	movsxd rdx,edx
    2760:	48 c1 e2 07          	shl    rdx,0x7
    2764:	48 01 d0             	add    rax,rdx
    2767:	48 05 20 01 00 00    	add    rax,0x120
    276d:	8b 00                	mov    eax,DWORD PTR [rax]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    276f:	0f b6 f0             	movzx  esi,al
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    2772:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2776:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    277a:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    277d:	48 63 d2             	movsxd rdx,edx
    2780:	48 c1 e2 07          	shl    rdx,0x7
    2784:	48 01 d0             	add    rax,rdx
    2787:	48 05 14 01 00 00    	add    rax,0x114
    278d:	44 8b 18             	mov    r11d,DWORD PTR [rax]
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    2790:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2794:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2798:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    279b:	48 63 d2             	movsxd rdx,edx
    279e:	48 c1 e2 07          	shl    rdx,0x7
    27a2:	48 01 d0             	add    rax,rdx
    27a5:	48 05 10 01 00 00    	add    rax,0x110
    27ab:	44 8b 10             	mov    r10d,DWORD PTR [rax]
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    27ae:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    27b2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    27b6:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    27b9:	48 63 d2             	movsxd rdx,edx
    27bc:	48 c1 e2 07          	shl    rdx,0x7
    27c0:	48 01 d0             	add    rax,rdx
    27c3:	48 05 10 01 00 00    	add    rax,0x110
    27c9:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    27cc:	c1 e8 0f             	shr    eax,0xf
    27cf:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    27d2:	0f b6 c8             	movzx  ecx,al
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    27d5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    27d9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    27dd:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    27e0:	48 63 d2             	movsxd rdx,edx
    27e3:	48 c1 e2 07          	shl    rdx,0x7
    27e7:	48 01 d0             	add    rax,rdx
    27ea:	48 05 10 01 00 00    	add    rax,0x110
    27f0:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    27f3:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    27f6:	0f b6 d0             	movzx  edx,al
    27f9:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    27fc:	41 51                	push   r9
    27fe:	41 50                	push   r8
    2800:	57                   	push   rdi
    2801:	56                   	push   rsi
    2802:	45 89 d9             	mov    r9d,r11d
    2805:	45 89 d0             	mov    r8d,r10d
    2808:	89 c6                	mov    esi,eax
    280a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2811:	b8 00 00 00 00       	mov    eax,0x0
    2816:	e8 00 00 00 00       	call   281b <ahci_worker+0x1c2>
    281b:	48 83 c4 20          	add    rsp,0x20
				for (int i = 0; i < 32; i++)
    281f:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    2823:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    2827:	0f 8e ad fe ff ff    	jle    26da <ahci_worker+0x81>
//
						}
				/* print global IS */
				void ioapic_print_is();
				int pci_print_is(union pca);
				ioapic_print_is();
    282d:	b8 00 00 00 00       	mov    eax,0x0
    2832:	e8 00 00 00 00       	call   2837 <ahci_worker+0x1de>
				pci_print_is(ad->dev->addr);
    2837:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    283b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    283e:	8b 00                	mov    eax,DWORD PTR [rax]
    2840:	89 c7                	mov    edi,eax
    2842:	e8 00 00 00 00       	call   2847 <ahci_worker+0x1ee>
//						}
//						/* R1C */
//						ad->ptr->intr = 1;
//				}

				wait_on_event(&ad->wh);
    2847:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    284b:	48 05 40 0b 00 00    	add    rax,0xb40
    2851:	48 89 c7             	mov    rdi,rax
    2854:	e8 00 00 00 00       	call   2859 <ahci_worker+0x200>
				//sleep(1);

				/* there are pending commands */
				if (ad->pending_ct) {
    2859:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    285d:	8b 80 20 0b 00 00    	mov    eax,DWORD PTR [rax+0xb20]
    2863:	85 c0                	test   eax,eax
    2865:	0f 84 13 fe ff ff    	je     267e <ahci_worker+0x25>
						for (int i = 0; i < 32; i++) {
    286b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    2872:	e9 95 00 00 00       	jmp    290c <ahci_worker+0x2b3>
								if (!(ps & (1 << i)))
    2877:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    287a:	ba 01 00 00 00       	mov    edx,0x1
    287f:	89 c1                	mov    ecx,eax
    2881:	d3 e2                	shl    edx,cl
    2883:	89 d0                	mov    eax,edx
    2885:	23 45 ec             	and    eax,DWORD PTR [rbp-0x14]
    2888:	85 c0                	test   eax,eax
    288a:	74 78                	je     2904 <ahci_worker+0x2ab>
										continue;
								if (list_empty(&ad->pending_cmds[i]))
    288c:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    288f:	48 63 d0             	movsxd rdx,eax
    2892:	48 89 d0             	mov    rax,rdx
    2895:	48 01 c0             	add    rax,rax
    2898:	48 01 d0             	add    rax,rdx
    289b:	48 c1 e0 03          	shl    rax,0x3
    289f:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    28a6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28aa:	48 01 d0             	add    rax,rdx
    28ad:	48 89 c7             	mov    rdi,rax
    28b0:	e8 f5 d8 ff ff       	call   1aa <list_empty>
    28b5:	85 c0                	test   eax,eax
    28b7:	75 4e                	jne    2907 <ahci_worker+0x2ae>
										continue;
								/* we have commands to process */
								ahci_process_command(ad, &ad->ptr->port[i],
    28b9:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    28bc:	48 63 d0             	movsxd rdx,eax
    28bf:	48 89 d0             	mov    rax,rdx
    28c2:	48 01 c0             	add    rax,rax
    28c5:	48 01 d0             	add    rax,rdx
    28c8:	48 c1 e0 03          	shl    rax,0x3
    28cc:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    28d3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28d7:	48 01 c2             	add    rdx,rax
    28da:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28de:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    28e2:	8b 4d f8             	mov    ecx,DWORD PTR [rbp-0x8]
    28e5:	48 63 c9             	movsxd rcx,ecx
    28e8:	48 83 c1 02          	add    rcx,0x2
    28ec:	48 c1 e1 07          	shl    rcx,0x7
    28f0:	48 01 c1             	add    rcx,rax
    28f3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28f7:	48 89 ce             	mov    rsi,rcx
    28fa:	48 89 c7             	mov    rdi,rax
    28fd:	e8 00 00 00 00       	call   2902 <ahci_worker+0x2a9>
    2902:	eb 04                	jmp    2908 <ahci_worker+0x2af>
										continue;
    2904:	90                   	nop
    2905:	eb 01                	jmp    2908 <ahci_worker+0x2af>
										continue;
    2907:	90                   	nop
						for (int i = 0; i < 32; i++) {
    2908:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    290c:	83 7d f8 1f          	cmp    DWORD PTR [rbp-0x8],0x1f
    2910:	0f 8e 61 ff ff ff    	jle    2877 <ahci_worker+0x21e>
		while (1) {
    2916:	e9 63 fd ff ff       	jmp    267e <ahci_worker+0x25>

000000000000291b <ahci_allocate_command_table_pool>:
				}
		}
}

void* ahci_allocate_command_table_pool(uint32_t ct, uint32_t prdt_cap, int bit64)
{
    291b:	55                   	push   rbp
    291c:	48 89 e5             	mov    rbp,rsp
    291f:	48 83 c4 80          	add    rsp,0xffffffffffffff80
    2923:	89 7d 8c             	mov    DWORD PTR [rbp-0x74],edi
    2926:	89 75 88             	mov    DWORD PTR [rbp-0x78],esi
    2929:	89 55 84             	mov    DWORD PTR [rbp-0x7c],edx
		/* 128bt aligned size (8 PRDT/128 bt) */
		struct ahci_ct_pool* rv; uint32_t i = 0;
    292c:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		size_t byte_ct, page_rest, indiv_ct, pg_pe, pg_ct, epa;
		struct page_range pr; int flg = MMGR_ALLOC_CONTIGUOUS;
    2933:	c7 45 dc 00 00 03 00 	mov    DWORD PTR [rbp-0x24],0x30000
		if (!bit64)
    293a:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    293e:	75 07                	jne    2947 <ahci_allocate_command_table_pool+0x2c>
				flg = MMGR_ALLOC_32BIT;
    2940:	c7 45 dc 00 00 04 00 	mov    DWORD PTR [rbp-0x24],0x40000
		if (!(rv = kzalloc(sizeof(*rv))))
    2947:	bf 18 03 00 00       	mov    edi,0x318
    294c:	e8 00 00 00 00       	call   2951 <ahci_allocate_command_table_pool+0x36>
    2951:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2955:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    295a:	75 0a                	jne    2966 <ahci_allocate_command_table_pool+0x4b>
				return NULL;
    295c:	b8 00 00 00 00       	mov    eax,0x0
    2961:	e9 63 03 00 00       	jmp    2cc9 <ahci_allocate_command_table_pool+0x3ae>
	   
		/* bitmask limit */
		if (ct > 32)
    2966:	83 7d 8c 20          	cmp    DWORD PTR [rbp-0x74],0x20
    296a:	76 07                	jbe    2973 <ahci_allocate_command_table_pool+0x58>
				ct = 32;
    296c:	c7 45 8c 20 00 00 00 	mov    DWORD PTR [rbp-0x74],0x20
		/* enforce alignment */
		if (prdt_cap % 8)
    2973:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    2976:	83 e0 07             	and    eax,0x7
    2979:	85 c0                	test   eax,eax
    297b:	74 0c                	je     2989 <ahci_allocate_command_table_pool+0x6e>
				prdt_cap += 8 - prdt_cap % 8;
    297d:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    2980:	83 e0 f8             	and    eax,0xfffffff8
    2983:	83 c0 08             	add    eax,0x8
    2986:	89 45 88             	mov    DWORD PTR [rbp-0x78],eax
		indiv_ct = 128 + 16 * prdt_cap;
    2989:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    298c:	83 c0 08             	add    eax,0x8
    298f:	c1 e0 04             	shl    eax,0x4
    2992:	89 c0                	mov    eax,eax
    2994:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		byte_ct = ct * indiv_ct;
    2998:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    299b:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    299f:	48 0f af c2          	imul   rax,rdx
    29a3:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		pg_pe = rdiv(indiv_ct, 4096);
    29a7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    29ab:	48 c1 e8 0c          	shr    rax,0xc
    29af:	48 89 c2             	mov    rdx,rax
    29b2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    29b6:	25 ff 0f 00 00       	and    eax,0xfff
    29bb:	48 85 c0             	test   rax,rax
    29be:	74 07                	je     29c7 <ahci_allocate_command_table_pool+0xac>
    29c0:	b8 01 00 00 00       	mov    eax,0x1
    29c5:	eb 05                	jmp    29cc <ahci_allocate_command_table_pool+0xb1>
    29c7:	b8 00 00 00 00       	mov    eax,0x0
    29cc:	48 01 d0             	add    rax,rdx
    29cf:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		page_rest = pg_pe * 4096 - indiv_ct;
    29d3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    29d7:	48 c1 e0 0c          	shl    rax,0xc
    29db:	48 2b 45 b0          	sub    rax,QWORD PTR [rbp-0x50]
    29df:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax

		/* pg_pe allocs must be contiguous, but if page_rest is low
		 * individual tables can be split up to different locations */
		if (!page_rest || (page_rest % indiv_ct == 0)) {
    29e3:	48 83 7d a0 00       	cmp    QWORD PTR [rbp-0x60],0x0
    29e8:	74 15                	je     29ff <ahci_allocate_command_table_pool+0xe4>
    29ea:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    29ee:	ba 00 00 00 00       	mov    edx,0x0
    29f3:	48 f7 75 b0          	div    QWORD PTR [rbp-0x50]
    29f7:	48 89 d0             	mov    rax,rdx
    29fa:	48 85 c0             	test   rax,rax
    29fd:	75 56                	jne    2a55 <ahci_allocate_command_table_pool+0x13a>
				epa = pg_pe * 4096 / indiv_ct; /* entries per allocation */
    29ff:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2a03:	48 c1 e0 0c          	shl    rax,0xc
    2a07:	ba 00 00 00 00       	mov    edx,0x0
    2a0c:	48 f7 75 b0          	div    QWORD PTR [rbp-0x50]
    2a10:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				pg_ct = rdiv(ct, epa) * pg_pe;
    2a14:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    2a17:	ba 00 00 00 00       	mov    edx,0x0
    2a1c:	48 f7 75 e0          	div    QWORD PTR [rbp-0x20]
    2a20:	48 89 c1             	mov    rcx,rax
    2a23:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    2a26:	ba 00 00 00 00       	mov    edx,0x0
    2a2b:	48 f7 75 e0          	div    QWORD PTR [rbp-0x20]
    2a2f:	48 89 d0             	mov    rax,rdx
    2a32:	48 85 c0             	test   rax,rax
    2a35:	74 07                	je     2a3e <ahci_allocate_command_table_pool+0x123>
    2a37:	b8 01 00 00 00       	mov    eax,0x1
    2a3c:	eb 05                	jmp    2a43 <ahci_allocate_command_table_pool+0x128>
    2a3e:	b8 00 00 00 00       	mov    eax,0x0
    2a43:	48 8d 14 08          	lea    rdx,[rax+rcx*1]
    2a47:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2a4b:	48 0f af c2          	imul   rax,rdx
    2a4f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    2a53:	eb 3b                	jmp    2a90 <ahci_allocate_command_table_pool+0x175>
		} else {
				pg_ct = rdiv(byte_ct, 4096);
    2a55:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a59:	48 c1 e8 0c          	shr    rax,0xc
    2a5d:	48 89 c2             	mov    rdx,rax
    2a60:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a64:	25 ff 0f 00 00       	and    eax,0xfff
    2a69:	48 85 c0             	test   rax,rax
    2a6c:	74 07                	je     2a75 <ahci_allocate_command_table_pool+0x15a>
    2a6e:	b8 01 00 00 00       	mov    eax,0x1
    2a73:	eb 05                	jmp    2a7a <ahci_allocate_command_table_pool+0x15f>
    2a75:	b8 00 00 00 00       	mov    eax,0x0
    2a7a:	48 01 d0             	add    rax,rdx
    2a7d:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				epa = ct;
    2a81:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    2a84:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				pg_pe = pg_ct;
    2a88:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2a8c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		}

		/* allocate the physical memory */
		while (pg_ct) {
    2a90:	e9 95 01 00 00       	jmp    2c2a <ahci_allocate_command_table_pool+0x30f>
				void* ptr; size_t epa2 = epa, rem;
    2a95:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2a99:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				mm_alloc_pm_flg(pg_pe, &pr, 1, flg);
    2a9d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2aa1:	89 c7                	mov    edi,eax
    2aa3:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2aa6:	48 8d 45 90          	lea    rax,[rbp-0x70]
    2aaa:	89 d1                	mov    ecx,edx
    2aac:	ba 01 00 00 00       	mov    edx,0x1
    2ab1:	48 89 c6             	mov    rsi,rax
    2ab4:	e8 00 00 00 00       	call   2ab9 <ahci_allocate_command_table_pool+0x19e>
				if (pr.count != pg_pe)
    2ab9:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2abd:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    2ac1:	74 30                	je     2af3 <ahci_allocate_command_table_pool+0x1d8>
						die("Out of contiguous memory\n");
    2ac3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2aca:	bf 0c 00 00 00       	mov    edi,0xc
    2acf:	b8 00 00 00 00       	mov    eax,0x0
    2ad4:	e8 00 00 00 00       	call   2ad9 <ahci_allocate_command_table_pool+0x1be>
    2ad9:	b8 00 00 00 00       	mov    eax,0x0
    2ade:	e8 00 00 00 00       	call   2ae3 <ahci_allocate_command_table_pool+0x1c8>
    2ae3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2aea:	e8 00 00 00 00       	call   2aef <ahci_allocate_command_table_pool+0x1d4>
    2aef:	fa                   	cli
    2af0:	f4                   	hlt
    2af1:	eb fd                	jmp    2af0 <ahci_allocate_command_table_pool+0x1d5>
				rem = pg_pe * 4096;
    2af3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2af7:	48 c1 e0 0c          	shl    rax,0xc
    2afb:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				/* pg_pe zeroed contiguous memory at pr.base */
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL |
    2aff:	48 8d 45 90          	lea    rax,[rbp-0x70]
    2b03:	41 b8 2c 00 00 00    	mov    r8d,0x2c
    2b09:	b9 01 00 00 00       	mov    ecx,0x1
    2b0e:	48 89 c2             	mov    rdx,rax
    2b11:	be 00 00 00 00       	mov    esi,0x0
    2b16:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2b1d:	e8 00 00 00 00       	call   2b22 <ahci_allocate_command_table_pool+0x207>
    2b22:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						MMGR_MAP_WRITE | MMGR_MAP_NO_CACHING);
				if (!ptr)
    2b26:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    2b2b:	0f 85 dc 00 00 00    	jne    2c0d <ahci_allocate_command_table_pool+0x2f2>
						die("mmap not working\n");
    2b31:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2b38:	bf 0c 00 00 00       	mov    edi,0xc
    2b3d:	b8 00 00 00 00       	mov    eax,0x0
    2b42:	e8 00 00 00 00       	call   2b47 <ahci_allocate_command_table_pool+0x22c>
    2b47:	b8 00 00 00 00       	mov    eax,0x0
    2b4c:	e8 00 00 00 00       	call   2b51 <ahci_allocate_command_table_pool+0x236>
    2b51:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2b58:	e8 00 00 00 00       	call   2b5d <ahci_allocate_command_table_pool+0x242>
    2b5d:	fa                   	cli
    2b5e:	f4                   	hlt
    2b5f:	eb fd                	jmp    2b5e <ahci_allocate_command_table_pool+0x243>

				/* assign the entries */
				while (epa2--) {
						rv->tables[i].pmem = pr.base;
    2b61:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    2b65:	48 8b 75 b8          	mov    rsi,QWORD PTR [rbp-0x48]
    2b69:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2b6c:	48 89 d0             	mov    rax,rdx
    2b6f:	48 01 c0             	add    rax,rax
    2b72:	48 01 d0             	add    rax,rdx
    2b75:	48 c1 e0 03          	shl    rax,0x3
    2b79:	48 01 f0             	add    rax,rsi
    2b7c:	48 83 c0 28          	add    rax,0x28
    2b80:	48 89 08             	mov    QWORD PTR [rax],rcx
						rv->tables[i++].ptr = ptr;
    2b83:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2b86:	8d 50 01             	lea    edx,[rax+0x1]
    2b89:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    2b8c:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    2b90:	89 c1                	mov    ecx,eax
    2b92:	48 89 c8             	mov    rax,rcx
    2b95:	48 01 c0             	add    rax,rax
    2b98:	48 01 c8             	add    rax,rcx
    2b9b:	48 c1 e0 03          	shl    rax,0x3
    2b9f:	48 01 d0             	add    rax,rdx
    2ba2:	48 8d 50 20          	lea    rdx,[rax+0x20]
    2ba6:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2baa:	48 89 02             	mov    QWORD PTR [rdx],rax
						/* advance */
						pr.base += indiv_ct;
    2bad:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    2bb1:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2bb5:	48 01 d0             	add    rax,rdx
    2bb8:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
						ptr += indiv_ct;
    2bbc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2bc0:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
						rem -= indiv_ct;
    2bc4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2bc8:	48 29 45 c0          	sub    QWORD PTR [rbp-0x40],rax
						if (rem < indiv_ct && epa2 > 1)
    2bcc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2bd0:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
    2bd4:	73 37                	jae    2c0d <ahci_allocate_command_table_pool+0x2f2>
    2bd6:	48 83 7d c8 01       	cmp    QWORD PTR [rbp-0x38],0x1
    2bdb:	76 30                	jbe    2c0d <ahci_allocate_command_table_pool+0x2f2>
								die("algo error\n");
    2bdd:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2be4:	bf 0c 00 00 00       	mov    edi,0xc
    2be9:	b8 00 00 00 00       	mov    eax,0x0
    2bee:	e8 00 00 00 00       	call   2bf3 <ahci_allocate_command_table_pool+0x2d8>
    2bf3:	b8 00 00 00 00       	mov    eax,0x0
    2bf8:	e8 00 00 00 00       	call   2bfd <ahci_allocate_command_table_pool+0x2e2>
    2bfd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c04:	e8 00 00 00 00       	call   2c09 <ahci_allocate_command_table_pool+0x2ee>
    2c09:	fa                   	cli
    2c0a:	f4                   	hlt
    2c0b:	eb fd                	jmp    2c0a <ahci_allocate_command_table_pool+0x2ef>
				while (epa2--) {
    2c0d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2c11:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2c15:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    2c19:	48 85 c0             	test   rax,rax
    2c1c:	0f 85 3f ff ff ff    	jne    2b61 <ahci_allocate_command_table_pool+0x246>
				}
				pg_ct -= pg_pe;
    2c22:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c26:	48 29 45 e8          	sub    QWORD PTR [rbp-0x18],rax
		while (pg_ct) {
    2c2a:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2c2f:	0f 85 60 fe ff ff    	jne    2a95 <ahci_allocate_command_table_pool+0x17a>
		}

		/* assign the other values */
		rv->prdt_cap = prdt_cap;
    2c35:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2c39:	8b 55 88             	mov    edx,DWORD PTR [rbp-0x78]
    2c3c:	89 10                	mov    DWORD PTR [rax],edx
		rv->next = NULL;
    2c3e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2c42:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		rv->mask = 0xffffffff << prdt_cap;
    2c4a:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    2c4d:	ba ff ff ff ff       	mov    edx,0xffffffff
    2c52:	89 c1                	mov    ecx,eax
    2c54:	d3 e2                	shl    edx,cl
    2c56:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2c5a:	89 50 10             	mov    DWORD PTR [rax+0x10],edx

		/* print it */
		for (i = 0; i < ct; i++)
    2c5d:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    2c64:	eb 57                	jmp    2cbd <ahci_allocate_command_table_pool+0x3a2>
				printf("%016llx %p\n", rv->tables[i].pmem, rv->tables[i].ptr);
    2c66:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    2c6a:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2c6d:	48 89 d0             	mov    rax,rdx
    2c70:	48 01 c0             	add    rax,rax
    2c73:	48 01 d0             	add    rax,rdx
    2c76:	48 c1 e0 03          	shl    rax,0x3
    2c7a:	48 01 c8             	add    rax,rcx
    2c7d:	48 83 c0 20          	add    rax,0x20
    2c81:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    2c84:	48 8b 75 b8          	mov    rsi,QWORD PTR [rbp-0x48]
    2c88:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2c8b:	48 89 d0             	mov    rax,rdx
    2c8e:	48 01 c0             	add    rax,rax
    2c91:	48 01 d0             	add    rax,rdx
    2c94:	48 c1 e0 03          	shl    rax,0x3
    2c98:	48 01 f0             	add    rax,rsi
    2c9b:	48 83 c0 28          	add    rax,0x28
    2c9f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2ca2:	48 89 ca             	mov    rdx,rcx
    2ca5:	48 89 c6             	mov    rsi,rax
    2ca8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2caf:	b8 00 00 00 00       	mov    eax,0x0
    2cb4:	e8 00 00 00 00       	call   2cb9 <ahci_allocate_command_table_pool+0x39e>
		for (i = 0; i < ct; i++)
    2cb9:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    2cbd:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2cc0:	3b 45 8c             	cmp    eax,DWORD PTR [rbp-0x74]
    2cc3:	72 a1                	jb     2c66 <ahci_allocate_command_table_pool+0x34b>

		return rv;
    2cc5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
}
    2cc9:	c9                   	leave
    2cca:	c3                   	ret

0000000000002ccb <ahci_reissue_command>:

void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc)
{
    2ccb:	55                   	push   rbp
    2ccc:	48 89 e5             	mov    rbp,rsp
    2ccf:	48 83 ec 10          	sub    rsp,0x10
    2cd3:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    2cd7:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		iprintf("  REISSUE: %d %u\n", cc->port, cc->c);
    2cdb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2cdf:	8b 50 18             	mov    edx,DWORD PTR [rax+0x18]
    2ce2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2ce6:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2cea:	0f b7 c0             	movzx  eax,ax
    2ced:	89 c6                	mov    esi,eax
    2cef:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2cf6:	b8 00 00 00 00       	mov    eax,0x0
    2cfb:	e8 00 00 00 00       	call   2d00 <ahci_reissue_command+0x35>
		if (cc->status)
    2d00:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d04:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2d08:	48 85 c0             	test   rax,rax
    2d0b:	74 0e                	je     2d1b <ahci_reissue_command+0x50>
				cc->status->state = cmd_state_pending;
    2d0d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d11:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2d15:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
						ad->pending_cmds[cc->port].next, cc->port);
    2d1b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d1f:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    2d23:	0f b7 c8             	movzx  ecx,ax
						ad->pending_cmds[cc->port].next, cc->port);
    2d26:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d2a:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2d2e:	0f b7 c0             	movzx  eax,ax
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    2d31:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    2d35:	48 63 d0             	movsxd rdx,eax
    2d38:	48 89 d0             	mov    rax,rdx
    2d3b:	48 01 c0             	add    rax,rax
    2d3e:	48 01 d0             	add    rax,rdx
    2d41:	48 c1 e0 03          	shl    rax,0x3
    2d45:	48 01 f0             	add    rax,rsi
    2d48:	48 05 28 05 00 00    	add    rax,0x528
    2d4e:	48 8b 30             	mov    rsi,QWORD PTR [rax]
    2d51:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d55:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2d59:	0f b7 c0             	movzx  eax,ax
    2d5c:	48 8b 7d f8          	mov    rdi,QWORD PTR [rbp-0x8]
    2d60:	48 63 d0             	movsxd rdx,eax
    2d63:	48 89 d0             	mov    rax,rdx
    2d66:	48 01 c0             	add    rax,rax
    2d69:	48 01 d0             	add    rax,rdx
    2d6c:	48 c1 e0 03          	shl    rax,0x3
    2d70:	48 01 f8             	add    rax,rdi
    2d73:	48 05 20 05 00 00    	add    rax,0x520
    2d79:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d7c:	48 89 f2             	mov    rdx,rsi
    2d7f:	48 89 c6             	mov    rsi,rax
    2d82:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2d89:	b8 00 00 00 00       	mov    eax,0x0
    2d8e:	e8 00 00 00 00       	call   2d93 <ahci_reissue_command+0xc8>
		list_add_tail(&cc->lst, &ad->pending_cmds[cc->port]);
    2d93:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d97:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2d9b:	0f b7 c0             	movzx  eax,ax
    2d9e:	48 63 d0             	movsxd rdx,eax
    2da1:	48 89 d0             	mov    rax,rdx
    2da4:	48 01 c0             	add    rax,rax
    2da7:	48 01 d0             	add    rax,rdx
    2daa:	48 c1 e0 03          	shl    rax,0x3
    2dae:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    2db5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2db9:	48 01 c2             	add    rdx,rax
    2dbc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2dc0:	48 89 d6             	mov    rsi,rdx
    2dc3:	48 89 c7             	mov    rdi,rax
    2dc6:	e8 53 d3 ff ff       	call   11e <list_add_tail>
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    2dcb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2dcf:	48 05 20 0b 00 00    	add    rax,0xb20
    2dd5:	ba 01 00 00 00       	mov    edx,0x1
    2dda:	f0 0f c1 10          	lock xadd DWORD PTR [rax],edx
    2dde:	85 d2                	test   edx,edx
    2de0:	75 12                	jne    2df4 <ahci_reissue_command+0x129>
				/* wake worker */
				wake_up_external_event(&ad->wh);
    2de2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2de6:	48 05 40 0b 00 00    	add    rax,0xb40
    2dec:	48 89 c7             	mov    rdi,rax
    2def:	e8 00 00 00 00       	call   2df4 <ahci_reissue_command+0x129>
		}
}
    2df4:	90                   	nop
    2df5:	c9                   	leave
    2df6:	c3                   	ret

0000000000002df7 <ahci_issue_command>:

void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st)
{
    2df7:	55                   	push   rbp
    2df8:	48 89 e5             	mov    rbp,rsp
    2dfb:	48 83 ec 40          	sub    rsp,0x40
    2dff:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    2e03:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    2e06:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
    2e09:	89 4d dc             	mov    DWORD PTR [rbp-0x24],ecx
    2e0c:	4c 89 45 d0          	mov    QWORD PTR [rbp-0x30],r8
    2e10:	4c 89 4d c8          	mov    QWORD PTR [rbp-0x38],r9
		iprintf("  ISSUE: %d %u\n", port, cmd);
    2e14:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2e17:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    2e1a:	89 c6                	mov    esi,eax
    2e1c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e23:	b8 00 00 00 00       	mov    eax,0x0
    2e28:	e8 00 00 00 00       	call   2e2d <ahci_issue_command+0x36>
		struct cmd_ctx* cc = ahci_allocate_context(ad);
    2e2d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2e31:	48 89 c7             	mov    rdi,rax
    2e34:	e8 00 00 00 00       	call   2e39 <ahci_issue_command+0x42>
    2e39:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		cc->c = cmd;
    2e3d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e41:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2e44:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
		cc->lba = lba;
    2e47:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e4b:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2e4f:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		cc->ct = ct;
    2e53:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e57:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2e5b:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
		cc->ptr = ptr;
    2e5f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e63:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10]
    2e67:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		cc->wq_wake = wq_h;
    2e6b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e6f:	48 8b 55 18          	mov    rdx,QWORD PTR [rbp+0x18]
    2e73:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		cc->pmprt = pmprt;
    2e77:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    2e7a:	89 c2                	mov    edx,eax
    2e7c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e80:	66 89 50 38          	mov    WORD PTR [rax+0x38],dx
		cc->port = port;
    2e84:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    2e87:	89 c2                	mov    edx,eax
    2e89:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e8d:	66 89 50 50          	mov    WORD PTR [rax+0x50],dx
		cc->status = st;
    2e91:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e95:	48 8b 55 20          	mov    rdx,QWORD PTR [rbp+0x20]
    2e99:	48 89 50 48          	mov    QWORD PTR [rax+0x48],rdx
		if (st) {
    2e9d:	48 83 7d 20 00       	cmp    QWORD PTR [rbp+0x20],0x0
    2ea2:	74 1b                	je     2ebf <ahci_issue_command+0xc8>
				bzero(st, sizeof(*st));
    2ea4:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
    2ea8:	be 18 00 00 00       	mov    esi,0x18
    2ead:	48 89 c7             	mov    rdi,rax
    2eb0:	e8 00 00 00 00       	call   2eb5 <ahci_issue_command+0xbe>
				st->state = cmd_state_pending;
    2eb5:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
    2eb9:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		}
		list_add_tail(&cc->lst, &ad->pending_cmds[port]);
    2ebf:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    2ec2:	48 63 d0             	movsxd rdx,eax
    2ec5:	48 89 d0             	mov    rax,rdx
    2ec8:	48 01 c0             	add    rax,rax
    2ecb:	48 01 d0             	add    rax,rdx
    2ece:	48 c1 e0 03          	shl    rax,0x3
    2ed2:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    2ed9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2edd:	48 01 c2             	add    rdx,rax
    2ee0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2ee4:	48 89 d6             	mov    rsi,rdx
    2ee7:	48 89 c7             	mov    rdi,rax
    2eea:	e8 2f d2 ff ff       	call   11e <list_add_tail>
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    2eef:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ef3:	48 05 20 0b 00 00    	add    rax,0xb20
    2ef9:	ba 01 00 00 00       	mov    edx,0x1
    2efe:	f0 0f c1 10          	lock xadd DWORD PTR [rax],edx
    2f02:	85 d2                	test   edx,edx
    2f04:	75 12                	jne    2f18 <ahci_issue_command+0x121>
				/*  wake worker */
				wake_up_external_event(&ad->wh);
    2f06:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f0a:	48 05 40 0b 00 00    	add    rax,0xb40
    2f10:	48 89 c7             	mov    rdi,rax
    2f13:	e8 00 00 00 00       	call   2f18 <ahci_issue_command+0x121>
		}
}
    2f18:	90                   	nop
    2f19:	c9                   	leave
    2f1a:	c3                   	ret

0000000000002f1b <ahci_do_bohc>:

int ahci_do_bohc(struct ahci_device* ad)
{
    2f1b:	55                   	push   rbp
    2f1c:	48 89 e5             	mov    rbp,rsp
    2f1f:	48 83 ec 20          	sub    rsp,0x20
    2f23:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct ahci_hba* hba = ad->ptr;
    2f27:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f2b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f2f:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (hba->cap2.boh) {
    2f33:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f37:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    2f3a:	83 e0 01             	and    eax,0x1
    2f3d:	84 c0                	test   al,al
    2f3f:	0f 84 be 00 00 00    	je     3003 <ahci_do_bohc+0xe8>
				abprintf("performing AHCI BIOS handover...\n");
    2f45:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2f4c:	b8 00 00 00 00       	mov    eax,0x0
    2f51:	e8 00 00 00 00       	call   2f56 <ahci_do_bohc+0x3b>
				preempt_disable();
    2f56:	b8 00 00 00 00       	mov    eax,0x0
    2f5b:	e8 00 00 00 00       	call   2f60 <ahci_do_bohc+0x45>
    2f60:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    2f63:	83 c2 01             	add    edx,0x1
    2f66:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				hba->bohc |= BOHC_OOS;
    2f69:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f6d:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f70:	83 c8 02             	or     eax,0x2
    2f73:	89 c2                	mov    edx,eax
    2f75:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f79:	89 50 28             	mov    DWORD PTR [rax+0x28],edx
				/* SMI is issued */
				if (hba->bohc & BOHC_BOS) { /* we have to wait */
    2f7c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f80:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f83:	83 e0 01             	and    eax,0x1
    2f86:	85 c0                	test   eax,eax
    2f88:	74 49                	je     2fd3 <ahci_do_bohc+0xb8>
						mdelay(25);
    2f8a:	bf 19 00 00 00       	mov    edi,0x19
    2f8f:	e8 00 00 00 00       	call   2f94 <ahci_do_bohc+0x79>
						if (hba->bohc & BOHC_BB) { /* BIOS does it */
    2f94:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f98:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f9b:	83 e0 10             	and    eax,0x10
    2f9e:	85 c0                	test   eax,eax
    2fa0:	74 31                	je     2fd3 <ahci_do_bohc+0xb8>
								int to = 30;
    2fa2:	c7 45 fc 1e 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1e
								while (hba->bohc & BOHC_BOS) {
    2fa9:	eb 17                	jmp    2fc2 <ahci_do_bohc+0xa7>
										mdelay(100);
    2fab:	bf 64 00 00 00       	mov    edi,0x64
    2fb0:	e8 00 00 00 00       	call   2fb5 <ahci_do_bohc+0x9a>
										if (!to--) /* abort after 3 seconds */
    2fb5:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2fb8:	8d 50 ff             	lea    edx,[rax-0x1]
    2fbb:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    2fbe:	85 c0                	test   eax,eax
    2fc0:	74 10                	je     2fd2 <ahci_do_bohc+0xb7>
								while (hba->bohc & BOHC_BOS) {
    2fc2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2fc6:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2fc9:	83 e0 01             	and    eax,0x1
    2fcc:	85 c0                	test   eax,eax
    2fce:	75 db                	jne    2fab <ahci_do_bohc+0x90>
    2fd0:	eb 01                	jmp    2fd3 <ahci_do_bohc+0xb8>
												break;
    2fd2:	90                   	nop
								}
						} else {;} /* we have to clean up */
				}
				/* we're done */
				preempt_enable();
    2fd3:	b8 00 00 00 00       	mov    eax,0x0
    2fd8:	e8 00 00 00 00       	call   2fdd <ahci_do_bohc+0xc2>
    2fdd:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    2fe0:	83 ea 01             	sub    edx,0x1
    2fe3:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    2fe6:	b8 00 00 00 00       	mov    eax,0x0
    2feb:	e8 00 00 00 00       	call   2ff0 <ahci_do_bohc+0xd5>
    2ff0:	8b 00                	mov    eax,DWORD PTR [rax]
    2ff2:	83 e0 01             	and    eax,0x1
    2ff5:	85 c0                	test   eax,eax
    2ff7:	74 0a                	je     3003 <ahci_do_bohc+0xe8>
    2ff9:	b8 00 00 00 00       	mov    eax,0x0
    2ffe:	e8 00 00 00 00       	call   3003 <ahci_do_bohc+0xe8>
		}
		/* always acquire (we're only nice to inform the bios) */
		return 0;
    3003:	b8 00 00 00 00       	mov    eax,0x0
}
    3008:	c9                   	leave
    3009:	c3                   	ret

000000000000300a <ahci_reset_port>:

void ahci_reset_port(struct ahci_hba* h, struct ahci_port* p)
{
    300a:	55                   	push   rbp
    300b:	48 89 e5             	mov    rbp,rsp
    300e:	48 83 ec 10          	sub    rsp,0x10
    3012:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    3016:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		/* cap.sclo? */
		die("not impl %p %p\n", h, p);
    301a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    301e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3022:	48 89 d1             	mov    rcx,rdx
    3025:	48 89 c2             	mov    rdx,rax
    3028:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    302f:	bf 0c 00 00 00       	mov    edi,0xc
    3034:	b8 00 00 00 00       	mov    eax,0x0
    3039:	e8 00 00 00 00       	call   303e <ahci_reset_port+0x34>
    303e:	b8 00 00 00 00       	mov    eax,0x0
    3043:	e8 00 00 00 00       	call   3048 <ahci_reset_port+0x3e>
    3048:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    304f:	e8 00 00 00 00       	call   3054 <ahci_reset_port+0x4a>
    3054:	fa                   	cli
    3055:	f4                   	hlt
    3056:	eb fd                	jmp    3055 <ahci_reset_port+0x4b>

0000000000003058 <ahci_port_activate_device>:
}

void ahci_port_activate_device(struct ahci_hba* h, struct ahci_port* p)
{
    3058:	55                   	push   rbp
    3059:	48 89 e5             	mov    rbp,rsp
    305c:	48 83 ec 20          	sub    rsp,0x20
    3060:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    3064:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		abprintf("activate port %zd:\n", p - h->port);
    3068:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    306c:	48 05 00 01 00 00    	add    rax,0x100
    3072:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3076:	48 29 c2             	sub    rdx,rax
    3079:	48 89 d0             	mov    rax,rdx
    307c:	48 c1 f8 07          	sar    rax,0x7
    3080:	48 89 c6             	mov    rsi,rax
    3083:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    308a:	b8 00 00 00 00       	mov    eax,0x0
    308f:	e8 00 00 00 00       	call   3094 <ahci_port_activate_device+0x3c>
		/* first check the presence flag */
		if (p->scr0.det == DET_NOT_PRESENT) {
    3094:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3098:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    309b:	83 e0 0f             	and    eax,0xf
    309e:	84 c0                	test   al,al
    30a0:	0f 85 09 02 00 00    	jne    32af <ahci_port_activate_device+0x257>
				abprintf("activate: DET_NOT_PRESENT\n");
    30a6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    30ad:	b8 00 00 00 00       	mov    eax,0x0
    30b2:	e8 00 00 00 00       	call   30b7 <ahci_port_activate_device+0x5f>
				/* nothing attached? */
				if (p->cmd.cpd) { /* we rely on CPD */
    30b7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    30bb:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    30be:	c1 e8 14             	shr    eax,0x14
    30c1:	83 e0 01             	and    eax,0x1
    30c4:	84 c0                	test   al,al
    30c6:	74 61                	je     3129 <ahci_port_activate_device+0xd1>
						if (!p->cmd.cps) {
    30c8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    30cc:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    30cf:	c1 e8 10             	shr    eax,0x10
    30d2:	83 e0 01             	and    eax,0x1
    30d5:	84 c0                	test   al,al
    30d7:	75 16                	jne    30ef <ahci_port_activate_device+0x97>
								abprintf("confirmed by CPD\n");
    30d9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    30e0:	b8 00 00 00 00       	mov    eax,0x0
    30e5:	e8 00 00 00 00       	call   30ea <ahci_port_activate_device+0x92>
								return;
    30ea:	e9 b2 03 00 00       	jmp    34a1 <ahci_port_activate_device+0x449>
						}
						/* there's something */
						if (!p->cmd.pod) {
    30ef:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    30f3:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    30f6:	c1 e8 02             	shr    eax,0x2
    30f9:	83 e0 01             	and    eax,0x1
    30fc:	84 c0                	test   al,al
    30fe:	75 17                	jne    3117 <ahci_port_activate_device+0xbf>
								p->cmd.pod = 1; /* power it */
    3100:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3104:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3107:	83 c8 04             	or     eax,0x4
    310a:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
								ndelay(20);
    310d:	bf 14 00 00 00       	mov    edi,0x14
    3112:	e8 00 00 00 00       	call   3117 <ahci_port_activate_device+0xbf>
						}
						if (p->scr0.det != DET_NOT_PRESENT)
    3117:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    311b:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    311e:	83 e0 0f             	and    eax,0xf
    3121:	84 c0                	test   al,al
    3123:	0f 85 89 01 00 00    	jne    32b2 <ahci_port_activate_device+0x25a>
								goto next_step;
				}
				/* spin-up? */
				if (!p->cmd.sud) { /* always !1 if cap.sss == 0 */
    3129:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    312d:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3130:	d1 e8                	shr    eax,1
    3132:	83 e0 01             	and    eax,0x1
    3135:	84 c0                	test   al,al
    3137:	0f 85 f4 00 00 00    	jne    3231 <ahci_port_activate_device+0x1d9>
						abprintf("not spun-up yet?\n");
    313d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3144:	b8 00 00 00 00       	mov    eax,0x0
    3149:	e8 00 00 00 00       	call   314e <ahci_port_activate_device+0xf6>
						if (p->pXserr & (1 << 26)) /* eXchange bit */
    314e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3152:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3155:	25 00 00 00 04       	and    eax,0x4000000
    315a:	85 c0                	test   eax,eax
    315c:	74 15                	je     3173 <ahci_port_activate_device+0x11b>
								p->pXserr |= (1 << 26); /* RWC */
    315e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3162:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3165:	0d 00 00 00 04       	or     eax,0x4000000
    316a:	89 c2                	mov    edx,eax
    316c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3170:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
						if (p->scr2.det != 0) { /* set to 0 prior sud */
    3173:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3177:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    317a:	c1 e8 1c             	shr    eax,0x1c
    317d:	84 c0                	test   al,al
    317f:	74 19                	je     319a <ahci_port_activate_device+0x142>
								p->scr2.det = 0;
    3181:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3185:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    3188:	25 ff ff ff 0f       	and    eax,0xfffffff
    318d:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
								ndelay(20);
    3190:	bf 14 00 00 00       	mov    edi,0x14
    3195:	e8 00 00 00 00       	call   319a <ahci_port_activate_device+0x142>
						}
						p->cmd.sud = 1;
    319a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    319e:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    31a1:	83 c8 02             	or     eax,0x2
    31a4:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						udelay(50); /* wait 50 mus */
    31a7:	bf 32 00 00 00       	mov    edi,0x32
    31ac:	e8 00 00 00 00       	call   31b1 <ahci_port_activate_device+0x159>
						if (p->pXserr & ((1 << 26) | (1 << 18))) { /* received sth. */
    31b1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    31b5:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    31b8:	25 00 00 04 04       	and    eax,0x4040000
    31bd:	85 c0                	test   eax,eax
    31bf:	0f 85 f0 00 00 00    	jne    32b5 <ahci_port_activate_device+0x25d>
								/* COMRESET, COMWAKE */
								goto next_step;
						}
						/* send the reset */
						p->scr2.det = 1;
    31c5:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    31c9:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    31cc:	25 ff ff ff 0f       	and    eax,0xfffffff
    31d1:	0d 00 00 00 10       	or     eax,0x10000000
    31d6:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
						mdelay(1);
    31d9:	bf 01 00 00 00       	mov    edi,0x1
    31de:	e8 00 00 00 00       	call   31e3 <ahci_port_activate_device+0x18b>
						p->scr2.det = 0;
    31e3:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    31e7:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    31ea:	25 ff ff ff 0f       	and    eax,0xfffffff
    31ef:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
						udelay(50);
    31f2:	bf 32 00 00 00       	mov    edi,0x32
    31f7:	e8 00 00 00 00       	call   31fc <ahci_port_activate_device+0x1a4>
						if (p->scr0.det != DET_NOT_PRESENT)
    31fc:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3200:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3203:	83 e0 0f             	and    eax,0xf
    3206:	84 c0                	test   al,al
    3208:	0f 85 aa 00 00 00    	jne    32b8 <ahci_port_activate_device+0x260>
								goto next_step;
						p->cmd.sud = 0; /* we're done enter listening mode */
    320e:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3212:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3215:	83 e0 fd             	and    eax,0xfffffffd
    3218:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						abprintf("not present\n");
    321b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3222:	b8 00 00 00 00       	mov    eax,0x0
    3227:	e8 00 00 00 00       	call   322c <ahci_port_activate_device+0x1d4>
						goto exit;
    322c:	e9 43 02 00 00       	jmp    3474 <ahci_port_activate_device+0x41c>
				}
				/* just try ICC */
				if (p->scr0.ipm != 1) {
    3231:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3235:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3238:	c1 e8 08             	shr    eax,0x8
    323b:	83 e0 0f             	and    eax,0xf
    323e:	3c 01                	cmp    al,0x1
    3240:	74 6d                	je     32af <ahci_port_activate_device+0x257>
						abprintf("IPM != ACTIVE\n");
    3242:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3249:	b8 00 00 00 00       	mov    eax,0x0
    324e:	e8 00 00 00 00       	call   3253 <ahci_port_activate_device+0x1fb>
						int ct = 50;
    3253:	c7 45 fc 32 00 00 00 	mov    DWORD PTR [rbp-0x4],0x32
						while (p->cmd.icc && ct--)
    325a:	eb 0a                	jmp    3266 <ahci_port_activate_device+0x20e>
								udelay(10);
    325c:	bf 0a 00 00 00       	mov    edi,0xa
    3261:	e8 00 00 00 00       	call   3266 <ahci_port_activate_device+0x20e>
						while (p->cmd.icc && ct--)
    3266:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    326a:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    326d:	c1 e8 1c             	shr    eax,0x1c
    3270:	84 c0                	test   al,al
    3272:	74 0d                	je     3281 <ahci_port_activate_device+0x229>
    3274:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3277:	8d 50 ff             	lea    edx,[rax-0x1]
    327a:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    327d:	85 c0                	test   eax,eax
    327f:	75 db                	jne    325c <ahci_port_activate_device+0x204>
						p->cmd.icc = 1;
    3281:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3285:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3288:	25 ff ff ff 0f       	and    eax,0xfffffff
    328d:	0d 00 00 00 10       	or     eax,0x10000000
    3292:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						mdelay(10);
    3295:	bf 0a 00 00 00       	mov    edi,0xa
    329a:	e8 00 00 00 00       	call   329f <ahci_port_activate_device+0x247>
						if (p->scr0.det != DET_NOT_PRESENT)
    329f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    32a3:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    32a6:	83 e0 0f             	and    eax,0xf
    32a9:	84 c0                	test   al,al
    32ab:	74 0e                	je     32bb <ahci_port_activate_device+0x263>
								goto next_step;
    32ad:	eb 22                	jmp    32d1 <ahci_port_activate_device+0x279>
						goto exit;
				}
		}

		/* det != 1*/
next_step:
    32af:	90                   	nop
    32b0:	eb 1f                	jmp    32d1 <ahci_port_activate_device+0x279>
								goto next_step;
    32b2:	90                   	nop
    32b3:	eb 1c                	jmp    32d1 <ahci_port_activate_device+0x279>
								goto next_step;
    32b5:	90                   	nop
    32b6:	eb 19                	jmp    32d1 <ahci_port_activate_device+0x279>
								goto next_step;
    32b8:	90                   	nop
    32b9:	eb 16                	jmp    32d1 <ahci_port_activate_device+0x279>
						abprintf("unable to set to active\n");
    32bb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    32c2:	b8 00 00 00 00       	mov    eax,0x0
    32c7:	e8 00 00 00 00       	call   32cc <ahci_port_activate_device+0x274>
						goto exit;
    32cc:	e9 a3 01 00 00       	jmp    3474 <ahci_port_activate_device+0x41c>
		if (p->scr0.det == DET_PRESENT) {
    32d1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    32d5:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    32d8:	83 e0 0f             	and    eax,0xf
    32db:	3c 03                	cmp    al,0x3
    32dd:	0f 85 48 01 00 00    	jne    342b <ahci_port_activate_device+0x3d3>
				/* almost done */
				if (p->scr0.ipm != IPM_ACTIVE) {
    32e3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    32e7:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    32ea:	c1 e8 08             	shr    eax,0x8
    32ed:	83 e0 0f             	and    eax,0xf
    32f0:	3c 01                	cmp    al,0x1
    32f2:	0f 84 b1 00 00 00    	je     33a9 <ahci_port_activate_device+0x351>
						int ct, wc;
						abprintf("Present but not active.\n");
    32f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    32ff:	b8 00 00 00 00       	mov    eax,0x0
    3304:	e8 00 00 00 00       	call   3309 <ahci_port_activate_device+0x2b1>
activ:
						ct = 50, wc = 0;
    3309:	c7 45 f8 32 00 00 00 	mov    DWORD PTR [rbp-0x8],0x32
    3310:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
rewait:
						while (p->cmd.icc && ct--) /* 500ms */
    3317:	eb 0a                	jmp    3323 <ahci_port_activate_device+0x2cb>
								mdelay(10);
    3319:	bf 0a 00 00 00       	mov    edi,0xa
    331e:	e8 00 00 00 00       	call   3323 <ahci_port_activate_device+0x2cb>
						while (p->cmd.icc && ct--) /* 500ms */
    3323:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3327:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    332a:	c1 e8 1c             	shr    eax,0x1c
    332d:	84 c0                	test   al,al
    332f:	74 0d                	je     333e <ahci_port_activate_device+0x2e6>
    3331:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    3334:	8d 50 ff             	lea    edx,[rax-0x1]
    3337:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
    333a:	85 c0                	test   eax,eax
    333c:	75 db                	jne    3319 <ahci_port_activate_device+0x2c1>
						if (p->scr0.ipm != IPM_ACTIVE && !wc) {
    333e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3342:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3345:	c1 e8 08             	shr    eax,0x8
    3348:	83 e0 0f             	and    eax,0xf
    334b:	3c 01                	cmp    al,0x1
    334d:	74 31                	je     3380 <ahci_port_activate_device+0x328>
    334f:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    3353:	75 2b                	jne    3380 <ahci_port_activate_device+0x328>
								p->cmd.icc = 1;
    3355:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3359:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    335c:	25 ff ff ff 0f       	and    eax,0xfffffff
    3361:	0d 00 00 00 10       	or     eax,0x10000000
    3366:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
								ndelay(50);
    3369:	bf 32 00 00 00       	mov    edi,0x32
    336e:	e8 00 00 00 00       	call   3373 <ahci_port_activate_device+0x31b>
								wc++; ct = 50;
    3373:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    3377:	c7 45 f8 32 00 00 00 	mov    DWORD PTR [rbp-0x8],0x32
								goto rewait;
    337e:	eb 97                	jmp    3317 <ahci_port_activate_device+0x2bf>
						}
						if (wc) {
    3380:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    3384:	74 23                	je     33a9 <ahci_port_activate_device+0x351>
								/* reset */
								p->scr2.det = 1;
    3386:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    338a:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    338d:	25 ff ff ff 0f       	and    eax,0xfffffff
    3392:	0d 00 00 00 10       	or     eax,0x10000000
    3397:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
								mdelay(1);
    339a:	bf 01 00 00 00       	mov    edi,0x1
    339f:	e8 00 00 00 00       	call   33a4 <ahci_port_activate_device+0x34c>
								goto next_step;
    33a4:	e9 28 ff ff ff       	jmp    32d1 <ahci_port_activate_device+0x279>
						}
				}
				abprintf("Device at port %zd is active and present.\n",
						p - h->port);
    33a9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    33ad:	48 05 00 01 00 00    	add    rax,0x100
    33b3:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    33b7:	48 29 c2             	sub    rdx,rax
				abprintf("Device at port %zd is active and present.\n",
    33ba:	48 89 d0             	mov    rax,rdx
    33bd:	48 c1 f8 07          	sar    rax,0x7
    33c1:	48 89 c6             	mov    rsi,rax
    33c4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    33cb:	b8 00 00 00 00       	mov    eax,0x0
    33d0:	e8 00 00 00 00       	call   33d5 <ahci_port_activate_device+0x37d>
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    33d5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33d9:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    33dc:	c1 e8 08             	shr    eax,0x8
    33df:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    33e2:	0f b6 f8             	movzx  edi,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    33e5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33e9:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    33ec:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    33ef:	0f b6 f0             	movzx  esi,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    33f2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33f6:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    33f9:	0f b6 c4             	movzx  eax,ah
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    33fc:	0f b6 c8             	movzx  ecx,al
    33ff:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3403:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3406:	0f b6 d0             	movzx  edx,al
    3409:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    340d:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3410:	41 89 f9             	mov    r9d,edi
    3413:	41 89 f0             	mov    r8d,esi
    3416:	89 c6                	mov    esi,eax
    3418:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    341f:	b8 00 00 00 00       	mov    eax,0x0
    3424:	e8 00 00 00 00       	call   3429 <ahci_port_activate_device+0x3d1>
				return;
    3429:	eb 76                	jmp    34a1 <ahci_port_activate_device+0x449>
		} else if (p->scr0.det == DET_PHY_OFFLINE) {
    342b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    342f:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3432:	83 e0 0f             	and    eax,0xf
    3435:	3c 04                	cmp    al,0x4
    3437:	75 16                	jne    344f <ahci_port_activate_device+0x3f7>
				/* just deactivated */
				abprintf("PHY offline mode\n");
    3439:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3440:	b8 00 00 00 00       	mov    eax,0x0
    3445:	e8 00 00 00 00       	call   344a <ahci_port_activate_device+0x3f2>
				goto activ;
    344a:	e9 ba fe ff ff       	jmp    3309 <ahci_port_activate_device+0x2b1>
		} else if (p->scr0.det == DET_PRESENT_NO_PHY) {
    344f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3453:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3456:	83 e0 0f             	and    eax,0xf
    3459:	3c 01                	cmp    al,0x1
    345b:	75 16                	jne    3473 <ahci_port_activate_device+0x41b>
				abprintf("PRESENT_NO_PHY mode\n");
    345d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3464:	b8 00 00 00 00       	mov    eax,0x0
    3469:	e8 00 00 00 00       	call   346e <ahci_port_activate_device+0x416>
				goto activ; /* try the same */
    346e:	e9 96 fe ff ff       	jmp    3309 <ahci_port_activate_device+0x2b1>
		}
exit:
    3473:	90                   	nop
				/* we're really done */
				abprintf("Not present at port %zd\n", p - h->port);
    3474:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3478:	48 05 00 01 00 00    	add    rax,0x100
    347e:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3482:	48 29 c2             	sub    rdx,rax
    3485:	48 89 d0             	mov    rax,rdx
    3488:	48 c1 f8 07          	sar    rax,0x7
    348c:	48 89 c6             	mov    rsi,rax
    348f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3496:	b8 00 00 00 00       	mov    eax,0x0
    349b:	e8 00 00 00 00       	call   34a0 <ahci_port_activate_device+0x448>
				return;
    34a0:	90                   	nop
}
    34a1:	c9                   	leave
    34a2:	c3                   	ret

00000000000034a3 <ahci_enable_port>:

void ahci_enable_port(struct ahci_device* ad, int pt)
{
    34a3:	55                   	push   rbp
    34a4:	48 89 e5             	mov    rbp,rsp
    34a7:	48 83 ec 30          	sub    rsp,0x30
    34ab:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    34af:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		struct ahci_port* p = &ad->ptr->port[pt];
    34b2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    34b6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    34ba:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    34bd:	48 63 d2             	movsxd rdx,edx
    34c0:	48 83 c2 02          	add    rdx,0x2
    34c4:	48 c1 e2 07          	shl    rdx,0x7
    34c8:	48 01 d0             	add    rax,rdx
    34cb:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		int reset_ct = 0;
    34cf:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    34d6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    34da:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    34de:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    34e1:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    34e4:	be 01 00 00 00       	mov    esi,0x1
    34e9:	89 c1                	mov    ecx,eax
    34eb:	d3 e6                	shl    esi,cl
    34ed:	89 f0                	mov    eax,esi
    34ef:	21 d0                	and    eax,edx
    34f1:	85 c0                	test   eax,eax
    34f3:	0f 84 65 02 00 00    	je     375e <ahci_enable_port+0x2bb>
				return;

Pos1:
    34f9:	90                   	nop
		/* clear old data */
		p->pXserr = 0xffffffff; /* 10.1.2 -> 6. */
    34fa:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34fe:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
		p->pXis = 0xffffffff; /* clear all pending interrupts */
    3505:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3509:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [rax+0x10],0xffffffff

		/* first allow for the reception of FISes */
		p->cmd.fre = 1;
    3510:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3514:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3517:	83 c8 10             	or     eax,0x10
    351a:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		ndelay(20); /* wait for BSY to show up */
    351d:	bf 14 00 00 00       	mov    edi,0x14
    3522:	e8 00 00 00 00       	call   3527 <ahci_enable_port+0x84>
		while (1) {
				uint8_t sts = p->tfd.sts;
    3527:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    352b:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    352e:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
				if (sts & TFS_ERR) {
    3531:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
    3535:	83 e0 01             	and    eax,0x1
    3538:	85 c0                	test   eax,eax
    353a:	0f 84 f1 00 00 00    	je     3631 <ahci_enable_port+0x18e>
						/* something went wrong! */
						if (sts == 0x7f) /* no device */
    3540:	80 7d ef 7f          	cmp    BYTE PTR [rbp-0x11],0x7f
    3544:	0f 84 03 01 00 00    	je     364d <ahci_enable_port+0x1aa>
								break;
						else if (sts == 0x41 && p->tfd.err == 0x20) {
    354a:	80 7d ef 41          	cmp    BYTE PTR [rbp-0x11],0x41
    354e:	75 20                	jne    3570 <ahci_enable_port+0xcd>
    3550:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3554:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3557:	0f b6 c4             	movzx  eax,ah
    355a:	3c 20                	cmp    al,0x20
    355c:	75 12                	jne    3570 <ahci_enable_port+0xcd>
								if (p->pXsig == SIG_ATAPI)
    355e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3562:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    3565:	3d 01 01 14 eb       	cmp    eax,0xeb140101
    356a:	0f 84 e0 00 00 00    	je     3650 <ahci_enable_port+0x1ad>
										break; /* no medium */
						}
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
								" while starting up.\n", pt, p->tfd.err);
    3570:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3574:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3577:	0f b6 c4             	movzx  eax,ah
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
    357a:	0f b6 d0             	movzx  edx,al
    357d:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    3580:	89 d1                	mov    ecx,edx
    3582:	89 c2                	mov    edx,eax
    3584:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    358b:	bf 0e 00 00 00       	mov    edi,0xe
    3590:	b8 00 00 00 00       	mov    eax,0x0
    3595:	e8 00 00 00 00       	call   359a <ahci_enable_port+0xf7>
						abprintf("scr1: %x %x\n", p->scr1.diag, p->scr1.err);
    359a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    359e:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    35a1:	0f b7 d0             	movzx  edx,ax
    35a4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35a8:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    35ab:	c1 e8 10             	shr    eax,0x10
    35ae:	0f b7 c0             	movzx  eax,ax
    35b1:	89 c6                	mov    esi,eax
    35b3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35ba:	b8 00 00 00 00       	mov    eax,0x0
    35bf:	e8 00 00 00 00       	call   35c4 <ahci_enable_port+0x121>
						abprintf("tfd: %x %x\n", p->tfd.sts, p->tfd.err);
    35c4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35c8:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    35cb:	0f b6 c4             	movzx  eax,ah
    35ce:	0f b6 d0             	movzx  edx,al
    35d1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35d5:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    35d8:	0f b6 c0             	movzx  eax,al
    35db:	89 c6                	mov    esi,eax
    35dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35e4:	b8 00 00 00 00       	mov    eax,0x0
    35e9:	e8 00 00 00 00       	call   35ee <ahci_enable_port+0x14b>
						p->pXserr = 0xffffffff;
    35ee:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35f2:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
						if (!reset_ct++) {
    35f9:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    35fc:	8d 50 01             	lea    edx,[rax+0x1]
    35ff:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    3602:	85 c0                	test   eax,eax
    3604:	75 1c                	jne    3622 <ahci_enable_port+0x17f>
								ahci_port_activate_device(ad->ptr, p);
    3606:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    360a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    360e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3612:	48 89 d6             	mov    rsi,rdx
    3615:	48 89 c7             	mov    rdi,rax
    3618:	e8 00 00 00 00       	call   361d <ahci_enable_port+0x17a>
								goto Pos1;
    361d:	e9 d8 fe ff ff       	jmp    34fa <ahci_enable_port+0x57>
						} else if (reset_ct == 1) {
    3622:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
    3626:	0f 85 08 01 00 00    	jne    3734 <ahci_enable_port+0x291>
								/*ahci_reset_port(ad->ptr, p);*/
								goto Pos1;
    362c:	e9 c9 fe ff ff       	jmp    34fa <ahci_enable_port+0x57>
						} else
								goto defer;
				}
				if (!(sts & (TFS_BSY | TFS_DRQ)))
    3631:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
    3635:	25 88 00 00 00       	and    eax,0x88
    363a:	85 c0                	test   eax,eax
    363c:	74 15                	je     3653 <ahci_enable_port+0x1b0>
						break;
				udelay(50);
    363e:	bf 32 00 00 00       	mov    edi,0x32
    3643:	e8 00 00 00 00       	call   3648 <ahci_enable_port+0x1a5>
		while (1) {
    3648:	e9 da fe ff ff       	jmp    3527 <ahci_enable_port+0x84>
								break;
    364d:	90                   	nop
    364e:	eb 04                	jmp    3654 <ahci_enable_port+0x1b1>
										break; /* no medium */
    3650:	90                   	nop
    3651:	eb 01                	jmp    3654 <ahci_enable_port+0x1b1>
						break;
    3653:	90                   	nop
		}

		/* set ST only if BSY,DRQ and DET=3h or IPM=2,6,8 */
		if (p->scr0.det != 3)
    3654:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3658:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    365b:	83 e0 0f             	and    eax,0xf
    365e:	3c 03                	cmp    al,0x3
    3660:	74 17                	je     3679 <ahci_enable_port+0x1d6>
				ahci_port_activate_device(ad->ptr, p);
    3662:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3666:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    366a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    366e:	48 89 d6             	mov    rsi,rdx
    3671:	48 89 c7             	mov    rdi,rax
    3674:	e8 00 00 00 00       	call   3679 <ahci_enable_port+0x1d6>
		if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    3679:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    367d:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3680:	0f b6 c0             	movzx  eax,al
    3683:	25 88 00 00 00       	and    eax,0x88
    3688:	85 c0                	test   eax,eax
    368a:	0f 85 a7 00 00 00    	jne    3737 <ahci_enable_port+0x294>
				goto defer; /* listen */
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    3690:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3694:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3697:	83 e0 0f             	and    eax,0xf
    369a:	3c 03                	cmp    al,0x3
    369c:	74 33                	je     36d1 <ahci_enable_port+0x22e>
    369e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    36a2:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    36a5:	c1 e8 08             	shr    eax,0x8
    36a8:	83 e0 0f             	and    eax,0xf
    36ab:	3c 02                	cmp    al,0x2
    36ad:	74 22                	je     36d1 <ahci_enable_port+0x22e>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    36af:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    36b3:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    36b6:	c1 e8 08             	shr    eax,0x8
    36b9:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    36bc:	3c 06                	cmp    al,0x6
    36be:	74 11                	je     36d1 <ahci_enable_port+0x22e>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    36c0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    36c4:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    36c7:	c1 e8 08             	shr    eax,0x8
    36ca:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    36cd:	3c 08                	cmp    al,0x8
    36cf:	75 69                	jne    373a <ahci_enable_port+0x297>
				goto defer;
		/* we're allowed so set it */
		p->cmd.st = 1;
    36d1:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    36d5:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    36d8:	83 c8 01             	or     eax,0x1
    36db:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		/* Change in PhyRdy, CPS, TFS.err, PCS, DPS(I=1), UFS, HBFS, HBDS, IFS, D2HFIS */
		p->pXie = (1 << 22) | (1 << 6) | (1 << 31) | (1 << 30) | (1 << 0)
    36de:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    36e2:	c7 40 14 71 00 40 f8 	mov    DWORD PTR [rax+0x14],0xf8400071
				| (1 << 5) | (1 << 4) | (1 << 29) | (1 << 28) | (1 << 27);

		/* issue the IDENTIFY_(PACKET)_DEVICE command */
		ahci_issue_command(ad, pt, 0, disk_cmd_identify, 0, 0, NULL, NULL /* wq_worker_ad*/, NULL);
    36e9:	8b 75 d4             	mov    esi,DWORD PTR [rbp-0x2c]
    36ec:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    36f0:	48 83 ec 08          	sub    rsp,0x8
    36f4:	6a 00                	push   0x0
    36f6:	6a 00                	push   0x0
    36f8:	6a 00                	push   0x0
    36fa:	41 b9 00 00 00 00    	mov    r9d,0x0
    3700:	41 b8 00 00 00 00    	mov    r8d,0x0
    3706:	b9 00 00 00 00       	mov    ecx,0x0
    370b:	ba 00 00 00 00       	mov    edx,0x0
    3710:	48 89 c7             	mov    rdi,rax
    3713:	e8 00 00 00 00       	call   3718 <ahci_enable_port+0x275>
    3718:	48 83 c4 20          	add    rsp,0x20

		printf("port %d is now processing commands\n", pt);
    371c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    371f:	89 c6                	mov    esi,eax
    3721:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3728:	b8 00 00 00 00       	mov    eax,0x0
    372d:	e8 00 00 00 00       	call   3732 <ahci_enable_port+0x28f>
		return;
    3732:	eb 2b                	jmp    375f <ahci_enable_port+0x2bc>
								goto defer;
    3734:	90                   	nop
    3735:	eb 04                	jmp    373b <ahci_enable_port+0x298>
				goto defer; /* listen */
    3737:	90                   	nop
    3738:	eb 01                	jmp    373b <ahci_enable_port+0x298>
				goto defer;
    373a:	90                   	nop

defer: /* we're interested in status changes only */
		abprintf("port %d set to listening mode\n", pt);
    373b:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    373e:	89 c6                	mov    esi,eax
    3740:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3747:	b8 00 00 00 00       	mov    eax,0x0
    374c:	e8 00 00 00 00       	call   3751 <ahci_enable_port+0x2ae>
		p->pXie = (1 << 22) | (1 << 31) | (1 << 6); /* PhyRdy change, CPS, CCS */
    3751:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3755:	c7 40 14 40 00 40 80 	mov    DWORD PTR [rax+0x14],0x80400040
    375c:	eb 01                	jmp    375f <ahci_enable_port+0x2bc>
				return;
    375e:	90                   	nop
}
    375f:	c9                   	leave
    3760:	c3                   	ret

0000000000003761 <ahci_stop_port>:

void ahci_stop_port(struct ahci_device* ad, int pt)
{
    3761:	55                   	push   rbp
    3762:	48 89 e5             	mov    rbp,rsp
    3765:	48 83 ec 20          	sub    rsp,0x20
    3769:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    376d:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct ahci_port* p = &ad->ptr->port[pt];
    3770:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3774:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3778:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    377b:	48 63 d2             	movsxd rdx,edx
    377e:	48 83 c2 02          	add    rdx,0x2
    3782:	48 c1 e2 07          	shl    rdx,0x7
    3786:	48 01 d0             	add    rax,rdx
    3789:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		int ct;

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    378d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3791:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3795:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3798:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    379b:	be 01 00 00 00       	mov    esi,0x1
    37a0:	89 c1                	mov    ecx,eax
    37a2:	d3 e6                	shl    esi,cl
    37a4:	89 f0                	mov    eax,esi
    37a6:	21 d0                	and    eax,edx
    37a8:	85 c0                	test   eax,eax
    37aa:	0f 84 6a 01 00 00    	je     391a <ahci_stop_port+0x1b9>
				return;

		/* print the BIOS provided status */
		abprintf("BIOS initial state of port %d:\n", pt);
    37b0:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    37b3:	89 c6                	mov    esi,eax
    37b5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    37bc:	b8 00 00 00 00       	mov    eax,0x0
    37c1:	e8 00 00 00 00       	call   37c6 <ahci_stop_port+0x65>
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
				p->cmd.st ? "ST" : "");
    37c6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37ca:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    37cd:	83 e0 01             	and    eax,0x1
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
    37d0:	84 c0                	test   al,al
    37d2:	74 09                	je     37dd <ahci_stop_port+0x7c>
    37d4:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    37db:	eb 07                	jmp    37e4 <ahci_stop_port+0x83>
    37dd:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    37e4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37e8:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    37eb:	c1 e8 04             	shr    eax,0x4
    37ee:	83 e0 01             	and    eax,0x1
    37f1:	84 c0                	test   al,al
    37f3:	74 09                	je     37fe <ahci_stop_port+0x9d>
    37f5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    37fc:	eb 07                	jmp    3805 <ahci_stop_port+0xa4>
    37fe:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3805:	48 89 c6             	mov    rsi,rax
    3808:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    380f:	b8 00 00 00 00       	mov    eax,0x0
    3814:	e8 00 00 00 00       	call   3819 <ahci_stop_port+0xb8>
		/* print the pointers */
		abprintf("BIOS command list located at %016llx\n", p->pXclb64);
    3819:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    381d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    3820:	48 89 c6             	mov    rsi,rax
    3823:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    382a:	b8 00 00 00 00       	mov    eax,0x0
    382f:	e8 00 00 00 00       	call   3834 <ahci_stop_port+0xd3>
		abprintf("BIOS FIS received buffer at  %016llx\n", p->pXfb64);
    3834:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3838:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    383c:	48 89 c6             	mov    rsi,rax
    383f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3846:	b8 00 00 00 00       	mov    eax,0x0
    384b:	e8 00 00 00 00       	call   3850 <ahci_stop_port+0xef>

		/* check if already off */
		if (!p->cmd.fre && !p->cmd.st)
    3850:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3854:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3857:	c1 e8 04             	shr    eax,0x4
    385a:	83 e0 01             	and    eax,0x1
    385d:	84 c0                	test   al,al
    385f:	75 12                	jne    3873 <ahci_stop_port+0x112>
    3861:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3865:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3868:	83 e0 01             	and    eax,0x1
    386b:	84 c0                	test   al,al
    386d:	0f 84 aa 00 00 00    	je     391d <ahci_stop_port+0x1bc>
				return;

		/* Now turn it off (2x500ms max else reset) */
		ct = 50;
    3873:	c7 45 fc 32 00 00 00 	mov    DWORD PTR [rbp-0x4],0x32
		p->cmd.st = 0;
    387a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    387e:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3881:	83 e0 fe             	and    eax,0xfffffffe
    3884:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		while (p->cmd.cr && ct--)
    3887:	eb 0a                	jmp    3893 <ahci_stop_port+0x132>
				mdelay(10);
    3889:	bf 0a 00 00 00       	mov    edi,0xa
    388e:	e8 00 00 00 00       	call   3893 <ahci_stop_port+0x132>
		while (p->cmd.cr && ct--)
    3893:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3897:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    389a:	c1 e8 0f             	shr    eax,0xf
    389d:	83 e0 01             	and    eax,0x1
    38a0:	84 c0                	test   al,al
    38a2:	74 0d                	je     38b1 <ahci_stop_port+0x150>
    38a4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    38a7:	8d 50 ff             	lea    edx,[rax-0x1]
    38aa:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    38ad:	85 c0                	test   eax,eax
    38af:	75 d8                	jne    3889 <ahci_stop_port+0x128>
		if (ct == -1)
    38b1:	83 7d fc ff          	cmp    DWORD PTR [rbp-0x4],0xffffffff
    38b5:	74 40                	je     38f7 <ahci_stop_port+0x196>
				goto reset;
		ct = 50;
    38b7:	c7 45 fc 32 00 00 00 	mov    DWORD PTR [rbp-0x4],0x32
		p->cmd.fre = 0;
    38be:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    38c2:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    38c5:	83 e0 ef             	and    eax,0xffffffef
    38c8:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		while (p->cmd.fr && ct--)
    38cb:	eb 0a                	jmp    38d7 <ahci_stop_port+0x176>
				mdelay(10);
    38cd:	bf 0a 00 00 00       	mov    edi,0xa
    38d2:	e8 00 00 00 00       	call   38d7 <ahci_stop_port+0x176>
		while (p->cmd.fr && ct--)
    38d7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    38db:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    38de:	c1 e8 0e             	shr    eax,0xe
    38e1:	83 e0 01             	and    eax,0x1
    38e4:	84 c0                	test   al,al
    38e6:	74 12                	je     38fa <ahci_stop_port+0x199>
    38e8:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    38eb:	8d 50 ff             	lea    edx,[rax-0x1]
    38ee:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    38f1:	85 c0                	test   eax,eax
    38f3:	75 d8                	jne    38cd <ahci_stop_port+0x16c>
reset:
    38f5:	eb 03                	jmp    38fa <ahci_stop_port+0x199>
				goto reset;
    38f7:	90                   	nop
    38f8:	eb 01                	jmp    38fb <ahci_stop_port+0x19a>
reset:
    38fa:	90                   	nop
		if (ct == -1) {
    38fb:	83 7d fc ff          	cmp    DWORD PTR [rbp-0x4],0xffffffff
    38ff:	75 1d                	jne    391e <ahci_stop_port+0x1bd>
				printf("Port %d: reset needed!\n", pt);
    3901:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    3904:	89 c6                	mov    esi,eax
    3906:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    390d:	b8 00 00 00 00       	mov    eax,0x0
    3912:	e8 00 00 00 00       	call   3917 <ahci_stop_port+0x1b6>
				/* TODO implement this */
				//ahci_reset_port(ad, pt);
				while (1);
    3917:	90                   	nop
    3918:	eb fd                	jmp    3917 <ahci_stop_port+0x1b6>
				return;
    391a:	90                   	nop
    391b:	eb 01                	jmp    391e <ahci_stop_port+0x1bd>
				return;
    391d:	90                   	nop
		}
		/* The port is now off innit? */
}
    391e:	c9                   	leave
    391f:	c3                   	ret

0000000000003920 <ahci_assign_buffers>:

/* we have ad->num_ports active ports needing num_cmd
 * command slots and one FIS receive buffer each.
 * The command lists are held in a shared pool. */
void ahci_assign_buffers(struct ahci_device* ad)
{
    3920:	55                   	push   rbp
    3921:	48 89 e5             	mov    rbp,rsp
    3924:	48 83 ec 60          	sub    rsp,0x60
    3928:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
		size_t bt_ct, pg_ct; int flg = MMGR_ALLOC_COMPLETE;
    392c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		struct page_range pr; int cc, fc, ic;
		/* Total size: 256*np+1024*np+512*np */
		bt_ct = ad->num_ports * (sizeof(struct ahci_fis)
    3933:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3937:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    393b:	0f b7 d0             	movzx  edx,ax
    393e:	48 89 d0             	mov    rax,rdx
    3941:	48 c1 e0 03          	shl    rax,0x3
    3945:	48 29 d0             	sub    rax,rdx
    3948:	48 c1 e0 08          	shl    rax,0x8
    394c:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				+ sizeof(struct ahci_cmdlst) + 512);
		pg_ct = rdiv(bt_ct, 4096);
    3950:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    3954:	48 c1 e8 0c          	shr    rax,0xc
    3958:	48 89 c2             	mov    rdx,rax
    395b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    395f:	25 ff 0f 00 00       	and    eax,0xfff
    3964:	48 85 c0             	test   rax,rax
    3967:	74 07                	je     3970 <ahci_assign_buffers+0x50>
    3969:	b8 01 00 00 00       	mov    eax,0x1
    396e:	eb 05                	jmp    3975 <ahci_assign_buffers+0x55>
    3970:	b8 00 00 00 00       	mov    eax,0x0
    3975:	48 01 d0             	add    rax,rdx
    3978:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax

		/* allocate and map the physical memory */
		ic = cc = fc = ad->num_ports;
    397c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3980:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3984:	0f b7 c0             	movzx  eax,ax
    3987:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    398a:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    398d:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    3990:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    3993:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		if (!ad->ptr->cap.is_64bit)
    3996:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    399a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    399e:	8b 00                	mov    eax,DWORD PTR [rax]
    39a0:	c1 e8 1f             	shr    eax,0x1f
    39a3:	84 c0                	test   al,al
    39a5:	0f 85 06 03 00 00    	jne    3cb1 <ahci_assign_buffers+0x391>
				flg = MMGR_ALLOC_32BIT;
    39ab:	c7 45 f4 00 00 04 00 	mov    DWORD PTR [rbp-0xc],0x40000
		while (pg_ct) {
    39b2:	e9 fa 02 00 00       	jmp    3cb1 <ahci_assign_buffers+0x391>
				void* ptr; size_t nb;
				/* we don't need contiguous memory */
				pg_ct -= mm_alloc_pm_flg(pg_ct, &pr, 1, flg);
    39b7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    39bb:	89 c7                	mov    edi,eax
    39bd:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    39c0:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    39c4:	89 d1                	mov    ecx,edx
    39c6:	ba 01 00 00 00       	mov    edx,0x1
    39cb:	48 89 c6             	mov    rsi,rax
    39ce:	e8 00 00 00 00       	call   39d3 <ahci_assign_buffers+0xb3>
    39d3:	89 c0                	mov    eax,eax
    39d5:	48 29 45 f8          	sub    QWORD PTR [rbp-0x8],rax
				if (!pr.count)
    39d9:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    39dd:	48 85 c0             	test   rax,rax
    39e0:	0f 84 db 02 00 00    	je     3cc1 <ahci_assign_buffers+0x3a1>
						goto quit;
				nb = 4096 * pr.count;
    39e6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    39ea:	48 c1 e0 0c          	shl    rax,0xc
    39ee:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, /*MMGR_MAP_MMIO | <- 0xe nope */
    39f2:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    39f6:	41 b8 2c 00 00 00    	mov    r8d,0x2c
    39fc:	b9 01 00 00 00       	mov    ecx,0x1
    3a01:	48 89 c2             	mov    rdx,rax
    3a04:	be 00 00 00 00       	mov    esi,0x0
    3a09:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a10:	e8 00 00 00 00       	call   3a15 <ahci_assign_buffers+0xf5>
    3a15:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!ptr)
    3a19:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    3a1e:	0f 84 a0 02 00 00    	je     3cc4 <ahci_assign_buffers+0x3a4>
						goto quit;

				/* now first process the command lists with 1K-alignment */
				while (cc && nb >= 1024) {
    3a24:	e9 8f 00 00 00       	jmp    3ab8 <ahci_assign_buffers+0x198>
						int pt = ad->num_ports - cc--;
    3a29:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a2d:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3a31:	0f b7 c8             	movzx  ecx,ax
    3a34:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    3a37:	8d 50 ff             	lea    edx,[rax-0x1]
    3a3a:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
    3a3d:	29 c1                	sub    ecx,eax
    3a3f:	89 ca                	mov    edx,ecx
    3a41:	89 55 cc             	mov    DWORD PTR [rbp-0x34],edx
						if (ad->ptr->ports & (1 << pt)) {
    3a44:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a48:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3a4c:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3a4f:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    3a52:	be 01 00 00 00       	mov    esi,0x1
    3a57:	89 c1                	mov    ecx,eax
    3a59:	d3 e6                	shl    esi,cl
    3a5b:	89 f0                	mov    eax,esi
    3a5d:	21 d0                	and    eax,edx
    3a5f:	85 c0                	test   eax,eax
    3a61:	74 55                	je     3ab8 <ahci_assign_buffers+0x198>
								/* assign for implemented port */
								ad->ptr->port[pt].pXclb64 = pr.base;
    3a63:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a67:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    3a6b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3a6f:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34]
    3a72:	48 63 c9             	movsxd rcx,ecx
    3a75:	48 83 c1 02          	add    rcx,0x2
    3a79:	48 c1 e1 07          	shl    rcx,0x7
    3a7d:	48 01 ca             	add    rdx,rcx
    3a80:	48 89 02             	mov    QWORD PTR [rdx],rax
								ad->command_lists[pt] = ptr;
    3a83:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a87:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
    3a8a:	48 63 d2             	movsxd rdx,edx
    3a8d:	48 8d 4a 02          	lea    rcx,[rdx+0x2]
    3a91:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3a95:	48 89 54 c8 08       	mov    QWORD PTR [rax+rcx*8+0x8],rdx
								/* advance */
								pr.base += 1024;
    3a9a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3a9e:	48 05 00 04 00 00    	add    rax,0x400
    3aa4:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								nb -= 1024;
    3aa8:	48 81 6d d8 00 04 00 00 	sub    QWORD PTR [rbp-0x28],0x400
								ptr += 1024;
    3ab0:	48 81 45 e0 00 04 00 00 	add    QWORD PTR [rbp-0x20],0x400
				while (cc && nb >= 1024) {
    3ab8:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3abc:	0f 84 a6 00 00 00    	je     3b68 <ahci_assign_buffers+0x248>
    3ac2:	48 81 7d d8 ff 03 00 00 	cmp    QWORD PTR [rbp-0x28],0x3ff
    3aca:	0f 87 59 ff ff ff    	ja     3a29 <ahci_assign_buffers+0x109>
						}
				}

				/* then the FIS buffers (256bt-aligned) */
				while (fc && nb >= 256) {
    3ad0:	e9 93 00 00 00       	jmp    3b68 <ahci_assign_buffers+0x248>
						int pt = ad->num_ports - fc--;
    3ad5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ad9:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3add:	0f b7 c8             	movzx  ecx,ax
    3ae0:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    3ae3:	8d 50 ff             	lea    edx,[rax-0x1]
    3ae6:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
    3ae9:	29 c1                	sub    ecx,eax
    3aeb:	89 ca                	mov    edx,ecx
    3aed:	89 55 c8             	mov    DWORD PTR [rbp-0x38],edx
						if (ad->ptr->ports & (1 << pt)) {
    3af0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3af4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3af8:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3afb:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    3afe:	be 01 00 00 00       	mov    esi,0x1
    3b03:	89 c1                	mov    ecx,eax
    3b05:	d3 e6                	shl    esi,cl
    3b07:	89 f0                	mov    eax,esi
    3b09:	21 d0                	and    eax,edx
    3b0b:	85 c0                	test   eax,eax
    3b0d:	74 59                	je     3b68 <ahci_assign_buffers+0x248>
								/* as above */
								ad->ptr->port[pt].pXfb64 = pr.base;
    3b0f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3b13:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    3b17:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3b1b:	8b 4d c8             	mov    ecx,DWORD PTR [rbp-0x38]
    3b1e:	48 63 c9             	movsxd rcx,ecx
    3b21:	48 83 c1 02          	add    rcx,0x2
    3b25:	48 c1 e1 07          	shl    rcx,0x7
    3b29:	48 01 ca             	add    rdx,rcx
    3b2c:	48 83 c2 08          	add    rdx,0x8
    3b30:	48 89 02             	mov    QWORD PTR [rdx],rax
								ad->recv_fis[pt] = ptr;
    3b33:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3b37:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    3b3a:	48 63 d2             	movsxd rdx,edx
    3b3d:	48 8d 4a 22          	lea    rcx,[rdx+0x22]
    3b41:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3b45:	48 89 54 c8 08       	mov    QWORD PTR [rax+rcx*8+0x8],rdx
								/* advance */
								pr.base += 256;
    3b4a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3b4e:	48 05 00 01 00 00    	add    rax,0x100
    3b54:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								nb -= 256;
    3b58:	48 81 6d d8 00 01 00 00 	sub    QWORD PTR [rbp-0x28],0x100
								ptr += 256;
    3b60:	48 81 45 e0 00 01 00 00 	add    QWORD PTR [rbp-0x20],0x100
				while (fc && nb >= 256) {
    3b68:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    3b6c:	0f 84 e2 00 00 00    	je     3c54 <ahci_assign_buffers+0x334>
    3b72:	48 81 7d d8 ff 00 00 00 	cmp    QWORD PTR [rbp-0x28],0xff
    3b7a:	0f 87 55 ff ff ff    	ja     3ad5 <ahci_assign_buffers+0x1b5>
						}
				}

				while (ic && nb >= 512) {
    3b80:	e9 cf 00 00 00       	jmp    3c54 <ahci_assign_buffers+0x334>
						int pt = ad->num_ports - ic--;
    3b85:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3b89:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3b8d:	0f b7 c8             	movzx  ecx,ax
    3b90:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    3b93:	8d 50 ff             	lea    edx,[rax-0x1]
    3b96:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
    3b99:	29 c1                	sub    ecx,eax
    3b9b:	89 ca                	mov    edx,ecx
    3b9d:	89 55 c4             	mov    DWORD PTR [rbp-0x3c],edx
						if (ad->ptr->ports & (1 << pt)) {
    3ba0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ba4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3ba8:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3bab:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3bae:	be 01 00 00 00       	mov    esi,0x1
    3bb3:	89 c1                	mov    ecx,eax
    3bb5:	d3 e6                	shl    esi,cl
    3bb7:	89 f0                	mov    eax,esi
    3bb9:	21 d0                	and    eax,edx
    3bbb:	85 c0                	test   eax,eax
    3bbd:	74 6f                	je     3c2e <ahci_assign_buffers+0x30e>
								/* as above */
								ad->identify_data[pt].pm = pr.base;
    3bbf:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    3bc3:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    3bc7:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3bca:	48 63 d0             	movsxd rdx,eax
    3bcd:	48 89 d0             	mov    rax,rdx
    3bd0:	48 01 c0             	add    rax,rax
    3bd3:	48 01 d0             	add    rax,rdx
    3bd6:	48 c1 e0 03          	shl    rax,0x3
    3bda:	48 01 f0             	add    rax,rsi
    3bdd:	48 05 28 02 00 00    	add    rax,0x228
    3be3:	48 89 08             	mov    QWORD PTR [rax],rcx
								ad->identify_data[pt].ptr = ptr;
    3be6:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    3bea:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3bed:	48 63 d0             	movsxd rdx,eax
    3bf0:	48 89 d0             	mov    rax,rdx
    3bf3:	48 01 c0             	add    rax,rax
    3bf6:	48 01 d0             	add    rax,rdx
    3bf9:	48 c1 e0 03          	shl    rax,0x3
    3bfd:	48 01 c8             	add    rax,rcx
    3c00:	48 8d 90 20 02 00 00 	lea    rdx,[rax+0x220]
    3c07:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3c0b:	48 89 02             	mov    QWORD PTR [rdx],rax
								/* advance */
								pr.base += 512;
    3c0e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3c12:	48 05 00 02 00 00    	add    rax,0x200
    3c18:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								nb -= 512;
    3c1c:	48 81 6d d8 00 02 00 00 	sub    QWORD PTR [rbp-0x28],0x200
								ptr += 512;
    3c24:	48 81 45 e0 00 02 00 00 	add    QWORD PTR [rbp-0x20],0x200
    3c2c:	eb 26                	jmp    3c54 <ahci_assign_buffers+0x334>
						} else
								ad->identify_data[pt].sig = 0;
    3c2e:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    3c32:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3c35:	48 63 d0             	movsxd rdx,eax
    3c38:	48 89 d0             	mov    rax,rdx
    3c3b:	48 01 c0             	add    rax,rax
    3c3e:	48 01 d0             	add    rax,rdx
    3c41:	48 c1 e0 03          	shl    rax,0x3
    3c45:	48 01 c8             	add    rax,rcx
    3c48:	48 05 18 02 00 00    	add    rax,0x218
    3c4e:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				while (ic && nb >= 512) {
    3c54:	83 7d e8 00          	cmp    DWORD PTR [rbp-0x18],0x0
    3c58:	74 0e                	je     3c68 <ahci_assign_buffers+0x348>
    3c5a:	48 81 7d d8 ff 01 00 00 	cmp    QWORD PTR [rbp-0x28],0x1ff
    3c62:	0f 87 1d ff ff ff    	ja     3b85 <ahci_assign_buffers+0x265>
				}

				/* exit early if we have non-impelented ports */
				if (!fc && !cc && !ic) {
    3c68:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    3c6c:	75 43                	jne    3cb1 <ahci_assign_buffers+0x391>
    3c6e:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3c72:	75 3d                	jne    3cb1 <ahci_assign_buffers+0x391>
    3c74:	83 7d e8 00          	cmp    DWORD PTR [rbp-0x18],0x0
    3c78:	75 37                	jne    3cb1 <ahci_assign_buffers+0x391>
						/* also deallocate if possible */
						if (nb >= 4096) {
    3c7a:	48 81 7d d8 ff 0f 00 00 	cmp    QWORD PTR [rbp-0x28],0xfff
    3c82:	76 3a                	jbe    3cbe <ahci_assign_buffers+0x39e>
								ptr += (size_t)ptr % 4096;
    3c84:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3c88:	25 ff 0f 00 00       	and    eax,0xfff
    3c8d:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
								mm_free_vmem(&mm_kernel, ptr, nb / 4096);
    3c91:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3c95:	48 c1 e8 0c          	shr    rax,0xc
    3c99:	48 89 c2             	mov    rdx,rax
    3c9c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3ca0:	48 89 c6             	mov    rsi,rax
    3ca3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3caa:	e8 00 00 00 00       	call   3caf <ahci_assign_buffers+0x38f>
						}
						break;
    3caf:	eb 0d                	jmp    3cbe <ahci_assign_buffers+0x39e>
		while (pg_ct) {
    3cb1:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    3cb6:	0f 85 fb fc ff ff    	jne    39b7 <ahci_assign_buffers+0x97>
				}
		}
		/* Now all implemented buffers are set */
		return;
    3cbc:	eb 37                	jmp    3cf5 <ahci_assign_buffers+0x3d5>
						break;
    3cbe:	90                   	nop
		return;
    3cbf:	eb 34                	jmp    3cf5 <ahci_assign_buffers+0x3d5>
						goto quit;
    3cc1:	90                   	nop
    3cc2:	eb 01                	jmp    3cc5 <ahci_assign_buffers+0x3a5>
						goto quit;
    3cc4:	90                   	nop

quit:
		die("Out of memory!\n");
    3cc5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3ccc:	bf 0c 00 00 00       	mov    edi,0xc
    3cd1:	b8 00 00 00 00       	mov    eax,0x0
    3cd6:	e8 00 00 00 00       	call   3cdb <ahci_assign_buffers+0x3bb>
    3cdb:	b8 00 00 00 00       	mov    eax,0x0
    3ce0:	e8 00 00 00 00       	call   3ce5 <ahci_assign_buffers+0x3c5>
    3ce5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3cec:	e8 00 00 00 00       	call   3cf1 <ahci_assign_buffers+0x3d1>
    3cf1:	fa                   	cli
    3cf2:	f4                   	hlt
    3cf3:	eb fd                	jmp    3cf2 <ahci_assign_buffers+0x3d2>
}
    3cf5:	c9                   	leave
    3cf6:	c3                   	ret

0000000000003cf7 <ahci_clear_interrupts>:

/* also disables interrupts */
void ahci_clear_interrupts(struct ahci_device* ad)
{
    3cf7:	55                   	push   rbp
    3cf8:	48 89 e5             	mov    rbp,rsp
    3cfb:	48 83 ec 28          	sub    rsp,0x28
    3cff:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct ahci_hba* h = ad->ptr;
    3d03:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3d07:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3d0b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax

		/* disable interrupts */
		h->ctrl.ie = 0;
    3d0f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3d13:	8b 42 04             	mov    eax,DWORD PTR [rdx+0x4]
    3d16:	83 e0 fd             	and    eax,0xfffffffd
    3d19:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax

		/* clear them in every port implemented */
		for (int i = 0; i < ad->num_ports; i++) {
    3d1c:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    3d23:	eb 53                	jmp    3d78 <ahci_clear_interrupts+0x81>
				struct ahci_port* p;
				if ((h->ports & (1 << i)) == 0)
    3d25:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3d29:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3d2c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3d2f:	be 01 00 00 00       	mov    esi,0x1
    3d34:	89 c1                	mov    ecx,eax
    3d36:	d3 e6                	shl    esi,cl
    3d38:	89 f0                	mov    eax,esi
    3d3a:	21 d0                	and    eax,edx
    3d3c:	85 c0                	test   eax,eax
    3d3e:	74 33                	je     3d73 <ahci_clear_interrupts+0x7c>
						continue;
				p = &h->port[i];
    3d40:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3d43:	48 98                	cdqe
    3d45:	48 83 c0 02          	add    rax,0x2
    3d49:	48 c1 e0 07          	shl    rax,0x7
    3d4d:	48 89 c2             	mov    rdx,rax
    3d50:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3d54:	48 01 d0             	add    rax,rdx
    3d57:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				/* disable and clear all */
				p->pXie = 0;
    3d5b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3d5f:	c7 40 14 00 00 00 00 	mov    DWORD PTR [rax+0x14],0x0
				p->pXis = 0xffffffff;
    3d66:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3d6a:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [rax+0x10],0xffffffff
    3d71:	eb 01                	jmp    3d74 <ahci_clear_interrupts+0x7d>
						continue;
    3d73:	90                   	nop
		for (int i = 0; i < ad->num_ports; i++) {
    3d74:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3d78:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3d7c:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3d80:	0f b7 c0             	movzx  eax,ax
    3d83:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    3d86:	7c 9d                	jl     3d25 <ahci_clear_interrupts+0x2e>
		}

		/* clear the global status */
		h->intr = 0xffffffff; /* W1C */
    3d88:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3d8c:	c7 40 08 ff ff ff ff 	mov    DWORD PTR [rax+0x8],0xffffffff
}
    3d93:	90                   	nop
    3d94:	c9                   	leave
    3d95:	c3                   	ret

0000000000003d96 <ahci_device_init>:

int ahci_device_init(struct pci_device* d)
{
    3d96:	55                   	push   rbp
    3d97:	48 89 e5             	mov    rbp,rsp
    3d9a:	41 55                	push   r13
    3d9c:	41 54                	push   r12
    3d9e:	53                   	push   rbx
    3d9f:	48 81 ec e8 00 00 00 	sub    rsp,0xe8
    3da6:	48 89 bd 08 ff ff ff 	mov    QWORD PTR [rbp-0xf8],rdi
		int rv;

		/* Check progIf */
		if (d->device_interface != 1) {
    3dad:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3db4:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
    3db8:	3c 01                	cmp    al,0x1
    3dba:	74 30                	je     3dec <ahci_device_init+0x56>
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
						d->device_interface);
    3dbc:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3dc3:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
    3dc7:	0f b6 c0             	movzx  eax,al
    3dca:	89 c2                	mov    edx,eax
    3dcc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3dd3:	bf 0e 00 00 00       	mov    edi,0xe
    3dd8:	b8 00 00 00 00       	mov    eax,0x0
    3ddd:	e8 00 00 00 00       	call   3de2 <ahci_device_init+0x4c>
				return -ENOSYS;
    3de2:	b8 da ff ff ff       	mov    eax,0xffffffda
    3de7:	e9 03 09 00 00       	jmp    46ef <ahci_device_init+0x959>
		}

		/* Setup and map BAR5 if neccessary */
		if (d->ressources[5].type == PCI_BAR_PIO)
    3dec:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3df3:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [rax+0xc8]
    3df9:	83 f8 01             	cmp    eax,0x1
    3dfc:	75 0a                	jne    3e08 <ahci_device_init+0x72>
				return -ENOTSUP; /* AHCI requires MMIO at BAR5 */
    3dfe:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    3e03:	e9 e7 08 00 00       	jmp    46ef <ahci_device_init+0x959>
		if (!d->ressources[5].mmio.base) {
    3e08:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3e0f:	48 8b 80 d0 00 00 00 	mov    rax,QWORD PTR [rax+0xd0]
    3e16:	48 85 c0             	test   rax,rax
    3e19:	0f 85 28 01 00 00    	jne    3f47 <ahci_device_init+0x1b1>
				int atl = 0; uint64_t m;
    3e1f:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
				/* we first need pmem for the device */
				if (!d->ressources[5].mmio.size) {
    3e26:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3e2d:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3e34:	48 85 c0             	test   rax,rax
    3e37:	75 4e                	jne    3e87 <ahci_device_init+0xf1>
						/* Ask PCI */
						d->ressources[5].mmio.size = pci_bar_get_size(d, 5);
    3e39:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3e40:	be 05 00 00 00       	mov    esi,0x5
    3e45:	48 89 c7             	mov    rdi,rax
    3e48:	e8 00 00 00 00       	call   3e4d <ahci_device_init+0xb7>
    3e4d:	48 8b 95 08 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xf8]
    3e54:	48 89 82 d8 00 00 00 	mov    QWORD PTR [rdx+0xd8],rax
						if (!d->ressources[5].mmio.size) {
    3e5b:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3e62:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3e69:	48 85 c0             	test   rax,rax
    3e6c:	75 19                	jne    3e87 <ahci_device_init+0xf1>
								d->ressources[5].mmio.size = 0x1100; /* 32 ports */
    3e6e:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3e75:	48 c7 80 d8 00 00 00 00 11 00 00 	mov    QWORD PTR [rax+0xd8],0x1100
								atl = 1; /* about to leave */
    3e80:	c7 45 dc 01 00 00 00 	mov    DWORD PTR [rbp-0x24],0x1
						}
				}
				/* Now we want to get some address */
				m = mmio_allocate_range(d->ressources[5].mmio.size,
						0x3 & (d->ressources[5].type >> 1));
    3e87:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3e8e:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [rax+0xc8]
    3e94:	d1 f8                	sar    eax,1
				m = mmio_allocate_range(d->ressources[5].mmio.size,
    3e96:	83 e0 03             	and    eax,0x3
    3e99:	89 c2                	mov    edx,eax
    3e9b:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3ea2:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3ea9:	89 d6                	mov    esi,edx
    3eab:	48 89 c7             	mov    rdi,rax
    3eae:	e8 00 00 00 00       	call   3eb3 <ahci_device_init+0x11d>
    3eb3:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				if (!m)
    3eb7:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    3ebc:	75 0a                	jne    3ec8 <ahci_device_init+0x132>
						return -ENOMEM;
    3ebe:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3ec3:	e9 27 08 00 00       	jmp    46ef <ahci_device_init+0x959>
				/* and assign it */
				pci_set_bar(d, 5, d->ressources[5].type, m);
    3ec8:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3ecf:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [rax+0xc8]
    3ed5:	89 c6                	mov    esi,eax
    3ed7:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    3edb:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3ee2:	48 89 d1             	mov    rcx,rdx
    3ee5:	89 f2                	mov    edx,esi
    3ee7:	be 05 00 00 00       	mov    esi,0x5
    3eec:	48 89 c7             	mov    rdi,rax
    3eef:	e8 00 00 00 00       	call   3ef4 <ahci_device_init+0x15e>
				if (d->ressources[5].mmio.base != m) {
    3ef4:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3efb:	48 8b 80 d0 00 00 00 	mov    rax,QWORD PTR [rax+0xd0]
    3f02:	48 39 45 c0          	cmp    QWORD PTR [rbp-0x40],rax
    3f06:	74 3f                	je     3f47 <ahci_device_init+0x1b1>
						/* we can't */
						mmio_free_range(m, d->ressources[5].mmio.size);
    3f08:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3f0f:	48 8b 90 d8 00 00 00 	mov    rdx,QWORD PTR [rax+0xd8]
    3f16:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    3f1a:	48 89 d6             	mov    rsi,rdx
    3f1d:	48 89 c7             	mov    rdi,rax
    3f20:	e8 00 00 00 00       	call   3f25 <ahci_device_init+0x18f>
						if (atl)
    3f25:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    3f29:	74 12                	je     3f3d <ahci_device_init+0x1a7>
								d->ressources[5].mmio.size = 0;
    3f2b:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3f32:	48 c7 80 d8 00 00 00 00 00 00 00 	mov    QWORD PTR [rax+0xd8],0x0
						return -ENOTSUP;
    3f3d:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    3f42:	e9 a8 07 00 00       	jmp    46ef <ahci_device_init+0x959>
				}
		}

		/* Now we possibly have to map the memory */
		if (!d->ressources[5].mmio.mapping) {
    3f47:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3f4e:	48 8b 80 e0 00 00 00 	mov    rax,QWORD PTR [rax+0xe0]
    3f55:	48 85 c0             	test   rax,rax
    3f58:	0f 85 a5 00 00 00    	jne    4003 <ahci_device_init+0x26d>
				void* mem; struct page_range pr;
				pr.base = d->ressources[5].mmio.base;
    3f5e:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3f65:	48 8b 80 d0 00 00 00 	mov    rax,QWORD PTR [rax+0xd0]
    3f6c:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
				pr.count = rdiv(d->ressources[5].mmio.size, 4096);
    3f73:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3f7a:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3f81:	48 c1 e8 0c          	shr    rax,0xc
    3f85:	48 89 c2             	mov    rdx,rax
    3f88:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3f8f:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3f96:	25 ff 0f 00 00       	and    eax,0xfff
    3f9b:	48 85 c0             	test   rax,rax
    3f9e:	74 07                	je     3fa7 <ahci_device_init+0x211>
    3fa0:	b8 01 00 00 00       	mov    eax,0x1
    3fa5:	eb 05                	jmp    3fac <ahci_device_init+0x216>
    3fa7:	b8 00 00 00 00       	mov    eax,0x0
    3fac:	48 01 d0             	add    rax,rdx
    3faf:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
			   	mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_MMIO |
    3fb6:	48 8d 85 50 ff ff ff 	lea    rax,[rbp-0xb0]
    3fbd:	41 b8 2d 00 00 00    	mov    r8d,0x2d
    3fc3:	b9 01 00 00 00       	mov    ecx,0x1
    3fc8:	48 89 c2             	mov    rdx,rax
    3fcb:	be 00 00 00 00       	mov    esi,0x0
    3fd0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3fd7:	e8 00 00 00 00       	call   3fdc <ahci_device_init+0x246>
    3fdc:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!mem)
    3fe0:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    3fe5:	75 0a                	jne    3ff1 <ahci_device_init+0x25b>
						return -ENOMEM;
    3fe7:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3fec:	e9 fe 06 00 00       	jmp    46ef <ahci_device_init+0x959>
				d->ressources[5].mmio.mapping = mem;
    3ff1:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    3ff8:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    3ffc:	48 89 90 e0 00 00 00 	mov    QWORD PTR [rax+0xe0],rdx
		}

		/* we now have a working mapping */
		struct ahci_hba* h = d->ressources[5].mmio.mapping;
    4003:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    400a:	48 8b 80 e0 00 00 00 	mov    rax,QWORD PTR [rax+0xe0]
    4011:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		struct ahci_device* ad = kzalloc(sizeof(*ad));
    4015:	bf 58 0b 00 00       	mov    edi,0xb58
    401a:	e8 00 00 00 00       	call   401f <ahci_device_init+0x289>
    401f:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		if (!ad)
    4023:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
    4028:	75 0a                	jne    4034 <ahci_device_init+0x29e>
				return -ENOMEM;
    402a:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    402f:	e9 bb 06 00 00       	jmp    46ef <ahci_device_init+0x959>

		/* check for AE (access to other registers is disallowed before) */
		if (!(h->control & GHC_CNT_AE)) {
    4034:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4038:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    403b:	85 c0                	test   eax,eax
    403d:	78 26                	js     4065 <ahci_device_init+0x2cf>
				abprintf("switching to AHCI mode\n");
    403f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4046:	b8 00 00 00 00       	mov    eax,0x0
    404b:	e8 00 00 00 00       	call   4050 <ahci_device_init+0x2ba>
				h->control |= GHC_CNT_AE;
    4050:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4054:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    4057:	0d 00 00 00 80       	or     eax,0x80000000
    405c:	89 c2                	mov    edx,eax
    405e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4062:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		}

		/* fill the descriptors */
		ad->ptr = h; /* D2H is set but masked */
    4065:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4069:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    406d:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		ad->dev = d;
    4071:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4075:	48 8b 95 08 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xf8]
    407c:	48 89 10             	mov    QWORD PTR [rax],rdx
		ad->num_ports = min(h->cap.num_ports + 1, bsr(h->ports));
    407f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4083:	8b 00                	mov    eax,DWORD PTR [rax]
    4085:	83 e0 1f             	and    eax,0x1f
    4088:	0f b6 c0             	movzx  eax,al
    408b:	8d 58 01             	lea    ebx,[rax+0x1]
    408e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4092:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    4095:	89 c7                	mov    edi,eax
    4097:	e8 64 bf ff ff       	call   0 <bsr>
    409c:	39 c3                	cmp    ebx,eax
    409e:	7d 11                	jge    40b1 <ahci_device_init+0x31b>
    40a0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    40a4:	8b 00                	mov    eax,DWORD PTR [rax]
    40a6:	83 e0 1f             	and    eax,0x1f
    40a9:	0f b6 c0             	movzx  eax,al
    40ac:	8d 50 01             	lea    edx,[rax+0x1]
    40af:	eb 10                	jmp    40c1 <ahci_device_init+0x32b>
    40b1:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    40b5:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    40b8:	89 c7                	mov    edi,eax
    40ba:	e8 41 bf ff ff       	call   0 <bsr>
    40bf:	89 c2                	mov    edx,eax
    40c1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    40c5:	66 89 50 10          	mov    WORD PTR [rax+0x10],dx
		ad->num_cmd = h->cap.num_cmd + 1;
    40c9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    40cd:	8b 00                	mov    eax,DWORD PTR [rax]
    40cf:	c1 e8 08             	shr    eax,0x8
    40d2:	83 e0 1f             	and    eax,0x1f
    40d5:	0f b6 c0             	movzx  eax,al
    40d8:	8d 50 01             	lea    edx,[rax+0x1]
    40db:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    40df:	66 89 50 12          	mov    WORD PTR [rax+0x12],dx
		for (int i = 0; i < 32; i++) {
    40e3:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [rbp-0x28],0x0
    40ea:	e9 62 01 00 00       	jmp    4251 <ahci_device_init+0x4bb>
				ad->pending_cmds[i] = LIST_HEAD_INIT(ad->pending_cmds[i]);
    40ef:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    40f2:	48 63 d0             	movsxd rdx,eax
    40f5:	48 89 d0             	mov    rax,rdx
    40f8:	48 01 c0             	add    rax,rax
    40fb:	48 01 d0             	add    rax,rdx
    40fe:	48 c1 e0 03          	shl    rax,0x3
    4102:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    4109:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    410d:	48 8d 34 02          	lea    rsi,[rdx+rax*1]
    4111:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4114:	48 63 d0             	movsxd rdx,eax
    4117:	48 89 d0             	mov    rax,rdx
    411a:	48 01 c0             	add    rax,rax
    411d:	48 01 d0             	add    rax,rdx
    4120:	48 c1 e0 03          	shl    rax,0x3
    4124:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    412b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    412f:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    4133:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    4137:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    413a:	48 63 d0             	movsxd rdx,eax
    413d:	48 89 d0             	mov    rax,rdx
    4140:	48 01 c0             	add    rax,rax
    4143:	48 01 d0             	add    rax,rdx
    4146:	48 c1 e0 03          	shl    rax,0x3
    414a:	48 01 f8             	add    rax,rdi
    414d:	48 05 20 05 00 00    	add    rax,0x520
    4153:	48 89 30             	mov    QWORD PTR [rax],rsi
    4156:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    415a:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    415d:	48 63 d0             	movsxd rdx,eax
    4160:	48 89 d0             	mov    rax,rdx
    4163:	48 01 c0             	add    rax,rax
    4166:	48 01 d0             	add    rax,rdx
    4169:	48 c1 e0 03          	shl    rax,0x3
    416d:	48 01 f0             	add    rax,rsi
    4170:	48 05 28 05 00 00    	add    rax,0x528
    4176:	48 89 08             	mov    QWORD PTR [rax],rcx
    4179:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    417d:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4180:	48 63 d0             	movsxd rdx,eax
    4183:	48 89 d0             	mov    rax,rdx
    4186:	48 01 c0             	add    rax,rax
    4189:	48 01 d0             	add    rax,rdx
    418c:	48 c1 e0 03          	shl    rax,0x3
    4190:	48 01 c8             	add    rax,rcx
    4193:	48 05 30 05 00 00    	add    rax,0x530
    4199:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
				ad->proc_cmds[i] = LIST_HEAD_INIT(ad->proc_cmds[i]);
    419e:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    41a1:	48 63 d0             	movsxd rdx,eax
    41a4:	48 89 d0             	mov    rax,rdx
    41a7:	48 01 c0             	add    rax,rax
    41aa:	48 01 d0             	add    rax,rdx
    41ad:	48 c1 e0 03          	shl    rax,0x3
    41b1:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    41b8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    41bc:	48 8d 34 02          	lea    rsi,[rdx+rax*1]
    41c0:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    41c3:	48 63 d0             	movsxd rdx,eax
    41c6:	48 89 d0             	mov    rax,rdx
    41c9:	48 01 c0             	add    rax,rax
    41cc:	48 01 d0             	add    rax,rdx
    41cf:	48 c1 e0 03          	shl    rax,0x3
    41d3:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    41da:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    41de:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    41e2:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    41e6:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    41e9:	48 63 d0             	movsxd rdx,eax
    41ec:	48 89 d0             	mov    rax,rdx
    41ef:	48 01 c0             	add    rax,rax
    41f2:	48 01 d0             	add    rax,rdx
    41f5:	48 c1 e0 03          	shl    rax,0x3
    41f9:	48 01 f8             	add    rax,rdi
    41fc:	48 05 20 08 00 00    	add    rax,0x820
    4202:	48 89 30             	mov    QWORD PTR [rax],rsi
    4205:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    4209:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    420c:	48 63 d0             	movsxd rdx,eax
    420f:	48 89 d0             	mov    rax,rdx
    4212:	48 01 c0             	add    rax,rax
    4215:	48 01 d0             	add    rax,rdx
    4218:	48 c1 e0 03          	shl    rax,0x3
    421c:	48 01 f0             	add    rax,rsi
    421f:	48 05 28 08 00 00    	add    rax,0x828
    4225:	48 89 08             	mov    QWORD PTR [rax],rcx
    4228:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    422c:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    422f:	48 63 d0             	movsxd rdx,eax
    4232:	48 89 d0             	mov    rax,rdx
    4235:	48 01 c0             	add    rax,rax
    4238:	48 01 d0             	add    rax,rdx
    423b:	48 c1 e0 03          	shl    rax,0x3
    423f:	48 01 c8             	add    rax,rcx
    4242:	48 05 30 08 00 00    	add    rax,0x830
    4248:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
		for (int i = 0; i < 32; i++) {
    424d:	83 45 d8 01          	add    DWORD PTR [rbp-0x28],0x1
    4251:	83 7d d8 1f          	cmp    DWORD PTR [rbp-0x28],0x1f
    4255:	0f 8e 94 fe ff ff    	jle    40ef <ahci_device_init+0x359>
		}
		ad->ctxs = LIST_HEAD_INIT(ad->ctxs);
    425b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    425f:	48 8d 88 28 0b 00 00 	lea    rcx,[rax+0xb28]
    4266:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    426a:	48 8d 90 28 0b 00 00 	lea    rdx,[rax+0xb28]
    4271:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4275:	48 89 88 28 0b 00 00 	mov    QWORD PTR [rax+0xb28],rcx
    427c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4280:	48 89 90 30 0b 00 00 	mov    QWORD PTR [rax+0xb30],rdx
    4287:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    428b:	66 c7 80 38 0b 00 00 00 00 	mov    WORD PTR [rax+0xb38],0x0
		ad->wh = WAIT_QUEUE_HEAD(ad->wh);
    4294:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4298:	48 8d 88 40 0b 00 00 	lea    rcx,[rax+0xb40]
    429f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    42a3:	48 8d 90 40 0b 00 00 	lea    rdx,[rax+0xb40]
    42aa:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    42ae:	48 89 88 40 0b 00 00 	mov    QWORD PTR [rax+0xb40],rcx
    42b5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    42b9:	48 89 90 48 0b 00 00 	mov    QWORD PTR [rax+0xb48],rdx
    42c0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    42c4:	66 c7 80 50 0b 00 00 00 00 	mov    WORD PTR [rax+0xb50],0x0
    42cd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    42d1:	c7 80 54 0b 00 00 00 00 00 00 	mov    DWORD PTR [rax+0xb54],0x0

#ifdef AHCIBABBLE /* Tell the world about it */
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    42db:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42df:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42e2:	0f b6 f8             	movzx  edi,al
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    42e5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42e9:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    42ec:	c1 e8 08             	shr    eax,0x8
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42ef:	0f b6 d0             	movzx  edx,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    42f2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42f6:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    42f9:	c1 e8 10             	shr    eax,0x10
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42fc:	0f b6 c0             	movzx  eax,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    42ff:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    4303:	8b 49 10             	mov    ecx,DWORD PTR [rcx+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    4306:	c1 e9 18             	shr    ecx,0x18
    4309:	89 ce                	mov    esi,ecx
    430b:	41 89 f8             	mov    r8d,edi
    430e:	89 d1                	mov    ecx,edx
    4310:	89 c2                	mov    edx,eax
    4312:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4319:	b8 00 00 00 00       	mov    eax,0x0
    431e:	e8 00 00 00 00       	call   4323 <ahci_device_init+0x58d>
		/* and print the capablilities */
		printf("Features: %s%s%sspeed: %s\n",
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
				capstr(h->cap.if_speed, 4, "res", "1.5 Gbps", "3 Gbps", "6Gbps", ">6Gbps"));
    4323:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4327:	8b 00                	mov    eax,DWORD PTR [rax]
    4329:	c1 e8 14             	shr    eax,0x14
    432c:	83 e0 0f             	and    eax,0xf
		printf("Features: %s%s%sspeed: %s\n",
    432f:	0f b6 c0             	movzx  eax,al
    4332:	48 83 ec 08          	sub    rsp,0x8
    4336:	68 00 00 00 00       	push   0x0
    433b:	49 c7 c1 00 00 00 00 	mov    r9,0x0
    4342:	49 c7 c0 00 00 00 00 	mov    r8,0x0
    4349:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    4350:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    4357:	be 04 00 00 00       	mov    esi,0x4
    435c:	89 c7                	mov    edi,eax
    435e:	b8 00 00 00 00       	mov    eax,0x0
    4363:	e8 00 00 00 00       	call   4368 <ahci_device_init+0x5d2>
    4368:	48 83 c4 10          	add    rsp,0x10
    436c:	49 89 c5             	mov    r13,rax
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
    436f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4373:	8b 00                	mov    eax,DWORD PTR [rax]
    4375:	c1 e8 1f             	shr    eax,0x1f
		printf("Features: %s%s%sspeed: %s\n",
    4378:	0f b6 c0             	movzx  eax,al
    437b:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    4382:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    4389:	be 01 00 00 00       	mov    esi,0x1
    438e:	89 c7                	mov    edi,eax
    4390:	b8 00 00 00 00       	mov    eax,0x0
    4395:	e8 00 00 00 00       	call   439a <ahci_device_init+0x604>
    439a:	49 89 c4             	mov    r12,rax
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
    439d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    43a1:	8b 00                	mov    eax,DWORD PTR [rax]
    43a3:	c1 e8 12             	shr    eax,0x12
    43a6:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    43a9:	0f b6 c0             	movzx  eax,al
    43ac:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    43b3:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    43ba:	be 01 00 00 00       	mov    esi,0x1
    43bf:	89 c7                	mov    edi,eax
    43c1:	b8 00 00 00 00       	mov    eax,0x0
    43c6:	e8 00 00 00 00       	call   43cb <ahci_device_init+0x635>
    43cb:	48 89 c3             	mov    rbx,rax
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
    43ce:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    43d2:	8b 00                	mov    eax,DWORD PTR [rax]
    43d4:	c1 e8 1e             	shr    eax,0x1e
    43d7:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    43da:	0f b6 c0             	movzx  eax,al
    43dd:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    43e4:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    43eb:	be 01 00 00 00       	mov    esi,0x1
    43f0:	89 c7                	mov    edi,eax
    43f2:	b8 00 00 00 00       	mov    eax,0x0
    43f7:	e8 00 00 00 00       	call   43fc <ahci_device_init+0x666>
    43fc:	4d 89 e8             	mov    r8,r13
    43ff:	4c 89 e1             	mov    rcx,r12
    4402:	48 89 da             	mov    rdx,rbx
    4405:	48 89 c6             	mov    rsi,rax
    4408:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    440f:	b8 00 00 00 00       	mov    eax,0x0
    4414:	e8 00 00 00 00       	call   4419 <ahci_device_init+0x683>
		printf("AHCI HBA has %u ports and %u command slots\n",
				ad->num_ports, ad->num_cmd);
    4419:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    441d:	0f b7 40 12          	movzx  eax,WORD PTR [rax+0x12]
		printf("AHCI HBA has %u ports and %u command slots\n",
    4421:	0f b7 d0             	movzx  edx,ax
				ad->num_ports, ad->num_cmd);
    4424:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4428:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
		printf("AHCI HBA has %u ports and %u command slots\n",
    442c:	0f b7 c0             	movzx  eax,ax
    442f:	89 c6                	mov    esi,eax
    4431:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4438:	b8 00 00 00 00       	mov    eax,0x0
    443d:	e8 00 00 00 00       	call   4442 <ahci_device_init+0x6ac>
#endif

		/* transfer ownership (incl NMI) */
		if (h->cap2.boh) {
    4442:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4446:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    4449:	83 e0 01             	and    eax,0x1
    444c:	84 c0                	test   al,al
    444e:	74 29                	je     4479 <ahci_device_init+0x6e3>
				rv = ahci_do_bohc(ad);
    4450:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4454:	48 89 c7             	mov    rdi,rax
    4457:	e8 00 00 00 00       	call   445c <ahci_device_init+0x6c6>
    445c:	89 45 a4             	mov    DWORD PTR [rbp-0x5c],eax
				if (rv) {
    445f:	83 7d a4 00          	cmp    DWORD PTR [rbp-0x5c],0x0
    4463:	74 14                	je     4479 <ahci_device_init+0x6e3>
						kfree(ad);
    4465:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4469:	48 89 c7             	mov    rdi,rax
    446c:	e8 00 00 00 00       	call   4471 <ahci_device_init+0x6db>
						return rv;
    4471:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    4474:	e9 76 02 00 00       	jmp    46ef <ahci_device_init+0x959>
				}
		}

		/* disable every possible interrupt */
		if(pci_disable_interrupts(d))
    4479:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    4480:	48 89 c7             	mov    rdi,rax
    4483:	e8 00 00 00 00       	call   4488 <ahci_device_init+0x6f2>
    4488:	85 c0                	test   eax,eax
    448a:	74 30                	je     44bc <ahci_device_init+0x726>
				die("not possible!\n");
    448c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4493:	bf 0c 00 00 00       	mov    edi,0xc
    4498:	b8 00 00 00 00       	mov    eax,0x0
    449d:	e8 00 00 00 00       	call   44a2 <ahci_device_init+0x70c>
    44a2:	b8 00 00 00 00       	mov    eax,0x0
    44a7:	e8 00 00 00 00       	call   44ac <ahci_device_init+0x716>
    44ac:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    44b3:	e8 00 00 00 00       	call   44b8 <ahci_device_init+0x722>
    44b8:	fa                   	cli
    44b9:	f4                   	hlt
    44ba:	eb fd                	jmp    44b9 <ahci_device_init+0x723>

		/* Stop the running ports */
		for (int i = 0; i < ad->num_ports; i++)
    44bc:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0
    44c3:	eb 15                	jmp    44da <ahci_device_init+0x744>
				ahci_stop_port(ad, i);
    44c5:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    44c8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44cc:	89 d6                	mov    esi,edx
    44ce:	48 89 c7             	mov    rdi,rax
    44d1:	e8 00 00 00 00       	call   44d6 <ahci_device_init+0x740>
		for (int i = 0; i < ad->num_ports; i++)
    44d6:	83 45 d4 01          	add    DWORD PTR [rbp-0x2c],0x1
    44da:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44de:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    44e2:	0f b7 c0             	movzx  eax,ax
    44e5:	39 45 d4             	cmp    DWORD PTR [rbp-0x2c],eax
    44e8:	7c db                	jl     44c5 <ahci_device_init+0x72f>

		/* clear all interrupts and install the handler */
		ahci_clear_interrupts(ad); /* PCI disabled MSI and we're currently */
    44ea:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44ee:	48 89 c7             	mov    rdi,rax
    44f1:	e8 00 00 00 00       	call   44f6 <ahci_device_init+0x760>
		install_irq_handler(ad->dev->intr_line, ahci_irq); /* not using it */
    44f6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44fa:	48 8b 00             	mov    rax,QWORD PTR [rax]
    44fd:	0f b6 40 09          	movzx  eax,BYTE PTR [rax+0x9]
    4501:	0f b6 c0             	movzx  eax,al
    4504:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    450b:	89 c7                	mov    edi,eax
    450d:	e8 00 00 00 00       	call   4512 <ahci_device_init+0x77c>
		/* TODO: do proper assigment */

		/* assign the command lists and the FIS buffers */
		ahci_assign_buffers(ad);
    4512:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4516:	48 89 c7             	mov    rdi,rax
    4519:	e8 00 00 00 00       	call   451e <ahci_device_init+0x788>

		/* print them */
		for (int i = 0; i < ad->num_ports; i++) {
    451e:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
    4525:	e9 df 00 00 00       	jmp    4609 <ahci_device_init+0x873>
				printf("port%d: %016llx %016llx %p %p\n", i,
    452a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    452e:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    4531:	48 63 d2             	movsxd rdx,edx
    4534:	48 83 c2 22          	add    rdx,0x22
    4538:	48 8b 7c d0 08       	mov    rdi,QWORD PTR [rax+rdx*8+0x8]
    453d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4541:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    4544:	48 63 d2             	movsxd rdx,edx
    4547:	48 83 c2 02          	add    rdx,0x2
    454b:	48 8b 74 d0 08       	mov    rsi,QWORD PTR [rax+rdx*8+0x8]
						ad->ptr->port[i].pXclb64,
						ad->ptr->port[i].pXfb64,
    4550:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4554:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
				printf("port%d: %016llx %016llx %p %p\n", i,
    4558:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    455b:	48 63 d2             	movsxd rdx,edx
    455e:	48 83 c2 02          	add    rdx,0x2
    4562:	48 c1 e2 07          	shl    rdx,0x7
    4566:	48 01 d0             	add    rax,rdx
    4569:	48 83 c0 08          	add    rax,0x8
    456d:	48 8b 08             	mov    rcx,QWORD PTR [rax]
						ad->ptr->port[i].pXclb64,
    4570:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4574:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
				printf("port%d: %016llx %016llx %p %p\n", i,
    4578:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    457b:	48 63 d2             	movsxd rdx,edx
    457e:	48 83 c2 02          	add    rdx,0x2
    4582:	48 c1 e2 07          	shl    rdx,0x7
    4586:	48 01 d0             	add    rax,rdx
    4589:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    458c:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    458f:	49 89 f9             	mov    r9,rdi
    4592:	49 89 f0             	mov    r8,rsi
    4595:	89 c6                	mov    esi,eax
    4597:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    459e:	b8 00 00 00 00       	mov    eax,0x0
    45a3:	e8 00 00 00 00       	call   45a8 <ahci_device_init+0x812>
						ad->command_lists[i],
						ad->recv_fis[i]);
				printf("       %016llx %p\n", ad->identify_data[i].pm,
    45a8:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    45ac:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    45af:	48 63 d0             	movsxd rdx,eax
    45b2:	48 89 d0             	mov    rax,rdx
    45b5:	48 01 c0             	add    rax,rax
    45b8:	48 01 d0             	add    rax,rdx
    45bb:	48 c1 e0 03          	shl    rax,0x3
    45bf:	48 01 c8             	add    rax,rcx
    45c2:	48 05 20 02 00 00    	add    rax,0x220
    45c8:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    45cb:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    45cf:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    45d2:	48 63 d0             	movsxd rdx,eax
    45d5:	48 89 d0             	mov    rax,rdx
    45d8:	48 01 c0             	add    rax,rax
    45db:	48 01 d0             	add    rax,rdx
    45de:	48 c1 e0 03          	shl    rax,0x3
    45e2:	48 01 f0             	add    rax,rsi
    45e5:	48 05 28 02 00 00    	add    rax,0x228
    45eb:	48 8b 00             	mov    rax,QWORD PTR [rax]
    45ee:	48 89 ca             	mov    rdx,rcx
    45f1:	48 89 c6             	mov    rsi,rax
    45f4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    45fb:	b8 00 00 00 00       	mov    eax,0x0
    4600:	e8 00 00 00 00       	call   4605 <ahci_device_init+0x86f>
		for (int i = 0; i < ad->num_ports; i++) {
    4605:	83 45 d0 01          	add    DWORD PTR [rbp-0x30],0x1
    4609:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    460d:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    4611:	0f b7 c0             	movzx  eax,ax
    4614:	39 45 d0             	cmp    DWORD PTR [rbp-0x30],eax
    4617:	0f 8c 0d ff ff ff    	jl     452a <ahci_device_init+0x794>
						ad->identify_data[i].ptr);
		}

		/* allow the device to write to our memory */
		pci_set_master(d);
    461d:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    4624:	48 89 c7             	mov    rdi,rax
    4627:	e8 00 00 00 00       	call   462c <ahci_device_init+0x896>

		/* reenable the ports */
		for (int i = 0; i < ad->num_ports; i++)
    462c:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
    4633:	eb 15                	jmp    464a <ahci_device_init+0x8b4>
				ahci_enable_port(ad, i);
    4635:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
    4638:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    463c:	89 d6                	mov    esi,edx
    463e:	48 89 c7             	mov    rdi,rax
    4641:	e8 00 00 00 00       	call   4646 <ahci_device_init+0x8b0>
		for (int i = 0; i < ad->num_ports; i++)
    4646:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
    464a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    464e:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    4652:	0f b7 c0             	movzx  eax,ax
    4655:	39 45 cc             	cmp    DWORD PTR [rbp-0x34],eax
    4658:	7c db                	jl     4635 <ahci_device_init+0x89f>

		/* add the device to the list */
		struct ale* le = kzalloc(sizeof(*le));
    465a:	bf 20 00 00 00       	mov    edi,0x20
    465f:	e8 00 00 00 00       	call   4664 <ahci_device_init+0x8ce>
    4664:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
		le->dev = ad;
    4668:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    466c:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    4670:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
		list_add_tail(&le->devs, &ahci_dl.devs);
    4674:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    4678:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    467f:	48 89 c7             	mov    rdi,rax
    4682:	e8 97 ba ff ff       	call   11e <list_add_tail>

		/* allocate the pool */
		ad->ctbl_pool = ahci_allocate_command_table_pool(
				32, 8, h->cap.is_64bit);
    4687:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    468b:	8b 00                	mov    eax,DWORD PTR [rax]
    468d:	c1 e8 1f             	shr    eax,0x1f
		ad->ctbl_pool = ahci_allocate_command_table_pool(
    4690:	0f b6 c0             	movzx  eax,al
    4693:	89 c2                	mov    edx,eax
    4695:	be 08 00 00 00       	mov    esi,0x8
    469a:	bf 20 00 00 00       	mov    edi,0x20
    469f:	e8 00 00 00 00       	call   46a4 <ahci_device_init+0x90e>
    46a4:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    46a8:	48 89 82 18 05 00 00 	mov    QWORD PTR [rdx+0x518],rax

		/* launch the worker */
		task_spawn(ahci_worker, ad, PRIORITY_ELEVATED);
    46af:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    46b3:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    46ba:	ba 01 00 00 00       	mov    edx,0x1
    46bf:	48 89 c6             	mov    rsi,rax
    46c2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    46c9:	e8 00 00 00 00       	call   46ce <ahci_device_init+0x938>

		/* reenable interrupts */
		/* The port_enable function already set the per-port values */
		h->ctrl.ie = 1;
    46ce:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    46d2:	8b 42 04             	mov    eax,DWORD PTR [rdx+0x4]
    46d5:	83 c8 02             	or     eax,0x2
    46d8:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
		pci_enable_interrupts(d);
    46db:	48 8b 85 08 ff ff ff 	mov    rax,QWORD PTR [rbp-0xf8]
    46e2:	48 89 c7             	mov    rdi,rax
    46e5:	e8 00 00 00 00       	call   46ea <ahci_device_init+0x954>

		return 0;
    46ea:	b8 00 00 00 00       	mov    eax,0x0
}
    46ef:	48 8d 65 e8          	lea    rsp,[rbp-0x18]
    46f3:	5b                   	pop    rbx
    46f4:	41 5c                	pop    r12
    46f6:	41 5d                	pop    r13
    46f8:	5d                   	pop    rbp
    46f9:	c3                   	ret

00000000000046fa <module_init>:

int MODENTRY module_init()
{
    46fa:	55                   	push   rbp
    46fb:	48 89 e5             	mov    rbp,rsp
    46fe:	48 83 ec 20          	sub    rsp,0x20
		printf("AHCI initialization...\n");
    4702:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4709:	b8 00 00 00 00       	mov    eax,0x0
    470e:	e8 00 00 00 00       	call   4713 <module_init+0x19>
		struct pci_device* dev; int ct = 0, nc = 0, nf = 0;
    4713:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    471a:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    4721:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    4728:	e9 96 00 00 00       	jmp    47c3 <module_init+0xc9>
				int rv;
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
						dev->addr.device_no, dev->addr.func_no);
    472d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4731:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    4735:	83 e0 07             	and    eax,0x7
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    4738:	0f b6 c8             	movzx  ecx,al
						dev->addr.device_no, dev->addr.func_no);
    473b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    473f:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    4743:	c0 e8 03             	shr    al,0x3
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    4746:	0f b6 d0             	movzx  edx,al
    4749:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    474d:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
    4751:	0f b6 c0             	movzx  eax,al
    4754:	89 c6                	mov    esi,eax
    4756:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    475d:	b8 00 00 00 00       	mov    eax,0x0
    4762:	e8 00 00 00 00       	call   4767 <module_init+0x6d>
				printf("Attempting initialization...\n");
    4767:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    476e:	b8 00 00 00 00       	mov    eax,0x0
    4773:	e8 00 00 00 00       	call   4778 <module_init+0x7e>
				rv = ahci_device_init(dev);
    4778:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    477c:	48 89 c7             	mov    rdi,rax
    477f:	e8 00 00 00 00       	call   4784 <module_init+0x8a>
    4784:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				if (rv) {
    4787:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
    478b:	74 1c                	je     47a9 <module_init+0xaf>
						cprintf(KFMT_ERROR, "Initialization of this device failed.\n");
    478d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4794:	bf 0c 00 00 00       	mov    edi,0xc
    4799:	b8 00 00 00 00       	mov    eax,0x0
    479e:	e8 00 00 00 00       	call   47a3 <module_init+0xa9>
						nf++;
    47a3:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    47a7:	eb 1a                	jmp    47c3 <module_init+0xc9>
				} else {
						cprintf(KFMT_OK, "Initialization of AHCI HBA succeeded.\n");
    47a9:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    47b0:	bf 0a 00 00 00       	mov    edi,0xa
    47b5:	b8 00 00 00 00       	mov    eax,0x0
    47ba:	e8 00 00 00 00       	call   47bf <module_init+0xc5>
						nc++;
    47bf:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    47c3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    47c6:	8d 50 01             	lea    edx,[rax+0x1]
    47c9:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    47cc:	89 c1                	mov    ecx,eax
    47ce:	ba 01 00 00 00       	mov    edx,0x1
    47d3:	be 06 00 00 00       	mov    esi,0x6
    47d8:	bf 01 00 00 00       	mov    edi,0x1
    47dd:	e8 00 00 00 00       	call   47e2 <module_init+0xe8>
    47e2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    47e6:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    47eb:	0f 85 3c ff ff ff    	jne    472d <module_init+0x33>
				}
		}
		/* Summary */
		cprintf(nf ? KFMT_WARN : KFMT_OK, "Initialized %d AHCI Host Bus Adapters. (%d failed)\n", nc, nf);
    47f1:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    47f5:	74 07                	je     47fe <module_init+0x104>
    47f7:	bf 0e 00 00 00       	mov    edi,0xe
    47fc:	eb 05                	jmp    4803 <module_init+0x109>
    47fe:	bf 0a 00 00 00       	mov    edi,0xa
    4803:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    4806:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    4809:	89 d1                	mov    ecx,edx
    480b:	89 c2                	mov    edx,eax
    480d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4814:	b8 00 00 00 00       	mov    eax,0x0
    4819:	e8 00 00 00 00       	call   481e <module_init+0x124>
		return 0;
    481e:	b8 00 00 00 00       	mov    eax,0x0
}
    4823:	c9                   	leave
    4824:	c3                   	ret

0000000000004825 <module_cleanup>:

void MODENTRY module_cleanup()
{
    4825:	55                   	push   rbp
    4826:	48 89 e5             	mov    rbp,rsp
}
    4829:	90                   	nop
    482a:	5d                   	pop    rbp
    482b:	c3                   	ret
