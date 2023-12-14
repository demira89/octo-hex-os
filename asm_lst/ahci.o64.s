
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
     a8e:	48 83 ec 48          	sub    rsp,0x48
     a92:	89 7d bc             	mov    DWORD PTR [rbp-0x44],edi
     a95:	89 75 b8             	mov    DWORD PTR [rbp-0x48],esi
     a98:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
     a9c:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
     aa0:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
     aa4:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
		const char** rv = (const char**)(&limit + 1);
     aa8:	48 8d 45 b8          	lea    rax,[rbp-0x48]
     aac:	48 83 c0 04          	add    rax,0x4
     ab0:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		return rv[min(idx, limit)];
     ab4:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
     ab7:	39 45 bc             	cmp    DWORD PTR [rbp-0x44],eax
     aba:	7d 0b                	jge    ac7 <capstr+0x3d>
     abc:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     abf:	48 98                	cdqe
     ac1:	48 c1 e0 03          	shl    rax,0x3
     ac5:	eb 09                	jmp    ad0 <capstr+0x46>
     ac7:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
     aca:	48 98                	cdqe
     acc:	48 c1 e0 03          	shl    rax,0x3
     ad0:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
     ad4:	48 01 d0             	add    rax,rdx
     ad7:	48 8b 00             	mov    rax,QWORD PTR [rax]
}
     ada:	c9                   	leave
     adb:	c3                   	ret

0000000000000adc <ahci_allocate_context>:
{
     adc:	55                   	push   rbp
     add:	48 89 e5             	mov    rbp,rsp
     ae0:	48 83 ec 30          	sub    rsp,0x30
     ae4:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		rv = list_cut_first_entry(&ad->ctxs, struct cmd_ctx, lst);
     ae8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     aec:	48 05 28 0b 00 00    	add    rax,0xb28
     af2:	48 89 c7             	mov    rdi,rax
     af5:	e8 b0 f6 ff ff       	call   1aa <list_empty>
     afa:	85 c0                	test   eax,eax
     afc:	75 6d                	jne    b6b <ahci_allocate_context+0x8f>
     afe:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b02:	48 05 38 0b 00 00    	add    rax,0xb38
     b08:	48 89 c7             	mov    rdi,rax
     b0b:	e8 00 00 00 00       	call   b10 <ahci_allocate_context+0x34>
     b10:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b14:	48 05 28 0b 00 00    	add    rax,0xb28
     b1a:	48 89 c7             	mov    rdi,rax
     b1d:	e8 88 f6 ff ff       	call   1aa <list_empty>
     b22:	85 c0                	test   eax,eax
     b24:	75 15                	jne    b3b <ahci_allocate_context+0x5f>
     b26:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b2a:	48 8b 80 30 0b 00 00 	mov    rax,QWORD PTR [rax+0xb30]
     b31:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     b35:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     b39:	eb 05                	jmp    b40 <ahci_allocate_context+0x64>
     b3b:	b8 00 00 00 00       	mov    eax,0x0
     b40:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     b44:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b49:	74 0c                	je     b57 <ahci_allocate_context+0x7b>
     b4b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b4f:	48 89 c7             	mov    rdi,rax
     b52:	e8 2e f5 ff ff       	call   85 <__list_del>
     b57:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b5b:	48 05 38 0b 00 00    	add    rax,0xb38
     b61:	48 89 c7             	mov    rdi,rax
     b64:	e8 00 00 00 00       	call   b69 <ahci_allocate_context+0x8d>
     b69:	eb 08                	jmp    b73 <ahci_allocate_context+0x97>
     b6b:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     b73:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b77:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!rv)
     b7b:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     b80:	75 0e                	jne    b90 <ahci_allocate_context+0xb4>
				rv = kzalloc(sizeof(*rv));
     b82:	bf 88 00 00 00       	mov    edi,0x88
     b87:	e8 00 00 00 00       	call   b8c <ahci_allocate_context+0xb0>
     b8c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		return rv;
     b90:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
     b94:	c9                   	leave
     b95:	c3                   	ret

0000000000000b96 <ahci_destroy_context>:
{
     b96:	55                   	push   rbp
     b97:	48 89 e5             	mov    rbp,rsp
     b9a:	48 83 ec 10          	sub    rsp,0x10
     b9e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     ba2:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		bzero(cc, sizeof(*cc));
     ba6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     baa:	be 88 00 00 00       	mov    esi,0x88
     baf:	48 89 c7             	mov    rdi,rax
     bb2:	e8 00 00 00 00       	call   bb7 <ahci_destroy_context+0x21>
		list_add_tail(&cc->lst, &ad->ctxs);
     bb7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bbb:	48 8d 90 28 0b 00 00 	lea    rdx,[rax+0xb28]
     bc2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bc6:	48 89 d6             	mov    rsi,rdx
     bc9:	48 89 c7             	mov    rdi,rax
     bcc:	e8 4d f5 ff ff       	call   11e <list_add_tail>
}
     bd1:	90                   	nop
     bd2:	c9                   	leave
     bd3:	c3                   	ret

0000000000000bd4 <ahci_handle_command_error>:
{
     bd4:	55                   	push   rbp
     bd5:	48 89 e5             	mov    rbp,rsp
     bd8:	48 83 ec 20          	sub    rsp,0x20
     bdc:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     be0:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     be4:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
		if (cc->c == disk_cmd_identify) {
     be7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     beb:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     bee:	85 c0                	test   eax,eax
     bf0:	75 07                	jne    bf9 <ahci_handle_command_error+0x25>
				return -1;
     bf2:	b8 ff ff ff ff       	mov    eax,0xffffffff
     bf7:	eb 3d                	jmp    c36 <ahci_handle_command_error+0x62>
				if (cc->status)
     bf9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bfd:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     c01:	48 85 c0             	test   rax,rax
     c04:	74 0e                	je     c14 <ahci_handle_command_error+0x40>
						cc->status->state = cmd_state_abort;
     c06:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c0a:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     c0e:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
				if (cc->wq_wake)
     c14:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c18:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
     c1c:	48 85 c0             	test   rax,rax
     c1f:	74 10                	je     c31 <ahci_handle_command_error+0x5d>
						wake_up_external_event(cc->wq_wake);
     c21:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c25:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
     c29:	48 89 c7             	mov    rdi,rax
     c2c:	e8 00 00 00 00       	call   c31 <ahci_handle_command_error+0x5d>
				return -1;
     c31:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     c36:	c9                   	leave
     c37:	c3                   	ret

0000000000000c38 <ahci_port_handle_tfes_regular>:
{
     c38:	55                   	push   rbp
     c39:	48 89 e5             	mov    rbp,rsp
     c3c:	48 83 c4 80          	add    rsp,0xffffffffffffff80
     c40:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     c44:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
     c48:	89 55 ac             	mov    DWORD PTR [rbp-0x54],edx
		uint32_t ci = p->pXci; /* all pending commands */
     c4b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     c4f:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
     c52:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		uint16_t slt = p->cmd.ccs; /* the offending one */
     c55:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     c59:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     c5c:	c1 e8 08             	shr    eax,0x8
     c5f:	83 e0 1f             	and    eax,0x1f
     c62:	0f b6 c0             	movzx  eax,al
     c65:	66 89 45 f2          	mov    WORD PTR [rbp-0xe],ax
		p->cmd.st = 0;
     c69:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     c6d:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
     c70:	83 e0 fe             	and    eax,0xfffffffe
     c73:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		abiprintf("slot which caused task file error: %u\n", slt);
     c76:	0f b7 45 f2          	movzx  eax,WORD PTR [rbp-0xe]
     c7a:	89 c6                	mov    esi,eax
     c7c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c83:	b8 00 00 00 00       	mov    eax,0x0
     c88:	e8 00 00 00 00       	call   c8d <ahci_port_handle_tfes_regular+0x55>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     c8d:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
     c91:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     c94:	48 63 d0             	movsxd rdx,eax
     c97:	48 89 d0             	mov    rax,rdx
     c9a:	48 01 c0             	add    rax,rax
     c9d:	48 01 d0             	add    rax,rdx
     ca0:	48 c1 e0 03          	shl    rax,0x3
     ca4:	48 01 c8             	add    rax,rcx
     ca7:	48 05 28 08 00 00    	add    rax,0x828
     cad:	48 8b 00             	mov    rax,QWORD PTR [rax]
     cb0:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     cb4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     cb8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     cbc:	e9 a1 01 00 00       	jmp    e62 <ahci_port_handle_tfes_regular+0x22a>
				struct cmd_ctx* cc = cc2; /* we're clearing the list */
     cc1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     cc5:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				list_del_and_prepare_continue(cc2, &ad->proc_cmds[pt], lst);
     cc9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ccd:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
     cd1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     cd5:	48 8b 00             	mov    rax,QWORD PTR [rax]
     cd8:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
     cdc:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     ce0:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     ce4:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     ce7:	48 63 d0             	movsxd rdx,eax
     cea:	48 89 d0             	mov    rax,rdx
     ced:	48 01 c0             	add    rax,rax
     cf0:	48 01 d0             	add    rax,rdx
     cf3:	48 c1 e0 03          	shl    rax,0x3
     cf7:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
     cfe:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d02:	48 01 c2             	add    rdx,rax
     d05:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     d09:	48 89 d6             	mov    rsi,rdx
     d0c:	48 89 c7             	mov    rdi,rax
     d0f:	e8 57 f4 ff ff       	call   16b <list_del>
				abiprintf("inside slt: %u\n", cc->slot);
     d14:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d18:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     d1c:	0f b7 c0             	movzx  eax,ax
     d1f:	89 c6                	mov    esi,eax
     d21:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     d28:	b8 00 00 00 00       	mov    eax,0x0
     d2d:	e8 00 00 00 00       	call   d32 <ahci_port_handle_tfes_regular+0xfa>
				if (cc->slot == slt) {
     d32:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d36:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     d3a:	66 39 45 f2          	cmp    WORD PTR [rbp-0xe],ax
     d3e:	0f 85 a8 00 00 00    	jne    dec <ahci_port_handle_tfes_regular+0x1b4>
								slt, pt, p->tfd.err, p->tfd.sts);
     d44:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d48:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     d4b:	0f b6 f0             	movzx  esi,al
								slt, pt, p->tfd.err, p->tfd.sts);
     d4e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d52:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
     d55:	0f b6 c4             	movzx  eax,ah
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     d58:	0f b6 c8             	movzx  ecx,al
     d5b:	0f b7 45 f2          	movzx  eax,WORD PTR [rbp-0xe]
     d5f:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
     d62:	41 89 f0             	mov    r8d,esi
     d65:	89 c6                	mov    esi,eax
     d67:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     d6e:	b8 00 00 00 00       	mov    eax,0x0
     d73:	e8 00 00 00 00       	call   d78 <ahci_port_handle_tfes_regular+0x140>
						if (-1 == ahci_handle_command_error(ad, cc, p->pXtfd)) {
     d78:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d7c:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
     d7f:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     d83:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d87:	48 89 ce             	mov    rsi,rcx
     d8a:	48 89 c7             	mov    rdi,rax
     d8d:	e8 00 00 00 00       	call   d92 <ahci_port_handle_tfes_regular+0x15a>
     d92:	83 f8 ff             	cmp    eax,0xffffffff
     d95:	75 2f                	jne    dc6 <ahci_port_handle_tfes_regular+0x18e>
								ahci_release_cmdtbl(ad, cc->entry);
     d97:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d9b:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
     d9f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     da3:	48 89 d6             	mov    rsi,rdx
     da6:	48 89 c7             	mov    rdi,rax
     da9:	e8 00 00 00 00       	call   dae <ahci_port_handle_tfes_regular+0x176>
								ahci_destroy_context(ad, cc);
     dae:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     db2:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     db6:	48 89 d6             	mov    rsi,rdx
     db9:	48 89 c7             	mov    rdi,rax
     dbc:	e8 00 00 00 00       	call   dc1 <ahci_port_handle_tfes_regular+0x189>
     dc1:	e9 88 00 00 00       	jmp    e4e <ahci_port_handle_tfes_regular+0x216>
								abiprintf("command reissued.\n");
     dc6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     dcd:	b8 00 00 00 00       	mov    eax,0x0
     dd2:	e8 00 00 00 00       	call   dd7 <ahci_port_handle_tfes_regular+0x19f>
								ahci_reissue_command(ad, cc);
     dd7:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     ddb:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ddf:	48 89 d6             	mov    rsi,rdx
     de2:	48 89 c7             	mov    rdi,rax
     de5:	e8 00 00 00 00       	call   dea <ahci_port_handle_tfes_regular+0x1b2>
     dea:	eb 62                	jmp    e4e <ahci_port_handle_tfes_regular+0x216>
						if (ci & (1 << cc->slot)) {
     dec:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     df0:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     df4:	0f b7 c0             	movzx  eax,ax
     df7:	ba 01 00 00 00       	mov    edx,0x1
     dfc:	89 c1                	mov    ecx,eax
     dfe:	d3 e2                	shl    edx,cl
     e00:	89 d0                	mov    eax,edx
     e02:	23 45 f4             	and    eax,DWORD PTR [rbp-0xc]
     e05:	85 c0                	test   eax,eax
     e07:	74 15                	je     e1e <ahci_port_handle_tfes_regular+0x1e6>
								ahci_reissue_command(ad, cc);
     e09:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     e0d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e11:	48 89 d6             	mov    rsi,rdx
     e14:	48 89 c7             	mov    rdi,rax
     e17:	e8 00 00 00 00       	call   e1c <ahci_port_handle_tfes_regular+0x1e4>
     e1c:	eb 30                	jmp    e4e <ahci_port_handle_tfes_regular+0x216>
								die("not implemented\n");
     e1e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     e25:	bf 0c 00 00 00       	mov    edi,0xc
     e2a:	b8 00 00 00 00       	mov    eax,0x0
     e2f:	e8 00 00 00 00       	call   e34 <ahci_port_handle_tfes_regular+0x1fc>
     e34:	b8 00 00 00 00       	mov    eax,0x0
     e39:	e8 00 00 00 00       	call   e3e <ahci_port_handle_tfes_regular+0x206>
     e3e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e45:	e8 00 00 00 00       	call   e4a <ahci_port_handle_tfes_regular+0x212>
     e4a:	fa                   	cli
     e4b:	f4                   	hlt
     e4c:	eb fd                	jmp    e4b <ahci_port_handle_tfes_regular+0x213>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     e4e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e52:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e56:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
     e5a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     e5e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     e62:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     e66:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     e69:	48 63 d0             	movsxd rdx,eax
     e6c:	48 89 d0             	mov    rax,rdx
     e6f:	48 01 c0             	add    rax,rax
     e72:	48 01 d0             	add    rax,rdx
     e75:	48 c1 e0 03          	shl    rax,0x3
     e79:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
     e80:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e84:	48 01 d0             	add    rax,rdx
     e87:	48 39 c1             	cmp    rcx,rax
     e8a:	0f 85 31 fe ff ff    	jne    cc1 <ahci_port_handle_tfes_regular+0x89>
		ahci_issue_command(ad, pt, 0 /* TODO: handle pmport */, host_cmd_reset,
     e90:	8b 75 ac             	mov    esi,DWORD PTR [rbp-0x54]
     e93:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e97:	48 c7 44 24 10 00 00 00 00 	mov    QWORD PTR [rsp+0x10],0x0
     ea0:	48 c7 44 24 08 00 00 00 00 	mov    QWORD PTR [rsp+0x8],0x0
     ea9:	48 c7 04 24 00 00 00 00 	mov    QWORD PTR [rsp],0x0
     eb1:	41 b9 00 00 00 00    	mov    r9d,0x0
     eb7:	41 b8 00 00 00 00    	mov    r8d,0x0
     ebd:	b9 82 00 00 00       	mov    ecx,0x82
     ec2:	ba 00 00 00 00       	mov    edx,0x0
     ec7:	48 89 c7             	mov    rdi,rax
     eca:	e8 00 00 00 00       	call   ecf <ahci_port_handle_tfes_regular+0x297>
}
     ecf:	90                   	nop
     ed0:	c9                   	leave
     ed1:	c3                   	ret

0000000000000ed2 <ahci_port_handle_tfes_ncq>:
{
     ed2:	55                   	push   rbp
     ed3:	48 89 e5             	mov    rbp,rsp
     ed6:	48 83 ec 20          	sub    rsp,0x20
     eda:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     ede:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     ee2:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
		die("not implemented!\n");
     ee5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     eec:	bf 0c 00 00 00       	mov    edi,0xc
     ef1:	b8 00 00 00 00       	mov    eax,0x0
     ef6:	e8 00 00 00 00       	call   efb <ahci_port_handle_tfes_ncq+0x29>
     efb:	b8 00 00 00 00       	mov    eax,0x0
     f00:	e8 00 00 00 00       	call   f05 <ahci_port_handle_tfes_ncq+0x33>
     f05:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f0c:	e8 00 00 00 00       	call   f11 <ahci_port_handle_tfes_ncq+0x3f>
     f11:	fa                   	cli
     f12:	f4                   	hlt
     f13:	eb fd                	jmp    f12 <ahci_port_handle_tfes_ncq+0x40>

0000000000000f15 <ahci_port_handle_pcs_cominit>:
{
     f15:	55                   	push   rbp
     f16:	48 89 e5             	mov    rbp,rsp
     f19:	48 83 ec 20          	sub    rsp,0x20
     f1d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     f21:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     f25:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
		die("not implemented!\n");
     f28:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f2f:	bf 0c 00 00 00       	mov    edi,0xc
     f34:	b8 00 00 00 00       	mov    eax,0x0
     f39:	e8 00 00 00 00       	call   f3e <ahci_port_handle_pcs_cominit+0x29>
     f3e:	b8 00 00 00 00       	mov    eax,0x0
     f43:	e8 00 00 00 00       	call   f48 <ahci_port_handle_pcs_cominit+0x33>
     f48:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f4f:	e8 00 00 00 00       	call   f54 <ahci_port_handle_pcs_cominit+0x3f>
     f54:	fa                   	cli
     f55:	f4                   	hlt
     f56:	eb fd                	jmp    f55 <ahci_port_handle_pcs_cominit+0x40>

0000000000000f58 <ahci_port_check_finished_commands>:
{
     f58:	55                   	push   rbp
     f59:	48 89 e5             	mov    rbp,rsp
     f5c:	48 83 ec 60          	sub    rsp,0x60
     f60:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     f64:	89 75 a4             	mov    DWORD PTR [rbp-0x5c],esi
     f67:	89 55 a0             	mov    DWORD PTR [rbp-0x60],edx
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
     f6a:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
     f6e:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f71:	48 63 d0             	movsxd rdx,eax
     f74:	48 89 d0             	mov    rax,rdx
     f77:	48 01 c0             	add    rax,rax
     f7a:	48 01 d0             	add    rax,rdx
     f7d:	48 c1 e0 03          	shl    rax,0x3
     f81:	48 01 c8             	add    rax,rcx
     f84:	48 05 28 08 00 00    	add    rax,0x828
     f8a:	48 8b 00             	mov    rax,QWORD PTR [rax]
     f8d:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     f91:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     f95:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     f99:	e9 f7 02 00 00       	jmp    1295 <ahci_port_check_finished_commands+0x33d>
				if (!(ci & (1 << cc->slot))) { /* slot was cleared */
     f9e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fa2:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     fa6:	0f b7 c0             	movzx  eax,ax
     fa9:	ba 01 00 00 00       	mov    edx,0x1
     fae:	89 c1                	mov    ecx,eax
     fb0:	d3 e2                	shl    edx,cl
     fb2:	89 d0                	mov    eax,edx
     fb4:	23 45 a0             	and    eax,DWORD PTR [rbp-0x60]
     fb7:	85 c0                	test   eax,eax
     fb9:	0f 85 a4 02 00 00    	jne    1263 <ahci_port_check_finished_commands+0x30b>
						uint16_t prdtl; uint32_t bc = 0, bc0 = 0;
     fbf:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
     fc6:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
						if ((prdtl = d->command_lists[pt]->chdrs[cc->slot].prdtl)) {
     fcd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     fd1:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
     fd4:	48 63 d2             	movsxd rdx,edx
     fd7:	48 83 c2 02          	add    rdx,0x2
     fdb:	48 8b 54 d0 08       	mov    rdx,QWORD PTR [rax+rdx*8+0x8]
     fe0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fe4:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
     fe8:	0f b7 c0             	movzx  eax,ax
     feb:	48 98                	cdqe
     fed:	48 c1 e0 05          	shl    rax,0x5
     ff1:	48 01 d0             	add    rax,rdx
     ff4:	48 83 c0 02          	add    rax,0x2
     ff8:	0f b7 00             	movzx  eax,WORD PTR [rax]
     ffb:	66 89 45 f6          	mov    WORD PTR [rbp-0xa],ax
     fff:	66 83 7d f6 00       	cmp    WORD PTR [rbp-0xa],0x0
    1004:	74 65                	je     106b <ahci_port_check_finished_commands+0x113>
								bc0 = d->command_lists[pt]->chdrs[cc->slot].prdbc;
    1006:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    100a:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
    100d:	48 63 d2             	movsxd rdx,edx
    1010:	48 83 c2 02          	add    rdx,0x2
    1014:	48 8b 54 d0 08       	mov    rdx,QWORD PTR [rax+rdx*8+0x8]
    1019:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    101d:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
    1021:	0f b7 c0             	movzx  eax,ax
    1024:	48 98                	cdqe
    1026:	48 c1 e0 05          	shl    rax,0x5
    102a:	48 01 d0             	add    rax,rdx
    102d:	48 83 c0 04          	add    rax,0x4
    1031:	8b 00                	mov    eax,DWORD PTR [rax]
    1033:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								struct ahci_prdt* pr = cc->entry->ptr->prdts;
    1036:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    103a:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    103e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1042:	48 83 e8 80          	sub    rax,0xffffffffffffff80
    1046:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
								while (prdtl--)
    104a:	eb 0f                	jmp    105b <ahci_port_check_finished_commands+0x103>
										bc += pr->dbc;
    104c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1050:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    1053:	25 ff ff 3f 00       	and    eax,0x3fffff
    1058:	01 45 f0             	add    DWORD PTR [rbp-0x10],eax
								while (prdtl--)
    105b:	0f b7 45 f6          	movzx  eax,WORD PTR [rbp-0xa]
    105f:	8d 50 ff             	lea    edx,[rax-0x1]
    1062:	66 89 55 f6          	mov    WORD PTR [rbp-0xa],dx
    1066:	66 85 c0             	test   ax,ax
    1069:	75 e1                	jne    104c <ahci_port_check_finished_commands+0xf4>
						if (!cc->cont_ctx && !cc->bts_left) {
    106b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    106f:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
    1073:	48 85 c0             	test   rax,rax
    1076:	0f 85 34 01 00 00    	jne    11b0 <ahci_port_check_finished_commands+0x258>
    107c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1080:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    1084:	48 85 c0             	test   rax,rax
    1087:	0f 85 23 01 00 00    	jne    11b0 <ahci_port_check_finished_commands+0x258>
								if (cc->c == disk_cmd_identify) {
    108d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1091:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1094:	85 c0                	test   eax,eax
    1096:	0f 85 87 00 00 00    	jne    1123 <ahci_port_check_finished_commands+0x1cb>
										struct cmd_ctx* cc2 = cc;
    109c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10a0:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
										abiprintf("identify host command issued\n");
    10a4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    10ab:	b8 00 00 00 00       	mov    eax,0x0
    10b0:	e8 00 00 00 00       	call   10b5 <ahci_port_check_finished_commands+0x15d>
										cc->c = host_cmd_process_identify;
    10b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10b9:	c7 40 18 80 00 00 00 	mov    DWORD PTR [rax+0x18],0x80
										list_del_and_prepare_continue(cc, &d->proc_cmds[pt], lst);
    10c0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10c4:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    10c8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10cc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    10cf:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    10d3:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    10d7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    10db:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    10de:	48 63 d0             	movsxd rdx,eax
    10e1:	48 89 d0             	mov    rax,rdx
    10e4:	48 01 c0             	add    rax,rax
    10e7:	48 01 d0             	add    rax,rdx
    10ea:	48 c1 e0 03          	shl    rax,0x3
    10ee:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    10f5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    10f9:	48 01 c2             	add    rdx,rax
    10fc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1100:	48 89 d6             	mov    rsi,rdx
    1103:	48 89 c7             	mov    rdi,rax
    1106:	e8 60 f0 ff ff       	call   16b <list_del>
										ahci_reissue_command(d, cc2); /* worker has to work */
    110b:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    110f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1113:	48 89 d6             	mov    rsi,rdx
    1116:	48 89 c7             	mov    rdi,rax
    1119:	e8 00 00 00 00       	call   111e <ahci_port_check_finished_commands+0x1c6>
										continue;
    111e:	e9 5e 01 00 00       	jmp    1281 <ahci_port_check_finished_commands+0x329>
										if (cc->status) {
    1123:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1127:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    112b:	48 85 c0             	test   rax,rax
    112e:	74 33                	je     1163 <ahci_port_check_finished_commands+0x20b>
												cc->status->state = cmd_state_completed;
    1130:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1134:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    1138:	c7 00 03 00 00 00    	mov    DWORD PTR [rax],0x3
												cc->status->bts_cur = bc;
    113e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1142:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    1146:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    1149:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
												cc->status->bts_left = bc0 - bc;
    114d:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1150:	2b 45 f0             	sub    eax,DWORD PTR [rbp-0x10]
    1153:	89 c2                	mov    edx,eax
    1155:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1159:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    115d:	89 d2                	mov    edx,edx
    115f:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										if (cc->wq_wake)
    1163:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1167:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    116b:	48 85 c0             	test   rax,rax
    116e:	74 10                	je     1180 <ahci_port_check_finished_commands+0x228>
												wake_up_external_event(cc->wq_wake);
    1170:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1174:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    1178:	48 89 c7             	mov    rdi,rax
    117b:	e8 00 00 00 00       	call   1180 <ahci_port_check_finished_commands+0x228>
								die("command w/o info finished.\n");
    1180:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1187:	bf 0c 00 00 00       	mov    edi,0xc
    118c:	b8 00 00 00 00       	mov    eax,0x0
    1191:	e8 00 00 00 00       	call   1196 <ahci_port_check_finished_commands+0x23e>
    1196:	b8 00 00 00 00       	mov    eax,0x0
    119b:	e8 00 00 00 00       	call   11a0 <ahci_port_check_finished_commands+0x248>
    11a0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    11a7:	e8 00 00 00 00       	call   11ac <ahci_port_check_finished_commands+0x254>
    11ac:	fa                   	cli
    11ad:	f4                   	hlt
    11ae:	eb fd                	jmp    11ad <ahci_port_check_finished_commands+0x255>
								if (bc0 == bc) {
    11b0:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    11b3:	3b 45 f0             	cmp    eax,DWORD PTR [rbp-0x10]
    11b6:	75 4b                	jne    1203 <ahci_port_check_finished_commands+0x2ab>
										if (cc->status) {
    11b8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11bc:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    11c0:	48 85 c0             	test   rax,rax
    11c3:	74 6e                	je     1233 <ahci_port_check_finished_commands+0x2db>
												cc->status->bts_cur += bc;
    11c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11c9:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    11cd:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    11d1:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    11d4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11d8:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    11dc:	48 01 ca             	add    rdx,rcx
    11df:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
												cc->status->bts_left -= bc;
    11e3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11e7:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    11eb:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
    11ef:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    11f2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11f6:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    11fa:	48 29 d1             	sub    rcx,rdx
    11fd:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
    1201:	eb 30                	jmp    1233 <ahci_port_check_finished_commands+0x2db>
										die("incomplete transfer\n"); /* possible by design of intr? */
    1203:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    120a:	bf 0c 00 00 00       	mov    edi,0xc
    120f:	b8 00 00 00 00       	mov    eax,0x0
    1214:	e8 00 00 00 00       	call   1219 <ahci_port_check_finished_commands+0x2c1>
    1219:	b8 00 00 00 00       	mov    eax,0x0
    121e:	e8 00 00 00 00       	call   1223 <ahci_port_check_finished_commands+0x2cb>
    1223:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    122a:	e8 00 00 00 00       	call   122f <ahci_port_check_finished_commands+0x2d7>
    122f:	fa                   	cli
    1230:	f4                   	hlt
    1231:	eb fd                	jmp    1230 <ahci_port_check_finished_commands+0x2d8>
								die("not implemented yet!\n");
    1233:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    123a:	bf 0c 00 00 00       	mov    edi,0xc
    123f:	b8 00 00 00 00       	mov    eax,0x0
    1244:	e8 00 00 00 00       	call   1249 <ahci_port_check_finished_commands+0x2f1>
    1249:	b8 00 00 00 00       	mov    eax,0x0
    124e:	e8 00 00 00 00       	call   1253 <ahci_port_check_finished_commands+0x2fb>
    1253:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    125a:	e8 00 00 00 00       	call   125f <ahci_port_check_finished_commands+0x307>
    125f:	fa                   	cli
    1260:	f4                   	hlt
    1261:	eb fd                	jmp    1260 <ahci_port_check_finished_commands+0x308>
						iprintf("slot %u still active\n", cc->slot);
    1263:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1267:	0f b7 40 52          	movzx  eax,WORD PTR [rax+0x52]
    126b:	0f b7 c0             	movzx  eax,ax
    126e:	89 c6                	mov    esi,eax
    1270:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1277:	b8 00 00 00 00       	mov    eax,0x0
    127c:	e8 00 00 00 00       	call   1281 <ahci_port_check_finished_commands+0x329>
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
    1281:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1285:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1289:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    128d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1291:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1295:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1299:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    129c:	48 63 d0             	movsxd rdx,eax
    129f:	48 89 d0             	mov    rax,rdx
    12a2:	48 01 c0             	add    rax,rax
    12a5:	48 01 d0             	add    rax,rdx
    12a8:	48 c1 e0 03          	shl    rax,0x3
    12ac:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    12b3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    12b7:	48 01 d0             	add    rax,rdx
    12ba:	48 39 c1             	cmp    rcx,rax
    12bd:	0f 85 db fc ff ff    	jne    f9e <ahci_port_check_finished_commands+0x46>
}
    12c3:	90                   	nop
    12c4:	90                   	nop
    12c5:	c9                   	leave
    12c6:	c3                   	ret

00000000000012c7 <ahci_port_intr>:
{
    12c7:	55                   	push   rbp
    12c8:	48 89 e5             	mov    rbp,rsp
    12cb:	48 83 ec 30          	sub    rsp,0x30
    12cf:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    12d3:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		struct ahci_port* p = &d->ptr->port[pt];
    12d6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12da:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    12de:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    12e1:	48 63 d2             	movsxd rdx,edx
    12e4:	48 83 c2 02          	add    rdx,0x2
    12e8:	48 c1 e2 07          	shl    rdx,0x7
    12ec:	48 01 d0             	add    rax,rdx
    12ef:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		uint32_t is = p->pXis, cm = 0; /* unaffected by mask */
    12f3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    12f7:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    12fa:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    12fd:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		uint32_t ci = p->pXci; /* check if still set */
    1304:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1308:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    130b:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		if (is & (1 << 5)) { /* DPS: data processed (PRD&I), commands must use C bit */
    130e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1311:	83 e0 20             	and    eax,0x20
    1314:	85 c0                	test   eax,eax
    1316:	74 18                	je     1330 <ahci_port_intr+0x69>
				ahci_port_check_finished_commands(d, pt, ci);
    1318:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    131b:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
    131e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1322:	89 ce                	mov    esi,ecx
    1324:	48 89 c7             	mov    rdi,rax
    1327:	e8 00 00 00 00       	call   132c <ahci_port_intr+0x65>
				cm |= (1 << 5);
    132c:	83 4d fc 20          	or     DWORD PTR [rbp-0x4],0x20
		if (is & (1 << 0)) { /* D2H FIS (more reliable) */
    1330:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1333:	83 e0 01             	and    eax,0x1
    1336:	85 c0                	test   eax,eax
    1338:	74 18                	je     1352 <ahci_port_intr+0x8b>
				ahci_port_check_finished_commands(d, pt, ci);
    133a:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    133d:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
    1340:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1344:	89 ce                	mov    esi,ecx
    1346:	48 89 c7             	mov    rdi,rax
    1349:	e8 00 00 00 00       	call   134e <ahci_port_intr+0x87>
				cm |= 1;
    134e:	83 4d fc 01          	or     DWORD PTR [rbp-0x4],0x1
		if (is & (1 << 6)) { /* PCS */
    1352:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1355:	83 e0 40             	and    eax,0x40
    1358:	85 c0                	test   eax,eax
    135a:	74 38                	je     1394 <ahci_port_intr+0xcd>
				abiprintf("PCS on port %d received, resetting...\n", pt);
    135c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    135f:	89 c6                	mov    esi,eax
    1361:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1368:	b8 00 00 00 00       	mov    eax,0x0
    136d:	e8 00 00 00 00       	call   1372 <ahci_port_intr+0xab>
				p->pXserr = 0xffffffff;
    1372:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1376:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
				ahci_reset_port(d->ptr, p);
    137d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1381:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1385:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1389:	48 89 d6             	mov    rsi,rdx
    138c:	48 89 c7             	mov    rdi,rax
    138f:	e8 00 00 00 00       	call   1394 <ahci_port_intr+0xcd>
		if (is & (1 << 30)) { /* we need to restart the command engine */
    1394:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1397:	25 00 00 00 40       	and    eax,0x40000000
    139c:	85 c0                	test   eax,eax
    139e:	74 1d                	je     13bd <ahci_port_intr+0xf6>
				ahci_port_handle_tfes_regular(d, p, pt);
    13a0:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    13a3:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    13a7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    13ab:	48 89 ce             	mov    rsi,rcx
    13ae:	48 89 c7             	mov    rdi,rax
    13b1:	e8 00 00 00 00       	call   13b6 <ahci_port_intr+0xef>
				cm |= (1 << 30);
    13b6:	81 4d fc 00 00 00 40 	or     DWORD PTR [rbp-0x4],0x40000000
		cm |= p->pXie;
    13bd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13c1:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    13c4:	09 45 fc             	or     DWORD PTR [rbp-0x4],eax
		abiprintf("port cm: %x\n", cm);
    13c7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13ca:	89 c6                	mov    esi,eax
    13cc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    13d3:	b8 00 00 00 00       	mov    eax,0x0
    13d8:	e8 00 00 00 00       	call   13dd <ahci_port_intr+0x116>
		p->pXis = cm;
    13dd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13e1:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    13e4:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
}
    13e7:	90                   	nop
    13e8:	c9                   	leave
    13e9:	c3                   	ret

00000000000013ea <ahci_handle_interrupt>:
{
    13ea:	55                   	push   rbp
    13eb:	48 89 e5             	mov    rbp,rsp
    13ee:	48 83 ec 20          	sub    rsp,0x20
    13f2:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    13f6:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		uint32_t is = d->ptr->intr, clm = 0;
    13f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13fd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1401:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1404:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
    1407:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		for (int i = 0; i < 32; i++) {
    140e:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1415:	eb 3b                	jmp    1452 <ahci_handle_interrupt+0x68>
				if (is & (1 << i)) {
    1417:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    141a:	ba 01 00 00 00       	mov    edx,0x1
    141f:	89 c1                	mov    ecx,eax
    1421:	d3 e2                	shl    edx,cl
    1423:	89 d0                	mov    eax,edx
    1425:	23 45 f4             	and    eax,DWORD PTR [rbp-0xc]
    1428:	85 c0                	test   eax,eax
    142a:	74 22                	je     144e <ahci_handle_interrupt+0x64>
						ahci_port_intr(d, i);
    142c:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    142f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1433:	89 d6                	mov    esi,edx
    1435:	48 89 c7             	mov    rdi,rax
    1438:	e8 00 00 00 00       	call   143d <ahci_handle_interrupt+0x53>
						clm |= (1 << i);
    143d:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1440:	ba 01 00 00 00       	mov    edx,0x1
    1445:	89 c1                	mov    ecx,eax
    1447:	d3 e2                	shl    edx,cl
    1449:	89 d0                	mov    eax,edx
    144b:	09 45 fc             	or     DWORD PTR [rbp-0x4],eax
		for (int i = 0; i < 32; i++) {
    144e:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    1452:	83 7d f8 1f          	cmp    DWORD PTR [rbp-0x8],0x1f
    1456:	7e bf                	jle    1417 <ahci_handle_interrupt+0x2d>
		d->ptr->intr = clm;
    1458:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    145c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1460:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1463:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
}
    1466:	90                   	nop
    1467:	c9                   	leave
    1468:	c3                   	ret

0000000000001469 <ahci_irq>:
{
    1469:	55                   	push   rbp
    146a:	48 89 e5             	mov    rbp,rsp
    146d:	48 83 ec 30          	sub    rsp,0x30
    1471:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    1474:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 147b <ahci_irq+0x12>
    147b:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    147f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1483:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1487:	e9 8a 00 00 00       	jmp    1516 <ahci_irq+0xad>
				if (d->dev->dev->intr_line == irq) {
    148c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1490:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1494:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1497:	0f b6 40 09          	movzx  eax,BYTE PTR [rax+0x9]
    149b:	0f b6 c0             	movzx  eax,al
    149e:	39 45 dc             	cmp    DWORD PTR [rbp-0x24],eax
    14a1:	75 5f                	jne    1502 <ahci_irq+0x99>
						if (pci_check_interrupt(d->dev->dev)) {
    14a3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14a7:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    14ab:	48 8b 00             	mov    rax,QWORD PTR [rax]
    14ae:	48 89 c7             	mov    rdi,rax
    14b1:	e8 00 00 00 00       	call   14b6 <ahci_irq+0x4d>
    14b6:	85 c0                	test   eax,eax
    14b8:	74 1c                	je     14d6 <ahci_irq+0x6d>
								ahci_handle_interrupt(d->dev, irq);
    14ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14be:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    14c2:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    14c5:	89 d6                	mov    esi,edx
    14c7:	48 89 c7             	mov    rdi,rax
    14ca:	e8 00 00 00 00       	call   14cf <ahci_irq+0x66>
								return 1;
    14cf:	b8 01 00 00 00       	mov    eax,0x1
    14d4:	eb 68                	jmp    153e <ahci_irq+0xd5>
								if (d->dev->ptr->intr) {
    14d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14da:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    14de:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    14e2:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    14e5:	85 c0                	test   eax,eax
    14e7:	74 19                	je     1502 <ahci_irq+0x99>
										ahci_handle_interrupt(d->dev, irq);
    14e9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14ed:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    14f1:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    14f4:	89 d6                	mov    esi,edx
    14f6:	48 89 c7             	mov    rdi,rax
    14f9:	e8 00 00 00 00       	call   14fe <ahci_irq+0x95>
										rv++;
    14fe:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    1502:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1506:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    150a:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    150e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1512:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1516:	48 81 7d f8 00 00 00 00 	cmp    QWORD PTR [rbp-0x8],0x0
    151e:	0f 85 68 ff ff ff    	jne    148c <ahci_irq+0x23>
		if (!rv)
    1524:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    1528:	75 11                	jne    153b <ahci_irq+0xd2>
				abiprintf("ignored non AHCI interrupt\n");
    152a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1531:	b8 00 00 00 00       	mov    eax,0x0
    1536:	e8 00 00 00 00       	call   153b <ahci_irq+0xd2>
		return rv;
    153b:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
    153e:	c9                   	leave
    153f:	c3                   	ret

0000000000001540 <ahci_find_slot>:
{
    1540:	55                   	push   rbp
    1541:	48 89 e5             	mov    rbp,rsp
    1544:	48 83 ec 20          	sub    rsp,0x20
    1548:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    154c:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		uint32_t bitmask = (p->pXci/* NCQ: | p->pXsact*/);
    154f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1553:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    1556:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		for (int i = 0; i < cmd_ct; i++) {
    1559:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1560:	eb 16                	jmp    1578 <ahci_find_slot+0x38>
				if (!(bitmask & 1))
    1562:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1565:	83 e0 01             	and    eax,0x1
    1568:	85 c0                	test   eax,eax
    156a:	75 05                	jne    1571 <ahci_find_slot+0x31>
						return i;
    156c:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    156f:	eb 14                	jmp    1585 <ahci_find_slot+0x45>
				bitmask >>= 1;
    1571:	d1 6d fc             	shr    DWORD PTR [rbp-0x4],1
		for (int i = 0; i < cmd_ct; i++) {
    1574:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    1578:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    157b:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
    157e:	7c e2                	jl     1562 <ahci_find_slot+0x22>
		return -1;
    1580:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    1585:	c9                   	leave
    1586:	c3                   	ret

0000000000001587 <ahci_release_cmdtbl>:
{
    1587:	55                   	push   rbp
    1588:	48 89 e5             	mov    rbp,rsp
    158b:	48 83 ec 30          	sub    rsp,0x30
    158f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1593:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    1597:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    159b:	48 8b 80 18 05 00 00 	mov    rax,QWORD PTR [rax+0x518]
    15a2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    15a6:	e9 ed 00 00 00       	jmp    1698 <ahci_release_cmdtbl+0x111>
				ptrdiff_t ofs = ctp->tables - entry;
    15ab:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15af:	48 83 c0 18          	add    rax,0x18
    15b3:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
    15b7:	48 c1 f8 03          	sar    rax,0x3
    15bb:	48 89 c2             	mov    rdx,rax
    15be:	48 b8 ab aa aa aa aa aa aa aa 	movabs rax,0xaaaaaaaaaaaaaaab
    15c8:	48 0f af c2          	imul   rax,rdx
    15cc:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (ofs >= 0 && ofs < 32) {
    15d0:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    15d5:	0f 88 b1 00 00 00    	js     168c <ahci_release_cmdtbl+0x105>
    15db:	48 83 7d f0 1f       	cmp    QWORD PTR [rbp-0x10],0x1f
    15e0:	0f 8f a6 00 00 00    	jg     168c <ahci_release_cmdtbl+0x105>
						uint16_t p = entry->port, slt = entry->slot;
    15e6:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15ea:	0f b7 00             	movzx  eax,WORD PTR [rax]
    15ed:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
    15f1:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15f5:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    15f9:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
						entry->port = entry->slot = 0xffff;
    15fd:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1601:	66 c7 40 02 ff ff    	mov    WORD PTR [rax+0x2],0xffff
    1607:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    160b:	0f b7 50 02          	movzx  edx,WORD PTR [rax+0x2]
    160f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1613:	66 89 10             	mov    WORD PTR [rax],dx
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    1616:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    161a:	ba 01 00 00 00       	mov    edx,0x1
    161f:	89 c1                	mov    ecx,eax
    1621:	d3 e2                	shl    edx,cl
    1623:	89 d0                	mov    eax,edx
    1625:	89 c7                	mov    edi,eax
								~(1 << ofs)))) {
    1627:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    162b:	ba 01 00 00 00       	mov    edx,0x1
    1630:	89 c1                	mov    ecx,eax
    1632:	d3 e2                	shl    edx,cl
    1634:	89 d0                	mov    eax,edx
    1636:	f7 d0                	not    eax
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    1638:	41 89 c0             	mov    r8d,eax
    163b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    163f:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1643:	8b 02                	mov    eax,DWORD PTR [rdx]
    1645:	89 c6                	mov    esi,eax
    1647:	89 c1                	mov    ecx,eax
    1649:	44 21 c1             	and    ecx,r8d
    164c:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1650:	0f 94 c1             	sete   cl
    1653:	84 c9                	test   cl,cl
    1655:	74 ee                	je     1645 <ahci_release_cmdtbl+0xbe>
    1657:	89 f8                	mov    eax,edi
    1659:	21 f0                	and    eax,esi
    165b:	85 c0                	test   eax,eax
    165d:	75 46                	jne    16a5 <ahci_release_cmdtbl+0x11e>
								abprintf("attempt to release command table at %p"
    165f:	0f b7 4d ec          	movzx  ecx,WORD PTR [rbp-0x14]
    1663:	0f b7 55 ee          	movzx  edx,WORD PTR [rbp-0x12]
    1667:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    166b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    166f:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    1673:	49 89 f0             	mov    r8,rsi
    1676:	48 89 c6             	mov    rsi,rax
    1679:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1680:	b8 00 00 00 00       	mov    eax,0x0
    1685:	e8 00 00 00 00       	call   168a <ahci_release_cmdtbl+0x103>
						break;
    168a:	eb 19                	jmp    16a5 <ahci_release_cmdtbl+0x11e>
				ctp = ctp->next;
    168c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1690:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1694:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    1698:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    169d:	0f 85 08 ff ff ff    	jne    15ab <ahci_release_cmdtbl+0x24>
}
    16a3:	eb 01                	jmp    16a6 <ahci_release_cmdtbl+0x11f>
						break;
    16a5:	90                   	nop
}
    16a6:	90                   	nop
    16a7:	c9                   	leave
    16a8:	c3                   	ret

00000000000016a9 <ahci_find_cmdtbl>:
{
    16a9:	55                   	push   rbp
    16aa:	48 89 e5             	mov    rbp,rsp
    16ad:	48 83 ec 20          	sub    rsp,0x20
    16b1:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    16b5:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    16b8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16bc:	48 8b 80 18 05 00 00 	mov    rax,QWORD PTR [rax+0x518]
    16c3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    16c7:	e9 a5 00 00 00       	jmp    1771 <ahci_find_cmdtbl+0xc8>
				if (ctp->prdt_cap >= prdt_ct) {
    16cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16d0:	8b 00                	mov    eax,DWORD PTR [rax]
    16d2:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
    16d5:	0f 82 8a 00 00 00    	jb     1765 <ahci_find_cmdtbl+0xbc>
Pos1:
    16db:	90                   	nop
						bit = bsf(~ctp->mask); /* 1 based */
    16dc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16e0:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    16e3:	f7 d0                	not    eax
    16e5:	89 c7                	mov    edi,eax
    16e7:	e8 34 e9 ff ff       	call   20 <bsf>
    16ec:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if (bit--) {
    16ef:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    16f2:	8d 50 ff             	lea    edx,[rax-0x1]
    16f5:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    16f8:	85 c0                	test   eax,eax
    16fa:	74 69                	je     1765 <ahci_find_cmdtbl+0xbc>
								if (!((1 << bit) & __sync_fetch_and_or(&ctp->mask, 1 << bit))) {
    16fc:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    16ff:	ba 01 00 00 00       	mov    edx,0x1
    1704:	89 c1                	mov    ecx,eax
    1706:	d3 e2                	shl    edx,cl
    1708:	89 d0                	mov    eax,edx
    170a:	89 c7                	mov    edi,eax
    170c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    170f:	ba 01 00 00 00       	mov    edx,0x1
    1714:	89 c1                	mov    ecx,eax
    1716:	d3 e2                	shl    edx,cl
    1718:	89 d0                	mov    eax,edx
    171a:	41 89 c0             	mov    r8d,eax
    171d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1721:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1725:	8b 02                	mov    eax,DWORD PTR [rdx]
    1727:	89 c6                	mov    esi,eax
    1729:	89 c1                	mov    ecx,eax
    172b:	44 09 c1             	or     ecx,r8d
    172e:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1732:	0f 94 c1             	sete   cl
    1735:	84 c9                	test   cl,cl
    1737:	74 ee                	je     1727 <ahci_find_cmdtbl+0x7e>
    1739:	89 f8                	mov    eax,edi
    173b:	21 f0                	and    eax,esi
    173d:	85 c0                	test   eax,eax
    173f:	75 9b                	jne    16dc <ahci_find_cmdtbl+0x33>
										return &ctp->tables[bit];
    1741:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1744:	48 63 d0             	movsxd rdx,eax
    1747:	48 89 d0             	mov    rax,rdx
    174a:	48 01 c0             	add    rax,rax
    174d:	48 01 d0             	add    rax,rdx
    1750:	48 c1 e0 03          	shl    rax,0x3
    1754:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1758:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    175c:	48 01 d0             	add    rax,rdx
    175f:	48 83 c0 08          	add    rax,0x8
    1763:	eb 60                	jmp    17c5 <ahci_find_cmdtbl+0x11c>
				ctp = ctp->next;
    1765:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1769:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    176d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ctp) {
    1771:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1776:	0f 85 50 ff ff ff    	jne    16cc <ahci_find_cmdtbl+0x23>
		if (jiffies - warn_time > HZ * 300) {
    177c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1783 <ahci_find_cmdtbl+0xda>
    1783:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1786:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 178d <ahci_find_cmdtbl+0xe4>
    178d:	48 29 c2             	sub    rdx,rax
    1790:	48 81 fa cc 8d 00 00 	cmp    rdx,0x8dcc
    1797:	76 27                	jbe    17c0 <ahci_find_cmdtbl+0x117>
				warn_time = jiffies;
    1799:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17a0 <ahci_find_cmdtbl+0xf7>
    17a0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    17a3:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17aa <ahci_find_cmdtbl+0x101>
				cprintf(KFMT_INFO, "Command table pool exhausted.\nI/O performance"
    17aa:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    17b1:	bf 0b 00 00 00       	mov    edi,0xb
    17b6:	b8 00 00 00 00       	mov    eax,0x0
    17bb:	e8 00 00 00 00       	call   17c0 <ahci_find_cmdtbl+0x117>
		return NULL;
    17c0:	b8 00 00 00 00       	mov    eax,0x0
}
    17c5:	c9                   	leave
    17c6:	c3                   	ret

00000000000017c7 <ahci_process_host_command>:
{
    17c7:	55                   	push   rbp
    17c8:	48 89 e5             	mov    rbp,rsp
    17cb:	48 83 ec 70          	sub    rsp,0x70
    17cf:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    17d3:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
    17d7:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
		switch (cc->c) {
    17db:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    17df:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    17e2:	3d 80 00 00 00       	cmp    eax,0x80
    17e7:	74 10                	je     17f9 <ahci_process_host_command+0x32>
    17e9:	3d 82 00 00 00       	cmp    eax,0x82
    17ee:	0f 84 c3 04 00 00    	je     1cb7 <ahci_process_host_command+0x4f0>
    17f4:	e9 dc 05 00 00       	jmp    1dd5 <ahci_process_host_command+0x60e>
						struct ata_identify* id = ad->identify_data[cc->port].ptr;
    17f9:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    17fd:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    1801:	0f b7 c0             	movzx  eax,ax
    1804:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    1808:	48 63 d0             	movsxd rdx,eax
    180b:	48 89 d0             	mov    rax,rdx
    180e:	48 01 c0             	add    rax,rax
    1811:	48 01 d0             	add    rax,rdx
    1814:	48 c1 e0 03          	shl    rax,0x3
    1818:	48 01 c8             	add    rax,rcx
    181b:	48 05 20 02 00 00    	add    rax,0x220
    1821:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1824:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						int comp = 1, su = 0, pt = cc->port;
    1828:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
    182f:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1836:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    183a:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    183e:	0f b7 c0             	movzx  eax,ax
    1841:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC
    1844:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1848:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    184c:	66 3d c8 37          	cmp    ax,0x37c8
    1850:	74 0e                	je     1860 <ahci_process_host_command+0x99>
								|| id->specific_configuration == ATA_SC_NO_SPIN_UP_INC)
    1852:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1856:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    185a:	66 3d 73 8c          	cmp    ax,0x8c73
    185e:	75 07                	jne    1867 <ahci_process_host_command+0xa0>
								comp = 0;
    1860:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP
    1867:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    186b:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    186f:	66 3d 8c 73          	cmp    ax,0x738c
    1873:	74 0e                	je     1883 <ahci_process_host_command+0xbc>
								|| id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC)
    1875:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1879:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    187d:	66 3d c8 37          	cmp    ax,0x37c8
    1881:	75 07                	jne    188a <ahci_process_host_command+0xc3>
								su = 1;
    1883:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [rbp-0x8],0x1
						if (comp && id->checksum_validity == 0xa5) {
    188a:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    188e:	74 70                	je     1900 <ahci_process_host_command+0x139>
    1890:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1894:	0f b6 80 fe 01 00 00 	movzx  eax,BYTE PTR [rax+0x1fe]
    189b:	3c a5                	cmp    al,0xa5
    189d:	75 61                	jne    1900 <ahci_process_host_command+0x139>
								if (checksum_memory(id, sizeof(*id))) {
    189f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18a3:	be 00 02 00 00       	mov    esi,0x200
    18a8:	48 89 c7             	mov    rdi,rax
    18ab:	e8 1a e9 ff ff       	call   1ca <checksum_memory>
    18b0:	84 c0                	test   al,al
    18b2:	74 4c                	je     1900 <ahci_process_host_command+0x139>
										cc->c = disk_cmd_identify;
    18b4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    18b8:	c7 40 18 00 00 00 00 	mov    DWORD PTR [rax+0x18],0x0
										cc->ptr = NULL;
    18bf:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    18c3:	48 c7 40 30 00 00 00 00 	mov    QWORD PTR [rax+0x30],0x0
										cc->cur_buf = NULL;
    18cb:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    18cf:	48 c7 40 58 00 00 00 00 	mov    QWORD PTR [rax+0x58],0x0
										printf("Invalid IDENTIFY received: reissuing...\n");
    18d7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    18de:	b8 00 00 00 00       	mov    eax,0x0
    18e3:	e8 00 00 00 00       	call   18e8 <ahci_process_host_command+0x121>
										ahci_reissue_command(ad, cc);
    18e8:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    18ec:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    18f0:	48 89 d6             	mov    rsi,rdx
    18f3:	48 89 c7             	mov    rdi,rax
    18f6:	e8 00 00 00 00       	call   18fb <ahci_process_host_command+0x134>
										return; /* we reuse cc */
    18fb:	e9 39 05 00 00       	jmp    1e39 <ahci_process_host_command+0x672>
						if (comp) {
    1900:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1904:	0f 84 73 03 00 00    	je     1c7d <ahci_process_host_command+0x4b6>
								uint64_t max_sec = 0; uint32_t lpp = 1, lls = 512, lof = 0;
    190a:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1912:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
    1919:	c7 45 e8 00 02 00 00 	mov    DWORD PTR [rbp-0x18],0x200
    1920:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0
    1927:	eb 01                	jmp    192a <ahci_process_host_command+0x163>
								goto is_comp;				
    1929:	90                   	nop
								convert_ata_string(id->model_number, 20);
    192a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    192e:	48 83 c0 36          	add    rax,0x36
    1932:	be 14 00 00 00       	mov    esi,0x14
    1937:	48 89 c7             	mov    rdi,rax
    193a:	e8 ca e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->additional_product_identifier, 4);
    193f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1943:	48 05 54 01 00 00    	add    rax,0x154
    1949:	be 04 00 00 00       	mov    esi,0x4
    194e:	48 89 c7             	mov    rdi,rax
    1951:	e8 b3 e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->current_media_manufacturer, 10);
    1956:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    195a:	48 05 88 01 00 00    	add    rax,0x188
    1960:	be 0a 00 00 00       	mov    esi,0xa
    1965:	48 89 c7             	mov    rdi,rax
    1968:	e8 9c e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->current_media_serial_number, 20);
    196d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1971:	48 05 60 01 00 00    	add    rax,0x160
    1977:	be 14 00 00 00       	mov    esi,0x14
    197c:	48 89 c7             	mov    rdi,rax
    197f:	e8 85 e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->firmware_rev, 4);
    1984:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1988:	48 83 c0 2e          	add    rax,0x2e
    198c:	be 04 00 00 00       	mov    esi,0x4
    1991:	48 89 c7             	mov    rdi,rax
    1994:	e8 70 e8 ff ff       	call   209 <convert_ata_string>
								convert_ata_string(id->serial_number, 10);
    1999:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    199d:	48 83 c0 14          	add    rax,0x14
    19a1:	be 0a 00 00 00       	mov    esi,0xa
    19a6:	48 89 c7             	mov    rdi,rax
    19a9:	e8 5b e8 ff ff       	call   209 <convert_ata_string>
								if (!id->lba_supp) {
    19ae:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19b2:	0f b6 40 63          	movzx  eax,BYTE PTR [rax+0x63]
    19b6:	83 e0 02             	and    eax,0x2
    19b9:	84 c0                	test   al,al
    19bb:	75 0a                	jne    19c7 <ahci_process_host_command+0x200>
										max_sec = -1; /* CHS? ATAncient */
    19bd:	48 c7 45 f0 ff ff ff ff 	mov    QWORD PTR [rbp-0x10],0xffffffffffffffff
    19c5:	eb 42                	jmp    1a09 <ahci_process_host_command+0x242>
								} else if (id->has_lba48 || id->has_lba48_alt)
    19c7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19cb:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [rax+0xa7]
    19d2:	83 e0 04             	and    eax,0x4
    19d5:	84 c0                	test   al,al
    19d7:	75 12                	jne    19eb <ahci_process_host_command+0x224>
    19d9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19dd:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [rax+0xad]
    19e4:	83 e0 04             	and    eax,0x4
    19e7:	84 c0                	test   al,al
    19e9:	74 11                	je     19fc <ahci_process_host_command+0x235>
										max_sec = id->num_logical_sectors;
    19eb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19ef:	48 8b 80 c8 00 00 00 	mov    rax,QWORD PTR [rax+0xc8]
    19f6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    19fa:	eb 0d                	jmp    1a09 <ahci_process_host_command+0x242>
										max_sec = id->max_lba28;
    19fc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a00:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
    1a03:	89 c0                	mov    eax,eax
    1a05:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
								if (id->has_multiple_logical_per_physical_sectors) {
    1a09:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a0d:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [rax+0xd5]
    1a14:	83 e0 20             	and    eax,0x20
    1a17:	84 c0                	test   al,al
    1a19:	74 1f                	je     1a3a <ahci_process_host_command+0x273>
										lpp = 1 << id->num_pwr2_logical_per_phys;
    1a1b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a1f:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [rax+0xd4]
    1a26:	83 e0 0f             	and    eax,0xf
    1a29:	0f b6 c0             	movzx  eax,al
    1a2c:	ba 01 00 00 00       	mov    edx,0x1
    1a31:	89 c1                	mov    ecx,eax
    1a33:	d3 e2                	shl    edx,cl
    1a35:	89 d0                	mov    eax,edx
    1a37:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								if (id->logical_sector_longer_than_512bt) {
    1a3a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a3e:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [rax+0xd5]
    1a45:	83 e0 10             	and    eax,0x10
    1a48:	84 c0                	test   al,al
    1a4a:	74 31                	je     1a7d <ahci_process_host_command+0x2b6>
										lls = 2 * id->logical_sector_size;
    1a4c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a50:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [rax+0xea]
    1a56:	01 c0                	add    eax,eax
    1a58:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
										lof = id->logical_sector_offset;
    1a5b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a5f:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [rax+0x1a2]
    1a66:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [rax+0x1a3]
    1a6d:	83 e0 3f             	and    eax,0x3f
    1a70:	48 c1 e0 08          	shl    rax,0x8
    1a74:	48 09 d0             	or     rax,rdx
    1a77:	0f b7 c0             	movzx  eax,ax
    1a7a:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
												(char*)id->current_media_manufacturer, (char*)id->current_media_serial_number);
    1a7d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a81:	48 8d b8 60 01 00 00 	lea    rdi,[rax+0x160]
    1a88:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a8c:	48 8d b0 88 01 00 00 	lea    rsi,[rax+0x188]
												(char*)id->serial_number, (char*)id->firmware_rev,
    1a93:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a97:	4c 8d 48 2e          	lea    r9,[rax+0x2e]
    1a9b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a9f:	4c 8d 40 14          	lea    r8,[rax+0x14]
												pt, (char*)id->model_number, (char*)id->additional_product_identifier,
    1aa3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1aa7:	48 8d 88 54 01 00 00 	lea    rcx,[rax+0x154]
    1aae:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ab2:	48 8d 50 36          	lea    rdx,[rax+0x36]
								printf("IDENTIFY on port %u: %.40s %.8s %.20s %.8s\nMedia: %.20s %.40s\n",
    1ab6:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    1ab9:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    1abe:	48 89 34 24          	mov    QWORD PTR [rsp],rsi
    1ac2:	89 c6                	mov    esi,eax
    1ac4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1acb:	b8 00 00 00 00       	mov    eax,0x0
    1ad0:	e8 00 00 00 00       	call   1ad5 <ahci_process_host_command+0x30e>
										capstr(id->form_factor, 6, "", "5.25\"", "3.5\"", "2.5\"", "1.8\"", "<1.8\"", ""),
    1ad5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ad9:	0f b6 80 50 01 00 00 	movzx  eax,BYTE PTR [rax+0x150]
    1ae0:	83 e0 0f             	and    eax,0xf
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1ae3:	0f b6 c0             	movzx  eax,al
    1ae6:	48 c7 44 24 10 00 00 00 00 	mov    QWORD PTR [rsp+0x10],0x0
    1aef:	48 c7 44 24 08 00 00 00 00 	mov    QWORD PTR [rsp+0x8],0x0
    1af8:	48 c7 04 24 00 00 00 00 	mov    QWORD PTR [rsp],0x0
    1b00:	49 c7 c1 00 00 00 00 	mov    r9,0x0
    1b07:	49 c7 c0 00 00 00 00 	mov    r8,0x0
    1b0e:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    1b15:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1b1c:	be 06 00 00 00       	mov    esi,0x6
    1b21:	89 c7                	mov    edi,eax
    1b23:	b8 00 00 00 00       	mov    eax,0x0
    1b28:	e8 00 00 00 00       	call   1b2d <ahci_process_host_command+0x366>
    1b2d:	48 89 c7             	mov    rdi,rax
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    1b30:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b34:	0f b6 40 63          	movzx  eax,BYTE PTR [rax+0x63]
    1b38:	83 e0 02             	and    eax,0x2
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b3b:	84 c0                	test   al,al
    1b3d:	74 24                	je     1b63 <ahci_process_host_command+0x39c>
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    1b3f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b43:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [rax+0xa7]
    1b4a:	83 e0 04             	and    eax,0x4
    1b4d:	84 c0                	test   al,al
    1b4f:	74 09                	je     1b5a <ahci_process_host_command+0x393>
    1b51:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1b58:	eb 10                	jmp    1b6a <ahci_process_host_command+0x3a3>
    1b5a:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1b61:	eb 07                	jmp    1b6a <ahci_process_host_command+0x3a3>
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b63:	48 c7 c0 00 00 00 00 	mov    rax,0x0
										id->ata_version_major, id->ata_version_minor,
    1b6a:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1b6e:	0f b7 92 a2 00 00 00 	movzx  edx,WORD PTR [rdx+0xa2]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b75:	0f b7 d2             	movzx  edx,dx
										id->ata_version_major, id->ata_version_minor,
    1b78:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    1b7c:	0f b7 89 a0 00 00 00 	movzx  ecx,WORD PTR [rcx+0xa0]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1b83:	0f b7 f1             	movzx  esi,cx
    1b86:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1b8a:	49 89 c9             	mov    r9,rcx
    1b8d:	49 89 f8             	mov    r8,rdi
    1b90:	48 89 c1             	mov    rcx,rax
    1b93:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b9a:	b8 00 00 00 00       	mov    eax,0x0
    1b9f:	e8 00 00 00 00       	call   1ba4 <ahci_process_host_command+0x3dd>
								printf("Logical sectors: size: %u offset: %u num_per_phys: %u\n", lls, lof, lpp);
    1ba4:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
    1ba7:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    1baa:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1bad:	89 c6                	mov    esi,eax
    1baf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1bb6:	b8 00 00 00 00       	mov    eax,0x0
    1bbb:	e8 00 00 00 00       	call   1bc0 <ahci_process_host_command+0x3f9>
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    1bc0:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1bc3:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1bc8:	48 c1 e8 28          	shr    rax,0x28
    1bcc:	48 89 c7             	mov    rdi,rax
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    1bcf:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1bd2:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1bd7:	48 c1 e8 1e          	shr    rax,0x1e
    1bdb:	48 89 c6             	mov    rsi,rax
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1bde:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1be1:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1be6:	48 c1 e8 14          	shr    rax,0x14
    1bea:	48 89 c1             	mov    rcx,rax
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1bed:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1bf0:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1bf5:	48 c1 e8 0a          	shr    rax,0xa
    1bf9:	48 89 c2             	mov    rdx,rax
    1bfc:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1bff:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
    1c04:	49 89 f9             	mov    r9,rdi
    1c07:	49 89 f0             	mov    r8,rsi
    1c0a:	48 89 c6             	mov    rsi,rax
    1c0d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c14:	b8 00 00 00 00       	mov    eax,0x0
    1c19:	e8 00 00 00 00       	call   1c1e <ahci_process_host_command+0x457>
								if (!id->is_not_ata) {
    1c1e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c22:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    1c26:	83 e0 80             	and    eax,0xffffff80
    1c29:	84 c0                	test   al,al
    1c2b:	0f 85 dd 01 00 00    	jne    1e0e <ahci_process_host_command+0x647>
										if (register_ata_device(ad, p, 0, id))
    1c31:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1c35:	48 8b 75 c0          	mov    rsi,QWORD PTR [rbp-0x40]
    1c39:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1c3d:	48 89 d1             	mov    rcx,rdx
    1c40:	ba 00 00 00 00       	mov    edx,0x0
    1c45:	48 89 c7             	mov    rdi,rax
    1c48:	e8 00 00 00 00       	call   1c4d <ahci_process_host_command+0x486>
    1c4d:	85 c0                	test   eax,eax
    1c4f:	74 16                	je     1c67 <ahci_process_host_command+0x4a0>
												printf("Registered device in file system.\n");
    1c51:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c58:	b8 00 00 00 00       	mov    eax,0x0
    1c5d:	e8 00 00 00 00       	call   1c62 <ahci_process_host_command+0x49b>
						break;
    1c62:	e9 a7 01 00 00       	jmp    1e0e <ahci_process_host_command+0x647>
												printf("Failed to register device.\n");
    1c67:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c6e:	b8 00 00 00 00       	mov    eax,0x0
    1c73:	e8 00 00 00 00       	call   1c78 <ahci_process_host_command+0x4b1>
						break;
    1c78:	e9 91 01 00 00       	jmp    1e0e <ahci_process_host_command+0x647>
						} else if (su) {
    1c7d:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1c81:	0f 84 a2 fc ff ff    	je     1929 <ahci_process_host_command+0x162>
								die("spin-up by SET FEATURES not supported yet!\n");
    1c87:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1c8e:	bf 0c 00 00 00       	mov    edi,0xc
    1c93:	b8 00 00 00 00       	mov    eax,0x0
    1c98:	e8 00 00 00 00       	call   1c9d <ahci_process_host_command+0x4d6>
    1c9d:	b8 00 00 00 00       	mov    eax,0x0
    1ca2:	e8 00 00 00 00       	call   1ca7 <ahci_process_host_command+0x4e0>
    1ca7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cae:	e8 00 00 00 00       	call   1cb3 <ahci_process_host_command+0x4ec>
    1cb3:	fa                   	cli
    1cb4:	f4                   	hlt
    1cb5:	eb fd                	jmp    1cb4 <ahci_process_host_command+0x4ed>
						int timeout = 50; /* up to 500 ms */
    1cb7:	c7 45 e0 32 00 00 00 	mov    DWORD PTR [rbp-0x20],0x32
						p->cmd.st = 0;
    1cbe:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1cc2:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    1cc5:	83 e0 fe             	and    eax,0xfffffffe
    1cc8:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						while (p->cmd.cr && timeout--)
    1ccb:	eb 0a                	jmp    1cd7 <ahci_process_host_command+0x510>
								mdelay(10);
    1ccd:	bf 0a 00 00 00       	mov    edi,0xa
    1cd2:	e8 00 00 00 00       	call   1cd7 <ahci_process_host_command+0x510>
						while (p->cmd.cr && timeout--)
    1cd7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cdb:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1cde:	c1 e8 0f             	shr    eax,0xf
    1ce1:	83 e0 01             	and    eax,0x1
    1ce4:	84 c0                	test   al,al
    1ce6:	74 0d                	je     1cf5 <ahci_process_host_command+0x52e>
    1ce8:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1ceb:	8d 50 ff             	lea    edx,[rax-0x1]
    1cee:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
    1cf1:	85 c0                	test   eax,eax
    1cf3:	75 d8                	jne    1ccd <ahci_process_host_command+0x506>
						if (p->cmd.cr) {
    1cf5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cf9:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1cfc:	c1 e8 0f             	shr    eax,0xf
    1cff:	83 e0 01             	and    eax,0x1
    1d02:	84 c0                	test   al,al
    1d04:	74 50                	je     1d56 <ahci_process_host_command+0x58f>
full_reset:
    1d06:	90                   	nop
    1d07:	eb 01                	jmp    1d0a <ahci_process_host_command+0x543>
										goto full_reset;
    1d09:	90                   	nop
										p - ad->ptr->port);
    1d0a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1d0e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1d12:	48 05 00 01 00 00    	add    rax,0x100
    1d18:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1d1c:	48 29 c2             	sub    rdx,rax
								abprintf("performing full port reset on port %zd\n",
    1d1f:	48 89 d0             	mov    rax,rdx
    1d22:	48 c1 f8 07          	sar    rax,0x7
    1d26:	48 89 c6             	mov    rsi,rax
    1d29:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d30:	b8 00 00 00 00       	mov    eax,0x0
    1d35:	e8 00 00 00 00       	call   1d3a <ahci_process_host_command+0x573>
								ahci_reset_port(ad->ptr, p);
    1d3a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1d3e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1d42:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1d46:	48 89 d6             	mov    rsi,rdx
    1d49:	48 89 c7             	mov    rdi,rax
    1d4c:	e8 00 00 00 00       	call   1d51 <ahci_process_host_command+0x58a>
						break;
    1d51:	e9 b9 00 00 00       	jmp    1e0f <ahci_process_host_command+0x648>
								p->pXserr = 0xffffffff;
    1d56:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d5a:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
								p->pXis = 0xffffffff; /* likewise */
    1d61:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d65:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [rax+0x10],0xffffffff
								if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    1d6c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d70:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    1d73:	0f b6 c0             	movzx  eax,al
    1d76:	25 88 00 00 00       	and    eax,0x88
    1d7b:	85 c0                	test   eax,eax
    1d7d:	75 8a                	jne    1d09 <ahci_process_host_command+0x542>
								p->cmd.st = 1;
    1d7f:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1d83:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    1d86:	83 c8 01             	or     eax,0x1
    1d89:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1d8c:	b8 32 00 00 00       	mov    eax,0x32
    1d91:	2b 45 e0             	sub    eax,DWORD PTR [rbp-0x20]
    1d94:	89 c2                	mov    edx,eax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1d96:	89 d0                	mov    eax,edx
    1d98:	c1 e0 02             	shl    eax,0x2
    1d9b:	01 d0                	add    eax,edx
    1d9d:	01 c0                	add    eax,eax
    1d9f:	89 c1                	mov    ecx,eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1da1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1da5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1da9:	48 05 00 01 00 00    	add    rax,0x100
    1daf:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1db3:	48 29 c2             	sub    rdx,rax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1db6:	48 89 d0             	mov    rax,rdx
    1db9:	48 c1 f8 07          	sar    rax,0x7
    1dbd:	89 ca                	mov    edx,ecx
    1dbf:	48 89 c6             	mov    rsi,rax
    1dc2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1dc9:	b8 00 00 00 00       	mov    eax,0x0
    1dce:	e8 00 00 00 00       	call   1dd3 <ahci_process_host_command+0x60c>
						break;
    1dd3:	eb 3a                	jmp    1e0f <ahci_process_host_command+0x648>
						die("someone messed up! command=%x\n", cc->c);
    1dd5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1dd9:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1ddc:	89 c2                	mov    edx,eax
    1dde:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1de5:	bf 0c 00 00 00       	mov    edi,0xc
    1dea:	b8 00 00 00 00       	mov    eax,0x0
    1def:	e8 00 00 00 00       	call   1df4 <ahci_process_host_command+0x62d>
    1df4:	b8 00 00 00 00       	mov    eax,0x0
    1df9:	e8 00 00 00 00       	call   1dfe <ahci_process_host_command+0x637>
    1dfe:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e05:	e8 00 00 00 00       	call   1e0a <ahci_process_host_command+0x643>
    1e0a:	fa                   	cli
    1e0b:	f4                   	hlt
    1e0c:	eb fd                	jmp    1e0b <ahci_process_host_command+0x644>
						break;
    1e0e:	90                   	nop
		ahci_release_cmdtbl(ad, cc->entry);
    1e0f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1e13:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    1e17:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1e1b:	48 89 d6             	mov    rsi,rdx
    1e1e:	48 89 c7             	mov    rdi,rax
    1e21:	e8 00 00 00 00       	call   1e26 <ahci_process_host_command+0x65f>
		ahci_destroy_context(ad, cc);
    1e26:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    1e2a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1e2e:	48 89 d6             	mov    rsi,rdx
    1e31:	48 89 c7             	mov    rdi,rax
    1e34:	e8 00 00 00 00       	call   1e39 <ahci_process_host_command+0x672>
}
    1e39:	c9                   	leave
    1e3a:	c3                   	ret

0000000000001e3b <ahci_process_command>:
{
    1e3b:	55                   	push   rbp
    1e3c:	48 89 e5             	mov    rbp,rsp
    1e3f:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    1e46:	48 89 7d 88          	mov    QWORD PTR [rbp-0x78],rdi
    1e4a:	48 89 75 80          	mov    QWORD PTR [rbp-0x80],rsi
    1e4e:	48 89 95 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdx
		struct cmd_ctx* cc; int slt, rv, pt = p - ad->ptr->port; uint32_t ct;
    1e55:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1e59:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e5d:	48 05 00 01 00 00    	add    rax,0x100
    1e63:	48 8b 55 80          	mov    rdx,QWORD PTR [rbp-0x80]
    1e67:	48 29 c2             	sub    rdx,rax
    1e6a:	48 89 d0             	mov    rax,rdx
    1e6d:	48 c1 f8 07          	sar    rax,0x7
    1e71:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
		struct ahci_cmdlst* cl = ad->command_lists[pt];
    1e74:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1e78:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    1e7b:	48 63 d2             	movsxd rdx,edx
    1e7e:	48 83 c2 02          	add    rdx,0x2
    1e82:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    1e87:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (!cl)
    1e8b:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    1e90:	75 18                	jne    1eaa <ahci_process_command+0x6f>
				abprintf("Ignoring command on port %d as it's command"
    1e92:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1e95:	89 c6                	mov    esi,eax
    1e97:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e9e:	b8 00 00 00 00       	mov    eax,0x0
    1ea3:	e8 00 00 00 00       	call   1ea8 <ahci_process_command+0x6d>
    1ea8:	eb 01                	jmp    1eab <ahci_process_command+0x70>
next_cmd:
    1eaa:	90                   	nop
		slt = ahci_find_slot(p, ad->num_cmd); /* does not reserve -> no cleanup */
    1eab:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1eaf:	0f b7 40 12          	movzx  eax,WORD PTR [rax+0x12]
    1eb3:	0f b7 d0             	movzx  edx,ax
    1eb6:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1eba:	89 d6                	mov    esi,edx
    1ebc:	48 89 c7             	mov    rdi,rax
    1ebf:	e8 00 00 00 00       	call   1ec4 <ahci_process_command+0x89>
    1ec4:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
		if (slt == -1) /* still full */
    1ec7:	83 7d c4 ff          	cmp    DWORD PTR [rbp-0x3c],0xffffffff
    1ecb:	0f 84 49 07 00 00    	je     261a <ahci_process_command+0x7df>
		if (!p->cmd.st) {
    1ed1:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1ed5:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1ed8:	83 e0 01             	and    eax,0x1
    1edb:	84 c0                	test   al,al
    1edd:	0f 85 c6 00 00 00    	jne    1fa9 <ahci_process_command+0x16e>
				abprintf("waiting for reset host command on port %d\n", pt);
    1ee3:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1ee6:	89 c6                	mov    esi,eax
    1ee8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1eef:	b8 00 00 00 00       	mov    eax,0x0
    1ef4:	e8 00 00 00 00       	call   1ef9 <ahci_process_command+0xbe>
				cc = list_cut_first_entry_where(lh, struct cmd_ctx, lst,
    1ef9:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    1f01:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f08:	48 89 c7             	mov    rdi,rax
    1f0b:	e8 9a e2 ff ff       	call   1aa <list_empty>
    1f10:	85 c0                	test   eax,eax
    1f12:	0f 85 84 00 00 00    	jne    1f9c <ahci_process_command+0x161>
    1f18:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f1f:	48 83 c0 10          	add    rax,0x10
    1f23:	48 89 c7             	mov    rdi,rax
    1f26:	e8 00 00 00 00       	call   1f2b <ahci_process_command+0xf0>
    1f2b:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f32:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f36:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
    1f3a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1f3e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1f42:	eb 38                	jmp    1f7c <ahci_process_command+0x141>
    1f44:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f48:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1f4b:	3d 82 00 00 00       	cmp    eax,0x82
    1f50:	75 16                	jne    1f68 <ahci_process_command+0x12d>
    1f52:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f56:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f5a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f5e:	48 89 c7             	mov    rdi,rax
    1f61:	e8 1f e1 ff ff       	call   85 <__list_del>
    1f66:	eb 21                	jmp    1f89 <ahci_process_command+0x14e>
    1f68:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f6c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f70:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
    1f74:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f78:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1f7c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f80:	48 39 85 78 ff ff ff 	cmp    QWORD PTR [rbp-0x88],rax
    1f87:	75 bb                	jne    1f44 <ahci_process_command+0x109>
    1f89:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1f90:	48 83 c0 10          	add    rax,0x10
    1f94:	48 89 c7             	mov    rdi,rax
    1f97:	e8 00 00 00 00       	call   1f9c <ahci_process_command+0x161>
    1f9c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1fa0:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1fa4:	e9 a8 00 00 00       	jmp    2051 <ahci_process_command+0x216>
				abprintf("processing command in slot %d on port %d\n", slt, pt);
    1fa9:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    1fac:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1faf:	89 c6                	mov    esi,eax
    1fb1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fb8:	b8 00 00 00 00       	mov    eax,0x0
    1fbd:	e8 00 00 00 00       	call   1fc2 <ahci_process_command+0x187>
				cc = list_cut_first_entry(lh, struct cmd_ctx, lst);
    1fc2:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1fc9:	48 89 c7             	mov    rdi,rax
    1fcc:	e8 d9 e1 ff ff       	call   1aa <list_empty>
    1fd1:	85 c0                	test   eax,eax
    1fd3:	75 6c                	jne    2041 <ahci_process_command+0x206>
    1fd5:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1fdc:	48 83 c0 10          	add    rax,0x10
    1fe0:	48 89 c7             	mov    rdi,rax
    1fe3:	e8 00 00 00 00       	call   1fe8 <ahci_process_command+0x1ad>
    1fe8:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1fef:	48 89 c7             	mov    rdi,rax
    1ff2:	e8 b3 e1 ff ff       	call   1aa <list_empty>
    1ff7:	85 c0                	test   eax,eax
    1ff9:	75 15                	jne    2010 <ahci_process_command+0x1d5>
    1ffb:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2002:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2006:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    200a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    200e:	eb 05                	jmp    2015 <ahci_process_command+0x1da>
    2010:	b8 00 00 00 00       	mov    eax,0x0
    2015:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    2019:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    201e:	74 0c                	je     202c <ahci_process_command+0x1f1>
    2020:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2024:	48 89 c7             	mov    rdi,rax
    2027:	e8 59 e0 ff ff       	call   85 <__list_del>
    202c:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2033:	48 83 c0 10          	add    rax,0x10
    2037:	48 89 c7             	mov    rdi,rax
    203a:	e8 00 00 00 00       	call   203f <ahci_process_command+0x204>
    203f:	eb 08                	jmp    2049 <ahci_process_command+0x20e>
    2041:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    2049:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    204d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!cc) { /* the command vanished?/or isn't posted yet */
    2051:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    2056:	75 16                	jne    206e <ahci_process_command+0x233>
				abprintf("command vanished\n");
    2058:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    205f:	b8 00 00 00 00       	mov    eax,0x0
    2064:	e8 00 00 00 00       	call   2069 <ahci_process_command+0x22e>
				return;
    2069:	e9 ad 05 00 00       	jmp    261b <ahci_process_command+0x7e0>
		if (cc->c == host_cmd_resend) {
    206e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2072:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2075:	3d 81 00 00 00       	cmp    eax,0x81
    207a:	75 0c                	jne    2088 <ahci_process_command+0x24d>
				rv = 0;
    207c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
				goto issue;
    2083:	e9 75 03 00 00       	jmp    23fd <ahci_process_command+0x5c2>
		} else if (cc->c >= host_cmd_process_identify) {
    2088:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    208c:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    208f:	83 f8 7f             	cmp    eax,0x7f
    2092:	76 1c                	jbe    20b0 <ahci_process_command+0x275>
				ahci_process_host_command(ad, p, cc);
    2094:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2098:	48 8b 4d 80          	mov    rcx,QWORD PTR [rbp-0x80]
    209c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    20a0:	48 89 ce             	mov    rsi,rcx
    20a3:	48 89 c7             	mov    rdi,rax
    20a6:	e8 00 00 00 00       	call   20ab <ahci_process_command+0x270>
				goto incr;
    20ab:	e9 44 05 00 00       	jmp    25f4 <ahci_process_command+0x7b9>
		if (cc->ptr) {
    20b0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20b4:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    20b8:	48 85 c0             	test   rax,rax
    20bb:	74 6e                	je     212b <ahci_process_command+0x2f0>
				/*void* ptr2; */uint64_t s = cc->ct;
    20bd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20c1:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    20c5:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
				ct = rdiv(s, 4096) + 1; /* first guess */
    20c9:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    20cd:	48 c1 e8 0c          	shr    rax,0xc
    20d1:	89 c2                	mov    edx,eax
    20d3:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    20d7:	25 ff 0f 00 00       	and    eax,0xfff
    20dc:	48 85 c0             	test   rax,rax
    20df:	74 07                	je     20e8 <ahci_process_command+0x2ad>
    20e1:	b8 01 00 00 00       	mov    eax,0x1
    20e6:	eb 05                	jmp    20ed <ahci_process_command+0x2b2>
    20e8:	b8 00 00 00 00       	mov    eax,0x0
    20ed:	01 d0                	add    eax,edx
    20ef:	83 c0 01             	add    eax,0x1
    20f2:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				if (ct > 8) {
    20f5:	83 7d f0 08          	cmp    DWORD PTR [rbp-0x10],0x8
    20f9:	76 4b                	jbe    2146 <ahci_process_command+0x30b>
						die("implement this later.\n");
    20fb:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2102:	bf 0c 00 00 00       	mov    edi,0xc
    2107:	b8 00 00 00 00       	mov    eax,0x0
    210c:	e8 00 00 00 00       	call   2111 <ahci_process_command+0x2d6>
    2111:	b8 00 00 00 00       	mov    eax,0x0
    2116:	e8 00 00 00 00       	call   211b <ahci_process_command+0x2e0>
    211b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2122:	e8 00 00 00 00       	call   2127 <ahci_process_command+0x2ec>
    2127:	fa                   	cli
    2128:	f4                   	hlt
    2129:	eb fd                	jmp    2128 <ahci_process_command+0x2ed>
		} else if (cc->c == disk_cmd_identify) {
    212b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    212f:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2132:	85 c0                	test   eax,eax
    2134:	75 09                	jne    213f <ahci_process_command+0x304>
				ct = 1;
    2136:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [rbp-0x10],0x1
    213d:	eb 07                	jmp    2146 <ahci_process_command+0x30b>
				ct = 0;
    213f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
		if (!cc->entry) /* else: max_prdtl still valid */
    2146:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    214a:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    214e:	48 85 c0             	test   rax,rax
    2151:	75 19                	jne    216c <ahci_process_command+0x331>
				cc->entry = ahci_find_cmdtbl(ad, ct);
    2153:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    2156:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    215a:	89 d6                	mov    esi,edx
    215c:	48 89 c7             	mov    rdi,rax
    215f:	e8 00 00 00 00       	call   2164 <ahci_process_command+0x329>
    2164:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2168:	48 89 42 78          	mov    QWORD PTR [rdx+0x78],rax
		if (cc->entry) {
    216c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2170:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2174:	48 85 c0             	test   rax,rax
    2177:	74 31                	je     21aa <ahci_process_command+0x36f>
				cc->entry->port = cc->port;
    2179:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    217d:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2181:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2185:	0f b7 52 50          	movzx  edx,WORD PTR [rdx+0x50]
    2189:	66 89 10             	mov    WORD PTR [rax],dx
				cc->entry->slot = slt;
    218c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2190:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2194:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    2197:	66 89 50 02          	mov    WORD PTR [rax+0x2],dx
				cc->slot = slt;
    219b:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    219e:	89 c2                	mov    edx,eax
    21a0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21a4:	66 89 50 52          	mov    WORD PTR [rax+0x52],dx
    21a8:	eb 16                	jmp    21c0 <ahci_process_command+0x385>
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);
    21aa:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    21ad:	89 c6                	mov    esi,eax
    21af:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21b6:	b8 00 00 00 00       	mov    eax,0x0
    21bb:	e8 00 00 00 00       	call   21c0 <ahci_process_command+0x385>
		if (!cc->entry && ct > 8) { /* divide by twoish */
    21c0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21c4:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    21c8:	48 85 c0             	test   rax,rax
    21cb:	75 3d                	jne    220a <ahci_process_command+0x3cf>
    21cd:	83 7d f0 08          	cmp    DWORD PTR [rbp-0x10],0x8
    21d1:	76 37                	jbe    220a <ahci_process_command+0x3cf>
				int log = bsr(ct) - 1;
    21d3:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    21d6:	89 c7                	mov    edi,eax
    21d8:	e8 23 de ff ff       	call   0 <bsr>
    21dd:	83 e8 01             	sub    eax,0x1
    21e0:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
				uint32_t new_ct = (1 << log);
    21e3:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    21e6:	ba 01 00 00 00       	mov    edx,0x1
    21eb:	89 c1                	mov    ecx,eax
    21ed:	d3 e2                	shl    edx,cl
    21ef:	89 d0                	mov    eax,edx
    21f1:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
				if (new_ct == ct)
    21f4:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    21f7:	3b 45 f0             	cmp    eax,DWORD PTR [rbp-0x10]
    21fa:	75 03                	jne    21ff <ahci_process_command+0x3c4>
						new_ct >>= 1;
    21fc:	d1 6d d4             	shr    DWORD PTR [rbp-0x2c],1
				ct = new_ct;
    21ff:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    2202:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				goto find;
    2205:	e9 3c ff ff ff       	jmp    2146 <ahci_process_command+0x30b>
		} else if (!cc->entry) { /* none available */
    220a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    220e:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2212:	48 85 c0             	test   rax,rax
    2215:	75 2c                	jne    2243 <ahci_process_command+0x408>
				abprintf("waiting for cmdtbl to become available.\n");
    2217:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    221e:	b8 00 00 00 00       	mov    eax,0x0
    2223:	e8 00 00 00 00       	call   2228 <ahci_process_command+0x3ed>
				list_add(&cc->lst, lh);
    2228:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    222c:	48 8b 95 78 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x88]
    2233:	48 89 d6             	mov    rsi,rdx
    2236:	48 89 c7             	mov    rdi,rax
    2239:	e8 92 de ff ff       	call   d0 <list_add>
				return;
    223e:	e9 d8 03 00 00       	jmp    261b <ahci_process_command+0x7e0>
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    2243:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2247:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    224b:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    224f:	0f b7 c8             	movzx  ecx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    2252:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2256:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    225a:	0f b7 00             	movzx  eax,WORD PTR [rax]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    225d:	0f b7 d0             	movzx  edx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    2260:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2264:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    2268:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    226c:	48 89 c6             	mov    rsi,rax
    226f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2276:	b8 00 00 00 00       	mov    eax,0x0
    227b:	e8 00 00 00 00       	call   2280 <ahci_process_command+0x445>
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
    2280:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    2283:	ba 08 00 00 00       	mov    edx,0x8
    2288:	39 d0                	cmp    eax,edx
    228a:	0f 43 d0             	cmovae edx,eax
    228d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2291:	89 90 80 00 00 00    	mov    DWORD PTR [rax+0x80],edx
		if (p->cmd.atapi) { /* ATAPI */
    2297:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    229b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    229e:	c1 e8 18             	shr    eax,0x18
    22a1:	83 e0 01             	and    eax,0x1
    22a4:	84 c0                	test   al,al
    22a6:	0f 84 99 00 00 00    	je     2345 <ahci_process_command+0x50a>
				switch (cc->c) {
    22ac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    22b0:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    22b3:	85 c0                	test   eax,eax
    22b5:	74 0a                	je     22c1 <ahci_process_command+0x486>
    22b7:	83 e8 01             	sub    eax,0x1
    22ba:	83 f8 02             	cmp    eax,0x2
    22bd:	77 4d                	ja     230c <ahci_process_command+0x4d1>
    22bf:	eb 1b                	jmp    22dc <ahci_process_command+0x4a1>
								rv = atapi_build_packet_device_identify(ad, cc);
    22c1:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    22c5:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    22c9:	48 89 d6             	mov    rsi,rdx
    22cc:	48 89 c7             	mov    rdi,rax
    22cf:	e8 00 00 00 00       	call   22d4 <ahci_process_command+0x499>
    22d4:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								break;
    22d7:	e9 21 01 00 00       	jmp    23fd <ahci_process_command+0x5c2>
								die("not implemented yet!\n");
    22dc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    22e3:	bf 0c 00 00 00       	mov    edi,0xc
    22e8:	b8 00 00 00 00       	mov    eax,0x0
    22ed:	e8 00 00 00 00       	call   22f2 <ahci_process_command+0x4b7>
    22f2:	b8 00 00 00 00       	mov    eax,0x0
    22f7:	e8 00 00 00 00       	call   22fc <ahci_process_command+0x4c1>
    22fc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2303:	e8 00 00 00 00       	call   2308 <ahci_process_command+0x4cd>
    2308:	fa                   	cli
    2309:	f4                   	hlt
    230a:	eb fd                	jmp    2309 <ahci_process_command+0x4ce>
								die("The command %x should not end up here.\n", cc->c);
    230c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2310:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2313:	89 c2                	mov    edx,eax
    2315:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    231c:	bf 0c 00 00 00       	mov    edi,0xc
    2321:	b8 00 00 00 00       	mov    eax,0x0
    2326:	e8 00 00 00 00       	call   232b <ahci_process_command+0x4f0>
    232b:	b8 00 00 00 00       	mov    eax,0x0
    2330:	e8 00 00 00 00       	call   2335 <ahci_process_command+0x4fa>
    2335:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    233c:	e8 00 00 00 00       	call   2341 <ahci_process_command+0x506>
    2341:	fa                   	cli
    2342:	f4                   	hlt
    2343:	eb fd                	jmp    2342 <ahci_process_command+0x507>
				switch (cc->c) { /* ATA */
    2345:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2349:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    234c:	83 f8 03             	cmp    eax,0x3
    234f:	77 73                	ja     23c4 <ahci_process_command+0x589>
    2351:	83 f8 02             	cmp    eax,0x2
    2354:	73 3e                	jae    2394 <ahci_process_command+0x559>
    2356:	85 c0                	test   eax,eax
    2358:	74 07                	je     2361 <ahci_process_command+0x526>
    235a:	83 f8 01             	cmp    eax,0x1
    235d:	74 1d                	je     237c <ahci_process_command+0x541>
    235f:	eb 63                	jmp    23c4 <ahci_process_command+0x589>
								rv = ata_build_device_identify(ad, cc);
    2361:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2365:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2369:	48 89 d6             	mov    rsi,rdx
    236c:	48 89 c7             	mov    rdi,rax
    236f:	e8 00 00 00 00       	call   2374 <ahci_process_command+0x539>
    2374:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								break;
    2377:	e9 81 00 00 00       	jmp    23fd <ahci_process_command+0x5c2>
								rv = ata_build_read_dma_ext(ad, cc);
    237c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2380:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2384:	48 89 d6             	mov    rsi,rdx
    2387:	48 89 c7             	mov    rdi,rax
    238a:	e8 00 00 00 00       	call   238f <ahci_process_command+0x554>
    238f:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								break;
    2392:	eb 69                	jmp    23fd <ahci_process_command+0x5c2>
								die("not implemented yet!\n");
    2394:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    239b:	bf 0c 00 00 00       	mov    edi,0xc
    23a0:	b8 00 00 00 00       	mov    eax,0x0
    23a5:	e8 00 00 00 00       	call   23aa <ahci_process_command+0x56f>
    23aa:	b8 00 00 00 00       	mov    eax,0x0
    23af:	e8 00 00 00 00       	call   23b4 <ahci_process_command+0x579>
    23b4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    23bb:	e8 00 00 00 00       	call   23c0 <ahci_process_command+0x585>
    23c0:	fa                   	cli
    23c1:	f4                   	hlt
    23c2:	eb fd                	jmp    23c1 <ahci_process_command+0x586>
								die("The command %x should not end up here.\n", cc->c);
    23c4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    23c8:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    23cb:	89 c2                	mov    edx,eax
    23cd:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    23d4:	bf 0c 00 00 00       	mov    edi,0xc
    23d9:	b8 00 00 00 00       	mov    eax,0x0
    23de:	e8 00 00 00 00       	call   23e3 <ahci_process_command+0x5a8>
    23e3:	b8 00 00 00 00       	mov    eax,0x0
    23e8:	e8 00 00 00 00       	call   23ed <ahci_process_command+0x5b2>
    23ed:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    23f4:	e8 00 00 00 00       	call   23f9 <ahci_process_command+0x5be>
    23f9:	fa                   	cli
    23fa:	f4                   	hlt
    23fb:	eb fd                	jmp    23fa <ahci_process_command+0x5bf>
		if (rv) { /* cleanup */
    23fd:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    2401:	74 68                	je     246b <ahci_process_command+0x630>
				abprintf("ignored malformed command on port %u\n", cc->port);
    2403:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2407:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    240b:	0f b7 c0             	movzx  eax,ax
    240e:	89 c6                	mov    esi,eax
    2410:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2417:	b8 00 00 00 00       	mov    eax,0x0
    241c:	e8 00 00 00 00       	call   2421 <ahci_process_command+0x5e6>
				if (cc->status)
    2421:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2425:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2429:	48 85 c0             	test   rax,rax
    242c:	74 0e                	je     243c <ahci_process_command+0x601>
						cc->status->state = cmd_state_abort;
    242e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2432:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2436:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
				ahci_release_cmdtbl(ad, cc->entry);
    243c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2440:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    2444:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2448:	48 89 d6             	mov    rsi,rdx
    244b:	48 89 c7             	mov    rdi,rax
    244e:	e8 00 00 00 00       	call   2453 <ahci_process_command+0x618>
				ahci_destroy_context(ad, cc);
    2453:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2457:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    245b:	48 89 d6             	mov    rsi,rdx
    245e:	48 89 c7             	mov    rdi,rax
    2461:	e8 00 00 00 00       	call   2466 <ahci_process_command+0x62b>
    2466:	e9 89 01 00 00       	jmp    25f4 <ahci_process_command+0x7b9>
		} else if (!(p->pXci & (1 << slt))) {/* issue it on the port p slot slt */
    246b:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    246f:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    2472:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    2475:	be 01 00 00 00       	mov    esi,0x1
    247a:	89 c1                	mov    ecx,eax
    247c:	d3 e6                	shl    esi,cl
    247e:	89 f0                	mov    eax,esi
    2480:	21 d0                	and    eax,edx
    2482:	85 c0                	test   eax,eax
    2484:	0f 85 3a 01 00 00    	jne    25c4 <ahci_process_command+0x789>
				struct ahci_cmdhdr* ch = &ad->command_lists[cc->port]->chdrs[slt];
    248a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    248e:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2492:	0f b7 d0             	movzx  edx,ax
    2495:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2499:	48 63 d2             	movsxd rdx,edx
    249c:	48 83 c2 02          	add    rdx,0x2
    24a0:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    24a5:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    24a8:	48 63 d2             	movsxd rdx,edx
    24ab:	48 c1 e2 05          	shl    rdx,0x5
    24af:	48 01 d0             	add    rax,rdx
    24b2:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
				bzero(ch, sizeof(*ch));
    24b6:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    24ba:	be 20 00 00 00       	mov    esi,0x20
    24bf:	48 89 c7             	mov    rdi,rax
    24c2:	e8 00 00 00 00       	call   24c7 <ahci_process_command+0x68c>
				ch->ctba64 = cc->entry->pmem;
    24c7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    24cb:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    24cf:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    24d3:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    24d7:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				ch->prdtl = cc->clh.prdtl;
    24db:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    24df:	0f b7 50 70          	movzx  edx,WORD PTR [rax+0x70]
    24e3:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    24e7:	66 89 50 02          	mov    WORD PTR [rax+0x2],dx
				ch->flags = cc->clh.flg;
    24eb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    24ef:	0f b7 50 72          	movzx  edx,WORD PTR [rax+0x72]
    24f3:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    24f7:	66 89 10             	mov    WORD PTR [rax],dx
				if (p->cmd.st) {
    24fa:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    24fe:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2501:	83 e0 01             	and    eax,0x1
    2504:	84 c0                	test   al,al
    2506:	74 32                	je     253a <ahci_process_command+0x6ff>
						p->pXci = (1 << slt);
    2508:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    250b:	ba 01 00 00 00       	mov    edx,0x1
    2510:	89 c1                	mov    ecx,eax
    2512:	d3 e2                	shl    edx,cl
    2514:	89 d0                	mov    eax,edx
    2516:	89 c2                	mov    edx,eax
    2518:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    251c:	89 50 38             	mov    DWORD PTR [rax+0x38],edx
						if (cc->status)
    251f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2523:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2527:	48 85 c0             	test   rax,rax
    252a:	74 0e                	je     253a <ahci_process_command+0x6ff>
								cc->status->state = cmd_state_issued;
    252c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2530:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2534:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
				if (!p->cmd.st) {
    253a:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    253e:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2541:	83 e0 01             	and    eax,0x1
    2544:	84 c0                	test   al,al
    2546:	75 31                	jne    2579 <ahci_process_command+0x73e>
						abprintf("command will be sent later\n");
    2548:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    254f:	b8 00 00 00 00       	mov    eax,0x0
    2554:	e8 00 00 00 00       	call   2559 <ahci_process_command+0x71e>
						cc->c = host_cmd_resend;
    2559:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    255d:	c7 40 18 81 00 00 00 	mov    DWORD PTR [rax+0x18],0x81
						ahci_reissue_command(ad, cc);
    2564:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2568:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    256c:	48 89 d6             	mov    rsi,rdx
    256f:	48 89 c7             	mov    rdi,rax
    2572:	e8 00 00 00 00       	call   2577 <ahci_process_command+0x73c>
						goto incr; /* skip putting into proc_cmds */
    2577:	eb 7b                	jmp    25f4 <ahci_process_command+0x7b9>
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
    2579:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    257d:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2581:	0f b7 c0             	movzx  eax,ax
    2584:	48 63 d0             	movsxd rdx,eax
    2587:	48 89 d0             	mov    rax,rdx
    258a:	48 01 c0             	add    rax,rax
    258d:	48 01 d0             	add    rax,rdx
    2590:	48 c1 e0 03          	shl    rax,0x3
    2594:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    259b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    259f:	48 01 c2             	add    rdx,rax
    25a2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    25a6:	48 89 d6             	mov    rsi,rdx
    25a9:	48 89 c7             	mov    rdi,rax
    25ac:	e8 6d db ff ff       	call   11e <list_add_tail>
				abprintf("issued the command successfully.\n");
    25b1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25b8:	b8 00 00 00 00       	mov    eax,0x0
    25bd:	e8 00 00 00 00       	call   25c2 <ahci_process_command+0x787>
    25c2:	eb 30                	jmp    25f4 <ahci_process_command+0x7b9>
				 * inherently single threaded structure? */
				die("error posting command\n");
    25c4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25cb:	bf 0c 00 00 00       	mov    edi,0xc
    25d0:	b8 00 00 00 00       	mov    eax,0x0
    25d5:	e8 00 00 00 00       	call   25da <ahci_process_command+0x79f>
    25da:	b8 00 00 00 00       	mov    eax,0x0
    25df:	e8 00 00 00 00       	call   25e4 <ahci_process_command+0x7a9>
    25e4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25eb:	e8 00 00 00 00       	call   25f0 <ahci_process_command+0x7b5>
    25f0:	fa                   	cli
    25f1:	f4                   	hlt
    25f2:	eb fd                	jmp    25f1 <ahci_process_command+0x7b6>
		}

		/* process next command */
incr:
		__sync_fetch_and_sub(&ad->pending_ct, 1);
    25f4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    25f8:	48 05 20 0b 00 00    	add    rax,0xb20
    25fe:	f0 83 28 01          	lock sub DWORD PTR [rax],0x1
		if (!list_empty(lh))
    2602:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2609:	48 89 c7             	mov    rdi,rax
    260c:	e8 99 db ff ff       	call   1aa <list_empty>
    2611:	85 c0                	test   eax,eax
    2613:	75 06                	jne    261b <ahci_process_command+0x7e0>
				goto next_cmd;
    2615:	e9 91 f8 ff ff       	jmp    1eab <ahci_process_command+0x70>
				return;
    261a:	90                   	nop
}
    261b:	c9                   	leave
    261c:	c3                   	ret

000000000000261d <ahci_worker>:

void ahci_worker(void* dat)
{
    261d:	55                   	push   rbp
    261e:	48 89 e5             	mov    rbp,rsp
    2621:	48 83 ec 50          	sub    rsp,0x50
    2625:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct ahci_device* ad = dat;
    2629:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    262d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax

		printf("AHCI worker is running\n");
    2631:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2638:	b8 00 00 00 00       	mov    eax,0x0
    263d:	e8 00 00 00 00       	call   2642 <ahci_worker+0x25>
		while (1) {
				uint32_t ps = ad->ptr->ports;
    2642:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2646:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    264a:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    264d:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    2650:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2654:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2658:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    265b:	d1 e8                	shr    eax,1
    265d:	83 e0 01             	and    eax,0x1
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    2660:	0f b6 c8             	movzx  ecx,al
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    2663:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2667:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    266b:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    266e:	c1 e8 1f             	shr    eax,0x1f
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    2671:	0f b6 d0             	movzx  edx,al
    2674:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2678:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    267c:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    267f:	89 c6                	mov    esi,eax
    2681:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2688:	b8 00 00 00 00       	mov    eax,0x0
    268d:	e8 00 00 00 00       	call   2692 <ahci_worker+0x75>
				for (int i = 0; i < 32; i++)
    2692:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    2699:	e9 50 01 00 00       	jmp    27ee <ahci_worker+0x1d1>
						if (ps & (1 << i)) {
    269e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    26a1:	ba 01 00 00 00       	mov    edx,0x1
    26a6:	89 c1                	mov    ecx,eax
    26a8:	d3 e2                	shl    edx,cl
    26aa:	89 d0                	mov    eax,edx
    26ac:	23 45 ec             	and    eax,DWORD PTR [rbp-0x14]
    26af:	85 c0                	test   eax,eax
    26b1:	0f 84 33 01 00 00    	je     27ea <ahci_worker+0x1cd>
//										ad->ptr->port[i].scr0.ipm, ad->ptr[i].port[i].pXserr);
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    26b7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    26bb:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    26bf:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    26c2:	48 63 d2             	movsxd rdx,edx
    26c5:	48 c1 e2 07          	shl    rdx,0x7
    26c9:	48 01 d0             	add    rax,rdx
    26cc:	48 05 34 01 00 00    	add    rax,0x134
    26d2:	44 8b 08             	mov    r9d,DWORD PTR [rax]
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    26d5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    26d9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    26dd:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    26e0:	48 63 d2             	movsxd rdx,edx
    26e3:	48 c1 e2 07          	shl    rdx,0x7
    26e7:	48 01 d0             	add    rax,rdx
    26ea:	48 05 38 01 00 00    	add    rax,0x138
    26f0:	44 8b 00             	mov    r8d,DWORD PTR [rax]
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    26f3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    26f7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    26fb:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    26fe:	48 63 d2             	movsxd rdx,edx
    2701:	48 c1 e2 07          	shl    rdx,0x7
    2705:	48 01 d0             	add    rax,rdx
    2708:	48 05 20 01 00 00    	add    rax,0x120
    270e:	8b 00                	mov    eax,DWORD PTR [rax]
    2710:	0f b6 c4             	movzx  eax,ah
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2713:	0f b6 f8             	movzx  edi,al
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    2716:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    271a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    271e:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2721:	48 63 d2             	movsxd rdx,edx
    2724:	48 c1 e2 07          	shl    rdx,0x7
    2728:	48 01 d0             	add    rax,rdx
    272b:	48 05 20 01 00 00    	add    rax,0x120
    2731:	8b 00                	mov    eax,DWORD PTR [rax]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2733:	0f b6 f0             	movzx  esi,al
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    2736:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    273a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    273e:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2741:	48 63 d2             	movsxd rdx,edx
    2744:	48 c1 e2 07          	shl    rdx,0x7
    2748:	48 01 d0             	add    rax,rdx
    274b:	48 05 14 01 00 00    	add    rax,0x114
    2751:	44 8b 18             	mov    r11d,DWORD PTR [rax]
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    2754:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2758:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    275c:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    275f:	48 63 d2             	movsxd rdx,edx
    2762:	48 c1 e2 07          	shl    rdx,0x7
    2766:	48 01 d0             	add    rax,rdx
    2769:	48 05 10 01 00 00    	add    rax,0x110
    276f:	44 8b 10             	mov    r10d,DWORD PTR [rax]
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    2772:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2776:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    277a:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    277d:	48 63 d2             	movsxd rdx,edx
    2780:	48 c1 e2 07          	shl    rdx,0x7
    2784:	48 01 d0             	add    rax,rdx
    2787:	48 05 10 01 00 00    	add    rax,0x110
    278d:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2790:	c1 e8 0f             	shr    eax,0xf
    2793:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2796:	0f b6 c8             	movzx  ecx,al
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    2799:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    279d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    27a1:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    27a4:	48 63 d2             	movsxd rdx,edx
    27a7:	48 c1 e2 07          	shl    rdx,0x7
    27ab:	48 01 d0             	add    rax,rdx
    27ae:	48 05 10 01 00 00    	add    rax,0x110
    27b4:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    27b7:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    27ba:	0f b6 d0             	movzx  edx,al
    27bd:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    27c0:	44 89 4c 24 18       	mov    DWORD PTR [rsp+0x18],r9d
    27c5:	44 89 44 24 10       	mov    DWORD PTR [rsp+0x10],r8d
    27ca:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    27ce:	89 34 24             	mov    DWORD PTR [rsp],esi
    27d1:	45 89 d9             	mov    r9d,r11d
    27d4:	45 89 d0             	mov    r8d,r10d
    27d7:	89 c6                	mov    esi,eax
    27d9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    27e0:	b8 00 00 00 00       	mov    eax,0x0
    27e5:	e8 00 00 00 00       	call   27ea <ahci_worker+0x1cd>
				for (int i = 0; i < 32; i++)
    27ea:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    27ee:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    27f2:	0f 8e a6 fe ff ff    	jle    269e <ahci_worker+0x81>
//
						}
				/* print global IS */
				void ioapic_print_is();
				int pci_print_is(union pca);
				ioapic_print_is();
    27f8:	b8 00 00 00 00       	mov    eax,0x0
    27fd:	e8 00 00 00 00       	call   2802 <ahci_worker+0x1e5>
				pci_print_is(ad->dev->addr);
    2802:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2806:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2809:	8b 00                	mov    eax,DWORD PTR [rax]
    280b:	89 c7                	mov    edi,eax
    280d:	e8 00 00 00 00       	call   2812 <ahci_worker+0x1f5>
//						}
//						/* R1C */
//						ad->ptr->intr = 1;
//				}

				wait_on_event(&ad->wh);
    2812:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2816:	48 05 40 0b 00 00    	add    rax,0xb40
    281c:	48 89 c7             	mov    rdi,rax
    281f:	e8 00 00 00 00       	call   2824 <ahci_worker+0x207>
				//sleep(1);

				/* there are pending commands */
				if (ad->pending_ct) {
    2824:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2828:	8b 80 20 0b 00 00    	mov    eax,DWORD PTR [rax+0xb20]
    282e:	85 c0                	test   eax,eax
    2830:	0f 84 0c fe ff ff    	je     2642 <ahci_worker+0x25>
						for (int i = 0; i < 32; i++) {
    2836:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    283d:	e9 95 00 00 00       	jmp    28d7 <ahci_worker+0x2ba>
								if (!(ps & (1 << i)))
    2842:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    2845:	ba 01 00 00 00       	mov    edx,0x1
    284a:	89 c1                	mov    ecx,eax
    284c:	d3 e2                	shl    edx,cl
    284e:	89 d0                	mov    eax,edx
    2850:	23 45 ec             	and    eax,DWORD PTR [rbp-0x14]
    2853:	85 c0                	test   eax,eax
    2855:	74 78                	je     28cf <ahci_worker+0x2b2>
										continue;
								if (list_empty(&ad->pending_cmds[i]))
    2857:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    285a:	48 63 d0             	movsxd rdx,eax
    285d:	48 89 d0             	mov    rax,rdx
    2860:	48 01 c0             	add    rax,rax
    2863:	48 01 d0             	add    rax,rdx
    2866:	48 c1 e0 03          	shl    rax,0x3
    286a:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    2871:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2875:	48 01 d0             	add    rax,rdx
    2878:	48 89 c7             	mov    rdi,rax
    287b:	e8 2a d9 ff ff       	call   1aa <list_empty>
    2880:	85 c0                	test   eax,eax
    2882:	75 4e                	jne    28d2 <ahci_worker+0x2b5>
										continue;
								/* we have commands to process */
								ahci_process_command(ad, &ad->ptr->port[i],
    2884:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    2887:	48 63 d0             	movsxd rdx,eax
    288a:	48 89 d0             	mov    rax,rdx
    288d:	48 01 c0             	add    rax,rax
    2890:	48 01 d0             	add    rax,rdx
    2893:	48 c1 e0 03          	shl    rax,0x3
    2897:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    289e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28a2:	48 01 c2             	add    rdx,rax
    28a5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28a9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    28ad:	8b 4d f8             	mov    ecx,DWORD PTR [rbp-0x8]
    28b0:	48 63 c9             	movsxd rcx,ecx
    28b3:	48 83 c1 02          	add    rcx,0x2
    28b7:	48 c1 e1 07          	shl    rcx,0x7
    28bb:	48 01 c1             	add    rcx,rax
    28be:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28c2:	48 89 ce             	mov    rsi,rcx
    28c5:	48 89 c7             	mov    rdi,rax
    28c8:	e8 00 00 00 00       	call   28cd <ahci_worker+0x2b0>
    28cd:	eb 04                	jmp    28d3 <ahci_worker+0x2b6>
										continue;
    28cf:	90                   	nop
    28d0:	eb 01                	jmp    28d3 <ahci_worker+0x2b6>
										continue;
    28d2:	90                   	nop
						for (int i = 0; i < 32; i++) {
    28d3:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    28d7:	83 7d f8 1f          	cmp    DWORD PTR [rbp-0x8],0x1f
    28db:	0f 8e 61 ff ff ff    	jle    2842 <ahci_worker+0x225>
		while (1) {
    28e1:	e9 5c fd ff ff       	jmp    2642 <ahci_worker+0x25>

00000000000028e6 <ahci_allocate_command_table_pool>:
				}
		}
}

void* ahci_allocate_command_table_pool(uint32_t ct, uint32_t prdt_cap, int bit64)
{
    28e6:	55                   	push   rbp
    28e7:	48 89 e5             	mov    rbp,rsp
    28ea:	48 83 c4 80          	add    rsp,0xffffffffffffff80
    28ee:	89 7d 8c             	mov    DWORD PTR [rbp-0x74],edi
    28f1:	89 75 88             	mov    DWORD PTR [rbp-0x78],esi
    28f4:	89 55 84             	mov    DWORD PTR [rbp-0x7c],edx
		/* 128bt aligned size (8 PRDT/128 bt) */
		struct ahci_ct_pool* rv; uint32_t i = 0;
    28f7:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		size_t byte_ct, page_rest, indiv_ct, pg_pe, pg_ct, epa;
		struct page_range pr; int flg = MMGR_ALLOC_CONTIGUOUS;
    28fe:	c7 45 dc 00 00 03 00 	mov    DWORD PTR [rbp-0x24],0x30000
		if (!bit64)
    2905:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    2909:	75 07                	jne    2912 <ahci_allocate_command_table_pool+0x2c>
				flg = MMGR_ALLOC_32BIT;
    290b:	c7 45 dc 00 00 04 00 	mov    DWORD PTR [rbp-0x24],0x40000
		if (!(rv = kzalloc(sizeof(*rv))))
    2912:	bf 18 03 00 00       	mov    edi,0x318
    2917:	e8 00 00 00 00       	call   291c <ahci_allocate_command_table_pool+0x36>
    291c:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2920:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    2925:	75 0a                	jne    2931 <ahci_allocate_command_table_pool+0x4b>
				return NULL;
    2927:	b8 00 00 00 00       	mov    eax,0x0
    292c:	e9 63 03 00 00       	jmp    2c94 <ahci_allocate_command_table_pool+0x3ae>
	   
		/* bitmask limit */
		if (ct > 32)
    2931:	83 7d 8c 20          	cmp    DWORD PTR [rbp-0x74],0x20
    2935:	76 07                	jbe    293e <ahci_allocate_command_table_pool+0x58>
				ct = 32;
    2937:	c7 45 8c 20 00 00 00 	mov    DWORD PTR [rbp-0x74],0x20
		/* enforce alignment */
		if (prdt_cap % 8)
    293e:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    2941:	83 e0 07             	and    eax,0x7
    2944:	85 c0                	test   eax,eax
    2946:	74 0c                	je     2954 <ahci_allocate_command_table_pool+0x6e>
				prdt_cap += 8 - prdt_cap % 8;
    2948:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    294b:	83 e0 f8             	and    eax,0xfffffff8
    294e:	83 c0 08             	add    eax,0x8
    2951:	89 45 88             	mov    DWORD PTR [rbp-0x78],eax
		indiv_ct = 128 + 16 * prdt_cap;
    2954:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    2957:	83 c0 08             	add    eax,0x8
    295a:	c1 e0 04             	shl    eax,0x4
    295d:	89 c0                	mov    eax,eax
    295f:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		byte_ct = ct * indiv_ct;
    2963:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    2966:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    296a:	48 0f af c2          	imul   rax,rdx
    296e:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		pg_pe = rdiv(indiv_ct, 4096);
    2972:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2976:	48 c1 e8 0c          	shr    rax,0xc
    297a:	48 89 c2             	mov    rdx,rax
    297d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2981:	25 ff 0f 00 00       	and    eax,0xfff
    2986:	48 85 c0             	test   rax,rax
    2989:	74 07                	je     2992 <ahci_allocate_command_table_pool+0xac>
    298b:	b8 01 00 00 00       	mov    eax,0x1
    2990:	eb 05                	jmp    2997 <ahci_allocate_command_table_pool+0xb1>
    2992:	b8 00 00 00 00       	mov    eax,0x0
    2997:	48 01 d0             	add    rax,rdx
    299a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		page_rest = pg_pe * 4096 - indiv_ct;
    299e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    29a2:	48 c1 e0 0c          	shl    rax,0xc
    29a6:	48 2b 45 b0          	sub    rax,QWORD PTR [rbp-0x50]
    29aa:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax

		/* pg_pe allocs must be contiguous, but if page_rest is low
		 * individual tables can be split up to different locations */
		if (!page_rest || (page_rest % indiv_ct == 0)) {
    29ae:	48 83 7d a0 00       	cmp    QWORD PTR [rbp-0x60],0x0
    29b3:	74 15                	je     29ca <ahci_allocate_command_table_pool+0xe4>
    29b5:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    29b9:	ba 00 00 00 00       	mov    edx,0x0
    29be:	48 f7 75 b0          	div    QWORD PTR [rbp-0x50]
    29c2:	48 89 d0             	mov    rax,rdx
    29c5:	48 85 c0             	test   rax,rax
    29c8:	75 56                	jne    2a20 <ahci_allocate_command_table_pool+0x13a>
				epa = pg_pe * 4096 / indiv_ct; /* entries per allocation */
    29ca:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    29ce:	48 c1 e0 0c          	shl    rax,0xc
    29d2:	ba 00 00 00 00       	mov    edx,0x0
    29d7:	48 f7 75 b0          	div    QWORD PTR [rbp-0x50]
    29db:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				pg_ct = rdiv(ct, epa) * pg_pe;
    29df:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    29e2:	ba 00 00 00 00       	mov    edx,0x0
    29e7:	48 f7 75 e0          	div    QWORD PTR [rbp-0x20]
    29eb:	48 89 c1             	mov    rcx,rax
    29ee:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    29f1:	ba 00 00 00 00       	mov    edx,0x0
    29f6:	48 f7 75 e0          	div    QWORD PTR [rbp-0x20]
    29fa:	48 89 d0             	mov    rax,rdx
    29fd:	48 85 c0             	test   rax,rax
    2a00:	74 07                	je     2a09 <ahci_allocate_command_table_pool+0x123>
    2a02:	b8 01 00 00 00       	mov    eax,0x1
    2a07:	eb 05                	jmp    2a0e <ahci_allocate_command_table_pool+0x128>
    2a09:	b8 00 00 00 00       	mov    eax,0x0
    2a0e:	48 8d 14 08          	lea    rdx,[rax+rcx*1]
    2a12:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2a16:	48 0f af c2          	imul   rax,rdx
    2a1a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    2a1e:	eb 3b                	jmp    2a5b <ahci_allocate_command_table_pool+0x175>
		} else {
				pg_ct = rdiv(byte_ct, 4096);
    2a20:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a24:	48 c1 e8 0c          	shr    rax,0xc
    2a28:	48 89 c2             	mov    rdx,rax
    2a2b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a2f:	25 ff 0f 00 00       	and    eax,0xfff
    2a34:	48 85 c0             	test   rax,rax
    2a37:	74 07                	je     2a40 <ahci_allocate_command_table_pool+0x15a>
    2a39:	b8 01 00 00 00       	mov    eax,0x1
    2a3e:	eb 05                	jmp    2a45 <ahci_allocate_command_table_pool+0x15f>
    2a40:	b8 00 00 00 00       	mov    eax,0x0
    2a45:	48 01 d0             	add    rax,rdx
    2a48:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				epa = ct;
    2a4c:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    2a4f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				pg_pe = pg_ct;
    2a53:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2a57:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		}

		/* allocate the physical memory */
		while (pg_ct) {
    2a5b:	e9 95 01 00 00       	jmp    2bf5 <ahci_allocate_command_table_pool+0x30f>
				void* ptr; size_t epa2 = epa, rem;
    2a60:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2a64:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				mm_alloc_pm_flg(pg_pe, &pr, 1, flg);
    2a68:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2a6c:	89 c7                	mov    edi,eax
    2a6e:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2a71:	48 8d 45 90          	lea    rax,[rbp-0x70]
    2a75:	89 d1                	mov    ecx,edx
    2a77:	ba 01 00 00 00       	mov    edx,0x1
    2a7c:	48 89 c6             	mov    rsi,rax
    2a7f:	e8 00 00 00 00       	call   2a84 <ahci_allocate_command_table_pool+0x19e>
				if (pr.count != pg_pe)
    2a84:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2a88:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    2a8c:	74 30                	je     2abe <ahci_allocate_command_table_pool+0x1d8>
						die("Out of contiguous memory\n");
    2a8e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2a95:	bf 0c 00 00 00       	mov    edi,0xc
    2a9a:	b8 00 00 00 00       	mov    eax,0x0
    2a9f:	e8 00 00 00 00       	call   2aa4 <ahci_allocate_command_table_pool+0x1be>
    2aa4:	b8 00 00 00 00       	mov    eax,0x0
    2aa9:	e8 00 00 00 00       	call   2aae <ahci_allocate_command_table_pool+0x1c8>
    2aae:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ab5:	e8 00 00 00 00       	call   2aba <ahci_allocate_command_table_pool+0x1d4>
    2aba:	fa                   	cli
    2abb:	f4                   	hlt
    2abc:	eb fd                	jmp    2abb <ahci_allocate_command_table_pool+0x1d5>
				rem = pg_pe * 4096;
    2abe:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2ac2:	48 c1 e0 0c          	shl    rax,0xc
    2ac6:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				/* pg_pe zeroed contiguous memory at pr.base */
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL |
    2aca:	48 8d 45 90          	lea    rax,[rbp-0x70]
    2ace:	41 b8 2c 00 00 00    	mov    r8d,0x2c
    2ad4:	b9 01 00 00 00       	mov    ecx,0x1
    2ad9:	48 89 c2             	mov    rdx,rax
    2adc:	be 00 00 00 00       	mov    esi,0x0
    2ae1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ae8:	e8 00 00 00 00       	call   2aed <ahci_allocate_command_table_pool+0x207>
    2aed:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						MMGR_MAP_WRITE | MMGR_MAP_NO_CACHING);
				if (!ptr)
    2af1:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    2af6:	0f 85 dc 00 00 00    	jne    2bd8 <ahci_allocate_command_table_pool+0x2f2>
						die("mmap not working\n");
    2afc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2b03:	bf 0c 00 00 00       	mov    edi,0xc
    2b08:	b8 00 00 00 00       	mov    eax,0x0
    2b0d:	e8 00 00 00 00       	call   2b12 <ahci_allocate_command_table_pool+0x22c>
    2b12:	b8 00 00 00 00       	mov    eax,0x0
    2b17:	e8 00 00 00 00       	call   2b1c <ahci_allocate_command_table_pool+0x236>
    2b1c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2b23:	e8 00 00 00 00       	call   2b28 <ahci_allocate_command_table_pool+0x242>
    2b28:	fa                   	cli
    2b29:	f4                   	hlt
    2b2a:	eb fd                	jmp    2b29 <ahci_allocate_command_table_pool+0x243>

				/* assign the entries */
				while (epa2--) {
						rv->tables[i].pmem = pr.base;
    2b2c:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    2b30:	48 8b 75 b8          	mov    rsi,QWORD PTR [rbp-0x48]
    2b34:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2b37:	48 89 d0             	mov    rax,rdx
    2b3a:	48 01 c0             	add    rax,rax
    2b3d:	48 01 d0             	add    rax,rdx
    2b40:	48 c1 e0 03          	shl    rax,0x3
    2b44:	48 01 f0             	add    rax,rsi
    2b47:	48 83 c0 28          	add    rax,0x28
    2b4b:	48 89 08             	mov    QWORD PTR [rax],rcx
						rv->tables[i++].ptr = ptr;
    2b4e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2b51:	8d 50 01             	lea    edx,[rax+0x1]
    2b54:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    2b57:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    2b5b:	89 c1                	mov    ecx,eax
    2b5d:	48 89 c8             	mov    rax,rcx
    2b60:	48 01 c0             	add    rax,rax
    2b63:	48 01 c8             	add    rax,rcx
    2b66:	48 c1 e0 03          	shl    rax,0x3
    2b6a:	48 01 d0             	add    rax,rdx
    2b6d:	48 8d 50 20          	lea    rdx,[rax+0x20]
    2b71:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2b75:	48 89 02             	mov    QWORD PTR [rdx],rax
						/* advance */
						pr.base += indiv_ct;
    2b78:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    2b7c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2b80:	48 01 d0             	add    rax,rdx
    2b83:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
						ptr += indiv_ct;
    2b87:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2b8b:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
						rem -= indiv_ct;
    2b8f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2b93:	48 29 45 c0          	sub    QWORD PTR [rbp-0x40],rax
						if (rem < indiv_ct && epa2 > 1)
    2b97:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2b9b:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
    2b9f:	73 37                	jae    2bd8 <ahci_allocate_command_table_pool+0x2f2>
    2ba1:	48 83 7d c8 01       	cmp    QWORD PTR [rbp-0x38],0x1
    2ba6:	76 30                	jbe    2bd8 <ahci_allocate_command_table_pool+0x2f2>
								die("algo error\n");
    2ba8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2baf:	bf 0c 00 00 00       	mov    edi,0xc
    2bb4:	b8 00 00 00 00       	mov    eax,0x0
    2bb9:	e8 00 00 00 00       	call   2bbe <ahci_allocate_command_table_pool+0x2d8>
    2bbe:	b8 00 00 00 00       	mov    eax,0x0
    2bc3:	e8 00 00 00 00       	call   2bc8 <ahci_allocate_command_table_pool+0x2e2>
    2bc8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bcf:	e8 00 00 00 00       	call   2bd4 <ahci_allocate_command_table_pool+0x2ee>
    2bd4:	fa                   	cli
    2bd5:	f4                   	hlt
    2bd6:	eb fd                	jmp    2bd5 <ahci_allocate_command_table_pool+0x2ef>
				while (epa2--) {
    2bd8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2bdc:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2be0:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    2be4:	48 85 c0             	test   rax,rax
    2be7:	0f 85 3f ff ff ff    	jne    2b2c <ahci_allocate_command_table_pool+0x246>
				}
				pg_ct -= pg_pe;
    2bed:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2bf1:	48 29 45 e8          	sub    QWORD PTR [rbp-0x18],rax
		while (pg_ct) {
    2bf5:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2bfa:	0f 85 60 fe ff ff    	jne    2a60 <ahci_allocate_command_table_pool+0x17a>
		}

		/* assign the other values */
		rv->prdt_cap = prdt_cap;
    2c00:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2c04:	8b 55 88             	mov    edx,DWORD PTR [rbp-0x78]
    2c07:	89 10                	mov    DWORD PTR [rax],edx
		rv->next = NULL;
    2c09:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2c0d:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		rv->mask = 0xffffffff << prdt_cap;
    2c15:	8b 45 88             	mov    eax,DWORD PTR [rbp-0x78]
    2c18:	ba ff ff ff ff       	mov    edx,0xffffffff
    2c1d:	89 c1                	mov    ecx,eax
    2c1f:	d3 e2                	shl    edx,cl
    2c21:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2c25:	89 50 10             	mov    DWORD PTR [rax+0x10],edx

		/* print it */
		for (i = 0; i < ct; i++)
    2c28:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    2c2f:	eb 57                	jmp    2c88 <ahci_allocate_command_table_pool+0x3a2>
				printf("%016llx %p\n", rv->tables[i].pmem, rv->tables[i].ptr);
    2c31:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    2c35:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2c38:	48 89 d0             	mov    rax,rdx
    2c3b:	48 01 c0             	add    rax,rax
    2c3e:	48 01 d0             	add    rax,rdx
    2c41:	48 c1 e0 03          	shl    rax,0x3
    2c45:	48 01 c8             	add    rax,rcx
    2c48:	48 83 c0 20          	add    rax,0x20
    2c4c:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    2c4f:	48 8b 75 b8          	mov    rsi,QWORD PTR [rbp-0x48]
    2c53:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    2c56:	48 89 d0             	mov    rax,rdx
    2c59:	48 01 c0             	add    rax,rax
    2c5c:	48 01 d0             	add    rax,rdx
    2c5f:	48 c1 e0 03          	shl    rax,0x3
    2c63:	48 01 f0             	add    rax,rsi
    2c66:	48 83 c0 28          	add    rax,0x28
    2c6a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2c6d:	48 89 ca             	mov    rdx,rcx
    2c70:	48 89 c6             	mov    rsi,rax
    2c73:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c7a:	b8 00 00 00 00       	mov    eax,0x0
    2c7f:	e8 00 00 00 00       	call   2c84 <ahci_allocate_command_table_pool+0x39e>
		for (i = 0; i < ct; i++)
    2c84:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    2c88:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2c8b:	3b 45 8c             	cmp    eax,DWORD PTR [rbp-0x74]
    2c8e:	72 a1                	jb     2c31 <ahci_allocate_command_table_pool+0x34b>

		return rv;
    2c90:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
}
    2c94:	c9                   	leave
    2c95:	c3                   	ret

0000000000002c96 <ahci_reissue_command>:

void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc)
{
    2c96:	55                   	push   rbp
    2c97:	48 89 e5             	mov    rbp,rsp
    2c9a:	48 83 ec 10          	sub    rsp,0x10
    2c9e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    2ca2:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		iprintf("  REISSUE: %d %u\n", cc->port, cc->c);
    2ca6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2caa:	8b 50 18             	mov    edx,DWORD PTR [rax+0x18]
    2cad:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2cb1:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2cb5:	0f b7 c0             	movzx  eax,ax
    2cb8:	89 c6                	mov    esi,eax
    2cba:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2cc1:	b8 00 00 00 00       	mov    eax,0x0
    2cc6:	e8 00 00 00 00       	call   2ccb <ahci_reissue_command+0x35>
		if (cc->status)
    2ccb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2ccf:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2cd3:	48 85 c0             	test   rax,rax
    2cd6:	74 0e                	je     2ce6 <ahci_reissue_command+0x50>
				cc->status->state = cmd_state_pending;
    2cd8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2cdc:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2ce0:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
						ad->pending_cmds[cc->port].next, cc->port);
    2ce6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2cea:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    2cee:	0f b7 c8             	movzx  ecx,ax
						ad->pending_cmds[cc->port].next, cc->port);
    2cf1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2cf5:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2cf9:	0f b7 c0             	movzx  eax,ax
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    2cfc:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    2d00:	48 63 d0             	movsxd rdx,eax
    2d03:	48 89 d0             	mov    rax,rdx
    2d06:	48 01 c0             	add    rax,rax
    2d09:	48 01 d0             	add    rax,rdx
    2d0c:	48 c1 e0 03          	shl    rax,0x3
    2d10:	48 01 f0             	add    rax,rsi
    2d13:	48 05 28 05 00 00    	add    rax,0x528
    2d19:	48 8b 30             	mov    rsi,QWORD PTR [rax]
    2d1c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d20:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2d24:	0f b7 c0             	movzx  eax,ax
    2d27:	48 8b 7d f8          	mov    rdi,QWORD PTR [rbp-0x8]
    2d2b:	48 63 d0             	movsxd rdx,eax
    2d2e:	48 89 d0             	mov    rax,rdx
    2d31:	48 01 c0             	add    rax,rax
    2d34:	48 01 d0             	add    rax,rdx
    2d37:	48 c1 e0 03          	shl    rax,0x3
    2d3b:	48 01 f8             	add    rax,rdi
    2d3e:	48 05 20 05 00 00    	add    rax,0x520
    2d44:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d47:	48 89 f2             	mov    rdx,rsi
    2d4a:	48 89 c6             	mov    rsi,rax
    2d4d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2d54:	b8 00 00 00 00       	mov    eax,0x0
    2d59:	e8 00 00 00 00       	call   2d5e <ahci_reissue_command+0xc8>
		list_add_tail(&cc->lst, &ad->pending_cmds[cc->port]);
    2d5e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d62:	0f b7 40 50          	movzx  eax,WORD PTR [rax+0x50]
    2d66:	0f b7 c0             	movzx  eax,ax
    2d69:	48 63 d0             	movsxd rdx,eax
    2d6c:	48 89 d0             	mov    rax,rdx
    2d6f:	48 01 c0             	add    rax,rax
    2d72:	48 01 d0             	add    rax,rdx
    2d75:	48 c1 e0 03          	shl    rax,0x3
    2d79:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    2d80:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2d84:	48 01 c2             	add    rdx,rax
    2d87:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d8b:	48 89 d6             	mov    rsi,rdx
    2d8e:	48 89 c7             	mov    rdi,rax
    2d91:	e8 88 d3 ff ff       	call   11e <list_add_tail>
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    2d96:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2d9a:	48 05 20 0b 00 00    	add    rax,0xb20
    2da0:	ba 01 00 00 00       	mov    edx,0x1
    2da5:	f0 0f c1 10          	lock xadd DWORD PTR [rax],edx
    2da9:	85 d2                	test   edx,edx
    2dab:	75 12                	jne    2dbf <ahci_reissue_command+0x129>
				/* wake worker */
				wake_up_external_event(&ad->wh);
    2dad:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2db1:	48 05 40 0b 00 00    	add    rax,0xb40
    2db7:	48 89 c7             	mov    rdi,rax
    2dba:	e8 00 00 00 00       	call   2dbf <ahci_reissue_command+0x129>
		}
}
    2dbf:	90                   	nop
    2dc0:	c9                   	leave
    2dc1:	c3                   	ret

0000000000002dc2 <ahci_issue_command>:

void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st)
{
    2dc2:	55                   	push   rbp
    2dc3:	48 89 e5             	mov    rbp,rsp
    2dc6:	48 83 ec 40          	sub    rsp,0x40
    2dca:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    2dce:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    2dd1:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
    2dd4:	89 4d dc             	mov    DWORD PTR [rbp-0x24],ecx
    2dd7:	4c 89 45 d0          	mov    QWORD PTR [rbp-0x30],r8
    2ddb:	4c 89 4d c8          	mov    QWORD PTR [rbp-0x38],r9
		iprintf("  ISSUE: %d %u\n", port, cmd);
    2ddf:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2de2:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    2de5:	89 c6                	mov    esi,eax
    2de7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dee:	b8 00 00 00 00       	mov    eax,0x0
    2df3:	e8 00 00 00 00       	call   2df8 <ahci_issue_command+0x36>
		struct cmd_ctx* cc = ahci_allocate_context(ad);
    2df8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2dfc:	48 89 c7             	mov    rdi,rax
    2dff:	e8 00 00 00 00       	call   2e04 <ahci_issue_command+0x42>
    2e04:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		cc->c = cmd;
    2e08:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e0c:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2e0f:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
		cc->lba = lba;
    2e12:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e16:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2e1a:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		cc->ct = ct;
    2e1e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e22:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2e26:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
		cc->ptr = ptr;
    2e2a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e2e:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10]
    2e32:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		cc->wq_wake = wq_h;
    2e36:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e3a:	48 8b 55 18          	mov    rdx,QWORD PTR [rbp+0x18]
    2e3e:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		cc->pmprt = pmprt;
    2e42:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    2e45:	89 c2                	mov    edx,eax
    2e47:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e4b:	66 89 50 38          	mov    WORD PTR [rax+0x38],dx
		cc->port = port;
    2e4f:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    2e52:	89 c2                	mov    edx,eax
    2e54:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e58:	66 89 50 50          	mov    WORD PTR [rax+0x50],dx
		cc->status = st;
    2e5c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2e60:	48 8b 55 20          	mov    rdx,QWORD PTR [rbp+0x20]
    2e64:	48 89 50 48          	mov    QWORD PTR [rax+0x48],rdx
		if (st) {
    2e68:	48 83 7d 20 00       	cmp    QWORD PTR [rbp+0x20],0x0
    2e6d:	74 1b                	je     2e8a <ahci_issue_command+0xc8>
				bzero(st, sizeof(*st));
    2e6f:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
    2e73:	be 18 00 00 00       	mov    esi,0x18
    2e78:	48 89 c7             	mov    rdi,rax
    2e7b:	e8 00 00 00 00       	call   2e80 <ahci_issue_command+0xbe>
				st->state = cmd_state_pending;
    2e80:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
    2e84:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		}
		list_add_tail(&cc->lst, &ad->pending_cmds[port]);
    2e8a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    2e8d:	48 63 d0             	movsxd rdx,eax
    2e90:	48 89 d0             	mov    rax,rdx
    2e93:	48 01 c0             	add    rax,rax
    2e96:	48 01 d0             	add    rax,rdx
    2e99:	48 c1 e0 03          	shl    rax,0x3
    2e9d:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    2ea4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ea8:	48 01 c2             	add    rdx,rax
    2eab:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2eaf:	48 89 d6             	mov    rsi,rdx
    2eb2:	48 89 c7             	mov    rdi,rax
    2eb5:	e8 64 d2 ff ff       	call   11e <list_add_tail>
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    2eba:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ebe:	48 05 20 0b 00 00    	add    rax,0xb20
    2ec4:	ba 01 00 00 00       	mov    edx,0x1
    2ec9:	f0 0f c1 10          	lock xadd DWORD PTR [rax],edx
    2ecd:	85 d2                	test   edx,edx
    2ecf:	75 12                	jne    2ee3 <ahci_issue_command+0x121>
				/*  wake worker */
				wake_up_external_event(&ad->wh);
    2ed1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ed5:	48 05 40 0b 00 00    	add    rax,0xb40
    2edb:	48 89 c7             	mov    rdi,rax
    2ede:	e8 00 00 00 00       	call   2ee3 <ahci_issue_command+0x121>
		}
}
    2ee3:	90                   	nop
    2ee4:	c9                   	leave
    2ee5:	c3                   	ret

0000000000002ee6 <ahci_do_bohc>:

int ahci_do_bohc(struct ahci_device* ad)
{
    2ee6:	55                   	push   rbp
    2ee7:	48 89 e5             	mov    rbp,rsp
    2eea:	48 83 ec 20          	sub    rsp,0x20
    2eee:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct ahci_hba* hba = ad->ptr;
    2ef2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ef6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2efa:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (hba->cap2.boh) {
    2efe:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f02:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    2f05:	83 e0 01             	and    eax,0x1
    2f08:	84 c0                	test   al,al
    2f0a:	0f 84 be 00 00 00    	je     2fce <ahci_do_bohc+0xe8>
				abprintf("performing AHCI BIOS handover...\n");
    2f10:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2f17:	b8 00 00 00 00       	mov    eax,0x0
    2f1c:	e8 00 00 00 00       	call   2f21 <ahci_do_bohc+0x3b>
				preempt_disable();
    2f21:	b8 00 00 00 00       	mov    eax,0x0
    2f26:	e8 00 00 00 00       	call   2f2b <ahci_do_bohc+0x45>
    2f2b:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    2f2e:	83 c2 01             	add    edx,0x1
    2f31:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				hba->bohc |= BOHC_OOS;
    2f34:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f38:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f3b:	83 c8 02             	or     eax,0x2
    2f3e:	89 c2                	mov    edx,eax
    2f40:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f44:	89 50 28             	mov    DWORD PTR [rax+0x28],edx
				/* SMI is issued */
				if (hba->bohc & BOHC_BOS) { /* we have to wait */
    2f47:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f4b:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f4e:	83 e0 01             	and    eax,0x1
    2f51:	85 c0                	test   eax,eax
    2f53:	74 49                	je     2f9e <ahci_do_bohc+0xb8>
						mdelay(25);
    2f55:	bf 19 00 00 00       	mov    edi,0x19
    2f5a:	e8 00 00 00 00       	call   2f5f <ahci_do_bohc+0x79>
						if (hba->bohc & BOHC_BB) { /* BIOS does it */
    2f5f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f63:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f66:	83 e0 10             	and    eax,0x10
    2f69:	85 c0                	test   eax,eax
    2f6b:	74 31                	je     2f9e <ahci_do_bohc+0xb8>
								int to = 30;
    2f6d:	c7 45 fc 1e 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1e
								while (hba->bohc & BOHC_BOS) {
    2f74:	eb 17                	jmp    2f8d <ahci_do_bohc+0xa7>
										mdelay(100);
    2f76:	bf 64 00 00 00       	mov    edi,0x64
    2f7b:	e8 00 00 00 00       	call   2f80 <ahci_do_bohc+0x9a>
										if (!to--) /* abort after 3 seconds */
    2f80:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2f83:	8d 50 ff             	lea    edx,[rax-0x1]
    2f86:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    2f89:	85 c0                	test   eax,eax
    2f8b:	74 10                	je     2f9d <ahci_do_bohc+0xb7>
								while (hba->bohc & BOHC_BOS) {
    2f8d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2f91:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2f94:	83 e0 01             	and    eax,0x1
    2f97:	85 c0                	test   eax,eax
    2f99:	75 db                	jne    2f76 <ahci_do_bohc+0x90>
    2f9b:	eb 01                	jmp    2f9e <ahci_do_bohc+0xb8>
												break;
    2f9d:	90                   	nop
								}
						} else {;} /* we have to clean up */
				}
				/* we're done */
				preempt_enable();
    2f9e:	b8 00 00 00 00       	mov    eax,0x0
    2fa3:	e8 00 00 00 00       	call   2fa8 <ahci_do_bohc+0xc2>
    2fa8:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    2fab:	83 ea 01             	sub    edx,0x1
    2fae:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    2fb1:	b8 00 00 00 00       	mov    eax,0x0
    2fb6:	e8 00 00 00 00       	call   2fbb <ahci_do_bohc+0xd5>
    2fbb:	8b 00                	mov    eax,DWORD PTR [rax]
    2fbd:	83 e0 01             	and    eax,0x1
    2fc0:	85 c0                	test   eax,eax
    2fc2:	74 0a                	je     2fce <ahci_do_bohc+0xe8>
    2fc4:	b8 00 00 00 00       	mov    eax,0x0
    2fc9:	e8 00 00 00 00       	call   2fce <ahci_do_bohc+0xe8>
		}
		/* always acquire (we're only nice to inform the bios) */
		return 0;
    2fce:	b8 00 00 00 00       	mov    eax,0x0
}
    2fd3:	c9                   	leave
    2fd4:	c3                   	ret

0000000000002fd5 <ahci_reset_port>:

void ahci_reset_port(struct ahci_hba* h, struct ahci_port* p)
{
    2fd5:	55                   	push   rbp
    2fd6:	48 89 e5             	mov    rbp,rsp
    2fd9:	48 83 ec 10          	sub    rsp,0x10
    2fdd:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    2fe1:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		/* cap.sclo? */
		die("not impl %p %p\n", h, p);
    2fe5:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2fe9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2fed:	48 89 d1             	mov    rcx,rdx
    2ff0:	48 89 c2             	mov    rdx,rax
    2ff3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ffa:	bf 0c 00 00 00       	mov    edi,0xc
    2fff:	b8 00 00 00 00       	mov    eax,0x0
    3004:	e8 00 00 00 00       	call   3009 <ahci_reset_port+0x34>
    3009:	b8 00 00 00 00       	mov    eax,0x0
    300e:	e8 00 00 00 00       	call   3013 <ahci_reset_port+0x3e>
    3013:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    301a:	e8 00 00 00 00       	call   301f <ahci_reset_port+0x4a>
    301f:	fa                   	cli
    3020:	f4                   	hlt
    3021:	eb fd                	jmp    3020 <ahci_reset_port+0x4b>

0000000000003023 <ahci_port_activate_device>:
}

void ahci_port_activate_device(struct ahci_hba* h, struct ahci_port* p)
{
    3023:	55                   	push   rbp
    3024:	48 89 e5             	mov    rbp,rsp
    3027:	48 83 ec 20          	sub    rsp,0x20
    302b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    302f:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		abprintf("activate port %zd:\n", p - h->port);
    3033:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3037:	48 05 00 01 00 00    	add    rax,0x100
    303d:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3041:	48 29 c2             	sub    rdx,rax
    3044:	48 89 d0             	mov    rax,rdx
    3047:	48 c1 f8 07          	sar    rax,0x7
    304b:	48 89 c6             	mov    rsi,rax
    304e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3055:	b8 00 00 00 00       	mov    eax,0x0
    305a:	e8 00 00 00 00       	call   305f <ahci_port_activate_device+0x3c>
		/* first check the presence flag */
		if (p->scr0.det == DET_NOT_PRESENT) {
    305f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3063:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3066:	83 e0 0f             	and    eax,0xf
    3069:	84 c0                	test   al,al
    306b:	0f 85 09 02 00 00    	jne    327a <ahci_port_activate_device+0x257>
				abprintf("activate: DET_NOT_PRESENT\n");
    3071:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3078:	b8 00 00 00 00       	mov    eax,0x0
    307d:	e8 00 00 00 00       	call   3082 <ahci_port_activate_device+0x5f>
				/* nothing attached? */
				if (p->cmd.cpd) { /* we rely on CPD */
    3082:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3086:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3089:	c1 e8 14             	shr    eax,0x14
    308c:	83 e0 01             	and    eax,0x1
    308f:	84 c0                	test   al,al
    3091:	74 61                	je     30f4 <ahci_port_activate_device+0xd1>
						if (!p->cmd.cps) {
    3093:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3097:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    309a:	c1 e8 10             	shr    eax,0x10
    309d:	83 e0 01             	and    eax,0x1
    30a0:	84 c0                	test   al,al
    30a2:	75 16                	jne    30ba <ahci_port_activate_device+0x97>
								abprintf("confirmed by CPD\n");
    30a4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    30ab:	b8 00 00 00 00       	mov    eax,0x0
    30b0:	e8 00 00 00 00       	call   30b5 <ahci_port_activate_device+0x92>
								return;
    30b5:	e9 b2 03 00 00       	jmp    346c <ahci_port_activate_device+0x449>
						}
						/* there's something */
						if (!p->cmd.pod) {
    30ba:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    30be:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    30c1:	c1 e8 02             	shr    eax,0x2
    30c4:	83 e0 01             	and    eax,0x1
    30c7:	84 c0                	test   al,al
    30c9:	75 17                	jne    30e2 <ahci_port_activate_device+0xbf>
								p->cmd.pod = 1; /* power it */
    30cb:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    30cf:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    30d2:	83 c8 04             	or     eax,0x4
    30d5:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
								ndelay(20);
    30d8:	bf 14 00 00 00       	mov    edi,0x14
    30dd:	e8 00 00 00 00       	call   30e2 <ahci_port_activate_device+0xbf>
						}
						if (p->scr0.det != DET_NOT_PRESENT)
    30e2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    30e6:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    30e9:	83 e0 0f             	and    eax,0xf
    30ec:	84 c0                	test   al,al
    30ee:	0f 85 89 01 00 00    	jne    327d <ahci_port_activate_device+0x25a>
								goto next_step;
				}
				/* spin-up? */
				if (!p->cmd.sud) { /* always !1 if cap.sss == 0 */
    30f4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    30f8:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    30fb:	d1 e8                	shr    eax,1
    30fd:	83 e0 01             	and    eax,0x1
    3100:	84 c0                	test   al,al
    3102:	0f 85 f4 00 00 00    	jne    31fc <ahci_port_activate_device+0x1d9>
						abprintf("not spun-up yet?\n");
    3108:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    310f:	b8 00 00 00 00       	mov    eax,0x0
    3114:	e8 00 00 00 00       	call   3119 <ahci_port_activate_device+0xf6>
						if (p->pXserr & (1 << 26)) /* eXchange bit */
    3119:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    311d:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3120:	25 00 00 00 04       	and    eax,0x4000000
    3125:	85 c0                	test   eax,eax
    3127:	74 15                	je     313e <ahci_port_activate_device+0x11b>
								p->pXserr |= (1 << 26); /* RWC */
    3129:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    312d:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3130:	0d 00 00 00 04       	or     eax,0x4000000
    3135:	89 c2                	mov    edx,eax
    3137:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    313b:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
						if (p->scr2.det != 0) { /* set to 0 prior sud */
    313e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3142:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    3145:	c1 e8 1c             	shr    eax,0x1c
    3148:	84 c0                	test   al,al
    314a:	74 19                	je     3165 <ahci_port_activate_device+0x142>
								p->scr2.det = 0;
    314c:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3150:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    3153:	25 ff ff ff 0f       	and    eax,0xfffffff
    3158:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
								ndelay(20);
    315b:	bf 14 00 00 00       	mov    edi,0x14
    3160:	e8 00 00 00 00       	call   3165 <ahci_port_activate_device+0x142>
						}
						p->cmd.sud = 1;
    3165:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3169:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    316c:	83 c8 02             	or     eax,0x2
    316f:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						udelay(50); /* wait 50 mus */
    3172:	bf 32 00 00 00       	mov    edi,0x32
    3177:	e8 00 00 00 00       	call   317c <ahci_port_activate_device+0x159>
						if (p->pXserr & ((1 << 26) | (1 << 18))) { /* received sth. */
    317c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3180:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3183:	25 00 00 04 04       	and    eax,0x4040000
    3188:	85 c0                	test   eax,eax
    318a:	0f 85 f0 00 00 00    	jne    3280 <ahci_port_activate_device+0x25d>
								/* COMRESET, COMWAKE */
								goto next_step;
						}
						/* send the reset */
						p->scr2.det = 1;
    3190:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3194:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    3197:	25 ff ff ff 0f       	and    eax,0xfffffff
    319c:	0d 00 00 00 10       	or     eax,0x10000000
    31a1:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
						mdelay(1);
    31a4:	bf 01 00 00 00       	mov    edi,0x1
    31a9:	e8 00 00 00 00       	call   31ae <ahci_port_activate_device+0x18b>
						p->scr2.det = 0;
    31ae:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    31b2:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    31b5:	25 ff ff ff 0f       	and    eax,0xfffffff
    31ba:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
						udelay(50);
    31bd:	bf 32 00 00 00       	mov    edi,0x32
    31c2:	e8 00 00 00 00       	call   31c7 <ahci_port_activate_device+0x1a4>
						if (p->scr0.det != DET_NOT_PRESENT)
    31c7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    31cb:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    31ce:	83 e0 0f             	and    eax,0xf
    31d1:	84 c0                	test   al,al
    31d3:	0f 85 aa 00 00 00    	jne    3283 <ahci_port_activate_device+0x260>
								goto next_step;
						p->cmd.sud = 0; /* we're done enter listening mode */
    31d9:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    31dd:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    31e0:	83 e0 fd             	and    eax,0xfffffffd
    31e3:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						abprintf("not present\n");
    31e6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    31ed:	b8 00 00 00 00       	mov    eax,0x0
    31f2:	e8 00 00 00 00       	call   31f7 <ahci_port_activate_device+0x1d4>
						goto exit;
    31f7:	e9 43 02 00 00       	jmp    343f <ahci_port_activate_device+0x41c>
				}
				/* just try ICC */
				if (p->scr0.ipm != 1) {
    31fc:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3200:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3203:	c1 e8 08             	shr    eax,0x8
    3206:	83 e0 0f             	and    eax,0xf
    3209:	3c 01                	cmp    al,0x1
    320b:	74 6d                	je     327a <ahci_port_activate_device+0x257>
						abprintf("IPM != ACTIVE\n");
    320d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3214:	b8 00 00 00 00       	mov    eax,0x0
    3219:	e8 00 00 00 00       	call   321e <ahci_port_activate_device+0x1fb>
						int ct = 50;
    321e:	c7 45 fc 32 00 00 00 	mov    DWORD PTR [rbp-0x4],0x32
						while (p->cmd.icc && ct--)
    3225:	eb 0a                	jmp    3231 <ahci_port_activate_device+0x20e>
								udelay(10);
    3227:	bf 0a 00 00 00       	mov    edi,0xa
    322c:	e8 00 00 00 00       	call   3231 <ahci_port_activate_device+0x20e>
						while (p->cmd.icc && ct--)
    3231:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3235:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3238:	c1 e8 1c             	shr    eax,0x1c
    323b:	84 c0                	test   al,al
    323d:	74 0d                	je     324c <ahci_port_activate_device+0x229>
    323f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3242:	8d 50 ff             	lea    edx,[rax-0x1]
    3245:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    3248:	85 c0                	test   eax,eax
    324a:	75 db                	jne    3227 <ahci_port_activate_device+0x204>
						p->cmd.icc = 1;
    324c:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3250:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3253:	25 ff ff ff 0f       	and    eax,0xfffffff
    3258:	0d 00 00 00 10       	or     eax,0x10000000
    325d:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
						mdelay(10);
    3260:	bf 0a 00 00 00       	mov    edi,0xa
    3265:	e8 00 00 00 00       	call   326a <ahci_port_activate_device+0x247>
						if (p->scr0.det != DET_NOT_PRESENT)
    326a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    326e:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3271:	83 e0 0f             	and    eax,0xf
    3274:	84 c0                	test   al,al
    3276:	74 0e                	je     3286 <ahci_port_activate_device+0x263>
								goto next_step;
    3278:	eb 22                	jmp    329c <ahci_port_activate_device+0x279>
						goto exit;
				}
		}

		/* det != 1*/
next_step:
    327a:	90                   	nop
    327b:	eb 1f                	jmp    329c <ahci_port_activate_device+0x279>
								goto next_step;
    327d:	90                   	nop
    327e:	eb 1c                	jmp    329c <ahci_port_activate_device+0x279>
								goto next_step;
    3280:	90                   	nop
    3281:	eb 19                	jmp    329c <ahci_port_activate_device+0x279>
								goto next_step;
    3283:	90                   	nop
    3284:	eb 16                	jmp    329c <ahci_port_activate_device+0x279>
						abprintf("unable to set to active\n");
    3286:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    328d:	b8 00 00 00 00       	mov    eax,0x0
    3292:	e8 00 00 00 00       	call   3297 <ahci_port_activate_device+0x274>
						goto exit;
    3297:	e9 a3 01 00 00       	jmp    343f <ahci_port_activate_device+0x41c>
		if (p->scr0.det == DET_PRESENT) {
    329c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    32a0:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    32a3:	83 e0 0f             	and    eax,0xf
    32a6:	3c 03                	cmp    al,0x3
    32a8:	0f 85 48 01 00 00    	jne    33f6 <ahci_port_activate_device+0x3d3>
				/* almost done */
				if (p->scr0.ipm != IPM_ACTIVE) {
    32ae:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    32b2:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    32b5:	c1 e8 08             	shr    eax,0x8
    32b8:	83 e0 0f             	and    eax,0xf
    32bb:	3c 01                	cmp    al,0x1
    32bd:	0f 84 b1 00 00 00    	je     3374 <ahci_port_activate_device+0x351>
						int ct, wc;
						abprintf("Present but not active.\n");
    32c3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    32ca:	b8 00 00 00 00       	mov    eax,0x0
    32cf:	e8 00 00 00 00       	call   32d4 <ahci_port_activate_device+0x2b1>
activ:
						ct = 50, wc = 0;
    32d4:	c7 45 f8 32 00 00 00 	mov    DWORD PTR [rbp-0x8],0x32
    32db:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
rewait:
						while (p->cmd.icc && ct--) /* 500ms */
    32e2:	eb 0a                	jmp    32ee <ahci_port_activate_device+0x2cb>
								mdelay(10);
    32e4:	bf 0a 00 00 00       	mov    edi,0xa
    32e9:	e8 00 00 00 00       	call   32ee <ahci_port_activate_device+0x2cb>
						while (p->cmd.icc && ct--) /* 500ms */
    32ee:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    32f2:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    32f5:	c1 e8 1c             	shr    eax,0x1c
    32f8:	84 c0                	test   al,al
    32fa:	74 0d                	je     3309 <ahci_port_activate_device+0x2e6>
    32fc:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    32ff:	8d 50 ff             	lea    edx,[rax-0x1]
    3302:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
    3305:	85 c0                	test   eax,eax
    3307:	75 db                	jne    32e4 <ahci_port_activate_device+0x2c1>
						if (p->scr0.ipm != IPM_ACTIVE && !wc) {
    3309:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    330d:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3310:	c1 e8 08             	shr    eax,0x8
    3313:	83 e0 0f             	and    eax,0xf
    3316:	3c 01                	cmp    al,0x1
    3318:	74 31                	je     334b <ahci_port_activate_device+0x328>
    331a:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    331e:	75 2b                	jne    334b <ahci_port_activate_device+0x328>
								p->cmd.icc = 1;
    3320:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3324:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3327:	25 ff ff ff 0f       	and    eax,0xfffffff
    332c:	0d 00 00 00 10       	or     eax,0x10000000
    3331:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
								ndelay(50);
    3334:	bf 32 00 00 00       	mov    edi,0x32
    3339:	e8 00 00 00 00       	call   333e <ahci_port_activate_device+0x31b>
								wc++; ct = 50;
    333e:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    3342:	c7 45 f8 32 00 00 00 	mov    DWORD PTR [rbp-0x8],0x32
								goto rewait;
    3349:	eb 97                	jmp    32e2 <ahci_port_activate_device+0x2bf>
						}
						if (wc) {
    334b:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    334f:	74 23                	je     3374 <ahci_port_activate_device+0x351>
								/* reset */
								p->scr2.det = 1;
    3351:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3355:	8b 42 2c             	mov    eax,DWORD PTR [rdx+0x2c]
    3358:	25 ff ff ff 0f       	and    eax,0xfffffff
    335d:	0d 00 00 00 10       	or     eax,0x10000000
    3362:	89 42 2c             	mov    DWORD PTR [rdx+0x2c],eax
								mdelay(1);
    3365:	bf 01 00 00 00       	mov    edi,0x1
    336a:	e8 00 00 00 00       	call   336f <ahci_port_activate_device+0x34c>
								goto next_step;
    336f:	e9 28 ff ff ff       	jmp    329c <ahci_port_activate_device+0x279>
						}
				}
				abprintf("Device at port %zd is active and present.\n",
						p - h->port);
    3374:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3378:	48 05 00 01 00 00    	add    rax,0x100
    337e:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3382:	48 29 c2             	sub    rdx,rax
				abprintf("Device at port %zd is active and present.\n",
    3385:	48 89 d0             	mov    rax,rdx
    3388:	48 c1 f8 07          	sar    rax,0x7
    338c:	48 89 c6             	mov    rsi,rax
    338f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3396:	b8 00 00 00 00       	mov    eax,0x0
    339b:	e8 00 00 00 00       	call   33a0 <ahci_port_activate_device+0x37d>
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    33a0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33a4:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    33a7:	c1 e8 08             	shr    eax,0x8
    33aa:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    33ad:	0f b6 f8             	movzx  edi,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    33b0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33b4:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    33b7:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    33ba:	0f b6 f0             	movzx  esi,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    33bd:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33c1:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    33c4:	0f b6 c4             	movzx  eax,ah
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    33c7:	0f b6 c8             	movzx  ecx,al
    33ca:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33ce:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    33d1:	0f b6 d0             	movzx  edx,al
    33d4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33d8:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    33db:	41 89 f9             	mov    r9d,edi
    33de:	41 89 f0             	mov    r8d,esi
    33e1:	89 c6                	mov    esi,eax
    33e3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    33ea:	b8 00 00 00 00       	mov    eax,0x0
    33ef:	e8 00 00 00 00       	call   33f4 <ahci_port_activate_device+0x3d1>
				return;
    33f4:	eb 76                	jmp    346c <ahci_port_activate_device+0x449>
		} else if (p->scr0.det == DET_PHY_OFFLINE) {
    33f6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    33fa:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    33fd:	83 e0 0f             	and    eax,0xf
    3400:	3c 04                	cmp    al,0x4
    3402:	75 16                	jne    341a <ahci_port_activate_device+0x3f7>
				/* just deactivated */
				abprintf("PHY offline mode\n");
    3404:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    340b:	b8 00 00 00 00       	mov    eax,0x0
    3410:	e8 00 00 00 00       	call   3415 <ahci_port_activate_device+0x3f2>
				goto activ;
    3415:	e9 ba fe ff ff       	jmp    32d4 <ahci_port_activate_device+0x2b1>
		} else if (p->scr0.det == DET_PRESENT_NO_PHY) {
    341a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    341e:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3421:	83 e0 0f             	and    eax,0xf
    3424:	3c 01                	cmp    al,0x1
    3426:	75 16                	jne    343e <ahci_port_activate_device+0x41b>
				abprintf("PRESENT_NO_PHY mode\n");
    3428:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    342f:	b8 00 00 00 00       	mov    eax,0x0
    3434:	e8 00 00 00 00       	call   3439 <ahci_port_activate_device+0x416>
				goto activ; /* try the same */
    3439:	e9 96 fe ff ff       	jmp    32d4 <ahci_port_activate_device+0x2b1>
		}
exit:
    343e:	90                   	nop
				/* we're really done */
				abprintf("Not present at port %zd\n", p - h->port);
    343f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3443:	48 05 00 01 00 00    	add    rax,0x100
    3449:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    344d:	48 29 c2             	sub    rdx,rax
    3450:	48 89 d0             	mov    rax,rdx
    3453:	48 c1 f8 07          	sar    rax,0x7
    3457:	48 89 c6             	mov    rsi,rax
    345a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3461:	b8 00 00 00 00       	mov    eax,0x0
    3466:	e8 00 00 00 00       	call   346b <ahci_port_activate_device+0x448>
				return;
    346b:	90                   	nop
}
    346c:	c9                   	leave
    346d:	c3                   	ret

000000000000346e <ahci_enable_port>:

void ahci_enable_port(struct ahci_device* ad, int pt)
{
    346e:	55                   	push   rbp
    346f:	48 89 e5             	mov    rbp,rsp
    3472:	48 83 ec 50          	sub    rsp,0x50
    3476:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    347a:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		struct ahci_port* p = &ad->ptr->port[pt];
    347d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3481:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3485:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    3488:	48 63 d2             	movsxd rdx,edx
    348b:	48 83 c2 02          	add    rdx,0x2
    348f:	48 c1 e2 07          	shl    rdx,0x7
    3493:	48 01 d0             	add    rax,rdx
    3496:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		int reset_ct = 0;
    349a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    34a1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    34a5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    34a9:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    34ac:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    34af:	be 01 00 00 00       	mov    esi,0x1
    34b4:	89 c1                	mov    ecx,eax
    34b6:	d3 e6                	shl    esi,cl
    34b8:	89 f0                	mov    eax,esi
    34ba:	21 d0                	and    eax,edx
    34bc:	85 c0                	test   eax,eax
    34be:	0f 84 71 02 00 00    	je     3735 <ahci_enable_port+0x2c7>
				return;

Pos1:
    34c4:	90                   	nop
		/* clear old data */
		p->pXserr = 0xffffffff; /* 10.1.2 -> 6. */
    34c5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34c9:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
		p->pXis = 0xffffffff; /* clear all pending interrupts */
    34d0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34d4:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [rax+0x10],0xffffffff

		/* first allow for the reception of FISes */
		p->cmd.fre = 1;
    34db:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    34df:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    34e2:	83 c8 10             	or     eax,0x10
    34e5:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		ndelay(20); /* wait for BSY to show up */
    34e8:	bf 14 00 00 00       	mov    edi,0x14
    34ed:	e8 00 00 00 00       	call   34f2 <ahci_enable_port+0x84>
		while (1) {
				uint8_t sts = p->tfd.sts;
    34f2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34f6:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    34f9:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
				if (sts & TFS_ERR) {
    34fc:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
    3500:	83 e0 01             	and    eax,0x1
    3503:	85 c0                	test   eax,eax
    3505:	0f 84 f1 00 00 00    	je     35fc <ahci_enable_port+0x18e>
						/* something went wrong! */
						if (sts == 0x7f) /* no device */
    350b:	80 7d ef 7f          	cmp    BYTE PTR [rbp-0x11],0x7f
    350f:	0f 84 03 01 00 00    	je     3618 <ahci_enable_port+0x1aa>
								break;
						else if (sts == 0x41 && p->tfd.err == 0x20) {
    3515:	80 7d ef 41          	cmp    BYTE PTR [rbp-0x11],0x41
    3519:	75 20                	jne    353b <ahci_enable_port+0xcd>
    351b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    351f:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3522:	0f b6 c4             	movzx  eax,ah
    3525:	3c 20                	cmp    al,0x20
    3527:	75 12                	jne    353b <ahci_enable_port+0xcd>
								if (p->pXsig == SIG_ATAPI)
    3529:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    352d:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    3530:	3d 01 01 14 eb       	cmp    eax,0xeb140101
    3535:	0f 84 e0 00 00 00    	je     361b <ahci_enable_port+0x1ad>
										break; /* no medium */
						}
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
								" while starting up.\n", pt, p->tfd.err);
    353b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    353f:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3542:	0f b6 c4             	movzx  eax,ah
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
    3545:	0f b6 d0             	movzx  edx,al
    3548:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    354b:	89 d1                	mov    ecx,edx
    354d:	89 c2                	mov    edx,eax
    354f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3556:	bf 0e 00 00 00       	mov    edi,0xe
    355b:	b8 00 00 00 00       	mov    eax,0x0
    3560:	e8 00 00 00 00       	call   3565 <ahci_enable_port+0xf7>
						abprintf("scr1: %x %x\n", p->scr1.diag, p->scr1.err);
    3565:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3569:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    356c:	0f b7 d0             	movzx  edx,ax
    356f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3573:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3576:	c1 e8 10             	shr    eax,0x10
    3579:	0f b7 c0             	movzx  eax,ax
    357c:	89 c6                	mov    esi,eax
    357e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3585:	b8 00 00 00 00       	mov    eax,0x0
    358a:	e8 00 00 00 00       	call   358f <ahci_enable_port+0x121>
						abprintf("tfd: %x %x\n", p->tfd.sts, p->tfd.err);
    358f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3593:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3596:	0f b6 c4             	movzx  eax,ah
    3599:	0f b6 d0             	movzx  edx,al
    359c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35a0:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    35a3:	0f b6 c0             	movzx  eax,al
    35a6:	89 c6                	mov    esi,eax
    35a8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35af:	b8 00 00 00 00       	mov    eax,0x0
    35b4:	e8 00 00 00 00       	call   35b9 <ahci_enable_port+0x14b>
						p->pXserr = 0xffffffff;
    35b9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35bd:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [rax+0x30],0xffffffff
						if (!reset_ct++) {
    35c4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    35c7:	8d 50 01             	lea    edx,[rax+0x1]
    35ca:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    35cd:	85 c0                	test   eax,eax
    35cf:	75 1c                	jne    35ed <ahci_enable_port+0x17f>
								ahci_port_activate_device(ad->ptr, p);
    35d1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    35d5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    35d9:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    35dd:	48 89 d6             	mov    rsi,rdx
    35e0:	48 89 c7             	mov    rdi,rax
    35e3:	e8 00 00 00 00       	call   35e8 <ahci_enable_port+0x17a>
								goto Pos1;
    35e8:	e9 d8 fe ff ff       	jmp    34c5 <ahci_enable_port+0x57>
						} else if (reset_ct == 1) {
    35ed:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
    35f1:	0f 85 14 01 00 00    	jne    370b <ahci_enable_port+0x29d>
								/*ahci_reset_port(ad->ptr, p);*/
								goto Pos1;
    35f7:	e9 c9 fe ff ff       	jmp    34c5 <ahci_enable_port+0x57>
						} else
								goto defer;
				}
				if (!(sts & (TFS_BSY | TFS_DRQ)))
    35fc:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
    3600:	25 88 00 00 00       	and    eax,0x88
    3605:	85 c0                	test   eax,eax
    3607:	74 15                	je     361e <ahci_enable_port+0x1b0>
						break;
				udelay(50);
    3609:	bf 32 00 00 00       	mov    edi,0x32
    360e:	e8 00 00 00 00       	call   3613 <ahci_enable_port+0x1a5>
		while (1) {
    3613:	e9 da fe ff ff       	jmp    34f2 <ahci_enable_port+0x84>
								break;
    3618:	90                   	nop
    3619:	eb 04                	jmp    361f <ahci_enable_port+0x1b1>
										break; /* no medium */
    361b:	90                   	nop
    361c:	eb 01                	jmp    361f <ahci_enable_port+0x1b1>
						break;
    361e:	90                   	nop
		}

		/* set ST only if BSY,DRQ and DET=3h or IPM=2,6,8 */
		if (p->scr0.det != 3)
    361f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3623:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3626:	83 e0 0f             	and    eax,0xf
    3629:	3c 03                	cmp    al,0x3
    362b:	74 17                	je     3644 <ahci_enable_port+0x1d6>
				ahci_port_activate_device(ad->ptr, p);
    362d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3631:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3635:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3639:	48 89 d6             	mov    rsi,rdx
    363c:	48 89 c7             	mov    rdi,rax
    363f:	e8 00 00 00 00       	call   3644 <ahci_enable_port+0x1d6>
		if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    3644:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3648:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    364b:	0f b6 c0             	movzx  eax,al
    364e:	25 88 00 00 00       	and    eax,0x88
    3653:	85 c0                	test   eax,eax
    3655:	0f 85 b3 00 00 00    	jne    370e <ahci_enable_port+0x2a0>
				goto defer; /* listen */
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    365b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    365f:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3662:	83 e0 0f             	and    eax,0xf
    3665:	3c 03                	cmp    al,0x3
    3667:	74 33                	je     369c <ahci_enable_port+0x22e>
    3669:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    366d:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3670:	c1 e8 08             	shr    eax,0x8
    3673:	83 e0 0f             	and    eax,0xf
    3676:	3c 02                	cmp    al,0x2
    3678:	74 22                	je     369c <ahci_enable_port+0x22e>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    367a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    367e:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3681:	c1 e8 08             	shr    eax,0x8
    3684:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    3687:	3c 06                	cmp    al,0x6
    3689:	74 11                	je     369c <ahci_enable_port+0x22e>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    368b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    368f:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    3692:	c1 e8 08             	shr    eax,0x8
    3695:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    3698:	3c 08                	cmp    al,0x8
    369a:	75 75                	jne    3711 <ahci_enable_port+0x2a3>
				goto defer;
		/* we're allowed so set it */
		p->cmd.st = 1;
    369c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    36a0:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    36a3:	83 c8 01             	or     eax,0x1
    36a6:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		/* Change in PhyRdy, CPS, TFS.err, PCS, DPS(I=1), UFS, HBFS, HBDS, IFS, D2HFIS */
		p->pXie = (1 << 22) | (1 << 6) | (1 << 31) | (1 << 30) | (1 << 0)
    36a9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    36ad:	c7 40 14 71 00 40 f8 	mov    DWORD PTR [rax+0x14],0xf8400071
				| (1 << 5) | (1 << 4) | (1 << 29) | (1 << 28) | (1 << 27);

		/* issue the IDENTIFY_(PACKET)_DEVICE command */
		ahci_issue_command(ad, pt, 0, disk_cmd_identify, 0, 0, NULL, NULL /* wq_worker_ad*/, NULL);
    36b4:	8b 75 d4             	mov    esi,DWORD PTR [rbp-0x2c]
    36b7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    36bb:	48 c7 44 24 10 00 00 00 00 	mov    QWORD PTR [rsp+0x10],0x0
    36c4:	48 c7 44 24 08 00 00 00 00 	mov    QWORD PTR [rsp+0x8],0x0
    36cd:	48 c7 04 24 00 00 00 00 	mov    QWORD PTR [rsp],0x0
    36d5:	41 b9 00 00 00 00    	mov    r9d,0x0
    36db:	41 b8 00 00 00 00    	mov    r8d,0x0
    36e1:	b9 00 00 00 00       	mov    ecx,0x0
    36e6:	ba 00 00 00 00       	mov    edx,0x0
    36eb:	48 89 c7             	mov    rdi,rax
    36ee:	e8 00 00 00 00       	call   36f3 <ahci_enable_port+0x285>

		printf("port %d is now processing commands\n", pt);
    36f3:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    36f6:	89 c6                	mov    esi,eax
    36f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36ff:	b8 00 00 00 00       	mov    eax,0x0
    3704:	e8 00 00 00 00       	call   3709 <ahci_enable_port+0x29b>
		return;
    3709:	eb 2b                	jmp    3736 <ahci_enable_port+0x2c8>
								goto defer;
    370b:	90                   	nop
    370c:	eb 04                	jmp    3712 <ahci_enable_port+0x2a4>
				goto defer; /* listen */
    370e:	90                   	nop
    370f:	eb 01                	jmp    3712 <ahci_enable_port+0x2a4>
				goto defer;
    3711:	90                   	nop

defer: /* we're interested in status changes only */
		abprintf("port %d set to listening mode\n", pt);
    3712:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    3715:	89 c6                	mov    esi,eax
    3717:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    371e:	b8 00 00 00 00       	mov    eax,0x0
    3723:	e8 00 00 00 00       	call   3728 <ahci_enable_port+0x2ba>
		p->pXie = (1 << 22) | (1 << 31) | (1 << 6); /* PhyRdy change, CPS, CCS */
    3728:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    372c:	c7 40 14 40 00 40 80 	mov    DWORD PTR [rax+0x14],0x80400040
    3733:	eb 01                	jmp    3736 <ahci_enable_port+0x2c8>
				return;
    3735:	90                   	nop
}
    3736:	c9                   	leave
    3737:	c3                   	ret

0000000000003738 <ahci_stop_port>:

void ahci_stop_port(struct ahci_device* ad, int pt)
{
    3738:	55                   	push   rbp
    3739:	48 89 e5             	mov    rbp,rsp
    373c:	48 83 ec 20          	sub    rsp,0x20
    3740:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    3744:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct ahci_port* p = &ad->ptr->port[pt];
    3747:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    374b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    374f:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    3752:	48 63 d2             	movsxd rdx,edx
    3755:	48 83 c2 02          	add    rdx,0x2
    3759:	48 c1 e2 07          	shl    rdx,0x7
    375d:	48 01 d0             	add    rax,rdx
    3760:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		int ct;

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    3764:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3768:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    376c:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    376f:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    3772:	be 01 00 00 00       	mov    esi,0x1
    3777:	89 c1                	mov    ecx,eax
    3779:	d3 e6                	shl    esi,cl
    377b:	89 f0                	mov    eax,esi
    377d:	21 d0                	and    eax,edx
    377f:	85 c0                	test   eax,eax
    3781:	0f 84 6a 01 00 00    	je     38f1 <ahci_stop_port+0x1b9>
				return;

		/* print the BIOS provided status */
		abprintf("BIOS initial state of port %d:\n", pt);
    3787:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    378a:	89 c6                	mov    esi,eax
    378c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3793:	b8 00 00 00 00       	mov    eax,0x0
    3798:	e8 00 00 00 00       	call   379d <ahci_stop_port+0x65>
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
				p->cmd.st ? "ST" : "");
    379d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37a1:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    37a4:	83 e0 01             	and    eax,0x1
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
    37a7:	84 c0                	test   al,al
    37a9:	74 09                	je     37b4 <ahci_stop_port+0x7c>
    37ab:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    37b2:	eb 07                	jmp    37bb <ahci_stop_port+0x83>
    37b4:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    37bb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37bf:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    37c2:	c1 e8 04             	shr    eax,0x4
    37c5:	83 e0 01             	and    eax,0x1
    37c8:	84 c0                	test   al,al
    37ca:	74 09                	je     37d5 <ahci_stop_port+0x9d>
    37cc:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    37d3:	eb 07                	jmp    37dc <ahci_stop_port+0xa4>
    37d5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    37dc:	48 89 c6             	mov    rsi,rax
    37df:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    37e6:	b8 00 00 00 00       	mov    eax,0x0
    37eb:	e8 00 00 00 00       	call   37f0 <ahci_stop_port+0xb8>
		/* print the pointers */
		abprintf("BIOS command list located at %016llx\n", p->pXclb64);
    37f0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37f4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    37f7:	48 89 c6             	mov    rsi,rax
    37fa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3801:	b8 00 00 00 00       	mov    eax,0x0
    3806:	e8 00 00 00 00       	call   380b <ahci_stop_port+0xd3>
		abprintf("BIOS FIS received buffer at  %016llx\n", p->pXfb64);
    380b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    380f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3813:	48 89 c6             	mov    rsi,rax
    3816:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    381d:	b8 00 00 00 00       	mov    eax,0x0
    3822:	e8 00 00 00 00       	call   3827 <ahci_stop_port+0xef>

		/* check if already off */
		if (!p->cmd.fre && !p->cmd.st)
    3827:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    382b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    382e:	c1 e8 04             	shr    eax,0x4
    3831:	83 e0 01             	and    eax,0x1
    3834:	84 c0                	test   al,al
    3836:	75 12                	jne    384a <ahci_stop_port+0x112>
    3838:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    383c:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    383f:	83 e0 01             	and    eax,0x1
    3842:	84 c0                	test   al,al
    3844:	0f 84 aa 00 00 00    	je     38f4 <ahci_stop_port+0x1bc>
				return;

		/* Now turn it off (2x500ms max else reset) */
		ct = 50;
    384a:	c7 45 fc 32 00 00 00 	mov    DWORD PTR [rbp-0x4],0x32
		p->cmd.st = 0;
    3851:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3855:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    3858:	83 e0 fe             	and    eax,0xfffffffe
    385b:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		while (p->cmd.cr && ct--)
    385e:	eb 0a                	jmp    386a <ahci_stop_port+0x132>
				mdelay(10);
    3860:	bf 0a 00 00 00       	mov    edi,0xa
    3865:	e8 00 00 00 00       	call   386a <ahci_stop_port+0x132>
		while (p->cmd.cr && ct--)
    386a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    386e:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3871:	c1 e8 0f             	shr    eax,0xf
    3874:	83 e0 01             	and    eax,0x1
    3877:	84 c0                	test   al,al
    3879:	74 0d                	je     3888 <ahci_stop_port+0x150>
    387b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    387e:	8d 50 ff             	lea    edx,[rax-0x1]
    3881:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    3884:	85 c0                	test   eax,eax
    3886:	75 d8                	jne    3860 <ahci_stop_port+0x128>
		if (ct == -1)
    3888:	83 7d fc ff          	cmp    DWORD PTR [rbp-0x4],0xffffffff
    388c:	74 40                	je     38ce <ahci_stop_port+0x196>
				goto reset;
		ct = 50;
    388e:	c7 45 fc 32 00 00 00 	mov    DWORD PTR [rbp-0x4],0x32
		p->cmd.fre = 0;
    3895:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3899:	8b 42 18             	mov    eax,DWORD PTR [rdx+0x18]
    389c:	83 e0 ef             	and    eax,0xffffffef
    389f:	89 42 18             	mov    DWORD PTR [rdx+0x18],eax
		while (p->cmd.fr && ct--)
    38a2:	eb 0a                	jmp    38ae <ahci_stop_port+0x176>
				mdelay(10);
    38a4:	bf 0a 00 00 00       	mov    edi,0xa
    38a9:	e8 00 00 00 00       	call   38ae <ahci_stop_port+0x176>
		while (p->cmd.fr && ct--)
    38ae:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    38b2:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    38b5:	c1 e8 0e             	shr    eax,0xe
    38b8:	83 e0 01             	and    eax,0x1
    38bb:	84 c0                	test   al,al
    38bd:	74 12                	je     38d1 <ahci_stop_port+0x199>
    38bf:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    38c2:	8d 50 ff             	lea    edx,[rax-0x1]
    38c5:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    38c8:	85 c0                	test   eax,eax
    38ca:	75 d8                	jne    38a4 <ahci_stop_port+0x16c>
reset:
    38cc:	eb 03                	jmp    38d1 <ahci_stop_port+0x199>
				goto reset;
    38ce:	90                   	nop
    38cf:	eb 01                	jmp    38d2 <ahci_stop_port+0x19a>
reset:
    38d1:	90                   	nop
		if (ct == -1) {
    38d2:	83 7d fc ff          	cmp    DWORD PTR [rbp-0x4],0xffffffff
    38d6:	75 1d                	jne    38f5 <ahci_stop_port+0x1bd>
				printf("Port %d: reset needed!\n", pt);
    38d8:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    38db:	89 c6                	mov    esi,eax
    38dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    38e4:	b8 00 00 00 00       	mov    eax,0x0
    38e9:	e8 00 00 00 00       	call   38ee <ahci_stop_port+0x1b6>
				/* TODO implement this */
				//ahci_reset_port(ad, pt);
				while (1);
    38ee:	90                   	nop
    38ef:	eb fd                	jmp    38ee <ahci_stop_port+0x1b6>
				return;
    38f1:	90                   	nop
    38f2:	eb 01                	jmp    38f5 <ahci_stop_port+0x1bd>
				return;
    38f4:	90                   	nop
		}
		/* The port is now off innit? */
}
    38f5:	c9                   	leave
    38f6:	c3                   	ret

00000000000038f7 <ahci_assign_buffers>:

/* we have ad->num_ports active ports needing num_cmd
 * command slots and one FIS receive buffer each.
 * The command lists are held in a shared pool. */
void ahci_assign_buffers(struct ahci_device* ad)
{
    38f7:	55                   	push   rbp
    38f8:	48 89 e5             	mov    rbp,rsp
    38fb:	48 83 ec 60          	sub    rsp,0x60
    38ff:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
		size_t bt_ct, pg_ct; int flg = MMGR_ALLOC_COMPLETE;
    3903:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		struct page_range pr; int cc, fc, ic;
		/* Total size: 256*np+1024*np+512*np */
		bt_ct = ad->num_ports * (sizeof(struct ahci_fis)
    390a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    390e:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3912:	0f b7 d0             	movzx  edx,ax
    3915:	48 89 d0             	mov    rax,rdx
    3918:	48 c1 e0 03          	shl    rax,0x3
    391c:	48 29 d0             	sub    rax,rdx
    391f:	48 c1 e0 08          	shl    rax,0x8
    3923:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				+ sizeof(struct ahci_cmdlst) + 512);
		pg_ct = rdiv(bt_ct, 4096);
    3927:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    392b:	48 c1 e8 0c          	shr    rax,0xc
    392f:	48 89 c2             	mov    rdx,rax
    3932:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    3936:	25 ff 0f 00 00       	and    eax,0xfff
    393b:	48 85 c0             	test   rax,rax
    393e:	74 07                	je     3947 <ahci_assign_buffers+0x50>
    3940:	b8 01 00 00 00       	mov    eax,0x1
    3945:	eb 05                	jmp    394c <ahci_assign_buffers+0x55>
    3947:	b8 00 00 00 00       	mov    eax,0x0
    394c:	48 01 d0             	add    rax,rdx
    394f:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax

		/* allocate and map the physical memory */
		ic = cc = fc = ad->num_ports;
    3953:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3957:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    395b:	0f b7 c0             	movzx  eax,ax
    395e:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    3961:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    3964:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    3967:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    396a:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		if (!ad->ptr->cap.is_64bit)
    396d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3971:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3975:	8b 00                	mov    eax,DWORD PTR [rax]
    3977:	c1 e8 1f             	shr    eax,0x1f
    397a:	84 c0                	test   al,al
    397c:	0f 85 06 03 00 00    	jne    3c88 <ahci_assign_buffers+0x391>
				flg = MMGR_ALLOC_32BIT;
    3982:	c7 45 f4 00 00 04 00 	mov    DWORD PTR [rbp-0xc],0x40000
		while (pg_ct) {
    3989:	e9 fa 02 00 00       	jmp    3c88 <ahci_assign_buffers+0x391>
				void* ptr; size_t nb;
				/* we don't need contiguous memory */
				pg_ct -= mm_alloc_pm_flg(pg_ct, &pr, 1, flg);
    398e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3992:	89 c7                	mov    edi,eax
    3994:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    3997:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    399b:	89 d1                	mov    ecx,edx
    399d:	ba 01 00 00 00       	mov    edx,0x1
    39a2:	48 89 c6             	mov    rsi,rax
    39a5:	e8 00 00 00 00       	call   39aa <ahci_assign_buffers+0xb3>
    39aa:	89 c0                	mov    eax,eax
    39ac:	48 29 45 f8          	sub    QWORD PTR [rbp-0x8],rax
				if (!pr.count)
    39b0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    39b4:	48 85 c0             	test   rax,rax
    39b7:	0f 84 db 02 00 00    	je     3c98 <ahci_assign_buffers+0x3a1>
						goto quit;
				nb = 4096 * pr.count;
    39bd:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    39c1:	48 c1 e0 0c          	shl    rax,0xc
    39c5:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, /*MMGR_MAP_MMIO | <- 0xe nope */
    39c9:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    39cd:	41 b8 2c 00 00 00    	mov    r8d,0x2c
    39d3:	b9 01 00 00 00       	mov    ecx,0x1
    39d8:	48 89 c2             	mov    rdx,rax
    39db:	be 00 00 00 00       	mov    esi,0x0
    39e0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    39e7:	e8 00 00 00 00       	call   39ec <ahci_assign_buffers+0xf5>
    39ec:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!ptr)
    39f0:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    39f5:	0f 84 a0 02 00 00    	je     3c9b <ahci_assign_buffers+0x3a4>
						goto quit;

				/* now first process the command lists with 1K-alignment */
				while (cc && nb >= 1024) {
    39fb:	e9 8f 00 00 00       	jmp    3a8f <ahci_assign_buffers+0x198>
						int pt = ad->num_ports - cc--;
    3a00:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a04:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3a08:	0f b7 c8             	movzx  ecx,ax
    3a0b:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    3a0e:	8d 50 ff             	lea    edx,[rax-0x1]
    3a11:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
    3a14:	29 c1                	sub    ecx,eax
    3a16:	89 ca                	mov    edx,ecx
    3a18:	89 55 cc             	mov    DWORD PTR [rbp-0x34],edx
						if (ad->ptr->ports & (1 << pt)) {
    3a1b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a1f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3a23:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3a26:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    3a29:	be 01 00 00 00       	mov    esi,0x1
    3a2e:	89 c1                	mov    ecx,eax
    3a30:	d3 e6                	shl    esi,cl
    3a32:	89 f0                	mov    eax,esi
    3a34:	21 d0                	and    eax,edx
    3a36:	85 c0                	test   eax,eax
    3a38:	74 55                	je     3a8f <ahci_assign_buffers+0x198>
								/* assign for implemented port */
								ad->ptr->port[pt].pXclb64 = pr.base;
    3a3a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a3e:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    3a42:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3a46:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34]
    3a49:	48 63 c9             	movsxd rcx,ecx
    3a4c:	48 83 c1 02          	add    rcx,0x2
    3a50:	48 c1 e1 07          	shl    rcx,0x7
    3a54:	48 01 ca             	add    rdx,rcx
    3a57:	48 89 02             	mov    QWORD PTR [rdx],rax
								ad->command_lists[pt] = ptr;
    3a5a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3a5e:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
    3a61:	48 63 d2             	movsxd rdx,edx
    3a64:	48 8d 4a 02          	lea    rcx,[rdx+0x2]
    3a68:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3a6c:	48 89 54 c8 08       	mov    QWORD PTR [rax+rcx*8+0x8],rdx
								/* advance */
								pr.base += 1024;
    3a71:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3a75:	48 05 00 04 00 00    	add    rax,0x400
    3a7b:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								nb -= 1024;
    3a7f:	48 81 6d d8 00 04 00 00 	sub    QWORD PTR [rbp-0x28],0x400
								ptr += 1024;
    3a87:	48 81 45 e0 00 04 00 00 	add    QWORD PTR [rbp-0x20],0x400
				while (cc && nb >= 1024) {
    3a8f:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3a93:	0f 84 a6 00 00 00    	je     3b3f <ahci_assign_buffers+0x248>
    3a99:	48 81 7d d8 ff 03 00 00 	cmp    QWORD PTR [rbp-0x28],0x3ff
    3aa1:	0f 87 59 ff ff ff    	ja     3a00 <ahci_assign_buffers+0x109>
						}
				}

				/* then the FIS buffers (256bt-aligned) */
				while (fc && nb >= 256) {
    3aa7:	e9 93 00 00 00       	jmp    3b3f <ahci_assign_buffers+0x248>
						int pt = ad->num_ports - fc--;
    3aac:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ab0:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3ab4:	0f b7 c8             	movzx  ecx,ax
    3ab7:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    3aba:	8d 50 ff             	lea    edx,[rax-0x1]
    3abd:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx
    3ac0:	29 c1                	sub    ecx,eax
    3ac2:	89 ca                	mov    edx,ecx
    3ac4:	89 55 c8             	mov    DWORD PTR [rbp-0x38],edx
						if (ad->ptr->ports & (1 << pt)) {
    3ac7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3acb:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3acf:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3ad2:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    3ad5:	be 01 00 00 00       	mov    esi,0x1
    3ada:	89 c1                	mov    ecx,eax
    3adc:	d3 e6                	shl    esi,cl
    3ade:	89 f0                	mov    eax,esi
    3ae0:	21 d0                	and    eax,edx
    3ae2:	85 c0                	test   eax,eax
    3ae4:	74 59                	je     3b3f <ahci_assign_buffers+0x248>
								/* as above */
								ad->ptr->port[pt].pXfb64 = pr.base;
    3ae6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3aea:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    3aee:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3af2:	8b 4d c8             	mov    ecx,DWORD PTR [rbp-0x38]
    3af5:	48 63 c9             	movsxd rcx,ecx
    3af8:	48 83 c1 02          	add    rcx,0x2
    3afc:	48 c1 e1 07          	shl    rcx,0x7
    3b00:	48 01 ca             	add    rdx,rcx
    3b03:	48 83 c2 08          	add    rdx,0x8
    3b07:	48 89 02             	mov    QWORD PTR [rdx],rax
								ad->recv_fis[pt] = ptr;
    3b0a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3b0e:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    3b11:	48 63 d2             	movsxd rdx,edx
    3b14:	48 8d 4a 22          	lea    rcx,[rdx+0x22]
    3b18:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3b1c:	48 89 54 c8 08       	mov    QWORD PTR [rax+rcx*8+0x8],rdx
								/* advance */
								pr.base += 256;
    3b21:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3b25:	48 05 00 01 00 00    	add    rax,0x100
    3b2b:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								nb -= 256;
    3b2f:	48 81 6d d8 00 01 00 00 	sub    QWORD PTR [rbp-0x28],0x100
								ptr += 256;
    3b37:	48 81 45 e0 00 01 00 00 	add    QWORD PTR [rbp-0x20],0x100
				while (fc && nb >= 256) {
    3b3f:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    3b43:	0f 84 e2 00 00 00    	je     3c2b <ahci_assign_buffers+0x334>
    3b49:	48 81 7d d8 ff 00 00 00 	cmp    QWORD PTR [rbp-0x28],0xff
    3b51:	0f 87 55 ff ff ff    	ja     3aac <ahci_assign_buffers+0x1b5>
						}
				}

				while (ic && nb >= 512) {
    3b57:	e9 cf 00 00 00       	jmp    3c2b <ahci_assign_buffers+0x334>
						int pt = ad->num_ports - ic--;
    3b5c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3b60:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3b64:	0f b7 c8             	movzx  ecx,ax
    3b67:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    3b6a:	8d 50 ff             	lea    edx,[rax-0x1]
    3b6d:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
    3b70:	29 c1                	sub    ecx,eax
    3b72:	89 ca                	mov    edx,ecx
    3b74:	89 55 c4             	mov    DWORD PTR [rbp-0x3c],edx
						if (ad->ptr->ports & (1 << pt)) {
    3b77:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3b7b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3b7f:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3b82:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3b85:	be 01 00 00 00       	mov    esi,0x1
    3b8a:	89 c1                	mov    ecx,eax
    3b8c:	d3 e6                	shl    esi,cl
    3b8e:	89 f0                	mov    eax,esi
    3b90:	21 d0                	and    eax,edx
    3b92:	85 c0                	test   eax,eax
    3b94:	74 6f                	je     3c05 <ahci_assign_buffers+0x30e>
								/* as above */
								ad->identify_data[pt].pm = pr.base;
    3b96:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    3b9a:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    3b9e:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3ba1:	48 63 d0             	movsxd rdx,eax
    3ba4:	48 89 d0             	mov    rax,rdx
    3ba7:	48 01 c0             	add    rax,rax
    3baa:	48 01 d0             	add    rax,rdx
    3bad:	48 c1 e0 03          	shl    rax,0x3
    3bb1:	48 01 f0             	add    rax,rsi
    3bb4:	48 05 28 02 00 00    	add    rax,0x228
    3bba:	48 89 08             	mov    QWORD PTR [rax],rcx
								ad->identify_data[pt].ptr = ptr;
    3bbd:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    3bc1:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3bc4:	48 63 d0             	movsxd rdx,eax
    3bc7:	48 89 d0             	mov    rax,rdx
    3bca:	48 01 c0             	add    rax,rax
    3bcd:	48 01 d0             	add    rax,rdx
    3bd0:	48 c1 e0 03          	shl    rax,0x3
    3bd4:	48 01 c8             	add    rax,rcx
    3bd7:	48 8d 90 20 02 00 00 	lea    rdx,[rax+0x220]
    3bde:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3be2:	48 89 02             	mov    QWORD PTR [rdx],rax
								/* advance */
								pr.base += 512;
    3be5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3be9:	48 05 00 02 00 00    	add    rax,0x200
    3bef:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								nb -= 512;
    3bf3:	48 81 6d d8 00 02 00 00 	sub    QWORD PTR [rbp-0x28],0x200
								ptr += 512;
    3bfb:	48 81 45 e0 00 02 00 00 	add    QWORD PTR [rbp-0x20],0x200
    3c03:	eb 26                	jmp    3c2b <ahci_assign_buffers+0x334>
						} else
								ad->identify_data[pt].sig = 0;
    3c05:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    3c09:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    3c0c:	48 63 d0             	movsxd rdx,eax
    3c0f:	48 89 d0             	mov    rax,rdx
    3c12:	48 01 c0             	add    rax,rax
    3c15:	48 01 d0             	add    rax,rdx
    3c18:	48 c1 e0 03          	shl    rax,0x3
    3c1c:	48 01 c8             	add    rax,rcx
    3c1f:	48 05 18 02 00 00    	add    rax,0x218
    3c25:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				while (ic && nb >= 512) {
    3c2b:	83 7d e8 00          	cmp    DWORD PTR [rbp-0x18],0x0
    3c2f:	74 0e                	je     3c3f <ahci_assign_buffers+0x348>
    3c31:	48 81 7d d8 ff 01 00 00 	cmp    QWORD PTR [rbp-0x28],0x1ff
    3c39:	0f 87 1d ff ff ff    	ja     3b5c <ahci_assign_buffers+0x265>
				}

				/* exit early if we have non-impelented ports */
				if (!fc && !cc && !ic) {
    3c3f:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    3c43:	75 43                	jne    3c88 <ahci_assign_buffers+0x391>
    3c45:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3c49:	75 3d                	jne    3c88 <ahci_assign_buffers+0x391>
    3c4b:	83 7d e8 00          	cmp    DWORD PTR [rbp-0x18],0x0
    3c4f:	75 37                	jne    3c88 <ahci_assign_buffers+0x391>
						/* also deallocate if possible */
						if (nb >= 4096) {
    3c51:	48 81 7d d8 ff 0f 00 00 	cmp    QWORD PTR [rbp-0x28],0xfff
    3c59:	76 3a                	jbe    3c95 <ahci_assign_buffers+0x39e>
								ptr += (size_t)ptr % 4096;
    3c5b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3c5f:	25 ff 0f 00 00       	and    eax,0xfff
    3c64:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
								mm_free_vmem(&mm_kernel, ptr, nb / 4096);
    3c68:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3c6c:	48 c1 e8 0c          	shr    rax,0xc
    3c70:	48 89 c2             	mov    rdx,rax
    3c73:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3c77:	48 89 c6             	mov    rsi,rax
    3c7a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3c81:	e8 00 00 00 00       	call   3c86 <ahci_assign_buffers+0x38f>
						}
						break;
    3c86:	eb 0d                	jmp    3c95 <ahci_assign_buffers+0x39e>
		while (pg_ct) {
    3c88:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    3c8d:	0f 85 fb fc ff ff    	jne    398e <ahci_assign_buffers+0x97>
				}
		}
		/* Now all implemented buffers are set */
		return;
    3c93:	eb 37                	jmp    3ccc <ahci_assign_buffers+0x3d5>
						break;
    3c95:	90                   	nop
		return;
    3c96:	eb 34                	jmp    3ccc <ahci_assign_buffers+0x3d5>
						goto quit;
    3c98:	90                   	nop
    3c99:	eb 01                	jmp    3c9c <ahci_assign_buffers+0x3a5>
						goto quit;
    3c9b:	90                   	nop

quit:
		die("Out of memory!\n");
    3c9c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3ca3:	bf 0c 00 00 00       	mov    edi,0xc
    3ca8:	b8 00 00 00 00       	mov    eax,0x0
    3cad:	e8 00 00 00 00       	call   3cb2 <ahci_assign_buffers+0x3bb>
    3cb2:	b8 00 00 00 00       	mov    eax,0x0
    3cb7:	e8 00 00 00 00       	call   3cbc <ahci_assign_buffers+0x3c5>
    3cbc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3cc3:	e8 00 00 00 00       	call   3cc8 <ahci_assign_buffers+0x3d1>
    3cc8:	fa                   	cli
    3cc9:	f4                   	hlt
    3cca:	eb fd                	jmp    3cc9 <ahci_assign_buffers+0x3d2>
}
    3ccc:	c9                   	leave
    3ccd:	c3                   	ret

0000000000003cce <ahci_clear_interrupts>:

/* also disables interrupts */
void ahci_clear_interrupts(struct ahci_device* ad)
{
    3cce:	55                   	push   rbp
    3ccf:	48 89 e5             	mov    rbp,rsp
    3cd2:	48 83 ec 28          	sub    rsp,0x28
    3cd6:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct ahci_hba* h = ad->ptr;
    3cda:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3cde:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    3ce2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax

		/* disable interrupts */
		h->ctrl.ie = 0;
    3ce6:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3cea:	8b 42 04             	mov    eax,DWORD PTR [rdx+0x4]
    3ced:	83 e0 fd             	and    eax,0xfffffffd
    3cf0:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax

		/* clear them in every port implemented */
		for (int i = 0; i < ad->num_ports; i++) {
    3cf3:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    3cfa:	eb 53                	jmp    3d4f <ahci_clear_interrupts+0x81>
				struct ahci_port* p;
				if ((h->ports & (1 << i)) == 0)
    3cfc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3d00:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    3d03:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3d06:	be 01 00 00 00       	mov    esi,0x1
    3d0b:	89 c1                	mov    ecx,eax
    3d0d:	d3 e6                	shl    esi,cl
    3d0f:	89 f0                	mov    eax,esi
    3d11:	21 d0                	and    eax,edx
    3d13:	85 c0                	test   eax,eax
    3d15:	74 33                	je     3d4a <ahci_clear_interrupts+0x7c>
						continue;
				p = &h->port[i];
    3d17:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3d1a:	48 98                	cdqe
    3d1c:	48 83 c0 02          	add    rax,0x2
    3d20:	48 c1 e0 07          	shl    rax,0x7
    3d24:	48 89 c2             	mov    rdx,rax
    3d27:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3d2b:	48 01 d0             	add    rax,rdx
    3d2e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				/* disable and clear all */
				p->pXie = 0;
    3d32:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3d36:	c7 40 14 00 00 00 00 	mov    DWORD PTR [rax+0x14],0x0
				p->pXis = 0xffffffff;
    3d3d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3d41:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [rax+0x10],0xffffffff
    3d48:	eb 01                	jmp    3d4b <ahci_clear_interrupts+0x7d>
						continue;
    3d4a:	90                   	nop
		for (int i = 0; i < ad->num_ports; i++) {
    3d4b:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3d4f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3d53:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    3d57:	0f b7 c0             	movzx  eax,ax
    3d5a:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    3d5d:	7c 9d                	jl     3cfc <ahci_clear_interrupts+0x2e>
		}

		/* clear the global status */
		h->intr = 0xffffffff; /* W1C */
    3d5f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3d63:	c7 40 08 ff ff ff ff 	mov    DWORD PTR [rax+0x8],0xffffffff
}
    3d6a:	90                   	nop
    3d6b:	c9                   	leave
    3d6c:	c3                   	ret

0000000000003d6d <ahci_device_init>:

int ahci_device_init(struct pci_device* d)
{
    3d6d:	55                   	push   rbp
    3d6e:	48 89 e5             	mov    rbp,rsp
    3d71:	41 55                	push   r13
    3d73:	41 54                	push   r12
    3d75:	53                   	push   rbx
    3d76:	48 81 ec e8 00 00 00 	sub    rsp,0xe8
    3d7d:	48 89 bd 18 ff ff ff 	mov    QWORD PTR [rbp-0xe8],rdi
		int rv;

		/* Check progIf */
		if (d->device_interface != 1) {
    3d84:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3d8b:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
    3d8f:	3c 01                	cmp    al,0x1
    3d91:	74 30                	je     3dc3 <ahci_device_init+0x56>
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
						d->device_interface);
    3d93:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3d9a:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
    3d9e:	0f b6 c0             	movzx  eax,al
    3da1:	89 c2                	mov    edx,eax
    3da3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3daa:	bf 0e 00 00 00       	mov    edi,0xe
    3daf:	b8 00 00 00 00       	mov    eax,0x0
    3db4:	e8 00 00 00 00       	call   3db9 <ahci_device_init+0x4c>
				return -ENOSYS;
    3db9:	b8 da ff ff ff       	mov    eax,0xffffffda
    3dbe:	e9 fe 08 00 00       	jmp    46c1 <ahci_device_init+0x954>
		}

		/* Setup and map BAR5 if neccessary */
		if (d->ressources[5].type == PCI_BAR_PIO)
    3dc3:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3dca:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [rax+0xc8]
    3dd0:	83 f8 01             	cmp    eax,0x1
    3dd3:	75 0a                	jne    3ddf <ahci_device_init+0x72>
				return -ENOTSUP; /* AHCI requires MMIO at BAR5 */
    3dd5:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    3dda:	e9 e2 08 00 00       	jmp    46c1 <ahci_device_init+0x954>
		if (!d->ressources[5].mmio.base) {
    3ddf:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3de6:	48 8b 80 d0 00 00 00 	mov    rax,QWORD PTR [rax+0xd0]
    3ded:	48 85 c0             	test   rax,rax
    3df0:	0f 85 28 01 00 00    	jne    3f1e <ahci_device_init+0x1b1>
				int atl = 0; uint64_t m;
    3df6:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
				/* we first need pmem for the device */
				if (!d->ressources[5].mmio.size) {
    3dfd:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3e04:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3e0b:	48 85 c0             	test   rax,rax
    3e0e:	75 4e                	jne    3e5e <ahci_device_init+0xf1>
						/* Ask PCI */
						d->ressources[5].mmio.size = pci_bar_get_size(d, 5);
    3e10:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3e17:	be 05 00 00 00       	mov    esi,0x5
    3e1c:	48 89 c7             	mov    rdi,rax
    3e1f:	e8 00 00 00 00       	call   3e24 <ahci_device_init+0xb7>
    3e24:	48 8b 95 18 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xe8]
    3e2b:	48 89 82 d8 00 00 00 	mov    QWORD PTR [rdx+0xd8],rax
						if (!d->ressources[5].mmio.size) {
    3e32:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3e39:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3e40:	48 85 c0             	test   rax,rax
    3e43:	75 19                	jne    3e5e <ahci_device_init+0xf1>
								d->ressources[5].mmio.size = 0x1100; /* 32 ports */
    3e45:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3e4c:	48 c7 80 d8 00 00 00 00 11 00 00 	mov    QWORD PTR [rax+0xd8],0x1100
								atl = 1; /* about to leave */
    3e57:	c7 45 dc 01 00 00 00 	mov    DWORD PTR [rbp-0x24],0x1
						}
				}
				/* Now we want to get some address */
				m = mmio_allocate_range(d->ressources[5].mmio.size,
						0x3 & (d->ressources[5].type >> 1));
    3e5e:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3e65:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [rax+0xc8]
    3e6b:	d1 f8                	sar    eax,1
				m = mmio_allocate_range(d->ressources[5].mmio.size,
    3e6d:	83 e0 03             	and    eax,0x3
    3e70:	89 c2                	mov    edx,eax
    3e72:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3e79:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3e80:	89 d6                	mov    esi,edx
    3e82:	48 89 c7             	mov    rdi,rax
    3e85:	e8 00 00 00 00       	call   3e8a <ahci_device_init+0x11d>
    3e8a:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				if (!m)
    3e8e:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    3e93:	75 0a                	jne    3e9f <ahci_device_init+0x132>
						return -ENOMEM;
    3e95:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3e9a:	e9 22 08 00 00       	jmp    46c1 <ahci_device_init+0x954>
				/* and assign it */
				pci_set_bar(d, 5, d->ressources[5].type, m);
    3e9f:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3ea6:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [rax+0xc8]
    3eac:	89 c6                	mov    esi,eax
    3eae:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    3eb2:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3eb9:	48 89 d1             	mov    rcx,rdx
    3ebc:	89 f2                	mov    edx,esi
    3ebe:	be 05 00 00 00       	mov    esi,0x5
    3ec3:	48 89 c7             	mov    rdi,rax
    3ec6:	e8 00 00 00 00       	call   3ecb <ahci_device_init+0x15e>
				if (d->ressources[5].mmio.base != m) {
    3ecb:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3ed2:	48 8b 80 d0 00 00 00 	mov    rax,QWORD PTR [rax+0xd0]
    3ed9:	48 39 45 c0          	cmp    QWORD PTR [rbp-0x40],rax
    3edd:	74 3f                	je     3f1e <ahci_device_init+0x1b1>
						/* we can't */
						mmio_free_range(m, d->ressources[5].mmio.size);
    3edf:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3ee6:	48 8b 90 d8 00 00 00 	mov    rdx,QWORD PTR [rax+0xd8]
    3eed:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    3ef1:	48 89 d6             	mov    rsi,rdx
    3ef4:	48 89 c7             	mov    rdi,rax
    3ef7:	e8 00 00 00 00       	call   3efc <ahci_device_init+0x18f>
						if (atl)
    3efc:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    3f00:	74 12                	je     3f14 <ahci_device_init+0x1a7>
								d->ressources[5].mmio.size = 0;
    3f02:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3f09:	48 c7 80 d8 00 00 00 00 00 00 00 	mov    QWORD PTR [rax+0xd8],0x0
						return -ENOTSUP;
    3f14:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    3f19:	e9 a3 07 00 00       	jmp    46c1 <ahci_device_init+0x954>
				}
		}

		/* Now we possibly have to map the memory */
		if (!d->ressources[5].mmio.mapping) {
    3f1e:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3f25:	48 8b 80 e0 00 00 00 	mov    rax,QWORD PTR [rax+0xe0]
    3f2c:	48 85 c0             	test   rax,rax
    3f2f:	0f 85 a5 00 00 00    	jne    3fda <ahci_device_init+0x26d>
				void* mem; struct page_range pr;
				pr.base = d->ressources[5].mmio.base;
    3f35:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3f3c:	48 8b 80 d0 00 00 00 	mov    rax,QWORD PTR [rax+0xd0]
    3f43:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
				pr.count = rdiv(d->ressources[5].mmio.size, 4096);
    3f4a:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3f51:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3f58:	48 c1 e8 0c          	shr    rax,0xc
    3f5c:	48 89 c2             	mov    rdx,rax
    3f5f:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3f66:	48 8b 80 d8 00 00 00 	mov    rax,QWORD PTR [rax+0xd8]
    3f6d:	25 ff 0f 00 00       	and    eax,0xfff
    3f72:	48 85 c0             	test   rax,rax
    3f75:	74 07                	je     3f7e <ahci_device_init+0x211>
    3f77:	b8 01 00 00 00       	mov    eax,0x1
    3f7c:	eb 05                	jmp    3f83 <ahci_device_init+0x216>
    3f7e:	b8 00 00 00 00       	mov    eax,0x0
    3f83:	48 01 d0             	add    rax,rdx
    3f86:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
			   	mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_MMIO |
    3f8d:	48 8d 85 58 ff ff ff 	lea    rax,[rbp-0xa8]
    3f94:	41 b8 2d 00 00 00    	mov    r8d,0x2d
    3f9a:	b9 01 00 00 00       	mov    ecx,0x1
    3f9f:	48 89 c2             	mov    rdx,rax
    3fa2:	be 00 00 00 00       	mov    esi,0x0
    3fa7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3fae:	e8 00 00 00 00       	call   3fb3 <ahci_device_init+0x246>
    3fb3:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!mem)
    3fb7:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    3fbc:	75 0a                	jne    3fc8 <ahci_device_init+0x25b>
						return -ENOMEM;
    3fbe:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3fc3:	e9 f9 06 00 00       	jmp    46c1 <ahci_device_init+0x954>
				d->ressources[5].mmio.mapping = mem;
    3fc8:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3fcf:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    3fd3:	48 89 90 e0 00 00 00 	mov    QWORD PTR [rax+0xe0],rdx
		}

		/* we now have a working mapping */
		struct ahci_hba* h = d->ressources[5].mmio.mapping;
    3fda:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    3fe1:	48 8b 80 e0 00 00 00 	mov    rax,QWORD PTR [rax+0xe0]
    3fe8:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		struct ahci_device* ad = kzalloc(sizeof(*ad));
    3fec:	bf 58 0b 00 00       	mov    edi,0xb58
    3ff1:	e8 00 00 00 00       	call   3ff6 <ahci_device_init+0x289>
    3ff6:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		if (!ad)
    3ffa:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
    3fff:	75 0a                	jne    400b <ahci_device_init+0x29e>
				return -ENOMEM;
    4001:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    4006:	e9 b6 06 00 00       	jmp    46c1 <ahci_device_init+0x954>

		/* check for AE (access to other registers is disallowed before) */
		if (!(h->control & GHC_CNT_AE)) {
    400b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    400f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    4012:	85 c0                	test   eax,eax
    4014:	78 26                	js     403c <ahci_device_init+0x2cf>
				abprintf("switching to AHCI mode\n");
    4016:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    401d:	b8 00 00 00 00       	mov    eax,0x0
    4022:	e8 00 00 00 00       	call   4027 <ahci_device_init+0x2ba>
				h->control |= GHC_CNT_AE;
    4027:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    402b:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    402e:	0d 00 00 00 80       	or     eax,0x80000000
    4033:	89 c2                	mov    edx,eax
    4035:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4039:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		}

		/* fill the descriptors */
		ad->ptr = h; /* D2H is set but masked */
    403c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4040:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    4044:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		ad->dev = d;
    4048:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    404c:	48 8b 95 18 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xe8]
    4053:	48 89 10             	mov    QWORD PTR [rax],rdx
		ad->num_ports = min(h->cap.num_ports + 1, bsr(h->ports));
    4056:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    405a:	8b 00                	mov    eax,DWORD PTR [rax]
    405c:	83 e0 1f             	and    eax,0x1f
    405f:	0f b6 c0             	movzx  eax,al
    4062:	8d 58 01             	lea    ebx,[rax+0x1]
    4065:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4069:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    406c:	89 c7                	mov    edi,eax
    406e:	e8 8d bf ff ff       	call   0 <bsr>
    4073:	39 c3                	cmp    ebx,eax
    4075:	7d 11                	jge    4088 <ahci_device_init+0x31b>
    4077:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    407b:	8b 00                	mov    eax,DWORD PTR [rax]
    407d:	83 e0 1f             	and    eax,0x1f
    4080:	0f b6 c0             	movzx  eax,al
    4083:	8d 50 01             	lea    edx,[rax+0x1]
    4086:	eb 10                	jmp    4098 <ahci_device_init+0x32b>
    4088:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    408c:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    408f:	89 c7                	mov    edi,eax
    4091:	e8 6a bf ff ff       	call   0 <bsr>
    4096:	89 c2                	mov    edx,eax
    4098:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    409c:	66 89 50 10          	mov    WORD PTR [rax+0x10],dx
		ad->num_cmd = h->cap.num_cmd + 1;
    40a0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    40a4:	8b 00                	mov    eax,DWORD PTR [rax]
    40a6:	c1 e8 08             	shr    eax,0x8
    40a9:	83 e0 1f             	and    eax,0x1f
    40ac:	0f b6 c0             	movzx  eax,al
    40af:	8d 50 01             	lea    edx,[rax+0x1]
    40b2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    40b6:	66 89 50 12          	mov    WORD PTR [rax+0x12],dx
		for (int i = 0; i < 32; i++) {
    40ba:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [rbp-0x28],0x0
    40c1:	e9 62 01 00 00       	jmp    4228 <ahci_device_init+0x4bb>
				ad->pending_cmds[i] = LIST_HEAD_INIT(ad->pending_cmds[i]);
    40c6:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    40c9:	48 63 d0             	movsxd rdx,eax
    40cc:	48 89 d0             	mov    rax,rdx
    40cf:	48 01 c0             	add    rax,rax
    40d2:	48 01 d0             	add    rax,rdx
    40d5:	48 c1 e0 03          	shl    rax,0x3
    40d9:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    40e0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    40e4:	48 8d 34 02          	lea    rsi,[rdx+rax*1]
    40e8:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    40eb:	48 63 d0             	movsxd rdx,eax
    40ee:	48 89 d0             	mov    rax,rdx
    40f1:	48 01 c0             	add    rax,rax
    40f4:	48 01 d0             	add    rax,rdx
    40f7:	48 c1 e0 03          	shl    rax,0x3
    40fb:	48 8d 90 20 05 00 00 	lea    rdx,[rax+0x520]
    4102:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4106:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    410a:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    410e:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4111:	48 63 d0             	movsxd rdx,eax
    4114:	48 89 d0             	mov    rax,rdx
    4117:	48 01 c0             	add    rax,rax
    411a:	48 01 d0             	add    rax,rdx
    411d:	48 c1 e0 03          	shl    rax,0x3
    4121:	48 01 f8             	add    rax,rdi
    4124:	48 05 20 05 00 00    	add    rax,0x520
    412a:	48 89 30             	mov    QWORD PTR [rax],rsi
    412d:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    4131:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4134:	48 63 d0             	movsxd rdx,eax
    4137:	48 89 d0             	mov    rax,rdx
    413a:	48 01 c0             	add    rax,rax
    413d:	48 01 d0             	add    rax,rdx
    4140:	48 c1 e0 03          	shl    rax,0x3
    4144:	48 01 f0             	add    rax,rsi
    4147:	48 05 28 05 00 00    	add    rax,0x528
    414d:	48 89 08             	mov    QWORD PTR [rax],rcx
    4150:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    4154:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4157:	48 63 d0             	movsxd rdx,eax
    415a:	48 89 d0             	mov    rax,rdx
    415d:	48 01 c0             	add    rax,rax
    4160:	48 01 d0             	add    rax,rdx
    4163:	48 c1 e0 03          	shl    rax,0x3
    4167:	48 01 c8             	add    rax,rcx
    416a:	48 05 30 05 00 00    	add    rax,0x530
    4170:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
				ad->proc_cmds[i] = LIST_HEAD_INIT(ad->proc_cmds[i]);
    4175:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4178:	48 63 d0             	movsxd rdx,eax
    417b:	48 89 d0             	mov    rax,rdx
    417e:	48 01 c0             	add    rax,rax
    4181:	48 01 d0             	add    rax,rdx
    4184:	48 c1 e0 03          	shl    rax,0x3
    4188:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    418f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4193:	48 8d 34 02          	lea    rsi,[rdx+rax*1]
    4197:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    419a:	48 63 d0             	movsxd rdx,eax
    419d:	48 89 d0             	mov    rax,rdx
    41a0:	48 01 c0             	add    rax,rax
    41a3:	48 01 d0             	add    rax,rdx
    41a6:	48 c1 e0 03          	shl    rax,0x3
    41aa:	48 8d 90 20 08 00 00 	lea    rdx,[rax+0x820]
    41b1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    41b5:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    41b9:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    41bd:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    41c0:	48 63 d0             	movsxd rdx,eax
    41c3:	48 89 d0             	mov    rax,rdx
    41c6:	48 01 c0             	add    rax,rax
    41c9:	48 01 d0             	add    rax,rdx
    41cc:	48 c1 e0 03          	shl    rax,0x3
    41d0:	48 01 f8             	add    rax,rdi
    41d3:	48 05 20 08 00 00    	add    rax,0x820
    41d9:	48 89 30             	mov    QWORD PTR [rax],rsi
    41dc:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    41e0:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    41e3:	48 63 d0             	movsxd rdx,eax
    41e6:	48 89 d0             	mov    rax,rdx
    41e9:	48 01 c0             	add    rax,rax
    41ec:	48 01 d0             	add    rax,rdx
    41ef:	48 c1 e0 03          	shl    rax,0x3
    41f3:	48 01 f0             	add    rax,rsi
    41f6:	48 05 28 08 00 00    	add    rax,0x828
    41fc:	48 89 08             	mov    QWORD PTR [rax],rcx
    41ff:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    4203:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    4206:	48 63 d0             	movsxd rdx,eax
    4209:	48 89 d0             	mov    rax,rdx
    420c:	48 01 c0             	add    rax,rax
    420f:	48 01 d0             	add    rax,rdx
    4212:	48 c1 e0 03          	shl    rax,0x3
    4216:	48 01 c8             	add    rax,rcx
    4219:	48 05 30 08 00 00    	add    rax,0x830
    421f:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
		for (int i = 0; i < 32; i++) {
    4224:	83 45 d8 01          	add    DWORD PTR [rbp-0x28],0x1
    4228:	83 7d d8 1f          	cmp    DWORD PTR [rbp-0x28],0x1f
    422c:	0f 8e 94 fe ff ff    	jle    40c6 <ahci_device_init+0x359>
		}
		ad->ctxs = LIST_HEAD_INIT(ad->ctxs);
    4232:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4236:	48 8d 88 28 0b 00 00 	lea    rcx,[rax+0xb28]
    423d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4241:	48 8d 90 28 0b 00 00 	lea    rdx,[rax+0xb28]
    4248:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    424c:	48 89 88 28 0b 00 00 	mov    QWORD PTR [rax+0xb28],rcx
    4253:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4257:	48 89 90 30 0b 00 00 	mov    QWORD PTR [rax+0xb30],rdx
    425e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4262:	66 c7 80 38 0b 00 00 00 00 	mov    WORD PTR [rax+0xb38],0x0
		ad->wh = WAIT_QUEUE_HEAD(ad->wh);
    426b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    426f:	48 8d 88 40 0b 00 00 	lea    rcx,[rax+0xb40]
    4276:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    427a:	48 8d 90 40 0b 00 00 	lea    rdx,[rax+0xb40]
    4281:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4285:	48 89 88 40 0b 00 00 	mov    QWORD PTR [rax+0xb40],rcx
    428c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4290:	48 89 90 48 0b 00 00 	mov    QWORD PTR [rax+0xb48],rdx
    4297:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    429b:	66 c7 80 50 0b 00 00 00 00 	mov    WORD PTR [rax+0xb50],0x0
    42a4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    42a8:	c7 80 54 0b 00 00 00 00 00 00 	mov    DWORD PTR [rax+0xb54],0x0

#ifdef AHCIBABBLE /* Tell the world about it */
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    42b2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42b6:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42b9:	0f b6 f8             	movzx  edi,al
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    42bc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42c0:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    42c3:	c1 e8 08             	shr    eax,0x8
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42c6:	0f b6 d0             	movzx  edx,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    42c9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42cd:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    42d0:	c1 e8 10             	shr    eax,0x10
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42d3:	0f b6 c0             	movzx  eax,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    42d6:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    42da:	8b 49 10             	mov    ecx,DWORD PTR [rcx+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    42dd:	c1 e9 18             	shr    ecx,0x18
    42e0:	89 ce                	mov    esi,ecx
    42e2:	41 89 f8             	mov    r8d,edi
    42e5:	89 d1                	mov    ecx,edx
    42e7:	89 c2                	mov    edx,eax
    42e9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    42f0:	b8 00 00 00 00       	mov    eax,0x0
    42f5:	e8 00 00 00 00       	call   42fa <ahci_device_init+0x58d>
		/* and print the capablilities */
		printf("Features: %s%s%sspeed: %s\n",
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
				capstr(h->cap.if_speed, 4, "res", "1.5 Gbps", "3 Gbps", "6Gbps", ">6Gbps"));
    42fa:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    42fe:	8b 00                	mov    eax,DWORD PTR [rax]
    4300:	c1 e8 14             	shr    eax,0x14
    4303:	83 e0 0f             	and    eax,0xf
		printf("Features: %s%s%sspeed: %s\n",
    4306:	0f b6 c0             	movzx  eax,al
    4309:	48 c7 04 24 00 00 00 00 	mov    QWORD PTR [rsp],0x0
    4311:	49 c7 c1 00 00 00 00 	mov    r9,0x0
    4318:	49 c7 c0 00 00 00 00 	mov    r8,0x0
    431f:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    4326:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    432d:	be 04 00 00 00       	mov    esi,0x4
    4332:	89 c7                	mov    edi,eax
    4334:	b8 00 00 00 00       	mov    eax,0x0
    4339:	e8 00 00 00 00       	call   433e <ahci_device_init+0x5d1>
    433e:	49 89 c5             	mov    r13,rax
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
    4341:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4345:	8b 00                	mov    eax,DWORD PTR [rax]
    4347:	c1 e8 1f             	shr    eax,0x1f
		printf("Features: %s%s%sspeed: %s\n",
    434a:	0f b6 c0             	movzx  eax,al
    434d:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    4354:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    435b:	be 01 00 00 00       	mov    esi,0x1
    4360:	89 c7                	mov    edi,eax
    4362:	b8 00 00 00 00       	mov    eax,0x0
    4367:	e8 00 00 00 00       	call   436c <ahci_device_init+0x5ff>
    436c:	49 89 c4             	mov    r12,rax
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
    436f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4373:	8b 00                	mov    eax,DWORD PTR [rax]
    4375:	c1 e8 12             	shr    eax,0x12
    4378:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    437b:	0f b6 c0             	movzx  eax,al
    437e:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    4385:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    438c:	be 01 00 00 00       	mov    esi,0x1
    4391:	89 c7                	mov    edi,eax
    4393:	b8 00 00 00 00       	mov    eax,0x0
    4398:	e8 00 00 00 00       	call   439d <ahci_device_init+0x630>
    439d:	48 89 c3             	mov    rbx,rax
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
    43a0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    43a4:	8b 00                	mov    eax,DWORD PTR [rax]
    43a6:	c1 e8 1e             	shr    eax,0x1e
    43a9:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    43ac:	0f b6 c0             	movzx  eax,al
    43af:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    43b6:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    43bd:	be 01 00 00 00       	mov    esi,0x1
    43c2:	89 c7                	mov    edi,eax
    43c4:	b8 00 00 00 00       	mov    eax,0x0
    43c9:	e8 00 00 00 00       	call   43ce <ahci_device_init+0x661>
    43ce:	4d 89 e8             	mov    r8,r13
    43d1:	4c 89 e1             	mov    rcx,r12
    43d4:	48 89 da             	mov    rdx,rbx
    43d7:	48 89 c6             	mov    rsi,rax
    43da:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    43e1:	b8 00 00 00 00       	mov    eax,0x0
    43e6:	e8 00 00 00 00       	call   43eb <ahci_device_init+0x67e>
		printf("AHCI HBA has %u ports and %u command slots\n",
				ad->num_ports, ad->num_cmd);
    43eb:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    43ef:	0f b7 40 12          	movzx  eax,WORD PTR [rax+0x12]
		printf("AHCI HBA has %u ports and %u command slots\n",
    43f3:	0f b7 d0             	movzx  edx,ax
				ad->num_ports, ad->num_cmd);
    43f6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    43fa:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
		printf("AHCI HBA has %u ports and %u command slots\n",
    43fe:	0f b7 c0             	movzx  eax,ax
    4401:	89 c6                	mov    esi,eax
    4403:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    440a:	b8 00 00 00 00       	mov    eax,0x0
    440f:	e8 00 00 00 00       	call   4414 <ahci_device_init+0x6a7>
#endif

		/* transfer ownership (incl NMI) */
		if (h->cap2.boh) {
    4414:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    4418:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    441b:	83 e0 01             	and    eax,0x1
    441e:	84 c0                	test   al,al
    4420:	74 29                	je     444b <ahci_device_init+0x6de>
				rv = ahci_do_bohc(ad);
    4422:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4426:	48 89 c7             	mov    rdi,rax
    4429:	e8 00 00 00 00       	call   442e <ahci_device_init+0x6c1>
    442e:	89 45 a4             	mov    DWORD PTR [rbp-0x5c],eax
				if (rv) {
    4431:	83 7d a4 00          	cmp    DWORD PTR [rbp-0x5c],0x0
    4435:	74 14                	je     444b <ahci_device_init+0x6de>
						kfree(ad);
    4437:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    443b:	48 89 c7             	mov    rdi,rax
    443e:	e8 00 00 00 00       	call   4443 <ahci_device_init+0x6d6>
						return rv;
    4443:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    4446:	e9 76 02 00 00       	jmp    46c1 <ahci_device_init+0x954>
				}
		}

		/* disable every possible interrupt */
		if(pci_disable_interrupts(d))
    444b:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    4452:	48 89 c7             	mov    rdi,rax
    4455:	e8 00 00 00 00       	call   445a <ahci_device_init+0x6ed>
    445a:	85 c0                	test   eax,eax
    445c:	74 30                	je     448e <ahci_device_init+0x721>
				die("not possible!\n");
    445e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4465:	bf 0c 00 00 00       	mov    edi,0xc
    446a:	b8 00 00 00 00       	mov    eax,0x0
    446f:	e8 00 00 00 00       	call   4474 <ahci_device_init+0x707>
    4474:	b8 00 00 00 00       	mov    eax,0x0
    4479:	e8 00 00 00 00       	call   447e <ahci_device_init+0x711>
    447e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4485:	e8 00 00 00 00       	call   448a <ahci_device_init+0x71d>
    448a:	fa                   	cli
    448b:	f4                   	hlt
    448c:	eb fd                	jmp    448b <ahci_device_init+0x71e>

		/* Stop the running ports */
		for (int i = 0; i < ad->num_ports; i++)
    448e:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0
    4495:	eb 15                	jmp    44ac <ahci_device_init+0x73f>
				ahci_stop_port(ad, i);
    4497:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    449a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    449e:	89 d6                	mov    esi,edx
    44a0:	48 89 c7             	mov    rdi,rax
    44a3:	e8 00 00 00 00       	call   44a8 <ahci_device_init+0x73b>
		for (int i = 0; i < ad->num_ports; i++)
    44a8:	83 45 d4 01          	add    DWORD PTR [rbp-0x2c],0x1
    44ac:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44b0:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    44b4:	0f b7 c0             	movzx  eax,ax
    44b7:	39 45 d4             	cmp    DWORD PTR [rbp-0x2c],eax
    44ba:	7c db                	jl     4497 <ahci_device_init+0x72a>

		/* clear all interrupts and install the handler */
		ahci_clear_interrupts(ad); /* PCI disabled MSI and we're currently */
    44bc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44c0:	48 89 c7             	mov    rdi,rax
    44c3:	e8 00 00 00 00       	call   44c8 <ahci_device_init+0x75b>
		install_irq_handler(ad->dev->intr_line, ahci_irq); /* not using it */
    44c8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44cc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    44cf:	0f b6 40 09          	movzx  eax,BYTE PTR [rax+0x9]
    44d3:	0f b6 c0             	movzx  eax,al
    44d6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    44dd:	89 c7                	mov    edi,eax
    44df:	e8 00 00 00 00       	call   44e4 <ahci_device_init+0x777>
		/* TODO: do proper assigment */

		/* assign the command lists and the FIS buffers */
		ahci_assign_buffers(ad);
    44e4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    44e8:	48 89 c7             	mov    rdi,rax
    44eb:	e8 00 00 00 00       	call   44f0 <ahci_device_init+0x783>

		/* print them */
		for (int i = 0; i < ad->num_ports; i++) {
    44f0:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
    44f7:	e9 df 00 00 00       	jmp    45db <ahci_device_init+0x86e>
				printf("port%d: %016llx %016llx %p %p\n", i,
    44fc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4500:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    4503:	48 63 d2             	movsxd rdx,edx
    4506:	48 83 c2 22          	add    rdx,0x22
    450a:	48 8b 7c d0 08       	mov    rdi,QWORD PTR [rax+rdx*8+0x8]
    450f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4513:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    4516:	48 63 d2             	movsxd rdx,edx
    4519:	48 83 c2 02          	add    rdx,0x2
    451d:	48 8b 74 d0 08       	mov    rsi,QWORD PTR [rax+rdx*8+0x8]
						ad->ptr->port[i].pXclb64,
						ad->ptr->port[i].pXfb64,
    4522:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4526:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
				printf("port%d: %016llx %016llx %p %p\n", i,
    452a:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    452d:	48 63 d2             	movsxd rdx,edx
    4530:	48 83 c2 02          	add    rdx,0x2
    4534:	48 c1 e2 07          	shl    rdx,0x7
    4538:	48 01 d0             	add    rax,rdx
    453b:	48 83 c0 08          	add    rax,0x8
    453f:	48 8b 08             	mov    rcx,QWORD PTR [rax]
						ad->ptr->port[i].pXclb64,
    4542:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4546:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
				printf("port%d: %016llx %016llx %p %p\n", i,
    454a:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    454d:	48 63 d2             	movsxd rdx,edx
    4550:	48 83 c2 02          	add    rdx,0x2
    4554:	48 c1 e2 07          	shl    rdx,0x7
    4558:	48 01 d0             	add    rax,rdx
    455b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    455e:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    4561:	49 89 f9             	mov    r9,rdi
    4564:	49 89 f0             	mov    r8,rsi
    4567:	89 c6                	mov    esi,eax
    4569:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4570:	b8 00 00 00 00       	mov    eax,0x0
    4575:	e8 00 00 00 00       	call   457a <ahci_device_init+0x80d>
						ad->command_lists[i],
						ad->recv_fis[i]);
				printf("       %016llx %p\n", ad->identify_data[i].pm,
    457a:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    457e:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    4581:	48 63 d0             	movsxd rdx,eax
    4584:	48 89 d0             	mov    rax,rdx
    4587:	48 01 c0             	add    rax,rax
    458a:	48 01 d0             	add    rax,rdx
    458d:	48 c1 e0 03          	shl    rax,0x3
    4591:	48 01 c8             	add    rax,rcx
    4594:	48 05 20 02 00 00    	add    rax,0x220
    459a:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    459d:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    45a1:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    45a4:	48 63 d0             	movsxd rdx,eax
    45a7:	48 89 d0             	mov    rax,rdx
    45aa:	48 01 c0             	add    rax,rax
    45ad:	48 01 d0             	add    rax,rdx
    45b0:	48 c1 e0 03          	shl    rax,0x3
    45b4:	48 01 f0             	add    rax,rsi
    45b7:	48 05 28 02 00 00    	add    rax,0x228
    45bd:	48 8b 00             	mov    rax,QWORD PTR [rax]
    45c0:	48 89 ca             	mov    rdx,rcx
    45c3:	48 89 c6             	mov    rsi,rax
    45c6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    45cd:	b8 00 00 00 00       	mov    eax,0x0
    45d2:	e8 00 00 00 00       	call   45d7 <ahci_device_init+0x86a>
		for (int i = 0; i < ad->num_ports; i++) {
    45d7:	83 45 d0 01          	add    DWORD PTR [rbp-0x30],0x1
    45db:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    45df:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    45e3:	0f b7 c0             	movzx  eax,ax
    45e6:	39 45 d0             	cmp    DWORD PTR [rbp-0x30],eax
    45e9:	0f 8c 0d ff ff ff    	jl     44fc <ahci_device_init+0x78f>
						ad->identify_data[i].ptr);
		}

		/* allow the device to write to our memory */
		pci_set_master(d);
    45ef:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    45f6:	48 89 c7             	mov    rdi,rax
    45f9:	e8 00 00 00 00       	call   45fe <ahci_device_init+0x891>

		/* reenable the ports */
		for (int i = 0; i < ad->num_ports; i++)
    45fe:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
    4605:	eb 15                	jmp    461c <ahci_device_init+0x8af>
				ahci_enable_port(ad, i);
    4607:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
    460a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    460e:	89 d6                	mov    esi,edx
    4610:	48 89 c7             	mov    rdi,rax
    4613:	e8 00 00 00 00       	call   4618 <ahci_device_init+0x8ab>
		for (int i = 0; i < ad->num_ports; i++)
    4618:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
    461c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4620:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    4624:	0f b7 c0             	movzx  eax,ax
    4627:	39 45 cc             	cmp    DWORD PTR [rbp-0x34],eax
    462a:	7c db                	jl     4607 <ahci_device_init+0x89a>

		/* add the device to the list */
		struct ale* le = kzalloc(sizeof(*le));
    462c:	bf 20 00 00 00       	mov    edi,0x20
    4631:	e8 00 00 00 00       	call   4636 <ahci_device_init+0x8c9>
    4636:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
		le->dev = ad;
    463a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    463e:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    4642:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
		list_add_tail(&le->devs, &ahci_dl.devs);
    4646:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    464a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4651:	48 89 c7             	mov    rdi,rax
    4654:	e8 c5 ba ff ff       	call   11e <list_add_tail>

		/* allocate the pool */
		ad->ctbl_pool = ahci_allocate_command_table_pool(
				32, 8, h->cap.is_64bit);
    4659:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    465d:	8b 00                	mov    eax,DWORD PTR [rax]
    465f:	c1 e8 1f             	shr    eax,0x1f
		ad->ctbl_pool = ahci_allocate_command_table_pool(
    4662:	0f b6 c0             	movzx  eax,al
    4665:	89 c2                	mov    edx,eax
    4667:	be 08 00 00 00       	mov    esi,0x8
    466c:	bf 20 00 00 00       	mov    edi,0x20
    4671:	e8 00 00 00 00       	call   4676 <ahci_device_init+0x909>
    4676:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    467a:	48 89 82 18 05 00 00 	mov    QWORD PTR [rdx+0x518],rax

		/* launch the worker */
		task_spawn(ahci_worker, ad, PRIORITY_ELEVATED);
    4681:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    4685:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    468c:	ba 01 00 00 00       	mov    edx,0x1
    4691:	48 89 c6             	mov    rsi,rax
    4694:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    469b:	e8 00 00 00 00       	call   46a0 <ahci_device_init+0x933>

		/* reenable interrupts */
		/* The port_enable function already set the per-port values */
		h->ctrl.ie = 1;
    46a0:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    46a4:	8b 42 04             	mov    eax,DWORD PTR [rdx+0x4]
    46a7:	83 c8 02             	or     eax,0x2
    46aa:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
		pci_enable_interrupts(d);
    46ad:	48 8b 85 18 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe8]
    46b4:	48 89 c7             	mov    rdi,rax
    46b7:	e8 00 00 00 00       	call   46bc <ahci_device_init+0x94f>

		return 0;
    46bc:	b8 00 00 00 00       	mov    eax,0x0
}
    46c1:	48 81 c4 e8 00 00 00 	add    rsp,0xe8
    46c8:	5b                   	pop    rbx
    46c9:	41 5c                	pop    r12
    46cb:	41 5d                	pop    r13
    46cd:	5d                   	pop    rbp
    46ce:	c3                   	ret

00000000000046cf <module_init>:

int MODENTRY module_init()
{
    46cf:	55                   	push   rbp
    46d0:	48 89 e5             	mov    rbp,rsp
    46d3:	48 83 ec 20          	sub    rsp,0x20
		printf("AHCI initialization...\n");
    46d7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    46de:	b8 00 00 00 00       	mov    eax,0x0
    46e3:	e8 00 00 00 00       	call   46e8 <module_init+0x19>
		struct pci_device* dev; int ct = 0, nc = 0, nf = 0;
    46e8:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    46ef:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    46f6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    46fd:	e9 96 00 00 00       	jmp    4798 <module_init+0xc9>
				int rv;
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
						dev->addr.device_no, dev->addr.func_no);
    4702:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4706:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    470a:	83 e0 07             	and    eax,0x7
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    470d:	0f b6 c8             	movzx  ecx,al
						dev->addr.device_no, dev->addr.func_no);
    4710:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4714:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    4718:	c0 e8 03             	shr    al,0x3
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    471b:	0f b6 d0             	movzx  edx,al
    471e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4722:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
    4726:	0f b6 c0             	movzx  eax,al
    4729:	89 c6                	mov    esi,eax
    472b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4732:	b8 00 00 00 00       	mov    eax,0x0
    4737:	e8 00 00 00 00       	call   473c <module_init+0x6d>
				printf("Attempting initialization...\n");
    473c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4743:	b8 00 00 00 00       	mov    eax,0x0
    4748:	e8 00 00 00 00       	call   474d <module_init+0x7e>
				rv = ahci_device_init(dev);
    474d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4751:	48 89 c7             	mov    rdi,rax
    4754:	e8 00 00 00 00       	call   4759 <module_init+0x8a>
    4759:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				if (rv) {
    475c:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
    4760:	74 1c                	je     477e <module_init+0xaf>
						cprintf(KFMT_ERROR, "Initialization of this device failed.\n");
    4762:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4769:	bf 0c 00 00 00       	mov    edi,0xc
    476e:	b8 00 00 00 00       	mov    eax,0x0
    4773:	e8 00 00 00 00       	call   4778 <module_init+0xa9>
						nf++;
    4778:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    477c:	eb 1a                	jmp    4798 <module_init+0xc9>
				} else {
						cprintf(KFMT_OK, "Initialization of AHCI HBA succeeded.\n");
    477e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4785:	bf 0a 00 00 00       	mov    edi,0xa
    478a:	b8 00 00 00 00       	mov    eax,0x0
    478f:	e8 00 00 00 00       	call   4794 <module_init+0xc5>
						nc++;
    4794:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    4798:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    479b:	8d 50 01             	lea    edx,[rax+0x1]
    479e:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    47a1:	89 c1                	mov    ecx,eax
    47a3:	ba 01 00 00 00       	mov    edx,0x1
    47a8:	be 06 00 00 00       	mov    esi,0x6
    47ad:	bf 01 00 00 00       	mov    edi,0x1
    47b2:	e8 00 00 00 00       	call   47b7 <module_init+0xe8>
    47b7:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    47bb:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    47c0:	0f 85 3c ff ff ff    	jne    4702 <module_init+0x33>
				}
		}
		/* Summary */
		cprintf(nf ? KFMT_WARN : KFMT_OK, "Initialized %d AHCI Host Bus Adapters. (%d failed)\n", nc, nf);
    47c6:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    47ca:	74 07                	je     47d3 <module_init+0x104>
    47cc:	bf 0e 00 00 00       	mov    edi,0xe
    47d1:	eb 05                	jmp    47d8 <module_init+0x109>
    47d3:	bf 0a 00 00 00       	mov    edi,0xa
    47d8:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    47db:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    47de:	89 d1                	mov    ecx,edx
    47e0:	89 c2                	mov    edx,eax
    47e2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    47e9:	b8 00 00 00 00       	mov    eax,0x0
    47ee:	e8 00 00 00 00       	call   47f3 <module_init+0x124>
		return 0;
    47f3:	b8 00 00 00 00       	mov    eax,0x0
}
    47f8:	c9                   	leave
    47f9:	c3                   	ret

00000000000047fa <module_cleanup>:

void MODENTRY module_cleanup()
{
    47fa:	55                   	push   rbp
    47fb:	48 89 e5             	mov    rbp,rsp
}
    47fe:	90                   	nop
    47ff:	5d                   	pop    rbp
    4800:	c3                   	ret
