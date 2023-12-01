
ahci.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <bsr>:
		} clh;
		struct ahci_ct_e* entry;
		uint32_t max_prdtl;
}; /* 70bt size -> slab allocator? DONE */

struct ahci_ct_pool {
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		uint32_t prdt_cap;
		struct ahci_ct_pool* next;
       6:	0f bd 45 08          	bsr    eax,DWORD PTR [ebp+0x8]
       a:	75 05                	jne    11 <bsr+0x11>
       c:	b8 ff ff ff ff       	mov    eax,0xffffffff
      11:	40                   	inc    eax
      12:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint32_t mask; /* not alloc always 1 */
		struct ahci_ct_e {
				uint16_t port, slot; /* dbg info? */
				struct ahci_cmdtbl* ptr;
      15:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
				uint64_t pmem;
      18:	c9                   	leave
      19:	c3                   	ret

0000001a <bsf>:
		} tables[32];
};
      1a:	55                   	push   ebp
      1b:	89 e5                	mov    ebp,esp
      1d:	83 ec 10             	sub    esp,0x10

/* Forward declarations:
      20:	0f bc 45 08          	bsf    eax,DWORD PTR [ebp+0x8]
      24:	75 05                	jne    2b <bsf+0x11>
      26:	b8 ff ff ff ff       	mov    eax,0xffffffff
      2b:	40                   	inc    eax
      2c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
 * */
void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st);
void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc);
      2f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
int ahci_handle_command_error(struct ahci_device* ad, struct cmd_ctx* cc, uint32_t tfd);
      32:	c9                   	leave
      33:	c3                   	ret

00000034 <__list_add>:
		/* limit is 4MiB per PRDT (BUT! PM!=contiguous) */
find:
		if (!cc->entry) /* else: max_prdtl still valid */
				cc->entry = ahci_find_cmdtbl(ad, ct);
		if (cc->entry) {
				cc->entry->port = cc->port;
      34:	55                   	push   ebp
      35:	89 e5                	mov    ebp,esp
				cc->entry->slot = slt;
      37:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      3a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      3d:	89 10                	mov    DWORD PTR [eax],edx
				cc->slot = slt;
      3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      42:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
      45:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		} else
      48:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      4b:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      4e:	89 10                	mov    DWORD PTR [eax],edx
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);
      50:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      53:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      56:	89 50 04             	mov    DWORD PTR [eax+0x4],edx

      59:	90                   	nop
      5a:	5d                   	pop    ebp
      5b:	c3                   	ret

0000005c <__list_del>:
		if (!cc->entry && ct > 8) { /* divide by twoish */
				int log = bsr(ct) - 1;
				uint32_t new_ct = (1 << log);
      5c:	55                   	push   ebp
      5d:	89 e5                	mov    ebp,esp
				if (new_ct == ct)
      5f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      62:	8b 00                	mov    eax,DWORD PTR [eax]
      64:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      67:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
      6a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						new_ct >>= 1;
      6d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      70:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
      73:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      76:	8b 12                	mov    edx,DWORD PTR [edx]
      78:	89 10                	mov    DWORD PTR [eax],edx
				ct = new_ct;
      7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      7d:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
				goto find;
      84:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      87:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		} else if (!cc->entry) { /* none available */
      8d:	90                   	nop
      8e:	5d                   	pop    ebp
      8f:	c3                   	ret

00000090 <list_add>:
				/* skip command processing on this port */
				abprintf("waiting for cmdtbl to become available.\n");
				list_add(&cc->lst, lh);
      90:	55                   	push   ebp
      91:	89 e5                	mov    ebp,esp
      93:	83 ec 08             	sub    esp,0x8
				return;
      96:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      99:	83 c0 08             	add    eax,0x8
      9c:	83 ec 0c             	sub    esp,0xc
      9f:	50                   	push   eax
      a0:	e8 fc ff ff ff       	call   a1 <list_add+0x11>
      a5:	83 c4 10             	add    esp,0x10
		}
      a8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      ab:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
      ae:	83 ec 04             	sub    esp,0x4
      b1:	50                   	push   eax
      b2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
      b5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
      b8:	e8 77 ff ff ff       	call   34 <__list_add>
      bd:	83 c4 10             	add    esp,0x10

      c0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      c3:	83 c0 08             	add    eax,0x8
      c6:	83 ec 0c             	sub    esp,0xc
      c9:	50                   	push   eax
      ca:	e8 fc ff ff ff       	call   cb <list_add+0x3b>
      cf:	83 c4 10             	add    esp,0x10
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
      d2:	90                   	nop
      d3:	c9                   	leave
      d4:	c3                   	ret

000000d5 <list_add_tail>:
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
		/* now build the command */
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
      d5:	55                   	push   ebp
      d6:	89 e5                	mov    ebp,esp
      d8:	83 ec 08             	sub    esp,0x8
		if (p->cmd.atapi) { /* ATAPI */
      db:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      de:	83 c0 08             	add    eax,0x8
      e1:	83 ec 0c             	sub    esp,0xc
      e4:	50                   	push   eax
      e5:	e8 fc ff ff ff       	call   e6 <list_add_tail+0x11>
      ea:	83 c4 10             	add    esp,0x10
				switch (cc->c) {
      ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      f0:	8b 00                	mov    eax,DWORD PTR [eax]
      f2:	83 ec 04             	sub    esp,0x4
      f5:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
      f8:	50                   	push   eax
      f9:	ff 75 08             	push   DWORD PTR [ebp+0x8]
      fc:	e8 33 ff ff ff       	call   34 <__list_add>
     101:	83 c4 10             	add    esp,0x10
						case disk_cmd_identify:
     104:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     107:	83 c0 08             	add    eax,0x8
     10a:	83 ec 0c             	sub    esp,0xc
     10d:	50                   	push   eax
     10e:	e8 fc ff ff ff       	call   10f <list_add_tail+0x3a>
     113:	83 c4 10             	add    esp,0x10
								rv = atapi_build_packet_device_identify(ad, cc);
     116:	90                   	nop
     117:	c9                   	leave
     118:	c3                   	ret

00000119 <list_del>:
								break;
						case disk_cmd_read:
						case disk_cmd_write:
     119:	55                   	push   ebp
     11a:	89 e5                	mov    ebp,esp
     11c:	83 ec 08             	sub    esp,0x8
						case disk_cmd_trim:
     11f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     122:	83 c0 08             	add    eax,0x8
     125:	83 ec 0c             	sub    esp,0xc
     128:	50                   	push   eax
     129:	e8 fc ff ff ff       	call   12a <list_del+0x11>
     12e:	83 c4 10             	add    esp,0x10
								die("not implemented yet!\n");
     131:	83 ec 0c             	sub    esp,0xc
     134:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     137:	e8 20 ff ff ff       	call   5c <__list_del>
     13c:	83 c4 10             	add    esp,0x10
								break;
     13f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     142:	83 c0 08             	add    eax,0x8
     145:	83 ec 0c             	sub    esp,0xc
     148:	50                   	push   eax
     149:	e8 fc ff ff ff       	call   14a <list_del+0x31>
     14e:	83 c4 10             	add    esp,0x10
						default:
     151:	90                   	nop
     152:	c9                   	leave
     153:	c3                   	ret

00000154 <list_empty>:
								die("The command %x should not end up here.\n", cc->c);
								break;
				}
     154:	55                   	push   ebp
     155:	89 e5                	mov    ebp,esp
		} else {
     157:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     15a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     15d:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     160:	0f 94 c0             	sete   al
     163:	0f b6 c0             	movzx  eax,al
				switch (cc->c) { /* ATA */
     166:	5d                   	pop    ebp
     167:	c3                   	ret

00000168 <checksum_memory>:
				}

		//		/* print the STATUS */
		//		cprintf(KFMT_WARN, "STATUS: diag=%x err=%x cmd=%x clb=%x\n",
		//						p->scr1.diag, p->scr1.err, p->pXcmd, p->pXclb);

     168:	55                   	push   ebp
     169:	89 e5                	mov    ebp,esp
     16b:	83 ec 10             	sub    esp,0x10
				/* and tell the IH about it */
     16e:	c6 45 ff 00          	mov    BYTE PTR [ebp-0x1],0x0
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
     172:	eb 0f                	jmp    183 <checksum_memory+0x1b>
				abprintf("issued the command successfully.\n");
     174:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     177:	8d 50 01             	lea    edx,[eax+0x1]
     17a:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
     17d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     180:	00 45 ff             	add    BYTE PTR [ebp-0x1],al
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
     183:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     186:	8d 50 ff             	lea    edx,[eax-0x1]
     189:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     18c:	85 c0                	test   eax,eax
     18e:	75 e4                	jne    174 <checksum_memory+0xc>
		} else {
     190:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
				/* slot became used: parallel access to
     194:	c9                   	leave
     195:	c3                   	ret

00000196 <convert_ata_string>:
		uint16_t checksum_validity : 8; /* 0xa5 */
		uint16_t checksum : 8; /* sum of all bytes incl. -> 0 */
} __attribute__ ((packed));

static inline void convert_ata_string(uint16_t* str, size_t len)
{
     196:	55                   	push   ebp
     197:	89 e5                	mov    ebp,esp
     199:	83 ec 10             	sub    esp,0x10
		size_t i; char* s = (char*)str;
     19c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     19f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		for (i = 0; i < len; i++) /* xchg ah, al */
     1a2:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     1a9:	eb 3b                	jmp    1e6 <convert_ata_string+0x50>
				str[i] = ((str[i] >> 8) | (str[i] << 8));
     1ab:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1ae:	8d 14 00             	lea    edx,[eax+eax*1]
     1b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1b4:	01 d0                	add    eax,edx
     1b6:	0f b7 00             	movzx  eax,WORD PTR [eax]
     1b9:	66 c1 e8 08          	shr    ax,0x8
     1bd:	89 c1                	mov    ecx,eax
     1bf:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1c2:	8d 14 00             	lea    edx,[eax+eax*1]
     1c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1c8:	01 d0                	add    eax,edx
     1ca:	0f b7 00             	movzx  eax,WORD PTR [eax]
     1cd:	c1 e0 08             	shl    eax,0x8
     1d0:	09 c1                	or     ecx,eax
     1d2:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1d5:	8d 14 00             	lea    edx,[eax+eax*1]
     1d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1db:	01 d0                	add    eax,edx
     1dd:	89 ca                	mov    edx,ecx
     1df:	66 89 10             	mov    WORD PTR [eax],dx
		for (i = 0; i < len; i++) /* xchg ah, al */
     1e2:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     1e6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1e9:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     1ec:	72 bd                	jb     1ab <convert_ata_string+0x15>
		/* possibly null terminate by eliminating spaces */
		i = 2 * i - 1;
     1ee:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1f1:	01 c0                	add    eax,eax
     1f3:	83 e8 01             	sub    eax,0x1
     1f6:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while (i && s[i] == ' ')
     1f9:	eb 04                	jmp    1ff <convert_ata_string+0x69>
				i--;
     1fb:	83 6d fc 01          	sub    DWORD PTR [ebp-0x4],0x1
		while (i && s[i] == ' ')
     1ff:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     203:	74 0f                	je     214 <convert_ata_string+0x7e>
     205:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
     208:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     20b:	01 d0                	add    eax,edx
     20d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     210:	3c 20                	cmp    al,0x20
     212:	74 e7                	je     1fb <convert_ata_string+0x65>
		if (i + 1 < len)
     214:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     217:	83 c0 01             	add    eax,0x1
     21a:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     21d:	73 0e                	jae    22d <convert_ata_string+0x97>
				s[i + 1] = '\0';
     21f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     222:	8d 50 01             	lea    edx,[eax+0x1]
     225:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     228:	01 d0                	add    eax,edx
     22a:	c6 00 00             	mov    BYTE PTR [eax],0x0
}
     22d:	90                   	nop
     22e:	c9                   	leave
     22f:	c3                   	ret

00000230 <ata_build_device_identify>:
{
     230:	55                   	push   ebp
     231:	89 e5                	mov    ebp,esp
     233:	53                   	push   ebx
     234:	83 ec 34             	sub    esp,0x34
		struct ahci_cmdtbl* t = ctx->entry->ptr;
     237:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     23a:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     23d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     240:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		struct sata_reg_h2d* r = &t->cfis.rh2d;
     243:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     246:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
     249:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     24c:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     24f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     252:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     259:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		uint16_t bc1 = 512, bc2 = 0;
     260:	66 c7 45 e6 00 02    	mov    WORD PTR [ebp-0x1a],0x200
     266:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
		if (ctx->max_prdtl < 1)
     26c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     26f:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     272:	85 c0                	test   eax,eax
     274:	75 0a                	jne    280 <ata_build_device_identify+0x50>
				return -1;
     276:	b8 ff ff ff ff       	mov    eax,0xffffffff
     27b:	e9 ab 03 00 00       	jmp    62b <ata_build_device_identify+0x3fb>
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
     280:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     283:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     286:	83 c0 08             	add    eax,0x8
     289:	c1 e0 04             	shl    eax,0x4
     28c:	83 ec 08             	sub    esp,0x8
     28f:	50                   	push   eax
     290:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     293:	e8 fc ff ff ff       	call   294 <ata_build_device_identify+0x64>
     298:	83 c4 10             	add    esp,0x10
		r->fis_type = FIS_REG_H2D;
     29b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     29e:	c6 00 27             	mov    BYTE PTR [eax],0x27
		r->pm_port = ctx->pmprt;
     2a1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     2a4:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     2a8:	83 e0 0f             	and    eax,0xf
     2ab:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     2ae:	83 e0 0f             	and    eax,0xf
     2b1:	89 c1                	mov    ecx,eax
     2b3:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     2b7:	83 e0 f0             	and    eax,0xfffffff0
     2ba:	09 c8                	or     eax,ecx
     2bc:	88 42 01             	mov    BYTE PTR [edx+0x1],al
		r->res0 = 0;
     2bf:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2c2:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     2c6:	83 e2 8f             	and    edx,0xffffff8f
     2c9:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->c = 1;
     2cc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2cf:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     2d3:	83 ca 80             	or     edx,0xffffff80
     2d6:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->command = ATA_CMD_IDENTIFY_DEVICE;
     2d9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2dc:	c6 40 02 ec          	mov    BYTE PTR [eax+0x2],0xec
		r->feat_high = r->feat_low = 0; /* N/A */
     2e0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2e3:	c6 40 03 00          	mov    BYTE PTR [eax+0x3],0x0
     2e7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2ea:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
     2ee:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2f1:	88 50 0b             	mov    BYTE PTR [eax+0xb],dl
		r->lba_high = r->lba_low = 0; /* N/A */
     2f4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2f7:	0f b6 50 04          	movzx  edx,BYTE PTR [eax+0x4]
     2fb:	83 e2 00             	and    edx,0x0
     2fe:	88 50 04             	mov    BYTE PTR [eax+0x4],dl
     301:	0f b6 50 05          	movzx  edx,BYTE PTR [eax+0x5]
     305:	83 e2 00             	and    edx,0x0
     308:	88 50 05             	mov    BYTE PTR [eax+0x5],dl
     30b:	0f b6 50 06          	movzx  edx,BYTE PTR [eax+0x6]
     30f:	83 e2 00             	and    edx,0x0
     312:	88 50 06             	mov    BYTE PTR [eax+0x6],dl
     315:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     318:	0f b6 50 04          	movzx  edx,BYTE PTR [eax+0x4]
     31c:	0f b6 48 05          	movzx  ecx,BYTE PTR [eax+0x5]
     320:	c1 e1 08             	shl    ecx,0x8
     323:	09 ca                	or     edx,ecx
     325:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
     329:	c1 e0 10             	shl    eax,0x10
     32c:	09 d0                	or     eax,edx
     32e:	89 c2                	mov    edx,eax
     330:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     333:	0f b6 da             	movzx  ebx,dl
     336:	0f b6 48 08          	movzx  ecx,BYTE PTR [eax+0x8]
     33a:	83 e1 00             	and    ecx,0x0
     33d:	09 d9                	or     ecx,ebx
     33f:	88 48 08             	mov    BYTE PTR [eax+0x8],cl
     342:	89 d1                	mov    ecx,edx
     344:	c1 e9 08             	shr    ecx,0x8
     347:	0f b6 d9             	movzx  ebx,cl
     34a:	0f b6 48 09          	movzx  ecx,BYTE PTR [eax+0x9]
     34e:	83 e1 00             	and    ecx,0x0
     351:	09 d9                	or     ecx,ebx
     353:	88 48 09             	mov    BYTE PTR [eax+0x9],cl
     356:	c1 ea 10             	shr    edx,0x10
     359:	0f b6 ca             	movzx  ecx,dl
     35c:	0f b6 50 0a          	movzx  edx,BYTE PTR [eax+0xa]
     360:	83 e2 00             	and    edx,0x0
     363:	09 ca                	or     edx,ecx
     365:	88 50 0a             	mov    BYTE PTR [eax+0xa],dl
		r->count = 0; /* N/A */
     368:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     36b:	66 c7 40 0c 00 00    	mov    WORD PTR [eax+0xc],0x0
		r->device = 0; /* bit4 is transport dependent */
     371:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     374:	c6 40 07 00          	mov    BYTE PTR [eax+0x7],0x0
		r->icc = 0;
     378:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     37b:	c6 40 0e 00          	mov    BYTE PTR [eax+0xe],0x0
		r->control = 0;
     37f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     382:	c6 40 0f 00          	mov    BYTE PTR [eax+0xf],0x0
		r->res1 = 0;
     386:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     389:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		if (!ptr) {
     390:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
     394:	75 47                	jne    3dd <ata_build_device_identify+0x1ad>
				ptr = ad->identify_data[ctx->entry->port].ptr;
     396:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     399:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     39c:	0f b7 00             	movzx  eax,WORD PTR [eax]
     39f:	0f b7 d0             	movzx  edx,ax
     3a2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3a5:	83 c2 10             	add    edx,0x10
     3a8:	c1 e2 04             	shl    edx,0x4
     3ab:	01 d0                	add    eax,edx
     3ad:	83 c0 10             	add    eax,0x10
     3b0:	8b 00                	mov    eax,DWORD PTR [eax]
     3b2:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				b1 = ad->identify_data[ctx->entry->port].pm;
     3b5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3b8:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     3bb:	0f b7 00             	movzx  eax,WORD PTR [eax]
     3be:	0f b7 d0             	movzx  edx,ax
     3c1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c4:	83 c2 10             	add    edx,0x10
     3c7:	c1 e2 04             	shl    edx,0x4
     3ca:	01 d0                	add    eax,edx
     3cc:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     3cf:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     3d2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     3d5:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     3d8:	e9 b2 00 00 00       	jmp    48f <ata_build_device_identify+0x25f>
				size_t ofs = (size_t)ptr % 4096;
     3dd:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     3e0:	25 ff 0f 00 00       	and    eax,0xfff
     3e5:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				b1 = mm_page_get_pmem(&mm_kernel, ptr);
     3e8:	83 ec 08             	sub    esp,0x8
     3eb:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     3ee:	68 00 00 00 00       	push   0x0
     3f3:	e8 fc ff ff ff       	call   3f4 <ata_build_device_identify+0x1c4>
     3f8:	83 c4 10             	add    esp,0x10
     3fb:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     3fe:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
				if (4096 - ofs < 512) { /* across pages */
     401:	b8 00 10 00 00       	mov    eax,0x1000
     406:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     409:	3d ff 01 00 00       	cmp    eax,0x1ff
     40e:	77 71                	ja     481 <ata_build_device_identify+0x251>
						bc1 = 4096 - ofs;
     410:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     413:	89 c2                	mov    edx,eax
     415:	b8 00 10 00 00       	mov    eax,0x1000
     41a:	29 d0                	sub    eax,edx
     41c:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
						bc2 = 512 - (4096 - ofs);
     420:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     423:	66 2d 00 0e          	sub    ax,0xe00
     427:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
						b2 = mm_page_get_pmem(&mm_kernel, ptr + bc1);
     42b:	0f b7 55 e6          	movzx  edx,WORD PTR [ebp-0x1a]
     42f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     432:	01 d0                	add    eax,edx
     434:	83 ec 08             	sub    esp,0x8
     437:	50                   	push   eax
     438:	68 00 00 00 00       	push   0x0
     43d:	e8 fc ff ff ff       	call   43e <ata_build_device_identify+0x20e>
     442:	83 c4 10             	add    esp,0x10
     445:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     448:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
						if (b2 == b1 + 4096) {
     44b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     44e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     451:	05 00 10 00 00       	add    eax,0x1000
     456:	83 d2 00             	adc    edx,0x0
     459:	89 c1                	mov    ecx,eax
     45b:	89 c8                	mov    eax,ecx
     45d:	33 45 e8             	xor    eax,DWORD PTR [ebp-0x18]
     460:	33 55 ec             	xor    edx,DWORD PTR [ebp-0x14]
     463:	09 d0                	or     eax,edx
     465:	75 1a                	jne    481 <ata_build_device_identify+0x251>
								bc1 = 512; bc2 = 0;
     467:	66 c7 45 e6 00 02    	mov    WORD PTR [ebp-0x1a],0x200
     46d:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
								b2 = 0;
     473:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     47a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				b1 += ofs;
     481:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     484:	ba 00 00 00 00       	mov    edx,0x0
     489:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
     48c:	11 55 f4             	adc    DWORD PTR [ebp-0xc],edx
		abprintf("IDENTIFY: %016llx %p\n", ctx->entry->pmem, t);
     48f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     492:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     495:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     498:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     49b:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     49e:	52                   	push   edx
     49f:	50                   	push   eax
     4a0:	68 00 00 00 00       	push   0x0
     4a5:	e8 fc ff ff ff       	call   4a6 <ata_build_device_identify+0x276>
     4aa:	83 c4 10             	add    esp,0x10
		abprintf("b1: %016llx\n", b1);
     4ad:	83 ec 04             	sub    esp,0x4
     4b0:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     4b3:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     4b6:	68 16 00 00 00       	push   0x16
     4bb:	e8 fc ff ff ff       	call   4bc <ata_build_device_identify+0x28c>
     4c0:	83 c4 10             	add    esp,0x10
		t->prdts[0].dba64 = b1;
     4c3:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     4c6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     4c9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     4cc:	89 81 80 00 00 00    	mov    DWORD PTR [ecx+0x80],eax
     4d2:	89 91 84 00 00 00    	mov    DWORD PTR [ecx+0x84],edx
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
     4d8:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     4dc:	83 e8 01             	sub    eax,0x1
     4df:	25 ff ff 3f 00       	and    eax,0x3fffff
     4e4:	89 c2                	mov    edx,eax
     4e6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     4e9:	89 d1                	mov    ecx,edx
     4eb:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     4f1:	8b 90 8c 00 00 00    	mov    edx,DWORD PTR [eax+0x8c]
     4f7:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     4fd:	09 ca                	or     edx,ecx
     4ff:	89 90 8c 00 00 00    	mov    DWORD PTR [eax+0x8c],edx
		t->prdts[0].I = 1; /* interrupt on completion */
     505:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     508:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [eax+0x8f]
     50f:	83 ca 80             	or     edx,0xffffff80
     512:	88 90 8f 00 00 00    	mov    BYTE PTR [eax+0x8f],dl
		if (b2) {
     518:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     51b:	0b 45 ec             	or     eax,DWORD PTR [ebp-0x14]
     51e:	74 7d                	je     59d <ata_build_device_identify+0x36d>
				if (ctx->max_prdtl < 2)
     520:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     523:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     526:	83 f8 01             	cmp    eax,0x1
     529:	77 0a                	ja     535 <ata_build_device_identify+0x305>
						return -1; /* TODO: word alignment */
     52b:	b8 ff ff ff ff       	mov    eax,0xffffffff
     530:	e9 f6 00 00 00       	jmp    62b <ata_build_device_identify+0x3fb>
				t->prdts[1].dba64 = b2;
     535:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     538:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     53b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     53e:	89 81 90 00 00 00    	mov    DWORD PTR [ecx+0x90],eax
     544:	89 91 94 00 00 00    	mov    DWORD PTR [ecx+0x94],edx
				t->prdts[1].dbc = bc2 - 1; /* IDENTIFY returns 512bt */
     54a:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     54e:	83 e8 01             	sub    eax,0x1
     551:	25 ff ff 3f 00       	and    eax,0x3fffff
     556:	89 c2                	mov    edx,eax
     558:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     55b:	89 d1                	mov    ecx,edx
     55d:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     563:	8b 90 9c 00 00 00    	mov    edx,DWORD PTR [eax+0x9c]
     569:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     56f:	09 ca                	or     edx,ecx
     571:	89 90 9c 00 00 00    	mov    DWORD PTR [eax+0x9c],edx
				t->prdts[1].I = 1; /* interrupt on completion */
     577:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     57a:	0f b6 90 9f 00 00 00 	movzx  edx,BYTE PTR [eax+0x9f]
     581:	83 ca 80             	or     edx,0xffffff80
     584:	88 90 9f 00 00 00    	mov    BYTE PTR [eax+0x9f],dl
				t->prdts[0].I = 0; /* not too early */
     58a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     58d:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [eax+0x8f]
     594:	83 e2 7f             	and    edx,0x7f
     597:	88 90 8f 00 00 00    	mov    BYTE PTR [eax+0x8f],dl
		ctx->clh.prdtl = b2 ? 2 : 1;
     59d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     5a0:	0b 45 ec             	or     eax,DWORD PTR [ebp-0x14]
     5a3:	74 07                	je     5ac <ata_build_device_identify+0x37c>
     5a5:	ba 02 00 00 00       	mov    edx,0x2
     5aa:	eb 05                	jmp    5b1 <ata_build_device_identify+0x381>
     5ac:	ba 01 00 00 00       	mov    edx,0x1
     5b1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5b4:	66 89 50 44          	mov    WORD PTR [eax+0x44],dx
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
     5b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5bb:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     5bf:	c1 e0 0c             	shl    eax,0xc
     5c2:	66 0d 05 04          	or     ax,0x405
     5c6:	89 c2                	mov    edx,eax
     5c8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5cb:	66 89 50 46          	mov    WORD PTR [eax+0x46],dx
		ctx->cont_ctx = NULL;
     5cf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5d2:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
		ctx->cur_buf = NULL;
     5d9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5dc:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
		ctx->bts_left = 0;
     5e3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5e6:	c7 40 3c 00 00 00 00 	mov    DWORD PTR [eax+0x3c],0x0
     5ed:	c7 40 40 00 00 00 00 	mov    DWORD PTR [eax+0x40],0x0
		if (ctx->status) {
     5f4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5f7:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     5fa:	85 c0                	test   eax,eax
     5fc:	74 28                	je     626 <ata_build_device_identify+0x3f6>
				ctx->status->bts_cur = 0;
     5fe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     601:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     604:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
     60b:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
				ctx->status->bts_left = 512; /* bts_left in ctx is internal */
     612:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     615:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     618:	c7 40 08 00 02 00 00 	mov    DWORD PTR [eax+0x8],0x200
     61f:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		return 0;
     626:	b8 00 00 00 00       	mov    eax,0x0
}
     62b:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     62e:	c9                   	leave
     62f:	c3                   	ret

00000630 <atapi_build_packet_device_identify>:
{
     630:	55                   	push   ebp
     631:	89 e5                	mov    ebp,esp
     633:	83 ec 08             	sub    esp,0x8
		printf("ATAPI IDENTIFY PACKET DEVICE %p %p\n", ad, ctx);
     636:	83 ec 04             	sub    esp,0x4
     639:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     63c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     63f:	68 24 00 00 00       	push   0x24
     644:	e8 fc ff ff ff       	call   645 <atapi_build_packet_device_identify+0x15>
     649:	83 c4 10             	add    esp,0x10
		return -1;
     64c:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     651:	c9                   	leave
     652:	c3                   	ret

00000653 <ata_build_read_dma_ext>:
{
     653:	55                   	push   ebp
     654:	89 e5                	mov    ebp,esp
     656:	53                   	push   ebx
     657:	83 ec 34             	sub    esp,0x34
		struct ahci_cmdtbl* t = ctx->entry->ptr;
     65a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     65d:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     660:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     663:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct sata_reg_h2d* r = &t->cfis.rh2d;
     666:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     669:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
     66c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     66f:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     672:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     675:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     67c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		uint16_t bc1 = 512, bc2 = 0;
     683:	66 c7 45 de 00 02    	mov    WORD PTR [ebp-0x22],0x200
     689:	66 c7 45 dc 00 00    	mov    WORD PTR [ebp-0x24],0x0
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
     68f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     692:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     695:	83 c0 08             	add    eax,0x8
     698:	c1 e0 04             	shl    eax,0x4
     69b:	83 ec 08             	sub    esp,0x8
     69e:	50                   	push   eax
     69f:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     6a2:	e8 fc ff ff ff       	call   6a3 <ata_build_read_dma_ext+0x50>
     6a7:	83 c4 10             	add    esp,0x10
		r->fis_type = FIS_REG_H2D;
     6aa:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6ad:	c6 00 27             	mov    BYTE PTR [eax],0x27
		r->pm_port = ctx->pmprt;
     6b0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6b3:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     6b7:	83 e0 0f             	and    eax,0xf
     6ba:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     6bd:	83 e0 0f             	and    eax,0xf
     6c0:	89 c1                	mov    ecx,eax
     6c2:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     6c6:	83 e0 f0             	and    eax,0xfffffff0
     6c9:	09 c8                	or     eax,ecx
     6cb:	88 42 01             	mov    BYTE PTR [edx+0x1],al
		r->res0 = 0;
     6ce:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6d1:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     6d5:	83 e2 8f             	and    edx,0xffffff8f
     6d8:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->c = 1;
     6db:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6de:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     6e2:	83 ca 80             	or     edx,0xffffff80
     6e5:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->command = ATA_CMD_READ_DMA_EXT;
     6e8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6eb:	c6 40 02 25          	mov    BYTE PTR [eax+0x2],0x25
		r->feat_high = r->feat_low = 0; /* reserved */
     6ef:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6f2:	c6 40 03 00          	mov    BYTE PTR [eax+0x3],0x0
     6f6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6f9:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
     6fd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     700:	88 50 0b             	mov    BYTE PTR [eax+0xb],dl
		r->lba_high = (uint32_t)((ctx->lba >> 24) & 0x00ffffff);
     703:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     706:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     709:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     70c:	0f ac d0 18          	shrd   eax,edx,0x18
     710:	c1 ea 18             	shr    edx,0x18
     713:	89 c2                	mov    edx,eax
     715:	81 e2 ff ff ff 00    	and    edx,0xffffff
     71b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     71e:	0f b6 da             	movzx  ebx,dl
     721:	0f b6 48 08          	movzx  ecx,BYTE PTR [eax+0x8]
     725:	83 e1 00             	and    ecx,0x0
     728:	09 d9                	or     ecx,ebx
     72a:	88 48 08             	mov    BYTE PTR [eax+0x8],cl
     72d:	89 d1                	mov    ecx,edx
     72f:	c1 e9 08             	shr    ecx,0x8
     732:	0f b6 d9             	movzx  ebx,cl
     735:	0f b6 48 09          	movzx  ecx,BYTE PTR [eax+0x9]
     739:	83 e1 00             	and    ecx,0x0
     73c:	09 d9                	or     ecx,ebx
     73e:	88 48 09             	mov    BYTE PTR [eax+0x9],cl
     741:	c1 ea 10             	shr    edx,0x10
     744:	0f b6 ca             	movzx  ecx,dl
     747:	0f b6 50 0a          	movzx  edx,BYTE PTR [eax+0xa]
     74b:	83 e2 00             	and    edx,0x0
     74e:	09 ca                	or     edx,ecx
     750:	88 50 0a             	mov    BYTE PTR [eax+0xa],dl
		r->lba_low = (uint32_t)(ctx->lba & 0x00ffffff);
     753:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     756:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     759:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     75c:	89 c2                	mov    edx,eax
     75e:	81 e2 ff ff ff 00    	and    edx,0xffffff
     764:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     767:	0f b6 da             	movzx  ebx,dl
     76a:	0f b6 48 04          	movzx  ecx,BYTE PTR [eax+0x4]
     76e:	83 e1 00             	and    ecx,0x0
     771:	09 d9                	or     ecx,ebx
     773:	88 48 04             	mov    BYTE PTR [eax+0x4],cl
     776:	89 d1                	mov    ecx,edx
     778:	c1 e9 08             	shr    ecx,0x8
     77b:	0f b6 d9             	movzx  ebx,cl
     77e:	0f b6 48 05          	movzx  ecx,BYTE PTR [eax+0x5]
     782:	83 e1 00             	and    ecx,0x0
     785:	09 d9                	or     ecx,ebx
     787:	88 48 05             	mov    BYTE PTR [eax+0x5],cl
     78a:	c1 ea 10             	shr    edx,0x10
     78d:	0f b6 ca             	movzx  ecx,dl
     790:	0f b6 50 06          	movzx  edx,BYTE PTR [eax+0x6]
     794:	83 e2 00             	and    edx,0x0
     797:	09 ca                	or     edx,ecx
     799:	88 50 06             	mov    BYTE PTR [eax+0x6],dl
		r->count = 1/*ctx->ct / 512*/; /* log sector count (first identify )*/
     79c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     79f:	66 c7 40 0c 01 00    	mov    WORD PTR [eax+0xc],0x1
		r->device = (1 << 6); /* bit6 shall be set to one */
     7a5:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7a8:	c6 40 07 40          	mov    BYTE PTR [eax+0x7],0x40
		r->icc = 0;
     7ac:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7af:	c6 40 0e 00          	mov    BYTE PTR [eax+0xe],0x0
		r->control = 0;
     7b3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7b6:	c6 40 0f 00          	mov    BYTE PTR [eax+0xf],0x0
		r->res1 = 0;
     7ba:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7bd:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		if (!ptr) {
     7c4:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     7c8:	0f 85 1c 01 00 00    	jne    8ea <ata_build_read_dma_ext+0x297>
				ptr = ad->identify_data[ctx->entry->port].ptr;
     7ce:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7d1:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     7d4:	0f b7 00             	movzx  eax,WORD PTR [eax]
     7d7:	0f b7 d0             	movzx  edx,ax
     7da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7dd:	83 c2 10             	add    edx,0x10
     7e0:	c1 e2 04             	shl    edx,0x4
     7e3:	01 d0                	add    eax,edx
     7e5:	83 c0 10             	add    eax,0x10
     7e8:	8b 00                	mov    eax,DWORD PTR [eax]
     7ea:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				b1 = ad->identify_data[ctx->entry->port].pm;
     7ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7f0:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     7f3:	0f b7 00             	movzx  eax,WORD PTR [eax]
     7f6:	0f b7 d0             	movzx  edx,ax
     7f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7fc:	83 c2 10             	add    edx,0x10
     7ff:	c1 e2 04             	shl    edx,0x4
     802:	01 d0                	add    eax,edx
     804:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     807:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     80a:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     80d:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		abprintf("READ DMA EXT: %016llx %p\n", ctx->entry->pmem, t);
     810:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     813:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     816:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     819:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     81c:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     81f:	52                   	push   edx
     820:	50                   	push   eax
     821:	68 58 00 00 00       	push   0x58
     826:	e8 fc ff ff ff       	call   827 <ata_build_read_dma_ext+0x1d4>
     82b:	83 c4 10             	add    esp,0x10
		abprintf("b1: %016llx\n", b1);
     82e:	83 ec 04             	sub    esp,0x4
     831:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     834:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     837:	68 16 00 00 00       	push   0x16
     83c:	e8 fc ff ff ff       	call   83d <ata_build_read_dma_ext+0x1ea>
     841:	83 c4 10             	add    esp,0x10
		t->prdts[0].dba64 = b1;
     844:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     847:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     84a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     84d:	89 81 80 00 00 00    	mov    DWORD PTR [ecx+0x80],eax
     853:	89 91 84 00 00 00    	mov    DWORD PTR [ecx+0x84],edx
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
     859:	0f b7 45 de          	movzx  eax,WORD PTR [ebp-0x22]
     85d:	83 e8 01             	sub    eax,0x1
     860:	25 ff ff 3f 00       	and    eax,0x3fffff
     865:	89 c2                	mov    edx,eax
     867:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     86a:	89 d1                	mov    ecx,edx
     86c:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     872:	8b 90 8c 00 00 00    	mov    edx,DWORD PTR [eax+0x8c]
     878:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     87e:	09 ca                	or     edx,ecx
     880:	89 90 8c 00 00 00    	mov    DWORD PTR [eax+0x8c],edx
		t->prdts[0].I = 1; /* interrupt on completion */
     886:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     889:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [eax+0x8f]
     890:	83 ca 80             	or     edx,0xffffff80
     893:	88 90 8f 00 00 00    	mov    BYTE PTR [eax+0x8f],dl
		ctx->clh.prdtl = 1;
     899:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     89c:	66 c7 40 44 01 00    	mov    WORD PTR [eax+0x44],0x1
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
     8a2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8a5:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     8a9:	c1 e0 0c             	shl    eax,0xc
     8ac:	66 0d 05 04          	or     ax,0x405
     8b0:	89 c2                	mov    edx,eax
     8b2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8b5:	66 89 50 46          	mov    WORD PTR [eax+0x46],dx
		ctx->cont_ctx = NULL;
     8b9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8bc:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
		ctx->cur_buf = NULL;
     8c3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8c6:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
		ctx->bts_left = 0;
     8cd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8d0:	c7 40 3c 00 00 00 00 	mov    DWORD PTR [eax+0x3c],0x0
     8d7:	c7 40 40 00 00 00 00 	mov    DWORD PTR [eax+0x40],0x0
		if (ctx->status) {
     8de:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8e1:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     8e4:	85 c0                	test   eax,eax
     8e6:	74 56                	je     93e <ata_build_read_dma_ext+0x2eb>
     8e8:	eb 2b                	jmp    915 <ata_build_read_dma_ext+0x2c2>
				die("not there yet!\n");
     8ea:	83 ec 08             	sub    esp,0x8
     8ed:	68 48 00 00 00       	push   0x48
     8f2:	6a 0c                	push   0xc
     8f4:	e8 fc ff ff ff       	call   8f5 <ata_build_read_dma_ext+0x2a2>
     8f9:	83 c4 10             	add    esp,0x10
     8fc:	e8 fc ff ff ff       	call   8fd <ata_build_read_dma_ext+0x2aa>
     901:	83 ec 0c             	sub    esp,0xc
     904:	68 00 00 00 00       	push   0x0
     909:	e8 fc ff ff ff       	call   90a <ata_build_read_dma_ext+0x2b7>
     90e:	83 c4 10             	add    esp,0x10
     911:	fa                   	cli
     912:	f4                   	hlt
     913:	eb fd                	jmp    912 <ata_build_read_dma_ext+0x2bf>
				ctx->status->bts_left = 122123;
     915:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     918:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     91b:	c7 40 08 0b dd 01 00 	mov    DWORD PTR [eax+0x8],0x1dd0b
     922:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
				ctx->status->bts_cur = bc2;
     929:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     92c:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     92f:	0f b7 45 dc          	movzx  eax,WORD PTR [ebp-0x24]
     933:	ba 00 00 00 00       	mov    edx,0x0
     938:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
     93b:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
		return 0;
     93e:	b8 00 00 00 00       	mov    eax,0x0
}
     943:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     946:	c9                   	leave
     947:	c3                   	ret

00000948 <capstr>:
{
     948:	55                   	push   ebp
     949:	89 e5                	mov    ebp,esp
     94b:	83 ec 10             	sub    esp,0x10
		const char** rv = (const char**)(&limit + 1);
     94e:	8d 45 0c             	lea    eax,[ebp+0xc]
     951:	83 c0 04             	add    eax,0x4
     954:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return rv[min(idx, limit)];
     957:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     95a:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     95d:	7d 08                	jge    967 <capstr+0x1f>
     95f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     962:	c1 e0 02             	shl    eax,0x2
     965:	eb 06                	jmp    96d <capstr+0x25>
     967:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     96a:	c1 e0 02             	shl    eax,0x2
     96d:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     970:	01 d0                	add    eax,edx
     972:	8b 00                	mov    eax,DWORD PTR [eax]
}
     974:	c9                   	leave
     975:	c3                   	ret

00000976 <ahci_allocate_context>:
{
     976:	55                   	push   ebp
     977:	89 e5                	mov    ebp,esp
     979:	83 ec 18             	sub    esp,0x18
		rv = list_cut_first_entry(&ad->ctxs, struct cmd_ctx, lst);
     97c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     97f:	05 14 06 00 00       	add    eax,0x614
     984:	50                   	push   eax
     985:	e8 ca f7 ff ff       	call   154 <list_empty>
     98a:	83 c4 04             	add    esp,0x4
     98d:	85 c0                	test   eax,eax
     98f:	75 70                	jne    a01 <ahci_allocate_context+0x8b>
     991:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     994:	05 1c 06 00 00       	add    eax,0x61c
     999:	83 ec 0c             	sub    esp,0xc
     99c:	50                   	push   eax
     99d:	e8 fc ff ff ff       	call   99e <ahci_allocate_context+0x28>
     9a2:	83 c4 10             	add    esp,0x10
     9a5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9a8:	05 14 06 00 00       	add    eax,0x614
     9ad:	83 ec 0c             	sub    esp,0xc
     9b0:	50                   	push   eax
     9b1:	e8 9e f7 ff ff       	call   154 <list_empty>
     9b6:	83 c4 10             	add    esp,0x10
     9b9:	85 c0                	test   eax,eax
     9bb:	75 11                	jne    9ce <ahci_allocate_context+0x58>
     9bd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9c0:	8b 80 18 06 00 00    	mov    eax,DWORD PTR [eax+0x618]
     9c6:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     9c9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     9cc:	eb 05                	jmp    9d3 <ahci_allocate_context+0x5d>
     9ce:	b8 00 00 00 00       	mov    eax,0x0
     9d3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     9d6:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     9da:	74 0f                	je     9eb <ahci_allocate_context+0x75>
     9dc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9df:	83 ec 0c             	sub    esp,0xc
     9e2:	50                   	push   eax
     9e3:	e8 74 f6 ff ff       	call   5c <__list_del>
     9e8:	83 c4 10             	add    esp,0x10
     9eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9ee:	05 1c 06 00 00       	add    eax,0x61c
     9f3:	83 ec 0c             	sub    esp,0xc
     9f6:	50                   	push   eax
     9f7:	e8 fc ff ff ff       	call   9f8 <ahci_allocate_context+0x82>
     9fc:	83 c4 10             	add    esp,0x10
     9ff:	eb 07                	jmp    a08 <ahci_allocate_context+0x92>
     a01:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     a08:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a0b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv)
     a0e:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     a12:	75 10                	jne    a24 <ahci_allocate_context+0xae>
				rv = kzalloc(sizeof(*rv));
     a14:	83 ec 0c             	sub    esp,0xc
     a17:	6a 50                	push   0x50
     a19:	e8 fc ff ff ff       	call   a1a <ahci_allocate_context+0xa4>
     a1e:	83 c4 10             	add    esp,0x10
     a21:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return rv;
     a24:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     a27:	c9                   	leave
     a28:	c3                   	ret

00000a29 <ahci_destroy_context>:
{
     a29:	55                   	push   ebp
     a2a:	89 e5                	mov    ebp,esp
     a2c:	83 ec 08             	sub    esp,0x8
		bzero(cc, sizeof(*cc));
     a2f:	83 ec 08             	sub    esp,0x8
     a32:	6a 50                	push   0x50
     a34:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     a37:	e8 fc ff ff ff       	call   a38 <ahci_destroy_context+0xf>
     a3c:	83 c4 10             	add    esp,0x10
		list_add_tail(&cc->lst, &ad->ctxs);
     a3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a42:	8d 90 14 06 00 00    	lea    edx,[eax+0x614]
     a48:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a4b:	83 ec 08             	sub    esp,0x8
     a4e:	52                   	push   edx
     a4f:	50                   	push   eax
     a50:	e8 80 f6 ff ff       	call   d5 <list_add_tail>
     a55:	83 c4 10             	add    esp,0x10
}
     a58:	90                   	nop
     a59:	c9                   	leave
     a5a:	c3                   	ret

00000a5b <ahci_handle_command_error>:
{
     a5b:	55                   	push   ebp
     a5c:	89 e5                	mov    ebp,esp
     a5e:	83 ec 08             	sub    esp,0x8
		if (cc->c == disk_cmd_identify) {
     a61:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a64:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     a67:	85 c0                	test   eax,eax
     a69:	75 07                	jne    a72 <ahci_handle_command_error+0x17>
				return -1;
     a6b:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a70:	eb 37                	jmp    aa9 <ahci_handle_command_error+0x4e>
				if (cc->status)
     a72:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a75:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     a78:	85 c0                	test   eax,eax
     a7a:	74 0c                	je     a88 <ahci_handle_command_error+0x2d>
						cc->status->state = cmd_state_abort;
     a7c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a7f:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     a82:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				if (cc->wq_wake)
     a88:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a8b:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     a8e:	85 c0                	test   eax,eax
     a90:	74 12                	je     aa4 <ahci_handle_command_error+0x49>
						wake_up_external_event(cc->wq_wake);
     a92:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a95:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     a98:	83 ec 0c             	sub    esp,0xc
     a9b:	50                   	push   eax
     a9c:	e8 fc ff ff ff       	call   a9d <ahci_handle_command_error+0x42>
     aa1:	83 c4 10             	add    esp,0x10
				return -1;
     aa4:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     aa9:	c9                   	leave
     aaa:	c3                   	ret

00000aab <ahci_port_handle_tfes_regular>:
{
     aab:	55                   	push   ebp
     aac:	89 e5                	mov    ebp,esp
     aae:	83 ec 28             	sub    esp,0x28
		uint32_t ci = p->pXci; /* all pending commands */
     ab1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ab4:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
     ab7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		uint16_t slt = p->cmd.ccs; /* the offending one */
     aba:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     abd:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     ac0:	c1 e8 08             	shr    eax,0x8
     ac3:	83 e0 1f             	and    eax,0x1f
     ac6:	0f b6 c0             	movzx  eax,al
     ac9:	66 89 45 ee          	mov    WORD PTR [ebp-0x12],ax
		p->cmd.st = 0;
     acd:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     ad0:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
     ad3:	83 e0 fe             	and    eax,0xfffffffe
     ad6:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		abiprintf("slot which caused task file error: %u\n", slt);
     ad9:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     add:	83 ec 08             	sub    esp,0x8
     ae0:	50                   	push   eax
     ae1:	68 74 00 00 00       	push   0x74
     ae6:	e8 fc ff ff ff       	call   ae7 <ahci_port_handle_tfes_regular+0x3c>
     aeb:	83 c4 10             	add    esp,0x10
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     aee:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     af1:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     af4:	89 d0                	mov    eax,edx
     af6:	01 c0                	add    eax,eax
     af8:	01 d0                	add    eax,edx
     afa:	c1 e0 02             	shl    eax,0x2
     afd:	01 c8                	add    eax,ecx
     aff:	05 94 04 00 00       	add    eax,0x494
     b04:	8b 00                	mov    eax,DWORD PTR [eax]
     b06:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     b09:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     b0c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     b0f:	e9 6d 01 00 00       	jmp    c81 <ahci_port_handle_tfes_regular+0x1d6>
				struct cmd_ctx* cc = cc2; /* we're clearing the list */
     b14:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b17:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				list_del_and_prepare_continue(cc2, &ad->proc_cmds[pt], lst);
     b1a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b1d:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     b20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b23:	8b 00                	mov    eax,DWORD PTR [eax]
     b25:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     b28:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     b2b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     b2e:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     b31:	89 d0                	mov    eax,edx
     b33:	01 c0                	add    eax,eax
     b35:	01 d0                	add    eax,edx
     b37:	c1 e0 02             	shl    eax,0x2
     b3a:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
     b40:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b43:	01 c2                	add    edx,eax
     b45:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b48:	83 ec 08             	sub    esp,0x8
     b4b:	52                   	push   edx
     b4c:	50                   	push   eax
     b4d:	e8 c7 f5 ff ff       	call   119 <list_del>
     b52:	83 c4 10             	add    esp,0x10
				abiprintf("inside slt: %u\n", cc->slot);
     b55:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b58:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     b5c:	0f b7 c0             	movzx  eax,ax
     b5f:	83 ec 08             	sub    esp,0x8
     b62:	50                   	push   eax
     b63:	68 9b 00 00 00       	push   0x9b
     b68:	e8 fc ff ff ff       	call   b69 <ahci_port_handle_tfes_regular+0xbe>
     b6d:	83 c4 10             	add    esp,0x10
				if (cc->slot == slt) {
     b70:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b73:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     b77:	66 39 45 ee          	cmp    WORD PTR [ebp-0x12],ax
     b7b:	0f 85 97 00 00 00    	jne    c18 <ahci_port_handle_tfes_regular+0x16d>
								slt, pt, p->tfd.err, p->tfd.sts);
     b81:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b84:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     b87:	0f b6 c8             	movzx  ecx,al
								slt, pt, p->tfd.err, p->tfd.sts);
     b8a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b8d:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     b90:	0f b6 c4             	movzx  eax,ah
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     b93:	0f b6 d0             	movzx  edx,al
     b96:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     b9a:	83 ec 0c             	sub    esp,0xc
     b9d:	51                   	push   ecx
     b9e:	52                   	push   edx
     b9f:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     ba2:	50                   	push   eax
     ba3:	68 ac 00 00 00       	push   0xac
     ba8:	e8 fc ff ff ff       	call   ba9 <ahci_port_handle_tfes_regular+0xfe>
     bad:	83 c4 20             	add    esp,0x20
						if (-1 == ahci_handle_command_error(ad, cc, p->pXtfd)) {
     bb0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     bb3:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     bb6:	83 ec 04             	sub    esp,0x4
     bb9:	50                   	push   eax
     bba:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     bbd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     bc0:	e8 fc ff ff ff       	call   bc1 <ahci_port_handle_tfes_regular+0x116>
     bc5:	83 c4 10             	add    esp,0x10
     bc8:	83 f8 ff             	cmp    eax,0xffffffff
     bcb:	75 28                	jne    bf5 <ahci_port_handle_tfes_regular+0x14a>
								ahci_release_cmdtbl(ad, cc->entry);
     bcd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     bd0:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     bd3:	83 ec 08             	sub    esp,0x8
     bd6:	50                   	push   eax
     bd7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     bda:	e8 fc ff ff ff       	call   bdb <ahci_port_handle_tfes_regular+0x130>
     bdf:	83 c4 10             	add    esp,0x10
								ahci_destroy_context(ad, cc);
     be2:	83 ec 08             	sub    esp,0x8
     be5:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     be8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     beb:	e8 fc ff ff ff       	call   bec <ahci_port_handle_tfes_regular+0x141>
     bf0:	83 c4 10             	add    esp,0x10
     bf3:	eb 7d                	jmp    c72 <ahci_port_handle_tfes_regular+0x1c7>
								abiprintf("command reissued.\n");
     bf5:	83 ec 0c             	sub    esp,0xc
     bf8:	68 e2 00 00 00       	push   0xe2
     bfd:	e8 fc ff ff ff       	call   bfe <ahci_port_handle_tfes_regular+0x153>
     c02:	83 c4 10             	add    esp,0x10
								ahci_reissue_command(ad, cc);
     c05:	83 ec 08             	sub    esp,0x8
     c08:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     c0b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c0e:	e8 fc ff ff ff       	call   c0f <ahci_port_handle_tfes_regular+0x164>
     c13:	83 c4 10             	add    esp,0x10
     c16:	eb 5a                	jmp    c72 <ahci_port_handle_tfes_regular+0x1c7>
						if (ci & (1 << cc->slot)) {
     c18:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c1b:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     c1f:	0f b7 c0             	movzx  eax,ax
     c22:	ba 01 00 00 00       	mov    edx,0x1
     c27:	89 c1                	mov    ecx,eax
     c29:	d3 e2                	shl    edx,cl
     c2b:	89 d0                	mov    eax,edx
     c2d:	23 45 f0             	and    eax,DWORD PTR [ebp-0x10]
     c30:	85 c0                	test   eax,eax
     c32:	74 13                	je     c47 <ahci_port_handle_tfes_regular+0x19c>
								ahci_reissue_command(ad, cc);
     c34:	83 ec 08             	sub    esp,0x8
     c37:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     c3a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c3d:	e8 fc ff ff ff       	call   c3e <ahci_port_handle_tfes_regular+0x193>
     c42:	83 c4 10             	add    esp,0x10
     c45:	eb 2b                	jmp    c72 <ahci_port_handle_tfes_regular+0x1c7>
								die("not implemented\n");
     c47:	83 ec 08             	sub    esp,0x8
     c4a:	68 f5 00 00 00       	push   0xf5
     c4f:	6a 0c                	push   0xc
     c51:	e8 fc ff ff ff       	call   c52 <ahci_port_handle_tfes_regular+0x1a7>
     c56:	83 c4 10             	add    esp,0x10
     c59:	e8 fc ff ff ff       	call   c5a <ahci_port_handle_tfes_regular+0x1af>
     c5e:	83 ec 0c             	sub    esp,0xc
     c61:	68 00 00 00 00       	push   0x0
     c66:	e8 fc ff ff ff       	call   c67 <ahci_port_handle_tfes_regular+0x1bc>
     c6b:	83 c4 10             	add    esp,0x10
     c6e:	fa                   	cli
     c6f:	f4                   	hlt
     c70:	eb fd                	jmp    c6f <ahci_port_handle_tfes_regular+0x1c4>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     c72:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c75:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     c78:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     c7b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     c7e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     c81:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c84:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     c87:	89 d0                	mov    eax,edx
     c89:	01 c0                	add    eax,eax
     c8b:	01 d0                	add    eax,edx
     c8d:	c1 e0 02             	shl    eax,0x2
     c90:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
     c96:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c99:	01 d0                	add    eax,edx
     c9b:	39 c1                	cmp    ecx,eax
     c9d:	0f 85 71 fe ff ff    	jne    b14 <ahci_port_handle_tfes_regular+0x69>
		ahci_issue_command(ad, pt, 0 /* TODO: handle pmport */, host_cmd_reset,
     ca3:	83 ec 04             	sub    esp,0x4
     ca6:	6a 00                	push   0x0
     ca8:	6a 00                	push   0x0
     caa:	6a 00                	push   0x0
     cac:	6a 00                	push   0x0
     cae:	6a 00                	push   0x0
     cb0:	6a 00                	push   0x0
     cb2:	6a 00                	push   0x0
     cb4:	68 82 00 00 00       	push   0x82
     cb9:	6a 00                	push   0x0
     cbb:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     cbe:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     cc1:	e8 fc ff ff ff       	call   cc2 <ahci_port_handle_tfes_regular+0x217>
     cc6:	83 c4 30             	add    esp,0x30
}
     cc9:	90                   	nop
     cca:	c9                   	leave
     ccb:	c3                   	ret

00000ccc <ahci_port_handle_tfes_ncq>:
{
     ccc:	55                   	push   ebp
     ccd:	89 e5                	mov    ebp,esp
     ccf:	83 ec 08             	sub    esp,0x8
		die("not implemented!\n");
     cd2:	83 ec 08             	sub    esp,0x8
     cd5:	68 06 01 00 00       	push   0x106
     cda:	6a 0c                	push   0xc
     cdc:	e8 fc ff ff ff       	call   cdd <ahci_port_handle_tfes_ncq+0x11>
     ce1:	83 c4 10             	add    esp,0x10
     ce4:	e8 fc ff ff ff       	call   ce5 <ahci_port_handle_tfes_ncq+0x19>
     ce9:	83 ec 0c             	sub    esp,0xc
     cec:	68 00 00 00 00       	push   0x0
     cf1:	e8 fc ff ff ff       	call   cf2 <ahci_port_handle_tfes_ncq+0x26>
     cf6:	83 c4 10             	add    esp,0x10
     cf9:	fa                   	cli
     cfa:	f4                   	hlt
     cfb:	eb fd                	jmp    cfa <ahci_port_handle_tfes_ncq+0x2e>

00000cfd <ahci_port_handle_pcs_cominit>:
{
     cfd:	55                   	push   ebp
     cfe:	89 e5                	mov    ebp,esp
     d00:	83 ec 08             	sub    esp,0x8
		die("not implemented!\n");
     d03:	83 ec 08             	sub    esp,0x8
     d06:	68 06 01 00 00       	push   0x106
     d0b:	6a 0c                	push   0xc
     d0d:	e8 fc ff ff ff       	call   d0e <ahci_port_handle_pcs_cominit+0x11>
     d12:	83 c4 10             	add    esp,0x10
     d15:	e8 fc ff ff ff       	call   d16 <ahci_port_handle_pcs_cominit+0x19>
     d1a:	83 ec 0c             	sub    esp,0xc
     d1d:	68 00 00 00 00       	push   0x0
     d22:	e8 fc ff ff ff       	call   d23 <ahci_port_handle_pcs_cominit+0x26>
     d27:	83 c4 10             	add    esp,0x10
     d2a:	fa                   	cli
     d2b:	f4                   	hlt
     d2c:	eb fd                	jmp    d2b <ahci_port_handle_pcs_cominit+0x2e>

00000d2e <ahci_port_check_finished_commands>:
{
     d2e:	55                   	push   ebp
     d2f:	89 e5                	mov    ebp,esp
     d31:	56                   	push   esi
     d32:	53                   	push   ebx
     d33:	83 ec 30             	sub    esp,0x30
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
     d36:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     d39:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     d3c:	89 d0                	mov    eax,edx
     d3e:	01 c0                	add    eax,eax
     d40:	01 d0                	add    eax,edx
     d42:	c1 e0 02             	shl    eax,0x2
     d45:	01 c8                	add    eax,ecx
     d47:	05 94 04 00 00       	add    eax,0x494
     d4c:	8b 00                	mov    eax,DWORD PTR [eax]
     d4e:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     d51:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d54:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     d57:	e9 ae 02 00 00       	jmp    100a <ahci_port_check_finished_commands+0x2dc>
				if (!(ci & (1 << cc->slot))) { /* slot was cleared */
     d5c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d5f:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     d63:	0f b7 c0             	movzx  eax,ax
     d66:	ba 01 00 00 00       	mov    edx,0x1
     d6b:	89 c1                	mov    ecx,eax
     d6d:	d3 e2                	shl    edx,cl
     d6f:	89 d0                	mov    eax,edx
     d71:	23 45 10             	and    eax,DWORD PTR [ebp+0x10]
     d74:	85 c0                	test   eax,eax
     d76:	0f 85 64 02 00 00    	jne    fe0 <ahci_port_check_finished_commands+0x2b2>
						uint16_t prdtl; uint32_t bc = 0, bc0 = 0;
     d7c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     d83:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
						if ((prdtl = d->command_lists[pt]->chdrs[cc->slot].prdtl)) {
     d8a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d8d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     d90:	8b 54 90 0c          	mov    edx,DWORD PTR [eax+edx*4+0xc]
     d94:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d97:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     d9b:	0f b7 c0             	movzx  eax,ax
     d9e:	c1 e0 05             	shl    eax,0x5
     da1:	01 d0                	add    eax,edx
     da3:	83 c0 02             	add    eax,0x2
     da6:	0f b7 00             	movzx  eax,WORD PTR [eax]
     da9:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
     dad:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     db2:	74 50                	je     e04 <ahci_port_check_finished_commands+0xd6>
								bc0 = d->command_lists[pt]->chdrs[cc->slot].prdbc;
     db4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     db7:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     dba:	8b 54 90 0c          	mov    edx,DWORD PTR [eax+edx*4+0xc]
     dbe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dc1:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     dc5:	0f b7 c0             	movzx  eax,ax
     dc8:	c1 e0 05             	shl    eax,0x5
     dcb:	01 d0                	add    eax,edx
     dcd:	83 c0 04             	add    eax,0x4
     dd0:	8b 00                	mov    eax,DWORD PTR [eax]
     dd2:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								struct ahci_prdt* pr = cc->entry->ptr->prdts;
     dd5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dd8:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     ddb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     dde:	83 e8 80             	sub    eax,0xffffff80
     de1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								while (prdtl--)
     de4:	eb 0e                	jmp    df4 <ahci_port_check_finished_commands+0xc6>
										bc += pr->dbc;
     de6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     de9:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     dec:	25 ff ff 3f 00       	and    eax,0x3fffff
     df1:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
								while (prdtl--)
     df4:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     df8:	8d 50 ff             	lea    edx,[eax-0x1]
     dfb:	66 89 55 f2          	mov    WORD PTR [ebp-0xe],dx
     dff:	66 85 c0             	test   ax,ax
     e02:	75 e2                	jne    de6 <ahci_port_check_finished_commands+0xb8>
						if (!cc->cont_ctx && !cc->bts_left) {
     e04:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e07:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
     e0a:	85 c0                	test   eax,eax
     e0c:	0f 85 1c 01 00 00    	jne    f2e <ahci_port_check_finished_commands+0x200>
     e12:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e15:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
     e18:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     e1b:	89 c1                	mov    ecx,eax
     e1d:	89 c8                	mov    eax,ecx
     e1f:	09 d0                	or     eax,edx
     e21:	0f 85 07 01 00 00    	jne    f2e <ahci_port_check_finished_commands+0x200>
								if (cc->c == disk_cmd_identify) {
     e27:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e2a:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     e2d:	85 c0                	test   eax,eax
     e2f:	75 71                	jne    ea2 <ahci_port_check_finished_commands+0x174>
										struct cmd_ctx* cc2 = cc;
     e31:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e34:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
										abiprintf("identify host command issued\n");
     e37:	83 ec 0c             	sub    esp,0xc
     e3a:	68 18 01 00 00       	push   0x118
     e3f:	e8 fc ff ff ff       	call   e40 <ahci_port_check_finished_commands+0x112>
     e44:	83 c4 10             	add    esp,0x10
										cc->c = host_cmd_process_identify;
     e47:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e4a:	c7 40 0c 80 00 00 00 	mov    DWORD PTR [eax+0xc],0x80
										list_del_and_prepare_continue(cc, &d->proc_cmds[pt], lst);
     e51:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e54:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e57:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e5a:	8b 00                	mov    eax,DWORD PTR [eax]
     e5c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     e5f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     e62:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     e65:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     e68:	89 d0                	mov    eax,edx
     e6a:	01 c0                	add    eax,eax
     e6c:	01 d0                	add    eax,edx
     e6e:	c1 e0 02             	shl    eax,0x2
     e71:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
     e77:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e7a:	01 c2                	add    edx,eax
     e7c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e7f:	83 ec 08             	sub    esp,0x8
     e82:	52                   	push   edx
     e83:	50                   	push   eax
     e84:	e8 90 f2 ff ff       	call   119 <list_del>
     e89:	83 c4 10             	add    esp,0x10
										ahci_reissue_command(d, cc2); /* worker has to work */
     e8c:	83 ec 08             	sub    esp,0x8
     e8f:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
     e92:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e95:	e8 fc ff ff ff       	call   e96 <ahci_port_check_finished_commands+0x168>
     e9a:	83 c4 10             	add    esp,0x10
										continue;
     e9d:	e9 59 01 00 00       	jmp    ffb <ahci_port_check_finished_commands+0x2cd>
										if (cc->status) {
     ea2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ea5:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     ea8:	85 c0                	test   eax,eax
     eaa:	74 3b                	je     ee7 <ahci_port_check_finished_commands+0x1b9>
												cc->status->state = cmd_state_completed;
     eac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     eaf:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     eb2:	c7 00 03 00 00 00    	mov    DWORD PTR [eax],0x3
												cc->status->bts_cur = bc;
     eb8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ebb:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     ebe:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ec1:	ba 00 00 00 00       	mov    edx,0x0
     ec6:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
     ec9:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
												cc->status->bts_left = bc0 - bc;
     ecc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     ecf:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
     ed2:	89 c2                	mov    edx,eax
     ed4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ed7:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     eda:	89 d0                	mov    eax,edx
     edc:	ba 00 00 00 00       	mov    edx,0x0
     ee1:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     ee4:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
										if (cc->wq_wake)
     ee7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     eea:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     eed:	85 c0                	test   eax,eax
     eef:	74 12                	je     f03 <ahci_port_check_finished_commands+0x1d5>
												wake_up_external_event(cc->wq_wake);
     ef1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ef4:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     ef7:	83 ec 0c             	sub    esp,0xc
     efa:	50                   	push   eax
     efb:	e8 fc ff ff ff       	call   efc <ahci_port_check_finished_commands+0x1ce>
     f00:	83 c4 10             	add    esp,0x10
								die("command w/o info finished.\n");
     f03:	83 ec 08             	sub    esp,0x8
     f06:	68 36 01 00 00       	push   0x136
     f0b:	6a 0c                	push   0xc
     f0d:	e8 fc ff ff ff       	call   f0e <ahci_port_check_finished_commands+0x1e0>
     f12:	83 c4 10             	add    esp,0x10
     f15:	e8 fc ff ff ff       	call   f16 <ahci_port_check_finished_commands+0x1e8>
     f1a:	83 ec 0c             	sub    esp,0xc
     f1d:	68 00 00 00 00       	push   0x0
     f22:	e8 fc ff ff ff       	call   f23 <ahci_port_check_finished_commands+0x1f5>
     f27:	83 c4 10             	add    esp,0x10
     f2a:	fa                   	cli
     f2b:	f4                   	hlt
     f2c:	eb fd                	jmp    f2b <ahci_port_check_finished_commands+0x1fd>
								if (bc0 == bc) {
     f2e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f31:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
     f34:	75 54                	jne    f8a <ahci_port_check_finished_commands+0x25c>
										if (cc->status) {
     f36:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f39:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     f3c:	85 c0                	test   eax,eax
     f3e:	74 75                	je     fb5 <ahci_port_check_finished_commands+0x287>
												cc->status->bts_cur += bc;
     f40:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f43:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     f46:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     f49:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     f4c:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     f4f:	bb 00 00 00 00       	mov    ebx,0x0
     f54:	8b 75 f4             	mov    esi,DWORD PTR [ebp-0xc]
     f57:	8b 76 2c             	mov    esi,DWORD PTR [esi+0x2c]
     f5a:	01 c8                	add    eax,ecx
     f5c:	11 da                	adc    edx,ebx
     f5e:	89 46 10             	mov    DWORD PTR [esi+0x10],eax
     f61:	89 56 14             	mov    DWORD PTR [esi+0x14],edx
												cc->status->bts_left -= bc;
     f64:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f67:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     f6a:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     f6d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f70:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     f73:	bb 00 00 00 00       	mov    ebx,0x0
     f78:	8b 75 f4             	mov    esi,DWORD PTR [ebp-0xc]
     f7b:	8b 76 2c             	mov    esi,DWORD PTR [esi+0x2c]
     f7e:	29 c8                	sub    eax,ecx
     f80:	19 da                	sbb    edx,ebx
     f82:	89 46 08             	mov    DWORD PTR [esi+0x8],eax
     f85:	89 56 0c             	mov    DWORD PTR [esi+0xc],edx
     f88:	eb 2b                	jmp    fb5 <ahci_port_check_finished_commands+0x287>
										die("incomplete transfer\n"); /* possible by design of intr? */
     f8a:	83 ec 08             	sub    esp,0x8
     f8d:	68 52 01 00 00       	push   0x152
     f92:	6a 0c                	push   0xc
     f94:	e8 fc ff ff ff       	call   f95 <ahci_port_check_finished_commands+0x267>
     f99:	83 c4 10             	add    esp,0x10
     f9c:	e8 fc ff ff ff       	call   f9d <ahci_port_check_finished_commands+0x26f>
     fa1:	83 ec 0c             	sub    esp,0xc
     fa4:	68 00 00 00 00       	push   0x0
     fa9:	e8 fc ff ff ff       	call   faa <ahci_port_check_finished_commands+0x27c>
     fae:	83 c4 10             	add    esp,0x10
     fb1:	fa                   	cli
     fb2:	f4                   	hlt
     fb3:	eb fd                	jmp    fb2 <ahci_port_check_finished_commands+0x284>
								die("not implemented yet!\n");
     fb5:	83 ec 08             	sub    esp,0x8
     fb8:	68 67 01 00 00       	push   0x167
     fbd:	6a 0c                	push   0xc
     fbf:	e8 fc ff ff ff       	call   fc0 <ahci_port_check_finished_commands+0x292>
     fc4:	83 c4 10             	add    esp,0x10
     fc7:	e8 fc ff ff ff       	call   fc8 <ahci_port_check_finished_commands+0x29a>
     fcc:	83 ec 0c             	sub    esp,0xc
     fcf:	68 00 00 00 00       	push   0x0
     fd4:	e8 fc ff ff ff       	call   fd5 <ahci_port_check_finished_commands+0x2a7>
     fd9:	83 c4 10             	add    esp,0x10
     fdc:	fa                   	cli
     fdd:	f4                   	hlt
     fde:	eb fd                	jmp    fdd <ahci_port_check_finished_commands+0x2af>
						iprintf("slot %u still active\n", cc->slot);
     fe0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     fe3:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     fe7:	0f b7 c0             	movzx  eax,ax
     fea:	83 ec 08             	sub    esp,0x8
     fed:	50                   	push   eax
     fee:	68 7d 01 00 00       	push   0x17d
     ff3:	e8 fc ff ff ff       	call   ff4 <ahci_port_check_finished_commands+0x2c6>
     ff8:	83 c4 10             	add    esp,0x10
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
     ffb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ffe:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1001:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1004:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1007:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    100a:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    100d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1010:	89 d0                	mov    eax,edx
    1012:	01 c0                	add    eax,eax
    1014:	01 d0                	add    eax,edx
    1016:	c1 e0 02             	shl    eax,0x2
    1019:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    101f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1022:	01 d0                	add    eax,edx
    1024:	39 c1                	cmp    ecx,eax
    1026:	0f 85 30 fd ff ff    	jne    d5c <ahci_port_check_finished_commands+0x2e>
}
    102c:	90                   	nop
    102d:	90                   	nop
    102e:	8d 65 f8             	lea    esp,[ebp-0x8]
    1031:	5b                   	pop    ebx
    1032:	5e                   	pop    esi
    1033:	5d                   	pop    ebp
    1034:	c3                   	ret

00001035 <ahci_port_intr>:
{
    1035:	55                   	push   ebp
    1036:	89 e5                	mov    ebp,esp
    1038:	83 ec 18             	sub    esp,0x18
		struct ahci_port* p = &d->ptr->port[pt];
    103b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    103e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1041:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1044:	83 c2 02             	add    edx,0x2
    1047:	c1 e2 07             	shl    edx,0x7
    104a:	01 d0                	add    eax,edx
    104c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		uint32_t is = p->pXis, cm = 0; /* unaffected by mask */
    104f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1052:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1055:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1058:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		uint32_t ci = p->pXci; /* check if still set */
    105f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1062:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    1065:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (is & (1 << 5)) { /* DPS: data processed (PRD&I), commands must use C bit */
    1068:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    106b:	83 e0 20             	and    eax,0x20
    106e:	85 c0                	test   eax,eax
    1070:	74 18                	je     108a <ahci_port_intr+0x55>
				ahci_port_check_finished_commands(d, pt, ci);
    1072:	83 ec 04             	sub    esp,0x4
    1075:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1078:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    107b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    107e:	e8 fc ff ff ff       	call   107f <ahci_port_intr+0x4a>
    1083:	83 c4 10             	add    esp,0x10
				cm |= (1 << 5);
    1086:	83 4d f4 20          	or     DWORD PTR [ebp-0xc],0x20
		if (is & (1 << 0)) { /* D2H FIS (more reliable) */
    108a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    108d:	83 e0 01             	and    eax,0x1
    1090:	85 c0                	test   eax,eax
    1092:	74 18                	je     10ac <ahci_port_intr+0x77>
				ahci_port_check_finished_commands(d, pt, ci);
    1094:	83 ec 04             	sub    esp,0x4
    1097:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    109a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    109d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    10a0:	e8 fc ff ff ff       	call   10a1 <ahci_port_intr+0x6c>
    10a5:	83 c4 10             	add    esp,0x10
				cm |= 1;
    10a8:	83 4d f4 01          	or     DWORD PTR [ebp-0xc],0x1
		if (is & (1 << 6)) { /* PCS */
    10ac:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10af:	83 e0 40             	and    eax,0x40
    10b2:	85 c0                	test   eax,eax
    10b4:	74 32                	je     10e8 <ahci_port_intr+0xb3>
				abiprintf("PCS on port %d received, resetting...\n", pt);
    10b6:	83 ec 08             	sub    esp,0x8
    10b9:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    10bc:	68 94 01 00 00       	push   0x194
    10c1:	e8 fc ff ff ff       	call   10c2 <ahci_port_intr+0x8d>
    10c6:	83 c4 10             	add    esp,0x10
				p->pXserr = 0xffffffff;
    10c9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10cc:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
				ahci_reset_port(d->ptr, p);
    10d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10d6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    10d9:	83 ec 08             	sub    esp,0x8
    10dc:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    10df:	50                   	push   eax
    10e0:	e8 fc ff ff ff       	call   10e1 <ahci_port_intr+0xac>
    10e5:	83 c4 10             	add    esp,0x10
		if (is & (1 << 30)) { /* we need to restart the command engine */
    10e8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10eb:	25 00 00 00 40       	and    eax,0x40000000
    10f0:	85 c0                	test   eax,eax
    10f2:	74 1b                	je     110f <ahci_port_intr+0xda>
				ahci_port_handle_tfes_regular(d, p, pt);
    10f4:	83 ec 04             	sub    esp,0x4
    10f7:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    10fa:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    10fd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1100:	e8 fc ff ff ff       	call   1101 <ahci_port_intr+0xcc>
    1105:	83 c4 10             	add    esp,0x10
				cm |= (1 << 30);
    1108:	81 4d f4 00 00 00 40 	or     DWORD PTR [ebp-0xc],0x40000000
		cm |= p->pXie;
    110f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1112:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1115:	09 45 f4             	or     DWORD PTR [ebp-0xc],eax
		abiprintf("port cm: %x\n", cm);
    1118:	83 ec 08             	sub    esp,0x8
    111b:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    111e:	68 bb 01 00 00       	push   0x1bb
    1123:	e8 fc ff ff ff       	call   1124 <ahci_port_intr+0xef>
    1128:	83 c4 10             	add    esp,0x10
		p->pXis = cm;
    112b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    112e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1131:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
}
    1134:	90                   	nop
    1135:	c9                   	leave
    1136:	c3                   	ret

00001137 <ahci_handle_interrupt>:
{
    1137:	55                   	push   ebp
    1138:	89 e5                	mov    ebp,esp
    113a:	83 ec 18             	sub    esp,0x18
		uint32_t is = d->ptr->intr, clm = 0;
    113d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1140:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1143:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1146:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1149:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		for (int i = 0; i < 32; i++) {
    1150:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1157:	eb 3b                	jmp    1194 <ahci_handle_interrupt+0x5d>
				if (is & (1 << i)) {
    1159:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    115c:	ba 01 00 00 00       	mov    edx,0x1
    1161:	89 c1                	mov    ecx,eax
    1163:	d3 e2                	shl    edx,cl
    1165:	89 d0                	mov    eax,edx
    1167:	23 45 ec             	and    eax,DWORD PTR [ebp-0x14]
    116a:	85 c0                	test   eax,eax
    116c:	74 22                	je     1190 <ahci_handle_interrupt+0x59>
						ahci_port_intr(d, i);
    116e:	83 ec 08             	sub    esp,0x8
    1171:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1174:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1177:	e8 fc ff ff ff       	call   1178 <ahci_handle_interrupt+0x41>
    117c:	83 c4 10             	add    esp,0x10
						clm |= (1 << i);
    117f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1182:	ba 01 00 00 00       	mov    edx,0x1
    1187:	89 c1                	mov    ecx,eax
    1189:	d3 e2                	shl    edx,cl
    118b:	89 d0                	mov    eax,edx
    118d:	09 45 f4             	or     DWORD PTR [ebp-0xc],eax
		for (int i = 0; i < 32; i++) {
    1190:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1194:	83 7d f0 1f          	cmp    DWORD PTR [ebp-0x10],0x1f
    1198:	7e bf                	jle    1159 <ahci_handle_interrupt+0x22>
		d->ptr->intr = clm;
    119a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    119d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    11a0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    11a3:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
}
    11a6:	90                   	nop
    11a7:	c9                   	leave
    11a8:	c3                   	ret

000011a9 <ahci_irq>:
{
    11a9:	55                   	push   ebp
    11aa:	89 e5                	mov    ebp,esp
    11ac:	83 ec 18             	sub    esp,0x18
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    11af:	a1 04 00 00 00       	mov    eax,ds:0x4
    11b4:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    11b7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11ba:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    11bd:	e9 80 00 00 00       	jmp    1242 <ahci_irq+0x99>
				if (d->dev->dev->intr_line == irq) {
    11c2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11c5:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    11c8:	8b 00                	mov    eax,DWORD PTR [eax]
    11ca:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    11ce:	0f b6 c0             	movzx  eax,al
    11d1:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    11d4:	75 5d                	jne    1233 <ahci_irq+0x8a>
						if (pci_check_interrupt(d->dev->dev)) {
    11d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11d9:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    11dc:	8b 00                	mov    eax,DWORD PTR [eax]
    11de:	83 ec 0c             	sub    esp,0xc
    11e1:	50                   	push   eax
    11e2:	e8 fc ff ff ff       	call   11e3 <ahci_irq+0x3a>
    11e7:	83 c4 10             	add    esp,0x10
    11ea:	85 c0                	test   eax,eax
    11ec:	74 1c                	je     120a <ahci_irq+0x61>
								ahci_handle_interrupt(d->dev, irq);
    11ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11f1:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    11f4:	83 ec 08             	sub    esp,0x8
    11f7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    11fa:	50                   	push   eax
    11fb:	e8 fc ff ff ff       	call   11fc <ahci_irq+0x53>
    1200:	83 c4 10             	add    esp,0x10
								return 1;
    1203:	b8 01 00 00 00       	mov    eax,0x1
    1208:	eb 5e                	jmp    1268 <ahci_irq+0xbf>
								if (d->dev->ptr->intr) {
    120a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    120d:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1210:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1213:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1216:	85 c0                	test   eax,eax
    1218:	74 19                	je     1233 <ahci_irq+0x8a>
										ahci_handle_interrupt(d->dev, irq);
    121a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    121d:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1220:	83 ec 08             	sub    esp,0x8
    1223:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1226:	50                   	push   eax
    1227:	e8 fc ff ff ff       	call   1228 <ahci_irq+0x7f>
    122c:	83 c4 10             	add    esp,0x10
										rv++;
    122f:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    1233:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1236:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1239:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    123c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    123f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1242:	81 7d f4 00 00 00 00 	cmp    DWORD PTR [ebp-0xc],0x0
    1249:	0f 85 73 ff ff ff    	jne    11c2 <ahci_irq+0x19>
		if (!rv)
    124f:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1253:	75 10                	jne    1265 <ahci_irq+0xbc>
				abiprintf("ignored non AHCI interrupt\n");
    1255:	83 ec 0c             	sub    esp,0xc
    1258:	68 c8 01 00 00       	push   0x1c8
    125d:	e8 fc ff ff ff       	call   125e <ahci_irq+0xb5>
    1262:	83 c4 10             	add    esp,0x10
		return rv;
    1265:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    1268:	c9                   	leave
    1269:	c3                   	ret

0000126a <ahci_find_slot>:
{
    126a:	55                   	push   ebp
    126b:	89 e5                	mov    ebp,esp
    126d:	83 ec 10             	sub    esp,0x10
		uint32_t bitmask = (p->pXci/* NCQ: | p->pXsact*/);
    1270:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1273:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    1276:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		for (int i = 0; i < cmd_ct; i++) {
    1279:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    1280:	eb 16                	jmp    1298 <ahci_find_slot+0x2e>
				if (!(bitmask & 1))
    1282:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1285:	83 e0 01             	and    eax,0x1
    1288:	85 c0                	test   eax,eax
    128a:	75 05                	jne    1291 <ahci_find_slot+0x27>
						return i;
    128c:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    128f:	eb 14                	jmp    12a5 <ahci_find_slot+0x3b>
				bitmask >>= 1;
    1291:	d1 6d fc             	shr    DWORD PTR [ebp-0x4],1
		for (int i = 0; i < cmd_ct; i++) {
    1294:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
    1298:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    129b:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    129e:	7c e2                	jl     1282 <ahci_find_slot+0x18>
		return -1;
    12a0:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    12a5:	c9                   	leave
    12a6:	c3                   	ret

000012a7 <ahci_release_cmdtbl>:
{
    12a7:	55                   	push   ebp
    12a8:	89 e5                	mov    ebp,esp
    12aa:	57                   	push   edi
    12ab:	56                   	push   esi
    12ac:	53                   	push   ebx
    12ad:	83 ec 1c             	sub    esp,0x1c
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    12b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12b3:	8b 80 0c 03 00 00    	mov    eax,DWORD PTR [eax+0x30c]
    12b9:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    12bc:	e9 c0 00 00 00       	jmp    1381 <ahci_release_cmdtbl+0xda>
				ptrdiff_t ofs = ctp->tables - entry;
    12c1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12c4:	83 c0 0c             	add    eax,0xc
    12c7:	2b 45 0c             	sub    eax,DWORD PTR [ebp+0xc]
    12ca:	c1 f8 04             	sar    eax,0x4
    12cd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (ofs >= 0 && ofs < 32) {
    12d0:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    12d4:	0f 88 9e 00 00 00    	js     1378 <ahci_release_cmdtbl+0xd1>
    12da:	83 7d e0 1f          	cmp    DWORD PTR [ebp-0x20],0x1f
    12de:	0f 8f 94 00 00 00    	jg     1378 <ahci_release_cmdtbl+0xd1>
						uint16_t p = entry->port, slt = entry->slot;
    12e4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12e7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    12ea:	66 89 45 de          	mov    WORD PTR [ebp-0x22],ax
    12ee:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12f1:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    12f5:	66 89 45 dc          	mov    WORD PTR [ebp-0x24],ax
						entry->port = entry->slot = 0xffff;
    12f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12fc:	66 c7 40 02 ff ff    	mov    WORD PTR [eax+0x2],0xffff
    1302:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1305:	0f b7 50 02          	movzx  edx,WORD PTR [eax+0x2]
    1309:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    130c:	66 89 10             	mov    WORD PTR [eax],dx
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    130f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1312:	ba 01 00 00 00       	mov    edx,0x1
    1317:	89 c1                	mov    ecx,eax
    1319:	d3 e2                	shl    edx,cl
    131b:	89 d0                	mov    eax,edx
    131d:	89 c6                	mov    esi,eax
								~(1 << ofs)))) {
    131f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1322:	ba 01 00 00 00       	mov    edx,0x1
    1327:	89 c1                	mov    ecx,eax
    1329:	d3 e2                	shl    edx,cl
    132b:	89 d0                	mov    eax,edx
    132d:	f7 d0                	not    eax
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    132f:	89 c7                	mov    edi,eax
    1331:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1334:	8d 50 08             	lea    edx,[eax+0x8]
    1337:	8b 02                	mov    eax,DWORD PTR [edx]
    1339:	89 c3                	mov    ebx,eax
    133b:	89 c1                	mov    ecx,eax
    133d:	21 f9                	and    ecx,edi
    133f:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1343:	0f 94 c1             	sete   cl
    1346:	84 c9                	test   cl,cl
    1348:	74 ef                	je     1339 <ahci_release_cmdtbl+0x92>
    134a:	89 f0                	mov    eax,esi
    134c:	21 d8                	and    eax,ebx
    134e:	85 c0                	test   eax,eax
    1350:	75 3b                	jne    138d <ahci_release_cmdtbl+0xe6>
								abprintf("attempt to release command table at %p"
    1352:	0f b7 4d dc          	movzx  ecx,WORD PTR [ebp-0x24]
    1356:	0f b7 55 de          	movzx  edx,WORD PTR [ebp-0x22]
    135a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    135d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1360:	83 ec 0c             	sub    esp,0xc
    1363:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1366:	51                   	push   ecx
    1367:	52                   	push   edx
    1368:	50                   	push   eax
    1369:	68 e4 01 00 00       	push   0x1e4
    136e:	e8 fc ff ff ff       	call   136f <ahci_release_cmdtbl+0xc8>
    1373:	83 c4 20             	add    esp,0x20
						break;
    1376:	eb 15                	jmp    138d <ahci_release_cmdtbl+0xe6>
				ctp = ctp->next;
    1378:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    137b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    137e:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    1381:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1385:	0f 85 36 ff ff ff    	jne    12c1 <ahci_release_cmdtbl+0x1a>
}
    138b:	eb 01                	jmp    138e <ahci_release_cmdtbl+0xe7>
						break;
    138d:	90                   	nop
}
    138e:	90                   	nop
    138f:	8d 65 f4             	lea    esp,[ebp-0xc]
    1392:	5b                   	pop    ebx
    1393:	5e                   	pop    esi
    1394:	5f                   	pop    edi
    1395:	5d                   	pop    ebp
    1396:	c3                   	ret

00001397 <ahci_find_cmdtbl>:
{
    1397:	55                   	push   ebp
    1398:	89 e5                	mov    ebp,esp
    139a:	57                   	push   edi
    139b:	56                   	push   esi
    139c:	53                   	push   ebx
    139d:	83 ec 1c             	sub    esp,0x1c
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    13a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13a3:	8b 80 0c 03 00 00    	mov    eax,DWORD PTR [eax+0x30c]
    13a9:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    13ac:	e9 88 00 00 00       	jmp    1439 <ahci_find_cmdtbl+0xa2>
				if (ctp->prdt_cap >= prdt_ct) {
    13b1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13b4:	8b 00                	mov    eax,DWORD PTR [eax]
    13b6:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    13b9:	72 75                	jb     1430 <ahci_find_cmdtbl+0x99>
Pos1:
    13bb:	90                   	nop
						bit = bsf(~ctp->mask); /* 1 based */
    13bc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13bf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    13c2:	f7 d0                	not    eax
    13c4:	50                   	push   eax
    13c5:	e8 50 ec ff ff       	call   1a <bsf>
    13ca:	83 c4 04             	add    esp,0x4
    13cd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						if (bit--) {
    13d0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13d3:	8d 50 ff             	lea    edx,[eax-0x1]
    13d6:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
    13d9:	85 c0                	test   eax,eax
    13db:	74 53                	je     1430 <ahci_find_cmdtbl+0x99>
								if (!((1 << bit) & __sync_fetch_and_or(&ctp->mask, 1 << bit))) {
    13dd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13e0:	ba 01 00 00 00       	mov    edx,0x1
    13e5:	89 c1                	mov    ecx,eax
    13e7:	d3 e2                	shl    edx,cl
    13e9:	89 d0                	mov    eax,edx
    13eb:	89 c6                	mov    esi,eax
    13ed:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13f0:	ba 01 00 00 00       	mov    edx,0x1
    13f5:	89 c1                	mov    ecx,eax
    13f7:	d3 e2                	shl    edx,cl
    13f9:	89 d0                	mov    eax,edx
    13fb:	89 c7                	mov    edi,eax
    13fd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1400:	8d 50 08             	lea    edx,[eax+0x8]
    1403:	8b 02                	mov    eax,DWORD PTR [edx]
    1405:	89 c3                	mov    ebx,eax
    1407:	89 c1                	mov    ecx,eax
    1409:	09 f9                	or     ecx,edi
    140b:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    140f:	0f 94 c1             	sete   cl
    1412:	84 c9                	test   cl,cl
    1414:	74 ef                	je     1405 <ahci_find_cmdtbl+0x6e>
    1416:	89 f0                	mov    eax,esi
    1418:	21 d8                	and    eax,ebx
    141a:	85 c0                	test   eax,eax
    141c:	75 9e                	jne    13bc <ahci_find_cmdtbl+0x25>
										return &ctp->tables[bit];
    141e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1421:	c1 e0 04             	shl    eax,0x4
    1424:	89 c2                	mov    edx,eax
    1426:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1429:	01 d0                	add    eax,edx
    142b:	83 c0 0c             	add    eax,0xc
    142e:	eb 69                	jmp    1499 <ahci_find_cmdtbl+0x102>
				ctp = ctp->next;
    1430:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1433:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1436:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    1439:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    143d:	0f 85 6e ff ff ff    	jne    13b1 <ahci_find_cmdtbl+0x1a>
		if (jiffies - warn_time > HZ * 300) {
    1443:	a1 00 00 00 00       	mov    eax,ds:0x0
    1448:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    144b:	8b 00                	mov    eax,DWORD PTR [eax]
    144d:	8b 0d 00 01 00 00    	mov    ecx,DWORD PTR ds:0x100
    1453:	8b 1d 04 01 00 00    	mov    ebx,DWORD PTR ds:0x104
    1459:	29 c8                	sub    eax,ecx
    145b:	19 da                	sbb    edx,ebx
    145d:	bb cc 8d 00 00       	mov    ebx,0x8dcc
    1462:	b9 00 00 00 00       	mov    ecx,0x0
    1467:	39 c3                	cmp    ebx,eax
    1469:	19 d1                	sbb    ecx,edx
    146b:	73 27                	jae    1494 <ahci_find_cmdtbl+0xfd>
				warn_time = jiffies;
    146d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1472:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1475:	8b 00                	mov    eax,DWORD PTR [eax]
    1477:	a3 00 01 00 00       	mov    ds:0x100,eax
    147c:	89 15 04 01 00 00    	mov    DWORD PTR ds:0x104,edx
				cprintf(KFMT_INFO, "Command table pool exhausted.\nI/O performance"
    1482:	83 ec 08             	sub    esp,0x8
    1485:	68 4c 02 00 00       	push   0x24c
    148a:	6a 0b                	push   0xb
    148c:	e8 fc ff ff ff       	call   148d <ahci_find_cmdtbl+0xf6>
    1491:	83 c4 10             	add    esp,0x10
		return NULL;
    1494:	b8 00 00 00 00       	mov    eax,0x0
}
    1499:	8d 65 f4             	lea    esp,[ebp-0xc]
    149c:	5b                   	pop    ebx
    149d:	5e                   	pop    esi
    149e:	5f                   	pop    edi
    149f:	5d                   	pop    ebp
    14a0:	c3                   	ret

000014a1 <ahci_process_host_command>:
{
    14a1:	55                   	push   ebp
    14a2:	89 e5                	mov    ebp,esp
    14a4:	57                   	push   edi
    14a5:	56                   	push   esi
    14a6:	53                   	push   ebx
    14a7:	83 ec 5c             	sub    esp,0x5c
		switch (cc->c) {
    14aa:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14ad:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    14b0:	3d 80 00 00 00       	cmp    eax,0x80
    14b5:	74 10                	je     14c7 <ahci_process_host_command+0x26>
    14b7:	3d 82 00 00 00       	cmp    eax,0x82
    14bc:	0f 84 06 05 00 00    	je     19c8 <ahci_process_host_command+0x527>
    14c2:	e9 04 06 00 00       	jmp    1acb <ahci_process_host_command+0x62a>
						struct ata_identify* id = ad->identify_data[cc->port].ptr;
    14c7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14ca:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    14ce:	0f b7 d0             	movzx  edx,ax
    14d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14d4:	83 c2 10             	add    edx,0x10
    14d7:	c1 e2 04             	shl    edx,0x4
    14da:	01 d0                	add    eax,edx
    14dc:	83 c0 10             	add    eax,0x10
    14df:	8b 00                	mov    eax,DWORD PTR [eax]
    14e1:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
						int comp = 1, su = 0, pt = cc->port;
    14e4:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
    14eb:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    14f2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14f5:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    14f9:	0f b7 c0             	movzx  eax,ax
    14fc:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC
    14ff:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1502:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1506:	66 3d c8 37          	cmp    ax,0x37c8
    150a:	74 0d                	je     1519 <ahci_process_host_command+0x78>
								|| id->specific_configuration == ATA_SC_NO_SPIN_UP_INC)
    150c:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    150f:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1513:	66 3d 73 8c          	cmp    ax,0x8c73
    1517:	75 07                	jne    1520 <ahci_process_host_command+0x7f>
								comp = 0;
    1519:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP
    1520:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1523:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1527:	66 3d 8c 73          	cmp    ax,0x738c
    152b:	74 0d                	je     153a <ahci_process_host_command+0x99>
								|| id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC)
    152d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1530:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1534:	66 3d c8 37          	cmp    ax,0x37c8
    1538:	75 07                	jne    1541 <ahci_process_host_command+0xa0>
								su = 1;
    153a:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
						if (comp && id->checksum_validity == 0xa5) {
    1541:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1545:	74 66                	je     15ad <ahci_process_host_command+0x10c>
    1547:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    154a:	0f b6 80 fe 01 00 00 	movzx  eax,BYTE PTR [eax+0x1fe]
    1551:	3c a5                	cmp    al,0xa5
    1553:	75 58                	jne    15ad <ahci_process_host_command+0x10c>
								if (checksum_memory(id, sizeof(*id))) {
    1555:	68 00 02 00 00       	push   0x200
    155a:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    155d:	e8 06 ec ff ff       	call   168 <checksum_memory>
    1562:	83 c4 08             	add    esp,0x8
    1565:	84 c0                	test   al,al
    1567:	74 44                	je     15ad <ahci_process_host_command+0x10c>
										cc->c = disk_cmd_identify;
    1569:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    156c:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
										cc->ptr = NULL;
    1573:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1576:	c7 40 20 00 00 00 00 	mov    DWORD PTR [eax+0x20],0x0
										cc->cur_buf = NULL;
    157d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1580:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
										printf("Invalid IDENTIFY received: reissuing...\n");
    1587:	83 ec 0c             	sub    esp,0xc
    158a:	68 94 02 00 00       	push   0x294
    158f:	e8 fc ff ff ff       	call   1590 <ahci_process_host_command+0xef>
    1594:	83 c4 10             	add    esp,0x10
										ahci_reissue_command(ad, cc);
    1597:	83 ec 08             	sub    esp,0x8
    159a:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    159d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15a0:	e8 fc ff ff ff       	call   15a1 <ahci_process_host_command+0x100>
    15a5:	83 c4 10             	add    esp,0x10
										return; /* we reuse cc */
    15a8:	e9 77 05 00 00       	jmp    1b24 <ahci_process_host_command+0x683>
						if (comp) {
    15ad:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    15b1:	0f 84 dc 03 00 00    	je     1993 <ahci_process_host_command+0x4f2>
								uint64_t max_sec = 0; uint32_t lpp = 1, lls = 512, lof = 0;
    15b7:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    15be:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    15c5:	c7 45 d4 01 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x1
    15cc:	c7 45 d0 00 02 00 00 	mov    DWORD PTR [ebp-0x30],0x200
    15d3:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    15da:	eb 01                	jmp    15dd <ahci_process_host_command+0x13c>
								goto is_comp;				
    15dc:	90                   	nop
								convert_ata_string(id->model_number, 20);
    15dd:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    15e0:	83 c0 36             	add    eax,0x36
    15e3:	83 ec 08             	sub    esp,0x8
    15e6:	6a 14                	push   0x14
    15e8:	50                   	push   eax
    15e9:	e8 a8 eb ff ff       	call   196 <convert_ata_string>
    15ee:	83 c4 10             	add    esp,0x10
								convert_ata_string(id->additional_product_identifier, 4);
    15f1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    15f4:	05 54 01 00 00       	add    eax,0x154
    15f9:	83 ec 08             	sub    esp,0x8
    15fc:	6a 04                	push   0x4
    15fe:	50                   	push   eax
    15ff:	e8 92 eb ff ff       	call   196 <convert_ata_string>
    1604:	83 c4 10             	add    esp,0x10
								convert_ata_string(id->current_media_manufacturer, 10);
    1607:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    160a:	05 88 01 00 00       	add    eax,0x188
    160f:	83 ec 08             	sub    esp,0x8
    1612:	6a 0a                	push   0xa
    1614:	50                   	push   eax
    1615:	e8 7c eb ff ff       	call   196 <convert_ata_string>
    161a:	83 c4 10             	add    esp,0x10
								convert_ata_string(id->current_media_serial_number, 20);
    161d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1620:	05 60 01 00 00       	add    eax,0x160
    1625:	83 ec 08             	sub    esp,0x8
    1628:	6a 14                	push   0x14
    162a:	50                   	push   eax
    162b:	e8 66 eb ff ff       	call   196 <convert_ata_string>
    1630:	83 c4 10             	add    esp,0x10
								convert_ata_string(id->firmware_rev, 4);
    1633:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1636:	83 c0 2e             	add    eax,0x2e
    1639:	83 ec 08             	sub    esp,0x8
    163c:	6a 04                	push   0x4
    163e:	50                   	push   eax
    163f:	e8 52 eb ff ff       	call   196 <convert_ata_string>
    1644:	83 c4 10             	add    esp,0x10
								convert_ata_string(id->serial_number, 10);
    1647:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    164a:	83 c0 14             	add    eax,0x14
    164d:	83 ec 08             	sub    esp,0x8
    1650:	6a 0a                	push   0xa
    1652:	50                   	push   eax
    1653:	e8 3e eb ff ff       	call   196 <convert_ata_string>
    1658:	83 c4 10             	add    esp,0x10
								if (!id->lba_supp) {
    165b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    165e:	0f b6 40 63          	movzx  eax,BYTE PTR [eax+0x63]
    1662:	83 e0 02             	and    eax,0x2
    1665:	84 c0                	test   al,al
    1667:	75 10                	jne    1679 <ahci_process_host_command+0x1d8>
										max_sec = -1; /* CHS? ATAncient */
    1669:	c7 45 d8 ff ff ff ff 	mov    DWORD PTR [ebp-0x28],0xffffffff
    1670:	c7 45 dc ff ff ff ff 	mov    DWORD PTR [ebp-0x24],0xffffffff
    1677:	eb 49                	jmp    16c2 <ahci_process_host_command+0x221>
								} else if (id->has_lba48 || id->has_lba48_alt)
    1679:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    167c:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [eax+0xa7]
    1683:	83 e0 04             	and    eax,0x4
    1686:	84 c0                	test   al,al
    1688:	75 11                	jne    169b <ahci_process_host_command+0x1fa>
    168a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    168d:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [eax+0xad]
    1694:	83 e0 04             	and    eax,0x4
    1697:	84 c0                	test   al,al
    1699:	74 17                	je     16b2 <ahci_process_host_command+0x211>
										max_sec = id->num_logical_sectors;
    169b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    169e:	8b 90 cc 00 00 00    	mov    edx,DWORD PTR [eax+0xcc]
    16a4:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [eax+0xc8]
    16aa:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    16ad:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    16b0:	eb 10                	jmp    16c2 <ahci_process_host_command+0x221>
										max_sec = id->max_lba28;
    16b2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16b5:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
    16b8:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    16bb:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
								if (id->has_multiple_logical_per_physical_sectors) {
    16c2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16c5:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
    16cc:	83 e0 20             	and    eax,0x20
    16cf:	84 c0                	test   al,al
    16d1:	74 1e                	je     16f1 <ahci_process_host_command+0x250>
										lpp = 1 << id->num_pwr2_logical_per_phys;
    16d3:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16d6:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [eax+0xd4]
    16dd:	83 e0 0f             	and    eax,0xf
    16e0:	0f b6 c0             	movzx  eax,al
    16e3:	ba 01 00 00 00       	mov    edx,0x1
    16e8:	89 c1                	mov    ecx,eax
    16ea:	d3 e2                	shl    edx,cl
    16ec:	89 d0                	mov    eax,edx
    16ee:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								if (id->logical_sector_longer_than_512bt) {
    16f1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16f4:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
    16fb:	83 e0 10             	and    eax,0x10
    16fe:	84 c0                	test   al,al
    1700:	74 2d                	je     172f <ahci_process_host_command+0x28e>
										lls = 2 * id->logical_sector_size;
    1702:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1705:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [eax+0xea]
    170b:	01 c0                	add    eax,eax
    170d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										lof = id->logical_sector_offset;
    1710:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1713:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [eax+0x1a2]
    171a:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [eax+0x1a3]
    1721:	83 e0 3f             	and    eax,0x3f
    1724:	c1 e0 08             	shl    eax,0x8
    1727:	09 d0                	or     eax,edx
    1729:	0f b7 c0             	movzx  eax,ax
    172c:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
												(char*)id->current_media_manufacturer, (char*)id->current_media_serial_number);
    172f:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1732:	8d b8 60 01 00 00    	lea    edi,[eax+0x160]
    1738:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    173b:	8d b0 88 01 00 00    	lea    esi,[eax+0x188]
												(char*)id->serial_number, (char*)id->firmware_rev,
    1741:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1744:	8d 58 2e             	lea    ebx,[eax+0x2e]
    1747:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    174a:	8d 48 14             	lea    ecx,[eax+0x14]
												pt, (char*)id->model_number, (char*)id->additional_product_identifier,
    174d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1750:	8d 90 54 01 00 00    	lea    edx,[eax+0x154]
    1756:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1759:	83 c0 36             	add    eax,0x36
								printf("IDENTIFY on port %u: %.40s %.8s %.20s %.8s\nMedia: %.20s %.40s\n",
    175c:	57                   	push   edi
    175d:	56                   	push   esi
    175e:	53                   	push   ebx
    175f:	51                   	push   ecx
    1760:	52                   	push   edx
    1761:	50                   	push   eax
    1762:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    1765:	68 c0 02 00 00       	push   0x2c0
    176a:	e8 fc ff ff ff       	call   176b <ahci_process_host_command+0x2ca>
    176f:	83 c4 20             	add    esp,0x20
										capstr(id->form_factor, 6, "", "5.25\"", "3.5\"", "2.5\"", "1.8\"", "<1.8\"", ""),
    1772:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1775:	0f b6 80 50 01 00 00 	movzx  eax,BYTE PTR [eax+0x150]
    177c:	83 e0 0f             	and    eax,0xf
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    177f:	0f b6 c0             	movzx  eax,al
    1782:	83 ec 0c             	sub    esp,0xc
    1785:	68 ff 02 00 00       	push   0x2ff
    178a:	68 00 03 00 00       	push   0x300
    178f:	68 06 03 00 00       	push   0x306
    1794:	68 0b 03 00 00       	push   0x30b
    1799:	68 10 03 00 00       	push   0x310
    179e:	68 15 03 00 00       	push   0x315
    17a3:	68 ff 02 00 00       	push   0x2ff
    17a8:	6a 06                	push   0x6
    17aa:	50                   	push   eax
    17ab:	e8 fc ff ff ff       	call   17ac <ahci_process_host_command+0x30b>
    17b0:	83 c4 30             	add    esp,0x30
    17b3:	89 c2                	mov    edx,eax
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    17b5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    17b8:	0f b6 40 63          	movzx  eax,BYTE PTR [eax+0x63]
    17bc:	83 e0 02             	and    eax,0x2
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    17bf:	84 c0                	test   al,al
    17c1:	74 1f                	je     17e2 <ahci_process_host_command+0x341>
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    17c3:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    17c6:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [eax+0xa7]
    17cd:	83 e0 04             	and    eax,0x4
    17d0:	84 c0                	test   al,al
    17d2:	74 07                	je     17db <ahci_process_host_command+0x33a>
    17d4:	b8 1b 03 00 00       	mov    eax,0x31b
    17d9:	eb 0c                	jmp    17e7 <ahci_process_host_command+0x346>
    17db:	b8 21 03 00 00       	mov    eax,0x321
    17e0:	eb 05                	jmp    17e7 <ahci_process_host_command+0x346>
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    17e2:	b8 27 03 00 00       	mov    eax,0x327
										id->ata_version_major, id->ata_version_minor,
    17e7:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    17ea:	0f b7 89 a2 00 00 00 	movzx  ecx,WORD PTR [ecx+0xa2]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    17f1:	0f b7 d9             	movzx  ebx,cx
										id->ata_version_major, id->ata_version_minor,
    17f4:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    17f7:	0f b7 89 a0 00 00 00 	movzx  ecx,WORD PTR [ecx+0xa0]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    17fe:	0f b7 c9             	movzx  ecx,cx
    1801:	83 ec 04             	sub    esp,0x4
    1804:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1807:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    180a:	52                   	push   edx
    180b:	50                   	push   eax
    180c:	53                   	push   ebx
    180d:	51                   	push   ecx
    180e:	68 2c 03 00 00       	push   0x32c
    1813:	e8 fc ff ff ff       	call   1814 <ahci_process_host_command+0x373>
    1818:	83 c4 20             	add    esp,0x20
								printf("Logical sectors: size: %u offset: %u num_per_phys: %u\n", lls, lof, lpp);
    181b:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    181e:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1821:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1824:	68 68 03 00 00       	push   0x368
    1829:	e8 fc ff ff ff       	call   182a <ahci_process_host_command+0x389>
    182e:	83 c4 10             	add    esp,0x10
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    1831:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    1834:	bb 00 00 00 00       	mov    ebx,0x0
    1839:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    183c:	0f af c3             	imul   eax,ebx
    183f:	89 c2                	mov    edx,eax
    1841:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1844:	0f af c1             	imul   eax,ecx
    1847:	8d 34 02             	lea    esi,[edx+eax*1]
    184a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    184d:	f7 e1                	mul    ecx
    184f:	8d 0c 16             	lea    ecx,[esi+edx*1]
    1852:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1854:	89 d0                	mov    eax,edx
    1856:	31 d2                	xor    edx,edx
    1858:	c1 e8 08             	shr    eax,0x8
    185b:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    185e:	89 55 b4             	mov    DWORD PTR [ebp-0x4c],edx
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    1861:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    1864:	bb 00 00 00 00       	mov    ebx,0x0
    1869:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    186c:	89 c2                	mov    edx,eax
    186e:	0f af d3             	imul   edx,ebx
    1871:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1874:	0f af c1             	imul   eax,ecx
    1877:	8d 34 02             	lea    esi,[edx+eax*1]
    187a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    187d:	f7 e1                	mul    ecx
    187f:	8d 0c 16             	lea    ecx,[esi+edx*1]
    1882:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1884:	0f ac d0 1e          	shrd   eax,edx,0x1e
    1888:	c1 ea 1e             	shr    edx,0x1e
    188b:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    188e:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1891:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    1894:	bb 00 00 00 00       	mov    ebx,0x0
    1899:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    189c:	89 c2                	mov    edx,eax
    189e:	0f af d3             	imul   edx,ebx
    18a1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18a4:	0f af c1             	imul   eax,ecx
    18a7:	8d 34 02             	lea    esi,[edx+eax*1]
    18aa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18ad:	f7 e1                	mul    ecx
    18af:	8d 0c 16             	lea    ecx,[esi+edx*1]
    18b2:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    18b4:	89 c3                	mov    ebx,eax
    18b6:	89 d6                	mov    esi,edx
    18b8:	0f ac f3 14          	shrd   ebx,esi,0x14
    18bc:	c1 ee 14             	shr    esi,0x14
    18bf:	89 5d a0             	mov    DWORD PTR [ebp-0x60],ebx
    18c2:	89 75 a4             	mov    DWORD PTR [ebp-0x5c],esi
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    18c5:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    18c8:	bb 00 00 00 00       	mov    ebx,0x0
    18cd:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18d0:	89 c2                	mov    edx,eax
    18d2:	0f af d3             	imul   edx,ebx
    18d5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18d8:	0f af c1             	imul   eax,ecx
    18db:	8d 34 02             	lea    esi,[edx+eax*1]
    18de:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18e1:	f7 e1                	mul    ecx
    18e3:	8d 0c 16             	lea    ecx,[esi+edx*1]
    18e6:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    18e8:	89 c6                	mov    esi,eax
    18ea:	89 d7                	mov    edi,edx
    18ec:	0f ac fe 0a          	shrd   esi,edi,0xa
    18f0:	c1 ef 0a             	shr    edi,0xa
    18f3:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    18f6:	bb 00 00 00 00       	mov    ebx,0x0
    18fb:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18fe:	89 c2                	mov    edx,eax
    1900:	0f af d3             	imul   edx,ebx
    1903:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1906:	0f af c1             	imul   eax,ecx
    1909:	01 c2                	add    edx,eax
    190b:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
    190e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1911:	f7 e1                	mul    ecx
    1913:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1916:	01 d1                	add    ecx,edx
    1918:	89 ca                	mov    edx,ecx
    191a:	83 ec 04             	sub    esp,0x4
    191d:	ff 75 b4             	push   DWORD PTR [ebp-0x4c]
    1920:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
    1923:	ff 75 ac             	push   DWORD PTR [ebp-0x54]
    1926:	ff 75 a8             	push   DWORD PTR [ebp-0x58]
    1929:	ff 75 a4             	push   DWORD PTR [ebp-0x5c]
    192c:	ff 75 a0             	push   DWORD PTR [ebp-0x60]
    192f:	57                   	push   edi
    1930:	56                   	push   esi
    1931:	52                   	push   edx
    1932:	50                   	push   eax
    1933:	68 a0 03 00 00       	push   0x3a0
    1938:	e8 fc ff ff ff       	call   1939 <ahci_process_host_command+0x498>
    193d:	83 c4 30             	add    esp,0x30
								if (!id->is_not_ata) {
    1940:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1943:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    1947:	83 e0 80             	and    eax,0xffffff80
    194a:	84 c0                	test   al,al
    194c:	0f 85 ab 01 00 00    	jne    1afd <ahci_process_host_command+0x65c>
										if (register_ata_device(ad, p, 0, id))
    1952:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    1955:	6a 00                	push   0x0
    1957:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    195a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    195d:	e8 fc ff ff ff       	call   195e <ahci_process_host_command+0x4bd>
    1962:	83 c4 10             	add    esp,0x10
    1965:	85 c0                	test   eax,eax
    1967:	74 15                	je     197e <ahci_process_host_command+0x4dd>
												printf("Registered device in file system.\n");
    1969:	83 ec 0c             	sub    esp,0xc
    196c:	68 d4 03 00 00       	push   0x3d4
    1971:	e8 fc ff ff ff       	call   1972 <ahci_process_host_command+0x4d1>
    1976:	83 c4 10             	add    esp,0x10
						break;
    1979:	e9 7f 01 00 00       	jmp    1afd <ahci_process_host_command+0x65c>
												printf("Failed to register device.\n");
    197e:	83 ec 0c             	sub    esp,0xc
    1981:	68 f7 03 00 00       	push   0x3f7
    1986:	e8 fc ff ff ff       	call   1987 <ahci_process_host_command+0x4e6>
    198b:	83 c4 10             	add    esp,0x10
						break;
    198e:	e9 6a 01 00 00       	jmp    1afd <ahci_process_host_command+0x65c>
						} else if (su) {
    1993:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1997:	0f 84 3f fc ff ff    	je     15dc <ahci_process_host_command+0x13b>
								die("spin-up by SET FEATURES not supported yet!\n");
    199d:	83 ec 08             	sub    esp,0x8
    19a0:	68 14 04 00 00       	push   0x414
    19a5:	6a 0c                	push   0xc
    19a7:	e8 fc ff ff ff       	call   19a8 <ahci_process_host_command+0x507>
    19ac:	83 c4 10             	add    esp,0x10
    19af:	e8 fc ff ff ff       	call   19b0 <ahci_process_host_command+0x50f>
    19b4:	83 ec 0c             	sub    esp,0xc
    19b7:	68 00 00 00 00       	push   0x0
    19bc:	e8 fc ff ff ff       	call   19bd <ahci_process_host_command+0x51c>
    19c1:	83 c4 10             	add    esp,0x10
    19c4:	fa                   	cli
    19c5:	f4                   	hlt
    19c6:	eb fd                	jmp    19c5 <ahci_process_host_command+0x524>
						int timeout = 50; /* up to 500 ms */
    19c8:	c7 45 c8 32 00 00 00 	mov    DWORD PTR [ebp-0x38],0x32
						p->cmd.st = 0;
    19cf:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    19d2:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    19d5:	83 e0 fe             	and    eax,0xfffffffe
    19d8:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						while (p->cmd.cr && timeout--)
    19db:	eb 0d                	jmp    19ea <ahci_process_host_command+0x549>
								mdelay(10);
    19dd:	83 ec 0c             	sub    esp,0xc
    19e0:	6a 0a                	push   0xa
    19e2:	e8 fc ff ff ff       	call   19e3 <ahci_process_host_command+0x542>
    19e7:	83 c4 10             	add    esp,0x10
						while (p->cmd.cr && timeout--)
    19ea:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19ed:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    19f0:	c1 e8 0f             	shr    eax,0xf
    19f3:	83 e0 01             	and    eax,0x1
    19f6:	84 c0                	test   al,al
    19f8:	74 0d                	je     1a07 <ahci_process_host_command+0x566>
    19fa:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    19fd:	8d 50 ff             	lea    edx,[eax-0x1]
    1a00:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    1a03:	85 c0                	test   eax,eax
    1a05:	75 d6                	jne    19dd <ahci_process_host_command+0x53c>
						if (p->cmd.cr) {
    1a07:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a0a:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1a0d:	c1 e8 0f             	shr    eax,0xf
    1a10:	83 e0 01             	and    eax,0x1
    1a13:	84 c0                	test   al,al
    1a15:	74 44                	je     1a5b <ahci_process_host_command+0x5ba>
full_reset:
    1a17:	90                   	nop
    1a18:	eb 01                	jmp    1a1b <ahci_process_host_command+0x57a>
										goto full_reset;
    1a1a:	90                   	nop
										p - ad->ptr->port);
    1a1b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a1e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a21:	05 00 01 00 00       	add    eax,0x100
    1a26:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1a29:	29 c2                	sub    edx,eax
								abprintf("performing full port reset on port %zd\n",
    1a2b:	89 d0                	mov    eax,edx
    1a2d:	c1 f8 07             	sar    eax,0x7
    1a30:	83 ec 08             	sub    esp,0x8
    1a33:	50                   	push   eax
    1a34:	68 40 04 00 00       	push   0x440
    1a39:	e8 fc ff ff ff       	call   1a3a <ahci_process_host_command+0x599>
    1a3e:	83 c4 10             	add    esp,0x10
								ahci_reset_port(ad->ptr, p);
    1a41:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a44:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a47:	83 ec 08             	sub    esp,0x8
    1a4a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1a4d:	50                   	push   eax
    1a4e:	e8 fc ff ff ff       	call   1a4f <ahci_process_host_command+0x5ae>
    1a53:	83 c4 10             	add    esp,0x10
						break;
    1a56:	e9 a3 00 00 00       	jmp    1afe <ahci_process_host_command+0x65d>
								p->pXserr = 0xffffffff;
    1a5b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a5e:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
								p->pXis = 0xffffffff; /* likewise */
    1a65:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a68:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [eax+0x10],0xffffffff
								if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    1a6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a72:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1a75:	0f b6 c0             	movzx  eax,al
    1a78:	25 88 00 00 00       	and    eax,0x88
    1a7d:	85 c0                	test   eax,eax
    1a7f:	75 99                	jne    1a1a <ahci_process_host_command+0x579>
								p->cmd.st = 1;
    1a81:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1a84:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    1a87:	83 c8 01             	or     eax,0x1
    1a8a:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1a8d:	b8 32 00 00 00       	mov    eax,0x32
    1a92:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
    1a95:	89 c2                	mov    edx,eax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1a97:	89 d0                	mov    eax,edx
    1a99:	c1 e0 02             	shl    eax,0x2
    1a9c:	01 d0                	add    eax,edx
    1a9e:	01 c0                	add    eax,eax
    1aa0:	89 c1                	mov    ecx,eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1aa2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aa5:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1aa8:	05 00 01 00 00       	add    eax,0x100
    1aad:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1ab0:	29 c2                	sub    edx,eax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1ab2:	89 d0                	mov    eax,edx
    1ab4:	c1 f8 07             	sar    eax,0x7
    1ab7:	83 ec 04             	sub    esp,0x4
    1aba:	51                   	push   ecx
    1abb:	50                   	push   eax
    1abc:	68 68 04 00 00       	push   0x468
    1ac1:	e8 fc ff ff ff       	call   1ac2 <ahci_process_host_command+0x621>
    1ac6:	83 c4 10             	add    esp,0x10
						break;
    1ac9:	eb 33                	jmp    1afe <ahci_process_host_command+0x65d>
						die("someone messed up! command=%x\n", cc->c);
    1acb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ace:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1ad1:	83 ec 04             	sub    esp,0x4
    1ad4:	50                   	push   eax
    1ad5:	68 a0 04 00 00       	push   0x4a0
    1ada:	6a 0c                	push   0xc
    1adc:	e8 fc ff ff ff       	call   1add <ahci_process_host_command+0x63c>
    1ae1:	83 c4 10             	add    esp,0x10
    1ae4:	e8 fc ff ff ff       	call   1ae5 <ahci_process_host_command+0x644>
    1ae9:	83 ec 0c             	sub    esp,0xc
    1aec:	68 00 00 00 00       	push   0x0
    1af1:	e8 fc ff ff ff       	call   1af2 <ahci_process_host_command+0x651>
    1af6:	83 c4 10             	add    esp,0x10
    1af9:	fa                   	cli
    1afa:	f4                   	hlt
    1afb:	eb fd                	jmp    1afa <ahci_process_host_command+0x659>
						break;
    1afd:	90                   	nop
		ahci_release_cmdtbl(ad, cc->entry);
    1afe:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b01:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1b04:	83 ec 08             	sub    esp,0x8
    1b07:	50                   	push   eax
    1b08:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1b0b:	e8 fc ff ff ff       	call   1b0c <ahci_process_host_command+0x66b>
    1b10:	83 c4 10             	add    esp,0x10
		ahci_destroy_context(ad, cc);
    1b13:	83 ec 08             	sub    esp,0x8
    1b16:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1b19:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1b1c:	e8 fc ff ff ff       	call   1b1d <ahci_process_host_command+0x67c>
    1b21:	83 c4 10             	add    esp,0x10
}
    1b24:	8d 65 f4             	lea    esp,[ebp-0xc]
    1b27:	5b                   	pop    ebx
    1b28:	5e                   	pop    esi
    1b29:	5f                   	pop    edi
    1b2a:	5d                   	pop    ebp
    1b2b:	c3                   	ret

00001b2c <ahci_process_command>:
{
    1b2c:	55                   	push   ebp
    1b2d:	89 e5                	mov    ebp,esp
    1b2f:	53                   	push   ebx
    1b30:	83 ec 54             	sub    esp,0x54
		struct cmd_ctx* cc; int slt, rv, pt = p - ad->ptr->port; uint32_t ct;
    1b33:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b36:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b39:	05 00 01 00 00       	add    eax,0x100
    1b3e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1b41:	29 c2                	sub    edx,eax
    1b43:	89 d0                	mov    eax,edx
    1b45:	c1 f8 07             	sar    eax,0x7
    1b48:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		struct ahci_cmdlst* cl = ad->command_lists[pt];
    1b4b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b4e:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1b51:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    1b55:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		if (!cl)
    1b58:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1b5c:	75 15                	jne    1b73 <ahci_process_command+0x47>
				abprintf("Ignoring command on port %d as it's command"
    1b5e:	83 ec 08             	sub    esp,0x8
    1b61:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1b64:	68 c0 04 00 00       	push   0x4c0
    1b69:	e8 fc ff ff ff       	call   1b6a <ahci_process_command+0x3e>
    1b6e:	83 c4 10             	add    esp,0x10
    1b71:	eb 01                	jmp    1b74 <ahci_process_command+0x48>
next_cmd:
    1b73:	90                   	nop
		slt = ahci_find_slot(p, ad->num_cmd); /* does not reserve -> no cleanup */
    1b74:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b77:	0f b7 40 0a          	movzx  eax,WORD PTR [eax+0xa]
    1b7b:	0f b7 c0             	movzx  eax,ax
    1b7e:	83 ec 08             	sub    esp,0x8
    1b81:	50                   	push   eax
    1b82:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1b85:	e8 fc ff ff ff       	call   1b86 <ahci_process_command+0x5a>
    1b8a:	83 c4 10             	add    esp,0x10
    1b8d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		if (slt == -1) /* still full */
    1b90:	83 7d d0 ff          	cmp    DWORD PTR [ebp-0x30],0xffffffff
    1b94:	0f 84 91 06 00 00    	je     222b <ahci_process_command+0x6ff>
		if (!p->cmd.st) {
    1b9a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b9d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1ba0:	83 e0 01             	and    eax,0x1
    1ba3:	84 c0                	test   al,al
    1ba5:	0f 85 a7 00 00 00    	jne    1c52 <ahci_process_command+0x126>
				abprintf("waiting for reset host command on port %d\n", pt);
    1bab:	83 ec 08             	sub    esp,0x8
    1bae:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1bb1:	68 04 05 00 00       	push   0x504
    1bb6:	e8 fc ff ff ff       	call   1bb7 <ahci_process_command+0x8b>
    1bbb:	83 c4 10             	add    esp,0x10
				cc = list_cut_first_entry_where(lh, struct cmd_ctx, lst,
    1bbe:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1bc5:	83 ec 0c             	sub    esp,0xc
    1bc8:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1bcb:	e8 84 e5 ff ff       	call   154 <list_empty>
    1bd0:	83 c4 10             	add    esp,0x10
    1bd3:	85 c0                	test   eax,eax
    1bd5:	75 70                	jne    1c47 <ahci_process_command+0x11b>
    1bd7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bda:	83 c0 08             	add    eax,0x8
    1bdd:	83 ec 0c             	sub    esp,0xc
    1be0:	50                   	push   eax
    1be1:	e8 fc ff ff ff       	call   1be2 <ahci_process_command+0xb6>
    1be6:	83 c4 10             	add    esp,0x10
    1be9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bec:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bef:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1bf2:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1bf5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1bf8:	eb 33                	jmp    1c2d <ahci_process_command+0x101>
    1bfa:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1bfd:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1c00:	3d 82 00 00 00       	cmp    eax,0x82
    1c05:	75 17                	jne    1c1e <ahci_process_command+0xf2>
    1c07:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c0a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1c0d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c10:	83 ec 0c             	sub    esp,0xc
    1c13:	50                   	push   eax
    1c14:	e8 43 e4 ff ff       	call   5c <__list_del>
    1c19:	83 c4 10             	add    esp,0x10
    1c1c:	eb 17                	jmp    1c35 <ahci_process_command+0x109>
    1c1e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c21:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c24:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    1c27:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1c2a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1c2d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c30:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
    1c33:	75 c5                	jne    1bfa <ahci_process_command+0xce>
    1c35:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c38:	83 c0 08             	add    eax,0x8
    1c3b:	83 ec 0c             	sub    esp,0xc
    1c3e:	50                   	push   eax
    1c3f:	e8 fc ff ff ff       	call   1c40 <ahci_process_command+0x114>
    1c44:	83 c4 10             	add    esp,0x10
    1c47:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1c4a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1c4d:	e9 98 00 00 00       	jmp    1cea <ahci_process_command+0x1be>
				abprintf("processing command in slot %d on port %d\n", slt, pt);
    1c52:	83 ec 04             	sub    esp,0x4
    1c55:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1c58:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1c5b:	68 30 05 00 00       	push   0x530
    1c60:	e8 fc ff ff ff       	call   1c61 <ahci_process_command+0x135>
    1c65:	83 c4 10             	add    esp,0x10
				cc = list_cut_first_entry(lh, struct cmd_ctx, lst);
    1c68:	83 ec 0c             	sub    esp,0xc
    1c6b:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1c6e:	e8 e1 e4 ff ff       	call   154 <list_empty>
    1c73:	83 c4 10             	add    esp,0x10
    1c76:	85 c0                	test   eax,eax
    1c78:	75 63                	jne    1cdd <ahci_process_command+0x1b1>
    1c7a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c7d:	83 c0 08             	add    eax,0x8
    1c80:	83 ec 0c             	sub    esp,0xc
    1c83:	50                   	push   eax
    1c84:	e8 fc ff ff ff       	call   1c85 <ahci_process_command+0x159>
    1c89:	83 c4 10             	add    esp,0x10
    1c8c:	83 ec 0c             	sub    esp,0xc
    1c8f:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1c92:	e8 bd e4 ff ff       	call   154 <list_empty>
    1c97:	83 c4 10             	add    esp,0x10
    1c9a:	85 c0                	test   eax,eax
    1c9c:	75 0e                	jne    1cac <ahci_process_command+0x180>
    1c9e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ca1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ca4:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    1ca7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1caa:	eb 05                	jmp    1cb1 <ahci_process_command+0x185>
    1cac:	b8 00 00 00 00       	mov    eax,0x0
    1cb1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1cb4:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1cb8:	74 0f                	je     1cc9 <ahci_process_command+0x19d>
    1cba:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cbd:	83 ec 0c             	sub    esp,0xc
    1cc0:	50                   	push   eax
    1cc1:	e8 96 e3 ff ff       	call   5c <__list_del>
    1cc6:	83 c4 10             	add    esp,0x10
    1cc9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ccc:	83 c0 08             	add    eax,0x8
    1ccf:	83 ec 0c             	sub    esp,0xc
    1cd2:	50                   	push   eax
    1cd3:	e8 fc ff ff ff       	call   1cd4 <ahci_process_command+0x1a8>
    1cd8:	83 c4 10             	add    esp,0x10
    1cdb:	eb 07                	jmp    1ce4 <ahci_process_command+0x1b8>
    1cdd:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    1ce4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1ce7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!cc) { /* the command vanished?/or isn't posted yet */
    1cea:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1cee:	75 15                	jne    1d05 <ahci_process_command+0x1d9>
				abprintf("command vanished\n");
    1cf0:	83 ec 0c             	sub    esp,0xc
    1cf3:	68 5a 05 00 00       	push   0x55a
    1cf8:	e8 fc ff ff ff       	call   1cf9 <ahci_process_command+0x1cd>
    1cfd:	83 c4 10             	add    esp,0x10
				return;
    1d00:	e9 27 05 00 00       	jmp    222c <ahci_process_command+0x700>
		if (cc->c == host_cmd_resend) {
    1d05:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d08:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d0b:	3d 81 00 00 00       	cmp    eax,0x81
    1d10:	75 0c                	jne    1d1e <ahci_process_command+0x1f2>
				rv = 0;
    1d12:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				goto issue;
    1d19:	e9 30 03 00 00       	jmp    204e <ahci_process_command+0x522>
		} else if (cc->c >= host_cmd_process_identify) {
    1d1e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d21:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d24:	83 f8 7f             	cmp    eax,0x7f
    1d27:	76 19                	jbe    1d42 <ahci_process_command+0x216>
				ahci_process_host_command(ad, p, cc);
    1d29:	83 ec 04             	sub    esp,0x4
    1d2c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1d2f:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1d32:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1d35:	e8 fc ff ff ff       	call   1d36 <ahci_process_command+0x20a>
    1d3a:	83 c4 10             	add    esp,0x10
				goto incr;
    1d3d:	e9 c6 04 00 00       	jmp    2208 <ahci_process_command+0x6dc>
		if (cc->ptr) {
    1d42:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d45:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1d48:	85 c0                	test   eax,eax
    1d4a:	74 7b                	je     1dc7 <ahci_process_command+0x29b>
				/*void* ptr2; */uint64_t s = cc->ct;
    1d4c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d4f:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1d52:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1d55:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1d58:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
				ct = rdiv(s, 4096) + 1; /* first guess */
    1d5b:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1d5e:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1d61:	0f ac d0 0c          	shrd   eax,edx,0xc
    1d65:	c1 ea 0c             	shr    edx,0xc
    1d68:	89 c1                	mov    ecx,eax
    1d6a:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1d6d:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1d70:	25 ff 0f 00 00       	and    eax,0xfff
    1d75:	ba 00 00 00 00       	mov    edx,0x0
    1d7a:	89 c3                	mov    ebx,eax
    1d7c:	89 d8                	mov    eax,ebx
    1d7e:	09 d0                	or     eax,edx
    1d80:	74 07                	je     1d89 <ahci_process_command+0x25d>
    1d82:	b8 01 00 00 00       	mov    eax,0x1
    1d87:	eb 05                	jmp    1d8e <ahci_process_command+0x262>
    1d89:	b8 00 00 00 00       	mov    eax,0x0
    1d8e:	01 c8                	add    eax,ecx
    1d90:	83 c0 01             	add    eax,0x1
    1d93:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (ct > 8) {
    1d96:	83 7d ec 08          	cmp    DWORD PTR [ebp-0x14],0x8
    1d9a:	76 45                	jbe    1de1 <ahci_process_command+0x2b5>
						die("implement this later.\n");
    1d9c:	83 ec 08             	sub    esp,0x8
    1d9f:	68 6c 05 00 00       	push   0x56c
    1da4:	6a 0c                	push   0xc
    1da6:	e8 fc ff ff ff       	call   1da7 <ahci_process_command+0x27b>
    1dab:	83 c4 10             	add    esp,0x10
    1dae:	e8 fc ff ff ff       	call   1daf <ahci_process_command+0x283>
    1db3:	83 ec 0c             	sub    esp,0xc
    1db6:	68 00 00 00 00       	push   0x0
    1dbb:	e8 fc ff ff ff       	call   1dbc <ahci_process_command+0x290>
    1dc0:	83 c4 10             	add    esp,0x10
    1dc3:	fa                   	cli
    1dc4:	f4                   	hlt
    1dc5:	eb fd                	jmp    1dc4 <ahci_process_command+0x298>
		} else if (cc->c == disk_cmd_identify) {
    1dc7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1dca:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1dcd:	85 c0                	test   eax,eax
    1dcf:	75 09                	jne    1dda <ahci_process_command+0x2ae>
				ct = 1;
    1dd1:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
    1dd8:	eb 07                	jmp    1de1 <ahci_process_command+0x2b5>
				ct = 0;
    1dda:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (!cc->entry) /* else: max_prdtl still valid */
    1de1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1de4:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1de7:	85 c0                	test   eax,eax
    1de9:	75 17                	jne    1e02 <ahci_process_command+0x2d6>
				cc->entry = ahci_find_cmdtbl(ad, ct);
    1deb:	83 ec 08             	sub    esp,0x8
    1dee:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1df1:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1df4:	e8 fc ff ff ff       	call   1df5 <ahci_process_command+0x2c9>
    1df9:	83 c4 10             	add    esp,0x10
    1dfc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1dff:	89 42 48             	mov    DWORD PTR [edx+0x48],eax
		if (cc->entry) {
    1e02:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e05:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e08:	85 c0                	test   eax,eax
    1e0a:	74 2b                	je     1e37 <ahci_process_command+0x30b>
				cc->entry->port = cc->port;
    1e0c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e0f:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e12:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1e15:	0f b7 52 30          	movzx  edx,WORD PTR [edx+0x30]
    1e19:	66 89 10             	mov    WORD PTR [eax],dx
				cc->entry->slot = slt;
    1e1c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e1f:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e22:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1e25:	66 89 50 02          	mov    WORD PTR [eax+0x2],dx
				cc->slot = slt;
    1e29:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1e2c:	89 c2                	mov    edx,eax
    1e2e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e31:	66 89 50 32          	mov    WORD PTR [eax+0x32],dx
    1e35:	eb 13                	jmp    1e4a <ahci_process_command+0x31e>
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);
    1e37:	83 ec 08             	sub    esp,0x8
    1e3a:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1e3d:	68 84 05 00 00       	push   0x584
    1e42:	e8 fc ff ff ff       	call   1e43 <ahci_process_command+0x317>
    1e47:	83 c4 10             	add    esp,0x10
		if (!cc->entry && ct > 8) { /* divide by twoish */
    1e4a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e4d:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e50:	85 c0                	test   eax,eax
    1e52:	75 42                	jne    1e96 <ahci_process_command+0x36a>
    1e54:	83 7d ec 08          	cmp    DWORD PTR [ebp-0x14],0x8
    1e58:	76 3c                	jbe    1e96 <ahci_process_command+0x36a>
				int log = bsr(ct) - 1;
    1e5a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e5d:	83 ec 0c             	sub    esp,0xc
    1e60:	50                   	push   eax
    1e61:	e8 9a e1 ff ff       	call   0 <bsr>
    1e66:	83 c4 10             	add    esp,0x10
    1e69:	83 e8 01             	sub    eax,0x1
    1e6c:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				uint32_t new_ct = (1 << log);
    1e6f:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1e72:	ba 01 00 00 00       	mov    edx,0x1
    1e77:	89 c1                	mov    ecx,eax
    1e79:	d3 e2                	shl    edx,cl
    1e7b:	89 d0                	mov    eax,edx
    1e7d:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (new_ct == ct)
    1e80:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1e83:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
    1e86:	75 03                	jne    1e8b <ahci_process_command+0x35f>
						new_ct >>= 1;
    1e88:	d1 6d dc             	shr    DWORD PTR [ebp-0x24],1
				ct = new_ct;
    1e8b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1e8e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				goto find;
    1e91:	e9 4b ff ff ff       	jmp    1de1 <ahci_process_command+0x2b5>
		} else if (!cc->entry) { /* none available */
    1e96:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e99:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e9c:	85 c0                	test   eax,eax
    1e9e:	75 27                	jne    1ec7 <ahci_process_command+0x39b>
				abprintf("waiting for cmdtbl to become available.\n");
    1ea0:	83 ec 0c             	sub    esp,0xc
    1ea3:	68 b0 05 00 00       	push   0x5b0
    1ea8:	e8 fc ff ff ff       	call   1ea9 <ahci_process_command+0x37d>
    1ead:	83 c4 10             	add    esp,0x10
				list_add(&cc->lst, lh);
    1eb0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1eb3:	83 ec 08             	sub    esp,0x8
    1eb6:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1eb9:	50                   	push   eax
    1eba:	e8 d1 e1 ff ff       	call   90 <list_add>
    1ebf:	83 c4 10             	add    esp,0x10
				return;
    1ec2:	e9 65 03 00 00       	jmp    222c <ahci_process_command+0x700>
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    1ec7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1eca:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1ecd:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    1ed1:	0f b7 c8             	movzx  ecx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    1ed4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ed7:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1eda:	0f b7 00             	movzx  eax,WORD PTR [eax]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    1edd:	0f b7 d0             	movzx  edx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    1ee0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ee3:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    1ee6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ee9:	51                   	push   ecx
    1eea:	52                   	push   edx
    1eeb:	50                   	push   eax
    1eec:	68 dc 05 00 00       	push   0x5dc
    1ef1:	e8 fc ff ff ff       	call   1ef2 <ahci_process_command+0x3c6>
    1ef6:	83 c4 10             	add    esp,0x10
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
    1ef9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1efc:	ba 08 00 00 00       	mov    edx,0x8
    1f01:	39 d0                	cmp    eax,edx
    1f03:	0f 43 d0             	cmovae edx,eax
    1f06:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f09:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
		if (p->cmd.atapi) { /* ATAPI */
    1f0c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f0f:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1f12:	c1 e8 18             	shr    eax,0x18
    1f15:	83 e0 01             	and    eax,0x1
    1f18:	84 c0                	test   al,al
    1f1a:	0f 84 8a 00 00 00    	je     1faa <ahci_process_command+0x47e>
				switch (cc->c) {
    1f20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f23:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1f26:	85 c0                	test   eax,eax
    1f28:	74 0a                	je     1f34 <ahci_process_command+0x408>
    1f2a:	83 e8 01             	sub    eax,0x1
    1f2d:	83 f8 02             	cmp    eax,0x2
    1f30:	77 46                	ja     1f78 <ahci_process_command+0x44c>
    1f32:	eb 19                	jmp    1f4d <ahci_process_command+0x421>
								rv = atapi_build_packet_device_identify(ad, cc);
    1f34:	83 ec 08             	sub    esp,0x8
    1f37:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1f3a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1f3d:	e8 fc ff ff ff       	call   1f3e <ahci_process_command+0x412>
    1f42:	83 c4 10             	add    esp,0x10
    1f45:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
    1f48:	e9 01 01 00 00       	jmp    204e <ahci_process_command+0x522>
								die("not implemented yet!\n");
    1f4d:	83 ec 08             	sub    esp,0x8
    1f50:	68 67 01 00 00       	push   0x167
    1f55:	6a 0c                	push   0xc
    1f57:	e8 fc ff ff ff       	call   1f58 <ahci_process_command+0x42c>
    1f5c:	83 c4 10             	add    esp,0x10
    1f5f:	e8 fc ff ff ff       	call   1f60 <ahci_process_command+0x434>
    1f64:	83 ec 0c             	sub    esp,0xc
    1f67:	68 00 00 00 00       	push   0x0
    1f6c:	e8 fc ff ff ff       	call   1f6d <ahci_process_command+0x441>
    1f71:	83 c4 10             	add    esp,0x10
    1f74:	fa                   	cli
    1f75:	f4                   	hlt
    1f76:	eb fd                	jmp    1f75 <ahci_process_command+0x449>
								die("The command %x should not end up here.\n", cc->c);
    1f78:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f7b:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1f7e:	83 ec 04             	sub    esp,0x4
    1f81:	50                   	push   eax
    1f82:	68 14 06 00 00       	push   0x614
    1f87:	6a 0c                	push   0xc
    1f89:	e8 fc ff ff ff       	call   1f8a <ahci_process_command+0x45e>
    1f8e:	83 c4 10             	add    esp,0x10
    1f91:	e8 fc ff ff ff       	call   1f92 <ahci_process_command+0x466>
    1f96:	83 ec 0c             	sub    esp,0xc
    1f99:	68 00 00 00 00       	push   0x0
    1f9e:	e8 fc ff ff ff       	call   1f9f <ahci_process_command+0x473>
    1fa3:	83 c4 10             	add    esp,0x10
    1fa6:	fa                   	cli
    1fa7:	f4                   	hlt
    1fa8:	eb fd                	jmp    1fa7 <ahci_process_command+0x47b>
				switch (cc->c) { /* ATA */
    1faa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fad:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1fb0:	83 f8 03             	cmp    eax,0x3
    1fb3:	77 67                	ja     201c <ahci_process_command+0x4f0>
    1fb5:	83 f8 02             	cmp    eax,0x2
    1fb8:	73 37                	jae    1ff1 <ahci_process_command+0x4c5>
    1fba:	85 c0                	test   eax,eax
    1fbc:	74 07                	je     1fc5 <ahci_process_command+0x499>
    1fbe:	83 f8 01             	cmp    eax,0x1
    1fc1:	74 18                	je     1fdb <ahci_process_command+0x4af>
    1fc3:	eb 57                	jmp    201c <ahci_process_command+0x4f0>
								rv = ata_build_device_identify(ad, cc);
    1fc5:	83 ec 08             	sub    esp,0x8
    1fc8:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1fcb:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1fce:	e8 fc ff ff ff       	call   1fcf <ahci_process_command+0x4a3>
    1fd3:	83 c4 10             	add    esp,0x10
    1fd6:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
    1fd9:	eb 73                	jmp    204e <ahci_process_command+0x522>
								rv = ata_build_read_dma_ext(ad, cc);
    1fdb:	83 ec 08             	sub    esp,0x8
    1fde:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1fe1:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1fe4:	e8 fc ff ff ff       	call   1fe5 <ahci_process_command+0x4b9>
    1fe9:	83 c4 10             	add    esp,0x10
    1fec:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
    1fef:	eb 5d                	jmp    204e <ahci_process_command+0x522>
								die("not implemented yet!\n");
    1ff1:	83 ec 08             	sub    esp,0x8
    1ff4:	68 67 01 00 00       	push   0x167
    1ff9:	6a 0c                	push   0xc
    1ffb:	e8 fc ff ff ff       	call   1ffc <ahci_process_command+0x4d0>
    2000:	83 c4 10             	add    esp,0x10
    2003:	e8 fc ff ff ff       	call   2004 <ahci_process_command+0x4d8>
    2008:	83 ec 0c             	sub    esp,0xc
    200b:	68 00 00 00 00       	push   0x0
    2010:	e8 fc ff ff ff       	call   2011 <ahci_process_command+0x4e5>
    2015:	83 c4 10             	add    esp,0x10
    2018:	fa                   	cli
    2019:	f4                   	hlt
    201a:	eb fd                	jmp    2019 <ahci_process_command+0x4ed>
								die("The command %x should not end up here.\n", cc->c);
    201c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    201f:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2022:	83 ec 04             	sub    esp,0x4
    2025:	50                   	push   eax
    2026:	68 14 06 00 00       	push   0x614
    202b:	6a 0c                	push   0xc
    202d:	e8 fc ff ff ff       	call   202e <ahci_process_command+0x502>
    2032:	83 c4 10             	add    esp,0x10
    2035:	e8 fc ff ff ff       	call   2036 <ahci_process_command+0x50a>
    203a:	83 ec 0c             	sub    esp,0xc
    203d:	68 00 00 00 00       	push   0x0
    2042:	e8 fc ff ff ff       	call   2043 <ahci_process_command+0x517>
    2047:	83 c4 10             	add    esp,0x10
    204a:	fa                   	cli
    204b:	f4                   	hlt
    204c:	eb fd                	jmp    204b <ahci_process_command+0x51f>
		if (rv) { /* cleanup */
    204e:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2052:	74 5c                	je     20b0 <ahci_process_command+0x584>
				abprintf("ignored malformed command on port %u\n", cc->port);
    2054:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2057:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    205b:	0f b7 c0             	movzx  eax,ax
    205e:	83 ec 08             	sub    esp,0x8
    2061:	50                   	push   eax
    2062:	68 3c 06 00 00       	push   0x63c
    2067:	e8 fc ff ff ff       	call   2068 <ahci_process_command+0x53c>
    206c:	83 c4 10             	add    esp,0x10
				if (cc->status)
    206f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2072:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2075:	85 c0                	test   eax,eax
    2077:	74 0c                	je     2085 <ahci_process_command+0x559>
						cc->status->state = cmd_state_abort;
    2079:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    207c:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    207f:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				ahci_release_cmdtbl(ad, cc->entry);
    2085:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2088:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    208b:	83 ec 08             	sub    esp,0x8
    208e:	50                   	push   eax
    208f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2092:	e8 fc ff ff ff       	call   2093 <ahci_process_command+0x567>
    2097:	83 c4 10             	add    esp,0x10
				ahci_destroy_context(ad, cc);
    209a:	83 ec 08             	sub    esp,0x8
    209d:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    20a0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    20a3:	e8 fc ff ff ff       	call   20a4 <ahci_process_command+0x578>
    20a8:	83 c4 10             	add    esp,0x10
    20ab:	e9 58 01 00 00       	jmp    2208 <ahci_process_command+0x6dc>
		} else if (!(p->pXci & (1 << slt))) {/* issue it on the port p slot slt */
    20b0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20b3:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
    20b6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    20b9:	bb 01 00 00 00       	mov    ebx,0x1
    20be:	89 c1                	mov    ecx,eax
    20c0:	d3 e3                	shl    ebx,cl
    20c2:	89 d8                	mov    eax,ebx
    20c4:	21 d0                	and    eax,edx
    20c6:	85 c0                	test   eax,eax
    20c8:	0f 85 0f 01 00 00    	jne    21dd <ahci_process_command+0x6b1>
				struct ahci_cmdhdr* ch = &ad->command_lists[cc->port]->chdrs[slt];
    20ce:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20d1:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    20d5:	0f b7 d0             	movzx  edx,ax
    20d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20db:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    20df:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    20e2:	c1 e2 05             	shl    edx,0x5
    20e5:	01 d0                	add    eax,edx
    20e7:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
				bzero(ch, sizeof(*ch));
    20ea:	83 ec 08             	sub    esp,0x8
    20ed:	6a 20                	push   0x20
    20ef:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
    20f2:	e8 fc ff ff ff       	call   20f3 <ahci_process_command+0x5c7>
    20f7:	83 c4 10             	add    esp,0x10
				ch->ctba64 = cc->entry->pmem;
    20fa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20fd:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    2100:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2103:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2106:	8b 4d b0             	mov    ecx,DWORD PTR [ebp-0x50]
    2109:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    210c:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
				ch->prdtl = cc->clh.prdtl;
    210f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2112:	0f b7 50 44          	movzx  edx,WORD PTR [eax+0x44]
    2116:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2119:	66 89 50 02          	mov    WORD PTR [eax+0x2],dx
				ch->flags = cc->clh.flg;
    211d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2120:	0f b7 50 46          	movzx  edx,WORD PTR [eax+0x46]
    2124:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2127:	66 89 10             	mov    WORD PTR [eax],dx
				if (p->cmd.st) {
    212a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    212d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2130:	83 e0 01             	and    eax,0x1
    2133:	84 c0                	test   al,al
    2135:	74 2c                	je     2163 <ahci_process_command+0x637>
						p->pXci = (1 << slt);
    2137:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    213a:	ba 01 00 00 00       	mov    edx,0x1
    213f:	89 c1                	mov    ecx,eax
    2141:	d3 e2                	shl    edx,cl
    2143:	89 d0                	mov    eax,edx
    2145:	89 c2                	mov    edx,eax
    2147:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    214a:	89 50 38             	mov    DWORD PTR [eax+0x38],edx
						if (cc->status)
    214d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2150:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2153:	85 c0                	test   eax,eax
    2155:	74 0c                	je     2163 <ahci_process_command+0x637>
								cc->status->state = cmd_state_issued;
    2157:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    215a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    215d:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
				if (!p->cmd.st) {
    2163:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2166:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2169:	83 e0 01             	and    eax,0x1
    216c:	84 c0                	test   al,al
    216e:	75 2d                	jne    219d <ahci_process_command+0x671>
						abprintf("command will be sent later\n");
    2170:	83 ec 0c             	sub    esp,0xc
    2173:	68 62 06 00 00       	push   0x662
    2178:	e8 fc ff ff ff       	call   2179 <ahci_process_command+0x64d>
    217d:	83 c4 10             	add    esp,0x10
						cc->c = host_cmd_resend;
    2180:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2183:	c7 40 0c 81 00 00 00 	mov    DWORD PTR [eax+0xc],0x81
						ahci_reissue_command(ad, cc);
    218a:	83 ec 08             	sub    esp,0x8
    218d:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2190:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2193:	e8 fc ff ff ff       	call   2194 <ahci_process_command+0x668>
    2198:	83 c4 10             	add    esp,0x10
						goto incr; /* skip putting into proc_cmds */
    219b:	eb 6b                	jmp    2208 <ahci_process_command+0x6dc>
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
    219d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21a0:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    21a4:	0f b7 d0             	movzx  edx,ax
    21a7:	89 d0                	mov    eax,edx
    21a9:	01 c0                	add    eax,eax
    21ab:	01 d0                	add    eax,edx
    21ad:	c1 e0 02             	shl    eax,0x2
    21b0:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    21b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21b9:	01 c2                	add    edx,eax
    21bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21be:	83 ec 08             	sub    esp,0x8
    21c1:	52                   	push   edx
    21c2:	50                   	push   eax
    21c3:	e8 0d df ff ff       	call   d5 <list_add_tail>
    21c8:	83 c4 10             	add    esp,0x10
				abprintf("issued the command successfully.\n");
    21cb:	83 ec 0c             	sub    esp,0xc
    21ce:	68 80 06 00 00       	push   0x680
    21d3:	e8 fc ff ff ff       	call   21d4 <ahci_process_command+0x6a8>
    21d8:	83 c4 10             	add    esp,0x10
    21db:	eb 2b                	jmp    2208 <ahci_process_command+0x6dc>
				 * inherently single threaded structure? */
				die("error posting command\n");
    21dd:	83 ec 08             	sub    esp,0x8
    21e0:	68 a2 06 00 00       	push   0x6a2
    21e5:	6a 0c                	push   0xc
    21e7:	e8 fc ff ff ff       	call   21e8 <ahci_process_command+0x6bc>
    21ec:	83 c4 10             	add    esp,0x10
    21ef:	e8 fc ff ff ff       	call   21f0 <ahci_process_command+0x6c4>
    21f4:	83 ec 0c             	sub    esp,0xc
    21f7:	68 00 00 00 00       	push   0x0
    21fc:	e8 fc ff ff ff       	call   21fd <ahci_process_command+0x6d1>
    2201:	83 c4 10             	add    esp,0x10
    2204:	fa                   	cli
    2205:	f4                   	hlt
    2206:	eb fd                	jmp    2205 <ahci_process_command+0x6d9>
		}

		/* process next command */
incr:
		__sync_fetch_and_sub(&ad->pending_ct, 1);
    2208:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    220b:	05 10 06 00 00       	add    eax,0x610
    2210:	f0 83 28 01          	lock sub DWORD PTR [eax],0x1
		if (!list_empty(lh))
    2214:	83 ec 0c             	sub    esp,0xc
    2217:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    221a:	e8 35 df ff ff       	call   154 <list_empty>
    221f:	83 c4 10             	add    esp,0x10
    2222:	85 c0                	test   eax,eax
    2224:	75 06                	jne    222c <ahci_process_command+0x700>
				goto next_cmd;
    2226:	e9 49 f9 ff ff       	jmp    1b74 <ahci_process_command+0x48>
				return;
    222b:	90                   	nop
}
    222c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    222f:	c9                   	leave
    2230:	c3                   	ret

00002231 <ahci_worker>:

void ahci_worker(void* dat)
{
    2231:	55                   	push   ebp
    2232:	89 e5                	mov    ebp,esp
    2234:	57                   	push   edi
    2235:	56                   	push   esi
    2236:	53                   	push   ebx
    2237:	83 ec 2c             	sub    esp,0x2c
		struct ahci_device* ad = dat;
    223a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    223d:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		printf("AHCI worker is running\n");
    2240:	83 ec 0c             	sub    esp,0xc
    2243:	68 b9 06 00 00       	push   0x6b9
    2248:	e8 fc ff ff ff       	call   2249 <ahci_worker+0x18>
    224d:	83 c4 10             	add    esp,0x10
		while (1) {
				uint32_t ps = ad->ptr->ports;
    2250:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2253:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2256:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2259:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    225c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    225f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2262:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2265:	d1 e8                	shr    eax,1
    2267:	83 e0 01             	and    eax,0x1
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    226a:	0f b6 c8             	movzx  ecx,al
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    226d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2270:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2273:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2276:	c1 e8 1f             	shr    eax,0x1f
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    2279:	0f b6 d0             	movzx  edx,al
    227c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    227f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2282:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2285:	51                   	push   ecx
    2286:	52                   	push   edx
    2287:	50                   	push   eax
    2288:	68 d1 06 00 00       	push   0x6d1
    228d:	e8 fc ff ff ff       	call   228e <ahci_worker+0x5d>
    2292:	83 c4 10             	add    esp,0x10
				for (int i = 0; i < 32; i++)
    2295:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    229c:	e9 09 01 00 00       	jmp    23aa <ahci_worker+0x179>
						if (ps & (1 << i)) {
    22a1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    22a4:	ba 01 00 00 00       	mov    edx,0x1
    22a9:	89 c1                	mov    ecx,eax
    22ab:	d3 e2                	shl    edx,cl
    22ad:	89 d0                	mov    eax,edx
    22af:	23 45 d8             	and    eax,DWORD PTR [ebp-0x28]
    22b2:	85 c0                	test   eax,eax
    22b4:	0f 84 ec 00 00 00    	je     23a6 <ahci_worker+0x175>
//										ad->ptr->port[i].scr0.ipm, ad->ptr[i].port[i].pXserr);
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    22ba:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22bd:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    22c0:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    22c3:	c1 e2 07             	shl    edx,0x7
    22c6:	01 d0                	add    eax,edx
    22c8:	05 34 01 00 00       	add    eax,0x134
    22cd:	8b 30                	mov    esi,DWORD PTR [eax]
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    22cf:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22d2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    22d5:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    22d8:	c1 e2 07             	shl    edx,0x7
    22db:	01 d0                	add    eax,edx
    22dd:	05 38 01 00 00       	add    eax,0x138
    22e2:	8b 00                	mov    eax,DWORD PTR [eax]
    22e4:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    22e7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22ea:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22ed:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    22f0:	c1 e2 07             	shl    edx,0x7
    22f3:	01 d0                	add    eax,edx
    22f5:	05 20 01 00 00       	add    eax,0x120
    22fa:	8b 00                	mov    eax,DWORD PTR [eax]
    22fc:	0f b6 c4             	movzx  eax,ah
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    22ff:	0f b6 d8             	movzx  ebx,al
    2302:	89 5d d0             	mov    DWORD PTR [ebp-0x30],ebx
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    2305:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2308:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    230b:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    230e:	c1 e2 07             	shl    edx,0x7
    2311:	01 d0                	add    eax,edx
    2313:	05 20 01 00 00       	add    eax,0x120
    2318:	8b 00                	mov    eax,DWORD PTR [eax]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    231a:	0f b6 f8             	movzx  edi,al
    231d:	89 7d cc             	mov    DWORD PTR [ebp-0x34],edi
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    2320:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2323:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2326:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2329:	c1 e2 07             	shl    edx,0x7
    232c:	01 d0                	add    eax,edx
    232e:	05 14 01 00 00       	add    eax,0x114
    2333:	8b 38                	mov    edi,DWORD PTR [eax]
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    2335:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2338:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    233b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    233e:	c1 e0 07             	shl    eax,0x7
    2341:	01 d0                	add    eax,edx
    2343:	05 10 01 00 00       	add    eax,0x110
    2348:	8b 18                	mov    ebx,DWORD PTR [eax]
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    234a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    234d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2350:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2353:	c1 e0 07             	shl    eax,0x7
    2356:	01 d0                	add    eax,edx
    2358:	05 10 01 00 00       	add    eax,0x110
    235d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2360:	c1 e8 0f             	shr    eax,0xf
    2363:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2366:	0f b6 c8             	movzx  ecx,al
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    2369:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    236c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    236f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2372:	c1 e0 07             	shl    eax,0x7
    2375:	01 d0                	add    eax,edx
    2377:	05 10 01 00 00       	add    eax,0x110
    237c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    237f:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2382:	0f b6 c0             	movzx  eax,al
    2385:	83 ec 08             	sub    esp,0x8
    2388:	56                   	push   esi
    2389:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    238c:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    238f:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    2392:	57                   	push   edi
    2393:	53                   	push   ebx
    2394:	51                   	push   ecx
    2395:	50                   	push   eax
    2396:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    2399:	68 e8 06 00 00       	push   0x6e8
    239e:	e8 fc ff ff ff       	call   239f <ahci_worker+0x16e>
    23a3:	83 c4 30             	add    esp,0x30
				for (int i = 0; i < 32; i++)
    23a6:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    23aa:	83 7d e4 1f          	cmp    DWORD PTR [ebp-0x1c],0x1f
    23ae:	0f 8e ed fe ff ff    	jle    22a1 <ahci_worker+0x70>
//
						}
				/* print global IS */
				void ioapic_print_is();
				int pci_print_is(union pca);
				ioapic_print_is();
    23b4:	e8 fc ff ff ff       	call   23b5 <ahci_worker+0x184>
				pci_print_is(ad->dev->addr);
    23b9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23bc:	8b 00                	mov    eax,DWORD PTR [eax]
    23be:	83 ec 0c             	sub    esp,0xc
    23c1:	ff 30                	push   DWORD PTR [eax]
    23c3:	e8 fc ff ff ff       	call   23c4 <ahci_worker+0x193>
    23c8:	83 c4 10             	add    esp,0x10
//						}
//						/* R1C */
//						ad->ptr->intr = 1;
//				}

				wait_on_event(&ad->wh);
    23cb:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23ce:	05 20 06 00 00       	add    eax,0x620
    23d3:	83 ec 0c             	sub    esp,0xc
    23d6:	50                   	push   eax
    23d7:	e8 fc ff ff ff       	call   23d8 <ahci_worker+0x1a7>
    23dc:	83 c4 10             	add    esp,0x10
				//sleep(1);

				/* there are pending commands */
				if (ad->pending_ct) {
    23df:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23e2:	8b 80 10 06 00 00    	mov    eax,DWORD PTR [eax+0x610]
    23e8:	85 c0                	test   eax,eax
    23ea:	0f 84 60 fe ff ff    	je     2250 <ahci_worker+0x1f>
						for (int i = 0; i < 32; i++) {
    23f0:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    23f7:	eb 7e                	jmp    2477 <ahci_worker+0x246>
								if (!(ps & (1 << i)))
    23f9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    23fc:	ba 01 00 00 00       	mov    edx,0x1
    2401:	89 c1                	mov    ecx,eax
    2403:	d3 e2                	shl    edx,cl
    2405:	89 d0                	mov    eax,edx
    2407:	23 45 d8             	and    eax,DWORD PTR [ebp-0x28]
    240a:	85 c0                	test   eax,eax
    240c:	74 61                	je     246f <ahci_worker+0x23e>
										continue;
								if (list_empty(&ad->pending_cmds[i]))
    240e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2411:	89 d0                	mov    eax,edx
    2413:	01 c0                	add    eax,eax
    2415:	01 d0                	add    eax,edx
    2417:	c1 e0 02             	shl    eax,0x2
    241a:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    2420:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2423:	01 d0                	add    eax,edx
    2425:	83 ec 0c             	sub    esp,0xc
    2428:	50                   	push   eax
    2429:	e8 26 dd ff ff       	call   154 <list_empty>
    242e:	83 c4 10             	add    esp,0x10
    2431:	85 c0                	test   eax,eax
    2433:	75 3d                	jne    2472 <ahci_worker+0x241>
										continue;
								/* we have commands to process */
								ahci_process_command(ad, &ad->ptr->port[i],
    2435:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2438:	89 d0                	mov    eax,edx
    243a:	01 c0                	add    eax,eax
    243c:	01 d0                	add    eax,edx
    243e:	c1 e0 02             	shl    eax,0x2
    2441:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    2447:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    244a:	01 c2                	add    edx,eax
    244c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    244f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2452:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    2455:	83 c1 02             	add    ecx,0x2
    2458:	c1 e1 07             	shl    ecx,0x7
    245b:	01 c8                	add    eax,ecx
    245d:	83 ec 04             	sub    esp,0x4
    2460:	52                   	push   edx
    2461:	50                   	push   eax
    2462:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    2465:	e8 fc ff ff ff       	call   2466 <ahci_worker+0x235>
    246a:	83 c4 10             	add    esp,0x10
    246d:	eb 04                	jmp    2473 <ahci_worker+0x242>
										continue;
    246f:	90                   	nop
    2470:	eb 01                	jmp    2473 <ahci_worker+0x242>
										continue;
    2472:	90                   	nop
						for (int i = 0; i < 32; i++) {
    2473:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    2477:	83 7d e0 1f          	cmp    DWORD PTR [ebp-0x20],0x1f
    247b:	0f 8e 78 ff ff ff    	jle    23f9 <ahci_worker+0x1c8>
		while (1) {
    2481:	e9 ca fd ff ff       	jmp    2250 <ahci_worker+0x1f>

00002486 <ahci_allocate_command_table_pool>:
				}
		}
}

void* ahci_allocate_command_table_pool(uint32_t ct, uint32_t prdt_cap, int bit64)
{
    2486:	55                   	push   ebp
    2487:	89 e5                	mov    ebp,esp
    2489:	53                   	push   ebx
    248a:	83 ec 44             	sub    esp,0x44
		/* 128bt aligned size (8 PRDT/128 bt) */
		struct ahci_ct_pool* rv; uint32_t i = 0;
    248d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		size_t byte_ct, page_rest, indiv_ct, pg_pe, pg_ct, epa;
		struct page_range pr; int flg = MMGR_ALLOC_CONTIGUOUS;
    2494:	c7 45 e4 00 00 03 00 	mov    DWORD PTR [ebp-0x1c],0x30000
		if (!bit64)
    249b:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    249f:	75 07                	jne    24a8 <ahci_allocate_command_table_pool+0x22>
				flg = MMGR_ALLOC_32BIT;
    24a1:	c7 45 e4 00 00 04 00 	mov    DWORD PTR [ebp-0x1c],0x40000
		if (!(rv = kzalloc(sizeof(*rv))))
    24a8:	83 ec 0c             	sub    esp,0xc
    24ab:	68 0c 02 00 00       	push   0x20c
    24b0:	e8 fc ff ff ff       	call   24b1 <ahci_allocate_command_table_pool+0x2b>
    24b5:	83 c4 10             	add    esp,0x10
    24b8:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    24bb:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    24bf:	75 0a                	jne    24cb <ahci_allocate_command_table_pool+0x45>
				return NULL;
    24c1:	b8 00 00 00 00       	mov    eax,0x0
    24c6:	e9 c3 02 00 00       	jmp    278e <ahci_allocate_command_table_pool+0x308>
	   
		/* bitmask limit */
		if (ct > 32)
    24cb:	83 7d 08 20          	cmp    DWORD PTR [ebp+0x8],0x20
    24cf:	76 07                	jbe    24d8 <ahci_allocate_command_table_pool+0x52>
				ct = 32;
    24d1:	c7 45 08 20 00 00 00 	mov    DWORD PTR [ebp+0x8],0x20
		/* enforce alignment */
		if (prdt_cap % 8)
    24d8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    24db:	83 e0 07             	and    eax,0x7
    24de:	85 c0                	test   eax,eax
    24e0:	74 0c                	je     24ee <ahci_allocate_command_table_pool+0x68>
				prdt_cap += 8 - prdt_cap % 8;
    24e2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    24e5:	83 e0 f8             	and    eax,0xfffffff8
    24e8:	83 c0 08             	add    eax,0x8
    24eb:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		indiv_ct = 128 + 16 * prdt_cap;
    24ee:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    24f1:	83 c0 08             	add    eax,0x8
    24f4:	c1 e0 04             	shl    eax,0x4
    24f7:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		byte_ct = ct * indiv_ct;
    24fa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    24fd:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
    2501:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		pg_pe = rdiv(indiv_ct, 4096);
    2504:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2507:	c1 e8 0c             	shr    eax,0xc
    250a:	89 c2                	mov    edx,eax
    250c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    250f:	25 ff 0f 00 00       	and    eax,0xfff
    2514:	85 c0                	test   eax,eax
    2516:	74 07                	je     251f <ahci_allocate_command_table_pool+0x99>
    2518:	b8 01 00 00 00       	mov    eax,0x1
    251d:	eb 05                	jmp    2524 <ahci_allocate_command_table_pool+0x9e>
    251f:	b8 00 00 00 00       	mov    eax,0x0
    2524:	01 d0                	add    eax,edx
    2526:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		page_rest = pg_pe * 4096 - indiv_ct;
    2529:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    252c:	c1 e0 0c             	shl    eax,0xc
    252f:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    2532:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax

		/* pg_pe allocs must be contiguous, but if page_rest is low
		 * individual tables can be split up to different locations */
		if (!page_rest || (page_rest % indiv_ct == 0)) {
    2535:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    2539:	74 11                	je     254c <ahci_allocate_command_table_pool+0xc6>
    253b:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    253e:	ba 00 00 00 00       	mov    edx,0x0
    2543:	f7 75 d0             	div    DWORD PTR [ebp-0x30]
    2546:	89 d0                	mov    eax,edx
    2548:	85 c0                	test   eax,eax
    254a:	75 49                	jne    2595 <ahci_allocate_command_table_pool+0x10f>
				epa = pg_pe * 4096 / indiv_ct; /* entries per allocation */
    254c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    254f:	c1 e0 0c             	shl    eax,0xc
    2552:	ba 00 00 00 00       	mov    edx,0x0
    2557:	f7 75 d0             	div    DWORD PTR [ebp-0x30]
    255a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				pg_ct = rdiv(ct, epa) * pg_pe;
    255d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2560:	ba 00 00 00 00       	mov    edx,0x0
    2565:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
    2568:	89 c1                	mov    ecx,eax
    256a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    256d:	ba 00 00 00 00       	mov    edx,0x0
    2572:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
    2575:	89 d0                	mov    eax,edx
    2577:	85 c0                	test   eax,eax
    2579:	74 07                	je     2582 <ahci_allocate_command_table_pool+0xfc>
    257b:	b8 01 00 00 00       	mov    eax,0x1
    2580:	eb 05                	jmp    2587 <ahci_allocate_command_table_pool+0x101>
    2582:	b8 00 00 00 00       	mov    eax,0x0
    2587:	8d 14 08             	lea    edx,[eax+ecx*1]
    258a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    258d:	0f af c2             	imul   eax,edx
    2590:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2593:	eb 31                	jmp    25c6 <ahci_allocate_command_table_pool+0x140>
		} else {
				pg_ct = rdiv(byte_ct, 4096);
    2595:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2598:	c1 e8 0c             	shr    eax,0xc
    259b:	89 c2                	mov    edx,eax
    259d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    25a0:	25 ff 0f 00 00       	and    eax,0xfff
    25a5:	85 c0                	test   eax,eax
    25a7:	74 07                	je     25b0 <ahci_allocate_command_table_pool+0x12a>
    25a9:	b8 01 00 00 00       	mov    eax,0x1
    25ae:	eb 05                	jmp    25b5 <ahci_allocate_command_table_pool+0x12f>
    25b0:	b8 00 00 00 00       	mov    eax,0x0
    25b5:	01 d0                	add    eax,edx
    25b7:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				epa = ct;
    25ba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25bd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				pg_pe = pg_ct;
    25c0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    25c3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		}

		/* allocate the physical memory */
		while (pg_ct) {
    25c6:	e9 4c 01 00 00       	jmp    2717 <ahci_allocate_command_table_pool+0x291>
				void* ptr; size_t epa2 = epa, rem;
    25cb:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    25ce:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				mm_alloc_pm_flg(pg_pe, &pr, 1, flg);
    25d1:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    25d4:	6a 01                	push   0x1
    25d6:	8d 45 bc             	lea    eax,[ebp-0x44]
    25d9:	50                   	push   eax
    25da:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    25dd:	e8 fc ff ff ff       	call   25de <ahci_allocate_command_table_pool+0x158>
    25e2:	83 c4 10             	add    esp,0x10
				if (pr.count != pg_pe)
    25e5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    25e8:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    25eb:	74 2b                	je     2618 <ahci_allocate_command_table_pool+0x192>
						die("Out of contiguous memory\n");
    25ed:	83 ec 08             	sub    esp,0x8
    25f0:	68 27 07 00 00       	push   0x727
    25f5:	6a 0c                	push   0xc
    25f7:	e8 fc ff ff ff       	call   25f8 <ahci_allocate_command_table_pool+0x172>
    25fc:	83 c4 10             	add    esp,0x10
    25ff:	e8 fc ff ff ff       	call   2600 <ahci_allocate_command_table_pool+0x17a>
    2604:	83 ec 0c             	sub    esp,0xc
    2607:	68 00 00 00 00       	push   0x0
    260c:	e8 fc ff ff ff       	call   260d <ahci_allocate_command_table_pool+0x187>
    2611:	83 c4 10             	add    esp,0x10
    2614:	fa                   	cli
    2615:	f4                   	hlt
    2616:	eb fd                	jmp    2615 <ahci_allocate_command_table_pool+0x18f>
				rem = pg_pe * 4096;
    2618:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    261b:	c1 e0 0c             	shl    eax,0xc
    261e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				/* pg_pe zeroed contiguous memory at pr.base */
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL |
    2621:	83 ec 0c             	sub    esp,0xc
    2624:	6a 2c                	push   0x2c
    2626:	6a 01                	push   0x1
    2628:	8d 45 bc             	lea    eax,[ebp-0x44]
    262b:	50                   	push   eax
    262c:	6a 00                	push   0x0
    262e:	68 00 00 00 00       	push   0x0
    2633:	e8 fc ff ff ff       	call   2634 <ahci_allocate_command_table_pool+0x1ae>
    2638:	83 c4 20             	add    esp,0x20
    263b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						MMGR_MAP_WRITE | MMGR_MAP_NO_CACHING);
				if (!ptr)
    263e:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    2642:	0f 85 b8 00 00 00    	jne    2700 <ahci_allocate_command_table_pool+0x27a>
						die("mmap not working\n");
    2648:	83 ec 08             	sub    esp,0x8
    264b:	68 41 07 00 00       	push   0x741
    2650:	6a 0c                	push   0xc
    2652:	e8 fc ff ff ff       	call   2653 <ahci_allocate_command_table_pool+0x1cd>
    2657:	83 c4 10             	add    esp,0x10
    265a:	e8 fc ff ff ff       	call   265b <ahci_allocate_command_table_pool+0x1d5>
    265f:	83 ec 0c             	sub    esp,0xc
    2662:	68 00 00 00 00       	push   0x0
    2667:	e8 fc ff ff ff       	call   2668 <ahci_allocate_command_table_pool+0x1e2>
    266c:	83 c4 10             	add    esp,0x10
    266f:	fa                   	cli
    2670:	f4                   	hlt
    2671:	eb fd                	jmp    2670 <ahci_allocate_command_table_pool+0x1ea>

				/* assign the entries */
				while (epa2--) {
						rv->tables[i].pmem = pr.base;
    2673:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2676:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    2679:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    267c:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    267f:	c1 e3 04             	shl    ebx,0x4
    2682:	01 d9                	add    ecx,ebx
    2684:	89 41 14             	mov    DWORD PTR [ecx+0x14],eax
    2687:	89 51 18             	mov    DWORD PTR [ecx+0x18],edx
						rv->tables[i++].ptr = ptr;
    268a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    268d:	8d 50 01             	lea    edx,[eax+0x1]
    2690:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2693:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2696:	c1 e0 04             	shl    eax,0x4
    2699:	01 d0                	add    eax,edx
    269b:	8d 50 10             	lea    edx,[eax+0x10]
    269e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    26a1:	89 02                	mov    DWORD PTR [edx],eax
						/* advance */
						pr.base += indiv_ct;
    26a3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    26a6:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    26a9:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    26ac:	bb 00 00 00 00       	mov    ebx,0x0
    26b1:	01 c8                	add    eax,ecx
    26b3:	11 da                	adc    edx,ebx
    26b5:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    26b8:	89 55 c0             	mov    DWORD PTR [ebp-0x40],edx
						ptr += indiv_ct;
    26bb:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    26be:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
						rem -= indiv_ct;
    26c1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    26c4:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
						if (rem < indiv_ct && epa2 > 1)
    26c7:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26ca:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    26cd:	73 31                	jae    2700 <ahci_allocate_command_table_pool+0x27a>
    26cf:	83 7d dc 01          	cmp    DWORD PTR [ebp-0x24],0x1
    26d3:	76 2b                	jbe    2700 <ahci_allocate_command_table_pool+0x27a>
								die("algo error\n");
    26d5:	83 ec 08             	sub    esp,0x8
    26d8:	68 53 07 00 00       	push   0x753
    26dd:	6a 0c                	push   0xc
    26df:	e8 fc ff ff ff       	call   26e0 <ahci_allocate_command_table_pool+0x25a>
    26e4:	83 c4 10             	add    esp,0x10
    26e7:	e8 fc ff ff ff       	call   26e8 <ahci_allocate_command_table_pool+0x262>
    26ec:	83 ec 0c             	sub    esp,0xc
    26ef:	68 00 00 00 00       	push   0x0
    26f4:	e8 fc ff ff ff       	call   26f5 <ahci_allocate_command_table_pool+0x26f>
    26f9:	83 c4 10             	add    esp,0x10
    26fc:	fa                   	cli
    26fd:	f4                   	hlt
    26fe:	eb fd                	jmp    26fd <ahci_allocate_command_table_pool+0x277>
				while (epa2--) {
    2700:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2703:	8d 50 ff             	lea    edx,[eax-0x1]
    2706:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    2709:	85 c0                	test   eax,eax
    270b:	0f 85 62 ff ff ff    	jne    2673 <ahci_allocate_command_table_pool+0x1ed>
				}
				pg_ct -= pg_pe;
    2711:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2714:	29 45 ec             	sub    DWORD PTR [ebp-0x14],eax
		while (pg_ct) {
    2717:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    271b:	0f 85 aa fe ff ff    	jne    25cb <ahci_allocate_command_table_pool+0x145>
		}

		/* assign the other values */
		rv->prdt_cap = prdt_cap;
    2721:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2724:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2727:	89 10                	mov    DWORD PTR [eax],edx
		rv->next = NULL;
    2729:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    272c:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
		rv->mask = 0xffffffff << prdt_cap;
    2733:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2736:	ba ff ff ff ff       	mov    edx,0xffffffff
    273b:	89 c1                	mov    ecx,eax
    273d:	d3 e2                	shl    edx,cl
    273f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2742:	89 50 08             	mov    DWORD PTR [eax+0x8],edx

		/* print it */
		for (i = 0; i < ct; i++)
    2745:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    274c:	eb 35                	jmp    2783 <ahci_allocate_command_table_pool+0x2fd>
				printf("%016llx %p\n", rv->tables[i].pmem, rv->tables[i].ptr);
    274e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2751:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2754:	c1 e2 04             	shl    edx,0x4
    2757:	01 d0                	add    eax,edx
    2759:	83 c0 10             	add    eax,0x10
    275c:	8b 08                	mov    ecx,DWORD PTR [eax]
    275e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2761:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2764:	c1 e2 04             	shl    edx,0x4
    2767:	01 d0                	add    eax,edx
    2769:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    276c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    276f:	51                   	push   ecx
    2770:	52                   	push   edx
    2771:	50                   	push   eax
    2772:	68 5f 07 00 00       	push   0x75f
    2777:	e8 fc ff ff ff       	call   2778 <ahci_allocate_command_table_pool+0x2f2>
    277c:	83 c4 10             	add    esp,0x10
		for (i = 0; i < ct; i++)
    277f:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2783:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2786:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    2789:	72 c3                	jb     274e <ahci_allocate_command_table_pool+0x2c8>

		return rv;
    278b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
}
    278e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2791:	c9                   	leave
    2792:	c3                   	ret

00002793 <ahci_reissue_command>:

void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc)
{
    2793:	55                   	push   ebp
    2794:	89 e5                	mov    ebp,esp
    2796:	56                   	push   esi
    2797:	53                   	push   ebx
		iprintf("  REISSUE: %d %u\n", cc->port, cc->c);
    2798:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    279b:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    279e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27a1:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    27a5:	0f b7 c0             	movzx  eax,ax
    27a8:	83 ec 04             	sub    esp,0x4
    27ab:	52                   	push   edx
    27ac:	50                   	push   eax
    27ad:	68 6b 07 00 00       	push   0x76b
    27b2:	e8 fc ff ff ff       	call   27b3 <ahci_reissue_command+0x20>
    27b7:	83 c4 10             	add    esp,0x10
		if (cc->status)
    27ba:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27bd:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    27c0:	85 c0                	test   eax,eax
    27c2:	74 0c                	je     27d0 <ahci_reissue_command+0x3d>
				cc->status->state = cmd_state_pending;
    27c4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27c7:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    27ca:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
						ad->pending_cmds[cc->port].next, cc->port);
    27d0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27d3:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    27d7:	0f b7 d8             	movzx  ebx,ax
						ad->pending_cmds[cc->port].next, cc->port);
    27da:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27dd:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    27e1:	0f b7 d0             	movzx  edx,ax
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    27e4:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    27e7:	89 d0                	mov    eax,edx
    27e9:	01 c0                	add    eax,eax
    27eb:	01 d0                	add    eax,edx
    27ed:	c1 e0 02             	shl    eax,0x2
    27f0:	01 c8                	add    eax,ecx
    27f2:	05 14 03 00 00       	add    eax,0x314
    27f7:	8b 08                	mov    ecx,DWORD PTR [eax]
    27f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27fc:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2800:	0f b7 d0             	movzx  edx,ax
    2803:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    2806:	89 d0                	mov    eax,edx
    2808:	01 c0                	add    eax,eax
    280a:	01 d0                	add    eax,edx
    280c:	c1 e0 02             	shl    eax,0x2
    280f:	01 f0                	add    eax,esi
    2811:	05 10 03 00 00       	add    eax,0x310
    2816:	8b 00                	mov    eax,DWORD PTR [eax]
    2818:	53                   	push   ebx
    2819:	51                   	push   ecx
    281a:	50                   	push   eax
    281b:	68 7d 07 00 00       	push   0x77d
    2820:	e8 fc ff ff ff       	call   2821 <ahci_reissue_command+0x8e>
    2825:	83 c4 10             	add    esp,0x10
		list_add_tail(&cc->lst, &ad->pending_cmds[cc->port]);
    2828:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    282b:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    282f:	0f b7 d0             	movzx  edx,ax
    2832:	89 d0                	mov    eax,edx
    2834:	01 c0                	add    eax,eax
    2836:	01 d0                	add    eax,edx
    2838:	c1 e0 02             	shl    eax,0x2
    283b:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    2841:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2844:	01 c2                	add    edx,eax
    2846:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2849:	83 ec 08             	sub    esp,0x8
    284c:	52                   	push   edx
    284d:	50                   	push   eax
    284e:	e8 82 d8 ff ff       	call   d5 <list_add_tail>
    2853:	83 c4 10             	add    esp,0x10
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    2856:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2859:	05 10 06 00 00       	add    eax,0x610
    285e:	ba 01 00 00 00       	mov    edx,0x1
    2863:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    2867:	85 d2                	test   edx,edx
    2869:	75 14                	jne    287f <ahci_reissue_command+0xec>
				/* wake worker */
				wake_up_external_event(&ad->wh);
    286b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    286e:	05 20 06 00 00       	add    eax,0x620
    2873:	83 ec 0c             	sub    esp,0xc
    2876:	50                   	push   eax
    2877:	e8 fc ff ff ff       	call   2878 <ahci_reissue_command+0xe5>
    287c:	83 c4 10             	add    esp,0x10
		}
}
    287f:	90                   	nop
    2880:	8d 65 f8             	lea    esp,[ebp-0x8]
    2883:	5b                   	pop    ebx
    2884:	5e                   	pop    esi
    2885:	5d                   	pop    ebp
    2886:	c3                   	ret

00002887 <ahci_issue_command>:

void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st)
{
    2887:	55                   	push   ebp
    2888:	89 e5                	mov    ebp,esp
    288a:	83 ec 28             	sub    esp,0x28
    288d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    2890:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    2893:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    2896:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    2899:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    289c:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    289f:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    28a2:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		iprintf("  ISSUE: %d %u\n", port, cmd);
    28a5:	83 ec 04             	sub    esp,0x4
    28a8:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    28ab:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    28ae:	68 8b 07 00 00       	push   0x78b
    28b3:	e8 fc ff ff ff       	call   28b4 <ahci_issue_command+0x2d>
    28b8:	83 c4 10             	add    esp,0x10
		struct cmd_ctx* cc = ahci_allocate_context(ad);
    28bb:	83 ec 0c             	sub    esp,0xc
    28be:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    28c1:	e8 fc ff ff ff       	call   28c2 <ahci_issue_command+0x3b>
    28c6:	83 c4 10             	add    esp,0x10
    28c9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		cc->c = cmd;
    28cc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    28cf:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    28d2:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		cc->lba = lba;
    28d5:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    28d8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    28db:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    28de:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
    28e1:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
		cc->ct = ct;
    28e4:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    28e7:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    28ea:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    28ed:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    28f0:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
		cc->ptr = ptr;
    28f3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    28f6:	8b 55 28             	mov    edx,DWORD PTR [ebp+0x28]
    28f9:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
		cc->wq_wake = wq_h;
    28fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    28ff:	8b 55 2c             	mov    edx,DWORD PTR [ebp+0x2c]
    2902:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
		cc->pmprt = pmprt;
    2905:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2908:	89 c2                	mov    edx,eax
    290a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    290d:	66 89 50 24          	mov    WORD PTR [eax+0x24],dx
		cc->port = port;
    2911:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2914:	89 c2                	mov    edx,eax
    2916:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2919:	66 89 50 30          	mov    WORD PTR [eax+0x30],dx
		cc->status = st;
    291d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2920:	8b 55 30             	mov    edx,DWORD PTR [ebp+0x30]
    2923:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
		if (st) {
    2926:	83 7d 30 00          	cmp    DWORD PTR [ebp+0x30],0x0
    292a:	74 19                	je     2945 <ahci_issue_command+0xbe>
				bzero(st, sizeof(*st));
    292c:	83 ec 08             	sub    esp,0x8
    292f:	6a 18                	push   0x18
    2931:	ff 75 30             	push   DWORD PTR [ebp+0x30]
    2934:	e8 fc ff ff ff       	call   2935 <ahci_issue_command+0xae>
    2939:	83 c4 10             	add    esp,0x10
				st->state = cmd_state_pending;
    293c:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
    293f:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		}
		list_add_tail(&cc->lst, &ad->pending_cmds[port]);
    2945:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2948:	89 d0                	mov    eax,edx
    294a:	01 c0                	add    eax,eax
    294c:	01 d0                	add    eax,edx
    294e:	c1 e0 02             	shl    eax,0x2
    2951:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    2957:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    295a:	01 c2                	add    edx,eax
    295c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    295f:	83 ec 08             	sub    esp,0x8
    2962:	52                   	push   edx
    2963:	50                   	push   eax
    2964:	e8 6c d7 ff ff       	call   d5 <list_add_tail>
    2969:	83 c4 10             	add    esp,0x10
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    296c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    296f:	05 10 06 00 00       	add    eax,0x610
    2974:	ba 01 00 00 00       	mov    edx,0x1
    2979:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    297d:	85 d2                	test   edx,edx
    297f:	75 14                	jne    2995 <ahci_issue_command+0x10e>
				/*  wake worker */
				wake_up_external_event(&ad->wh);
    2981:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2984:	05 20 06 00 00       	add    eax,0x620
    2989:	83 ec 0c             	sub    esp,0xc
    298c:	50                   	push   eax
    298d:	e8 fc ff ff ff       	call   298e <ahci_issue_command+0x107>
    2992:	83 c4 10             	add    esp,0x10
		}
}
    2995:	90                   	nop
    2996:	c9                   	leave
    2997:	c3                   	ret

00002998 <ahci_do_bohc>:

int ahci_do_bohc(struct ahci_device* ad)
{
    2998:	55                   	push   ebp
    2999:	89 e5                	mov    ebp,esp
    299b:	83 ec 18             	sub    esp,0x18
		struct ahci_hba* hba = ad->ptr;
    299e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    29a1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    29a4:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (hba->cap2.boh) {
    29a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29aa:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    29ad:	83 e0 01             	and    eax,0x1
    29b0:	84 c0                	test   al,al
    29b2:	0f 84 aa 00 00 00    	je     2a62 <ahci_do_bohc+0xca>
				abprintf("performing AHCI BIOS handover...\n");
    29b8:	83 ec 0c             	sub    esp,0xc
    29bb:	68 9c 07 00 00       	push   0x79c
    29c0:	e8 fc ff ff ff       	call   29c1 <ahci_do_bohc+0x29>
    29c5:	83 c4 10             	add    esp,0x10
				preempt_disable();
    29c8:	e8 fc ff ff ff       	call   29c9 <ahci_do_bohc+0x31>
    29cd:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    29d0:	83 c2 01             	add    edx,0x1
    29d3:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				hba->bohc |= BOHC_OOS;
    29d6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29d9:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    29dc:	83 c8 02             	or     eax,0x2
    29df:	89 c2                	mov    edx,eax
    29e1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29e4:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
				/* SMI is issued */
				if (hba->bohc & BOHC_BOS) { /* we have to wait */
    29e7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29ea:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    29ed:	83 e0 01             	and    eax,0x1
    29f0:	85 c0                	test   eax,eax
    29f2:	74 4d                	je     2a41 <ahci_do_bohc+0xa9>
						mdelay(25);
    29f4:	83 ec 0c             	sub    esp,0xc
    29f7:	6a 19                	push   0x19
    29f9:	e8 fc ff ff ff       	call   29fa <ahci_do_bohc+0x62>
    29fe:	83 c4 10             	add    esp,0x10
						if (hba->bohc & BOHC_BB) { /* BIOS does it */
    2a01:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2a04:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2a07:	83 e0 10             	and    eax,0x10
    2a0a:	85 c0                	test   eax,eax
    2a0c:	74 33                	je     2a41 <ahci_do_bohc+0xa9>
								int to = 30;
    2a0e:	c7 45 f4 1e 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1e
								while (hba->bohc & BOHC_BOS) {
    2a15:	eb 1a                	jmp    2a31 <ahci_do_bohc+0x99>
										mdelay(100);
    2a17:	83 ec 0c             	sub    esp,0xc
    2a1a:	6a 64                	push   0x64
    2a1c:	e8 fc ff ff ff       	call   2a1d <ahci_do_bohc+0x85>
    2a21:	83 c4 10             	add    esp,0x10
										if (!to--) /* abort after 3 seconds */
    2a24:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a27:	8d 50 ff             	lea    edx,[eax-0x1]
    2a2a:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2a2d:	85 c0                	test   eax,eax
    2a2f:	74 0f                	je     2a40 <ahci_do_bohc+0xa8>
								while (hba->bohc & BOHC_BOS) {
    2a31:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2a34:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2a37:	83 e0 01             	and    eax,0x1
    2a3a:	85 c0                	test   eax,eax
    2a3c:	75 d9                	jne    2a17 <ahci_do_bohc+0x7f>
    2a3e:	eb 01                	jmp    2a41 <ahci_do_bohc+0xa9>
												break;
    2a40:	90                   	nop
								}
						} else {;} /* we have to clean up */
				}
				/* we're done */
				preempt_enable();
    2a41:	e8 fc ff ff ff       	call   2a42 <ahci_do_bohc+0xaa>
    2a46:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2a49:	83 ea 01             	sub    edx,0x1
    2a4c:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    2a4f:	e8 fc ff ff ff       	call   2a50 <ahci_do_bohc+0xb8>
    2a54:	8b 00                	mov    eax,DWORD PTR [eax]
    2a56:	83 e0 01             	and    eax,0x1
    2a59:	85 c0                	test   eax,eax
    2a5b:	74 05                	je     2a62 <ahci_do_bohc+0xca>
    2a5d:	e8 fc ff ff ff       	call   2a5e <ahci_do_bohc+0xc6>
		}
		/* always acquire (we're only nice to inform the bios) */
		return 0;
    2a62:	b8 00 00 00 00       	mov    eax,0x0
}
    2a67:	c9                   	leave
    2a68:	c3                   	ret

00002a69 <ahci_reset_port>:

void ahci_reset_port(struct ahci_hba* h, struct ahci_port* p)
{
    2a69:	55                   	push   ebp
    2a6a:	89 e5                	mov    ebp,esp
    2a6c:	83 ec 08             	sub    esp,0x8
		/* cap.sclo? */
		die("not impl %p %p\n", h, p);
    2a6f:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2a72:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2a75:	68 be 07 00 00       	push   0x7be
    2a7a:	6a 0c                	push   0xc
    2a7c:	e8 fc ff ff ff       	call   2a7d <ahci_reset_port+0x14>
    2a81:	83 c4 10             	add    esp,0x10
    2a84:	e8 fc ff ff ff       	call   2a85 <ahci_reset_port+0x1c>
    2a89:	83 ec 0c             	sub    esp,0xc
    2a8c:	68 00 00 00 00       	push   0x0
    2a91:	e8 fc ff ff ff       	call   2a92 <ahci_reset_port+0x29>
    2a96:	83 c4 10             	add    esp,0x10
    2a99:	fa                   	cli
    2a9a:	f4                   	hlt
    2a9b:	eb fd                	jmp    2a9a <ahci_reset_port+0x31>

00002a9d <ahci_port_activate_device>:
}

void ahci_port_activate_device(struct ahci_hba* h, struct ahci_port* p)
{
    2a9d:	55                   	push   ebp
    2a9e:	89 e5                	mov    ebp,esp
    2aa0:	56                   	push   esi
    2aa1:	53                   	push   ebx
    2aa2:	83 ec 10             	sub    esp,0x10
		abprintf("activate port %zd:\n", p - h->port);
    2aa5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2aa8:	05 00 01 00 00       	add    eax,0x100
    2aad:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2ab0:	29 c2                	sub    edx,eax
    2ab2:	89 d0                	mov    eax,edx
    2ab4:	c1 f8 07             	sar    eax,0x7
    2ab7:	83 ec 08             	sub    esp,0x8
    2aba:	50                   	push   eax
    2abb:	68 ce 07 00 00       	push   0x7ce
    2ac0:	e8 fc ff ff ff       	call   2ac1 <ahci_port_activate_device+0x24>
    2ac5:	83 c4 10             	add    esp,0x10
		/* first check the presence flag */
		if (p->scr0.det == DET_NOT_PRESENT) {
    2ac8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2acb:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2ace:	83 e0 0f             	and    eax,0xf
    2ad1:	84 c0                	test   al,al
    2ad3:	0f 85 04 02 00 00    	jne    2cdd <ahci_port_activate_device+0x240>
				abprintf("activate: DET_NOT_PRESENT\n");
    2ad9:	83 ec 0c             	sub    esp,0xc
    2adc:	68 e2 07 00 00       	push   0x7e2
    2ae1:	e8 fc ff ff ff       	call   2ae2 <ahci_port_activate_device+0x45>
    2ae6:	83 c4 10             	add    esp,0x10
				/* nothing attached? */
				if (p->cmd.cpd) { /* we rely on CPD */
    2ae9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2aec:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2aef:	c1 e8 14             	shr    eax,0x14
    2af2:	83 e0 01             	and    eax,0x1
    2af5:	84 c0                	test   al,al
    2af7:	74 5f                	je     2b58 <ahci_port_activate_device+0xbb>
						if (!p->cmd.cps) {
    2af9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2afc:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2aff:	c1 e8 10             	shr    eax,0x10
    2b02:	83 e0 01             	and    eax,0x1
    2b05:	84 c0                	test   al,al
    2b07:	75 15                	jne    2b1e <ahci_port_activate_device+0x81>
								abprintf("confirmed by CPD\n");
    2b09:	83 ec 0c             	sub    esp,0xc
    2b0c:	68 fd 07 00 00       	push   0x7fd
    2b11:	e8 fc ff ff ff       	call   2b12 <ahci_port_activate_device+0x75>
    2b16:	83 c4 10             	add    esp,0x10
								return;
    2b19:	e9 93 03 00 00       	jmp    2eb1 <ahci_port_activate_device+0x414>
						}
						/* there's something */
						if (!p->cmd.pod) {
    2b1e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b21:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2b24:	c1 e8 02             	shr    eax,0x2
    2b27:	83 e0 01             	and    eax,0x1
    2b2a:	84 c0                	test   al,al
    2b2c:	75 19                	jne    2b47 <ahci_port_activate_device+0xaa>
								p->cmd.pod = 1; /* power it */
    2b2e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2b31:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2b34:	83 c8 04             	or     eax,0x4
    2b37:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
								ndelay(20);
    2b3a:	83 ec 0c             	sub    esp,0xc
    2b3d:	6a 14                	push   0x14
    2b3f:	e8 fc ff ff ff       	call   2b40 <ahci_port_activate_device+0xa3>
    2b44:	83 c4 10             	add    esp,0x10
						}
						if (p->scr0.det != DET_NOT_PRESENT)
    2b47:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b4a:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2b4d:	83 e0 0f             	and    eax,0xf
    2b50:	84 c0                	test   al,al
    2b52:	0f 85 88 01 00 00    	jne    2ce0 <ahci_port_activate_device+0x243>
								goto next_step;
				}
				/* spin-up? */
				if (!p->cmd.sud) { /* always !1 if cap.sss == 0 */
    2b58:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b5b:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2b5e:	d1 e8                	shr    eax,1
    2b60:	83 e0 01             	and    eax,0x1
    2b63:	84 c0                	test   al,al
    2b65:	0f 85 f3 00 00 00    	jne    2c5e <ahci_port_activate_device+0x1c1>
						abprintf("not spun-up yet?\n");
    2b6b:	83 ec 0c             	sub    esp,0xc
    2b6e:	68 0f 08 00 00       	push   0x80f
    2b73:	e8 fc ff ff ff       	call   2b74 <ahci_port_activate_device+0xd7>
    2b78:	83 c4 10             	add    esp,0x10
						if (p->pXserr & (1 << 26)) /* eXchange bit */
    2b7b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b7e:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2b81:	25 00 00 00 04       	and    eax,0x4000000
    2b86:	85 c0                	test   eax,eax
    2b88:	74 13                	je     2b9d <ahci_port_activate_device+0x100>
								p->pXserr |= (1 << 26); /* RWC */
    2b8a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b8d:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2b90:	0d 00 00 00 04       	or     eax,0x4000000
    2b95:	89 c2                	mov    edx,eax
    2b97:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b9a:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
						if (p->scr2.det != 0) { /* set to 0 prior sud */
    2b9d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ba0:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2ba3:	c1 e8 1c             	shr    eax,0x1c
    2ba6:	84 c0                	test   al,al
    2ba8:	74 1b                	je     2bc5 <ahci_port_activate_device+0x128>
								p->scr2.det = 0;
    2baa:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2bad:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2bb0:	25 ff ff ff 0f       	and    eax,0xfffffff
    2bb5:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
								ndelay(20);
    2bb8:	83 ec 0c             	sub    esp,0xc
    2bbb:	6a 14                	push   0x14
    2bbd:	e8 fc ff ff ff       	call   2bbe <ahci_port_activate_device+0x121>
    2bc2:	83 c4 10             	add    esp,0x10
						}
						p->cmd.sud = 1;
    2bc5:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2bc8:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2bcb:	83 c8 02             	or     eax,0x2
    2bce:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						udelay(50); /* wait 50 mus */
    2bd1:	83 ec 0c             	sub    esp,0xc
    2bd4:	6a 32                	push   0x32
    2bd6:	e8 fc ff ff ff       	call   2bd7 <ahci_port_activate_device+0x13a>
    2bdb:	83 c4 10             	add    esp,0x10
						if (p->pXserr & ((1 << 26) | (1 << 18))) { /* received sth. */
    2bde:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2be1:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2be4:	25 00 00 04 04       	and    eax,0x4040000
    2be9:	85 c0                	test   eax,eax
    2beb:	0f 85 f2 00 00 00    	jne    2ce3 <ahci_port_activate_device+0x246>
								/* COMRESET, COMWAKE */
								goto next_step;
						}
						/* send the reset */
						p->scr2.det = 1;
    2bf1:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2bf4:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2bf7:	25 ff ff ff 0f       	and    eax,0xfffffff
    2bfc:	0d 00 00 00 10       	or     eax,0x10000000
    2c01:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
						mdelay(1);
    2c04:	83 ec 0c             	sub    esp,0xc
    2c07:	6a 01                	push   0x1
    2c09:	e8 fc ff ff ff       	call   2c0a <ahci_port_activate_device+0x16d>
    2c0e:	83 c4 10             	add    esp,0x10
						p->scr2.det = 0;
    2c11:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2c14:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2c17:	25 ff ff ff 0f       	and    eax,0xfffffff
    2c1c:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
						udelay(50);
    2c1f:	83 ec 0c             	sub    esp,0xc
    2c22:	6a 32                	push   0x32
    2c24:	e8 fc ff ff ff       	call   2c25 <ahci_port_activate_device+0x188>
    2c29:	83 c4 10             	add    esp,0x10
						if (p->scr0.det != DET_NOT_PRESENT)
    2c2c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c2f:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2c32:	83 e0 0f             	and    eax,0xf
    2c35:	84 c0                	test   al,al
    2c37:	0f 85 a9 00 00 00    	jne    2ce6 <ahci_port_activate_device+0x249>
								goto next_step;
						p->cmd.sud = 0; /* we're done enter listening mode */
    2c3d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2c40:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2c43:	83 e0 fd             	and    eax,0xfffffffd
    2c46:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						abprintf("not present\n");
    2c49:	83 ec 0c             	sub    esp,0xc
    2c4c:	68 21 08 00 00       	push   0x821
    2c51:	e8 fc ff ff ff       	call   2c52 <ahci_port_activate_device+0x1b5>
    2c56:	83 c4 10             	add    esp,0x10
						goto exit;
    2c59:	e9 2f 02 00 00       	jmp    2e8d <ahci_port_activate_device+0x3f0>
				}
				/* just try ICC */
				if (p->scr0.ipm != 1) {
    2c5e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c61:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2c64:	c1 e8 08             	shr    eax,0x8
    2c67:	83 e0 0f             	and    eax,0xf
    2c6a:	3c 01                	cmp    al,0x1
    2c6c:	74 6f                	je     2cdd <ahci_port_activate_device+0x240>
						abprintf("IPM != ACTIVE\n");
    2c6e:	83 ec 0c             	sub    esp,0xc
    2c71:	68 2e 08 00 00       	push   0x82e
    2c76:	e8 fc ff ff ff       	call   2c77 <ahci_port_activate_device+0x1da>
    2c7b:	83 c4 10             	add    esp,0x10
						int ct = 50;
    2c7e:	c7 45 f4 32 00 00 00 	mov    DWORD PTR [ebp-0xc],0x32
						while (p->cmd.icc && ct--)
    2c85:	eb 0d                	jmp    2c94 <ahci_port_activate_device+0x1f7>
								udelay(10);
    2c87:	83 ec 0c             	sub    esp,0xc
    2c8a:	6a 0a                	push   0xa
    2c8c:	e8 fc ff ff ff       	call   2c8d <ahci_port_activate_device+0x1f0>
    2c91:	83 c4 10             	add    esp,0x10
						while (p->cmd.icc && ct--)
    2c94:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c97:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2c9a:	c1 e8 1c             	shr    eax,0x1c
    2c9d:	84 c0                	test   al,al
    2c9f:	74 0d                	je     2cae <ahci_port_activate_device+0x211>
    2ca1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2ca4:	8d 50 ff             	lea    edx,[eax-0x1]
    2ca7:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2caa:	85 c0                	test   eax,eax
    2cac:	75 d9                	jne    2c87 <ahci_port_activate_device+0x1ea>
						p->cmd.icc = 1;
    2cae:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2cb1:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2cb4:	25 ff ff ff 0f       	and    eax,0xfffffff
    2cb9:	0d 00 00 00 10       	or     eax,0x10000000
    2cbe:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						mdelay(10);
    2cc1:	83 ec 0c             	sub    esp,0xc
    2cc4:	6a 0a                	push   0xa
    2cc6:	e8 fc ff ff ff       	call   2cc7 <ahci_port_activate_device+0x22a>
    2ccb:	83 c4 10             	add    esp,0x10
						if (p->scr0.det != DET_NOT_PRESENT)
    2cce:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2cd1:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2cd4:	83 e0 0f             	and    eax,0xf
    2cd7:	84 c0                	test   al,al
    2cd9:	74 0e                	je     2ce9 <ahci_port_activate_device+0x24c>
								goto next_step;
    2cdb:	eb 21                	jmp    2cfe <ahci_port_activate_device+0x261>
						goto exit;
				}
		}

		/* det != 1*/
next_step:
    2cdd:	90                   	nop
    2cde:	eb 1e                	jmp    2cfe <ahci_port_activate_device+0x261>
								goto next_step;
    2ce0:	90                   	nop
    2ce1:	eb 1b                	jmp    2cfe <ahci_port_activate_device+0x261>
								goto next_step;
    2ce3:	90                   	nop
    2ce4:	eb 18                	jmp    2cfe <ahci_port_activate_device+0x261>
								goto next_step;
    2ce6:	90                   	nop
    2ce7:	eb 15                	jmp    2cfe <ahci_port_activate_device+0x261>
						abprintf("unable to set to active\n");
    2ce9:	83 ec 0c             	sub    esp,0xc
    2cec:	68 3d 08 00 00       	push   0x83d
    2cf1:	e8 fc ff ff ff       	call   2cf2 <ahci_port_activate_device+0x255>
    2cf6:	83 c4 10             	add    esp,0x10
						goto exit;
    2cf9:	e9 8f 01 00 00       	jmp    2e8d <ahci_port_activate_device+0x3f0>
		if (p->scr0.det == DET_PRESENT) {
    2cfe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d01:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2d04:	83 e0 0f             	and    eax,0xf
    2d07:	3c 03                	cmp    al,0x3
    2d09:	0f 85 39 01 00 00    	jne    2e48 <ahci_port_activate_device+0x3ab>
				/* almost done */
				if (p->scr0.ipm != IPM_ACTIVE) {
    2d0f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d12:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2d15:	c1 e8 08             	shr    eax,0x8
    2d18:	83 e0 0f             	and    eax,0xf
    2d1b:	3c 01                	cmp    al,0x1
    2d1d:	0f 84 b5 00 00 00    	je     2dd8 <ahci_port_activate_device+0x33b>
						int ct, wc;
						abprintf("Present but not active.\n");
    2d23:	83 ec 0c             	sub    esp,0xc
    2d26:	68 56 08 00 00       	push   0x856
    2d2b:	e8 fc ff ff ff       	call   2d2c <ahci_port_activate_device+0x28f>
    2d30:	83 c4 10             	add    esp,0x10
activ:
						ct = 50, wc = 0;
    2d33:	c7 45 f0 32 00 00 00 	mov    DWORD PTR [ebp-0x10],0x32
    2d3a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
rewait:
						while (p->cmd.icc && ct--) /* 500ms */
    2d41:	eb 0d                	jmp    2d50 <ahci_port_activate_device+0x2b3>
								mdelay(10);
    2d43:	83 ec 0c             	sub    esp,0xc
    2d46:	6a 0a                	push   0xa
    2d48:	e8 fc ff ff ff       	call   2d49 <ahci_port_activate_device+0x2ac>
    2d4d:	83 c4 10             	add    esp,0x10
						while (p->cmd.icc && ct--) /* 500ms */
    2d50:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d53:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2d56:	c1 e8 1c             	shr    eax,0x1c
    2d59:	84 c0                	test   al,al
    2d5b:	74 0d                	je     2d6a <ahci_port_activate_device+0x2cd>
    2d5d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2d60:	8d 50 ff             	lea    edx,[eax-0x1]
    2d63:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    2d66:	85 c0                	test   eax,eax
    2d68:	75 d9                	jne    2d43 <ahci_port_activate_device+0x2a6>
						if (p->scr0.ipm != IPM_ACTIVE && !wc) {
    2d6a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d6d:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2d70:	c1 e8 08             	shr    eax,0x8
    2d73:	83 e0 0f             	and    eax,0xf
    2d76:	3c 01                	cmp    al,0x1
    2d78:	74 33                	je     2dad <ahci_port_activate_device+0x310>
    2d7a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2d7e:	75 2d                	jne    2dad <ahci_port_activate_device+0x310>
								p->cmd.icc = 1;
    2d80:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2d83:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2d86:	25 ff ff ff 0f       	and    eax,0xfffffff
    2d8b:	0d 00 00 00 10       	or     eax,0x10000000
    2d90:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
								ndelay(50);
    2d93:	83 ec 0c             	sub    esp,0xc
    2d96:	6a 32                	push   0x32
    2d98:	e8 fc ff ff ff       	call   2d99 <ahci_port_activate_device+0x2fc>
    2d9d:	83 c4 10             	add    esp,0x10
								wc++; ct = 50;
    2da0:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    2da4:	c7 45 f0 32 00 00 00 	mov    DWORD PTR [ebp-0x10],0x32
								goto rewait;
    2dab:	eb 94                	jmp    2d41 <ahci_port_activate_device+0x2a4>
						}
						if (wc) {
    2dad:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2db1:	74 25                	je     2dd8 <ahci_port_activate_device+0x33b>
								/* reset */
								p->scr2.det = 1;
    2db3:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2db6:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2db9:	25 ff ff ff 0f       	and    eax,0xfffffff
    2dbe:	0d 00 00 00 10       	or     eax,0x10000000
    2dc3:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
								mdelay(1);
    2dc6:	83 ec 0c             	sub    esp,0xc
    2dc9:	6a 01                	push   0x1
    2dcb:	e8 fc ff ff ff       	call   2dcc <ahci_port_activate_device+0x32f>
    2dd0:	83 c4 10             	add    esp,0x10
								goto next_step;
    2dd3:	e9 26 ff ff ff       	jmp    2cfe <ahci_port_activate_device+0x261>
						}
				}
				abprintf("Device at port %zd is active and present.\n",
						p - h->port);
    2dd8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ddb:	05 00 01 00 00       	add    eax,0x100
    2de0:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2de3:	29 c2                	sub    edx,eax
				abprintf("Device at port %zd is active and present.\n",
    2de5:	89 d0                	mov    eax,edx
    2de7:	c1 f8 07             	sar    eax,0x7
    2dea:	83 ec 08             	sub    esp,0x8
    2ded:	50                   	push   eax
    2dee:	68 70 08 00 00       	push   0x870
    2df3:	e8 fc ff ff ff       	call   2df4 <ahci_port_activate_device+0x357>
    2df8:	83 c4 10             	add    esp,0x10
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    2dfb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2dfe:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2e01:	c1 e8 08             	shr    eax,0x8
    2e04:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    2e07:	0f b6 f0             	movzx  esi,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    2e0a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e0d:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2e10:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    2e13:	0f b6 d8             	movzx  ebx,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    2e16:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e19:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2e1c:	0f b6 c4             	movzx  eax,ah
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    2e1f:	0f b6 c8             	movzx  ecx,al
    2e22:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e25:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2e28:	0f b6 d0             	movzx  edx,al
    2e2b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e2e:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2e31:	83 ec 08             	sub    esp,0x8
    2e34:	56                   	push   esi
    2e35:	53                   	push   ebx
    2e36:	51                   	push   ecx
    2e37:	52                   	push   edx
    2e38:	50                   	push   eax
    2e39:	68 9b 08 00 00       	push   0x89b
    2e3e:	e8 fc ff ff ff       	call   2e3f <ahci_port_activate_device+0x3a2>
    2e43:	83 c4 20             	add    esp,0x20
				return;
    2e46:	eb 69                	jmp    2eb1 <ahci_port_activate_device+0x414>
		} else if (p->scr0.det == DET_PHY_OFFLINE) {
    2e48:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e4b:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2e4e:	83 e0 0f             	and    eax,0xf
    2e51:	3c 04                	cmp    al,0x4
    2e53:	75 15                	jne    2e6a <ahci_port_activate_device+0x3cd>
				/* just deactivated */
				abprintf("PHY offline mode\n");
    2e55:	83 ec 0c             	sub    esp,0xc
    2e58:	68 b4 08 00 00       	push   0x8b4
    2e5d:	e8 fc ff ff ff       	call   2e5e <ahci_port_activate_device+0x3c1>
    2e62:	83 c4 10             	add    esp,0x10
				goto activ;
    2e65:	e9 c9 fe ff ff       	jmp    2d33 <ahci_port_activate_device+0x296>
		} else if (p->scr0.det == DET_PRESENT_NO_PHY) {
    2e6a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e6d:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2e70:	83 e0 0f             	and    eax,0xf
    2e73:	3c 01                	cmp    al,0x1
    2e75:	75 15                	jne    2e8c <ahci_port_activate_device+0x3ef>
				abprintf("PRESENT_NO_PHY mode\n");
    2e77:	83 ec 0c             	sub    esp,0xc
    2e7a:	68 c6 08 00 00       	push   0x8c6
    2e7f:	e8 fc ff ff ff       	call   2e80 <ahci_port_activate_device+0x3e3>
    2e84:	83 c4 10             	add    esp,0x10
				goto activ; /* try the same */
    2e87:	e9 a7 fe ff ff       	jmp    2d33 <ahci_port_activate_device+0x296>
		}
exit:
    2e8c:	90                   	nop
				/* we're really done */
				abprintf("Not present at port %zd\n", p - h->port);
    2e8d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e90:	05 00 01 00 00       	add    eax,0x100
    2e95:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2e98:	29 c2                	sub    edx,eax
    2e9a:	89 d0                	mov    eax,edx
    2e9c:	c1 f8 07             	sar    eax,0x7
    2e9f:	83 ec 08             	sub    esp,0x8
    2ea2:	50                   	push   eax
    2ea3:	68 db 08 00 00       	push   0x8db
    2ea8:	e8 fc ff ff ff       	call   2ea9 <ahci_port_activate_device+0x40c>
    2ead:	83 c4 10             	add    esp,0x10
				return;
    2eb0:	90                   	nop
}
    2eb1:	8d 65 f8             	lea    esp,[ebp-0x8]
    2eb4:	5b                   	pop    ebx
    2eb5:	5e                   	pop    esi
    2eb6:	5d                   	pop    ebp
    2eb7:	c3                   	ret

00002eb8 <ahci_enable_port>:

void ahci_enable_port(struct ahci_device* ad, int pt)
{
    2eb8:	55                   	push   ebp
    2eb9:	89 e5                	mov    ebp,esp
    2ebb:	53                   	push   ebx
    2ebc:	83 ec 14             	sub    esp,0x14
		struct ahci_port* p = &ad->ptr->port[pt];
    2ebf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ec2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2ec5:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2ec8:	83 c2 02             	add    edx,0x2
    2ecb:	c1 e2 07             	shl    edx,0x7
    2ece:	01 d0                	add    eax,edx
    2ed0:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		int reset_ct = 0;
    2ed3:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    2eda:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2edd:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2ee0:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2ee3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ee6:	bb 01 00 00 00       	mov    ebx,0x1
    2eeb:	89 c1                	mov    ecx,eax
    2eed:	d3 e3                	shl    ebx,cl
    2eef:	89 d8                	mov    eax,ebx
    2ef1:	21 d0                	and    eax,edx
    2ef3:	85 c0                	test   eax,eax
    2ef5:	0f 84 30 02 00 00    	je     312b <ahci_enable_port+0x273>
				return;

Pos1:
    2efb:	90                   	nop
		/* clear old data */
		p->pXserr = 0xffffffff; /* 10.1.2 -> 6. */
    2efc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2eff:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
		p->pXis = 0xffffffff; /* clear all pending interrupts */
    2f06:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f09:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [eax+0x10],0xffffffff

		/* first allow for the reception of FISes */
		p->cmd.fre = 1;
    2f10:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2f13:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2f16:	83 c8 10             	or     eax,0x10
    2f19:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		ndelay(20); /* wait for BSY to show up */
    2f1c:	83 ec 0c             	sub    esp,0xc
    2f1f:	6a 14                	push   0x14
    2f21:	e8 fc ff ff ff       	call   2f22 <ahci_enable_port+0x6a>
    2f26:	83 c4 10             	add    esp,0x10
		while (1) {
				uint8_t sts = p->tfd.sts;
    2f29:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f2c:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2f2f:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
				if (sts & TFS_ERR) {
    2f32:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    2f36:	83 e0 01             	and    eax,0x1
    2f39:	85 c0                	test   eax,eax
    2f3b:	0f 84 db 00 00 00    	je     301c <ahci_enable_port+0x164>
						/* something went wrong! */
						if (sts == 0x7f) /* no device */
    2f41:	80 7d ef 7f          	cmp    BYTE PTR [ebp-0x11],0x7f
    2f45:	0f 84 f0 00 00 00    	je     303b <ahci_enable_port+0x183>
								break;
						else if (sts == 0x41 && p->tfd.err == 0x20) {
    2f4b:	80 7d ef 41          	cmp    BYTE PTR [ebp-0x11],0x41
    2f4f:	75 1e                	jne    2f6f <ahci_enable_port+0xb7>
    2f51:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f54:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2f57:	0f b6 c4             	movzx  eax,ah
    2f5a:	3c 20                	cmp    al,0x20
    2f5c:	75 11                	jne    2f6f <ahci_enable_port+0xb7>
								if (p->pXsig == SIG_ATAPI)
    2f5e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f61:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2f64:	3d 01 01 14 eb       	cmp    eax,0xeb140101
    2f69:	0f 84 cf 00 00 00    	je     303e <ahci_enable_port+0x186>
										break; /* no medium */
						}
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
								" while starting up.\n", pt, p->tfd.err);
    2f6f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f72:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2f75:	0f b6 c4             	movzx  eax,ah
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
    2f78:	0f b6 c0             	movzx  eax,al
    2f7b:	50                   	push   eax
    2f7c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2f7f:	68 f4 08 00 00       	push   0x8f4
    2f84:	6a 0e                	push   0xe
    2f86:	e8 fc ff ff ff       	call   2f87 <ahci_enable_port+0xcf>
    2f8b:	83 c4 10             	add    esp,0x10
						abprintf("scr1: %x %x\n", p->scr1.diag, p->scr1.err);
    2f8e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f91:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2f94:	0f b7 d0             	movzx  edx,ax
    2f97:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f9a:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2f9d:	c1 e8 10             	shr    eax,0x10
    2fa0:	0f b7 c0             	movzx  eax,ax
    2fa3:	83 ec 04             	sub    esp,0x4
    2fa6:	52                   	push   edx
    2fa7:	50                   	push   eax
    2fa8:	68 2c 09 00 00       	push   0x92c
    2fad:	e8 fc ff ff ff       	call   2fae <ahci_enable_port+0xf6>
    2fb2:	83 c4 10             	add    esp,0x10
						abprintf("tfd: %x %x\n", p->tfd.sts, p->tfd.err);
    2fb5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fb8:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2fbb:	0f b6 c4             	movzx  eax,ah
    2fbe:	0f b6 d0             	movzx  edx,al
    2fc1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fc4:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2fc7:	0f b6 c0             	movzx  eax,al
    2fca:	83 ec 04             	sub    esp,0x4
    2fcd:	52                   	push   edx
    2fce:	50                   	push   eax
    2fcf:	68 39 09 00 00       	push   0x939
    2fd4:	e8 fc ff ff ff       	call   2fd5 <ahci_enable_port+0x11d>
    2fd9:	83 c4 10             	add    esp,0x10
						p->pXserr = 0xffffffff;
    2fdc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fdf:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
						if (!reset_ct++) {
    2fe6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2fe9:	8d 50 01             	lea    edx,[eax+0x1]
    2fec:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2fef:	85 c0                	test   eax,eax
    2ff1:	75 1a                	jne    300d <ahci_enable_port+0x155>
								ahci_port_activate_device(ad->ptr, p);
    2ff3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ff6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2ff9:	83 ec 08             	sub    esp,0x8
    2ffc:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2fff:	50                   	push   eax
    3000:	e8 fc ff ff ff       	call   3001 <ahci_enable_port+0x149>
    3005:	83 c4 10             	add    esp,0x10
								goto Pos1;
    3008:	e9 ef fe ff ff       	jmp    2efc <ahci_enable_port+0x44>
						} else if (reset_ct == 1) {
    300d:	83 7d f4 01          	cmp    DWORD PTR [ebp-0xc],0x1
    3011:	0f 85 ee 00 00 00    	jne    3105 <ahci_enable_port+0x24d>
								/*ahci_reset_port(ad->ptr, p);*/
								goto Pos1;
    3017:	e9 e0 fe ff ff       	jmp    2efc <ahci_enable_port+0x44>
						} else
								goto defer;
				}
				if (!(sts & (TFS_BSY | TFS_DRQ)))
    301c:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    3020:	25 88 00 00 00       	and    eax,0x88
    3025:	85 c0                	test   eax,eax
    3027:	74 18                	je     3041 <ahci_enable_port+0x189>
						break;
				udelay(50);
    3029:	83 ec 0c             	sub    esp,0xc
    302c:	6a 32                	push   0x32
    302e:	e8 fc ff ff ff       	call   302f <ahci_enable_port+0x177>
    3033:	83 c4 10             	add    esp,0x10
		while (1) {
    3036:	e9 ee fe ff ff       	jmp    2f29 <ahci_enable_port+0x71>
								break;
    303b:	90                   	nop
    303c:	eb 04                	jmp    3042 <ahci_enable_port+0x18a>
										break; /* no medium */
    303e:	90                   	nop
    303f:	eb 01                	jmp    3042 <ahci_enable_port+0x18a>
						break;
    3041:	90                   	nop
		}

		/* set ST only if BSY,DRQ and DET=3h or IPM=2,6,8 */
		if (p->scr0.det != 3)
    3042:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3045:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3048:	83 e0 0f             	and    eax,0xf
    304b:	3c 03                	cmp    al,0x3
    304d:	74 15                	je     3064 <ahci_enable_port+0x1ac>
				ahci_port_activate_device(ad->ptr, p);
    304f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3052:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3055:	83 ec 08             	sub    esp,0x8
    3058:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    305b:	50                   	push   eax
    305c:	e8 fc ff ff ff       	call   305d <ahci_enable_port+0x1a5>
    3061:	83 c4 10             	add    esp,0x10
		if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    3064:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3067:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    306a:	0f b6 c0             	movzx  eax,al
    306d:	25 88 00 00 00       	and    eax,0x88
    3072:	85 c0                	test   eax,eax
    3074:	0f 85 8e 00 00 00    	jne    3108 <ahci_enable_port+0x250>
				goto defer; /* listen */
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    307a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    307d:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3080:	83 e0 0f             	and    eax,0xf
    3083:	3c 03                	cmp    al,0x3
    3085:	74 30                	je     30b7 <ahci_enable_port+0x1ff>
    3087:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    308a:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    308d:	c1 e8 08             	shr    eax,0x8
    3090:	83 e0 0f             	and    eax,0xf
    3093:	3c 02                	cmp    al,0x2
    3095:	74 20                	je     30b7 <ahci_enable_port+0x1ff>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    3097:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    309a:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    309d:	c1 e8 08             	shr    eax,0x8
    30a0:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    30a3:	3c 06                	cmp    al,0x6
    30a5:	74 10                	je     30b7 <ahci_enable_port+0x1ff>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    30a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    30aa:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    30ad:	c1 e8 08             	shr    eax,0x8
    30b0:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    30b3:	3c 08                	cmp    al,0x8
    30b5:	75 54                	jne    310b <ahci_enable_port+0x253>
				goto defer;
		/* we're allowed so set it */
		p->cmd.st = 1;
    30b7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    30ba:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    30bd:	83 c8 01             	or     eax,0x1
    30c0:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		/* Change in PhyRdy, CPS, TFS.err, PCS, DPS(I=1), UFS, HBFS, HBDS, IFS, D2HFIS */
		p->pXie = (1 << 22) | (1 << 6) | (1 << 31) | (1 << 30) | (1 << 0)
    30c3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    30c6:	c7 40 14 71 00 40 f8 	mov    DWORD PTR [eax+0x14],0xf8400071
				| (1 << 5) | (1 << 4) | (1 << 29) | (1 << 28) | (1 << 27);

		/* issue the IDENTIFY_(PACKET)_DEVICE command */
		ahci_issue_command(ad, pt, 0, disk_cmd_identify, 0, 0, NULL, NULL /* wq_worker_ad*/, NULL);
    30cd:	83 ec 04             	sub    esp,0x4
    30d0:	6a 00                	push   0x0
    30d2:	6a 00                	push   0x0
    30d4:	6a 00                	push   0x0
    30d6:	6a 00                	push   0x0
    30d8:	6a 00                	push   0x0
    30da:	6a 00                	push   0x0
    30dc:	6a 00                	push   0x0
    30de:	6a 00                	push   0x0
    30e0:	6a 00                	push   0x0
    30e2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    30e5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    30e8:	e8 fc ff ff ff       	call   30e9 <ahci_enable_port+0x231>
    30ed:	83 c4 30             	add    esp,0x30

		printf("port %d is now processing commands\n", pt);
    30f0:	83 ec 08             	sub    esp,0x8
    30f3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    30f6:	68 48 09 00 00       	push   0x948
    30fb:	e8 fc ff ff ff       	call   30fc <ahci_enable_port+0x244>
    3100:	83 c4 10             	add    esp,0x10
		return;
    3103:	eb 27                	jmp    312c <ahci_enable_port+0x274>
								goto defer;
    3105:	90                   	nop
    3106:	eb 04                	jmp    310c <ahci_enable_port+0x254>
				goto defer; /* listen */
    3108:	90                   	nop
    3109:	eb 01                	jmp    310c <ahci_enable_port+0x254>
				goto defer;
    310b:	90                   	nop

defer: /* we're interested in status changes only */
		abprintf("port %d set to listening mode\n", pt);
    310c:	83 ec 08             	sub    esp,0x8
    310f:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    3112:	68 6c 09 00 00       	push   0x96c
    3117:	e8 fc ff ff ff       	call   3118 <ahci_enable_port+0x260>
    311c:	83 c4 10             	add    esp,0x10
		p->pXie = (1 << 22) | (1 << 31) | (1 << 6); /* PhyRdy change, CPS, CCS */
    311f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3122:	c7 40 14 40 00 40 80 	mov    DWORD PTR [eax+0x14],0x80400040
    3129:	eb 01                	jmp    312c <ahci_enable_port+0x274>
				return;
    312b:	90                   	nop
}
    312c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    312f:	c9                   	leave
    3130:	c3                   	ret

00003131 <ahci_stop_port>:

void ahci_stop_port(struct ahci_device* ad, int pt)
{
    3131:	55                   	push   ebp
    3132:	89 e5                	mov    ebp,esp
    3134:	53                   	push   ebx
    3135:	83 ec 14             	sub    esp,0x14
		struct ahci_port* p = &ad->ptr->port[pt];
    3138:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    313b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    313e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    3141:	83 c2 02             	add    edx,0x2
    3144:	c1 e2 07             	shl    edx,0x7
    3147:	01 d0                	add    eax,edx
    3149:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		int ct;

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    314c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    314f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3152:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3155:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3158:	bb 01 00 00 00       	mov    ebx,0x1
    315d:	89 c1                	mov    ecx,eax
    315f:	d3 e3                	shl    ebx,cl
    3161:	89 d8                	mov    eax,ebx
    3163:	21 d0                	and    eax,edx
    3165:	85 c0                	test   eax,eax
    3167:	0f 84 56 01 00 00    	je     32c3 <ahci_stop_port+0x192>
				return;

		/* print the BIOS provided status */
		abprintf("BIOS initial state of port %d:\n", pt);
    316d:	83 ec 08             	sub    esp,0x8
    3170:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    3173:	68 8c 09 00 00       	push   0x98c
    3178:	e8 fc ff ff ff       	call   3179 <ahci_stop_port+0x48>
    317d:	83 c4 10             	add    esp,0x10
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
				p->cmd.st ? "ST" : "");
    3180:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3183:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3186:	83 e0 01             	and    eax,0x1
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
    3189:	84 c0                	test   al,al
    318b:	74 07                	je     3194 <ahci_stop_port+0x63>
    318d:	ba ac 09 00 00       	mov    edx,0x9ac
    3192:	eb 05                	jmp    3199 <ahci_stop_port+0x68>
    3194:	ba ff 02 00 00       	mov    edx,0x2ff
    3199:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    319c:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    319f:	c1 e8 04             	shr    eax,0x4
    31a2:	83 e0 01             	and    eax,0x1
    31a5:	84 c0                	test   al,al
    31a7:	74 07                	je     31b0 <ahci_stop_port+0x7f>
    31a9:	b8 af 09 00 00       	mov    eax,0x9af
    31ae:	eb 05                	jmp    31b5 <ahci_stop_port+0x84>
    31b0:	b8 ff 02 00 00       	mov    eax,0x2ff
    31b5:	83 ec 04             	sub    esp,0x4
    31b8:	52                   	push   edx
    31b9:	50                   	push   eax
    31ba:	68 b4 09 00 00       	push   0x9b4
    31bf:	e8 fc ff ff ff       	call   31c0 <ahci_stop_port+0x8f>
    31c4:	83 c4 10             	add    esp,0x10
		/* print the pointers */
		abprintf("BIOS command list located at %016llx\n", p->pXclb64);
    31c7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    31ca:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    31cd:	8b 00                	mov    eax,DWORD PTR [eax]
    31cf:	83 ec 04             	sub    esp,0x4
    31d2:	52                   	push   edx
    31d3:	50                   	push   eax
    31d4:	68 bc 09 00 00       	push   0x9bc
    31d9:	e8 fc ff ff ff       	call   31da <ahci_stop_port+0xa9>
    31de:	83 c4 10             	add    esp,0x10
		abprintf("BIOS FIS received buffer at  %016llx\n", p->pXfb64);
    31e1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    31e4:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    31e7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    31ea:	83 ec 04             	sub    esp,0x4
    31ed:	52                   	push   edx
    31ee:	50                   	push   eax
    31ef:	68 e4 09 00 00       	push   0x9e4
    31f4:	e8 fc ff ff ff       	call   31f5 <ahci_stop_port+0xc4>
    31f9:	83 c4 10             	add    esp,0x10

		/* check if already off */
		if (!p->cmd.fre && !p->cmd.st)
    31fc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    31ff:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3202:	c1 e8 04             	shr    eax,0x4
    3205:	83 e0 01             	and    eax,0x1
    3208:	84 c0                	test   al,al
    320a:	75 11                	jne    321d <ahci_stop_port+0xec>
    320c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    320f:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3212:	83 e0 01             	and    eax,0x1
    3215:	84 c0                	test   al,al
    3217:	0f 84 a9 00 00 00    	je     32c6 <ahci_stop_port+0x195>
				return;

		/* Now turn it off (2x500ms max else reset) */
		ct = 50;
    321d:	c7 45 f4 32 00 00 00 	mov    DWORD PTR [ebp-0xc],0x32
		p->cmd.st = 0;
    3224:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    3227:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    322a:	83 e0 fe             	and    eax,0xfffffffe
    322d:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		while (p->cmd.cr && ct--)
    3230:	eb 0d                	jmp    323f <ahci_stop_port+0x10e>
				mdelay(10);
    3232:	83 ec 0c             	sub    esp,0xc
    3235:	6a 0a                	push   0xa
    3237:	e8 fc ff ff ff       	call   3238 <ahci_stop_port+0x107>
    323c:	83 c4 10             	add    esp,0x10
		while (p->cmd.cr && ct--)
    323f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3242:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3245:	c1 e8 0f             	shr    eax,0xf
    3248:	83 e0 01             	and    eax,0x1
    324b:	84 c0                	test   al,al
    324d:	74 0d                	je     325c <ahci_stop_port+0x12b>
    324f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3252:	8d 50 ff             	lea    edx,[eax-0x1]
    3255:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    3258:	85 c0                	test   eax,eax
    325a:	75 d6                	jne    3232 <ahci_stop_port+0x101>
		if (ct == -1)
    325c:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
    3260:	74 41                	je     32a3 <ahci_stop_port+0x172>
				goto reset;
		ct = 50;
    3262:	c7 45 f4 32 00 00 00 	mov    DWORD PTR [ebp-0xc],0x32
		p->cmd.fre = 0;
    3269:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    326c:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    326f:	83 e0 ef             	and    eax,0xffffffef
    3272:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		while (p->cmd.fr && ct--)
    3275:	eb 0d                	jmp    3284 <ahci_stop_port+0x153>
				mdelay(10);
    3277:	83 ec 0c             	sub    esp,0xc
    327a:	6a 0a                	push   0xa
    327c:	e8 fc ff ff ff       	call   327d <ahci_stop_port+0x14c>
    3281:	83 c4 10             	add    esp,0x10
		while (p->cmd.fr && ct--)
    3284:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3287:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    328a:	c1 e8 0e             	shr    eax,0xe
    328d:	83 e0 01             	and    eax,0x1
    3290:	84 c0                	test   al,al
    3292:	74 12                	je     32a6 <ahci_stop_port+0x175>
    3294:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3297:	8d 50 ff             	lea    edx,[eax-0x1]
    329a:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    329d:	85 c0                	test   eax,eax
    329f:	75 d6                	jne    3277 <ahci_stop_port+0x146>
reset:
    32a1:	eb 03                	jmp    32a6 <ahci_stop_port+0x175>
				goto reset;
    32a3:	90                   	nop
    32a4:	eb 01                	jmp    32a7 <ahci_stop_port+0x176>
reset:
    32a6:	90                   	nop
		if (ct == -1) {
    32a7:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
    32ab:	75 1a                	jne    32c7 <ahci_stop_port+0x196>
				printf("Port %d: reset needed!\n", pt);
    32ad:	83 ec 08             	sub    esp,0x8
    32b0:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    32b3:	68 0a 0a 00 00       	push   0xa0a
    32b8:	e8 fc ff ff ff       	call   32b9 <ahci_stop_port+0x188>
    32bd:	83 c4 10             	add    esp,0x10
				/* TODO implement this */
				//ahci_reset_port(ad, pt);
				while (1);
    32c0:	90                   	nop
    32c1:	eb fd                	jmp    32c0 <ahci_stop_port+0x18f>
				return;
    32c3:	90                   	nop
    32c4:	eb 01                	jmp    32c7 <ahci_stop_port+0x196>
				return;
    32c6:	90                   	nop
		}
		/* The port is now off innit? */
}
    32c7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    32ca:	c9                   	leave
    32cb:	c3                   	ret

000032cc <ahci_assign_buffers>:

/* we have ad->num_ports active ports needing num_cmd
 * command slots and one FIS receive buffer each.
 * The command lists are held in a shared pool. */
void ahci_assign_buffers(struct ahci_device* ad)
{
    32cc:	55                   	push   ebp
    32cd:	89 e5                	mov    ebp,esp
    32cf:	53                   	push   ebx
    32d0:	83 ec 44             	sub    esp,0x44
		size_t bt_ct, pg_ct; int flg = MMGR_ALLOC_COMPLETE;
    32d3:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		struct page_range pr; int cc, fc, ic;
		/* Total size: 256*np+1024*np+512*np */
		bt_ct = ad->num_ports * (sizeof(struct ahci_fis)
    32da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32dd:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    32e1:	0f b7 c0             	movzx  eax,ax
    32e4:	69 c0 00 07 00 00    	imul   eax,eax,0x700
    32ea:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				+ sizeof(struct ahci_cmdlst) + 512);
		pg_ct = rdiv(bt_ct, 4096);
    32ed:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    32f0:	c1 e8 0c             	shr    eax,0xc
    32f3:	89 c2                	mov    edx,eax
    32f5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    32f8:	25 ff 0f 00 00       	and    eax,0xfff
    32fd:	85 c0                	test   eax,eax
    32ff:	74 07                	je     3308 <ahci_assign_buffers+0x3c>
    3301:	b8 01 00 00 00       	mov    eax,0x1
    3306:	eb 05                	jmp    330d <ahci_assign_buffers+0x41>
    3308:	b8 00 00 00 00       	mov    eax,0x0
    330d:	01 d0                	add    eax,edx
    330f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* allocate and map the physical memory */
		ic = cc = fc = ad->num_ports;
    3312:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3315:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3319:	0f b7 c0             	movzx  eax,ax
    331c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    331f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3322:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    3325:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3328:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!ad->ptr->cap.is_64bit)
    332b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    332e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3331:	8b 00                	mov    eax,DWORD PTR [eax]
    3333:	c1 e8 1f             	shr    eax,0x1f
    3336:	84 c0                	test   al,al
    3338:	0f 85 9a 02 00 00    	jne    35d8 <ahci_assign_buffers+0x30c>
				flg = MMGR_ALLOC_32BIT;
    333e:	c7 45 f0 00 00 04 00 	mov    DWORD PTR [ebp-0x10],0x40000
		while (pg_ct) {
    3345:	e9 8e 02 00 00       	jmp    35d8 <ahci_assign_buffers+0x30c>
				void* ptr; size_t nb;
				/* we don't need contiguous memory */
				pg_ct -= mm_alloc_pm_flg(pg_ct, &pr, 1, flg);
    334a:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    334d:	6a 01                	push   0x1
    334f:	8d 45 c0             	lea    eax,[ebp-0x40]
    3352:	50                   	push   eax
    3353:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    3356:	e8 fc ff ff ff       	call   3357 <ahci_assign_buffers+0x8b>
    335b:	83 c4 10             	add    esp,0x10
    335e:	29 45 f4             	sub    DWORD PTR [ebp-0xc],eax
				if (!pr.count)
    3361:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3364:	85 c0                	test   eax,eax
    3366:	0f 84 7b 02 00 00    	je     35e7 <ahci_assign_buffers+0x31b>
						goto quit;
				nb = 4096 * pr.count;
    336c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    336f:	c1 e0 0c             	shl    eax,0xc
    3372:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, /*MMGR_MAP_MMIO | <- 0xe nope */
    3375:	83 ec 0c             	sub    esp,0xc
    3378:	6a 2c                	push   0x2c
    337a:	6a 01                	push   0x1
    337c:	8d 45 c0             	lea    eax,[ebp-0x40]
    337f:	50                   	push   eax
    3380:	6a 00                	push   0x0
    3382:	68 00 00 00 00       	push   0x0
    3387:	e8 fc ff ff ff       	call   3388 <ahci_assign_buffers+0xbc>
    338c:	83 c4 20             	add    esp,0x20
    338f:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!ptr)
    3392:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    3396:	0f 84 4e 02 00 00    	je     35ea <ahci_assign_buffers+0x31e>
						goto quit;

				/* now first process the command lists with 1K-alignment */
				while (cc && nb >= 1024) {
    339c:	e9 82 00 00 00       	jmp    3423 <ahci_assign_buffers+0x157>
						int pt = ad->num_ports - cc--;
    33a1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33a4:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    33a8:	0f b7 c8             	movzx  ecx,ax
    33ab:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    33ae:	8d 50 ff             	lea    edx,[eax-0x1]
    33b1:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    33b4:	29 c1                	sub    ecx,eax
    33b6:	89 ca                	mov    edx,ecx
    33b8:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						if (ad->ptr->ports & (1 << pt)) {
    33bb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33be:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    33c1:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    33c4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    33c7:	bb 01 00 00 00       	mov    ebx,0x1
    33cc:	89 c1                	mov    ecx,eax
    33ce:	d3 e3                	shl    ebx,cl
    33d0:	89 d8                	mov    eax,ebx
    33d2:	21 d0                	and    eax,edx
    33d4:	85 c0                	test   eax,eax
    33d6:	74 4b                	je     3423 <ahci_assign_buffers+0x157>
								/* assign for implemented port */
								ad->ptr->port[pt].pXclb64 = pr.base;
    33d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33db:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    33de:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    33e1:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    33e4:	8b 5d d4             	mov    ebx,DWORD PTR [ebp-0x2c]
    33e7:	83 c3 02             	add    ebx,0x2
    33ea:	c1 e3 07             	shl    ebx,0x7
    33ed:	01 d9                	add    ecx,ebx
    33ef:	89 01                	mov    DWORD PTR [ecx],eax
    33f1:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								ad->command_lists[pt] = ptr;
    33f4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33f7:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    33fa:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    33fd:	89 4c 90 0c          	mov    DWORD PTR [eax+edx*4+0xc],ecx
								/* advance */
								pr.base += 1024;
    3401:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3404:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    3407:	05 00 04 00 00       	add    eax,0x400
    340c:	83 d2 00             	adc    edx,0x0
    340f:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    3412:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								nb -= 1024;
    3415:	81 6d dc 00 04 00 00 	sub    DWORD PTR [ebp-0x24],0x400
								ptr += 1024;
    341c:	81 45 e0 00 04 00 00 	add    DWORD PTR [ebp-0x20],0x400
				while (cc && nb >= 1024) {
    3423:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    3427:	0f 84 98 00 00 00    	je     34c5 <ahci_assign_buffers+0x1f9>
    342d:	81 7d dc ff 03 00 00 	cmp    DWORD PTR [ebp-0x24],0x3ff
    3434:	0f 87 67 ff ff ff    	ja     33a1 <ahci_assign_buffers+0xd5>
						}
				}

				/* then the FIS buffers (256bt-aligned) */
				while (fc && nb >= 256) {
    343a:	e9 86 00 00 00       	jmp    34c5 <ahci_assign_buffers+0x1f9>
						int pt = ad->num_ports - fc--;
    343f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3442:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3446:	0f b7 c8             	movzx  ecx,ax
    3449:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    344c:	8d 50 ff             	lea    edx,[eax-0x1]
    344f:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    3452:	29 c1                	sub    ecx,eax
    3454:	89 ca                	mov    edx,ecx
    3456:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
						if (ad->ptr->ports & (1 << pt)) {
    3459:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    345c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    345f:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3462:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    3465:	bb 01 00 00 00       	mov    ebx,0x1
    346a:	89 c1                	mov    ecx,eax
    346c:	d3 e3                	shl    ebx,cl
    346e:	89 d8                	mov    eax,ebx
    3470:	21 d0                	and    eax,edx
    3472:	85 c0                	test   eax,eax
    3474:	74 4f                	je     34c5 <ahci_assign_buffers+0x1f9>
								/* as above */
								ad->ptr->port[pt].pXfb64 = pr.base;
    3476:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3479:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    347c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    347f:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    3482:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
    3485:	83 c3 02             	add    ebx,0x2
    3488:	c1 e3 07             	shl    ebx,0x7
    348b:	01 d9                	add    ecx,ebx
    348d:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    3490:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
								ad->recv_fis[pt] = ptr;
    3493:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3496:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    3499:	8d 4a 20             	lea    ecx,[edx+0x20]
    349c:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    349f:	89 54 88 0c          	mov    DWORD PTR [eax+ecx*4+0xc],edx
								/* advance */
								pr.base += 256;
    34a3:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    34a6:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    34a9:	05 00 01 00 00       	add    eax,0x100
    34ae:	83 d2 00             	adc    edx,0x0
    34b1:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    34b4:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								nb -= 256;
    34b7:	81 6d dc 00 01 00 00 	sub    DWORD PTR [ebp-0x24],0x100
								ptr += 256;
    34be:	81 45 e0 00 01 00 00 	add    DWORD PTR [ebp-0x20],0x100
				while (fc && nb >= 256) {
    34c5:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    34c9:	0f 84 b4 00 00 00    	je     3583 <ahci_assign_buffers+0x2b7>
    34cf:	81 7d dc ff 00 00 00 	cmp    DWORD PTR [ebp-0x24],0xff
    34d6:	0f 87 63 ff ff ff    	ja     343f <ahci_assign_buffers+0x173>
						}
				}

				while (ic && nb >= 512) {
    34dc:	e9 a2 00 00 00       	jmp    3583 <ahci_assign_buffers+0x2b7>
						int pt = ad->num_ports - ic--;
    34e1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34e4:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    34e8:	0f b7 c8             	movzx  ecx,ax
    34eb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    34ee:	8d 50 ff             	lea    edx,[eax-0x1]
    34f1:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    34f4:	29 c1                	sub    ecx,eax
    34f6:	89 ca                	mov    edx,ecx
    34f8:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						if (ad->ptr->ports & (1 << pt)) {
    34fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34fe:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3501:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3504:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    3507:	bb 01 00 00 00       	mov    ebx,0x1
    350c:	89 c1                	mov    ecx,eax
    350e:	d3 e3                	shl    ebx,cl
    3510:	89 d8                	mov    eax,ebx
    3512:	21 d0                	and    eax,edx
    3514:	85 c0                	test   eax,eax
    3516:	74 54                	je     356c <ahci_assign_buffers+0x2a0>
								/* as above */
								ad->identify_data[pt].pm = pr.base;
    3518:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    351b:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    351e:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    3521:	8b 5d cc             	mov    ebx,DWORD PTR [ebp-0x34]
    3524:	83 c3 10             	add    ebx,0x10
    3527:	c1 e3 04             	shl    ebx,0x4
    352a:	01 d9                	add    ecx,ebx
    352c:	89 41 14             	mov    DWORD PTR [ecx+0x14],eax
    352f:	89 51 18             	mov    DWORD PTR [ecx+0x18],edx
								ad->identify_data[pt].ptr = ptr;
    3532:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3535:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3538:	83 c2 10             	add    edx,0x10
    353b:	c1 e2 04             	shl    edx,0x4
    353e:	01 d0                	add    eax,edx
    3540:	8d 50 10             	lea    edx,[eax+0x10]
    3543:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    3546:	89 02                	mov    DWORD PTR [edx],eax
								/* advance */
								pr.base += 512;
    3548:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    354b:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    354e:	05 00 02 00 00       	add    eax,0x200
    3553:	83 d2 00             	adc    edx,0x0
    3556:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    3559:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								nb -= 512;
    355c:	81 6d dc 00 02 00 00 	sub    DWORD PTR [ebp-0x24],0x200
								ptr += 512;
    3563:	81 45 e0 00 02 00 00 	add    DWORD PTR [ebp-0x20],0x200
    356a:	eb 17                	jmp    3583 <ahci_assign_buffers+0x2b7>
						} else
								ad->identify_data[pt].sig = 0;
    356c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    356f:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3572:	83 c2 10             	add    edx,0x10
    3575:	c1 e2 04             	shl    edx,0x4
    3578:	01 d0                	add    eax,edx
    357a:	83 c0 0c             	add    eax,0xc
    357d:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				while (ic && nb >= 512) {
    3583:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    3587:	74 0d                	je     3596 <ahci_assign_buffers+0x2ca>
    3589:	81 7d dc ff 01 00 00 	cmp    DWORD PTR [ebp-0x24],0x1ff
    3590:	0f 87 4b ff ff ff    	ja     34e1 <ahci_assign_buffers+0x215>
				}

				/* exit early if we have non-impelented ports */
				if (!fc && !cc && !ic) {
    3596:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    359a:	75 3c                	jne    35d8 <ahci_assign_buffers+0x30c>
    359c:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    35a0:	75 36                	jne    35d8 <ahci_assign_buffers+0x30c>
    35a2:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    35a6:	75 30                	jne    35d8 <ahci_assign_buffers+0x30c>
						/* also deallocate if possible */
						if (nb >= 4096) {
    35a8:	81 7d dc ff 0f 00 00 	cmp    DWORD PTR [ebp-0x24],0xfff
    35af:	76 33                	jbe    35e4 <ahci_assign_buffers+0x318>
								ptr += (size_t)ptr % 4096;
    35b1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    35b4:	25 ff 0f 00 00       	and    eax,0xfff
    35b9:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								mm_free_vmem(&mm_kernel, ptr, nb / 4096);
    35bc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    35bf:	c1 e8 0c             	shr    eax,0xc
    35c2:	83 ec 04             	sub    esp,0x4
    35c5:	50                   	push   eax
    35c6:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    35c9:	68 00 00 00 00       	push   0x0
    35ce:	e8 fc ff ff ff       	call   35cf <ahci_assign_buffers+0x303>
    35d3:	83 c4 10             	add    esp,0x10
						}
						break;
    35d6:	eb 0c                	jmp    35e4 <ahci_assign_buffers+0x318>
		while (pg_ct) {
    35d8:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    35dc:	0f 85 68 fd ff ff    	jne    334a <ahci_assign_buffers+0x7e>
				}
		}
		/* Now all implemented buffers are set */
		return;
    35e2:	eb 32                	jmp    3616 <ahci_assign_buffers+0x34a>
						break;
    35e4:	90                   	nop
		return;
    35e5:	eb 2f                	jmp    3616 <ahci_assign_buffers+0x34a>
						goto quit;
    35e7:	90                   	nop
    35e8:	eb 01                	jmp    35eb <ahci_assign_buffers+0x31f>
						goto quit;
    35ea:	90                   	nop

quit:
		die("Out of memory!\n");
    35eb:	83 ec 08             	sub    esp,0x8
    35ee:	68 22 0a 00 00       	push   0xa22
    35f3:	6a 0c                	push   0xc
    35f5:	e8 fc ff ff ff       	call   35f6 <ahci_assign_buffers+0x32a>
    35fa:	83 c4 10             	add    esp,0x10
    35fd:	e8 fc ff ff ff       	call   35fe <ahci_assign_buffers+0x332>
    3602:	83 ec 0c             	sub    esp,0xc
    3605:	68 00 00 00 00       	push   0x0
    360a:	e8 fc ff ff ff       	call   360b <ahci_assign_buffers+0x33f>
    360f:	83 c4 10             	add    esp,0x10
    3612:	fa                   	cli
    3613:	f4                   	hlt
    3614:	eb fd                	jmp    3613 <ahci_assign_buffers+0x347>
}
    3616:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    3619:	c9                   	leave
    361a:	c3                   	ret

0000361b <ahci_clear_interrupts>:

/* also disables interrupts */
void ahci_clear_interrupts(struct ahci_device* ad)
{
    361b:	55                   	push   ebp
    361c:	89 e5                	mov    ebp,esp
    361e:	53                   	push   ebx
    361f:	83 ec 10             	sub    esp,0x10
		struct ahci_hba* h = ad->ptr;
    3622:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3625:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3628:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* disable interrupts */
		h->ctrl.ie = 0;
    362b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    362e:	8b 42 04             	mov    eax,DWORD PTR [edx+0x4]
    3631:	83 e0 fd             	and    eax,0xfffffffd
    3634:	89 42 04             	mov    DWORD PTR [edx+0x4],eax

		/* clear them in every port implemented */
		for (int i = 0; i < ad->num_ports; i++) {
    3637:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    363e:	eb 48                	jmp    3688 <ahci_clear_interrupts+0x6d>
				struct ahci_port* p;
				if ((h->ports & (1 << i)) == 0)
    3640:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3643:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3646:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    3649:	bb 01 00 00 00       	mov    ebx,0x1
    364e:	89 c1                	mov    ecx,eax
    3650:	d3 e3                	shl    ebx,cl
    3652:	89 d8                	mov    eax,ebx
    3654:	21 d0                	and    eax,edx
    3656:	85 c0                	test   eax,eax
    3658:	74 29                	je     3683 <ahci_clear_interrupts+0x68>
						continue;
				p = &h->port[i];
    365a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    365d:	83 c0 02             	add    eax,0x2
    3660:	c1 e0 07             	shl    eax,0x7
    3663:	89 c2                	mov    edx,eax
    3665:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3668:	01 d0                	add    eax,edx
    366a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* disable and clear all */
				p->pXie = 0;
    366d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3670:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
				p->pXis = 0xffffffff;
    3677:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    367a:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [eax+0x10],0xffffffff
    3681:	eb 01                	jmp    3684 <ahci_clear_interrupts+0x69>
						continue;
    3683:	90                   	nop
		for (int i = 0; i < ad->num_ports; i++) {
    3684:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
    3688:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    368b:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    368f:	0f b7 c0             	movzx  eax,ax
    3692:	39 45 f8             	cmp    DWORD PTR [ebp-0x8],eax
    3695:	7c a9                	jl     3640 <ahci_clear_interrupts+0x25>
		}

		/* clear the global status */
		h->intr = 0xffffffff; /* W1C */
    3697:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    369a:	c7 40 08 ff ff ff ff 	mov    DWORD PTR [eax+0x8],0xffffffff
}
    36a1:	90                   	nop
    36a2:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    36a5:	c9                   	leave
    36a6:	c3                   	ret

000036a7 <ahci_device_init>:

int ahci_device_init(struct pci_device* d)
{
    36a7:	55                   	push   ebp
    36a8:	89 e5                	mov    ebp,esp
    36aa:	57                   	push   edi
    36ab:	56                   	push   esi
    36ac:	53                   	push   ebx
    36ad:	81 ec 8c 00 00 00    	sub    esp,0x8c
		int rv;

		/* Check progIf */
		if (d->device_interface != 1) {
    36b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    36b6:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
    36ba:	3c 01                	cmp    al,0x1
    36bc:	74 27                	je     36e5 <ahci_device_init+0x3e>
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
						d->device_interface);
    36be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    36c1:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
    36c5:	0f b6 c0             	movzx  eax,al
    36c8:	83 ec 04             	sub    esp,0x4
    36cb:	50                   	push   eax
    36cc:	68 34 0a 00 00       	push   0xa34
    36d1:	6a 0e                	push   0xe
    36d3:	e8 fc ff ff ff       	call   36d4 <ahci_device_init+0x2d>
    36d8:	83 c4 10             	add    esp,0x10
				return -ENOSYS;
    36db:	b8 da ff ff ff       	mov    eax,0xffffffda
    36e0:	e9 d3 07 00 00       	jmp    3eb8 <ahci_device_init+0x811>
		}

		/* Setup and map BAR5 if neccessary */
		if (d->ressources[5].type == PCI_BAR_PIO)
    36e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    36e8:	8b 80 9c 00 00 00    	mov    eax,DWORD PTR [eax+0x9c]
    36ee:	83 f8 01             	cmp    eax,0x1
    36f1:	75 0a                	jne    36fd <ahci_device_init+0x56>
				return -ENOTSUP; /* AHCI requires MMIO at BAR5 */
    36f3:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    36f8:	e9 bb 07 00 00       	jmp    3eb8 <ahci_device_init+0x811>
		if (!d->ressources[5].mmio.base) {
    36fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3700:	8b 90 a4 00 00 00    	mov    edx,DWORD PTR [eax+0xa4]
    3706:	8b 80 a0 00 00 00    	mov    eax,DWORD PTR [eax+0xa0]
    370c:	89 c1                	mov    ecx,eax
    370e:	89 c8                	mov    eax,ecx
    3710:	09 d0                	or     eax,edx
    3712:	0f 85 3a 01 00 00    	jne    3852 <ahci_device_init+0x1ab>
				int atl = 0; uint64_t m;
    3718:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
				/* we first need pmem for the device */
				if (!d->ressources[5].mmio.size) {
    371f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3722:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    3728:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    372e:	89 c1                	mov    ecx,eax
    3730:	89 c8                	mov    eax,ecx
    3732:	09 d0                	or     eax,edx
    3734:	75 54                	jne    378a <ahci_device_init+0xe3>
						/* Ask PCI */
						d->ressources[5].mmio.size = pci_bar_get_size(d, 5);
    3736:	83 ec 08             	sub    esp,0x8
    3739:	6a 05                	push   0x5
    373b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    373e:	e8 fc ff ff ff       	call   373f <ahci_device_init+0x98>
    3743:	83 c4 10             	add    esp,0x10
    3746:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    3749:	89 81 a8 00 00 00    	mov    DWORD PTR [ecx+0xa8],eax
    374f:	89 91 ac 00 00 00    	mov    DWORD PTR [ecx+0xac],edx
						if (!d->ressources[5].mmio.size) {
    3755:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3758:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    375e:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    3764:	89 c1                	mov    ecx,eax
    3766:	89 c8                	mov    eax,ecx
    3768:	09 d0                	or     eax,edx
    376a:	75 1e                	jne    378a <ahci_device_init+0xe3>
								d->ressources[5].mmio.size = 0x1100; /* 32 ports */
    376c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    376f:	c7 80 a8 00 00 00 00 11 00 00 	mov    DWORD PTR [eax+0xa8],0x1100
    3779:	c7 80 ac 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0xac],0x0
								atl = 1; /* about to leave */
    3783:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
						}
				}
				/* Now we want to get some address */
				m = mmio_allocate_range(d->ressources[5].mmio.size,
						0x3 & (d->ressources[5].type >> 1));
    378a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    378d:	8b 80 9c 00 00 00    	mov    eax,DWORD PTR [eax+0x9c]
    3793:	d1 f8                	sar    eax,1
				m = mmio_allocate_range(d->ressources[5].mmio.size,
    3795:	83 e0 03             	and    eax,0x3
    3798:	89 c1                	mov    ecx,eax
    379a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    379d:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    37a3:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    37a9:	83 ec 04             	sub    esp,0x4
    37ac:	51                   	push   ecx
    37ad:	52                   	push   edx
    37ae:	50                   	push   eax
    37af:	e8 fc ff ff ff       	call   37b0 <ahci_device_init+0x109>
    37b4:	83 c4 10             	add    esp,0x10
    37b7:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    37ba:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (!m)
    37bd:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    37c0:	0b 45 cc             	or     eax,DWORD PTR [ebp-0x34]
    37c3:	75 0a                	jne    37cf <ahci_device_init+0x128>
						return -ENOMEM;
    37c5:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    37ca:	e9 e9 06 00 00       	jmp    3eb8 <ahci_device_init+0x811>
				/* and assign it */
				pci_set_bar(d, 5, d->ressources[5].type, m);
    37cf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37d2:	8b 80 9c 00 00 00    	mov    eax,DWORD PTR [eax+0x9c]
    37d8:	83 ec 0c             	sub    esp,0xc
    37db:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    37de:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    37e1:	50                   	push   eax
    37e2:	6a 05                	push   0x5
    37e4:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    37e7:	e8 fc ff ff ff       	call   37e8 <ahci_device_init+0x141>
    37ec:	83 c4 20             	add    esp,0x20
				if (d->ressources[5].mmio.base != m) {
    37ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37f2:	8b 90 a4 00 00 00    	mov    edx,DWORD PTR [eax+0xa4]
    37f8:	8b 80 a0 00 00 00    	mov    eax,DWORD PTR [eax+0xa0]
    37fe:	89 c1                	mov    ecx,eax
    3800:	89 c8                	mov    eax,ecx
    3802:	33 45 c8             	xor    eax,DWORD PTR [ebp-0x38]
    3805:	33 55 cc             	xor    edx,DWORD PTR [ebp-0x34]
    3808:	09 d0                	or     eax,edx
    380a:	74 46                	je     3852 <ahci_device_init+0x1ab>
						/* we can't */
						mmio_free_range(m, d->ressources[5].mmio.size);
    380c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    380f:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    3815:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    381b:	52                   	push   edx
    381c:	50                   	push   eax
    381d:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    3820:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    3823:	e8 fc ff ff ff       	call   3824 <ahci_device_init+0x17d>
    3828:	83 c4 10             	add    esp,0x10
						if (atl)
    382b:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    382f:	74 17                	je     3848 <ahci_device_init+0x1a1>
								d->ressources[5].mmio.size = 0;
    3831:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3834:	c7 80 a8 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0xa8],0x0
    383e:	c7 80 ac 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0xac],0x0
						return -ENOTSUP;
    3848:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    384d:	e9 66 06 00 00       	jmp    3eb8 <ahci_device_init+0x811>
				}
		}

		/* Now we possibly have to map the memory */
		if (!d->ressources[5].mmio.mapping) {
    3852:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3855:	8b 80 b0 00 00 00    	mov    eax,DWORD PTR [eax+0xb0]
    385b:	85 c0                	test   eax,eax
    385d:	0f 85 98 00 00 00    	jne    38fb <ahci_device_init+0x254>
				void* mem; struct page_range pr;
				pr.base = d->ressources[5].mmio.base;
    3863:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3866:	8b 90 a4 00 00 00    	mov    edx,DWORD PTR [eax+0xa4]
    386c:	8b 80 a0 00 00 00    	mov    eax,DWORD PTR [eax+0xa0]
    3872:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
    3875:	89 55 90             	mov    DWORD PTR [ebp-0x70],edx
				pr.count = rdiv(d->ressources[5].mmio.size, 4096);
    3878:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    387b:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    3881:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    3887:	0f ac d0 0c          	shrd   eax,edx,0xc
    388b:	c1 ea 0c             	shr    edx,0xc
    388e:	89 c1                	mov    ecx,eax
    3890:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3893:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    3899:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    389f:	25 ff 0f 00 00       	and    eax,0xfff
    38a4:	ba 00 00 00 00       	mov    edx,0x0
    38a9:	89 c3                	mov    ebx,eax
    38ab:	89 d8                	mov    eax,ebx
    38ad:	09 d0                	or     eax,edx
    38af:	74 07                	je     38b8 <ahci_device_init+0x211>
    38b1:	b8 01 00 00 00       	mov    eax,0x1
    38b6:	eb 05                	jmp    38bd <ahci_device_init+0x216>
    38b8:	b8 00 00 00 00       	mov    eax,0x0
    38bd:	01 c8                	add    eax,ecx
    38bf:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
			   	mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_MMIO |
    38c2:	83 ec 0c             	sub    esp,0xc
    38c5:	6a 2d                	push   0x2d
    38c7:	6a 01                	push   0x1
    38c9:	8d 45 8c             	lea    eax,[ebp-0x74]
    38cc:	50                   	push   eax
    38cd:	6a 00                	push   0x0
    38cf:	68 00 00 00 00       	push   0x0
    38d4:	e8 fc ff ff ff       	call   38d5 <ahci_device_init+0x22e>
    38d9:	83 c4 20             	add    esp,0x20
    38dc:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!mem)
    38df:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
    38e3:	75 0a                	jne    38ef <ahci_device_init+0x248>
						return -ENOMEM;
    38e5:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    38ea:	e9 c9 05 00 00       	jmp    3eb8 <ahci_device_init+0x811>
				d->ressources[5].mmio.mapping = mem;
    38ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    38f2:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    38f5:	89 90 b0 00 00 00    	mov    DWORD PTR [eax+0xb0],edx
		}

		/* we now have a working mapping */
		struct ahci_hba* h = d->ressources[5].mmio.mapping;
    38fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    38fe:	8b 80 b0 00 00 00    	mov    eax,DWORD PTR [eax+0xb0]
    3904:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		struct ahci_device* ad = kzalloc(sizeof(*ad));
    3907:	83 ec 0c             	sub    esp,0xc
    390a:	68 30 06 00 00       	push   0x630
    390f:	e8 fc ff ff ff       	call   3910 <ahci_device_init+0x269>
    3914:	83 c4 10             	add    esp,0x10
    3917:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		if (!ad)
    391a:	83 7d bc 00          	cmp    DWORD PTR [ebp-0x44],0x0
    391e:	75 0a                	jne    392a <ahci_device_init+0x283>
				return -ENOMEM;
    3920:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3925:	e9 8e 05 00 00       	jmp    3eb8 <ahci_device_init+0x811>

		/* check for AE (access to other registers is disallowed before) */
		if (!(h->control & GHC_CNT_AE)) {
    392a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    392d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3930:	85 c0                	test   eax,eax
    3932:	78 23                	js     3957 <ahci_device_init+0x2b0>
				abprintf("switching to AHCI mode\n");
    3934:	83 ec 0c             	sub    esp,0xc
    3937:	68 5c 0a 00 00       	push   0xa5c
    393c:	e8 fc ff ff ff       	call   393d <ahci_device_init+0x296>
    3941:	83 c4 10             	add    esp,0x10
				h->control |= GHC_CNT_AE;
    3944:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3947:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    394a:	0d 00 00 00 80       	or     eax,0x80000000
    394f:	89 c2                	mov    edx,eax
    3951:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3954:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		}

		/* fill the descriptors */
		ad->ptr = h; /* D2H is set but masked */
    3957:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    395a:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    395d:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		ad->dev = d;
    3960:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3963:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    3966:	89 10                	mov    DWORD PTR [eax],edx
		ad->num_ports = min(h->cap.num_ports + 1, bsr(h->ports));
    3968:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    396b:	8b 00                	mov    eax,DWORD PTR [eax]
    396d:	83 e0 1f             	and    eax,0x1f
    3970:	0f b6 c0             	movzx  eax,al
    3973:	8d 58 01             	lea    ebx,[eax+0x1]
    3976:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3979:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    397c:	83 ec 0c             	sub    esp,0xc
    397f:	50                   	push   eax
    3980:	e8 7b c6 ff ff       	call   0 <bsr>
    3985:	83 c4 10             	add    esp,0x10
    3988:	39 c3                	cmp    ebx,eax
    398a:	7d 10                	jge    399c <ahci_device_init+0x2f5>
    398c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    398f:	8b 00                	mov    eax,DWORD PTR [eax]
    3991:	83 e0 1f             	and    eax,0x1f
    3994:	0f b6 c0             	movzx  eax,al
    3997:	8d 50 01             	lea    edx,[eax+0x1]
    399a:	eb 14                	jmp    39b0 <ahci_device_init+0x309>
    399c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    399f:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    39a2:	83 ec 0c             	sub    esp,0xc
    39a5:	50                   	push   eax
    39a6:	e8 55 c6 ff ff       	call   0 <bsr>
    39ab:	83 c4 10             	add    esp,0x10
    39ae:	89 c2                	mov    edx,eax
    39b0:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    39b3:	66 89 50 08          	mov    WORD PTR [eax+0x8],dx
		ad->num_cmd = h->cap.num_cmd + 1;
    39b7:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    39ba:	8b 00                	mov    eax,DWORD PTR [eax]
    39bc:	c1 e8 08             	shr    eax,0x8
    39bf:	83 e0 1f             	and    eax,0x1f
    39c2:	0f b6 c0             	movzx  eax,al
    39c5:	8d 50 01             	lea    edx,[eax+0x1]
    39c8:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    39cb:	66 89 50 0a          	mov    WORD PTR [eax+0xa],dx
		for (int i = 0; i < 32; i++) {
    39cf:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    39d6:	e9 fa 00 00 00       	jmp    3ad5 <ahci_device_init+0x42e>
				ad->pending_cmds[i] = LIST_HEAD_INIT(ad->pending_cmds[i]);
    39db:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    39de:	89 d0                	mov    eax,edx
    39e0:	01 c0                	add    eax,eax
    39e2:	01 d0                	add    eax,edx
    39e4:	c1 e0 02             	shl    eax,0x2
    39e7:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    39ed:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    39f0:	8d 1c 02             	lea    ebx,[edx+eax*1]
    39f3:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    39f6:	89 d0                	mov    eax,edx
    39f8:	01 c0                	add    eax,eax
    39fa:	01 d0                	add    eax,edx
    39fc:	c1 e0 02             	shl    eax,0x2
    39ff:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    3a05:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3a08:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3a0b:	8b 75 bc             	mov    esi,DWORD PTR [ebp-0x44]
    3a0e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3a11:	89 d0                	mov    eax,edx
    3a13:	01 c0                	add    eax,eax
    3a15:	01 d0                	add    eax,edx
    3a17:	c1 e0 02             	shl    eax,0x2
    3a1a:	01 f0                	add    eax,esi
    3a1c:	05 10 03 00 00       	add    eax,0x310
    3a21:	89 18                	mov    DWORD PTR [eax],ebx
    3a23:	8b 5d bc             	mov    ebx,DWORD PTR [ebp-0x44]
    3a26:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3a29:	89 d0                	mov    eax,edx
    3a2b:	01 c0                	add    eax,eax
    3a2d:	01 d0                	add    eax,edx
    3a2f:	c1 e0 02             	shl    eax,0x2
    3a32:	01 d8                	add    eax,ebx
    3a34:	05 14 03 00 00       	add    eax,0x314
    3a39:	89 08                	mov    DWORD PTR [eax],ecx
    3a3b:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3a3e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3a41:	89 d0                	mov    eax,edx
    3a43:	01 c0                	add    eax,eax
    3a45:	01 d0                	add    eax,edx
    3a47:	c1 e0 02             	shl    eax,0x2
    3a4a:	01 c8                	add    eax,ecx
    3a4c:	05 18 03 00 00       	add    eax,0x318
    3a51:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
				ad->proc_cmds[i] = LIST_HEAD_INIT(ad->proc_cmds[i]);
    3a56:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3a59:	89 d0                	mov    eax,edx
    3a5b:	01 c0                	add    eax,eax
    3a5d:	01 d0                	add    eax,edx
    3a5f:	c1 e0 02             	shl    eax,0x2
    3a62:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    3a68:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3a6b:	8d 1c 02             	lea    ebx,[edx+eax*1]
    3a6e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3a71:	89 d0                	mov    eax,edx
    3a73:	01 c0                	add    eax,eax
    3a75:	01 d0                	add    eax,edx
    3a77:	c1 e0 02             	shl    eax,0x2
    3a7a:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    3a80:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3a83:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3a86:	8b 75 bc             	mov    esi,DWORD PTR [ebp-0x44]
    3a89:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3a8c:	89 d0                	mov    eax,edx
    3a8e:	01 c0                	add    eax,eax
    3a90:	01 d0                	add    eax,edx
    3a92:	c1 e0 02             	shl    eax,0x2
    3a95:	01 f0                	add    eax,esi
    3a97:	05 90 04 00 00       	add    eax,0x490
    3a9c:	89 18                	mov    DWORD PTR [eax],ebx
    3a9e:	8b 5d bc             	mov    ebx,DWORD PTR [ebp-0x44]
    3aa1:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3aa4:	89 d0                	mov    eax,edx
    3aa6:	01 c0                	add    eax,eax
    3aa8:	01 d0                	add    eax,edx
    3aaa:	c1 e0 02             	shl    eax,0x2
    3aad:	01 d8                	add    eax,ebx
    3aaf:	05 94 04 00 00       	add    eax,0x494
    3ab4:	89 08                	mov    DWORD PTR [eax],ecx
    3ab6:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3ab9:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3abc:	89 d0                	mov    eax,edx
    3abe:	01 c0                	add    eax,eax
    3ac0:	01 d0                	add    eax,edx
    3ac2:	c1 e0 02             	shl    eax,0x2
    3ac5:	01 c8                	add    eax,ecx
    3ac7:	05 98 04 00 00       	add    eax,0x498
    3acc:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
		for (int i = 0; i < 32; i++) {
    3ad1:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    3ad5:	83 7d e0 1f          	cmp    DWORD PTR [ebp-0x20],0x1f
    3ad9:	0f 8e fc fe ff ff    	jle    39db <ahci_device_init+0x334>
		}
		ad->ctxs = LIST_HEAD_INIT(ad->ctxs);
    3adf:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3ae2:	8d 88 14 06 00 00    	lea    ecx,[eax+0x614]
    3ae8:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3aeb:	8d 90 14 06 00 00    	lea    edx,[eax+0x614]
    3af1:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3af4:	89 88 14 06 00 00    	mov    DWORD PTR [eax+0x614],ecx
    3afa:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3afd:	89 90 18 06 00 00    	mov    DWORD PTR [eax+0x618],edx
    3b03:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b06:	66 c7 80 1c 06 00 00 00 00 	mov    WORD PTR [eax+0x61c],0x0
		ad->wh = WAIT_QUEUE_HEAD(ad->wh);
    3b0f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b12:	8d 88 20 06 00 00    	lea    ecx,[eax+0x620]
    3b18:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b1b:	8d 90 20 06 00 00    	lea    edx,[eax+0x620]
    3b21:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b24:	89 88 20 06 00 00    	mov    DWORD PTR [eax+0x620],ecx
    3b2a:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b2d:	89 90 24 06 00 00    	mov    DWORD PTR [eax+0x624],edx
    3b33:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b36:	66 c7 80 28 06 00 00 00 00 	mov    WORD PTR [eax+0x628],0x0
    3b3f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b42:	c7 80 2c 06 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x62c],0x0

#ifdef AHCIBABBLE /* Tell the world about it */
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    3b4c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3b4f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3b52:	0f b6 c8             	movzx  ecx,al
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    3b55:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3b58:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3b5b:	c1 e8 08             	shr    eax,0x8
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3b5e:	0f b6 d0             	movzx  edx,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    3b61:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3b64:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3b67:	c1 e8 10             	shr    eax,0x10
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3b6a:	0f b6 c0             	movzx  eax,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    3b6d:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    3b70:	8b 5b 10             	mov    ebx,DWORD PTR [ebx+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3b73:	c1 eb 18             	shr    ebx,0x18
    3b76:	83 ec 0c             	sub    esp,0xc
    3b79:	51                   	push   ecx
    3b7a:	52                   	push   edx
    3b7b:	50                   	push   eax
    3b7c:	53                   	push   ebx
    3b7d:	68 74 0a 00 00       	push   0xa74
    3b82:	e8 fc ff ff ff       	call   3b83 <ahci_device_init+0x4dc>
    3b87:	83 c4 20             	add    esp,0x20
		/* and print the capablilities */
		printf("Features: %s%s%sspeed: %s\n",
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
				capstr(h->cap.if_speed, 4, "res", "1.5 Gbps", "3 Gbps", "6Gbps", ">6Gbps"));
    3b8a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3b8d:	8b 00                	mov    eax,DWORD PTR [eax]
    3b8f:	c1 e8 14             	shr    eax,0x14
    3b92:	83 e0 0f             	and    eax,0xf
		printf("Features: %s%s%sspeed: %s\n",
    3b95:	0f b6 c0             	movzx  eax,al
    3b98:	83 ec 04             	sub    esp,0x4
    3b9b:	68 9e 0a 00 00       	push   0xa9e
    3ba0:	68 a5 0a 00 00       	push   0xaa5
    3ba5:	68 ab 0a 00 00       	push   0xaab
    3baa:	68 b2 0a 00 00       	push   0xab2
    3baf:	68 bb 0a 00 00       	push   0xabb
    3bb4:	6a 04                	push   0x4
    3bb6:	50                   	push   eax
    3bb7:	e8 fc ff ff ff       	call   3bb8 <ahci_device_init+0x511>
    3bbc:	83 c4 20             	add    esp,0x20
    3bbf:	89 c7                	mov    edi,eax
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
    3bc1:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3bc4:	8b 00                	mov    eax,DWORD PTR [eax]
    3bc6:	c1 e8 1f             	shr    eax,0x1f
		printf("Features: %s%s%sspeed: %s\n",
    3bc9:	0f b6 c0             	movzx  eax,al
    3bcc:	68 bf 0a 00 00       	push   0xabf
    3bd1:	68 c8 0a 00 00       	push   0xac8
    3bd6:	6a 01                	push   0x1
    3bd8:	50                   	push   eax
    3bd9:	e8 fc ff ff ff       	call   3bda <ahci_device_init+0x533>
    3bde:	83 c4 10             	add    esp,0x10
    3be1:	89 c6                	mov    esi,eax
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
    3be3:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3be6:	8b 00                	mov    eax,DWORD PTR [eax]
    3be8:	c1 e8 12             	shr    eax,0x12
    3beb:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    3bee:	0f b6 c0             	movzx  eax,al
    3bf1:	68 d1 0a 00 00       	push   0xad1
    3bf6:	68 dd 0a 00 00       	push   0xadd
    3bfb:	6a 01                	push   0x1
    3bfd:	50                   	push   eax
    3bfe:	e8 fc ff ff ff       	call   3bff <ahci_device_init+0x558>
    3c03:	83 c4 10             	add    esp,0x10
    3c06:	89 c3                	mov    ebx,eax
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
    3c08:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3c0b:	8b 00                	mov    eax,DWORD PTR [eax]
    3c0d:	c1 e8 1e             	shr    eax,0x1e
    3c10:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    3c13:	0f b6 c0             	movzx  eax,al
    3c16:	68 ee 0a 00 00       	push   0xaee
    3c1b:	68 ff 02 00 00       	push   0x2ff
    3c20:	6a 01                	push   0x1
    3c22:	50                   	push   eax
    3c23:	e8 fc ff ff ff       	call   3c24 <ahci_device_init+0x57d>
    3c28:	83 c4 10             	add    esp,0x10
    3c2b:	83 ec 0c             	sub    esp,0xc
    3c2e:	57                   	push   edi
    3c2f:	56                   	push   esi
    3c30:	53                   	push   ebx
    3c31:	50                   	push   eax
    3c32:	68 f4 0a 00 00       	push   0xaf4
    3c37:	e8 fc ff ff ff       	call   3c38 <ahci_device_init+0x591>
    3c3c:	83 c4 20             	add    esp,0x20
		printf("AHCI HBA has %u ports and %u command slots\n",
				ad->num_ports, ad->num_cmd);
    3c3f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c42:	0f b7 40 0a          	movzx  eax,WORD PTR [eax+0xa]
		printf("AHCI HBA has %u ports and %u command slots\n",
    3c46:	0f b7 d0             	movzx  edx,ax
				ad->num_ports, ad->num_cmd);
    3c49:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c4c:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
		printf("AHCI HBA has %u ports and %u command slots\n",
    3c50:	0f b7 c0             	movzx  eax,ax
    3c53:	83 ec 04             	sub    esp,0x4
    3c56:	52                   	push   edx
    3c57:	50                   	push   eax
    3c58:	68 10 0b 00 00       	push   0xb10
    3c5d:	e8 fc ff ff ff       	call   3c5e <ahci_device_init+0x5b7>
    3c62:	83 c4 10             	add    esp,0x10
#endif

		/* transfer ownership (incl NMI) */
		if (h->cap2.boh) {
    3c65:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3c68:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    3c6b:	83 e0 01             	and    eax,0x1
    3c6e:	84 c0                	test   al,al
    3c70:	74 2d                	je     3c9f <ahci_device_init+0x5f8>
				rv = ahci_do_bohc(ad);
    3c72:	83 ec 0c             	sub    esp,0xc
    3c75:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3c78:	e8 fc ff ff ff       	call   3c79 <ahci_device_init+0x5d2>
    3c7d:	83 c4 10             	add    esp,0x10
    3c80:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				if (rv) {
    3c83:	83 7d b8 00          	cmp    DWORD PTR [ebp-0x48],0x0
    3c87:	74 16                	je     3c9f <ahci_device_init+0x5f8>
						kfree(ad);
    3c89:	83 ec 0c             	sub    esp,0xc
    3c8c:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3c8f:	e8 fc ff ff ff       	call   3c90 <ahci_device_init+0x5e9>
    3c94:	83 c4 10             	add    esp,0x10
						return rv;
    3c97:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3c9a:	e9 19 02 00 00       	jmp    3eb8 <ahci_device_init+0x811>
				}
		}

		/* disable every possible interrupt */
		if(pci_disable_interrupts(d))
    3c9f:	83 ec 0c             	sub    esp,0xc
    3ca2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3ca5:	e8 fc ff ff ff       	call   3ca6 <ahci_device_init+0x5ff>
    3caa:	83 c4 10             	add    esp,0x10
    3cad:	85 c0                	test   eax,eax
    3caf:	74 2b                	je     3cdc <ahci_device_init+0x635>
				die("not possible!\n");
    3cb1:	83 ec 08             	sub    esp,0x8
    3cb4:	68 3c 0b 00 00       	push   0xb3c
    3cb9:	6a 0c                	push   0xc
    3cbb:	e8 fc ff ff ff       	call   3cbc <ahci_device_init+0x615>
    3cc0:	83 c4 10             	add    esp,0x10
    3cc3:	e8 fc ff ff ff       	call   3cc4 <ahci_device_init+0x61d>
    3cc8:	83 ec 0c             	sub    esp,0xc
    3ccb:	68 00 00 00 00       	push   0x0
    3cd0:	e8 fc ff ff ff       	call   3cd1 <ahci_device_init+0x62a>
    3cd5:	83 c4 10             	add    esp,0x10
    3cd8:	fa                   	cli
    3cd9:	f4                   	hlt
    3cda:	eb fd                	jmp    3cd9 <ahci_device_init+0x632>

		/* Stop the running ports */
		for (int i = 0; i < ad->num_ports; i++)
    3cdc:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    3ce3:	eb 15                	jmp    3cfa <ahci_device_init+0x653>
				ahci_stop_port(ad, i);
    3ce5:	83 ec 08             	sub    esp,0x8
    3ce8:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    3ceb:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3cee:	e8 fc ff ff ff       	call   3cef <ahci_device_init+0x648>
    3cf3:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < ad->num_ports; i++)
    3cf6:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    3cfa:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3cfd:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3d01:	0f b7 c0             	movzx  eax,ax
    3d04:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
    3d07:	7c dc                	jl     3ce5 <ahci_device_init+0x63e>

		/* clear all interrupts and install the handler */
		ahci_clear_interrupts(ad); /* PCI disabled MSI and we're currently */
    3d09:	83 ec 0c             	sub    esp,0xc
    3d0c:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3d0f:	e8 fc ff ff ff       	call   3d10 <ahci_device_init+0x669>
    3d14:	83 c4 10             	add    esp,0x10
		install_irq_handler(ad->dev->intr_line, ahci_irq); /* not using it */
    3d17:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3d1a:	8b 00                	mov    eax,DWORD PTR [eax]
    3d1c:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    3d20:	0f b6 c0             	movzx  eax,al
    3d23:	83 ec 08             	sub    esp,0x8
    3d26:	68 00 00 00 00       	push   0x0
    3d2b:	50                   	push   eax
    3d2c:	e8 fc ff ff ff       	call   3d2d <ahci_device_init+0x686>
    3d31:	83 c4 10             	add    esp,0x10
		/* TODO: do proper assigment */

		/* assign the command lists and the FIS buffers */
		ahci_assign_buffers(ad);
    3d34:	83 ec 0c             	sub    esp,0xc
    3d37:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3d3a:	e8 fc ff ff ff       	call   3d3b <ahci_device_init+0x694>
    3d3f:	83 c4 10             	add    esp,0x10

		/* print them */
		for (int i = 0; i < ad->num_ports; i++) {
    3d42:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    3d49:	e9 95 00 00 00       	jmp    3de3 <ahci_device_init+0x73c>
				printf("port%d: %016llx %016llx %p %p\n", i,
    3d4e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3d51:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3d54:	83 c2 20             	add    edx,0x20
    3d57:	8b 7c 90 0c          	mov    edi,DWORD PTR [eax+edx*4+0xc]
    3d5b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3d5e:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3d61:	8b 74 90 0c          	mov    esi,DWORD PTR [eax+edx*4+0xc]
						ad->ptr->port[i].pXclb64,
						ad->ptr->port[i].pXfb64,
    3d65:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3d68:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("port%d: %016llx %016llx %p %p\n", i,
    3d6b:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3d6e:	83 c2 02             	add    edx,0x2
    3d71:	c1 e2 07             	shl    edx,0x7
    3d74:	01 d0                	add    eax,edx
    3d76:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    3d79:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
						ad->ptr->port[i].pXclb64,
    3d7c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3d7f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("port%d: %016llx %016llx %p %p\n", i,
    3d82:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3d85:	83 c2 02             	add    edx,0x2
    3d88:	c1 e2 07             	shl    edx,0x7
    3d8b:	01 d0                	add    eax,edx
    3d8d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3d90:	8b 00                	mov    eax,DWORD PTR [eax]
    3d92:	57                   	push   edi
    3d93:	56                   	push   esi
    3d94:	53                   	push   ebx
    3d95:	51                   	push   ecx
    3d96:	52                   	push   edx
    3d97:	50                   	push   eax
    3d98:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    3d9b:	68 4c 0b 00 00       	push   0xb4c
    3da0:	e8 fc ff ff ff       	call   3da1 <ahci_device_init+0x6fa>
    3da5:	83 c4 20             	add    esp,0x20
						ad->command_lists[i],
						ad->recv_fis[i]);
				printf("       %016llx %p\n", ad->identify_data[i].pm,
    3da8:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3dab:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3dae:	83 c2 10             	add    edx,0x10
    3db1:	c1 e2 04             	shl    edx,0x4
    3db4:	01 d0                	add    eax,edx
    3db6:	83 c0 10             	add    eax,0x10
    3db9:	8b 08                	mov    ecx,DWORD PTR [eax]
    3dbb:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3dbe:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3dc1:	83 c2 10             	add    edx,0x10
    3dc4:	c1 e2 04             	shl    edx,0x4
    3dc7:	01 d0                	add    eax,edx
    3dc9:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    3dcc:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    3dcf:	51                   	push   ecx
    3dd0:	52                   	push   edx
    3dd1:	50                   	push   eax
    3dd2:	68 6b 0b 00 00       	push   0xb6b
    3dd7:	e8 fc ff ff ff       	call   3dd8 <ahci_device_init+0x731>
    3ddc:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < ad->num_ports; i++) {
    3ddf:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    3de3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3de6:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3dea:	0f b7 c0             	movzx  eax,ax
    3ded:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    3df0:	0f 8c 58 ff ff ff    	jl     3d4e <ahci_device_init+0x6a7>
						ad->identify_data[i].ptr);
		}

		/* allow the device to write to our memory */
		pci_set_master(d);
    3df6:	83 ec 0c             	sub    esp,0xc
    3df9:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3dfc:	e8 fc ff ff ff       	call   3dfd <ahci_device_init+0x756>
    3e01:	83 c4 10             	add    esp,0x10

		/* reenable the ports */
		for (int i = 0; i < ad->num_ports; i++)
    3e04:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    3e0b:	eb 15                	jmp    3e22 <ahci_device_init+0x77b>
				ahci_enable_port(ad, i);
    3e0d:	83 ec 08             	sub    esp,0x8
    3e10:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    3e13:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3e16:	e8 fc ff ff ff       	call   3e17 <ahci_device_init+0x770>
    3e1b:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < ad->num_ports; i++)
    3e1e:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
    3e22:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3e25:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3e29:	0f b7 c0             	movzx  eax,ax
    3e2c:	39 45 d4             	cmp    DWORD PTR [ebp-0x2c],eax
    3e2f:	7c dc                	jl     3e0d <ahci_device_init+0x766>

		/* add the device to the list */
		struct ale* le = kzalloc(sizeof(*le));
    3e31:	83 ec 0c             	sub    esp,0xc
    3e34:	6a 10                	push   0x10
    3e36:	e8 fc ff ff ff       	call   3e37 <ahci_device_init+0x790>
    3e3b:	83 c4 10             	add    esp,0x10
    3e3e:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
		le->dev = ad;
    3e41:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3e44:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    3e47:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		list_add_tail(&le->devs, &ahci_dl.devs);
    3e4a:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3e4d:	83 ec 08             	sub    esp,0x8
    3e50:	68 00 00 00 00       	push   0x0
    3e55:	50                   	push   eax
    3e56:	e8 7a c2 ff ff       	call   d5 <list_add_tail>
    3e5b:	83 c4 10             	add    esp,0x10

		/* allocate the pool */
		ad->ctbl_pool = ahci_allocate_command_table_pool(
				32, 8, h->cap.is_64bit);
    3e5e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3e61:	8b 00                	mov    eax,DWORD PTR [eax]
    3e63:	c1 e8 1f             	shr    eax,0x1f
		ad->ctbl_pool = ahci_allocate_command_table_pool(
    3e66:	0f b6 c0             	movzx  eax,al
    3e69:	83 ec 04             	sub    esp,0x4
    3e6c:	50                   	push   eax
    3e6d:	6a 08                	push   0x8
    3e6f:	6a 20                	push   0x20
    3e71:	e8 fc ff ff ff       	call   3e72 <ahci_device_init+0x7cb>
    3e76:	83 c4 10             	add    esp,0x10
    3e79:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    3e7c:	89 82 0c 03 00 00    	mov    DWORD PTR [edx+0x30c],eax

		/* launch the worker */
		task_spawn(ahci_worker, ad, PRIORITY_ELEVATED);
    3e82:	68 7e 0b 00 00       	push   0xb7e
    3e87:	6a 01                	push   0x1
    3e89:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    3e8c:	68 00 00 00 00       	push   0x0
    3e91:	e8 fc ff ff ff       	call   3e92 <ahci_device_init+0x7eb>
    3e96:	83 c4 10             	add    esp,0x10

		/* reenable interrupts */
		/* The port_enable function already set the per-port values */
		h->ctrl.ie = 1;
    3e99:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    3e9c:	8b 42 04             	mov    eax,DWORD PTR [edx+0x4]
    3e9f:	83 c8 02             	or     eax,0x2
    3ea2:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
		pci_enable_interrupts(d);
    3ea5:	83 ec 0c             	sub    esp,0xc
    3ea8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3eab:	e8 fc ff ff ff       	call   3eac <ahci_device_init+0x805>
    3eb0:	83 c4 10             	add    esp,0x10

		return 0;
    3eb3:	b8 00 00 00 00       	mov    eax,0x0
}
    3eb8:	8d 65 f4             	lea    esp,[ebp-0xc]
    3ebb:	5b                   	pop    ebx
    3ebc:	5e                   	pop    esi
    3ebd:	5f                   	pop    edi
    3ebe:	5d                   	pop    ebp
    3ebf:	c3                   	ret

00003ec0 <module_init>:

int MODENTRY module_init()
{
    3ec0:	55                   	push   ebp
    3ec1:	89 e5                	mov    ebp,esp
    3ec3:	83 ec 28             	sub    esp,0x28
		printf("AHCI initialization...\n");
    3ec6:	83 ec 0c             	sub    esp,0xc
    3ec9:	68 8a 0b 00 00       	push   0xb8a
    3ece:	e8 fc ff ff ff       	call   3ecf <module_init+0xf>
    3ed3:	83 c4 10             	add    esp,0x10
		struct pci_device* dev; int ct = 0, nc = 0, nf = 0;
    3ed6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    3edd:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    3ee4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    3eeb:	e9 89 00 00 00       	jmp    3f79 <module_init+0xb9>
				int rv;
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
						dev->addr.device_no, dev->addr.func_no);
    3ef0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3ef3:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    3ef7:	83 e0 07             	and    eax,0x7
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    3efa:	0f b6 c8             	movzx  ecx,al
						dev->addr.device_no, dev->addr.func_no);
    3efd:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3f00:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    3f04:	c0 e8 03             	shr    al,0x3
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    3f07:	0f b6 d0             	movzx  edx,al
    3f0a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3f0d:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
    3f11:	0f b6 c0             	movzx  eax,al
    3f14:	51                   	push   ecx
    3f15:	52                   	push   edx
    3f16:	50                   	push   eax
    3f17:	68 a4 0b 00 00       	push   0xba4
    3f1c:	e8 fc ff ff ff       	call   3f1d <module_init+0x5d>
    3f21:	83 c4 10             	add    esp,0x10
				printf("Attempting initialization...\n");
    3f24:	83 ec 0c             	sub    esp,0xc
    3f27:	68 c7 0b 00 00       	push   0xbc7
    3f2c:	e8 fc ff ff ff       	call   3f2d <module_init+0x6d>
    3f31:	83 c4 10             	add    esp,0x10
				rv = ahci_device_init(dev);
    3f34:	83 ec 0c             	sub    esp,0xc
    3f37:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    3f3a:	e8 fc ff ff ff       	call   3f3b <module_init+0x7b>
    3f3f:	83 c4 10             	add    esp,0x10
    3f42:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (rv) {
    3f45:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    3f49:	74 18                	je     3f63 <module_init+0xa3>
						cprintf(KFMT_ERROR, "Initialization of this device failed.\n");
    3f4b:	83 ec 08             	sub    esp,0x8
    3f4e:	68 e8 0b 00 00       	push   0xbe8
    3f53:	6a 0c                	push   0xc
    3f55:	e8 fc ff ff ff       	call   3f56 <module_init+0x96>
    3f5a:	83 c4 10             	add    esp,0x10
						nf++;
    3f5d:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    3f61:	eb 16                	jmp    3f79 <module_init+0xb9>
				} else {
						cprintf(KFMT_OK, "Initialization of AHCI HBA succeeded.\n");
    3f63:	83 ec 08             	sub    esp,0x8
    3f66:	68 10 0c 00 00       	push   0xc10
    3f6b:	6a 0a                	push   0xa
    3f6d:	e8 fc ff ff ff       	call   3f6e <module_init+0xae>
    3f72:	83 c4 10             	add    esp,0x10
						nc++;
    3f75:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    3f79:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3f7c:	8d 50 01             	lea    edx,[eax+0x1]
    3f7f:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    3f82:	50                   	push   eax
    3f83:	6a 01                	push   0x1
    3f85:	6a 06                	push   0x6
    3f87:	6a 01                	push   0x1
    3f89:	e8 fc ff ff ff       	call   3f8a <module_init+0xca>
    3f8e:	83 c4 10             	add    esp,0x10
    3f91:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    3f94:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    3f98:	0f 85 52 ff ff ff    	jne    3ef0 <module_init+0x30>
				}
		}
		/* Summary */
		cprintf(nf ? KFMT_WARN : KFMT_OK, "Initialized %d AHCI Host Bus Adapters. (%d failed)\n", nc, nf);
    3f9e:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    3fa2:	74 07                	je     3fab <module_init+0xeb>
    3fa4:	b8 0e 00 00 00       	mov    eax,0xe
    3fa9:	eb 05                	jmp    3fb0 <module_init+0xf0>
    3fab:	b8 0a 00 00 00       	mov    eax,0xa
    3fb0:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    3fb3:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    3fb6:	68 38 0c 00 00       	push   0xc38
    3fbb:	50                   	push   eax
    3fbc:	e8 fc ff ff ff       	call   3fbd <module_init+0xfd>
    3fc1:	83 c4 10             	add    esp,0x10
		return 0;
    3fc4:	b8 00 00 00 00       	mov    eax,0x0
}
    3fc9:	c9                   	leave
    3fca:	c3                   	ret

00003fcb <module_cleanup>:

void MODENTRY module_cleanup()
{
    3fcb:	55                   	push   ebp
    3fcc:	89 e5                	mov    ebp,esp
}
    3fce:	90                   	nop
    3fcf:	5d                   	pop    ebp
    3fd0:	c3                   	ret
