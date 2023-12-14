
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
      93:	83 ec 18             	sub    esp,0x18
				return;
      96:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      99:	83 c0 08             	add    eax,0x8
      9c:	89 04 24             	mov    DWORD PTR [esp],eax
      9f:	e8 fc ff ff ff       	call   a0 <list_add+0x10>
		}
      a4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      a7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
      aa:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
      ae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
      b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b8:	89 04 24             	mov    DWORD PTR [esp],eax
      bb:	e8 74 ff ff ff       	call   34 <__list_add>

      c0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      c3:	83 c0 08             	add    eax,0x8
      c6:	89 04 24             	mov    DWORD PTR [esp],eax
      c9:	e8 fc ff ff ff       	call   ca <list_add+0x3a>
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
      ce:	90                   	nop
      cf:	c9                   	leave
      d0:	c3                   	ret

000000d1 <list_add_tail>:
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
		/* now build the command */
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
      d1:	55                   	push   ebp
      d2:	89 e5                	mov    ebp,esp
      d4:	83 ec 18             	sub    esp,0x18
		if (p->cmd.atapi) { /* ATAPI */
      d7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      da:	83 c0 08             	add    eax,0x8
      dd:	89 04 24             	mov    DWORD PTR [esp],eax
      e0:	e8 fc ff ff ff       	call   e1 <list_add_tail+0x10>
				switch (cc->c) {
      e5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      e8:	8b 00                	mov    eax,DWORD PTR [eax]
      ea:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      ed:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
      f1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
      f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      f8:	89 04 24             	mov    DWORD PTR [esp],eax
      fb:	e8 34 ff ff ff       	call   34 <__list_add>
						case disk_cmd_identify:
     100:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     103:	83 c0 08             	add    eax,0x8
     106:	89 04 24             	mov    DWORD PTR [esp],eax
     109:	e8 fc ff ff ff       	call   10a <list_add_tail+0x39>
								rv = atapi_build_packet_device_identify(ad, cc);
     10e:	90                   	nop
     10f:	c9                   	leave
     110:	c3                   	ret

00000111 <list_del>:
								break;
						case disk_cmd_read:
						case disk_cmd_write:
     111:	55                   	push   ebp
     112:	89 e5                	mov    ebp,esp
     114:	83 ec 18             	sub    esp,0x18
						case disk_cmd_trim:
     117:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     11a:	83 c0 08             	add    eax,0x8
     11d:	89 04 24             	mov    DWORD PTR [esp],eax
     120:	e8 fc ff ff ff       	call   121 <list_del+0x10>
								die("not implemented yet!\n");
     125:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     128:	89 04 24             	mov    DWORD PTR [esp],eax
     12b:	e8 2c ff ff ff       	call   5c <__list_del>
								break;
     130:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     133:	83 c0 08             	add    eax,0x8
     136:	89 04 24             	mov    DWORD PTR [esp],eax
     139:	e8 fc ff ff ff       	call   13a <list_del+0x29>
						default:
     13e:	90                   	nop
     13f:	c9                   	leave
     140:	c3                   	ret

00000141 <list_empty>:
								die("The command %x should not end up here.\n", cc->c);
								break;
				}
     141:	55                   	push   ebp
     142:	89 e5                	mov    ebp,esp
		} else {
     144:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     147:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     14a:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     14d:	0f 94 c0             	sete   al
     150:	0f b6 c0             	movzx  eax,al
				switch (cc->c) { /* ATA */
     153:	5d                   	pop    ebp
     154:	c3                   	ret

00000155 <checksum_memory>:
				}

		//		/* print the STATUS */
		//		cprintf(KFMT_WARN, "STATUS: diag=%x err=%x cmd=%x clb=%x\n",
		//						p->scr1.diag, p->scr1.err, p->pXcmd, p->pXclb);

     155:	55                   	push   ebp
     156:	89 e5                	mov    ebp,esp
     158:	83 ec 10             	sub    esp,0x10
				/* and tell the IH about it */
     15b:	c6 45 ff 00          	mov    BYTE PTR [ebp-0x1],0x0
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
     15f:	eb 0f                	jmp    170 <checksum_memory+0x1b>
				abprintf("issued the command successfully.\n");
     161:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     164:	8d 50 01             	lea    edx,[eax+0x1]
     167:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
     16a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     16d:	00 45 ff             	add    BYTE PTR [ebp-0x1],al
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
     170:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     173:	8d 50 ff             	lea    edx,[eax-0x1]
     176:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     179:	85 c0                	test   eax,eax
     17b:	75 e4                	jne    161 <checksum_memory+0xc>
		} else {
     17d:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
				/* slot became used: parallel access to
     181:	c9                   	leave
     182:	c3                   	ret

00000183 <convert_ata_string>:
		uint16_t checksum_validity : 8; /* 0xa5 */
		uint16_t checksum : 8; /* sum of all bytes incl. -> 0 */
} __attribute__ ((packed));

static inline void convert_ata_string(uint16_t* str, size_t len)
{
     183:	55                   	push   ebp
     184:	89 e5                	mov    ebp,esp
     186:	83 ec 10             	sub    esp,0x10
		size_t i; char* s = (char*)str;
     189:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     18c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		for (i = 0; i < len; i++) /* xchg ah, al */
     18f:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     196:	eb 3b                	jmp    1d3 <convert_ata_string+0x50>
				str[i] = ((str[i] >> 8) | (str[i] << 8));
     198:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     19b:	8d 14 00             	lea    edx,[eax+eax*1]
     19e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1a1:	01 d0                	add    eax,edx
     1a3:	0f b7 00             	movzx  eax,WORD PTR [eax]
     1a6:	66 c1 e8 08          	shr    ax,0x8
     1aa:	89 c1                	mov    ecx,eax
     1ac:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1af:	8d 14 00             	lea    edx,[eax+eax*1]
     1b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1b5:	01 d0                	add    eax,edx
     1b7:	0f b7 00             	movzx  eax,WORD PTR [eax]
     1ba:	c1 e0 08             	shl    eax,0x8
     1bd:	09 c1                	or     ecx,eax
     1bf:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1c2:	8d 14 00             	lea    edx,[eax+eax*1]
     1c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1c8:	01 d0                	add    eax,edx
     1ca:	89 ca                	mov    edx,ecx
     1cc:	66 89 10             	mov    WORD PTR [eax],dx
		for (i = 0; i < len; i++) /* xchg ah, al */
     1cf:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     1d3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1d6:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     1d9:	72 bd                	jb     198 <convert_ata_string+0x15>
		/* possibly null terminate by eliminating spaces */
		i = 2 * i - 1;
     1db:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1de:	01 c0                	add    eax,eax
     1e0:	83 e8 01             	sub    eax,0x1
     1e3:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while (i && s[i] == ' ')
     1e6:	eb 04                	jmp    1ec <convert_ata_string+0x69>
				i--;
     1e8:	83 6d fc 01          	sub    DWORD PTR [ebp-0x4],0x1
		while (i && s[i] == ' ')
     1ec:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     1f0:	74 0f                	je     201 <convert_ata_string+0x7e>
     1f2:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
     1f5:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1f8:	01 d0                	add    eax,edx
     1fa:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     1fd:	3c 20                	cmp    al,0x20
     1ff:	74 e7                	je     1e8 <convert_ata_string+0x65>
		if (i + 1 < len)
     201:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     204:	83 c0 01             	add    eax,0x1
     207:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     20a:	73 0e                	jae    21a <convert_ata_string+0x97>
				s[i + 1] = '\0';
     20c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     20f:	8d 50 01             	lea    edx,[eax+0x1]
     212:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     215:	01 d0                	add    eax,edx
     217:	c6 00 00             	mov    BYTE PTR [eax],0x0
}
     21a:	90                   	nop
     21b:	c9                   	leave
     21c:	c3                   	ret

0000021d <ata_build_device_identify>:
{
     21d:	55                   	push   ebp
     21e:	89 e5                	mov    ebp,esp
     220:	53                   	push   ebx
     221:	83 ec 44             	sub    esp,0x44
		struct ahci_cmdtbl* t = ctx->entry->ptr;
     224:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     227:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     22a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     22d:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		struct sata_reg_h2d* r = &t->cfis.rh2d;
     230:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     233:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
     236:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     239:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     23c:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     23f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     246:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		uint16_t bc1 = 512, bc2 = 0;
     24d:	66 c7 45 e6 00 02    	mov    WORD PTR [ebp-0x1a],0x200
     253:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
		if (ctx->max_prdtl < 1)
     259:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     25c:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     25f:	85 c0                	test   eax,eax
     261:	75 0a                	jne    26d <ata_build_device_identify+0x50>
				return -1;
     263:	b8 ff ff ff ff       	mov    eax,0xffffffff
     268:	e9 b7 03 00 00       	jmp    624 <ata_build_device_identify+0x407>
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
     26d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     270:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     273:	83 c0 08             	add    eax,0x8
     276:	c1 e0 04             	shl    eax,0x4
     279:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     27d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     280:	89 04 24             	mov    DWORD PTR [esp],eax
     283:	e8 fc ff ff ff       	call   284 <ata_build_device_identify+0x67>
		r->fis_type = FIS_REG_H2D;
     288:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     28b:	c6 00 27             	mov    BYTE PTR [eax],0x27
		r->pm_port = ctx->pmprt;
     28e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     291:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     295:	83 e0 0f             	and    eax,0xf
     298:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     29b:	83 e0 0f             	and    eax,0xf
     29e:	89 c1                	mov    ecx,eax
     2a0:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     2a4:	83 e0 f0             	and    eax,0xfffffff0
     2a7:	09 c8                	or     eax,ecx
     2a9:	88 42 01             	mov    BYTE PTR [edx+0x1],al
		r->res0 = 0;
     2ac:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2af:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     2b3:	83 e2 8f             	and    edx,0xffffff8f
     2b6:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->c = 1;
     2b9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2bc:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     2c0:	83 ca 80             	or     edx,0xffffff80
     2c3:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->command = ATA_CMD_IDENTIFY_DEVICE;
     2c6:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2c9:	c6 40 02 ec          	mov    BYTE PTR [eax+0x2],0xec
		r->feat_high = r->feat_low = 0; /* N/A */
     2cd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2d0:	c6 40 03 00          	mov    BYTE PTR [eax+0x3],0x0
     2d4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2d7:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
     2db:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2de:	88 50 0b             	mov    BYTE PTR [eax+0xb],dl
		r->lba_high = r->lba_low = 0; /* N/A */
     2e1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     2e4:	0f b6 50 04          	movzx  edx,BYTE PTR [eax+0x4]
     2e8:	83 e2 00             	and    edx,0x0
     2eb:	88 50 04             	mov    BYTE PTR [eax+0x4],dl
     2ee:	0f b6 50 05          	movzx  edx,BYTE PTR [eax+0x5]
     2f2:	83 e2 00             	and    edx,0x0
     2f5:	88 50 05             	mov    BYTE PTR [eax+0x5],dl
     2f8:	0f b6 50 06          	movzx  edx,BYTE PTR [eax+0x6]
     2fc:	83 e2 00             	and    edx,0x0
     2ff:	88 50 06             	mov    BYTE PTR [eax+0x6],dl
     302:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     305:	0f b6 50 04          	movzx  edx,BYTE PTR [eax+0x4]
     309:	0f b6 48 05          	movzx  ecx,BYTE PTR [eax+0x5]
     30d:	c1 e1 08             	shl    ecx,0x8
     310:	09 ca                	or     edx,ecx
     312:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
     316:	c1 e0 10             	shl    eax,0x10
     319:	09 d0                	or     eax,edx
     31b:	89 c2                	mov    edx,eax
     31d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     320:	0f b6 da             	movzx  ebx,dl
     323:	0f b6 48 08          	movzx  ecx,BYTE PTR [eax+0x8]
     327:	83 e1 00             	and    ecx,0x0
     32a:	09 d9                	or     ecx,ebx
     32c:	88 48 08             	mov    BYTE PTR [eax+0x8],cl
     32f:	89 d1                	mov    ecx,edx
     331:	c1 e9 08             	shr    ecx,0x8
     334:	0f b6 d9             	movzx  ebx,cl
     337:	0f b6 48 09          	movzx  ecx,BYTE PTR [eax+0x9]
     33b:	83 e1 00             	and    ecx,0x0
     33e:	09 d9                	or     ecx,ebx
     340:	88 48 09             	mov    BYTE PTR [eax+0x9],cl
     343:	c1 ea 10             	shr    edx,0x10
     346:	0f b6 ca             	movzx  ecx,dl
     349:	0f b6 50 0a          	movzx  edx,BYTE PTR [eax+0xa]
     34d:	83 e2 00             	and    edx,0x0
     350:	09 ca                	or     edx,ecx
     352:	88 50 0a             	mov    BYTE PTR [eax+0xa],dl
		r->count = 0; /* N/A */
     355:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     358:	66 c7 40 0c 00 00    	mov    WORD PTR [eax+0xc],0x0
		r->device = 0; /* bit4 is transport dependent */
     35e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     361:	c6 40 07 00          	mov    BYTE PTR [eax+0x7],0x0
		r->icc = 0;
     365:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     368:	c6 40 0e 00          	mov    BYTE PTR [eax+0xe],0x0
		r->control = 0;
     36c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     36f:	c6 40 0f 00          	mov    BYTE PTR [eax+0xf],0x0
		r->res1 = 0;
     373:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     376:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		if (!ptr) {
     37d:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
     381:	75 47                	jne    3ca <ata_build_device_identify+0x1ad>
				ptr = ad->identify_data[ctx->entry->port].ptr;
     383:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     386:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     389:	0f b7 00             	movzx  eax,WORD PTR [eax]
     38c:	0f b7 d0             	movzx  edx,ax
     38f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     392:	83 c2 10             	add    edx,0x10
     395:	c1 e2 04             	shl    edx,0x4
     398:	01 d0                	add    eax,edx
     39a:	83 c0 10             	add    eax,0x10
     39d:	8b 00                	mov    eax,DWORD PTR [eax]
     39f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				b1 = ad->identify_data[ctx->entry->port].pm;
     3a2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3a5:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     3a8:	0f b7 00             	movzx  eax,WORD PTR [eax]
     3ab:	0f b7 d0             	movzx  edx,ax
     3ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b1:	83 c2 10             	add    edx,0x10
     3b4:	c1 e2 04             	shl    edx,0x4
     3b7:	01 d0                	add    eax,edx
     3b9:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     3bc:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     3bf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     3c2:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     3c5:	e9 b1 00 00 00       	jmp    47b <ata_build_device_identify+0x25e>
				size_t ofs = (size_t)ptr % 4096;
     3ca:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     3cd:	25 ff 0f 00 00       	and    eax,0xfff
     3d2:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				b1 = mm_page_get_pmem(&mm_kernel, ptr);
     3d5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     3d8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     3dc:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     3e3:	e8 fc ff ff ff       	call   3e4 <ata_build_device_identify+0x1c7>
     3e8:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     3eb:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
				if (4096 - ofs < 512) { /* across pages */
     3ee:	b8 00 10 00 00       	mov    eax,0x1000
     3f3:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     3f6:	3d ff 01 00 00       	cmp    eax,0x1ff
     3fb:	77 70                	ja     46d <ata_build_device_identify+0x250>
						bc1 = 4096 - ofs;
     3fd:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     400:	89 c2                	mov    edx,eax
     402:	b8 00 10 00 00       	mov    eax,0x1000
     407:	29 d0                	sub    eax,edx
     409:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
						bc2 = 512 - (4096 - ofs);
     40d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     410:	66 2d 00 0e          	sub    ax,0xe00
     414:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
						b2 = mm_page_get_pmem(&mm_kernel, ptr + bc1);
     418:	0f b7 55 e6          	movzx  edx,WORD PTR [ebp-0x1a]
     41c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     41f:	01 d0                	add    eax,edx
     421:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     425:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     42c:	e8 fc ff ff ff       	call   42d <ata_build_device_identify+0x210>
     431:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     434:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
						if (b2 == b1 + 4096) {
     437:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     43a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     43d:	05 00 10 00 00       	add    eax,0x1000
     442:	83 d2 00             	adc    edx,0x0
     445:	89 c1                	mov    ecx,eax
     447:	89 c8                	mov    eax,ecx
     449:	33 45 e8             	xor    eax,DWORD PTR [ebp-0x18]
     44c:	33 55 ec             	xor    edx,DWORD PTR [ebp-0x14]
     44f:	09 d0                	or     eax,edx
     451:	75 1a                	jne    46d <ata_build_device_identify+0x250>
								bc1 = 512; bc2 = 0;
     453:	66 c7 45 e6 00 02    	mov    WORD PTR [ebp-0x1a],0x200
     459:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
								b2 = 0;
     45f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     466:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				b1 += ofs;
     46d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     470:	ba 00 00 00 00       	mov    edx,0x0
     475:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
     478:	11 55 f4             	adc    DWORD PTR [ebp-0xc],edx
		abprintf("IDENTIFY: %016llx %p\n", ctx->entry->pmem, t);
     47b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     47e:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     481:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     484:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     487:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     48a:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     48e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     492:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     496:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     49d:	e8 fc ff ff ff       	call   49e <ata_build_device_identify+0x281>
		abprintf("b1: %016llx\n", b1);
     4a2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     4a5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     4a8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     4ac:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     4b0:	c7 04 24 16 00 00 00 	mov    DWORD PTR [esp],0x16
     4b7:	e8 fc ff ff ff       	call   4b8 <ata_build_device_identify+0x29b>
		t->prdts[0].dba64 = b1;
     4bc:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     4bf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     4c2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     4c5:	89 81 80 00 00 00    	mov    DWORD PTR [ecx+0x80],eax
     4cb:	89 91 84 00 00 00    	mov    DWORD PTR [ecx+0x84],edx
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
     4d1:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     4d5:	83 e8 01             	sub    eax,0x1
     4d8:	25 ff ff 3f 00       	and    eax,0x3fffff
     4dd:	89 c2                	mov    edx,eax
     4df:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     4e2:	89 d1                	mov    ecx,edx
     4e4:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     4ea:	8b 90 8c 00 00 00    	mov    edx,DWORD PTR [eax+0x8c]
     4f0:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     4f6:	09 ca                	or     edx,ecx
     4f8:	89 90 8c 00 00 00    	mov    DWORD PTR [eax+0x8c],edx
		t->prdts[0].I = 1; /* interrupt on completion */
     4fe:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     501:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [eax+0x8f]
     508:	83 ca 80             	or     edx,0xffffff80
     50b:	88 90 8f 00 00 00    	mov    BYTE PTR [eax+0x8f],dl
		if (b2) {
     511:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     514:	0b 45 ec             	or     eax,DWORD PTR [ebp-0x14]
     517:	74 7d                	je     596 <ata_build_device_identify+0x379>
				if (ctx->max_prdtl < 2)
     519:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     51c:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     51f:	83 f8 01             	cmp    eax,0x1
     522:	77 0a                	ja     52e <ata_build_device_identify+0x311>
						return -1; /* TODO: word alignment */
     524:	b8 ff ff ff ff       	mov    eax,0xffffffff
     529:	e9 f6 00 00 00       	jmp    624 <ata_build_device_identify+0x407>
				t->prdts[1].dba64 = b2;
     52e:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     531:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     534:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     537:	89 81 90 00 00 00    	mov    DWORD PTR [ecx+0x90],eax
     53d:	89 91 94 00 00 00    	mov    DWORD PTR [ecx+0x94],edx
				t->prdts[1].dbc = bc2 - 1; /* IDENTIFY returns 512bt */
     543:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     547:	83 e8 01             	sub    eax,0x1
     54a:	25 ff ff 3f 00       	and    eax,0x3fffff
     54f:	89 c2                	mov    edx,eax
     551:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     554:	89 d1                	mov    ecx,edx
     556:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     55c:	8b 90 9c 00 00 00    	mov    edx,DWORD PTR [eax+0x9c]
     562:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     568:	09 ca                	or     edx,ecx
     56a:	89 90 9c 00 00 00    	mov    DWORD PTR [eax+0x9c],edx
				t->prdts[1].I = 1; /* interrupt on completion */
     570:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     573:	0f b6 90 9f 00 00 00 	movzx  edx,BYTE PTR [eax+0x9f]
     57a:	83 ca 80             	or     edx,0xffffff80
     57d:	88 90 9f 00 00 00    	mov    BYTE PTR [eax+0x9f],dl
				t->prdts[0].I = 0; /* not too early */
     583:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     586:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [eax+0x8f]
     58d:	83 e2 7f             	and    edx,0x7f
     590:	88 90 8f 00 00 00    	mov    BYTE PTR [eax+0x8f],dl
		ctx->clh.prdtl = b2 ? 2 : 1;
     596:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     599:	0b 45 ec             	or     eax,DWORD PTR [ebp-0x14]
     59c:	74 07                	je     5a5 <ata_build_device_identify+0x388>
     59e:	ba 02 00 00 00       	mov    edx,0x2
     5a3:	eb 05                	jmp    5aa <ata_build_device_identify+0x38d>
     5a5:	ba 01 00 00 00       	mov    edx,0x1
     5aa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5ad:	66 89 50 44          	mov    WORD PTR [eax+0x44],dx
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
     5b1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5b4:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     5b8:	c1 e0 0c             	shl    eax,0xc
     5bb:	66 0d 05 04          	or     ax,0x405
     5bf:	89 c2                	mov    edx,eax
     5c1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5c4:	66 89 50 46          	mov    WORD PTR [eax+0x46],dx
		ctx->cont_ctx = NULL;
     5c8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5cb:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
		ctx->cur_buf = NULL;
     5d2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5d5:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
		ctx->bts_left = 0;
     5dc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5df:	c7 40 3c 00 00 00 00 	mov    DWORD PTR [eax+0x3c],0x0
     5e6:	c7 40 40 00 00 00 00 	mov    DWORD PTR [eax+0x40],0x0
		if (ctx->status) {
     5ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5f0:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     5f3:	85 c0                	test   eax,eax
     5f5:	74 28                	je     61f <ata_build_device_identify+0x402>
				ctx->status->bts_cur = 0;
     5f7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5fa:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     5fd:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
     604:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
				ctx->status->bts_left = 512; /* bts_left in ctx is internal */
     60b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     60e:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     611:	c7 40 08 00 02 00 00 	mov    DWORD PTR [eax+0x8],0x200
     618:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		return 0;
     61f:	b8 00 00 00 00       	mov    eax,0x0
}
     624:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     627:	c9                   	leave
     628:	c3                   	ret

00000629 <atapi_build_packet_device_identify>:
{
     629:	55                   	push   ebp
     62a:	89 e5                	mov    ebp,esp
     62c:	83 ec 18             	sub    esp,0x18
		printf("ATAPI IDENTIFY PACKET DEVICE %p %p\n", ad, ctx);
     62f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     632:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     636:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     639:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     63d:	c7 04 24 24 00 00 00 	mov    DWORD PTR [esp],0x24
     644:	e8 fc ff ff ff       	call   645 <atapi_build_packet_device_identify+0x1c>
		return -1;
     649:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     64e:	c9                   	leave
     64f:	c3                   	ret

00000650 <ata_build_read_dma_ext>:
{
     650:	55                   	push   ebp
     651:	89 e5                	mov    ebp,esp
     653:	53                   	push   ebx
     654:	83 ec 44             	sub    esp,0x44
		struct ahci_cmdtbl* t = ctx->entry->ptr;
     657:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     65a:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     65d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     660:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct sata_reg_h2d* r = &t->cfis.rh2d;
     663:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     666:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
     669:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     66c:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     66f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     672:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     679:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		uint16_t bc1 = 512, bc2 = 0;
     680:	66 c7 45 de 00 02    	mov    WORD PTR [ebp-0x22],0x200
     686:	66 c7 45 dc 00 00    	mov    WORD PTR [ebp-0x24],0x0
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
     68c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     68f:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
     692:	83 c0 08             	add    eax,0x8
     695:	c1 e0 04             	shl    eax,0x4
     698:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     69c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     69f:	89 04 24             	mov    DWORD PTR [esp],eax
     6a2:	e8 fc ff ff ff       	call   6a3 <ata_build_read_dma_ext+0x53>
		r->fis_type = FIS_REG_H2D;
     6a7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6aa:	c6 00 27             	mov    BYTE PTR [eax],0x27
		r->pm_port = ctx->pmprt;
     6ad:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6b0:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     6b4:	83 e0 0f             	and    eax,0xf
     6b7:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     6ba:	83 e0 0f             	and    eax,0xf
     6bd:	89 c1                	mov    ecx,eax
     6bf:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     6c3:	83 e0 f0             	and    eax,0xfffffff0
     6c6:	09 c8                	or     eax,ecx
     6c8:	88 42 01             	mov    BYTE PTR [edx+0x1],al
		r->res0 = 0;
     6cb:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6ce:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     6d2:	83 e2 8f             	and    edx,0xffffff8f
     6d5:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->c = 1;
     6d8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6db:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     6df:	83 ca 80             	or     edx,0xffffff80
     6e2:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
		r->command = ATA_CMD_READ_DMA_EXT;
     6e5:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6e8:	c6 40 02 25          	mov    BYTE PTR [eax+0x2],0x25
		r->feat_high = r->feat_low = 0; /* reserved */
     6ec:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6ef:	c6 40 03 00          	mov    BYTE PTR [eax+0x3],0x0
     6f3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6f6:	0f b6 50 03          	movzx  edx,BYTE PTR [eax+0x3]
     6fa:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6fd:	88 50 0b             	mov    BYTE PTR [eax+0xb],dl
		r->lba_high = (uint32_t)((ctx->lba >> 24) & 0x00ffffff);
     700:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     703:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     706:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     709:	0f ac d0 18          	shrd   eax,edx,0x18
     70d:	c1 ea 18             	shr    edx,0x18
     710:	89 c2                	mov    edx,eax
     712:	81 e2 ff ff ff 00    	and    edx,0xffffff
     718:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     71b:	0f b6 da             	movzx  ebx,dl
     71e:	0f b6 48 08          	movzx  ecx,BYTE PTR [eax+0x8]
     722:	83 e1 00             	and    ecx,0x0
     725:	09 d9                	or     ecx,ebx
     727:	88 48 08             	mov    BYTE PTR [eax+0x8],cl
     72a:	89 d1                	mov    ecx,edx
     72c:	c1 e9 08             	shr    ecx,0x8
     72f:	0f b6 d9             	movzx  ebx,cl
     732:	0f b6 48 09          	movzx  ecx,BYTE PTR [eax+0x9]
     736:	83 e1 00             	and    ecx,0x0
     739:	09 d9                	or     ecx,ebx
     73b:	88 48 09             	mov    BYTE PTR [eax+0x9],cl
     73e:	c1 ea 10             	shr    edx,0x10
     741:	0f b6 ca             	movzx  ecx,dl
     744:	0f b6 50 0a          	movzx  edx,BYTE PTR [eax+0xa]
     748:	83 e2 00             	and    edx,0x0
     74b:	09 ca                	or     edx,ecx
     74d:	88 50 0a             	mov    BYTE PTR [eax+0xa],dl
		r->lba_low = (uint32_t)(ctx->lba & 0x00ffffff);
     750:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     753:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     756:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     759:	89 c2                	mov    edx,eax
     75b:	81 e2 ff ff ff 00    	and    edx,0xffffff
     761:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     764:	0f b6 da             	movzx  ebx,dl
     767:	0f b6 48 04          	movzx  ecx,BYTE PTR [eax+0x4]
     76b:	83 e1 00             	and    ecx,0x0
     76e:	09 d9                	or     ecx,ebx
     770:	88 48 04             	mov    BYTE PTR [eax+0x4],cl
     773:	89 d1                	mov    ecx,edx
     775:	c1 e9 08             	shr    ecx,0x8
     778:	0f b6 d9             	movzx  ebx,cl
     77b:	0f b6 48 05          	movzx  ecx,BYTE PTR [eax+0x5]
     77f:	83 e1 00             	and    ecx,0x0
     782:	09 d9                	or     ecx,ebx
     784:	88 48 05             	mov    BYTE PTR [eax+0x5],cl
     787:	c1 ea 10             	shr    edx,0x10
     78a:	0f b6 ca             	movzx  ecx,dl
     78d:	0f b6 50 06          	movzx  edx,BYTE PTR [eax+0x6]
     791:	83 e2 00             	and    edx,0x0
     794:	09 ca                	or     edx,ecx
     796:	88 50 06             	mov    BYTE PTR [eax+0x6],dl
		r->count = 1/*ctx->ct / 512*/; /* log sector count (first identify )*/
     799:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     79c:	66 c7 40 0c 01 00    	mov    WORD PTR [eax+0xc],0x1
		r->device = (1 << 6); /* bit6 shall be set to one */
     7a2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7a5:	c6 40 07 40          	mov    BYTE PTR [eax+0x7],0x40
		r->icc = 0;
     7a9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7ac:	c6 40 0e 00          	mov    BYTE PTR [eax+0xe],0x0
		r->control = 0;
     7b0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7b3:	c6 40 0f 00          	mov    BYTE PTR [eax+0xf],0x0
		r->res1 = 0;
     7b7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7ba:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		if (!ptr) {
     7c1:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     7c5:	0f 85 29 01 00 00    	jne    8f4 <ata_build_read_dma_ext+0x2a4>
				ptr = ad->identify_data[ctx->entry->port].ptr;
     7cb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7ce:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     7d1:	0f b7 00             	movzx  eax,WORD PTR [eax]
     7d4:	0f b7 d0             	movzx  edx,ax
     7d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7da:	83 c2 10             	add    edx,0x10
     7dd:	c1 e2 04             	shl    edx,0x4
     7e0:	01 d0                	add    eax,edx
     7e2:	83 c0 10             	add    eax,0x10
     7e5:	8b 00                	mov    eax,DWORD PTR [eax]
     7e7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				b1 = ad->identify_data[ctx->entry->port].pm;
     7ea:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7ed:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     7f0:	0f b7 00             	movzx  eax,WORD PTR [eax]
     7f3:	0f b7 d0             	movzx  edx,ax
     7f6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7f9:	83 c2 10             	add    edx,0x10
     7fc:	c1 e2 04             	shl    edx,0x4
     7ff:	01 d0                	add    eax,edx
     801:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     804:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     807:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     80a:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		abprintf("READ DMA EXT: %016llx %p\n", ctx->entry->pmem, t);
     80d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     810:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     813:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     816:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     819:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     81c:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     820:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     824:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     828:	c7 04 24 58 00 00 00 	mov    DWORD PTR [esp],0x58
     82f:	e8 fc ff ff ff       	call   830 <ata_build_read_dma_ext+0x1e0>
		abprintf("b1: %016llx\n", b1);
     834:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     837:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     83a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     83e:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     842:	c7 04 24 16 00 00 00 	mov    DWORD PTR [esp],0x16
     849:	e8 fc ff ff ff       	call   84a <ata_build_read_dma_ext+0x1fa>
		t->prdts[0].dba64 = b1;
     84e:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     851:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     854:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     857:	89 81 80 00 00 00    	mov    DWORD PTR [ecx+0x80],eax
     85d:	89 91 84 00 00 00    	mov    DWORD PTR [ecx+0x84],edx
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
     863:	0f b7 45 de          	movzx  eax,WORD PTR [ebp-0x22]
     867:	83 e8 01             	sub    eax,0x1
     86a:	25 ff ff 3f 00       	and    eax,0x3fffff
     86f:	89 c2                	mov    edx,eax
     871:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     874:	89 d1                	mov    ecx,edx
     876:	81 e1 ff ff 3f 00    	and    ecx,0x3fffff
     87c:	8b 90 8c 00 00 00    	mov    edx,DWORD PTR [eax+0x8c]
     882:	81 e2 00 00 c0 ff    	and    edx,0xffc00000
     888:	09 ca                	or     edx,ecx
     88a:	89 90 8c 00 00 00    	mov    DWORD PTR [eax+0x8c],edx
		t->prdts[0].I = 1; /* interrupt on completion */
     890:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     893:	0f b6 90 8f 00 00 00 	movzx  edx,BYTE PTR [eax+0x8f]
     89a:	83 ca 80             	or     edx,0xffffff80
     89d:	88 90 8f 00 00 00    	mov    BYTE PTR [eax+0x8f],dl
		ctx->clh.prdtl = 1;
     8a3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8a6:	66 c7 40 44 01 00    	mov    WORD PTR [eax+0x44],0x1
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
     8ac:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8af:	0f b7 40 24          	movzx  eax,WORD PTR [eax+0x24]
     8b3:	c1 e0 0c             	shl    eax,0xc
     8b6:	66 0d 05 04          	or     ax,0x405
     8ba:	89 c2                	mov    edx,eax
     8bc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8bf:	66 89 50 46          	mov    WORD PTR [eax+0x46],dx
		ctx->cont_ctx = NULL;
     8c3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8c6:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
		ctx->cur_buf = NULL;
     8cd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8d0:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
		ctx->bts_left = 0;
     8d7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8da:	c7 40 3c 00 00 00 00 	mov    DWORD PTR [eax+0x3c],0x0
     8e1:	c7 40 40 00 00 00 00 	mov    DWORD PTR [eax+0x40],0x0
		if (ctx->status) {
     8e8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8eb:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     8ee:	85 c0                	test   eax,eax
     8f0:	74 54                	je     946 <ata_build_read_dma_ext+0x2f6>
     8f2:	eb 29                	jmp    91d <ata_build_read_dma_ext+0x2cd>
				die("not there yet!\n");
     8f4:	c7 44 24 04 48 00 00 00 	mov    DWORD PTR [esp+0x4],0x48
     8fc:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     903:	e8 fc ff ff ff       	call   904 <ata_build_read_dma_ext+0x2b4>
     908:	e8 fc ff ff ff       	call   909 <ata_build_read_dma_ext+0x2b9>
     90d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     914:	e8 fc ff ff ff       	call   915 <ata_build_read_dma_ext+0x2c5>
     919:	fa                   	cli
     91a:	f4                   	hlt
     91b:	eb fd                	jmp    91a <ata_build_read_dma_ext+0x2ca>
				ctx->status->bts_left = 122123;
     91d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     920:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     923:	c7 40 08 0b dd 01 00 	mov    DWORD PTR [eax+0x8],0x1dd0b
     92a:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
				ctx->status->bts_cur = bc2;
     931:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     934:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     937:	0f b7 45 dc          	movzx  eax,WORD PTR [ebp-0x24]
     93b:	ba 00 00 00 00       	mov    edx,0x0
     940:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
     943:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
		return 0;
     946:	b8 00 00 00 00       	mov    eax,0x0
}
     94b:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     94e:	c9                   	leave
     94f:	c3                   	ret

00000950 <capstr>:
{
     950:	55                   	push   ebp
     951:	89 e5                	mov    ebp,esp
     953:	83 ec 10             	sub    esp,0x10
		const char** rv = (const char**)(&limit + 1);
     956:	8d 45 0c             	lea    eax,[ebp+0xc]
     959:	83 c0 04             	add    eax,0x4
     95c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return rv[min(idx, limit)];
     95f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     962:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     965:	7d 08                	jge    96f <capstr+0x1f>
     967:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     96a:	c1 e0 02             	shl    eax,0x2
     96d:	eb 06                	jmp    975 <capstr+0x25>
     96f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     972:	c1 e0 02             	shl    eax,0x2
     975:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     978:	01 d0                	add    eax,edx
     97a:	8b 00                	mov    eax,DWORD PTR [eax]
}
     97c:	c9                   	leave
     97d:	c3                   	ret

0000097e <ahci_allocate_context>:
{
     97e:	55                   	push   ebp
     97f:	89 e5                	mov    ebp,esp
     981:	83 ec 28             	sub    esp,0x28
		rv = list_cut_first_entry(&ad->ctxs, struct cmd_ctx, lst);
     984:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     987:	05 14 06 00 00       	add    eax,0x614
     98c:	89 04 24             	mov    DWORD PTR [esp],eax
     98f:	e8 ad f7 ff ff       	call   141 <list_empty>
     994:	85 c0                	test   eax,eax
     996:	75 60                	jne    9f8 <ahci_allocate_context+0x7a>
     998:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     99b:	05 1c 06 00 00       	add    eax,0x61c
     9a0:	89 04 24             	mov    DWORD PTR [esp],eax
     9a3:	e8 fc ff ff ff       	call   9a4 <ahci_allocate_context+0x26>
     9a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9ab:	05 14 06 00 00       	add    eax,0x614
     9b0:	89 04 24             	mov    DWORD PTR [esp],eax
     9b3:	e8 89 f7 ff ff       	call   141 <list_empty>
     9b8:	85 c0                	test   eax,eax
     9ba:	75 11                	jne    9cd <ahci_allocate_context+0x4f>
     9bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9bf:	8b 80 18 06 00 00    	mov    eax,DWORD PTR [eax+0x618]
     9c5:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     9c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     9cb:	eb 05                	jmp    9d2 <ahci_allocate_context+0x54>
     9cd:	b8 00 00 00 00       	mov    eax,0x0
     9d2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     9d5:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     9d9:	74 0b                	je     9e6 <ahci_allocate_context+0x68>
     9db:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9de:	89 04 24             	mov    DWORD PTR [esp],eax
     9e1:	e8 76 f6 ff ff       	call   5c <__list_del>
     9e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9e9:	05 1c 06 00 00       	add    eax,0x61c
     9ee:	89 04 24             	mov    DWORD PTR [esp],eax
     9f1:	e8 fc ff ff ff       	call   9f2 <ahci_allocate_context+0x74>
     9f6:	eb 07                	jmp    9ff <ahci_allocate_context+0x81>
     9f8:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     9ff:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a02:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv)
     a05:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     a09:	75 0f                	jne    a1a <ahci_allocate_context+0x9c>
				rv = kzalloc(sizeof(*rv));
     a0b:	c7 04 24 50 00 00 00 	mov    DWORD PTR [esp],0x50
     a12:	e8 fc ff ff ff       	call   a13 <ahci_allocate_context+0x95>
     a17:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return rv;
     a1a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     a1d:	c9                   	leave
     a1e:	c3                   	ret

00000a1f <ahci_destroy_context>:
{
     a1f:	55                   	push   ebp
     a20:	89 e5                	mov    ebp,esp
     a22:	83 ec 18             	sub    esp,0x18
		bzero(cc, sizeof(*cc));
     a25:	c7 44 24 04 50 00 00 00 	mov    DWORD PTR [esp+0x4],0x50
     a2d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a30:	89 04 24             	mov    DWORD PTR [esp],eax
     a33:	e8 fc ff ff ff       	call   a34 <ahci_destroy_context+0x15>
		list_add_tail(&cc->lst, &ad->ctxs);
     a38:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a3b:	8d 90 14 06 00 00    	lea    edx,[eax+0x614]
     a41:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a44:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     a48:	89 04 24             	mov    DWORD PTR [esp],eax
     a4b:	e8 81 f6 ff ff       	call   d1 <list_add_tail>
}
     a50:	90                   	nop
     a51:	c9                   	leave
     a52:	c3                   	ret

00000a53 <ahci_handle_command_error>:
{
     a53:	55                   	push   ebp
     a54:	89 e5                	mov    ebp,esp
     a56:	83 ec 18             	sub    esp,0x18
		if (cc->c == disk_cmd_identify) {
     a59:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a5c:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     a5f:	85 c0                	test   eax,eax
     a61:	75 07                	jne    a6a <ahci_handle_command_error+0x17>
				return -1;
     a63:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a68:	eb 33                	jmp    a9d <ahci_handle_command_error+0x4a>
				if (cc->status)
     a6a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a6d:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     a70:	85 c0                	test   eax,eax
     a72:	74 0c                	je     a80 <ahci_handle_command_error+0x2d>
						cc->status->state = cmd_state_abort;
     a74:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a77:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     a7a:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				if (cc->wq_wake)
     a80:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a83:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     a86:	85 c0                	test   eax,eax
     a88:	74 0e                	je     a98 <ahci_handle_command_error+0x45>
						wake_up_external_event(cc->wq_wake);
     a8a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a8d:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     a90:	89 04 24             	mov    DWORD PTR [esp],eax
     a93:	e8 fc ff ff ff       	call   a94 <ahci_handle_command_error+0x41>
				return -1;
     a98:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     a9d:	c9                   	leave
     a9e:	c3                   	ret

00000a9f <ahci_port_handle_tfes_regular>:
{
     a9f:	55                   	push   ebp
     aa0:	89 e5                	mov    ebp,esp
     aa2:	83 ec 58             	sub    esp,0x58
		uint32_t ci = p->pXci; /* all pending commands */
     aa5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     aa8:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
     aab:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		uint16_t slt = p->cmd.ccs; /* the offending one */
     aae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ab1:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     ab4:	c1 e8 08             	shr    eax,0x8
     ab7:	83 e0 1f             	and    eax,0x1f
     aba:	0f b6 c0             	movzx  eax,al
     abd:	66 89 45 ee          	mov    WORD PTR [ebp-0x12],ax
		p->cmd.st = 0;
     ac1:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     ac4:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
     ac7:	83 e0 fe             	and    eax,0xfffffffe
     aca:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		abiprintf("slot which caused task file error: %u\n", slt);
     acd:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     ad1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     ad5:	c7 04 24 74 00 00 00 	mov    DWORD PTR [esp],0x74
     adc:	e8 fc ff ff ff       	call   add <ahci_port_handle_tfes_regular+0x3e>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     ae1:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     ae4:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     ae7:	89 d0                	mov    eax,edx
     ae9:	01 c0                	add    eax,eax
     aeb:	01 d0                	add    eax,edx
     aed:	c1 e0 02             	shl    eax,0x2
     af0:	01 c8                	add    eax,ecx
     af2:	05 94 04 00 00       	add    eax,0x494
     af7:	8b 00                	mov    eax,DWORD PTR [eax]
     af9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     afc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     aff:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     b02:	e9 75 01 00 00       	jmp    c7c <ahci_port_handle_tfes_regular+0x1dd>
				struct cmd_ctx* cc = cc2; /* we're clearing the list */
     b07:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b0a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				list_del_and_prepare_continue(cc2, &ad->proc_cmds[pt], lst);
     b0d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b10:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     b13:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b16:	8b 00                	mov    eax,DWORD PTR [eax]
     b18:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     b1b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     b1e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     b21:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     b24:	89 d0                	mov    eax,edx
     b26:	01 c0                	add    eax,eax
     b28:	01 d0                	add    eax,edx
     b2a:	c1 e0 02             	shl    eax,0x2
     b2d:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
     b33:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b36:	01 c2                	add    edx,eax
     b38:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b3b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     b3f:	89 04 24             	mov    DWORD PTR [esp],eax
     b42:	e8 ca f5 ff ff       	call   111 <list_del>
				abiprintf("inside slt: %u\n", cc->slot);
     b47:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b4a:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     b4e:	0f b7 c0             	movzx  eax,ax
     b51:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b55:	c7 04 24 9b 00 00 00 	mov    DWORD PTR [esp],0x9b
     b5c:	e8 fc ff ff ff       	call   b5d <ahci_port_handle_tfes_regular+0xbe>
				if (cc->slot == slt) {
     b61:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b64:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     b68:	66 39 45 ee          	cmp    WORD PTR [ebp-0x12],ax
     b6c:	0f 85 a2 00 00 00    	jne    c14 <ahci_port_handle_tfes_regular+0x175>
								slt, pt, p->tfd.err, p->tfd.sts);
     b72:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b75:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     b78:	0f b6 c8             	movzx  ecx,al
								slt, pt, p->tfd.err, p->tfd.sts);
     b7b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b7e:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     b81:	0f b6 c4             	movzx  eax,ah
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
     b84:	0f b6 d0             	movzx  edx,al
     b87:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     b8b:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     b8f:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     b93:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     b96:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     b9a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b9e:	c7 04 24 ac 00 00 00 	mov    DWORD PTR [esp],0xac
     ba5:	e8 fc ff ff ff       	call   ba6 <ahci_port_handle_tfes_regular+0x107>
						if (-1 == ahci_handle_command_error(ad, cc, p->pXtfd)) {
     baa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     bad:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     bb0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     bb4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     bb7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     bbb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bbe:	89 04 24             	mov    DWORD PTR [esp],eax
     bc1:	e8 fc ff ff ff       	call   bc2 <ahci_port_handle_tfes_regular+0x123>
     bc6:	83 f8 ff             	cmp    eax,0xffffffff
     bc9:	75 29                	jne    bf4 <ahci_port_handle_tfes_regular+0x155>
								ahci_release_cmdtbl(ad, cc->entry);
     bcb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     bce:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     bd1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     bd5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bd8:	89 04 24             	mov    DWORD PTR [esp],eax
     bdb:	e8 fc ff ff ff       	call   bdc <ahci_port_handle_tfes_regular+0x13d>
								ahci_destroy_context(ad, cc);
     be0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     be3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     be7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bea:	89 04 24             	mov    DWORD PTR [esp],eax
     bed:	e8 fc ff ff ff       	call   bee <ahci_port_handle_tfes_regular+0x14f>
     bf2:	eb 79                	jmp    c6d <ahci_port_handle_tfes_regular+0x1ce>
								abiprintf("command reissued.\n");
     bf4:	c7 04 24 e2 00 00 00 	mov    DWORD PTR [esp],0xe2
     bfb:	e8 fc ff ff ff       	call   bfc <ahci_port_handle_tfes_regular+0x15d>
								ahci_reissue_command(ad, cc);
     c00:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c03:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     c07:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c0a:	89 04 24             	mov    DWORD PTR [esp],eax
     c0d:	e8 fc ff ff ff       	call   c0e <ahci_port_handle_tfes_regular+0x16f>
     c12:	eb 59                	jmp    c6d <ahci_port_handle_tfes_regular+0x1ce>
						if (ci & (1 << cc->slot)) {
     c14:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c17:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     c1b:	0f b7 c0             	movzx  eax,ax
     c1e:	ba 01 00 00 00       	mov    edx,0x1
     c23:	89 c1                	mov    ecx,eax
     c25:	d3 e2                	shl    edx,cl
     c27:	89 d0                	mov    eax,edx
     c29:	23 45 f0             	and    eax,DWORD PTR [ebp-0x10]
     c2c:	85 c0                	test   eax,eax
     c2e:	74 14                	je     c44 <ahci_port_handle_tfes_regular+0x1a5>
								ahci_reissue_command(ad, cc);
     c30:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c33:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     c37:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c3a:	89 04 24             	mov    DWORD PTR [esp],eax
     c3d:	e8 fc ff ff ff       	call   c3e <ahci_port_handle_tfes_regular+0x19f>
     c42:	eb 29                	jmp    c6d <ahci_port_handle_tfes_regular+0x1ce>
								die("not implemented\n");
     c44:	c7 44 24 04 f5 00 00 00 	mov    DWORD PTR [esp+0x4],0xf5
     c4c:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     c53:	e8 fc ff ff ff       	call   c54 <ahci_port_handle_tfes_regular+0x1b5>
     c58:	e8 fc ff ff ff       	call   c59 <ahci_port_handle_tfes_regular+0x1ba>
     c5d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     c64:	e8 fc ff ff ff       	call   c65 <ahci_port_handle_tfes_regular+0x1c6>
     c69:	fa                   	cli
     c6a:	f4                   	hlt
     c6b:	eb fd                	jmp    c6a <ahci_port_handle_tfes_regular+0x1cb>
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
     c6d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c70:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     c73:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     c76:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     c79:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     c7c:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c7f:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     c82:	89 d0                	mov    eax,edx
     c84:	01 c0                	add    eax,eax
     c86:	01 d0                	add    eax,edx
     c88:	c1 e0 02             	shl    eax,0x2
     c8b:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
     c91:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c94:	01 d0                	add    eax,edx
     c96:	39 c1                	cmp    ecx,eax
     c98:	0f 85 69 fe ff ff    	jne    b07 <ahci_port_handle_tfes_regular+0x68>
		ahci_issue_command(ad, pt, 0 /* TODO: handle pmport */, host_cmd_reset,
     c9e:	c7 44 24 28 00 00 00 00 	mov    DWORD PTR [esp+0x28],0x0
     ca6:	c7 44 24 24 00 00 00 00 	mov    DWORD PTR [esp+0x24],0x0
     cae:	c7 44 24 20 00 00 00 00 	mov    DWORD PTR [esp+0x20],0x0
     cb6:	c7 44 24 18 00 00 00 00 	mov    DWORD PTR [esp+0x18],0x0
     cbe:	c7 44 24 1c 00 00 00 00 	mov    DWORD PTR [esp+0x1c],0x0
     cc6:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
     cce:	c7 44 24 14 00 00 00 00 	mov    DWORD PTR [esp+0x14],0x0
     cd6:	c7 44 24 0c 82 00 00 00 	mov    DWORD PTR [esp+0xc],0x82
     cde:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
     ce6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ce9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     ced:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cf0:	89 04 24             	mov    DWORD PTR [esp],eax
     cf3:	e8 fc ff ff ff       	call   cf4 <ahci_port_handle_tfes_regular+0x255>
}
     cf8:	90                   	nop
     cf9:	c9                   	leave
     cfa:	c3                   	ret

00000cfb <ahci_port_handle_tfes_ncq>:
{
     cfb:	55                   	push   ebp
     cfc:	89 e5                	mov    ebp,esp
     cfe:	83 ec 18             	sub    esp,0x18
		die("not implemented!\n");
     d01:	c7 44 24 04 06 01 00 00 	mov    DWORD PTR [esp+0x4],0x106
     d09:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     d10:	e8 fc ff ff ff       	call   d11 <ahci_port_handle_tfes_ncq+0x16>
     d15:	e8 fc ff ff ff       	call   d16 <ahci_port_handle_tfes_ncq+0x1b>
     d1a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     d21:	e8 fc ff ff ff       	call   d22 <ahci_port_handle_tfes_ncq+0x27>
     d26:	fa                   	cli
     d27:	f4                   	hlt
     d28:	eb fd                	jmp    d27 <ahci_port_handle_tfes_ncq+0x2c>

00000d2a <ahci_port_handle_pcs_cominit>:
{
     d2a:	55                   	push   ebp
     d2b:	89 e5                	mov    ebp,esp
     d2d:	83 ec 18             	sub    esp,0x18
		die("not implemented!\n");
     d30:	c7 44 24 04 06 01 00 00 	mov    DWORD PTR [esp+0x4],0x106
     d38:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     d3f:	e8 fc ff ff ff       	call   d40 <ahci_port_handle_pcs_cominit+0x16>
     d44:	e8 fc ff ff ff       	call   d45 <ahci_port_handle_pcs_cominit+0x1b>
     d49:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     d50:	e8 fc ff ff ff       	call   d51 <ahci_port_handle_pcs_cominit+0x27>
     d55:	fa                   	cli
     d56:	f4                   	hlt
     d57:	eb fd                	jmp    d56 <ahci_port_handle_pcs_cominit+0x2c>

00000d59 <ahci_port_check_finished_commands>:
{
     d59:	55                   	push   ebp
     d5a:	89 e5                	mov    ebp,esp
     d5c:	56                   	push   esi
     d5d:	53                   	push   ebx
     d5e:	83 ec 40             	sub    esp,0x40
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
     d61:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     d64:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     d67:	89 d0                	mov    eax,edx
     d69:	01 c0                	add    eax,eax
     d6b:	01 d0                	add    eax,edx
     d6d:	c1 e0 02             	shl    eax,0x2
     d70:	01 c8                	add    eax,ecx
     d72:	05 94 04 00 00       	add    eax,0x494
     d77:	8b 00                	mov    eax,DWORD PTR [eax]
     d79:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     d7c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d7f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     d82:	e9 9f 02 00 00       	jmp    1026 <ahci_port_check_finished_commands+0x2cd>
				if (!(ci & (1 << cc->slot))) { /* slot was cleared */
     d87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d8a:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     d8e:	0f b7 c0             	movzx  eax,ax
     d91:	ba 01 00 00 00       	mov    edx,0x1
     d96:	89 c1                	mov    ecx,eax
     d98:	d3 e2                	shl    edx,cl
     d9a:	89 d0                	mov    eax,edx
     d9c:	23 45 10             	and    eax,DWORD PTR [ebp+0x10]
     d9f:	85 c0                	test   eax,eax
     da1:	0f 85 56 02 00 00    	jne    ffd <ahci_port_check_finished_commands+0x2a4>
						uint16_t prdtl; uint32_t bc = 0, bc0 = 0;
     da7:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     dae:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
						if ((prdtl = d->command_lists[pt]->chdrs[cc->slot].prdtl)) {
     db5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     db8:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     dbb:	8b 54 90 0c          	mov    edx,DWORD PTR [eax+edx*4+0xc]
     dbf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dc2:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     dc6:	0f b7 c0             	movzx  eax,ax
     dc9:	c1 e0 05             	shl    eax,0x5
     dcc:	01 d0                	add    eax,edx
     dce:	83 c0 02             	add    eax,0x2
     dd1:	0f b7 00             	movzx  eax,WORD PTR [eax]
     dd4:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
     dd8:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     ddd:	74 50                	je     e2f <ahci_port_check_finished_commands+0xd6>
								bc0 = d->command_lists[pt]->chdrs[cc->slot].prdbc;
     ddf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     de2:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     de5:	8b 54 90 0c          	mov    edx,DWORD PTR [eax+edx*4+0xc]
     de9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dec:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     df0:	0f b7 c0             	movzx  eax,ax
     df3:	c1 e0 05             	shl    eax,0x5
     df6:	01 d0                	add    eax,edx
     df8:	83 c0 04             	add    eax,0x4
     dfb:	8b 00                	mov    eax,DWORD PTR [eax]
     dfd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								struct ahci_prdt* pr = cc->entry->ptr->prdts;
     e00:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e03:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
     e06:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     e09:	83 e8 80             	sub    eax,0xffffff80
     e0c:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								while (prdtl--)
     e0f:	eb 0e                	jmp    e1f <ahci_port_check_finished_commands+0xc6>
										bc += pr->dbc;
     e11:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     e14:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     e17:	25 ff ff 3f 00       	and    eax,0x3fffff
     e1c:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
								while (prdtl--)
     e1f:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     e23:	8d 50 ff             	lea    edx,[eax-0x1]
     e26:	66 89 55 f2          	mov    WORD PTR [ebp-0xe],dx
     e2a:	66 85 c0             	test   ax,ax
     e2d:	75 e2                	jne    e11 <ahci_port_check_finished_commands+0xb8>
						if (!cc->cont_ctx && !cc->bts_left) {
     e2f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e32:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
     e35:	85 c0                	test   eax,eax
     e37:	0f 85 12 01 00 00    	jne    f4f <ahci_port_check_finished_commands+0x1f6>
     e3d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e40:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
     e43:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     e46:	89 c1                	mov    ecx,eax
     e48:	89 c8                	mov    eax,ecx
     e4a:	09 d0                	or     eax,edx
     e4c:	0f 85 fd 00 00 00    	jne    f4f <ahci_port_check_finished_commands+0x1f6>
								if (cc->c == disk_cmd_identify) {
     e52:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e55:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     e58:	85 c0                	test   eax,eax
     e5a:	75 6d                	jne    ec9 <ahci_port_check_finished_commands+0x170>
										struct cmd_ctx* cc2 = cc;
     e5c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e5f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
										abiprintf("identify host command issued\n");
     e62:	c7 04 24 18 01 00 00 	mov    DWORD PTR [esp],0x118
     e69:	e8 fc ff ff ff       	call   e6a <ahci_port_check_finished_commands+0x111>
										cc->c = host_cmd_process_identify;
     e6e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e71:	c7 40 0c 80 00 00 00 	mov    DWORD PTR [eax+0xc],0x80
										list_del_and_prepare_continue(cc, &d->proc_cmds[pt], lst);
     e78:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e7b:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     e7e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e81:	8b 00                	mov    eax,DWORD PTR [eax]
     e83:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     e86:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     e89:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     e8c:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     e8f:	89 d0                	mov    eax,edx
     e91:	01 c0                	add    eax,eax
     e93:	01 d0                	add    eax,edx
     e95:	c1 e0 02             	shl    eax,0x2
     e98:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
     e9e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ea1:	01 c2                	add    edx,eax
     ea3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     ea6:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     eaa:	89 04 24             	mov    DWORD PTR [esp],eax
     ead:	e8 5f f2 ff ff       	call   111 <list_del>
										ahci_reissue_command(d, cc2); /* worker has to work */
     eb2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     eb5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     eb9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ebc:	89 04 24             	mov    DWORD PTR [esp],eax
     ebf:	e8 fc ff ff ff       	call   ec0 <ahci_port_check_finished_commands+0x167>
										continue;
     ec4:	e9 4e 01 00 00       	jmp    1017 <ahci_port_check_finished_commands+0x2be>
										if (cc->status) {
     ec9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ecc:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     ecf:	85 c0                	test   eax,eax
     ed1:	74 3b                	je     f0e <ahci_port_check_finished_commands+0x1b5>
												cc->status->state = cmd_state_completed;
     ed3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ed6:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     ed9:	c7 00 03 00 00 00    	mov    DWORD PTR [eax],0x3
												cc->status->bts_cur = bc;
     edf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ee2:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     ee5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ee8:	ba 00 00 00 00       	mov    edx,0x0
     eed:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
     ef0:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
												cc->status->bts_left = bc0 - bc;
     ef3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     ef6:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
     ef9:	89 c2                	mov    edx,eax
     efb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     efe:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     f01:	89 d0                	mov    eax,edx
     f03:	ba 00 00 00 00       	mov    edx,0x0
     f08:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
     f0b:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
										if (cc->wq_wake)
     f0e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f11:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     f14:	85 c0                	test   eax,eax
     f16:	74 0e                	je     f26 <ahci_port_check_finished_commands+0x1cd>
												wake_up_external_event(cc->wq_wake);
     f18:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f1b:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     f1e:	89 04 24             	mov    DWORD PTR [esp],eax
     f21:	e8 fc ff ff ff       	call   f22 <ahci_port_check_finished_commands+0x1c9>
								die("command w/o info finished.\n");
     f26:	c7 44 24 04 36 01 00 00 	mov    DWORD PTR [esp+0x4],0x136
     f2e:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     f35:	e8 fc ff ff ff       	call   f36 <ahci_port_check_finished_commands+0x1dd>
     f3a:	e8 fc ff ff ff       	call   f3b <ahci_port_check_finished_commands+0x1e2>
     f3f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     f46:	e8 fc ff ff ff       	call   f47 <ahci_port_check_finished_commands+0x1ee>
     f4b:	fa                   	cli
     f4c:	f4                   	hlt
     f4d:	eb fd                	jmp    f4c <ahci_port_check_finished_commands+0x1f3>
								if (bc0 == bc) {
     f4f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f52:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
     f55:	75 54                	jne    fab <ahci_port_check_finished_commands+0x252>
										if (cc->status) {
     f57:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f5a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     f5d:	85 c0                	test   eax,eax
     f5f:	74 73                	je     fd4 <ahci_port_check_finished_commands+0x27b>
												cc->status->bts_cur += bc;
     f61:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f64:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     f67:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     f6a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     f6d:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     f70:	bb 00 00 00 00       	mov    ebx,0x0
     f75:	8b 75 f4             	mov    esi,DWORD PTR [ebp-0xc]
     f78:	8b 76 2c             	mov    esi,DWORD PTR [esi+0x2c]
     f7b:	01 c8                	add    eax,ecx
     f7d:	11 da                	adc    edx,ebx
     f7f:	89 46 10             	mov    DWORD PTR [esi+0x10],eax
     f82:	89 56 14             	mov    DWORD PTR [esi+0x14],edx
												cc->status->bts_left -= bc;
     f85:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f88:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     f8b:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     f8e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f91:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     f94:	bb 00 00 00 00       	mov    ebx,0x0
     f99:	8b 75 f4             	mov    esi,DWORD PTR [ebp-0xc]
     f9c:	8b 76 2c             	mov    esi,DWORD PTR [esi+0x2c]
     f9f:	29 c8                	sub    eax,ecx
     fa1:	19 da                	sbb    edx,ebx
     fa3:	89 46 08             	mov    DWORD PTR [esi+0x8],eax
     fa6:	89 56 0c             	mov    DWORD PTR [esi+0xc],edx
     fa9:	eb 29                	jmp    fd4 <ahci_port_check_finished_commands+0x27b>
										die("incomplete transfer\n"); /* possible by design of intr? */
     fab:	c7 44 24 04 52 01 00 00 	mov    DWORD PTR [esp+0x4],0x152
     fb3:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     fba:	e8 fc ff ff ff       	call   fbb <ahci_port_check_finished_commands+0x262>
     fbf:	e8 fc ff ff ff       	call   fc0 <ahci_port_check_finished_commands+0x267>
     fc4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     fcb:	e8 fc ff ff ff       	call   fcc <ahci_port_check_finished_commands+0x273>
     fd0:	fa                   	cli
     fd1:	f4                   	hlt
     fd2:	eb fd                	jmp    fd1 <ahci_port_check_finished_commands+0x278>
								die("not implemented yet!\n");
     fd4:	c7 44 24 04 67 01 00 00 	mov    DWORD PTR [esp+0x4],0x167
     fdc:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     fe3:	e8 fc ff ff ff       	call   fe4 <ahci_port_check_finished_commands+0x28b>
     fe8:	e8 fc ff ff ff       	call   fe9 <ahci_port_check_finished_commands+0x290>
     fed:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     ff4:	e8 fc ff ff ff       	call   ff5 <ahci_port_check_finished_commands+0x29c>
     ff9:	fa                   	cli
     ffa:	f4                   	hlt
     ffb:	eb fd                	jmp    ffa <ahci_port_check_finished_commands+0x2a1>
						iprintf("slot %u still active\n", cc->slot);
     ffd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1000:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
    1004:	0f b7 c0             	movzx  eax,ax
    1007:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    100b:	c7 04 24 7d 01 00 00 	mov    DWORD PTR [esp],0x17d
    1012:	e8 fc ff ff ff       	call   1013 <ahci_port_check_finished_commands+0x2ba>
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
    1017:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    101a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    101d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1020:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1023:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1026:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    1029:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    102c:	89 d0                	mov    eax,edx
    102e:	01 c0                	add    eax,eax
    1030:	01 d0                	add    eax,edx
    1032:	c1 e0 02             	shl    eax,0x2
    1035:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    103b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    103e:	01 d0                	add    eax,edx
    1040:	39 c1                	cmp    ecx,eax
    1042:	0f 85 3f fd ff ff    	jne    d87 <ahci_port_check_finished_commands+0x2e>
}
    1048:	90                   	nop
    1049:	90                   	nop
    104a:	83 c4 40             	add    esp,0x40
    104d:	5b                   	pop    ebx
    104e:	5e                   	pop    esi
    104f:	5d                   	pop    ebp
    1050:	c3                   	ret

00001051 <ahci_port_intr>:
{
    1051:	55                   	push   ebp
    1052:	89 e5                	mov    ebp,esp
    1054:	83 ec 28             	sub    esp,0x28
		struct ahci_port* p = &d->ptr->port[pt];
    1057:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    105a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    105d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1060:	83 c2 02             	add    edx,0x2
    1063:	c1 e2 07             	shl    edx,0x7
    1066:	01 d0                	add    eax,edx
    1068:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		uint32_t is = p->pXis, cm = 0; /* unaffected by mask */
    106b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    106e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1071:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1074:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		uint32_t ci = p->pXci; /* check if still set */
    107b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    107e:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    1081:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (is & (1 << 5)) { /* DPS: data processed (PRD&I), commands must use C bit */
    1084:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1087:	83 e0 20             	and    eax,0x20
    108a:	85 c0                	test   eax,eax
    108c:	74 1d                	je     10ab <ahci_port_intr+0x5a>
				ahci_port_check_finished_commands(d, pt, ci);
    108e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1091:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1095:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1098:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    109c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    109f:	89 04 24             	mov    DWORD PTR [esp],eax
    10a2:	e8 fc ff ff ff       	call   10a3 <ahci_port_intr+0x52>
				cm |= (1 << 5);
    10a7:	83 4d f4 20          	or     DWORD PTR [ebp-0xc],0x20
		if (is & (1 << 0)) { /* D2H FIS (more reliable) */
    10ab:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10ae:	83 e0 01             	and    eax,0x1
    10b1:	85 c0                	test   eax,eax
    10b3:	74 1d                	je     10d2 <ahci_port_intr+0x81>
				ahci_port_check_finished_commands(d, pt, ci);
    10b5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    10b8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    10bc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    10bf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    10c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10c6:	89 04 24             	mov    DWORD PTR [esp],eax
    10c9:	e8 fc ff ff ff       	call   10ca <ahci_port_intr+0x79>
				cm |= 1;
    10ce:	83 4d f4 01          	or     DWORD PTR [ebp-0xc],0x1
		if (is & (1 << 6)) { /* PCS */
    10d2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10d5:	83 e0 40             	and    eax,0x40
    10d8:	85 c0                	test   eax,eax
    10da:	74 32                	je     110e <ahci_port_intr+0xbd>
				abiprintf("PCS on port %d received, resetting...\n", pt);
    10dc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    10df:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    10e3:	c7 04 24 94 01 00 00 	mov    DWORD PTR [esp],0x194
    10ea:	e8 fc ff ff ff       	call   10eb <ahci_port_intr+0x9a>
				p->pXserr = 0xffffffff;
    10ef:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10f2:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
				ahci_reset_port(d->ptr, p);
    10f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10fc:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    10ff:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1102:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1106:	89 04 24             	mov    DWORD PTR [esp],eax
    1109:	e8 fc ff ff ff       	call   110a <ahci_port_intr+0xb9>
		if (is & (1 << 30)) { /* we need to restart the command engine */
    110e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1111:	25 00 00 00 40       	and    eax,0x40000000
    1116:	85 c0                	test   eax,eax
    1118:	74 20                	je     113a <ahci_port_intr+0xe9>
				ahci_port_handle_tfes_regular(d, p, pt);
    111a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    111d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1121:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1124:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1128:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    112b:	89 04 24             	mov    DWORD PTR [esp],eax
    112e:	e8 fc ff ff ff       	call   112f <ahci_port_intr+0xde>
				cm |= (1 << 30);
    1133:	81 4d f4 00 00 00 40 	or     DWORD PTR [ebp-0xc],0x40000000
		cm |= p->pXie;
    113a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    113d:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1140:	09 45 f4             	or     DWORD PTR [ebp-0xc],eax
		abiprintf("port cm: %x\n", cm);
    1143:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1146:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    114a:	c7 04 24 bb 01 00 00 	mov    DWORD PTR [esp],0x1bb
    1151:	e8 fc ff ff ff       	call   1152 <ahci_port_intr+0x101>
		p->pXis = cm;
    1156:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1159:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    115c:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
}
    115f:	90                   	nop
    1160:	c9                   	leave
    1161:	c3                   	ret

00001162 <ahci_handle_interrupt>:
{
    1162:	55                   	push   ebp
    1163:	89 e5                	mov    ebp,esp
    1165:	83 ec 28             	sub    esp,0x28
		uint32_t is = d->ptr->intr, clm = 0;
    1168:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    116b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    116e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1171:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1174:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		for (int i = 0; i < 32; i++) {
    117b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1182:	eb 3c                	jmp    11c0 <ahci_handle_interrupt+0x5e>
				if (is & (1 << i)) {
    1184:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1187:	ba 01 00 00 00       	mov    edx,0x1
    118c:	89 c1                	mov    ecx,eax
    118e:	d3 e2                	shl    edx,cl
    1190:	89 d0                	mov    eax,edx
    1192:	23 45 ec             	and    eax,DWORD PTR [ebp-0x14]
    1195:	85 c0                	test   eax,eax
    1197:	74 23                	je     11bc <ahci_handle_interrupt+0x5a>
						ahci_port_intr(d, i);
    1199:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    119c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    11a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11a3:	89 04 24             	mov    DWORD PTR [esp],eax
    11a6:	e8 fc ff ff ff       	call   11a7 <ahci_handle_interrupt+0x45>
						clm |= (1 << i);
    11ab:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11ae:	ba 01 00 00 00       	mov    edx,0x1
    11b3:	89 c1                	mov    ecx,eax
    11b5:	d3 e2                	shl    edx,cl
    11b7:	89 d0                	mov    eax,edx
    11b9:	09 45 f4             	or     DWORD PTR [ebp-0xc],eax
		for (int i = 0; i < 32; i++) {
    11bc:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    11c0:	83 7d f0 1f          	cmp    DWORD PTR [ebp-0x10],0x1f
    11c4:	7e be                	jle    1184 <ahci_handle_interrupt+0x22>
		d->ptr->intr = clm;
    11c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11c9:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    11cc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    11cf:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
}
    11d2:	90                   	nop
    11d3:	c9                   	leave
    11d4:	c3                   	ret

000011d5 <ahci_irq>:
{
    11d5:	55                   	push   ebp
    11d6:	89 e5                	mov    ebp,esp
    11d8:	83 ec 28             	sub    esp,0x28
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    11db:	a1 04 00 00 00       	mov    eax,ds:0x4
    11e0:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    11e3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11e6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    11e9:	eb 7c                	jmp    1267 <ahci_irq+0x92>
				if (d->dev->dev->intr_line == irq) {
    11eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11ee:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    11f1:	8b 00                	mov    eax,DWORD PTR [eax]
    11f3:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    11f7:	0f b6 c0             	movzx  eax,al
    11fa:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    11fd:	75 59                	jne    1258 <ahci_irq+0x83>
						if (pci_check_interrupt(d->dev->dev)) {
    11ff:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1202:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1205:	8b 00                	mov    eax,DWORD PTR [eax]
    1207:	89 04 24             	mov    DWORD PTR [esp],eax
    120a:	e8 fc ff ff ff       	call   120b <ahci_irq+0x36>
    120f:	85 c0                	test   eax,eax
    1211:	74 1c                	je     122f <ahci_irq+0x5a>
								ahci_handle_interrupt(d->dev, irq);
    1213:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1216:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1219:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    121c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1220:	89 04 24             	mov    DWORD PTR [esp],eax
    1223:	e8 fc ff ff ff       	call   1224 <ahci_irq+0x4f>
								return 1;
    1228:	b8 01 00 00 00       	mov    eax,0x1
    122d:	eb 5a                	jmp    1289 <ahci_irq+0xb4>
								if (d->dev->ptr->intr) {
    122f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1232:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1235:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1238:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    123b:	85 c0                	test   eax,eax
    123d:	74 19                	je     1258 <ahci_irq+0x83>
										ahci_handle_interrupt(d->dev, irq);
    123f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1242:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1245:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1248:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    124c:	89 04 24             	mov    DWORD PTR [esp],eax
    124f:	e8 fc ff ff ff       	call   1250 <ahci_irq+0x7b>
										rv++;
    1254:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
		list_for_each_entry(d, &ahci_dl.devs, devs) {
    1258:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    125b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    125e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1261:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1264:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1267:	81 7d f4 00 00 00 00 	cmp    DWORD PTR [ebp-0xc],0x0
    126e:	0f 85 77 ff ff ff    	jne    11eb <ahci_irq+0x16>
		if (!rv)
    1274:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1278:	75 0c                	jne    1286 <ahci_irq+0xb1>
				abiprintf("ignored non AHCI interrupt\n");
    127a:	c7 04 24 c8 01 00 00 	mov    DWORD PTR [esp],0x1c8
    1281:	e8 fc ff ff ff       	call   1282 <ahci_irq+0xad>
		return rv;
    1286:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    1289:	c9                   	leave
    128a:	c3                   	ret

0000128b <ahci_find_slot>:
{
    128b:	55                   	push   ebp
    128c:	89 e5                	mov    ebp,esp
    128e:	83 ec 10             	sub    esp,0x10
		uint32_t bitmask = (p->pXci/* NCQ: | p->pXsact*/);
    1291:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1294:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    1297:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		for (int i = 0; i < cmd_ct; i++) {
    129a:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    12a1:	eb 16                	jmp    12b9 <ahci_find_slot+0x2e>
				if (!(bitmask & 1))
    12a3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    12a6:	83 e0 01             	and    eax,0x1
    12a9:	85 c0                	test   eax,eax
    12ab:	75 05                	jne    12b2 <ahci_find_slot+0x27>
						return i;
    12ad:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    12b0:	eb 14                	jmp    12c6 <ahci_find_slot+0x3b>
				bitmask >>= 1;
    12b2:	d1 6d fc             	shr    DWORD PTR [ebp-0x4],1
		for (int i = 0; i < cmd_ct; i++) {
    12b5:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
    12b9:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    12bc:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    12bf:	7c e2                	jl     12a3 <ahci_find_slot+0x18>
		return -1;
    12c1:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    12c6:	c9                   	leave
    12c7:	c3                   	ret

000012c8 <ahci_release_cmdtbl>:
{
    12c8:	55                   	push   ebp
    12c9:	89 e5                	mov    ebp,esp
    12cb:	57                   	push   edi
    12cc:	56                   	push   esi
    12cd:	53                   	push   ebx
    12ce:	83 ec 3c             	sub    esp,0x3c
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    12d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12d4:	8b 80 0c 03 00 00    	mov    eax,DWORD PTR [eax+0x30c]
    12da:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    12dd:	e9 c9 00 00 00       	jmp    13ab <ahci_release_cmdtbl+0xe3>
				ptrdiff_t ofs = ctp->tables - entry;
    12e2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12e5:	83 c0 0c             	add    eax,0xc
    12e8:	2b 45 0c             	sub    eax,DWORD PTR [ebp+0xc]
    12eb:	c1 f8 04             	sar    eax,0x4
    12ee:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (ofs >= 0 && ofs < 32) {
    12f1:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    12f5:	0f 88 a7 00 00 00    	js     13a2 <ahci_release_cmdtbl+0xda>
    12fb:	83 7d e0 1f          	cmp    DWORD PTR [ebp-0x20],0x1f
    12ff:	0f 8f 9d 00 00 00    	jg     13a2 <ahci_release_cmdtbl+0xda>
						uint16_t p = entry->port, slt = entry->slot;
    1305:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1308:	0f b7 00             	movzx  eax,WORD PTR [eax]
    130b:	66 89 45 de          	mov    WORD PTR [ebp-0x22],ax
    130f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1312:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1316:	66 89 45 dc          	mov    WORD PTR [ebp-0x24],ax
						entry->port = entry->slot = 0xffff;
    131a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    131d:	66 c7 40 02 ff ff    	mov    WORD PTR [eax+0x2],0xffff
    1323:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1326:	0f b7 50 02          	movzx  edx,WORD PTR [eax+0x2]
    132a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    132d:	66 89 10             	mov    WORD PTR [eax],dx
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    1330:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1333:	ba 01 00 00 00       	mov    edx,0x1
    1338:	89 c1                	mov    ecx,eax
    133a:	d3 e2                	shl    edx,cl
    133c:	89 d0                	mov    eax,edx
    133e:	89 c6                	mov    esi,eax
								~(1 << ofs)))) {
    1340:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1343:	ba 01 00 00 00       	mov    edx,0x1
    1348:	89 c1                	mov    ecx,eax
    134a:	d3 e2                	shl    edx,cl
    134c:	89 d0                	mov    eax,edx
    134e:	f7 d0                	not    eax
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
    1350:	89 c7                	mov    edi,eax
    1352:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1355:	8d 50 08             	lea    edx,[eax+0x8]
    1358:	8b 02                	mov    eax,DWORD PTR [edx]
    135a:	89 c3                	mov    ebx,eax
    135c:	89 c1                	mov    ecx,eax
    135e:	21 f9                	and    ecx,edi
    1360:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1364:	0f 94 c1             	sete   cl
    1367:	84 c9                	test   cl,cl
    1369:	74 ef                	je     135a <ahci_release_cmdtbl+0x92>
    136b:	89 f0                	mov    eax,esi
    136d:	21 d8                	and    eax,ebx
    136f:	85 c0                	test   eax,eax
    1371:	75 44                	jne    13b7 <ahci_release_cmdtbl+0xef>
								abprintf("attempt to release command table at %p"
    1373:	0f b7 4d dc          	movzx  ecx,WORD PTR [ebp-0x24]
    1377:	0f b7 55 de          	movzx  edx,WORD PTR [ebp-0x22]
    137b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    137e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1381:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
    1384:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    1388:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    138c:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1390:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1394:	c7 04 24 e4 01 00 00 	mov    DWORD PTR [esp],0x1e4
    139b:	e8 fc ff ff ff       	call   139c <ahci_release_cmdtbl+0xd4>
						break;
    13a0:	eb 15                	jmp    13b7 <ahci_release_cmdtbl+0xef>
				ctp = ctp->next;
    13a2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13a5:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    13a8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    13ab:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    13af:	0f 85 2d ff ff ff    	jne    12e2 <ahci_release_cmdtbl+0x1a>
}
    13b5:	eb 01                	jmp    13b8 <ahci_release_cmdtbl+0xf0>
						break;
    13b7:	90                   	nop
}
    13b8:	90                   	nop
    13b9:	83 c4 3c             	add    esp,0x3c
    13bc:	5b                   	pop    ebx
    13bd:	5e                   	pop    esi
    13be:	5f                   	pop    edi
    13bf:	5d                   	pop    ebp
    13c0:	c3                   	ret

000013c1 <ahci_find_cmdtbl>:
{
    13c1:	55                   	push   ebp
    13c2:	89 e5                	mov    ebp,esp
    13c4:	57                   	push   edi
    13c5:	56                   	push   esi
    13c6:	53                   	push   ebx
    13c7:	83 ec 2c             	sub    esp,0x2c
		struct ahci_ct_pool* ctp = ad->ctbl_pool;
    13ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13cd:	8b 80 0c 03 00 00    	mov    eax,DWORD PTR [eax+0x30c]
    13d3:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    13d6:	e9 87 00 00 00       	jmp    1462 <ahci_find_cmdtbl+0xa1>
				if (ctp->prdt_cap >= prdt_ct) {
    13db:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13de:	8b 00                	mov    eax,DWORD PTR [eax]
    13e0:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    13e3:	72 74                	jb     1459 <ahci_find_cmdtbl+0x98>
Pos1:
    13e5:	90                   	nop
						bit = bsf(~ctp->mask); /* 1 based */
    13e6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13e9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    13ec:	f7 d0                	not    eax
    13ee:	89 04 24             	mov    DWORD PTR [esp],eax
    13f1:	e8 24 ec ff ff       	call   1a <bsf>
    13f6:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						if (bit--) {
    13f9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13fc:	8d 50 ff             	lea    edx,[eax-0x1]
    13ff:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
    1402:	85 c0                	test   eax,eax
    1404:	74 53                	je     1459 <ahci_find_cmdtbl+0x98>
								if (!((1 << bit) & __sync_fetch_and_or(&ctp->mask, 1 << bit))) {
    1406:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1409:	ba 01 00 00 00       	mov    edx,0x1
    140e:	89 c1                	mov    ecx,eax
    1410:	d3 e2                	shl    edx,cl
    1412:	89 d0                	mov    eax,edx
    1414:	89 c6                	mov    esi,eax
    1416:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1419:	ba 01 00 00 00       	mov    edx,0x1
    141e:	89 c1                	mov    ecx,eax
    1420:	d3 e2                	shl    edx,cl
    1422:	89 d0                	mov    eax,edx
    1424:	89 c7                	mov    edi,eax
    1426:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1429:	8d 50 08             	lea    edx,[eax+0x8]
    142c:	8b 02                	mov    eax,DWORD PTR [edx]
    142e:	89 c3                	mov    ebx,eax
    1430:	89 c1                	mov    ecx,eax
    1432:	09 f9                	or     ecx,edi
    1434:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1438:	0f 94 c1             	sete   cl
    143b:	84 c9                	test   cl,cl
    143d:	74 ef                	je     142e <ahci_find_cmdtbl+0x6d>
    143f:	89 f0                	mov    eax,esi
    1441:	21 d8                	and    eax,ebx
    1443:	85 c0                	test   eax,eax
    1445:	75 9f                	jne    13e6 <ahci_find_cmdtbl+0x25>
										return &ctp->tables[bit];
    1447:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    144a:	c1 e0 04             	shl    eax,0x4
    144d:	89 c2                	mov    edx,eax
    144f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1452:	01 d0                	add    eax,edx
    1454:	83 c0 0c             	add    eax,0xc
    1457:	eb 6b                	jmp    14c4 <ahci_find_cmdtbl+0x103>
				ctp = ctp->next;
    1459:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    145c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    145f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		while (ctp) {
    1462:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1466:	0f 85 6f ff ff ff    	jne    13db <ahci_find_cmdtbl+0x1a>
		if (jiffies - warn_time > HZ * 300) {
    146c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1471:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1474:	8b 00                	mov    eax,DWORD PTR [eax]
    1476:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    147c:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1482:	29 c8                	sub    eax,ecx
    1484:	19 da                	sbb    edx,ebx
    1486:	bb cc 8d 00 00       	mov    ebx,0x8dcc
    148b:	b9 00 00 00 00       	mov    ecx,0x0
    1490:	39 c3                	cmp    ebx,eax
    1492:	19 d1                	sbb    ecx,edx
    1494:	73 29                	jae    14bf <ahci_find_cmdtbl+0xfe>
				warn_time = jiffies;
    1496:	a1 00 00 00 00       	mov    eax,ds:0x0
    149b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    149e:	8b 00                	mov    eax,DWORD PTR [eax]
    14a0:	a3 00 00 00 00       	mov    ds:0x0,eax
    14a5:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
				cprintf(KFMT_INFO, "Command table pool exhausted.\nI/O performance"
    14ab:	c7 44 24 04 4c 02 00 00 	mov    DWORD PTR [esp+0x4],0x24c
    14b3:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    14ba:	e8 fc ff ff ff       	call   14bb <ahci_find_cmdtbl+0xfa>
		return NULL;
    14bf:	b8 00 00 00 00       	mov    eax,0x0
}
    14c4:	83 c4 2c             	add    esp,0x2c
    14c7:	5b                   	pop    ebx
    14c8:	5e                   	pop    esi
    14c9:	5f                   	pop    edi
    14ca:	5d                   	pop    ebp
    14cb:	c3                   	ret

000014cc <ahci_process_host_command>:
{
    14cc:	55                   	push   ebp
    14cd:	89 e5                	mov    ebp,esp
    14cf:	57                   	push   edi
    14d0:	56                   	push   esi
    14d1:	53                   	push   ebx
    14d2:	81 ec 8c 00 00 00    	sub    esp,0x8c
		switch (cc->c) {
    14d8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14db:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    14de:	3d 80 00 00 00       	cmp    eax,0x80
    14e3:	74 10                	je     14f5 <ahci_process_host_command+0x29>
    14e5:	3d 82 00 00 00       	cmp    eax,0x82
    14ea:	0f 84 7e 05 00 00    	je     1a6e <ahci_process_host_command+0x5a2>
    14f0:	e9 7c 06 00 00       	jmp    1b71 <ahci_process_host_command+0x6a5>
						struct ata_identify* id = ad->identify_data[cc->port].ptr;
    14f5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14f8:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    14fc:	0f b7 d0             	movzx  edx,ax
    14ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1502:	83 c2 10             	add    edx,0x10
    1505:	c1 e2 04             	shl    edx,0x4
    1508:	01 d0                	add    eax,edx
    150a:	83 c0 10             	add    eax,0x10
    150d:	8b 00                	mov    eax,DWORD PTR [eax]
    150f:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
						int comp = 1, su = 0, pt = cc->port;
    1512:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
    1519:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    1520:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1523:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    1527:	0f b7 c0             	movzx  eax,ax
    152a:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC
    152d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1530:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1534:	66 3d c8 37          	cmp    ax,0x37c8
    1538:	74 0d                	je     1547 <ahci_process_host_command+0x7b>
								|| id->specific_configuration == ATA_SC_NO_SPIN_UP_INC)
    153a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    153d:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1541:	66 3d 73 8c          	cmp    ax,0x8c73
    1545:	75 07                	jne    154e <ahci_process_host_command+0x82>
								comp = 0;
    1547:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP
    154e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1551:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1555:	66 3d 8c 73          	cmp    ax,0x738c
    1559:	74 0d                	je     1568 <ahci_process_host_command+0x9c>
								|| id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC)
    155b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    155e:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1562:	66 3d c8 37          	cmp    ax,0x37c8
    1566:	75 07                	jne    156f <ahci_process_host_command+0xa3>
								su = 1;
    1568:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
						if (comp && id->checksum_validity == 0xa5) {
    156f:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1573:	74 66                	je     15db <ahci_process_host_command+0x10f>
    1575:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1578:	0f b6 80 fe 01 00 00 	movzx  eax,BYTE PTR [eax+0x1fe]
    157f:	3c a5                	cmp    al,0xa5
    1581:	75 58                	jne    15db <ahci_process_host_command+0x10f>
								if (checksum_memory(id, sizeof(*id))) {
    1583:	c7 44 24 04 00 02 00 00 	mov    DWORD PTR [esp+0x4],0x200
    158b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    158e:	89 04 24             	mov    DWORD PTR [esp],eax
    1591:	e8 bf eb ff ff       	call   155 <checksum_memory>
    1596:	84 c0                	test   al,al
    1598:	74 41                	je     15db <ahci_process_host_command+0x10f>
										cc->c = disk_cmd_identify;
    159a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    159d:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
										cc->ptr = NULL;
    15a4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    15a7:	c7 40 20 00 00 00 00 	mov    DWORD PTR [eax+0x20],0x0
										cc->cur_buf = NULL;
    15ae:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    15b1:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
										printf("Invalid IDENTIFY received: reissuing...\n");
    15b8:	c7 04 24 94 02 00 00 	mov    DWORD PTR [esp],0x294
    15bf:	e8 fc ff ff ff       	call   15c0 <ahci_process_host_command+0xf4>
										ahci_reissue_command(ad, cc);
    15c4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    15c7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    15cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15ce:	89 04 24             	mov    DWORD PTR [esp],eax
    15d1:	e8 fc ff ff ff       	call   15d2 <ahci_process_host_command+0x106>
										return; /* we reuse cc */
    15d6:	e9 f1 05 00 00       	jmp    1bcc <ahci_process_host_command+0x700>
						if (comp) {
    15db:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    15df:	0f 84 56 04 00 00    	je     1a3b <ahci_process_host_command+0x56f>
								uint64_t max_sec = 0; uint32_t lpp = 1, lls = 512, lof = 0;
    15e5:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    15ec:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    15f3:	c7 45 d4 01 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x1
    15fa:	c7 45 d0 00 02 00 00 	mov    DWORD PTR [ebp-0x30],0x200
    1601:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    1608:	eb 01                	jmp    160b <ahci_process_host_command+0x13f>
								goto is_comp;				
    160a:	90                   	nop
								convert_ata_string(id->model_number, 20);
    160b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    160e:	83 c0 36             	add    eax,0x36
    1611:	c7 44 24 04 14 00 00 00 	mov    DWORD PTR [esp+0x4],0x14
    1619:	89 04 24             	mov    DWORD PTR [esp],eax
    161c:	e8 62 eb ff ff       	call   183 <convert_ata_string>
								convert_ata_string(id->additional_product_identifier, 4);
    1621:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1624:	05 54 01 00 00       	add    eax,0x154
    1629:	c7 44 24 04 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x4
    1631:	89 04 24             	mov    DWORD PTR [esp],eax
    1634:	e8 4a eb ff ff       	call   183 <convert_ata_string>
								convert_ata_string(id->current_media_manufacturer, 10);
    1639:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    163c:	05 88 01 00 00       	add    eax,0x188
    1641:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
    1649:	89 04 24             	mov    DWORD PTR [esp],eax
    164c:	e8 32 eb ff ff       	call   183 <convert_ata_string>
								convert_ata_string(id->current_media_serial_number, 20);
    1651:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1654:	05 60 01 00 00       	add    eax,0x160
    1659:	c7 44 24 04 14 00 00 00 	mov    DWORD PTR [esp+0x4],0x14
    1661:	89 04 24             	mov    DWORD PTR [esp],eax
    1664:	e8 1a eb ff ff       	call   183 <convert_ata_string>
								convert_ata_string(id->firmware_rev, 4);
    1669:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    166c:	83 c0 2e             	add    eax,0x2e
    166f:	c7 44 24 04 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x4
    1677:	89 04 24             	mov    DWORD PTR [esp],eax
    167a:	e8 04 eb ff ff       	call   183 <convert_ata_string>
								convert_ata_string(id->serial_number, 10);
    167f:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1682:	83 c0 14             	add    eax,0x14
    1685:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
    168d:	89 04 24             	mov    DWORD PTR [esp],eax
    1690:	e8 ee ea ff ff       	call   183 <convert_ata_string>
								if (!id->lba_supp) {
    1695:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1698:	0f b6 40 63          	movzx  eax,BYTE PTR [eax+0x63]
    169c:	83 e0 02             	and    eax,0x2
    169f:	84 c0                	test   al,al
    16a1:	75 10                	jne    16b3 <ahci_process_host_command+0x1e7>
										max_sec = -1; /* CHS? ATAncient */
    16a3:	c7 45 d8 ff ff ff ff 	mov    DWORD PTR [ebp-0x28],0xffffffff
    16aa:	c7 45 dc ff ff ff ff 	mov    DWORD PTR [ebp-0x24],0xffffffff
    16b1:	eb 49                	jmp    16fc <ahci_process_host_command+0x230>
								} else if (id->has_lba48 || id->has_lba48_alt)
    16b3:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16b6:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [eax+0xa7]
    16bd:	83 e0 04             	and    eax,0x4
    16c0:	84 c0                	test   al,al
    16c2:	75 11                	jne    16d5 <ahci_process_host_command+0x209>
    16c4:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16c7:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [eax+0xad]
    16ce:	83 e0 04             	and    eax,0x4
    16d1:	84 c0                	test   al,al
    16d3:	74 17                	je     16ec <ahci_process_host_command+0x220>
										max_sec = id->num_logical_sectors;
    16d5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16d8:	8b 90 cc 00 00 00    	mov    edx,DWORD PTR [eax+0xcc]
    16de:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [eax+0xc8]
    16e4:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    16e7:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    16ea:	eb 10                	jmp    16fc <ahci_process_host_command+0x230>
										max_sec = id->max_lba28;
    16ec:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16ef:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
    16f2:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    16f5:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
								if (id->has_multiple_logical_per_physical_sectors) {
    16fc:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16ff:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
    1706:	83 e0 20             	and    eax,0x20
    1709:	84 c0                	test   al,al
    170b:	74 1e                	je     172b <ahci_process_host_command+0x25f>
										lpp = 1 << id->num_pwr2_logical_per_phys;
    170d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1710:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [eax+0xd4]
    1717:	83 e0 0f             	and    eax,0xf
    171a:	0f b6 c0             	movzx  eax,al
    171d:	ba 01 00 00 00       	mov    edx,0x1
    1722:	89 c1                	mov    ecx,eax
    1724:	d3 e2                	shl    edx,cl
    1726:	89 d0                	mov    eax,edx
    1728:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								if (id->logical_sector_longer_than_512bt) {
    172b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    172e:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
    1735:	83 e0 10             	and    eax,0x10
    1738:	84 c0                	test   al,al
    173a:	74 2d                	je     1769 <ahci_process_host_command+0x29d>
										lls = 2 * id->logical_sector_size;
    173c:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    173f:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [eax+0xea]
    1745:	01 c0                	add    eax,eax
    1747:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										lof = id->logical_sector_offset;
    174a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    174d:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [eax+0x1a2]
    1754:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [eax+0x1a3]
    175b:	83 e0 3f             	and    eax,0x3f
    175e:	c1 e0 08             	shl    eax,0x8
    1761:	09 d0                	or     eax,edx
    1763:	0f b7 c0             	movzx  eax,ax
    1766:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
												(char*)id->current_media_manufacturer, (char*)id->current_media_serial_number);
    1769:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    176c:	8d b8 60 01 00 00    	lea    edi,[eax+0x160]
    1772:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1775:	8d b0 88 01 00 00    	lea    esi,[eax+0x188]
												(char*)id->serial_number, (char*)id->firmware_rev,
    177b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    177e:	8d 58 2e             	lea    ebx,[eax+0x2e]
    1781:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1784:	8d 48 14             	lea    ecx,[eax+0x14]
												pt, (char*)id->model_number, (char*)id->additional_product_identifier,
    1787:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    178a:	8d 90 54 01 00 00    	lea    edx,[eax+0x154]
    1790:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1793:	83 c0 36             	add    eax,0x36
								printf("IDENTIFY on port %u: %.40s %.8s %.20s %.8s\nMedia: %.20s %.40s\n",
    1796:	89 7c 24 1c          	mov    DWORD PTR [esp+0x1c],edi
    179a:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
    179e:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    17a2:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    17a6:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    17aa:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    17ae:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    17b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    17b5:	c7 04 24 c0 02 00 00 	mov    DWORD PTR [esp],0x2c0
    17bc:	e8 fc ff ff ff       	call   17bd <ahci_process_host_command+0x2f1>
										capstr(id->form_factor, 6, "", "5.25\"", "3.5\"", "2.5\"", "1.8\"", "<1.8\"", ""),
    17c1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    17c4:	0f b6 80 50 01 00 00 	movzx  eax,BYTE PTR [eax+0x150]
    17cb:	83 e0 0f             	and    eax,0xf
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    17ce:	0f b6 c0             	movzx  eax,al
    17d1:	c7 44 24 20 ff 02 00 00 	mov    DWORD PTR [esp+0x20],0x2ff
    17d9:	c7 44 24 1c 00 03 00 00 	mov    DWORD PTR [esp+0x1c],0x300
    17e1:	c7 44 24 18 06 03 00 00 	mov    DWORD PTR [esp+0x18],0x306
    17e9:	c7 44 24 14 0b 03 00 00 	mov    DWORD PTR [esp+0x14],0x30b
    17f1:	c7 44 24 10 10 03 00 00 	mov    DWORD PTR [esp+0x10],0x310
    17f9:	c7 44 24 0c 15 03 00 00 	mov    DWORD PTR [esp+0xc],0x315
    1801:	c7 44 24 08 ff 02 00 00 	mov    DWORD PTR [esp+0x8],0x2ff
    1809:	c7 44 24 04 06 00 00 00 	mov    DWORD PTR [esp+0x4],0x6
    1811:	89 04 24             	mov    DWORD PTR [esp],eax
    1814:	e8 fc ff ff ff       	call   1815 <ahci_process_host_command+0x349>
    1819:	89 c3                	mov    ebx,eax
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    181b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    181e:	0f b6 40 63          	movzx  eax,BYTE PTR [eax+0x63]
    1822:	83 e0 02             	and    eax,0x2
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1825:	84 c0                	test   al,al
    1827:	74 1f                	je     1848 <ahci_process_host_command+0x37c>
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
    1829:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    182c:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [eax+0xa7]
    1833:	83 e0 04             	and    eax,0x4
    1836:	84 c0                	test   al,al
    1838:	74 07                	je     1841 <ahci_process_host_command+0x375>
    183a:	b9 1b 03 00 00       	mov    ecx,0x31b
    183f:	eb 0c                	jmp    184d <ahci_process_host_command+0x381>
    1841:	b9 21 03 00 00       	mov    ecx,0x321
    1846:	eb 05                	jmp    184d <ahci_process_host_command+0x381>
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1848:	b9 27 03 00 00       	mov    ecx,0x327
										id->ata_version_major, id->ata_version_minor,
    184d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1850:	0f b7 80 a2 00 00 00 	movzx  eax,WORD PTR [eax+0xa2]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1857:	0f b7 f8             	movzx  edi,ax
										id->ata_version_major, id->ata_version_minor,
    185a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    185d:	0f b7 80 a0 00 00 00 	movzx  eax,WORD PTR [eax+0xa0]
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
    1864:	0f b7 f0             	movzx  esi,ax
    1867:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    186a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    186d:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1871:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
    1875:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    1879:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    187d:	89 7c 24 08          	mov    DWORD PTR [esp+0x8],edi
    1881:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    1885:	c7 04 24 2c 03 00 00 	mov    DWORD PTR [esp],0x32c
    188c:	e8 fc ff ff ff       	call   188d <ahci_process_host_command+0x3c1>
								printf("Logical sectors: size: %u offset: %u num_per_phys: %u\n", lls, lof, lpp);
    1891:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1894:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1898:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    189b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    189f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    18a2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    18a6:	c7 04 24 68 03 00 00 	mov    DWORD PTR [esp],0x368
    18ad:	e8 fc ff ff ff       	call   18ae <ahci_process_host_command+0x3e2>
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    18b2:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    18b5:	bb 00 00 00 00       	mov    ebx,0x0
    18ba:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18bd:	0f af c3             	imul   eax,ebx
    18c0:	89 c2                	mov    edx,eax
    18c2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18c5:	0f af c1             	imul   eax,ecx
    18c8:	8d 34 02             	lea    esi,[edx+eax*1]
    18cb:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18ce:	f7 e1                	mul    ecx
    18d0:	8d 0c 16             	lea    ecx,[esi+edx*1]
    18d3:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    18d5:	89 d0                	mov    eax,edx
    18d7:	31 d2                	xor    edx,edx
    18d9:	c1 e8 08             	shr    eax,0x8
    18dc:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    18df:	89 55 b4             	mov    DWORD PTR [ebp-0x4c],edx
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
    18e2:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    18e5:	bb 00 00 00 00       	mov    ebx,0x0
    18ea:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18ed:	89 c2                	mov    edx,eax
    18ef:	0f af d3             	imul   edx,ebx
    18f2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18f5:	0f af c1             	imul   eax,ecx
    18f8:	8d 34 02             	lea    esi,[edx+eax*1]
    18fb:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18fe:	f7 e1                	mul    ecx
    1900:	8d 0c 16             	lea    ecx,[esi+edx*1]
    1903:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1905:	0f ac d0 1e          	shrd   eax,edx,0x1e
    1909:	c1 ea 1e             	shr    edx,0x1e
    190c:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    190f:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1912:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    1915:	bb 00 00 00 00       	mov    ebx,0x0
    191a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    191d:	89 c2                	mov    edx,eax
    191f:	0f af d3             	imul   edx,ebx
    1922:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1925:	0f af c1             	imul   eax,ecx
    1928:	8d 34 02             	lea    esi,[edx+eax*1]
    192b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    192e:	f7 e1                	mul    ecx
    1930:	8d 0c 16             	lea    ecx,[esi+edx*1]
    1933:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1935:	89 c3                	mov    ebx,eax
    1937:	89 d6                	mov    esi,edx
    1939:	0f ac f3 14          	shrd   ebx,esi,0x14
    193d:	c1 ee 14             	shr    esi,0x14
    1940:	89 5d a0             	mov    DWORD PTR [ebp-0x60],ebx
    1943:	89 75 a4             	mov    DWORD PTR [ebp-0x5c],esi
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
    1946:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    1949:	bb 00 00 00 00       	mov    ebx,0x0
    194e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1951:	89 c2                	mov    edx,eax
    1953:	0f af d3             	imul   edx,ebx
    1956:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1959:	0f af c1             	imul   eax,ecx
    195c:	8d 34 02             	lea    esi,[edx+eax*1]
    195f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1962:	f7 e1                	mul    ecx
    1964:	8d 0c 16             	lea    ecx,[esi+edx*1]
    1967:	89 ca                	mov    edx,ecx
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
    1969:	89 c6                	mov    esi,eax
    196b:	89 d7                	mov    edi,edx
    196d:	0f ac fe 0a          	shrd   esi,edi,0xa
    1971:	c1 ef 0a             	shr    edi,0xa
    1974:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    1977:	bb 00 00 00 00       	mov    ebx,0x0
    197c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    197f:	89 c2                	mov    edx,eax
    1981:	0f af d3             	imul   edx,ebx
    1984:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1987:	0f af c1             	imul   eax,ecx
    198a:	01 c2                	add    edx,eax
    198c:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
    198f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1992:	f7 e1                	mul    ecx
    1994:	8b 5d 9c             	mov    ebx,DWORD PTR [ebp-0x64]
    1997:	8d 0c 13             	lea    ecx,[ebx+edx*1]
    199a:	89 ca                	mov    edx,ecx
    199c:	8b 4d b0             	mov    ecx,DWORD PTR [ebp-0x50]
    199f:	8b 5d b4             	mov    ebx,DWORD PTR [ebp-0x4c]
    19a2:	89 4c 24 24          	mov    DWORD PTR [esp+0x24],ecx
    19a6:	89 5c 24 28          	mov    DWORD PTR [esp+0x28],ebx
    19aa:	8b 4d a8             	mov    ecx,DWORD PTR [ebp-0x58]
    19ad:	8b 5d ac             	mov    ebx,DWORD PTR [ebp-0x54]
    19b0:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
    19b4:	89 5c 24 20          	mov    DWORD PTR [esp+0x20],ebx
    19b8:	8b 4d a0             	mov    ecx,DWORD PTR [ebp-0x60]
    19bb:	8b 5d a4             	mov    ebx,DWORD PTR [ebp-0x5c]
    19be:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    19c2:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
    19c6:	89 74 24 0c          	mov    DWORD PTR [esp+0xc],esi
    19ca:	89 7c 24 10          	mov    DWORD PTR [esp+0x10],edi
    19ce:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    19d2:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    19d6:	c7 04 24 a0 03 00 00 	mov    DWORD PTR [esp],0x3a0
    19dd:	e8 fc ff ff ff       	call   19de <ahci_process_host_command+0x512>
								if (!id->is_not_ata) {
    19e2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    19e5:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    19e9:	83 e0 80             	and    eax,0xffffff80
    19ec:	84 c0                	test   al,al
    19ee:	0f 85 b0 01 00 00    	jne    1ba4 <ahci_process_host_command+0x6d8>
										if (register_ata_device(ad, p, 0, id))
    19f4:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    19f7:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    19fb:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    1a03:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a06:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a0a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a0d:	89 04 24             	mov    DWORD PTR [esp],eax
    1a10:	e8 fc ff ff ff       	call   1a11 <ahci_process_host_command+0x545>
    1a15:	85 c0                	test   eax,eax
    1a17:	74 11                	je     1a2a <ahci_process_host_command+0x55e>
												printf("Registered device in file system.\n");
    1a19:	c7 04 24 d4 03 00 00 	mov    DWORD PTR [esp],0x3d4
    1a20:	e8 fc ff ff ff       	call   1a21 <ahci_process_host_command+0x555>
						break;
    1a25:	e9 7a 01 00 00       	jmp    1ba4 <ahci_process_host_command+0x6d8>
												printf("Failed to register device.\n");
    1a2a:	c7 04 24 f7 03 00 00 	mov    DWORD PTR [esp],0x3f7
    1a31:	e8 fc ff ff ff       	call   1a32 <ahci_process_host_command+0x566>
						break;
    1a36:	e9 69 01 00 00       	jmp    1ba4 <ahci_process_host_command+0x6d8>
						} else if (su) {
    1a3b:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1a3f:	0f 84 c5 fb ff ff    	je     160a <ahci_process_host_command+0x13e>
								die("spin-up by SET FEATURES not supported yet!\n");
    1a45:	c7 44 24 04 14 04 00 00 	mov    DWORD PTR [esp+0x4],0x414
    1a4d:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1a54:	e8 fc ff ff ff       	call   1a55 <ahci_process_host_command+0x589>
    1a59:	e8 fc ff ff ff       	call   1a5a <ahci_process_host_command+0x58e>
    1a5e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1a65:	e8 fc ff ff ff       	call   1a66 <ahci_process_host_command+0x59a>
    1a6a:	fa                   	cli
    1a6b:	f4                   	hlt
    1a6c:	eb fd                	jmp    1a6b <ahci_process_host_command+0x59f>
						int timeout = 50; /* up to 500 ms */
    1a6e:	c7 45 c8 32 00 00 00 	mov    DWORD PTR [ebp-0x38],0x32
						p->cmd.st = 0;
    1a75:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1a78:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    1a7b:	83 e0 fe             	and    eax,0xfffffffe
    1a7e:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						while (p->cmd.cr && timeout--)
    1a81:	eb 0c                	jmp    1a8f <ahci_process_host_command+0x5c3>
								mdelay(10);
    1a83:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    1a8a:	e8 fc ff ff ff       	call   1a8b <ahci_process_host_command+0x5bf>
						while (p->cmd.cr && timeout--)
    1a8f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a92:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1a95:	c1 e8 0f             	shr    eax,0xf
    1a98:	83 e0 01             	and    eax,0x1
    1a9b:	84 c0                	test   al,al
    1a9d:	74 0d                	je     1aac <ahci_process_host_command+0x5e0>
    1a9f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1aa2:	8d 50 ff             	lea    edx,[eax-0x1]
    1aa5:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    1aa8:	85 c0                	test   eax,eax
    1aaa:	75 d7                	jne    1a83 <ahci_process_host_command+0x5b7>
						if (p->cmd.cr) {
    1aac:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1aaf:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1ab2:	c1 e8 0f             	shr    eax,0xf
    1ab5:	83 e0 01             	and    eax,0x1
    1ab8:	84 c0                	test   al,al
    1aba:	74 43                	je     1aff <ahci_process_host_command+0x633>
full_reset:
    1abc:	90                   	nop
    1abd:	eb 01                	jmp    1ac0 <ahci_process_host_command+0x5f4>
										goto full_reset;
    1abf:	90                   	nop
										p - ad->ptr->port);
    1ac0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ac3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ac6:	05 00 01 00 00       	add    eax,0x100
    1acb:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1ace:	29 c2                	sub    edx,eax
								abprintf("performing full port reset on port %zd\n",
    1ad0:	89 d0                	mov    eax,edx
    1ad2:	c1 f8 07             	sar    eax,0x7
    1ad5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ad9:	c7 04 24 40 04 00 00 	mov    DWORD PTR [esp],0x440
    1ae0:	e8 fc ff ff ff       	call   1ae1 <ahci_process_host_command+0x615>
								ahci_reset_port(ad->ptr, p);
    1ae5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ae8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1aeb:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1aee:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1af2:	89 04 24             	mov    DWORD PTR [esp],eax
    1af5:	e8 fc ff ff ff       	call   1af6 <ahci_process_host_command+0x62a>
						break;
    1afa:	e9 a6 00 00 00       	jmp    1ba5 <ahci_process_host_command+0x6d9>
								p->pXserr = 0xffffffff;
    1aff:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b02:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
								p->pXis = 0xffffffff; /* likewise */
    1b09:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b0c:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [eax+0x10],0xffffffff
								if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    1b13:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b16:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1b19:	0f b6 c0             	movzx  eax,al
    1b1c:	25 88 00 00 00       	and    eax,0x88
    1b21:	85 c0                	test   eax,eax
    1b23:	75 9a                	jne    1abf <ahci_process_host_command+0x5f3>
								p->cmd.st = 1;
    1b25:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1b28:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    1b2b:	83 c8 01             	or     eax,0x1
    1b2e:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1b31:	b8 32 00 00 00       	mov    eax,0x32
    1b36:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
    1b39:	89 c2                	mov    edx,eax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1b3b:	89 d0                	mov    eax,edx
    1b3d:	c1 e0 02             	shl    eax,0x2
    1b40:	01 d0                	add    eax,edx
    1b42:	01 c0                	add    eax,eax
    1b44:	89 c1                	mov    ecx,eax
										p - ad->ptr->port, 10 * (50 - timeout));
    1b46:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b49:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b4c:	05 00 01 00 00       	add    eax,0x100
    1b51:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1b54:	29 c2                	sub    edx,eax
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
    1b56:	89 d0                	mov    eax,edx
    1b58:	c1 f8 07             	sar    eax,0x7
    1b5b:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1b5f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b63:	c7 04 24 68 04 00 00 	mov    DWORD PTR [esp],0x468
    1b6a:	e8 fc ff ff ff       	call   1b6b <ahci_process_host_command+0x69f>
						break;
    1b6f:	eb 34                	jmp    1ba5 <ahci_process_host_command+0x6d9>
						die("someone messed up! command=%x\n", cc->c);
    1b71:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b74:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1b77:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1b7b:	c7 44 24 04 a0 04 00 00 	mov    DWORD PTR [esp+0x4],0x4a0
    1b83:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1b8a:	e8 fc ff ff ff       	call   1b8b <ahci_process_host_command+0x6bf>
    1b8f:	e8 fc ff ff ff       	call   1b90 <ahci_process_host_command+0x6c4>
    1b94:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1b9b:	e8 fc ff ff ff       	call   1b9c <ahci_process_host_command+0x6d0>
    1ba0:	fa                   	cli
    1ba1:	f4                   	hlt
    1ba2:	eb fd                	jmp    1ba1 <ahci_process_host_command+0x6d5>
						break;
    1ba4:	90                   	nop
		ahci_release_cmdtbl(ad, cc->entry);
    1ba5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ba8:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1bab:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1baf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bb2:	89 04 24             	mov    DWORD PTR [esp],eax
    1bb5:	e8 fc ff ff ff       	call   1bb6 <ahci_process_host_command+0x6ea>
		ahci_destroy_context(ad, cc);
    1bba:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bbd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1bc1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bc4:	89 04 24             	mov    DWORD PTR [esp],eax
    1bc7:	e8 fc ff ff ff       	call   1bc8 <ahci_process_host_command+0x6fc>
}
    1bcc:	81 c4 8c 00 00 00    	add    esp,0x8c
    1bd2:	5b                   	pop    ebx
    1bd3:	5e                   	pop    esi
    1bd4:	5f                   	pop    edi
    1bd5:	5d                   	pop    ebp
    1bd6:	c3                   	ret

00001bd7 <ahci_process_command>:
{
    1bd7:	55                   	push   ebp
    1bd8:	89 e5                	mov    ebp,esp
    1bda:	53                   	push   ebx
    1bdb:	83 ec 64             	sub    esp,0x64
		struct cmd_ctx* cc; int slt, rv, pt = p - ad->ptr->port; uint32_t ct;
    1bde:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1be1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1be4:	05 00 01 00 00       	add    eax,0x100
    1be9:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1bec:	29 c2                	sub    edx,eax
    1bee:	89 d0                	mov    eax,edx
    1bf0:	c1 f8 07             	sar    eax,0x7
    1bf3:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		struct ahci_cmdlst* cl = ad->command_lists[pt];
    1bf6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bf9:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1bfc:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    1c00:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		if (!cl)
    1c03:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1c07:	75 15                	jne    1c1e <ahci_process_command+0x47>
				abprintf("Ignoring command on port %d as it's command"
    1c09:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1c0c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c10:	c7 04 24 c0 04 00 00 	mov    DWORD PTR [esp],0x4c0
    1c17:	e8 fc ff ff ff       	call   1c18 <ahci_process_command+0x41>
    1c1c:	eb 01                	jmp    1c1f <ahci_process_command+0x48>
next_cmd:
    1c1e:	90                   	nop
		slt = ahci_find_slot(p, ad->num_cmd); /* does not reserve -> no cleanup */
    1c1f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c22:	0f b7 40 0a          	movzx  eax,WORD PTR [eax+0xa]
    1c26:	0f b7 c0             	movzx  eax,ax
    1c29:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c2d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c30:	89 04 24             	mov    DWORD PTR [esp],eax
    1c33:	e8 fc ff ff ff       	call   1c34 <ahci_process_command+0x5d>
    1c38:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		if (slt == -1) /* still full */
    1c3b:	83 7d d0 ff          	cmp    DWORD PTR [ebp-0x30],0xffffffff
    1c3f:	0f 84 6b 06 00 00    	je     22b0 <ahci_process_command+0x6d9>
		if (!p->cmd.st) {
    1c45:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c48:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1c4b:	83 e0 01             	and    eax,0x1
    1c4e:	84 c0                	test   al,al
    1c50:	0f 85 98 00 00 00    	jne    1cee <ahci_process_command+0x117>
				abprintf("waiting for reset host command on port %d\n", pt);
    1c56:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1c59:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c5d:	c7 04 24 04 05 00 00 	mov    DWORD PTR [esp],0x504
    1c64:	e8 fc ff ff ff       	call   1c65 <ahci_process_command+0x8e>
				cc = list_cut_first_entry_where(lh, struct cmd_ctx, lst,
    1c69:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1c70:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c73:	89 04 24             	mov    DWORD PTR [esp],eax
    1c76:	e8 c6 e4 ff ff       	call   141 <list_empty>
    1c7b:	85 c0                	test   eax,eax
    1c7d:	75 64                	jne    1ce3 <ahci_process_command+0x10c>
    1c7f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c82:	83 c0 08             	add    eax,0x8
    1c85:	89 04 24             	mov    DWORD PTR [esp],eax
    1c88:	e8 fc ff ff ff       	call   1c89 <ahci_process_command+0xb2>
    1c8d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c90:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c93:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    1c96:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1c99:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1c9c:	eb 2f                	jmp    1ccd <ahci_process_command+0xf6>
    1c9e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1ca1:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1ca4:	3d 82 00 00 00       	cmp    eax,0x82
    1ca9:	75 13                	jne    1cbe <ahci_process_command+0xe7>
    1cab:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cae:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1cb1:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cb4:	89 04 24             	mov    DWORD PTR [esp],eax
    1cb7:	e8 a0 e3 ff ff       	call   5c <__list_del>
    1cbc:	eb 17                	jmp    1cd5 <ahci_process_command+0xfe>
    1cbe:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cc1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1cc4:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    1cc7:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1cca:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1ccd:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cd0:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
    1cd3:	75 c9                	jne    1c9e <ahci_process_command+0xc7>
    1cd5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1cd8:	83 c0 08             	add    eax,0x8
    1cdb:	89 04 24             	mov    DWORD PTR [esp],eax
    1cde:	e8 fc ff ff ff       	call   1cdf <ahci_process_command+0x108>
    1ce3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1ce6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1ce9:	e9 8a 00 00 00       	jmp    1d78 <ahci_process_command+0x1a1>
				abprintf("processing command in slot %d on port %d\n", slt, pt);
    1cee:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1cf1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1cf5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1cf8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1cfc:	c7 04 24 30 05 00 00 	mov    DWORD PTR [esp],0x530
    1d03:	e8 fc ff ff ff       	call   1d04 <ahci_process_command+0x12d>
				cc = list_cut_first_entry(lh, struct cmd_ctx, lst);
    1d08:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d0b:	89 04 24             	mov    DWORD PTR [esp],eax
    1d0e:	e8 2e e4 ff ff       	call   141 <list_empty>
    1d13:	85 c0                	test   eax,eax
    1d15:	75 54                	jne    1d6b <ahci_process_command+0x194>
    1d17:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d1a:	83 c0 08             	add    eax,0x8
    1d1d:	89 04 24             	mov    DWORD PTR [esp],eax
    1d20:	e8 fc ff ff ff       	call   1d21 <ahci_process_command+0x14a>
    1d25:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d28:	89 04 24             	mov    DWORD PTR [esp],eax
    1d2b:	e8 11 e4 ff ff       	call   141 <list_empty>
    1d30:	85 c0                	test   eax,eax
    1d32:	75 0e                	jne    1d42 <ahci_process_command+0x16b>
    1d34:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d37:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1d3a:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    1d3d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1d40:	eb 05                	jmp    1d47 <ahci_process_command+0x170>
    1d42:	b8 00 00 00 00       	mov    eax,0x0
    1d47:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1d4a:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1d4e:	74 0b                	je     1d5b <ahci_process_command+0x184>
    1d50:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d53:	89 04 24             	mov    DWORD PTR [esp],eax
    1d56:	e8 01 e3 ff ff       	call   5c <__list_del>
    1d5b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d5e:	83 c0 08             	add    eax,0x8
    1d61:	89 04 24             	mov    DWORD PTR [esp],eax
    1d64:	e8 fc ff ff ff       	call   1d65 <ahci_process_command+0x18e>
    1d69:	eb 07                	jmp    1d72 <ahci_process_command+0x19b>
    1d6b:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    1d72:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d75:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!cc) { /* the command vanished?/or isn't posted yet */
    1d78:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1d7c:	75 11                	jne    1d8f <ahci_process_command+0x1b8>
				abprintf("command vanished\n");
    1d7e:	c7 04 24 5a 05 00 00 	mov    DWORD PTR [esp],0x55a
    1d85:	e8 fc ff ff ff       	call   1d86 <ahci_process_command+0x1af>
				return;
    1d8a:	e9 22 05 00 00       	jmp    22b1 <ahci_process_command+0x6da>
		if (cc->c == host_cmd_resend) {
    1d8f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1d92:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d95:	3d 81 00 00 00       	cmp    eax,0x81
    1d9a:	75 0c                	jne    1da8 <ahci_process_command+0x1d1>
				rv = 0;
    1d9c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				goto issue;
    1da3:	e9 35 03 00 00       	jmp    20dd <ahci_process_command+0x506>
		} else if (cc->c >= host_cmd_process_identify) {
    1da8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1dab:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1dae:	83 f8 7f             	cmp    eax,0x7f
    1db1:	76 1e                	jbe    1dd1 <ahci_process_command+0x1fa>
				ahci_process_host_command(ad, p, cc);
    1db3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1db6:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1dba:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1dbd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1dc1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dc4:	89 04 24             	mov    DWORD PTR [esp],eax
    1dc7:	e8 fc ff ff ff       	call   1dc8 <ahci_process_command+0x1f1>
				goto incr;
    1dcc:	e9 bf 04 00 00       	jmp    2290 <ahci_process_command+0x6b9>
		if (cc->ptr) {
    1dd1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1dd4:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1dd7:	85 c0                	test   eax,eax
    1dd9:	74 79                	je     1e54 <ahci_process_command+0x27d>
				/*void* ptr2; */uint64_t s = cc->ct;
    1ddb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1dde:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1de1:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1de4:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1de7:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
				ct = rdiv(s, 4096) + 1; /* first guess */
    1dea:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1ded:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1df0:	0f ac d0 0c          	shrd   eax,edx,0xc
    1df4:	c1 ea 0c             	shr    edx,0xc
    1df7:	89 c1                	mov    ecx,eax
    1df9:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1dfc:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1dff:	25 ff 0f 00 00       	and    eax,0xfff
    1e04:	ba 00 00 00 00       	mov    edx,0x0
    1e09:	89 c3                	mov    ebx,eax
    1e0b:	89 d8                	mov    eax,ebx
    1e0d:	09 d0                	or     eax,edx
    1e0f:	74 07                	je     1e18 <ahci_process_command+0x241>
    1e11:	b8 01 00 00 00       	mov    eax,0x1
    1e16:	eb 05                	jmp    1e1d <ahci_process_command+0x246>
    1e18:	b8 00 00 00 00       	mov    eax,0x0
    1e1d:	01 c8                	add    eax,ecx
    1e1f:	83 c0 01             	add    eax,0x1
    1e22:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (ct > 8) {
    1e25:	83 7d ec 08          	cmp    DWORD PTR [ebp-0x14],0x8
    1e29:	76 43                	jbe    1e6e <ahci_process_command+0x297>
						die("implement this later.\n");
    1e2b:	c7 44 24 04 6c 05 00 00 	mov    DWORD PTR [esp+0x4],0x56c
    1e33:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1e3a:	e8 fc ff ff ff       	call   1e3b <ahci_process_command+0x264>
    1e3f:	e8 fc ff ff ff       	call   1e40 <ahci_process_command+0x269>
    1e44:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1e4b:	e8 fc ff ff ff       	call   1e4c <ahci_process_command+0x275>
    1e50:	fa                   	cli
    1e51:	f4                   	hlt
    1e52:	eb fd                	jmp    1e51 <ahci_process_command+0x27a>
		} else if (cc->c == disk_cmd_identify) {
    1e54:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e57:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1e5a:	85 c0                	test   eax,eax
    1e5c:	75 09                	jne    1e67 <ahci_process_command+0x290>
				ct = 1;
    1e5e:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
    1e65:	eb 07                	jmp    1e6e <ahci_process_command+0x297>
				ct = 0;
    1e67:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (!cc->entry) /* else: max_prdtl still valid */
    1e6e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e71:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e74:	85 c0                	test   eax,eax
    1e76:	75 18                	jne    1e90 <ahci_process_command+0x2b9>
				cc->entry = ahci_find_cmdtbl(ad, ct);
    1e78:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e7b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e7f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e82:	89 04 24             	mov    DWORD PTR [esp],eax
    1e85:	e8 fc ff ff ff       	call   1e86 <ahci_process_command+0x2af>
    1e8a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1e8d:	89 42 48             	mov    DWORD PTR [edx+0x48],eax
		if (cc->entry) {
    1e90:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e93:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1e96:	85 c0                	test   eax,eax
    1e98:	74 2b                	je     1ec5 <ahci_process_command+0x2ee>
				cc->entry->port = cc->port;
    1e9a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e9d:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1ea0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1ea3:	0f b7 52 30          	movzx  edx,WORD PTR [edx+0x30]
    1ea7:	66 89 10             	mov    WORD PTR [eax],dx
				cc->entry->slot = slt;
    1eaa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ead:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1eb0:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1eb3:	66 89 50 02          	mov    WORD PTR [eax+0x2],dx
				cc->slot = slt;
    1eb7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1eba:	89 c2                	mov    edx,eax
    1ebc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ebf:	66 89 50 32          	mov    WORD PTR [eax+0x32],dx
    1ec3:	eb 13                	jmp    1ed8 <ahci_process_command+0x301>
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);
    1ec5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ec8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ecc:	c7 04 24 84 05 00 00 	mov    DWORD PTR [esp],0x584
    1ed3:	e8 fc ff ff ff       	call   1ed4 <ahci_process_command+0x2fd>
		if (!cc->entry && ct > 8) { /* divide by twoish */
    1ed8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1edb:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1ede:	85 c0                	test   eax,eax
    1ee0:	75 3e                	jne    1f20 <ahci_process_command+0x349>
    1ee2:	83 7d ec 08          	cmp    DWORD PTR [ebp-0x14],0x8
    1ee6:	76 38                	jbe    1f20 <ahci_process_command+0x349>
				int log = bsr(ct) - 1;
    1ee8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1eeb:	89 04 24             	mov    DWORD PTR [esp],eax
    1eee:	e8 0d e1 ff ff       	call   0 <bsr>
    1ef3:	83 e8 01             	sub    eax,0x1
    1ef6:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				uint32_t new_ct = (1 << log);
    1ef9:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1efc:	ba 01 00 00 00       	mov    edx,0x1
    1f01:	89 c1                	mov    ecx,eax
    1f03:	d3 e2                	shl    edx,cl
    1f05:	89 d0                	mov    eax,edx
    1f07:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (new_ct == ct)
    1f0a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1f0d:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
    1f10:	75 03                	jne    1f15 <ahci_process_command+0x33e>
						new_ct >>= 1;
    1f12:	d1 6d dc             	shr    DWORD PTR [ebp-0x24],1
				ct = new_ct;
    1f15:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1f18:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				goto find;
    1f1b:	e9 4e ff ff ff       	jmp    1e6e <ahci_process_command+0x297>
		} else if (!cc->entry) { /* none available */
    1f20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f23:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1f26:	85 c0                	test   eax,eax
    1f28:	75 23                	jne    1f4d <ahci_process_command+0x376>
				abprintf("waiting for cmdtbl to become available.\n");
    1f2a:	c7 04 24 b0 05 00 00 	mov    DWORD PTR [esp],0x5b0
    1f31:	e8 fc ff ff ff       	call   1f32 <ahci_process_command+0x35b>
				list_add(&cc->lst, lh);
    1f36:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f39:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    1f3c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1f40:	89 04 24             	mov    DWORD PTR [esp],eax
    1f43:	e8 48 e1 ff ff       	call   90 <list_add>
				return;
    1f48:	e9 64 03 00 00       	jmp    22b1 <ahci_process_command+0x6da>
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    1f4d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f50:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1f53:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    1f57:	0f b7 c8             	movzx  ecx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    1f5a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f5d:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    1f60:	0f b7 00             	movzx  eax,WORD PTR [eax]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    1f63:	0f b7 d0             	movzx  edx,ax
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
    1f66:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f69:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
    1f6c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1f6f:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1f73:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1f77:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f7b:	c7 04 24 dc 05 00 00 	mov    DWORD PTR [esp],0x5dc
    1f82:	e8 fc ff ff ff       	call   1f83 <ahci_process_command+0x3ac>
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
    1f87:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f8a:	ba 08 00 00 00       	mov    edx,0x8
    1f8f:	39 d0                	cmp    eax,edx
    1f91:	0f 43 d0             	cmovae edx,eax
    1f94:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f97:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
		if (p->cmd.atapi) { /* ATAPI */
    1f9a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f9d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1fa0:	c1 e8 18             	shr    eax,0x18
    1fa3:	83 e0 01             	and    eax,0x1
    1fa6:	84 c0                	test   al,al
    1fa8:	0f 84 8a 00 00 00    	je     2038 <ahci_process_command+0x461>
				switch (cc->c) {
    1fae:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fb1:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1fb4:	85 c0                	test   eax,eax
    1fb6:	74 0a                	je     1fc2 <ahci_process_command+0x3eb>
    1fb8:	83 e8 01             	sub    eax,0x1
    1fbb:	83 f8 02             	cmp    eax,0x2
    1fbe:	77 45                	ja     2005 <ahci_process_command+0x42e>
    1fc0:	eb 1a                	jmp    1fdc <ahci_process_command+0x405>
								rv = atapi_build_packet_device_identify(ad, cc);
    1fc2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fc5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1fc9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fcc:	89 04 24             	mov    DWORD PTR [esp],eax
    1fcf:	e8 fc ff ff ff       	call   1fd0 <ahci_process_command+0x3f9>
    1fd4:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
    1fd7:	e9 01 01 00 00       	jmp    20dd <ahci_process_command+0x506>
								die("not implemented yet!\n");
    1fdc:	c7 44 24 04 67 01 00 00 	mov    DWORD PTR [esp+0x4],0x167
    1fe4:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1feb:	e8 fc ff ff ff       	call   1fec <ahci_process_command+0x415>
    1ff0:	e8 fc ff ff ff       	call   1ff1 <ahci_process_command+0x41a>
    1ff5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1ffc:	e8 fc ff ff ff       	call   1ffd <ahci_process_command+0x426>
    2001:	fa                   	cli
    2002:	f4                   	hlt
    2003:	eb fd                	jmp    2002 <ahci_process_command+0x42b>
								die("The command %x should not end up here.\n", cc->c);
    2005:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2008:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    200b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    200f:	c7 44 24 04 14 06 00 00 	mov    DWORD PTR [esp+0x4],0x614
    2017:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    201e:	e8 fc ff ff ff       	call   201f <ahci_process_command+0x448>
    2023:	e8 fc ff ff ff       	call   2024 <ahci_process_command+0x44d>
    2028:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    202f:	e8 fc ff ff ff       	call   2030 <ahci_process_command+0x459>
    2034:	fa                   	cli
    2035:	f4                   	hlt
    2036:	eb fd                	jmp    2035 <ahci_process_command+0x45e>
				switch (cc->c) { /* ATA */
    2038:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    203b:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    203e:	83 f8 03             	cmp    eax,0x3
    2041:	77 67                	ja     20aa <ahci_process_command+0x4d3>
    2043:	83 f8 02             	cmp    eax,0x2
    2046:	73 39                	jae    2081 <ahci_process_command+0x4aa>
    2048:	85 c0                	test   eax,eax
    204a:	74 07                	je     2053 <ahci_process_command+0x47c>
    204c:	83 f8 01             	cmp    eax,0x1
    204f:	74 19                	je     206a <ahci_process_command+0x493>
    2051:	eb 57                	jmp    20aa <ahci_process_command+0x4d3>
								rv = ata_build_device_identify(ad, cc);
    2053:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2056:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    205a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    205d:	89 04 24             	mov    DWORD PTR [esp],eax
    2060:	e8 fc ff ff ff       	call   2061 <ahci_process_command+0x48a>
    2065:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
    2068:	eb 73                	jmp    20dd <ahci_process_command+0x506>
								rv = ata_build_read_dma_ext(ad, cc);
    206a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    206d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2071:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2074:	89 04 24             	mov    DWORD PTR [esp],eax
    2077:	e8 fc ff ff ff       	call   2078 <ahci_process_command+0x4a1>
    207c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
    207f:	eb 5c                	jmp    20dd <ahci_process_command+0x506>
								die("not implemented yet!\n");
    2081:	c7 44 24 04 67 01 00 00 	mov    DWORD PTR [esp+0x4],0x167
    2089:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2090:	e8 fc ff ff ff       	call   2091 <ahci_process_command+0x4ba>
    2095:	e8 fc ff ff ff       	call   2096 <ahci_process_command+0x4bf>
    209a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    20a1:	e8 fc ff ff ff       	call   20a2 <ahci_process_command+0x4cb>
    20a6:	fa                   	cli
    20a7:	f4                   	hlt
    20a8:	eb fd                	jmp    20a7 <ahci_process_command+0x4d0>
								die("The command %x should not end up here.\n", cc->c);
    20aa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20ad:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    20b0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    20b4:	c7 44 24 04 14 06 00 00 	mov    DWORD PTR [esp+0x4],0x614
    20bc:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    20c3:	e8 fc ff ff ff       	call   20c4 <ahci_process_command+0x4ed>
    20c8:	e8 fc ff ff ff       	call   20c9 <ahci_process_command+0x4f2>
    20cd:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    20d4:	e8 fc ff ff ff       	call   20d5 <ahci_process_command+0x4fe>
    20d9:	fa                   	cli
    20da:	f4                   	hlt
    20db:	eb fd                	jmp    20da <ahci_process_command+0x503>
		if (rv) { /* cleanup */
    20dd:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    20e1:	74 5c                	je     213f <ahci_process_command+0x568>
				abprintf("ignored malformed command on port %u\n", cc->port);
    20e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20e6:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    20ea:	0f b7 c0             	movzx  eax,ax
    20ed:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    20f1:	c7 04 24 3c 06 00 00 	mov    DWORD PTR [esp],0x63c
    20f8:	e8 fc ff ff ff       	call   20f9 <ahci_process_command+0x522>
				if (cc->status)
    20fd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2100:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2103:	85 c0                	test   eax,eax
    2105:	74 0c                	je     2113 <ahci_process_command+0x53c>
						cc->status->state = cmd_state_abort;
    2107:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    210a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    210d:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				ahci_release_cmdtbl(ad, cc->entry);
    2113:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2116:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    2119:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    211d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2120:	89 04 24             	mov    DWORD PTR [esp],eax
    2123:	e8 fc ff ff ff       	call   2124 <ahci_process_command+0x54d>
				ahci_destroy_context(ad, cc);
    2128:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    212b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    212f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2132:	89 04 24             	mov    DWORD PTR [esp],eax
    2135:	e8 fc ff ff ff       	call   2136 <ahci_process_command+0x55f>
    213a:	e9 51 01 00 00       	jmp    2290 <ahci_process_command+0x6b9>
		} else if (!(p->pXci & (1 << slt))) {/* issue it on the port p slot slt */
    213f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2142:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
    2145:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2148:	bb 01 00 00 00       	mov    ebx,0x1
    214d:	89 c1                	mov    ecx,eax
    214f:	d3 e3                	shl    ebx,cl
    2151:	89 d8                	mov    eax,ebx
    2153:	21 d0                	and    eax,edx
    2155:	85 c0                	test   eax,eax
    2157:	0f 85 0a 01 00 00    	jne    2267 <ahci_process_command+0x690>
				struct ahci_cmdhdr* ch = &ad->command_lists[cc->port]->chdrs[slt];
    215d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2160:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2164:	0f b7 d0             	movzx  edx,ax
    2167:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    216a:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    216e:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2171:	c1 e2 05             	shl    edx,0x5
    2174:	01 d0                	add    eax,edx
    2176:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
				bzero(ch, sizeof(*ch));
    2179:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    2181:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2184:	89 04 24             	mov    DWORD PTR [esp],eax
    2187:	e8 fc ff ff ff       	call   2188 <ahci_process_command+0x5b1>
				ch->ctba64 = cc->entry->pmem;
    218c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    218f:	8b 40 48             	mov    eax,DWORD PTR [eax+0x48]
    2192:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2195:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2198:	8b 4d b0             	mov    ecx,DWORD PTR [ebp-0x50]
    219b:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    219e:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
				ch->prdtl = cc->clh.prdtl;
    21a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21a4:	0f b7 50 44          	movzx  edx,WORD PTR [eax+0x44]
    21a8:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    21ab:	66 89 50 02          	mov    WORD PTR [eax+0x2],dx
				ch->flags = cc->clh.flg;
    21af:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21b2:	0f b7 50 46          	movzx  edx,WORD PTR [eax+0x46]
    21b6:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    21b9:	66 89 10             	mov    WORD PTR [eax],dx
				if (p->cmd.st) {
    21bc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21bf:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    21c2:	83 e0 01             	and    eax,0x1
    21c5:	84 c0                	test   al,al
    21c7:	74 2c                	je     21f5 <ahci_process_command+0x61e>
						p->pXci = (1 << slt);
    21c9:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    21cc:	ba 01 00 00 00       	mov    edx,0x1
    21d1:	89 c1                	mov    ecx,eax
    21d3:	d3 e2                	shl    edx,cl
    21d5:	89 d0                	mov    eax,edx
    21d7:	89 c2                	mov    edx,eax
    21d9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21dc:	89 50 38             	mov    DWORD PTR [eax+0x38],edx
						if (cc->status)
    21df:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21e2:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    21e5:	85 c0                	test   eax,eax
    21e7:	74 0c                	je     21f5 <ahci_process_command+0x61e>
								cc->status->state = cmd_state_issued;
    21e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21ec:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    21ef:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
				if (!p->cmd.st) {
    21f5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21f8:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    21fb:	83 e0 01             	and    eax,0x1
    21fe:	84 c0                	test   al,al
    2200:	75 2a                	jne    222c <ahci_process_command+0x655>
						abprintf("command will be sent later\n");
    2202:	c7 04 24 62 06 00 00 	mov    DWORD PTR [esp],0x662
    2209:	e8 fc ff ff ff       	call   220a <ahci_process_command+0x633>
						cc->c = host_cmd_resend;
    220e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2211:	c7 40 0c 81 00 00 00 	mov    DWORD PTR [eax+0xc],0x81
						ahci_reissue_command(ad, cc);
    2218:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    221b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    221f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2222:	89 04 24             	mov    DWORD PTR [esp],eax
    2225:	e8 fc ff ff ff       	call   2226 <ahci_process_command+0x64f>
						goto incr; /* skip putting into proc_cmds */
    222a:	eb 64                	jmp    2290 <ahci_process_command+0x6b9>
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
    222c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    222f:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2233:	0f b7 d0             	movzx  edx,ax
    2236:	89 d0                	mov    eax,edx
    2238:	01 c0                	add    eax,eax
    223a:	01 d0                	add    eax,edx
    223c:	c1 e0 02             	shl    eax,0x2
    223f:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    2245:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2248:	01 c2                	add    edx,eax
    224a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    224d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2251:	89 04 24             	mov    DWORD PTR [esp],eax
    2254:	e8 78 de ff ff       	call   d1 <list_add_tail>
				abprintf("issued the command successfully.\n");
    2259:	c7 04 24 80 06 00 00 	mov    DWORD PTR [esp],0x680
    2260:	e8 fc ff ff ff       	call   2261 <ahci_process_command+0x68a>
    2265:	eb 29                	jmp    2290 <ahci_process_command+0x6b9>
				 * inherently single threaded structure? */
				die("error posting command\n");
    2267:	c7 44 24 04 a2 06 00 00 	mov    DWORD PTR [esp+0x4],0x6a2
    226f:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2276:	e8 fc ff ff ff       	call   2277 <ahci_process_command+0x6a0>
    227b:	e8 fc ff ff ff       	call   227c <ahci_process_command+0x6a5>
    2280:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2287:	e8 fc ff ff ff       	call   2288 <ahci_process_command+0x6b1>
    228c:	fa                   	cli
    228d:	f4                   	hlt
    228e:	eb fd                	jmp    228d <ahci_process_command+0x6b6>
		}

		/* process next command */
incr:
		__sync_fetch_and_sub(&ad->pending_ct, 1);
    2290:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2293:	05 10 06 00 00       	add    eax,0x610
    2298:	f0 83 28 01          	lock sub DWORD PTR [eax],0x1
		if (!list_empty(lh))
    229c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    229f:	89 04 24             	mov    DWORD PTR [esp],eax
    22a2:	e8 9a de ff ff       	call   141 <list_empty>
    22a7:	85 c0                	test   eax,eax
    22a9:	75 06                	jne    22b1 <ahci_process_command+0x6da>
				goto next_cmd;
    22ab:	e9 6f f9 ff ff       	jmp    1c1f <ahci_process_command+0x48>
				return;
    22b0:	90                   	nop
}
    22b1:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    22b4:	c9                   	leave
    22b5:	c3                   	ret

000022b6 <ahci_worker>:

void ahci_worker(void* dat)
{
    22b6:	55                   	push   ebp
    22b7:	89 e5                	mov    ebp,esp
    22b9:	57                   	push   edi
    22ba:	56                   	push   esi
    22bb:	53                   	push   ebx
    22bc:	83 ec 5c             	sub    esp,0x5c
		struct ahci_device* ad = dat;
    22bf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22c2:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		printf("AHCI worker is running\n");
    22c5:	c7 04 24 b9 06 00 00 	mov    DWORD PTR [esp],0x6b9
    22cc:	e8 fc ff ff ff       	call   22cd <ahci_worker+0x17>
		while (1) {
				uint32_t ps = ad->ptr->ports;
    22d1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22d4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22d7:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    22da:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    22dd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22e0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22e3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22e6:	d1 e8                	shr    eax,1
    22e8:	83 e0 01             	and    eax,0x1
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    22eb:	0f b6 c8             	movzx  ecx,al
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
    22ee:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22f1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22f4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22f7:	c1 e8 1f             	shr    eax,0x1f
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
    22fa:	0f b6 d0             	movzx  edx,al
    22fd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2300:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2303:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2306:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    230a:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    230e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2312:	c7 04 24 d1 06 00 00 	mov    DWORD PTR [esp],0x6d1
    2319:	e8 fc ff ff ff       	call   231a <ahci_worker+0x64>
				for (int i = 0; i < 32; i++)
    231e:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    2325:	e9 24 01 00 00       	jmp    244e <ahci_worker+0x198>
						if (ps & (1 << i)) {
    232a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    232d:	ba 01 00 00 00       	mov    edx,0x1
    2332:	89 c1                	mov    ecx,eax
    2334:	d3 e2                	shl    edx,cl
    2336:	89 d0                	mov    eax,edx
    2338:	23 45 d8             	and    eax,DWORD PTR [ebp-0x28]
    233b:	85 c0                	test   eax,eax
    233d:	0f 84 07 01 00 00    	je     244a <ahci_worker+0x194>
//										ad->ptr->port[i].scr0.ipm, ad->ptr[i].port[i].pXserr);
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    2343:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2346:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2349:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    234c:	c1 e2 07             	shl    edx,0x7
    234f:	01 d0                	add    eax,edx
    2351:	05 34 01 00 00       	add    eax,0x134
    2356:	8b 30                	mov    esi,DWORD PTR [eax]
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
    2358:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    235b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    235e:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2361:	c1 e2 07             	shl    edx,0x7
    2364:	01 d0                	add    eax,edx
    2366:	05 38 01 00 00       	add    eax,0x138
    236b:	8b 00                	mov    eax,DWORD PTR [eax]
    236d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    2370:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2373:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2376:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2379:	c1 e2 07             	shl    edx,0x7
    237c:	01 d0                	add    eax,edx
    237e:	05 20 01 00 00       	add    eax,0x120
    2383:	8b 00                	mov    eax,DWORD PTR [eax]
    2385:	0f b6 c4             	movzx  eax,ah
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    2388:	0f b6 d8             	movzx  ebx,al
    238b:	89 5d d0             	mov    DWORD PTR [ebp-0x30],ebx
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
    238e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2391:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2394:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2397:	c1 e2 07             	shl    edx,0x7
    239a:	01 d0                	add    eax,edx
    239c:	05 20 01 00 00       	add    eax,0x120
    23a1:	8b 00                	mov    eax,DWORD PTR [eax]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    23a3:	0f b6 f8             	movzx  edi,al
    23a6:	89 7d cc             	mov    DWORD PTR [ebp-0x34],edi
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    23a9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23ac:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    23af:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    23b2:	c1 e2 07             	shl    edx,0x7
    23b5:	01 d0                	add    eax,edx
    23b7:	05 14 01 00 00       	add    eax,0x114
    23bc:	8b 38                	mov    edi,DWORD PTR [eax]
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
    23be:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23c1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    23c4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    23c7:	c1 e0 07             	shl    eax,0x7
    23ca:	01 d0                	add    eax,edx
    23cc:	05 10 01 00 00       	add    eax,0x110
    23d1:	8b 18                	mov    ebx,DWORD PTR [eax]
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    23d3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23d6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    23d9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    23dc:	c1 e0 07             	shl    eax,0x7
    23df:	01 d0                	add    eax,edx
    23e1:	05 10 01 00 00       	add    eax,0x110
    23e6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    23e9:	c1 e8 0f             	shr    eax,0xf
    23ec:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    23ef:	0f b6 c8             	movzx  ecx,al
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
    23f2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    23f5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    23f8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    23fb:	c1 e0 07             	shl    eax,0x7
    23fe:	01 d0                	add    eax,edx
    2400:	05 10 01 00 00       	add    eax,0x110
    2405:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2408:	83 e0 01             	and    eax,0x1
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
    240b:	0f b6 c0             	movzx  eax,al
    240e:	89 74 24 24          	mov    DWORD PTR [esp+0x24],esi
    2412:	8b 75 d4             	mov    esi,DWORD PTR [ebp-0x2c]
    2415:	89 74 24 20          	mov    DWORD PTR [esp+0x20],esi
    2419:	8b 75 d0             	mov    esi,DWORD PTR [ebp-0x30]
    241c:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    2420:	8b 75 cc             	mov    esi,DWORD PTR [ebp-0x34]
    2423:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
    2427:	89 7c 24 14          	mov    DWORD PTR [esp+0x14],edi
    242b:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    242f:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    2433:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2437:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    243a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    243e:	c7 04 24 e8 06 00 00 	mov    DWORD PTR [esp],0x6e8
    2445:	e8 fc ff ff ff       	call   2446 <ahci_worker+0x190>
				for (int i = 0; i < 32; i++)
    244a:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    244e:	83 7d e4 1f          	cmp    DWORD PTR [ebp-0x1c],0x1f
    2452:	0f 8e d2 fe ff ff    	jle    232a <ahci_worker+0x74>
//
						}
				/* print global IS */
				void ioapic_print_is();
				int pci_print_is(union pca);
				ioapic_print_is();
    2458:	e8 fc ff ff ff       	call   2459 <ahci_worker+0x1a3>
				pci_print_is(ad->dev->addr);
    245d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2460:	8b 00                	mov    eax,DWORD PTR [eax]
    2462:	8b 00                	mov    eax,DWORD PTR [eax]
    2464:	89 04 24             	mov    DWORD PTR [esp],eax
    2467:	e8 fc ff ff ff       	call   2468 <ahci_worker+0x1b2>
//						}
//						/* R1C */
//						ad->ptr->intr = 1;
//				}

				wait_on_event(&ad->wh);
    246c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    246f:	05 20 06 00 00       	add    eax,0x620
    2474:	89 04 24             	mov    DWORD PTR [esp],eax
    2477:	e8 fc ff ff ff       	call   2478 <ahci_worker+0x1c2>
				//sleep(1);

				/* there are pending commands */
				if (ad->pending_ct) {
    247c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    247f:	8b 80 10 06 00 00    	mov    eax,DWORD PTR [eax+0x610]
    2485:	85 c0                	test   eax,eax
    2487:	0f 84 44 fe ff ff    	je     22d1 <ahci_worker+0x1b>
						for (int i = 0; i < 32; i++) {
    248d:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    2494:	eb 7d                	jmp    2513 <ahci_worker+0x25d>
								if (!(ps & (1 << i)))
    2496:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2499:	ba 01 00 00 00       	mov    edx,0x1
    249e:	89 c1                	mov    ecx,eax
    24a0:	d3 e2                	shl    edx,cl
    24a2:	89 d0                	mov    eax,edx
    24a4:	23 45 d8             	and    eax,DWORD PTR [ebp-0x28]
    24a7:	85 c0                	test   eax,eax
    24a9:	74 60                	je     250b <ahci_worker+0x255>
										continue;
								if (list_empty(&ad->pending_cmds[i]))
    24ab:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    24ae:	89 d0                	mov    eax,edx
    24b0:	01 c0                	add    eax,eax
    24b2:	01 d0                	add    eax,edx
    24b4:	c1 e0 02             	shl    eax,0x2
    24b7:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    24bd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    24c0:	01 d0                	add    eax,edx
    24c2:	89 04 24             	mov    DWORD PTR [esp],eax
    24c5:	e8 77 dc ff ff       	call   141 <list_empty>
    24ca:	85 c0                	test   eax,eax
    24cc:	75 40                	jne    250e <ahci_worker+0x258>
										continue;
								/* we have commands to process */
								ahci_process_command(ad, &ad->ptr->port[i],
    24ce:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    24d1:	89 d0                	mov    eax,edx
    24d3:	01 c0                	add    eax,eax
    24d5:	01 d0                	add    eax,edx
    24d7:	c1 e0 02             	shl    eax,0x2
    24da:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    24e0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    24e3:	01 c2                	add    edx,eax
    24e5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    24e8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    24eb:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    24ee:	83 c1 02             	add    ecx,0x2
    24f1:	c1 e1 07             	shl    ecx,0x7
    24f4:	01 c8                	add    eax,ecx
    24f6:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    24fa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    24fe:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2501:	89 04 24             	mov    DWORD PTR [esp],eax
    2504:	e8 fc ff ff ff       	call   2505 <ahci_worker+0x24f>
    2509:	eb 04                	jmp    250f <ahci_worker+0x259>
										continue;
    250b:	90                   	nop
    250c:	eb 01                	jmp    250f <ahci_worker+0x259>
										continue;
    250e:	90                   	nop
						for (int i = 0; i < 32; i++) {
    250f:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    2513:	83 7d e0 1f          	cmp    DWORD PTR [ebp-0x20],0x1f
    2517:	0f 8e 79 ff ff ff    	jle    2496 <ahci_worker+0x1e0>
		while (1) {
    251d:	e9 af fd ff ff       	jmp    22d1 <ahci_worker+0x1b>

00002522 <ahci_allocate_command_table_pool>:
				}
		}
}

void* ahci_allocate_command_table_pool(uint32_t ct, uint32_t prdt_cap, int bit64)
{
    2522:	55                   	push   ebp
    2523:	89 e5                	mov    ebp,esp
    2525:	53                   	push   ebx
    2526:	83 ec 64             	sub    esp,0x64
		/* 128bt aligned size (8 PRDT/128 bt) */
		struct ahci_ct_pool* rv; uint32_t i = 0;
    2529:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		size_t byte_ct, page_rest, indiv_ct, pg_pe, pg_ct, epa;
		struct page_range pr; int flg = MMGR_ALLOC_CONTIGUOUS;
    2530:	c7 45 e4 00 00 03 00 	mov    DWORD PTR [ebp-0x1c],0x30000
		if (!bit64)
    2537:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    253b:	75 07                	jne    2544 <ahci_allocate_command_table_pool+0x22>
				flg = MMGR_ALLOC_32BIT;
    253d:	c7 45 e4 00 00 04 00 	mov    DWORD PTR [ebp-0x1c],0x40000
		if (!(rv = kzalloc(sizeof(*rv))))
    2544:	c7 04 24 0c 02 00 00 	mov    DWORD PTR [esp],0x20c
    254b:	e8 fc ff ff ff       	call   254c <ahci_allocate_command_table_pool+0x2a>
    2550:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    2553:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    2557:	75 0a                	jne    2563 <ahci_allocate_command_table_pool+0x41>
				return NULL;
    2559:	b8 00 00 00 00       	mov    eax,0x0
    255e:	e9 e3 02 00 00       	jmp    2846 <ahci_allocate_command_table_pool+0x324>
	   
		/* bitmask limit */
		if (ct > 32)
    2563:	83 7d 08 20          	cmp    DWORD PTR [ebp+0x8],0x20
    2567:	76 07                	jbe    2570 <ahci_allocate_command_table_pool+0x4e>
				ct = 32;
    2569:	c7 45 08 20 00 00 00 	mov    DWORD PTR [ebp+0x8],0x20
		/* enforce alignment */
		if (prdt_cap % 8)
    2570:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2573:	83 e0 07             	and    eax,0x7
    2576:	85 c0                	test   eax,eax
    2578:	74 0c                	je     2586 <ahci_allocate_command_table_pool+0x64>
				prdt_cap += 8 - prdt_cap % 8;
    257a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    257d:	83 e0 f8             	and    eax,0xfffffff8
    2580:	83 c0 08             	add    eax,0x8
    2583:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		indiv_ct = 128 + 16 * prdt_cap;
    2586:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2589:	83 c0 08             	add    eax,0x8
    258c:	c1 e0 04             	shl    eax,0x4
    258f:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		byte_ct = ct * indiv_ct;
    2592:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2595:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
    2599:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		pg_pe = rdiv(indiv_ct, 4096);
    259c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    259f:	c1 e8 0c             	shr    eax,0xc
    25a2:	89 c2                	mov    edx,eax
    25a4:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    25a7:	25 ff 0f 00 00       	and    eax,0xfff
    25ac:	85 c0                	test   eax,eax
    25ae:	74 07                	je     25b7 <ahci_allocate_command_table_pool+0x95>
    25b0:	b8 01 00 00 00       	mov    eax,0x1
    25b5:	eb 05                	jmp    25bc <ahci_allocate_command_table_pool+0x9a>
    25b7:	b8 00 00 00 00       	mov    eax,0x0
    25bc:	01 d0                	add    eax,edx
    25be:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		page_rest = pg_pe * 4096 - indiv_ct;
    25c1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    25c4:	c1 e0 0c             	shl    eax,0xc
    25c7:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    25ca:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax

		/* pg_pe allocs must be contiguous, but if page_rest is low
		 * individual tables can be split up to different locations */
		if (!page_rest || (page_rest % indiv_ct == 0)) {
    25cd:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    25d1:	74 11                	je     25e4 <ahci_allocate_command_table_pool+0xc2>
    25d3:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    25d6:	ba 00 00 00 00       	mov    edx,0x0
    25db:	f7 75 d0             	div    DWORD PTR [ebp-0x30]
    25de:	89 d0                	mov    eax,edx
    25e0:	85 c0                	test   eax,eax
    25e2:	75 49                	jne    262d <ahci_allocate_command_table_pool+0x10b>
				epa = pg_pe * 4096 / indiv_ct; /* entries per allocation */
    25e4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    25e7:	c1 e0 0c             	shl    eax,0xc
    25ea:	ba 00 00 00 00       	mov    edx,0x0
    25ef:	f7 75 d0             	div    DWORD PTR [ebp-0x30]
    25f2:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				pg_ct = rdiv(ct, epa) * pg_pe;
    25f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25f8:	ba 00 00 00 00       	mov    edx,0x0
    25fd:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
    2600:	89 c1                	mov    ecx,eax
    2602:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2605:	ba 00 00 00 00       	mov    edx,0x0
    260a:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
    260d:	89 d0                	mov    eax,edx
    260f:	85 c0                	test   eax,eax
    2611:	74 07                	je     261a <ahci_allocate_command_table_pool+0xf8>
    2613:	b8 01 00 00 00       	mov    eax,0x1
    2618:	eb 05                	jmp    261f <ahci_allocate_command_table_pool+0xfd>
    261a:	b8 00 00 00 00       	mov    eax,0x0
    261f:	8d 14 08             	lea    edx,[eax+ecx*1]
    2622:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2625:	0f af c2             	imul   eax,edx
    2628:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    262b:	eb 31                	jmp    265e <ahci_allocate_command_table_pool+0x13c>
		} else {
				pg_ct = rdiv(byte_ct, 4096);
    262d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2630:	c1 e8 0c             	shr    eax,0xc
    2633:	89 c2                	mov    edx,eax
    2635:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2638:	25 ff 0f 00 00       	and    eax,0xfff
    263d:	85 c0                	test   eax,eax
    263f:	74 07                	je     2648 <ahci_allocate_command_table_pool+0x126>
    2641:	b8 01 00 00 00       	mov    eax,0x1
    2646:	eb 05                	jmp    264d <ahci_allocate_command_table_pool+0x12b>
    2648:	b8 00 00 00 00       	mov    eax,0x0
    264d:	01 d0                	add    eax,edx
    264f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				epa = ct;
    2652:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2655:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				pg_pe = pg_ct;
    2658:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    265b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		}

		/* allocate the physical memory */
		while (pg_ct) {
    265e:	e9 64 01 00 00       	jmp    27c7 <ahci_allocate_command_table_pool+0x2a5>
				void* ptr; size_t epa2 = epa, rem;
    2663:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2666:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				mm_alloc_pm_flg(pg_pe, &pr, 1, flg);
    2669:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    266c:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    2670:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    2678:	8d 45 bc             	lea    eax,[ebp-0x44]
    267b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    267f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2682:	89 04 24             	mov    DWORD PTR [esp],eax
    2685:	e8 fc ff ff ff       	call   2686 <ahci_allocate_command_table_pool+0x164>
				if (pr.count != pg_pe)
    268a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    268d:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    2690:	74 29                	je     26bb <ahci_allocate_command_table_pool+0x199>
						die("Out of contiguous memory\n");
    2692:	c7 44 24 04 27 07 00 00 	mov    DWORD PTR [esp+0x4],0x727
    269a:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    26a1:	e8 fc ff ff ff       	call   26a2 <ahci_allocate_command_table_pool+0x180>
    26a6:	e8 fc ff ff ff       	call   26a7 <ahci_allocate_command_table_pool+0x185>
    26ab:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    26b2:	e8 fc ff ff ff       	call   26b3 <ahci_allocate_command_table_pool+0x191>
    26b7:	fa                   	cli
    26b8:	f4                   	hlt
    26b9:	eb fd                	jmp    26b8 <ahci_allocate_command_table_pool+0x196>
				rem = pg_pe * 4096;
    26bb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    26be:	c1 e0 0c             	shl    eax,0xc
    26c1:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				/* pg_pe zeroed contiguous memory at pr.base */
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL |
    26c4:	c7 44 24 10 2c 00 00 00 	mov    DWORD PTR [esp+0x10],0x2c
    26cc:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    26d4:	8d 45 bc             	lea    eax,[ebp-0x44]
    26d7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    26db:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    26e3:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    26ea:	e8 fc ff ff ff       	call   26eb <ahci_allocate_command_table_pool+0x1c9>
    26ef:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						MMGR_MAP_WRITE | MMGR_MAP_NO_CACHING);
				if (!ptr)
    26f2:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    26f6:	0f 85 b4 00 00 00    	jne    27b0 <ahci_allocate_command_table_pool+0x28e>
						die("mmap not working\n");
    26fc:	c7 44 24 04 41 07 00 00 	mov    DWORD PTR [esp+0x4],0x741
    2704:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    270b:	e8 fc ff ff ff       	call   270c <ahci_allocate_command_table_pool+0x1ea>
    2710:	e8 fc ff ff ff       	call   2711 <ahci_allocate_command_table_pool+0x1ef>
    2715:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    271c:	e8 fc ff ff ff       	call   271d <ahci_allocate_command_table_pool+0x1fb>
    2721:	fa                   	cli
    2722:	f4                   	hlt
    2723:	eb fd                	jmp    2722 <ahci_allocate_command_table_pool+0x200>

				/* assign the entries */
				while (epa2--) {
						rv->tables[i].pmem = pr.base;
    2725:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2728:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    272b:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    272e:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    2731:	c1 e3 04             	shl    ebx,0x4
    2734:	01 d9                	add    ecx,ebx
    2736:	89 41 14             	mov    DWORD PTR [ecx+0x14],eax
    2739:	89 51 18             	mov    DWORD PTR [ecx+0x18],edx
						rv->tables[i++].ptr = ptr;
    273c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    273f:	8d 50 01             	lea    edx,[eax+0x1]
    2742:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2745:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2748:	c1 e0 04             	shl    eax,0x4
    274b:	01 d0                	add    eax,edx
    274d:	8d 50 10             	lea    edx,[eax+0x10]
    2750:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2753:	89 02                	mov    DWORD PTR [edx],eax
						/* advance */
						pr.base += indiv_ct;
    2755:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2758:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    275b:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    275e:	bb 00 00 00 00       	mov    ebx,0x0
    2763:	01 c8                	add    eax,ecx
    2765:	11 da                	adc    edx,ebx
    2767:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    276a:	89 55 c0             	mov    DWORD PTR [ebp-0x40],edx
						ptr += indiv_ct;
    276d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2770:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
						rem -= indiv_ct;
    2773:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2776:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
						if (rem < indiv_ct && epa2 > 1)
    2779:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    277c:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    277f:	73 2f                	jae    27b0 <ahci_allocate_command_table_pool+0x28e>
    2781:	83 7d dc 01          	cmp    DWORD PTR [ebp-0x24],0x1
    2785:	76 29                	jbe    27b0 <ahci_allocate_command_table_pool+0x28e>
								die("algo error\n");
    2787:	c7 44 24 04 53 07 00 00 	mov    DWORD PTR [esp+0x4],0x753
    278f:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2796:	e8 fc ff ff ff       	call   2797 <ahci_allocate_command_table_pool+0x275>
    279b:	e8 fc ff ff ff       	call   279c <ahci_allocate_command_table_pool+0x27a>
    27a0:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    27a7:	e8 fc ff ff ff       	call   27a8 <ahci_allocate_command_table_pool+0x286>
    27ac:	fa                   	cli
    27ad:	f4                   	hlt
    27ae:	eb fd                	jmp    27ad <ahci_allocate_command_table_pool+0x28b>
				while (epa2--) {
    27b0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    27b3:	8d 50 ff             	lea    edx,[eax-0x1]
    27b6:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    27b9:	85 c0                	test   eax,eax
    27bb:	0f 85 64 ff ff ff    	jne    2725 <ahci_allocate_command_table_pool+0x203>
				}
				pg_ct -= pg_pe;
    27c1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    27c4:	29 45 ec             	sub    DWORD PTR [ebp-0x14],eax
		while (pg_ct) {
    27c7:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    27cb:	0f 85 92 fe ff ff    	jne    2663 <ahci_allocate_command_table_pool+0x141>
		}

		/* assign the other values */
		rv->prdt_cap = prdt_cap;
    27d1:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    27d4:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    27d7:	89 10                	mov    DWORD PTR [eax],edx
		rv->next = NULL;
    27d9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    27dc:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
		rv->mask = 0xffffffff << prdt_cap;
    27e3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27e6:	ba ff ff ff ff       	mov    edx,0xffffffff
    27eb:	89 c1                	mov    ecx,eax
    27ed:	d3 e2                	shl    edx,cl
    27ef:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    27f2:	89 50 08             	mov    DWORD PTR [eax+0x8],edx

		/* print it */
		for (i = 0; i < ct; i++)
    27f5:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    27fc:	eb 3d                	jmp    283b <ahci_allocate_command_table_pool+0x319>
				printf("%016llx %p\n", rv->tables[i].pmem, rv->tables[i].ptr);
    27fe:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2801:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2804:	c1 e2 04             	shl    edx,0x4
    2807:	01 d0                	add    eax,edx
    2809:	83 c0 10             	add    eax,0x10
    280c:	8b 08                	mov    ecx,DWORD PTR [eax]
    280e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2811:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2814:	c1 e2 04             	shl    edx,0x4
    2817:	01 d0                	add    eax,edx
    2819:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    281c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    281f:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    2823:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2827:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    282b:	c7 04 24 5f 07 00 00 	mov    DWORD PTR [esp],0x75f
    2832:	e8 fc ff ff ff       	call   2833 <ahci_allocate_command_table_pool+0x311>
		for (i = 0; i < ct; i++)
    2837:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    283b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    283e:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    2841:	72 bb                	jb     27fe <ahci_allocate_command_table_pool+0x2dc>

		return rv;
    2843:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
}
    2846:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2849:	c9                   	leave
    284a:	c3                   	ret

0000284b <ahci_reissue_command>:

void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc)
{
    284b:	55                   	push   ebp
    284c:	89 e5                	mov    ebp,esp
    284e:	56                   	push   esi
    284f:	53                   	push   ebx
    2850:	83 ec 10             	sub    esp,0x10
		iprintf("  REISSUE: %d %u\n", cc->port, cc->c);
    2853:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2856:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2859:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    285c:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2860:	0f b7 c0             	movzx  eax,ax
    2863:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2867:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    286b:	c7 04 24 6b 07 00 00 	mov    DWORD PTR [esp],0x76b
    2872:	e8 fc ff ff ff       	call   2873 <ahci_reissue_command+0x28>
		if (cc->status)
    2877:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    287a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    287d:	85 c0                	test   eax,eax
    287f:	74 0c                	je     288d <ahci_reissue_command+0x42>
				cc->status->state = cmd_state_pending;
    2881:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2884:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2887:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
						ad->pending_cmds[cc->port].next, cc->port);
    288d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2890:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    2894:	0f b7 d8             	movzx  ebx,ax
						ad->pending_cmds[cc->port].next, cc->port);
    2897:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    289a:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    289e:	0f b7 d0             	movzx  edx,ax
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
    28a1:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    28a4:	89 d0                	mov    eax,edx
    28a6:	01 c0                	add    eax,eax
    28a8:	01 d0                	add    eax,edx
    28aa:	c1 e0 02             	shl    eax,0x2
    28ad:	01 c8                	add    eax,ecx
    28af:	05 14 03 00 00       	add    eax,0x314
    28b4:	8b 08                	mov    ecx,DWORD PTR [eax]
    28b6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    28b9:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    28bd:	0f b7 d0             	movzx  edx,ax
    28c0:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    28c3:	89 d0                	mov    eax,edx
    28c5:	01 c0                	add    eax,eax
    28c7:	01 d0                	add    eax,edx
    28c9:	c1 e0 02             	shl    eax,0x2
    28cc:	01 f0                	add    eax,esi
    28ce:	05 10 03 00 00       	add    eax,0x310
    28d3:	8b 00                	mov    eax,DWORD PTR [eax]
    28d5:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    28d9:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    28dd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    28e1:	c7 04 24 7d 07 00 00 	mov    DWORD PTR [esp],0x77d
    28e8:	e8 fc ff ff ff       	call   28e9 <ahci_reissue_command+0x9e>
		list_add_tail(&cc->lst, &ad->pending_cmds[cc->port]);
    28ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    28f0:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    28f4:	0f b7 d0             	movzx  edx,ax
    28f7:	89 d0                	mov    eax,edx
    28f9:	01 c0                	add    eax,eax
    28fb:	01 d0                	add    eax,edx
    28fd:	c1 e0 02             	shl    eax,0x2
    2900:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    2906:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2909:	01 c2                	add    edx,eax
    290b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    290e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2912:	89 04 24             	mov    DWORD PTR [esp],eax
    2915:	e8 b7 d7 ff ff       	call   d1 <list_add_tail>
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    291a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    291d:	05 10 06 00 00       	add    eax,0x610
    2922:	ba 01 00 00 00       	mov    edx,0x1
    2927:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    292b:	85 d2                	test   edx,edx
    292d:	75 10                	jne    293f <ahci_reissue_command+0xf4>
				/* wake worker */
				wake_up_external_event(&ad->wh);
    292f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2932:	05 20 06 00 00       	add    eax,0x620
    2937:	89 04 24             	mov    DWORD PTR [esp],eax
    293a:	e8 fc ff ff ff       	call   293b <ahci_reissue_command+0xf0>
		}
}
    293f:	90                   	nop
    2940:	83 c4 10             	add    esp,0x10
    2943:	5b                   	pop    ebx
    2944:	5e                   	pop    esi
    2945:	5d                   	pop    ebp
    2946:	c3                   	ret

00002947 <ahci_issue_command>:

void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st)
{
    2947:	55                   	push   ebp
    2948:	89 e5                	mov    ebp,esp
    294a:	83 ec 38             	sub    esp,0x38
    294d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    2950:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    2953:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    2956:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    2959:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    295c:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    295f:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
    2962:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		iprintf("  ISSUE: %d %u\n", port, cmd);
    2965:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2968:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    296c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    296f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2973:	c7 04 24 8b 07 00 00 	mov    DWORD PTR [esp],0x78b
    297a:	e8 fc ff ff ff       	call   297b <ahci_issue_command+0x34>
		struct cmd_ctx* cc = ahci_allocate_context(ad);
    297f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2982:	89 04 24             	mov    DWORD PTR [esp],eax
    2985:	e8 fc ff ff ff       	call   2986 <ahci_issue_command+0x3f>
    298a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		cc->c = cmd;
    298d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2990:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    2993:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		cc->lba = lba;
    2996:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2999:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    299c:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    299f:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
    29a2:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
		cc->ct = ct;
    29a5:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    29a8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    29ab:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    29ae:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    29b1:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
		cc->ptr = ptr;
    29b4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29b7:	8b 55 28             	mov    edx,DWORD PTR [ebp+0x28]
    29ba:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
		cc->wq_wake = wq_h;
    29bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29c0:	8b 55 2c             	mov    edx,DWORD PTR [ebp+0x2c]
    29c3:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
		cc->pmprt = pmprt;
    29c6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    29c9:	89 c2                	mov    edx,eax
    29cb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29ce:	66 89 50 24          	mov    WORD PTR [eax+0x24],dx
		cc->port = port;
    29d2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    29d5:	89 c2                	mov    edx,eax
    29d7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29da:	66 89 50 30          	mov    WORD PTR [eax+0x30],dx
		cc->status = st;
    29de:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29e1:	8b 55 30             	mov    edx,DWORD PTR [ebp+0x30]
    29e4:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
		if (st) {
    29e7:	83 7d 30 00          	cmp    DWORD PTR [ebp+0x30],0x0
    29eb:	74 1c                	je     2a09 <ahci_issue_command+0xc2>
				bzero(st, sizeof(*st));
    29ed:	c7 44 24 04 18 00 00 00 	mov    DWORD PTR [esp+0x4],0x18
    29f5:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
    29f8:	89 04 24             	mov    DWORD PTR [esp],eax
    29fb:	e8 fc ff ff ff       	call   29fc <ahci_issue_command+0xb5>
				st->state = cmd_state_pending;
    2a00:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
    2a03:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		}
		list_add_tail(&cc->lst, &ad->pending_cmds[port]);
    2a09:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2a0c:	89 d0                	mov    eax,edx
    2a0e:	01 c0                	add    eax,eax
    2a10:	01 d0                	add    eax,edx
    2a12:	c1 e0 02             	shl    eax,0x2
    2a15:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    2a1b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a1e:	01 c2                	add    edx,eax
    2a20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a23:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2a27:	89 04 24             	mov    DWORD PTR [esp],eax
    2a2a:	e8 a2 d6 ff ff       	call   d1 <list_add_tail>
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
    2a2f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a32:	05 10 06 00 00       	add    eax,0x610
    2a37:	ba 01 00 00 00       	mov    edx,0x1
    2a3c:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    2a40:	85 d2                	test   edx,edx
    2a42:	75 10                	jne    2a54 <ahci_issue_command+0x10d>
				/*  wake worker */
				wake_up_external_event(&ad->wh);
    2a44:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a47:	05 20 06 00 00       	add    eax,0x620
    2a4c:	89 04 24             	mov    DWORD PTR [esp],eax
    2a4f:	e8 fc ff ff ff       	call   2a50 <ahci_issue_command+0x109>
		}
}
    2a54:	90                   	nop
    2a55:	c9                   	leave
    2a56:	c3                   	ret

00002a57 <ahci_do_bohc>:

int ahci_do_bohc(struct ahci_device* ad)
{
    2a57:	55                   	push   ebp
    2a58:	89 e5                	mov    ebp,esp
    2a5a:	83 ec 28             	sub    esp,0x28
		struct ahci_hba* hba = ad->ptr;
    2a5d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a60:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2a63:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (hba->cap2.boh) {
    2a66:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2a69:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2a6c:	83 e0 01             	and    eax,0x1
    2a6f:	84 c0                	test   al,al
    2a71:	0f 84 a4 00 00 00    	je     2b1b <ahci_do_bohc+0xc4>
				abprintf("performing AHCI BIOS handover...\n");
    2a77:	c7 04 24 9c 07 00 00 	mov    DWORD PTR [esp],0x79c
    2a7e:	e8 fc ff ff ff       	call   2a7f <ahci_do_bohc+0x28>
				preempt_disable();
    2a83:	e8 fc ff ff ff       	call   2a84 <ahci_do_bohc+0x2d>
    2a88:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2a8b:	83 c2 01             	add    edx,0x1
    2a8e:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				hba->bohc |= BOHC_OOS;
    2a91:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2a94:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2a97:	83 c8 02             	or     eax,0x2
    2a9a:	89 c2                	mov    edx,eax
    2a9c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2a9f:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
				/* SMI is issued */
				if (hba->bohc & BOHC_BOS) { /* we have to wait */
    2aa2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2aa5:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2aa8:	83 e0 01             	and    eax,0x1
    2aab:	85 c0                	test   eax,eax
    2aad:	74 4b                	je     2afa <ahci_do_bohc+0xa3>
						mdelay(25);
    2aaf:	c7 04 24 19 00 00 00 	mov    DWORD PTR [esp],0x19
    2ab6:	e8 fc ff ff ff       	call   2ab7 <ahci_do_bohc+0x60>
						if (hba->bohc & BOHC_BB) { /* BIOS does it */
    2abb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2abe:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2ac1:	83 e0 10             	and    eax,0x10
    2ac4:	85 c0                	test   eax,eax
    2ac6:	74 32                	je     2afa <ahci_do_bohc+0xa3>
								int to = 30;
    2ac8:	c7 45 f4 1e 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1e
								while (hba->bohc & BOHC_BOS) {
    2acf:	eb 19                	jmp    2aea <ahci_do_bohc+0x93>
										mdelay(100);
    2ad1:	c7 04 24 64 00 00 00 	mov    DWORD PTR [esp],0x64
    2ad8:	e8 fc ff ff ff       	call   2ad9 <ahci_do_bohc+0x82>
										if (!to--) /* abort after 3 seconds */
    2add:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2ae0:	8d 50 ff             	lea    edx,[eax-0x1]
    2ae3:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2ae6:	85 c0                	test   eax,eax
    2ae8:	74 0f                	je     2af9 <ahci_do_bohc+0xa2>
								while (hba->bohc & BOHC_BOS) {
    2aea:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2aed:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2af0:	83 e0 01             	and    eax,0x1
    2af3:	85 c0                	test   eax,eax
    2af5:	75 da                	jne    2ad1 <ahci_do_bohc+0x7a>
    2af7:	eb 01                	jmp    2afa <ahci_do_bohc+0xa3>
												break;
    2af9:	90                   	nop
								}
						} else {;} /* we have to clean up */
				}
				/* we're done */
				preempt_enable();
    2afa:	e8 fc ff ff ff       	call   2afb <ahci_do_bohc+0xa4>
    2aff:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2b02:	83 ea 01             	sub    edx,0x1
    2b05:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    2b08:	e8 fc ff ff ff       	call   2b09 <ahci_do_bohc+0xb2>
    2b0d:	8b 00                	mov    eax,DWORD PTR [eax]
    2b0f:	83 e0 01             	and    eax,0x1
    2b12:	85 c0                	test   eax,eax
    2b14:	74 05                	je     2b1b <ahci_do_bohc+0xc4>
    2b16:	e8 fc ff ff ff       	call   2b17 <ahci_do_bohc+0xc0>
		}
		/* always acquire (we're only nice to inform the bios) */
		return 0;
    2b1b:	b8 00 00 00 00       	mov    eax,0x0
}
    2b20:	c9                   	leave
    2b21:	c3                   	ret

00002b22 <ahci_reset_port>:

void ahci_reset_port(struct ahci_hba* h, struct ahci_port* p)
{
    2b22:	55                   	push   ebp
    2b23:	89 e5                	mov    ebp,esp
    2b25:	83 ec 18             	sub    esp,0x18
		/* cap.sclo? */
		die("not impl %p %p\n", h, p);
    2b28:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b2b:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    2b2f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b32:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2b36:	c7 44 24 04 be 07 00 00 	mov    DWORD PTR [esp+0x4],0x7be
    2b3e:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2b45:	e8 fc ff ff ff       	call   2b46 <ahci_reset_port+0x24>
    2b4a:	e8 fc ff ff ff       	call   2b4b <ahci_reset_port+0x29>
    2b4f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2b56:	e8 fc ff ff ff       	call   2b57 <ahci_reset_port+0x35>
    2b5b:	fa                   	cli
    2b5c:	f4                   	hlt
    2b5d:	eb fd                	jmp    2b5c <ahci_reset_port+0x3a>

00002b5f <ahci_port_activate_device>:
}

void ahci_port_activate_device(struct ahci_hba* h, struct ahci_port* p)
{
    2b5f:	55                   	push   ebp
    2b60:	89 e5                	mov    ebp,esp
    2b62:	56                   	push   esi
    2b63:	53                   	push   ebx
    2b64:	83 ec 30             	sub    esp,0x30
		abprintf("activate port %zd:\n", p - h->port);
    2b67:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b6a:	05 00 01 00 00       	add    eax,0x100
    2b6f:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2b72:	29 c2                	sub    edx,eax
    2b74:	89 d0                	mov    eax,edx
    2b76:	c1 f8 07             	sar    eax,0x7
    2b79:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b7d:	c7 04 24 ce 07 00 00 	mov    DWORD PTR [esp],0x7ce
    2b84:	e8 fc ff ff ff       	call   2b85 <ahci_port_activate_device+0x26>
		/* first check the presence flag */
		if (p->scr0.det == DET_NOT_PRESENT) {
    2b89:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b8c:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2b8f:	83 e0 0f             	and    eax,0xf
    2b92:	84 c0                	test   al,al
    2b94:	0f 85 e9 01 00 00    	jne    2d83 <ahci_port_activate_device+0x224>
				abprintf("activate: DET_NOT_PRESENT\n");
    2b9a:	c7 04 24 e2 07 00 00 	mov    DWORD PTR [esp],0x7e2
    2ba1:	e8 fc ff ff ff       	call   2ba2 <ahci_port_activate_device+0x43>
				/* nothing attached? */
				if (p->cmd.cpd) { /* we rely on CPD */
    2ba6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ba9:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2bac:	c1 e8 14             	shr    eax,0x14
    2baf:	83 e0 01             	and    eax,0x1
    2bb2:	84 c0                	test   al,al
    2bb4:	74 5a                	je     2c10 <ahci_port_activate_device+0xb1>
						if (!p->cmd.cps) {
    2bb6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2bb9:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2bbc:	c1 e8 10             	shr    eax,0x10
    2bbf:	83 e0 01             	and    eax,0x1
    2bc2:	84 c0                	test   al,al
    2bc4:	75 11                	jne    2bd7 <ahci_port_activate_device+0x78>
								abprintf("confirmed by CPD\n");
    2bc6:	c7 04 24 fd 07 00 00 	mov    DWORD PTR [esp],0x7fd
    2bcd:	e8 fc ff ff ff       	call   2bce <ahci_port_activate_device+0x6f>
								return;
    2bd2:	e9 76 03 00 00       	jmp    2f4d <ahci_port_activate_device+0x3ee>
						}
						/* there's something */
						if (!p->cmd.pod) {
    2bd7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2bda:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2bdd:	c1 e8 02             	shr    eax,0x2
    2be0:	83 e0 01             	and    eax,0x1
    2be3:	84 c0                	test   al,al
    2be5:	75 18                	jne    2bff <ahci_port_activate_device+0xa0>
								p->cmd.pod = 1; /* power it */
    2be7:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2bea:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2bed:	83 c8 04             	or     eax,0x4
    2bf0:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
								ndelay(20);
    2bf3:	c7 04 24 14 00 00 00 	mov    DWORD PTR [esp],0x14
    2bfa:	e8 fc ff ff ff       	call   2bfb <ahci_port_activate_device+0x9c>
						}
						if (p->scr0.det != DET_NOT_PRESENT)
    2bff:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c02:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2c05:	83 e0 0f             	and    eax,0xf
    2c08:	84 c0                	test   al,al
    2c0a:	0f 85 76 01 00 00    	jne    2d86 <ahci_port_activate_device+0x227>
								goto next_step;
				}
				/* spin-up? */
				if (!p->cmd.sud) { /* always !1 if cap.sss == 0 */
    2c10:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c13:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2c16:	d1 e8                	shr    eax,1
    2c18:	83 e0 01             	and    eax,0x1
    2c1b:	84 c0                	test   al,al
    2c1d:	0f 85 e7 00 00 00    	jne    2d0a <ahci_port_activate_device+0x1ab>
						abprintf("not spun-up yet?\n");
    2c23:	c7 04 24 0f 08 00 00 	mov    DWORD PTR [esp],0x80f
    2c2a:	e8 fc ff ff ff       	call   2c2b <ahci_port_activate_device+0xcc>
						if (p->pXserr & (1 << 26)) /* eXchange bit */
    2c2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c32:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2c35:	25 00 00 00 04       	and    eax,0x4000000
    2c3a:	85 c0                	test   eax,eax
    2c3c:	74 13                	je     2c51 <ahci_port_activate_device+0xf2>
								p->pXserr |= (1 << 26); /* RWC */
    2c3e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c41:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2c44:	0d 00 00 00 04       	or     eax,0x4000000
    2c49:	89 c2                	mov    edx,eax
    2c4b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c4e:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
						if (p->scr2.det != 0) { /* set to 0 prior sud */
    2c51:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c54:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2c57:	c1 e8 1c             	shr    eax,0x1c
    2c5a:	84 c0                	test   al,al
    2c5c:	74 1a                	je     2c78 <ahci_port_activate_device+0x119>
								p->scr2.det = 0;
    2c5e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2c61:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2c64:	25 ff ff ff 0f       	and    eax,0xfffffff
    2c69:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
								ndelay(20);
    2c6c:	c7 04 24 14 00 00 00 	mov    DWORD PTR [esp],0x14
    2c73:	e8 fc ff ff ff       	call   2c74 <ahci_port_activate_device+0x115>
						}
						p->cmd.sud = 1;
    2c78:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2c7b:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2c7e:	83 c8 02             	or     eax,0x2
    2c81:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						udelay(50); /* wait 50 mus */
    2c84:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
    2c8b:	e8 fc ff ff ff       	call   2c8c <ahci_port_activate_device+0x12d>
						if (p->pXserr & ((1 << 26) | (1 << 18))) { /* received sth. */
    2c90:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2c93:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2c96:	25 00 00 04 04       	and    eax,0x4040000
    2c9b:	85 c0                	test   eax,eax
    2c9d:	0f 85 e6 00 00 00    	jne    2d89 <ahci_port_activate_device+0x22a>
								/* COMRESET, COMWAKE */
								goto next_step;
						}
						/* send the reset */
						p->scr2.det = 1;
    2ca3:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2ca6:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2ca9:	25 ff ff ff 0f       	and    eax,0xfffffff
    2cae:	0d 00 00 00 10       	or     eax,0x10000000
    2cb3:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
						mdelay(1);
    2cb6:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
    2cbd:	e8 fc ff ff ff       	call   2cbe <ahci_port_activate_device+0x15f>
						p->scr2.det = 0;
    2cc2:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2cc5:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2cc8:	25 ff ff ff 0f       	and    eax,0xfffffff
    2ccd:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
						udelay(50);
    2cd0:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
    2cd7:	e8 fc ff ff ff       	call   2cd8 <ahci_port_activate_device+0x179>
						if (p->scr0.det != DET_NOT_PRESENT)
    2cdc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2cdf:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2ce2:	83 e0 0f             	and    eax,0xf
    2ce5:	84 c0                	test   al,al
    2ce7:	0f 85 9f 00 00 00    	jne    2d8c <ahci_port_activate_device+0x22d>
								goto next_step;
						p->cmd.sud = 0; /* we're done enter listening mode */
    2ced:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2cf0:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2cf3:	83 e0 fd             	and    eax,0xfffffffd
    2cf6:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						abprintf("not present\n");
    2cf9:	c7 04 24 21 08 00 00 	mov    DWORD PTR [esp],0x821
    2d00:	e8 fc ff ff ff       	call   2d01 <ahci_port_activate_device+0x1a2>
						goto exit;
    2d05:	e9 20 02 00 00       	jmp    2f2a <ahci_port_activate_device+0x3cb>
				}
				/* just try ICC */
				if (p->scr0.ipm != 1) {
    2d0a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d0d:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2d10:	c1 e8 08             	shr    eax,0x8
    2d13:	83 e0 0f             	and    eax,0xf
    2d16:	3c 01                	cmp    al,0x1
    2d18:	74 69                	je     2d83 <ahci_port_activate_device+0x224>
						abprintf("IPM != ACTIVE\n");
    2d1a:	c7 04 24 2e 08 00 00 	mov    DWORD PTR [esp],0x82e
    2d21:	e8 fc ff ff ff       	call   2d22 <ahci_port_activate_device+0x1c3>
						int ct = 50;
    2d26:	c7 45 f4 32 00 00 00 	mov    DWORD PTR [ebp-0xc],0x32
						while (p->cmd.icc && ct--)
    2d2d:	eb 0c                	jmp    2d3b <ahci_port_activate_device+0x1dc>
								udelay(10);
    2d2f:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    2d36:	e8 fc ff ff ff       	call   2d37 <ahci_port_activate_device+0x1d8>
						while (p->cmd.icc && ct--)
    2d3b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d3e:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2d41:	c1 e8 1c             	shr    eax,0x1c
    2d44:	84 c0                	test   al,al
    2d46:	74 0d                	je     2d55 <ahci_port_activate_device+0x1f6>
    2d48:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2d4b:	8d 50 ff             	lea    edx,[eax-0x1]
    2d4e:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2d51:	85 c0                	test   eax,eax
    2d53:	75 da                	jne    2d2f <ahci_port_activate_device+0x1d0>
						p->cmd.icc = 1;
    2d55:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2d58:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2d5b:	25 ff ff ff 0f       	and    eax,0xfffffff
    2d60:	0d 00 00 00 10       	or     eax,0x10000000
    2d65:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
						mdelay(10);
    2d68:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    2d6f:	e8 fc ff ff ff       	call   2d70 <ahci_port_activate_device+0x211>
						if (p->scr0.det != DET_NOT_PRESENT)
    2d74:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d77:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2d7a:	83 e0 0f             	and    eax,0xf
    2d7d:	84 c0                	test   al,al
    2d7f:	74 0e                	je     2d8f <ahci_port_activate_device+0x230>
								goto next_step;
    2d81:	eb 1d                	jmp    2da0 <ahci_port_activate_device+0x241>
						goto exit;
				}
		}

		/* det != 1*/
next_step:
    2d83:	90                   	nop
    2d84:	eb 1a                	jmp    2da0 <ahci_port_activate_device+0x241>
								goto next_step;
    2d86:	90                   	nop
    2d87:	eb 17                	jmp    2da0 <ahci_port_activate_device+0x241>
								goto next_step;
    2d89:	90                   	nop
    2d8a:	eb 14                	jmp    2da0 <ahci_port_activate_device+0x241>
								goto next_step;
    2d8c:	90                   	nop
    2d8d:	eb 11                	jmp    2da0 <ahci_port_activate_device+0x241>
						abprintf("unable to set to active\n");
    2d8f:	c7 04 24 3d 08 00 00 	mov    DWORD PTR [esp],0x83d
    2d96:	e8 fc ff ff ff       	call   2d97 <ahci_port_activate_device+0x238>
						goto exit;
    2d9b:	e9 8a 01 00 00       	jmp    2f2a <ahci_port_activate_device+0x3cb>
		if (p->scr0.det == DET_PRESENT) {
    2da0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2da3:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2da6:	83 e0 0f             	and    eax,0xf
    2da9:	3c 03                	cmp    al,0x3
    2dab:	0f 85 3c 01 00 00    	jne    2eed <ahci_port_activate_device+0x38e>
				/* almost done */
				if (p->scr0.ipm != IPM_ACTIVE) {
    2db1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2db4:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2db7:	c1 e8 08             	shr    eax,0x8
    2dba:	83 e0 0f             	and    eax,0xf
    2dbd:	3c 01                	cmp    al,0x1
    2dbf:	0f 84 ae 00 00 00    	je     2e73 <ahci_port_activate_device+0x314>
						int ct, wc;
						abprintf("Present but not active.\n");
    2dc5:	c7 04 24 56 08 00 00 	mov    DWORD PTR [esp],0x856
    2dcc:	e8 fc ff ff ff       	call   2dcd <ahci_port_activate_device+0x26e>
activ:
						ct = 50, wc = 0;
    2dd1:	c7 45 f0 32 00 00 00 	mov    DWORD PTR [ebp-0x10],0x32
    2dd8:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
rewait:
						while (p->cmd.icc && ct--) /* 500ms */
    2ddf:	eb 0c                	jmp    2ded <ahci_port_activate_device+0x28e>
								mdelay(10);
    2de1:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    2de8:	e8 fc ff ff ff       	call   2de9 <ahci_port_activate_device+0x28a>
						while (p->cmd.icc && ct--) /* 500ms */
    2ded:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2df0:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2df3:	c1 e8 1c             	shr    eax,0x1c
    2df6:	84 c0                	test   al,al
    2df8:	74 0d                	je     2e07 <ahci_port_activate_device+0x2a8>
    2dfa:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2dfd:	8d 50 ff             	lea    edx,[eax-0x1]
    2e00:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    2e03:	85 c0                	test   eax,eax
    2e05:	75 da                	jne    2de1 <ahci_port_activate_device+0x282>
						if (p->scr0.ipm != IPM_ACTIVE && !wc) {
    2e07:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e0a:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2e0d:	c1 e8 08             	shr    eax,0x8
    2e10:	83 e0 0f             	and    eax,0xf
    2e13:	3c 01                	cmp    al,0x1
    2e15:	74 32                	je     2e49 <ahci_port_activate_device+0x2ea>
    2e17:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2e1b:	75 2c                	jne    2e49 <ahci_port_activate_device+0x2ea>
								p->cmd.icc = 1;
    2e1d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2e20:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2e23:	25 ff ff ff 0f       	and    eax,0xfffffff
    2e28:	0d 00 00 00 10       	or     eax,0x10000000
    2e2d:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
								ndelay(50);
    2e30:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
    2e37:	e8 fc ff ff ff       	call   2e38 <ahci_port_activate_device+0x2d9>
								wc++; ct = 50;
    2e3c:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    2e40:	c7 45 f0 32 00 00 00 	mov    DWORD PTR [ebp-0x10],0x32
								goto rewait;
    2e47:	eb 96                	jmp    2ddf <ahci_port_activate_device+0x280>
						}
						if (wc) {
    2e49:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2e4d:	74 24                	je     2e73 <ahci_port_activate_device+0x314>
								/* reset */
								p->scr2.det = 1;
    2e4f:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2e52:	8b 42 2c             	mov    eax,DWORD PTR [edx+0x2c]
    2e55:	25 ff ff ff 0f       	and    eax,0xfffffff
    2e5a:	0d 00 00 00 10       	or     eax,0x10000000
    2e5f:	89 42 2c             	mov    DWORD PTR [edx+0x2c],eax
								mdelay(1);
    2e62:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
    2e69:	e8 fc ff ff ff       	call   2e6a <ahci_port_activate_device+0x30b>
								goto next_step;
    2e6e:	e9 2d ff ff ff       	jmp    2da0 <ahci_port_activate_device+0x241>
						}
				}
				abprintf("Device at port %zd is active and present.\n",
						p - h->port);
    2e73:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e76:	05 00 01 00 00       	add    eax,0x100
    2e7b:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2e7e:	29 c2                	sub    edx,eax
				abprintf("Device at port %zd is active and present.\n",
    2e80:	89 d0                	mov    eax,edx
    2e82:	c1 f8 07             	sar    eax,0x7
    2e85:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e89:	c7 04 24 70 08 00 00 	mov    DWORD PTR [esp],0x870
    2e90:	e8 fc ff ff ff       	call   2e91 <ahci_port_activate_device+0x332>
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    2e95:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e98:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2e9b:	c1 e8 08             	shr    eax,0x8
    2e9e:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    2ea1:	0f b6 f0             	movzx  esi,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    2ea4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ea7:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2eaa:	83 e0 0f             	and    eax,0xf
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    2ead:	0f b6 d8             	movzx  ebx,al
						p->tfd.err, p->scr0.det, p->scr0.ipm);
    2eb0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2eb3:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2eb6:	0f b6 c4             	movzx  eax,ah
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
    2eb9:	0f b6 c8             	movzx  ecx,al
    2ebc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ebf:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2ec2:	0f b6 d0             	movzx  edx,al
    2ec5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ec8:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2ecb:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    2ecf:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    2ed3:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    2ed7:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2edb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2edf:	c7 04 24 9b 08 00 00 	mov    DWORD PTR [esp],0x89b
    2ee6:	e8 fc ff ff ff       	call   2ee7 <ahci_port_activate_device+0x388>
				return;
    2eeb:	eb 60                	jmp    2f4d <ahci_port_activate_device+0x3ee>
		} else if (p->scr0.det == DET_PHY_OFFLINE) {
    2eed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ef0:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2ef3:	83 e0 0f             	and    eax,0xf
    2ef6:	3c 04                	cmp    al,0x4
    2ef8:	75 11                	jne    2f0b <ahci_port_activate_device+0x3ac>
				/* just deactivated */
				abprintf("PHY offline mode\n");
    2efa:	c7 04 24 b4 08 00 00 	mov    DWORD PTR [esp],0x8b4
    2f01:	e8 fc ff ff ff       	call   2f02 <ahci_port_activate_device+0x3a3>
				goto activ;
    2f06:	e9 c6 fe ff ff       	jmp    2dd1 <ahci_port_activate_device+0x272>
		} else if (p->scr0.det == DET_PRESENT_NO_PHY) {
    2f0b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2f0e:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2f11:	83 e0 0f             	and    eax,0xf
    2f14:	3c 01                	cmp    al,0x1
    2f16:	75 11                	jne    2f29 <ahci_port_activate_device+0x3ca>
				abprintf("PRESENT_NO_PHY mode\n");
    2f18:	c7 04 24 c6 08 00 00 	mov    DWORD PTR [esp],0x8c6
    2f1f:	e8 fc ff ff ff       	call   2f20 <ahci_port_activate_device+0x3c1>
				goto activ; /* try the same */
    2f24:	e9 a8 fe ff ff       	jmp    2dd1 <ahci_port_activate_device+0x272>
		}
exit:
    2f29:	90                   	nop
				/* we're really done */
				abprintf("Not present at port %zd\n", p - h->port);
    2f2a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f2d:	05 00 01 00 00       	add    eax,0x100
    2f32:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2f35:	29 c2                	sub    edx,eax
    2f37:	89 d0                	mov    eax,edx
    2f39:	c1 f8 07             	sar    eax,0x7
    2f3c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f40:	c7 04 24 db 08 00 00 	mov    DWORD PTR [esp],0x8db
    2f47:	e8 fc ff ff ff       	call   2f48 <ahci_port_activate_device+0x3e9>
				return;
    2f4c:	90                   	nop
}
    2f4d:	83 c4 30             	add    esp,0x30
    2f50:	5b                   	pop    ebx
    2f51:	5e                   	pop    esi
    2f52:	5d                   	pop    ebp
    2f53:	c3                   	ret

00002f54 <ahci_enable_port>:

void ahci_enable_port(struct ahci_device* ad, int pt)
{
    2f54:	55                   	push   ebp
    2f55:	89 e5                	mov    ebp,esp
    2f57:	53                   	push   ebx
    2f58:	83 ec 44             	sub    esp,0x44
		struct ahci_port* p = &ad->ptr->port[pt];
    2f5b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f5e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2f61:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2f64:	83 c2 02             	add    edx,0x2
    2f67:	c1 e2 07             	shl    edx,0x7
    2f6a:	01 d0                	add    eax,edx
    2f6c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		int reset_ct = 0;
    2f6f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    2f76:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f79:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2f7c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2f7f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2f82:	bb 01 00 00 00       	mov    ebx,0x1
    2f87:	89 c1                	mov    ecx,eax
    2f89:	d3 e3                	shl    ebx,cl
    2f8b:	89 d8                	mov    eax,ebx
    2f8d:	21 d0                	and    eax,edx
    2f8f:	85 c0                	test   eax,eax
    2f91:	0f 84 79 02 00 00    	je     3210 <ahci_enable_port+0x2bc>
				return;

Pos1:
    2f97:	90                   	nop
		/* clear old data */
		p->pXserr = 0xffffffff; /* 10.1.2 -> 6. */
    2f98:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f9b:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
		p->pXis = 0xffffffff; /* clear all pending interrupts */
    2fa2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fa5:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [eax+0x10],0xffffffff

		/* first allow for the reception of FISes */
		p->cmd.fre = 1;
    2fac:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2faf:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    2fb2:	83 c8 10             	or     eax,0x10
    2fb5:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		ndelay(20); /* wait for BSY to show up */
    2fb8:	c7 04 24 14 00 00 00 	mov    DWORD PTR [esp],0x14
    2fbf:	e8 fc ff ff ff       	call   2fc0 <ahci_enable_port+0x6c>
		while (1) {
				uint8_t sts = p->tfd.sts;
    2fc4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fc7:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2fca:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
				if (sts & TFS_ERR) {
    2fcd:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    2fd1:	83 e0 01             	and    eax,0x1
    2fd4:	85 c0                	test   eax,eax
    2fd6:	0f 84 eb 00 00 00    	je     30c7 <ahci_enable_port+0x173>
						/* something went wrong! */
						if (sts == 0x7f) /* no device */
    2fdc:	80 7d ef 7f          	cmp    BYTE PTR [ebp-0x11],0x7f
    2fe0:	0f 84 ff 00 00 00    	je     30e5 <ahci_enable_port+0x191>
								break;
						else if (sts == 0x41 && p->tfd.err == 0x20) {
    2fe6:	80 7d ef 41          	cmp    BYTE PTR [ebp-0x11],0x41
    2fea:	75 1e                	jne    300a <ahci_enable_port+0xb6>
    2fec:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fef:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2ff2:	0f b6 c4             	movzx  eax,ah
    2ff5:	3c 20                	cmp    al,0x20
    2ff7:	75 11                	jne    300a <ahci_enable_port+0xb6>
								if (p->pXsig == SIG_ATAPI)
    2ff9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2ffc:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2fff:	3d 01 01 14 eb       	cmp    eax,0xeb140101
    3004:	0f 84 de 00 00 00    	je     30e8 <ahci_enable_port+0x194>
										break; /* no medium */
						}
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
								" while starting up.\n", pt, p->tfd.err);
    300a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    300d:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    3010:	0f b6 c4             	movzx  eax,ah
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
    3013:	0f b6 c0             	movzx  eax,al
    3016:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    301a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    301d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3021:	c7 44 24 04 f4 08 00 00 	mov    DWORD PTR [esp+0x4],0x8f4
    3029:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    3030:	e8 fc ff ff ff       	call   3031 <ahci_enable_port+0xdd>
						abprintf("scr1: %x %x\n", p->scr1.diag, p->scr1.err);
    3035:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3038:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    303b:	0f b7 d0             	movzx  edx,ax
    303e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3041:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    3044:	c1 e8 10             	shr    eax,0x10
    3047:	0f b7 c0             	movzx  eax,ax
    304a:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    304e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3052:	c7 04 24 2c 09 00 00 	mov    DWORD PTR [esp],0x92c
    3059:	e8 fc ff ff ff       	call   305a <ahci_enable_port+0x106>
						abprintf("tfd: %x %x\n", p->tfd.sts, p->tfd.err);
    305e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3061:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    3064:	0f b6 c4             	movzx  eax,ah
    3067:	0f b6 d0             	movzx  edx,al
    306a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    306d:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    3070:	0f b6 c0             	movzx  eax,al
    3073:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3077:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    307b:	c7 04 24 39 09 00 00 	mov    DWORD PTR [esp],0x939
    3082:	e8 fc ff ff ff       	call   3083 <ahci_enable_port+0x12f>
						p->pXserr = 0xffffffff;
    3087:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    308a:	c7 40 30 ff ff ff ff 	mov    DWORD PTR [eax+0x30],0xffffffff
						if (!reset_ct++) {
    3091:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3094:	8d 50 01             	lea    edx,[eax+0x1]
    3097:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    309a:	85 c0                	test   eax,eax
    309c:	75 1a                	jne    30b8 <ahci_enable_port+0x164>
								ahci_port_activate_device(ad->ptr, p);
    309e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    30a1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    30a4:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    30a7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    30ab:	89 04 24             	mov    DWORD PTR [esp],eax
    30ae:	e8 fc ff ff ff       	call   30af <ahci_enable_port+0x15b>
								goto Pos1;
    30b3:	e9 e0 fe ff ff       	jmp    2f98 <ahci_enable_port+0x44>
						} else if (reset_ct == 1) {
    30b8:	83 7d f4 01          	cmp    DWORD PTR [ebp-0xc],0x1
    30bc:	0f 85 28 01 00 00    	jne    31ea <ahci_enable_port+0x296>
								/*ahci_reset_port(ad->ptr, p);*/
								goto Pos1;
    30c2:	e9 d1 fe ff ff       	jmp    2f98 <ahci_enable_port+0x44>
						} else
								goto defer;
				}
				if (!(sts & (TFS_BSY | TFS_DRQ)))
    30c7:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    30cb:	25 88 00 00 00       	and    eax,0x88
    30d0:	85 c0                	test   eax,eax
    30d2:	74 17                	je     30eb <ahci_enable_port+0x197>
						break;
				udelay(50);
    30d4:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
    30db:	e8 fc ff ff ff       	call   30dc <ahci_enable_port+0x188>
		while (1) {
    30e0:	e9 df fe ff ff       	jmp    2fc4 <ahci_enable_port+0x70>
								break;
    30e5:	90                   	nop
    30e6:	eb 04                	jmp    30ec <ahci_enable_port+0x198>
										break; /* no medium */
    30e8:	90                   	nop
    30e9:	eb 01                	jmp    30ec <ahci_enable_port+0x198>
						break;
    30eb:	90                   	nop
		}

		/* set ST only if BSY,DRQ and DET=3h or IPM=2,6,8 */
		if (p->scr0.det != 3)
    30ec:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    30ef:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    30f2:	83 e0 0f             	and    eax,0xf
    30f5:	3c 03                	cmp    al,0x3
    30f7:	74 15                	je     310e <ahci_enable_port+0x1ba>
				ahci_port_activate_device(ad->ptr, p);
    30f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    30fc:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    30ff:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    3102:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3106:	89 04 24             	mov    DWORD PTR [esp],eax
    3109:	e8 fc ff ff ff       	call   310a <ahci_enable_port+0x1b6>
		if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
    310e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3111:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    3114:	0f b6 c0             	movzx  eax,al
    3117:	25 88 00 00 00       	and    eax,0x88
    311c:	85 c0                	test   eax,eax
    311e:	0f 85 c9 00 00 00    	jne    31ed <ahci_enable_port+0x299>
				goto defer; /* listen */
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    3124:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3127:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    312a:	83 e0 0f             	and    eax,0xf
    312d:	3c 03                	cmp    al,0x3
    312f:	74 34                	je     3165 <ahci_enable_port+0x211>
    3131:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3134:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3137:	c1 e8 08             	shr    eax,0x8
    313a:	83 e0 0f             	and    eax,0xf
    313d:	3c 02                	cmp    al,0x2
    313f:	74 24                	je     3165 <ahci_enable_port+0x211>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    3141:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3144:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3147:	c1 e8 08             	shr    eax,0x8
    314a:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    314d:	3c 06                	cmp    al,0x6
    314f:	74 14                	je     3165 <ahci_enable_port+0x211>
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
    3151:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3154:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3157:	c1 e8 08             	shr    eax,0x8
    315a:	83 e0 0f             	and    eax,0xf
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
    315d:	3c 08                	cmp    al,0x8
    315f:	0f 85 8b 00 00 00    	jne    31f0 <ahci_enable_port+0x29c>
				goto defer;
		/* we're allowed so set it */
		p->cmd.st = 1;
    3165:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    3168:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    316b:	83 c8 01             	or     eax,0x1
    316e:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		/* Change in PhyRdy, CPS, TFS.err, PCS, DPS(I=1), UFS, HBFS, HBDS, IFS, D2HFIS */
		p->pXie = (1 << 22) | (1 << 6) | (1 << 31) | (1 << 30) | (1 << 0)
    3171:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3174:	c7 40 14 71 00 40 f8 	mov    DWORD PTR [eax+0x14],0xf8400071
				| (1 << 5) | (1 << 4) | (1 << 29) | (1 << 28) | (1 << 27);

		/* issue the IDENTIFY_(PACKET)_DEVICE command */
		ahci_issue_command(ad, pt, 0, disk_cmd_identify, 0, 0, NULL, NULL /* wq_worker_ad*/, NULL);
    317b:	c7 44 24 28 00 00 00 00 	mov    DWORD PTR [esp+0x28],0x0
    3183:	c7 44 24 24 00 00 00 00 	mov    DWORD PTR [esp+0x24],0x0
    318b:	c7 44 24 20 00 00 00 00 	mov    DWORD PTR [esp+0x20],0x0
    3193:	c7 44 24 18 00 00 00 00 	mov    DWORD PTR [esp+0x18],0x0
    319b:	c7 44 24 1c 00 00 00 00 	mov    DWORD PTR [esp+0x1c],0x0
    31a3:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    31ab:	c7 44 24 14 00 00 00 00 	mov    DWORD PTR [esp+0x14],0x0
    31b3:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    31bb:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    31c3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    31c6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    31ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    31cd:	89 04 24             	mov    DWORD PTR [esp],eax
    31d0:	e8 fc ff ff ff       	call   31d1 <ahci_enable_port+0x27d>

		printf("port %d is now processing commands\n", pt);
    31d5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    31d8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    31dc:	c7 04 24 48 09 00 00 	mov    DWORD PTR [esp],0x948
    31e3:	e8 fc ff ff ff       	call   31e4 <ahci_enable_port+0x290>
		return;
    31e8:	eb 27                	jmp    3211 <ahci_enable_port+0x2bd>
								goto defer;
    31ea:	90                   	nop
    31eb:	eb 04                	jmp    31f1 <ahci_enable_port+0x29d>
				goto defer; /* listen */
    31ed:	90                   	nop
    31ee:	eb 01                	jmp    31f1 <ahci_enable_port+0x29d>
				goto defer;
    31f0:	90                   	nop

defer: /* we're interested in status changes only */
		abprintf("port %d set to listening mode\n", pt);
    31f1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    31f4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    31f8:	c7 04 24 6c 09 00 00 	mov    DWORD PTR [esp],0x96c
    31ff:	e8 fc ff ff ff       	call   3200 <ahci_enable_port+0x2ac>
		p->pXie = (1 << 22) | (1 << 31) | (1 << 6); /* PhyRdy change, CPS, CCS */
    3204:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3207:	c7 40 14 40 00 40 80 	mov    DWORD PTR [eax+0x14],0x80400040
    320e:	eb 01                	jmp    3211 <ahci_enable_port+0x2bd>
				return;
    3210:	90                   	nop
}
    3211:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    3214:	c9                   	leave
    3215:	c3                   	ret

00003216 <ahci_stop_port>:

void ahci_stop_port(struct ahci_device* ad, int pt)
{
    3216:	55                   	push   ebp
    3217:	89 e5                	mov    ebp,esp
    3219:	53                   	push   ebx
    321a:	83 ec 24             	sub    esp,0x24
		struct ahci_port* p = &ad->ptr->port[pt];
    321d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3220:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3223:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    3226:	83 c2 02             	add    edx,0x2
    3229:	c1 e2 07             	shl    edx,0x7
    322c:	01 d0                	add    eax,edx
    322e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		int ct;

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
    3231:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3234:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3237:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    323a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    323d:	bb 01 00 00 00       	mov    ebx,0x1
    3242:	89 c1                	mov    ecx,eax
    3244:	d3 e3                	shl    ebx,cl
    3246:	89 d8                	mov    eax,ebx
    3248:	21 d0                	and    eax,edx
    324a:	85 c0                	test   eax,eax
    324c:	0f 84 5a 01 00 00    	je     33ac <ahci_stop_port+0x196>
				return;

		/* print the BIOS provided status */
		abprintf("BIOS initial state of port %d:\n", pt);
    3252:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3255:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3259:	c7 04 24 8c 09 00 00 	mov    DWORD PTR [esp],0x98c
    3260:	e8 fc ff ff ff       	call   3261 <ahci_stop_port+0x4b>
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
				p->cmd.st ? "ST" : "");
    3265:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3268:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    326b:	83 e0 01             	and    eax,0x1
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
    326e:	84 c0                	test   al,al
    3270:	74 07                	je     3279 <ahci_stop_port+0x63>
    3272:	ba ac 09 00 00       	mov    edx,0x9ac
    3277:	eb 05                	jmp    327e <ahci_stop_port+0x68>
    3279:	ba ff 02 00 00       	mov    edx,0x2ff
    327e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3281:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3284:	c1 e8 04             	shr    eax,0x4
    3287:	83 e0 01             	and    eax,0x1
    328a:	84 c0                	test   al,al
    328c:	74 07                	je     3295 <ahci_stop_port+0x7f>
    328e:	b8 af 09 00 00       	mov    eax,0x9af
    3293:	eb 05                	jmp    329a <ahci_stop_port+0x84>
    3295:	b8 ff 02 00 00       	mov    eax,0x2ff
    329a:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    329e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    32a2:	c7 04 24 b4 09 00 00 	mov    DWORD PTR [esp],0x9b4
    32a9:	e8 fc ff ff ff       	call   32aa <ahci_stop_port+0x94>
		/* print the pointers */
		abprintf("BIOS command list located at %016llx\n", p->pXclb64);
    32ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    32b1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    32b4:	8b 00                	mov    eax,DWORD PTR [eax]
    32b6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    32ba:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    32be:	c7 04 24 bc 09 00 00 	mov    DWORD PTR [esp],0x9bc
    32c5:	e8 fc ff ff ff       	call   32c6 <ahci_stop_port+0xb0>
		abprintf("BIOS FIS received buffer at  %016llx\n", p->pXfb64);
    32ca:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    32cd:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    32d0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    32d3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    32d7:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    32db:	c7 04 24 e4 09 00 00 	mov    DWORD PTR [esp],0x9e4
    32e2:	e8 fc ff ff ff       	call   32e3 <ahci_stop_port+0xcd>

		/* check if already off */
		if (!p->cmd.fre && !p->cmd.st)
    32e7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    32ea:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    32ed:	c1 e8 04             	shr    eax,0x4
    32f0:	83 e0 01             	and    eax,0x1
    32f3:	84 c0                	test   al,al
    32f5:	75 11                	jne    3308 <ahci_stop_port+0xf2>
    32f7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    32fa:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    32fd:	83 e0 01             	and    eax,0x1
    3300:	84 c0                	test   al,al
    3302:	0f 84 a7 00 00 00    	je     33af <ahci_stop_port+0x199>
				return;

		/* Now turn it off (2x500ms max else reset) */
		ct = 50;
    3308:	c7 45 f4 32 00 00 00 	mov    DWORD PTR [ebp-0xc],0x32
		p->cmd.st = 0;
    330f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    3312:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    3315:	83 e0 fe             	and    eax,0xfffffffe
    3318:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		while (p->cmd.cr && ct--)
    331b:	eb 0c                	jmp    3329 <ahci_stop_port+0x113>
				mdelay(10);
    331d:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    3324:	e8 fc ff ff ff       	call   3325 <ahci_stop_port+0x10f>
		while (p->cmd.cr && ct--)
    3329:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    332c:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    332f:	c1 e8 0f             	shr    eax,0xf
    3332:	83 e0 01             	and    eax,0x1
    3335:	84 c0                	test   al,al
    3337:	74 0d                	je     3346 <ahci_stop_port+0x130>
    3339:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    333c:	8d 50 ff             	lea    edx,[eax-0x1]
    333f:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    3342:	85 c0                	test   eax,eax
    3344:	75 d7                	jne    331d <ahci_stop_port+0x107>
		if (ct == -1)
    3346:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
    334a:	74 40                	je     338c <ahci_stop_port+0x176>
				goto reset;
		ct = 50;
    334c:	c7 45 f4 32 00 00 00 	mov    DWORD PTR [ebp-0xc],0x32
		p->cmd.fre = 0;
    3353:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    3356:	8b 42 18             	mov    eax,DWORD PTR [edx+0x18]
    3359:	83 e0 ef             	and    eax,0xffffffef
    335c:	89 42 18             	mov    DWORD PTR [edx+0x18],eax
		while (p->cmd.fr && ct--)
    335f:	eb 0c                	jmp    336d <ahci_stop_port+0x157>
				mdelay(10);
    3361:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    3368:	e8 fc ff ff ff       	call   3369 <ahci_stop_port+0x153>
		while (p->cmd.fr && ct--)
    336d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3370:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3373:	c1 e8 0e             	shr    eax,0xe
    3376:	83 e0 01             	and    eax,0x1
    3379:	84 c0                	test   al,al
    337b:	74 12                	je     338f <ahci_stop_port+0x179>
    337d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3380:	8d 50 ff             	lea    edx,[eax-0x1]
    3383:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    3386:	85 c0                	test   eax,eax
    3388:	75 d7                	jne    3361 <ahci_stop_port+0x14b>
reset:
    338a:	eb 03                	jmp    338f <ahci_stop_port+0x179>
				goto reset;
    338c:	90                   	nop
    338d:	eb 01                	jmp    3390 <ahci_stop_port+0x17a>
reset:
    338f:	90                   	nop
		if (ct == -1) {
    3390:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
    3394:	75 1a                	jne    33b0 <ahci_stop_port+0x19a>
				printf("Port %d: reset needed!\n", pt);
    3396:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3399:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    339d:	c7 04 24 0a 0a 00 00 	mov    DWORD PTR [esp],0xa0a
    33a4:	e8 fc ff ff ff       	call   33a5 <ahci_stop_port+0x18f>
				/* TODO implement this */
				//ahci_reset_port(ad, pt);
				while (1);
    33a9:	90                   	nop
    33aa:	eb fd                	jmp    33a9 <ahci_stop_port+0x193>
				return;
    33ac:	90                   	nop
    33ad:	eb 01                	jmp    33b0 <ahci_stop_port+0x19a>
				return;
    33af:	90                   	nop
		}
		/* The port is now off innit? */
}
    33b0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    33b3:	c9                   	leave
    33b4:	c3                   	ret

000033b5 <ahci_assign_buffers>:

/* we have ad->num_ports active ports needing num_cmd
 * command slots and one FIS receive buffer each.
 * The command lists are held in a shared pool. */
void ahci_assign_buffers(struct ahci_device* ad)
{
    33b5:	55                   	push   ebp
    33b6:	89 e5                	mov    ebp,esp
    33b8:	53                   	push   ebx
    33b9:	83 ec 64             	sub    esp,0x64
		size_t bt_ct, pg_ct; int flg = MMGR_ALLOC_COMPLETE;
    33bc:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		struct page_range pr; int cc, fc, ic;
		/* Total size: 256*np+1024*np+512*np */
		bt_ct = ad->num_ports * (sizeof(struct ahci_fis)
    33c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33c6:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    33ca:	0f b7 c0             	movzx  eax,ax
    33cd:	69 c0 00 07 00 00    	imul   eax,eax,0x700
    33d3:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				+ sizeof(struct ahci_cmdlst) + 512);
		pg_ct = rdiv(bt_ct, 4096);
    33d6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    33d9:	c1 e8 0c             	shr    eax,0xc
    33dc:	89 c2                	mov    edx,eax
    33de:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    33e1:	25 ff 0f 00 00       	and    eax,0xfff
    33e6:	85 c0                	test   eax,eax
    33e8:	74 07                	je     33f1 <ahci_assign_buffers+0x3c>
    33ea:	b8 01 00 00 00       	mov    eax,0x1
    33ef:	eb 05                	jmp    33f6 <ahci_assign_buffers+0x41>
    33f1:	b8 00 00 00 00       	mov    eax,0x0
    33f6:	01 d0                	add    eax,edx
    33f8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* allocate and map the physical memory */
		ic = cc = fc = ad->num_ports;
    33fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    33fe:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3402:	0f b7 c0             	movzx  eax,ax
    3405:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    3408:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    340b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    340e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3411:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!ad->ptr->cap.is_64bit)
    3414:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3417:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    341a:	8b 00                	mov    eax,DWORD PTR [eax]
    341c:	c1 e8 1f             	shr    eax,0x1f
    341f:	84 c0                	test   al,al
    3421:	0f 85 bb 02 00 00    	jne    36e2 <ahci_assign_buffers+0x32d>
				flg = MMGR_ALLOC_32BIT;
    3427:	c7 45 f0 00 00 04 00 	mov    DWORD PTR [ebp-0x10],0x40000
		while (pg_ct) {
    342e:	e9 af 02 00 00       	jmp    36e2 <ahci_assign_buffers+0x32d>
				void* ptr; size_t nb;
				/* we don't need contiguous memory */
				pg_ct -= mm_alloc_pm_flg(pg_ct, &pr, 1, flg);
    3433:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3436:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    343a:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    3442:	8d 45 c0             	lea    eax,[ebp-0x40]
    3445:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3449:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    344c:	89 04 24             	mov    DWORD PTR [esp],eax
    344f:	e8 fc ff ff ff       	call   3450 <ahci_assign_buffers+0x9b>
    3454:	29 45 f4             	sub    DWORD PTR [ebp-0xc],eax
				if (!pr.count)
    3457:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    345a:	85 c0                	test   eax,eax
    345c:	0f 84 8f 02 00 00    	je     36f1 <ahci_assign_buffers+0x33c>
						goto quit;
				nb = 4096 * pr.count;
    3462:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3465:	c1 e0 0c             	shl    eax,0xc
    3468:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, /*MMGR_MAP_MMIO | <- 0xe nope */
    346b:	c7 44 24 10 2c 00 00 00 	mov    DWORD PTR [esp+0x10],0x2c
    3473:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    347b:	8d 45 c0             	lea    eax,[ebp-0x40]
    347e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3482:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    348a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3491:	e8 fc ff ff ff       	call   3492 <ahci_assign_buffers+0xdd>
    3496:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!ptr)
    3499:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    349d:	0f 84 51 02 00 00    	je     36f4 <ahci_assign_buffers+0x33f>
						goto quit;

				/* now first process the command lists with 1K-alignment */
				while (cc && nb >= 1024) {
    34a3:	e9 82 00 00 00       	jmp    352a <ahci_assign_buffers+0x175>
						int pt = ad->num_ports - cc--;
    34a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34ab:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    34af:	0f b7 c8             	movzx  ecx,ax
    34b2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    34b5:	8d 50 ff             	lea    edx,[eax-0x1]
    34b8:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    34bb:	29 c1                	sub    ecx,eax
    34bd:	89 ca                	mov    edx,ecx
    34bf:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
						if (ad->ptr->ports & (1 << pt)) {
    34c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34c5:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    34c8:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    34cb:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    34ce:	bb 01 00 00 00       	mov    ebx,0x1
    34d3:	89 c1                	mov    ecx,eax
    34d5:	d3 e3                	shl    ebx,cl
    34d7:	89 d8                	mov    eax,ebx
    34d9:	21 d0                	and    eax,edx
    34db:	85 c0                	test   eax,eax
    34dd:	74 4b                	je     352a <ahci_assign_buffers+0x175>
								/* assign for implemented port */
								ad->ptr->port[pt].pXclb64 = pr.base;
    34df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34e2:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    34e5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    34e8:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    34eb:	8b 5d d4             	mov    ebx,DWORD PTR [ebp-0x2c]
    34ee:	83 c3 02             	add    ebx,0x2
    34f1:	c1 e3 07             	shl    ebx,0x7
    34f4:	01 d9                	add    ecx,ebx
    34f6:	89 01                	mov    DWORD PTR [ecx],eax
    34f8:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								ad->command_lists[pt] = ptr;
    34fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    34fe:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    3501:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    3504:	89 4c 90 0c          	mov    DWORD PTR [eax+edx*4+0xc],ecx
								/* advance */
								pr.base += 1024;
    3508:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    350b:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    350e:	05 00 04 00 00       	add    eax,0x400
    3513:	83 d2 00             	adc    edx,0x0
    3516:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    3519:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								nb -= 1024;
    351c:	81 6d dc 00 04 00 00 	sub    DWORD PTR [ebp-0x24],0x400
								ptr += 1024;
    3523:	81 45 e0 00 04 00 00 	add    DWORD PTR [ebp-0x20],0x400
				while (cc && nb >= 1024) {
    352a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    352e:	0f 84 98 00 00 00    	je     35cc <ahci_assign_buffers+0x217>
    3534:	81 7d dc ff 03 00 00 	cmp    DWORD PTR [ebp-0x24],0x3ff
    353b:	0f 87 67 ff ff ff    	ja     34a8 <ahci_assign_buffers+0xf3>
						}
				}

				/* then the FIS buffers (256bt-aligned) */
				while (fc && nb >= 256) {
    3541:	e9 86 00 00 00       	jmp    35cc <ahci_assign_buffers+0x217>
						int pt = ad->num_ports - fc--;
    3546:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3549:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    354d:	0f b7 c8             	movzx  ecx,ax
    3550:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3553:	8d 50 ff             	lea    edx,[eax-0x1]
    3556:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    3559:	29 c1                	sub    ecx,eax
    355b:	89 ca                	mov    edx,ecx
    355d:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
						if (ad->ptr->ports & (1 << pt)) {
    3560:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3563:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3566:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    3569:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    356c:	bb 01 00 00 00       	mov    ebx,0x1
    3571:	89 c1                	mov    ecx,eax
    3573:	d3 e3                	shl    ebx,cl
    3575:	89 d8                	mov    eax,ebx
    3577:	21 d0                	and    eax,edx
    3579:	85 c0                	test   eax,eax
    357b:	74 4f                	je     35cc <ahci_assign_buffers+0x217>
								/* as above */
								ad->ptr->port[pt].pXfb64 = pr.base;
    357d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3580:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    3583:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3586:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    3589:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
    358c:	83 c3 02             	add    ebx,0x2
    358f:	c1 e3 07             	shl    ebx,0x7
    3592:	01 d9                	add    ecx,ebx
    3594:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    3597:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
								ad->recv_fis[pt] = ptr;
    359a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    359d:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    35a0:	8d 4a 20             	lea    ecx,[edx+0x20]
    35a3:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    35a6:	89 54 88 0c          	mov    DWORD PTR [eax+ecx*4+0xc],edx
								/* advance */
								pr.base += 256;
    35aa:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    35ad:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    35b0:	05 00 01 00 00       	add    eax,0x100
    35b5:	83 d2 00             	adc    edx,0x0
    35b8:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    35bb:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								nb -= 256;
    35be:	81 6d dc 00 01 00 00 	sub    DWORD PTR [ebp-0x24],0x100
								ptr += 256;
    35c5:	81 45 e0 00 01 00 00 	add    DWORD PTR [ebp-0x20],0x100
				while (fc && nb >= 256) {
    35cc:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    35d0:	0f 84 b4 00 00 00    	je     368a <ahci_assign_buffers+0x2d5>
    35d6:	81 7d dc ff 00 00 00 	cmp    DWORD PTR [ebp-0x24],0xff
    35dd:	0f 87 63 ff ff ff    	ja     3546 <ahci_assign_buffers+0x191>
						}
				}

				while (ic && nb >= 512) {
    35e3:	e9 a2 00 00 00       	jmp    368a <ahci_assign_buffers+0x2d5>
						int pt = ad->num_ports - ic--;
    35e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    35eb:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    35ef:	0f b7 c8             	movzx  ecx,ax
    35f2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    35f5:	8d 50 ff             	lea    edx,[eax-0x1]
    35f8:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    35fb:	29 c1                	sub    ecx,eax
    35fd:	89 ca                	mov    edx,ecx
    35ff:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						if (ad->ptr->ports & (1 << pt)) {
    3602:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3605:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3608:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    360b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    360e:	bb 01 00 00 00       	mov    ebx,0x1
    3613:	89 c1                	mov    ecx,eax
    3615:	d3 e3                	shl    ebx,cl
    3617:	89 d8                	mov    eax,ebx
    3619:	21 d0                	and    eax,edx
    361b:	85 c0                	test   eax,eax
    361d:	74 54                	je     3673 <ahci_assign_buffers+0x2be>
								/* as above */
								ad->identify_data[pt].pm = pr.base;
    361f:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3622:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    3625:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    3628:	8b 5d cc             	mov    ebx,DWORD PTR [ebp-0x34]
    362b:	83 c3 10             	add    ebx,0x10
    362e:	c1 e3 04             	shl    ebx,0x4
    3631:	01 d9                	add    ecx,ebx
    3633:	89 41 14             	mov    DWORD PTR [ecx+0x14],eax
    3636:	89 51 18             	mov    DWORD PTR [ecx+0x18],edx
								ad->identify_data[pt].ptr = ptr;
    3639:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    363c:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    363f:	83 c2 10             	add    edx,0x10
    3642:	c1 e2 04             	shl    edx,0x4
    3645:	01 d0                	add    eax,edx
    3647:	8d 50 10             	lea    edx,[eax+0x10]
    364a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    364d:	89 02                	mov    DWORD PTR [edx],eax
								/* advance */
								pr.base += 512;
    364f:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3652:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    3655:	05 00 02 00 00       	add    eax,0x200
    365a:	83 d2 00             	adc    edx,0x0
    365d:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    3660:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
								nb -= 512;
    3663:	81 6d dc 00 02 00 00 	sub    DWORD PTR [ebp-0x24],0x200
								ptr += 512;
    366a:	81 45 e0 00 02 00 00 	add    DWORD PTR [ebp-0x20],0x200
    3671:	eb 17                	jmp    368a <ahci_assign_buffers+0x2d5>
						} else
								ad->identify_data[pt].sig = 0;
    3673:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3676:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3679:	83 c2 10             	add    edx,0x10
    367c:	c1 e2 04             	shl    edx,0x4
    367f:	01 d0                	add    eax,edx
    3681:	83 c0 0c             	add    eax,0xc
    3684:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				while (ic && nb >= 512) {
    368a:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    368e:	74 0d                	je     369d <ahci_assign_buffers+0x2e8>
    3690:	81 7d dc ff 01 00 00 	cmp    DWORD PTR [ebp-0x24],0x1ff
    3697:	0f 87 4b ff ff ff    	ja     35e8 <ahci_assign_buffers+0x233>
				}

				/* exit early if we have non-impelented ports */
				if (!fc && !cc && !ic) {
    369d:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    36a1:	75 3f                	jne    36e2 <ahci_assign_buffers+0x32d>
    36a3:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    36a7:	75 39                	jne    36e2 <ahci_assign_buffers+0x32d>
    36a9:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    36ad:	75 33                	jne    36e2 <ahci_assign_buffers+0x32d>
						/* also deallocate if possible */
						if (nb >= 4096) {
    36af:	81 7d dc ff 0f 00 00 	cmp    DWORD PTR [ebp-0x24],0xfff
    36b6:	76 36                	jbe    36ee <ahci_assign_buffers+0x339>
								ptr += (size_t)ptr % 4096;
    36b8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    36bb:	25 ff 0f 00 00       	and    eax,0xfff
    36c0:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								mm_free_vmem(&mm_kernel, ptr, nb / 4096);
    36c3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    36c6:	c1 e8 0c             	shr    eax,0xc
    36c9:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    36cd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    36d0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    36d4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    36db:	e8 fc ff ff ff       	call   36dc <ahci_assign_buffers+0x327>
						}
						break;
    36e0:	eb 0c                	jmp    36ee <ahci_assign_buffers+0x339>
		while (pg_ct) {
    36e2:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    36e6:	0f 85 47 fd ff ff    	jne    3433 <ahci_assign_buffers+0x7e>
				}
		}
		/* Now all implemented buffers are set */
		return;
    36ec:	eb 30                	jmp    371e <ahci_assign_buffers+0x369>
						break;
    36ee:	90                   	nop
		return;
    36ef:	eb 2d                	jmp    371e <ahci_assign_buffers+0x369>
						goto quit;
    36f1:	90                   	nop
    36f2:	eb 01                	jmp    36f5 <ahci_assign_buffers+0x340>
						goto quit;
    36f4:	90                   	nop

quit:
		die("Out of memory!\n");
    36f5:	c7 44 24 04 22 0a 00 00 	mov    DWORD PTR [esp+0x4],0xa22
    36fd:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    3704:	e8 fc ff ff ff       	call   3705 <ahci_assign_buffers+0x350>
    3709:	e8 fc ff ff ff       	call   370a <ahci_assign_buffers+0x355>
    370e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3715:	e8 fc ff ff ff       	call   3716 <ahci_assign_buffers+0x361>
    371a:	fa                   	cli
    371b:	f4                   	hlt
    371c:	eb fd                	jmp    371b <ahci_assign_buffers+0x366>
}
    371e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    3721:	c9                   	leave
    3722:	c3                   	ret

00003723 <ahci_clear_interrupts>:

/* also disables interrupts */
void ahci_clear_interrupts(struct ahci_device* ad)
{
    3723:	55                   	push   ebp
    3724:	89 e5                	mov    ebp,esp
    3726:	53                   	push   ebx
    3727:	83 ec 10             	sub    esp,0x10
		struct ahci_hba* h = ad->ptr;
    372a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    372d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3730:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* disable interrupts */
		h->ctrl.ie = 0;
    3733:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3736:	8b 42 04             	mov    eax,DWORD PTR [edx+0x4]
    3739:	83 e0 fd             	and    eax,0xfffffffd
    373c:	89 42 04             	mov    DWORD PTR [edx+0x4],eax

		/* clear them in every port implemented */
		for (int i = 0; i < ad->num_ports; i++) {
    373f:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    3746:	eb 48                	jmp    3790 <ahci_clear_interrupts+0x6d>
				struct ahci_port* p;
				if ((h->ports & (1 << i)) == 0)
    3748:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    374b:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    374e:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    3751:	bb 01 00 00 00       	mov    ebx,0x1
    3756:	89 c1                	mov    ecx,eax
    3758:	d3 e3                	shl    ebx,cl
    375a:	89 d8                	mov    eax,ebx
    375c:	21 d0                	and    eax,edx
    375e:	85 c0                	test   eax,eax
    3760:	74 29                	je     378b <ahci_clear_interrupts+0x68>
						continue;
				p = &h->port[i];
    3762:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    3765:	83 c0 02             	add    eax,0x2
    3768:	c1 e0 07             	shl    eax,0x7
    376b:	89 c2                	mov    edx,eax
    376d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3770:	01 d0                	add    eax,edx
    3772:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* disable and clear all */
				p->pXie = 0;
    3775:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3778:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
				p->pXis = 0xffffffff;
    377f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3782:	c7 40 10 ff ff ff ff 	mov    DWORD PTR [eax+0x10],0xffffffff
    3789:	eb 01                	jmp    378c <ahci_clear_interrupts+0x69>
						continue;
    378b:	90                   	nop
		for (int i = 0; i < ad->num_ports; i++) {
    378c:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
    3790:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3793:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3797:	0f b7 c0             	movzx  eax,ax
    379a:	39 45 f8             	cmp    DWORD PTR [ebp-0x8],eax
    379d:	7c a9                	jl     3748 <ahci_clear_interrupts+0x25>
		}

		/* clear the global status */
		h->intr = 0xffffffff; /* W1C */
    379f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    37a2:	c7 40 08 ff ff ff ff 	mov    DWORD PTR [eax+0x8],0xffffffff
}
    37a9:	90                   	nop
    37aa:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    37ad:	c9                   	leave
    37ae:	c3                   	ret

000037af <ahci_device_init>:

int ahci_device_init(struct pci_device* d)
{
    37af:	55                   	push   ebp
    37b0:	89 e5                	mov    ebp,esp
    37b2:	57                   	push   edi
    37b3:	56                   	push   esi
    37b4:	53                   	push   ebx
    37b5:	81 ec ac 00 00 00    	sub    esp,0xac
		int rv;

		/* Check progIf */
		if (d->device_interface != 1) {
    37bb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37be:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
    37c2:	3c 01                	cmp    al,0x1
    37c4:	74 2c                	je     37f2 <ahci_device_init+0x43>
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
						d->device_interface);
    37c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37c9:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
    37cd:	0f b6 c0             	movzx  eax,al
    37d0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    37d4:	c7 44 24 04 34 0a 00 00 	mov    DWORD PTR [esp+0x4],0xa34
    37dc:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    37e3:	e8 fc ff ff ff       	call   37e4 <ahci_device_init+0x35>
				return -ENOSYS;
    37e8:	b8 da ff ff ff       	mov    eax,0xffffffda
    37ed:	e9 50 08 00 00       	jmp    4042 <ahci_device_init+0x893>
		}

		/* Setup and map BAR5 if neccessary */
		if (d->ressources[5].type == PCI_BAR_PIO)
    37f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    37f5:	8b 80 9c 00 00 00    	mov    eax,DWORD PTR [eax+0x9c]
    37fb:	83 f8 01             	cmp    eax,0x1
    37fe:	75 0a                	jne    380a <ahci_device_init+0x5b>
				return -ENOTSUP; /* AHCI requires MMIO at BAR5 */
    3800:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    3805:	e9 38 08 00 00       	jmp    4042 <ahci_device_init+0x893>
		if (!d->ressources[5].mmio.base) {
    380a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    380d:	8b 90 a4 00 00 00    	mov    edx,DWORD PTR [eax+0xa4]
    3813:	8b 80 a0 00 00 00    	mov    eax,DWORD PTR [eax+0xa0]
    3819:	89 c1                	mov    ecx,eax
    381b:	89 c8                	mov    eax,ecx
    381d:	09 d0                	or     eax,edx
    381f:	0f 85 59 01 00 00    	jne    397e <ahci_device_init+0x1cf>
				int atl = 0; uint64_t m;
    3825:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
				/* we first need pmem for the device */
				if (!d->ressources[5].mmio.size) {
    382c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    382f:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    3835:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    383b:	89 c1                	mov    ecx,eax
    383d:	89 c8                	mov    eax,ecx
    383f:	09 d0                	or     eax,edx
    3841:	75 57                	jne    389a <ahci_device_init+0xeb>
						/* Ask PCI */
						d->ressources[5].mmio.size = pci_bar_get_size(d, 5);
    3843:	c7 44 24 04 05 00 00 00 	mov    DWORD PTR [esp+0x4],0x5
    384b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    384e:	89 04 24             	mov    DWORD PTR [esp],eax
    3851:	e8 fc ff ff ff       	call   3852 <ahci_device_init+0xa3>
    3856:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    3859:	89 81 a8 00 00 00    	mov    DWORD PTR [ecx+0xa8],eax
    385f:	89 91 ac 00 00 00    	mov    DWORD PTR [ecx+0xac],edx
						if (!d->ressources[5].mmio.size) {
    3865:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3868:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    386e:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    3874:	89 c1                	mov    ecx,eax
    3876:	89 c8                	mov    eax,ecx
    3878:	09 d0                	or     eax,edx
    387a:	75 1e                	jne    389a <ahci_device_init+0xeb>
								d->ressources[5].mmio.size = 0x1100; /* 32 ports */
    387c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    387f:	c7 80 a8 00 00 00 00 11 00 00 	mov    DWORD PTR [eax+0xa8],0x1100
    3889:	c7 80 ac 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0xac],0x0
								atl = 1; /* about to leave */
    3893:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
						}
				}
				/* Now we want to get some address */
				m = mmio_allocate_range(d->ressources[5].mmio.size,
						0x3 & (d->ressources[5].type >> 1));
    389a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    389d:	8b 80 9c 00 00 00    	mov    eax,DWORD PTR [eax+0x9c]
    38a3:	d1 f8                	sar    eax,1
				m = mmio_allocate_range(d->ressources[5].mmio.size,
    38a5:	83 e0 03             	and    eax,0x3
    38a8:	89 c1                	mov    ecx,eax
    38aa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    38ad:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    38b3:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    38b9:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    38bd:	89 04 24             	mov    DWORD PTR [esp],eax
    38c0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    38c4:	e8 fc ff ff ff       	call   38c5 <ahci_device_init+0x116>
    38c9:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    38cc:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				if (!m)
    38cf:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    38d2:	0b 45 cc             	or     eax,DWORD PTR [ebp-0x34]
    38d5:	75 0a                	jne    38e1 <ahci_device_init+0x132>
						return -ENOMEM;
    38d7:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    38dc:	e9 61 07 00 00       	jmp    4042 <ahci_device_init+0x893>
				/* and assign it */
				pci_set_bar(d, 5, d->ressources[5].type, m);
    38e1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    38e4:	8b 80 9c 00 00 00    	mov    eax,DWORD PTR [eax+0x9c]
    38ea:	89 c1                	mov    ecx,eax
    38ec:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    38ef:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    38f2:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    38f6:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    38fa:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    38fe:	c7 44 24 04 05 00 00 00 	mov    DWORD PTR [esp+0x4],0x5
    3906:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3909:	89 04 24             	mov    DWORD PTR [esp],eax
    390c:	e8 fc ff ff ff       	call   390d <ahci_device_init+0x15e>
				if (d->ressources[5].mmio.base != m) {
    3911:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3914:	8b 90 a4 00 00 00    	mov    edx,DWORD PTR [eax+0xa4]
    391a:	8b 80 a0 00 00 00    	mov    eax,DWORD PTR [eax+0xa0]
    3920:	89 c1                	mov    ecx,eax
    3922:	89 c8                	mov    eax,ecx
    3924:	33 45 c8             	xor    eax,DWORD PTR [ebp-0x38]
    3927:	33 55 cc             	xor    edx,DWORD PTR [ebp-0x34]
    392a:	09 d0                	or     eax,edx
    392c:	74 50                	je     397e <ahci_device_init+0x1cf>
						/* we can't */
						mmio_free_range(m, d->ressources[5].mmio.size);
    392e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3931:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    3937:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    393d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3941:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    3945:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3948:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    394b:	89 04 24             	mov    DWORD PTR [esp],eax
    394e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3952:	e8 fc ff ff ff       	call   3953 <ahci_device_init+0x1a4>
						if (atl)
    3957:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    395b:	74 17                	je     3974 <ahci_device_init+0x1c5>
								d->ressources[5].mmio.size = 0;
    395d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3960:	c7 80 a8 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0xa8],0x0
    396a:	c7 80 ac 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0xac],0x0
						return -ENOTSUP;
    3974:	b8 a1 ff ff ff       	mov    eax,0xffffffa1
    3979:	e9 c4 06 00 00       	jmp    4042 <ahci_device_init+0x893>
				}
		}

		/* Now we possibly have to map the memory */
		if (!d->ressources[5].mmio.mapping) {
    397e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3981:	8b 80 b0 00 00 00    	mov    eax,DWORD PTR [eax+0xb0]
    3987:	85 c0                	test   eax,eax
    3989:	0f 85 a9 00 00 00    	jne    3a38 <ahci_device_init+0x289>
				void* mem; struct page_range pr;
				pr.base = d->ressources[5].mmio.base;
    398f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3992:	8b 90 a4 00 00 00    	mov    edx,DWORD PTR [eax+0xa4]
    3998:	8b 80 a0 00 00 00    	mov    eax,DWORD PTR [eax+0xa0]
    399e:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
    39a1:	89 55 90             	mov    DWORD PTR [ebp-0x70],edx
				pr.count = rdiv(d->ressources[5].mmio.size, 4096);
    39a4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    39a7:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    39ad:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    39b3:	0f ac d0 0c          	shrd   eax,edx,0xc
    39b7:	c1 ea 0c             	shr    edx,0xc
    39ba:	89 c1                	mov    ecx,eax
    39bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    39bf:	8b 90 ac 00 00 00    	mov    edx,DWORD PTR [eax+0xac]
    39c5:	8b 80 a8 00 00 00    	mov    eax,DWORD PTR [eax+0xa8]
    39cb:	25 ff 0f 00 00       	and    eax,0xfff
    39d0:	ba 00 00 00 00       	mov    edx,0x0
    39d5:	89 c3                	mov    ebx,eax
    39d7:	89 d8                	mov    eax,ebx
    39d9:	09 d0                	or     eax,edx
    39db:	74 07                	je     39e4 <ahci_device_init+0x235>
    39dd:	b8 01 00 00 00       	mov    eax,0x1
    39e2:	eb 05                	jmp    39e9 <ahci_device_init+0x23a>
    39e4:	b8 00 00 00 00       	mov    eax,0x0
    39e9:	01 c8                	add    eax,ecx
    39eb:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
			   	mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_MMIO |
    39ee:	c7 44 24 10 2d 00 00 00 	mov    DWORD PTR [esp+0x10],0x2d
    39f6:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    39fe:	8d 45 8c             	lea    eax,[ebp-0x74]
    3a01:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3a05:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    3a0d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3a14:	e8 fc ff ff ff       	call   3a15 <ahci_device_init+0x266>
    3a19:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!mem)
    3a1c:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
    3a20:	75 0a                	jne    3a2c <ahci_device_init+0x27d>
						return -ENOMEM;
    3a22:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3a27:	e9 16 06 00 00       	jmp    4042 <ahci_device_init+0x893>
				d->ressources[5].mmio.mapping = mem;
    3a2c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3a2f:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    3a32:	89 90 b0 00 00 00    	mov    DWORD PTR [eax+0xb0],edx
		}

		/* we now have a working mapping */
		struct ahci_hba* h = d->ressources[5].mmio.mapping;
    3a38:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3a3b:	8b 80 b0 00 00 00    	mov    eax,DWORD PTR [eax+0xb0]
    3a41:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
		struct ahci_device* ad = kzalloc(sizeof(*ad));
    3a44:	c7 04 24 30 06 00 00 	mov    DWORD PTR [esp],0x630
    3a4b:	e8 fc ff ff ff       	call   3a4c <ahci_device_init+0x29d>
    3a50:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
		if (!ad)
    3a53:	83 7d bc 00          	cmp    DWORD PTR [ebp-0x44],0x0
    3a57:	75 0a                	jne    3a63 <ahci_device_init+0x2b4>
				return -ENOMEM;
    3a59:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
    3a5e:	e9 df 05 00 00       	jmp    4042 <ahci_device_init+0x893>

		/* check for AE (access to other registers is disallowed before) */
		if (!(h->control & GHC_CNT_AE)) {
    3a63:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3a66:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3a69:	85 c0                	test   eax,eax
    3a6b:	78 1f                	js     3a8c <ahci_device_init+0x2dd>
				abprintf("switching to AHCI mode\n");
    3a6d:	c7 04 24 5c 0a 00 00 	mov    DWORD PTR [esp],0xa5c
    3a74:	e8 fc ff ff ff       	call   3a75 <ahci_device_init+0x2c6>
				h->control |= GHC_CNT_AE;
    3a79:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3a7c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3a7f:	0d 00 00 00 80       	or     eax,0x80000000
    3a84:	89 c2                	mov    edx,eax
    3a86:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3a89:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		}

		/* fill the descriptors */
		ad->ptr = h; /* D2H is set but masked */
    3a8c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3a8f:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    3a92:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		ad->dev = d;
    3a95:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3a98:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    3a9b:	89 10                	mov    DWORD PTR [eax],edx
		ad->num_ports = min(h->cap.num_ports + 1, bsr(h->ports));
    3a9d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3aa0:	8b 00                	mov    eax,DWORD PTR [eax]
    3aa2:	83 e0 1f             	and    eax,0x1f
    3aa5:	0f b6 c0             	movzx  eax,al
    3aa8:	8d 58 01             	lea    ebx,[eax+0x1]
    3aab:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3aae:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    3ab1:	89 04 24             	mov    DWORD PTR [esp],eax
    3ab4:	e8 47 c5 ff ff       	call   0 <bsr>
    3ab9:	39 c3                	cmp    ebx,eax
    3abb:	7d 10                	jge    3acd <ahci_device_init+0x31e>
    3abd:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3ac0:	8b 00                	mov    eax,DWORD PTR [eax]
    3ac2:	83 e0 1f             	and    eax,0x1f
    3ac5:	0f b6 c0             	movzx  eax,al
    3ac8:	8d 50 01             	lea    edx,[eax+0x1]
    3acb:	eb 10                	jmp    3add <ahci_device_init+0x32e>
    3acd:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3ad0:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    3ad3:	89 04 24             	mov    DWORD PTR [esp],eax
    3ad6:	e8 25 c5 ff ff       	call   0 <bsr>
    3adb:	89 c2                	mov    edx,eax
    3add:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3ae0:	66 89 50 08          	mov    WORD PTR [eax+0x8],dx
		ad->num_cmd = h->cap.num_cmd + 1;
    3ae4:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3ae7:	8b 00                	mov    eax,DWORD PTR [eax]
    3ae9:	c1 e8 08             	shr    eax,0x8
    3aec:	83 e0 1f             	and    eax,0x1f
    3aef:	0f b6 c0             	movzx  eax,al
    3af2:	8d 50 01             	lea    edx,[eax+0x1]
    3af5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3af8:	66 89 50 0a          	mov    WORD PTR [eax+0xa],dx
		for (int i = 0; i < 32; i++) {
    3afc:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    3b03:	e9 fa 00 00 00       	jmp    3c02 <ahci_device_init+0x453>
				ad->pending_cmds[i] = LIST_HEAD_INIT(ad->pending_cmds[i]);
    3b08:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b0b:	89 d0                	mov    eax,edx
    3b0d:	01 c0                	add    eax,eax
    3b0f:	01 d0                	add    eax,edx
    3b11:	c1 e0 02             	shl    eax,0x2
    3b14:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    3b1a:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b1d:	8d 1c 02             	lea    ebx,[edx+eax*1]
    3b20:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b23:	89 d0                	mov    eax,edx
    3b25:	01 c0                	add    eax,eax
    3b27:	01 d0                	add    eax,edx
    3b29:	c1 e0 02             	shl    eax,0x2
    3b2c:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
    3b32:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b35:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3b38:	8b 75 bc             	mov    esi,DWORD PTR [ebp-0x44]
    3b3b:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b3e:	89 d0                	mov    eax,edx
    3b40:	01 c0                	add    eax,eax
    3b42:	01 d0                	add    eax,edx
    3b44:	c1 e0 02             	shl    eax,0x2
    3b47:	01 f0                	add    eax,esi
    3b49:	05 10 03 00 00       	add    eax,0x310
    3b4e:	89 18                	mov    DWORD PTR [eax],ebx
    3b50:	8b 5d bc             	mov    ebx,DWORD PTR [ebp-0x44]
    3b53:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b56:	89 d0                	mov    eax,edx
    3b58:	01 c0                	add    eax,eax
    3b5a:	01 d0                	add    eax,edx
    3b5c:	c1 e0 02             	shl    eax,0x2
    3b5f:	01 d8                	add    eax,ebx
    3b61:	05 14 03 00 00       	add    eax,0x314
    3b66:	89 08                	mov    DWORD PTR [eax],ecx
    3b68:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3b6b:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b6e:	89 d0                	mov    eax,edx
    3b70:	01 c0                	add    eax,eax
    3b72:	01 d0                	add    eax,edx
    3b74:	c1 e0 02             	shl    eax,0x2
    3b77:	01 c8                	add    eax,ecx
    3b79:	05 18 03 00 00       	add    eax,0x318
    3b7e:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
				ad->proc_cmds[i] = LIST_HEAD_INIT(ad->proc_cmds[i]);
    3b83:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b86:	89 d0                	mov    eax,edx
    3b88:	01 c0                	add    eax,eax
    3b8a:	01 d0                	add    eax,edx
    3b8c:	c1 e0 02             	shl    eax,0x2
    3b8f:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    3b95:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3b98:	8d 1c 02             	lea    ebx,[edx+eax*1]
    3b9b:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3b9e:	89 d0                	mov    eax,edx
    3ba0:	01 c0                	add    eax,eax
    3ba2:	01 d0                	add    eax,edx
    3ba4:	c1 e0 02             	shl    eax,0x2
    3ba7:	8d 90 90 04 00 00    	lea    edx,[eax+0x490]
    3bad:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3bb0:	8d 0c 02             	lea    ecx,[edx+eax*1]
    3bb3:	8b 75 bc             	mov    esi,DWORD PTR [ebp-0x44]
    3bb6:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3bb9:	89 d0                	mov    eax,edx
    3bbb:	01 c0                	add    eax,eax
    3bbd:	01 d0                	add    eax,edx
    3bbf:	c1 e0 02             	shl    eax,0x2
    3bc2:	01 f0                	add    eax,esi
    3bc4:	05 90 04 00 00       	add    eax,0x490
    3bc9:	89 18                	mov    DWORD PTR [eax],ebx
    3bcb:	8b 5d bc             	mov    ebx,DWORD PTR [ebp-0x44]
    3bce:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3bd1:	89 d0                	mov    eax,edx
    3bd3:	01 c0                	add    eax,eax
    3bd5:	01 d0                	add    eax,edx
    3bd7:	c1 e0 02             	shl    eax,0x2
    3bda:	01 d8                	add    eax,ebx
    3bdc:	05 94 04 00 00       	add    eax,0x494
    3be1:	89 08                	mov    DWORD PTR [eax],ecx
    3be3:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3be6:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3be9:	89 d0                	mov    eax,edx
    3beb:	01 c0                	add    eax,eax
    3bed:	01 d0                	add    eax,edx
    3bef:	c1 e0 02             	shl    eax,0x2
    3bf2:	01 c8                	add    eax,ecx
    3bf4:	05 98 04 00 00       	add    eax,0x498
    3bf9:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
		for (int i = 0; i < 32; i++) {
    3bfe:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
    3c02:	83 7d e0 1f          	cmp    DWORD PTR [ebp-0x20],0x1f
    3c06:	0f 8e fc fe ff ff    	jle    3b08 <ahci_device_init+0x359>
		}
		ad->ctxs = LIST_HEAD_INIT(ad->ctxs);
    3c0c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c0f:	8d 88 14 06 00 00    	lea    ecx,[eax+0x614]
    3c15:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c18:	8d 90 14 06 00 00    	lea    edx,[eax+0x614]
    3c1e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c21:	89 88 14 06 00 00    	mov    DWORD PTR [eax+0x614],ecx
    3c27:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c2a:	89 90 18 06 00 00    	mov    DWORD PTR [eax+0x618],edx
    3c30:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c33:	66 c7 80 1c 06 00 00 00 00 	mov    WORD PTR [eax+0x61c],0x0
		ad->wh = WAIT_QUEUE_HEAD(ad->wh);
    3c3c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c3f:	8d 88 20 06 00 00    	lea    ecx,[eax+0x620]
    3c45:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c48:	8d 90 20 06 00 00    	lea    edx,[eax+0x620]
    3c4e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c51:	89 88 20 06 00 00    	mov    DWORD PTR [eax+0x620],ecx
    3c57:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c5a:	89 90 24 06 00 00    	mov    DWORD PTR [eax+0x624],edx
    3c60:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c63:	66 c7 80 28 06 00 00 00 00 	mov    WORD PTR [eax+0x628],0x0
    3c6c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3c6f:	c7 80 2c 06 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x62c],0x0

#ifdef AHCIBABBLE /* Tell the world about it */
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    3c79:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3c7c:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3c7f:	0f b6 c8             	movzx  ecx,al
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
    3c82:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3c85:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3c88:	c1 e8 08             	shr    eax,0x8
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3c8b:	0f b6 d0             	movzx  edx,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    3c8e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3c91:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3c94:	c1 e8 10             	shr    eax,0x10
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3c97:	0f b6 c0             	movzx  eax,al
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
    3c9a:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    3c9d:	8b 5b 10             	mov    ebx,DWORD PTR [ebx+0x10]
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
    3ca0:	c1 eb 18             	shr    ebx,0x18
    3ca3:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    3ca7:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    3cab:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3caf:	89 5c 24 04          	mov    DWORD PTR [esp+0x4],ebx
    3cb3:	c7 04 24 74 0a 00 00 	mov    DWORD PTR [esp],0xa74
    3cba:	e8 fc ff ff ff       	call   3cbb <ahci_device_init+0x50c>
		/* and print the capablilities */
		printf("Features: %s%s%sspeed: %s\n",
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
				capstr(h->cap.if_speed, 4, "res", "1.5 Gbps", "3 Gbps", "6Gbps", ">6Gbps"));
    3cbf:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3cc2:	8b 00                	mov    eax,DWORD PTR [eax]
    3cc4:	c1 e8 14             	shr    eax,0x14
    3cc7:	83 e0 0f             	and    eax,0xf
		printf("Features: %s%s%sspeed: %s\n",
    3cca:	0f b6 c0             	movzx  eax,al
    3ccd:	c7 44 24 18 9e 0a 00 00 	mov    DWORD PTR [esp+0x18],0xa9e
    3cd5:	c7 44 24 14 a5 0a 00 00 	mov    DWORD PTR [esp+0x14],0xaa5
    3cdd:	c7 44 24 10 ab 0a 00 00 	mov    DWORD PTR [esp+0x10],0xaab
    3ce5:	c7 44 24 0c b2 0a 00 00 	mov    DWORD PTR [esp+0xc],0xab2
    3ced:	c7 44 24 08 bb 0a 00 00 	mov    DWORD PTR [esp+0x8],0xabb
    3cf5:	c7 44 24 04 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x4
    3cfd:	89 04 24             	mov    DWORD PTR [esp],eax
    3d00:	e8 fc ff ff ff       	call   3d01 <ahci_device_init+0x552>
    3d05:	89 c7                	mov    edi,eax
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
    3d07:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3d0a:	8b 00                	mov    eax,DWORD PTR [eax]
    3d0c:	c1 e8 1f             	shr    eax,0x1f
		printf("Features: %s%s%sspeed: %s\n",
    3d0f:	0f b6 c0             	movzx  eax,al
    3d12:	c7 44 24 0c bf 0a 00 00 	mov    DWORD PTR [esp+0xc],0xabf
    3d1a:	c7 44 24 08 c8 0a 00 00 	mov    DWORD PTR [esp+0x8],0xac8
    3d22:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    3d2a:	89 04 24             	mov    DWORD PTR [esp],eax
    3d2d:	e8 fc ff ff ff       	call   3d2e <ahci_device_init+0x57f>
    3d32:	89 c6                	mov    esi,eax
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
    3d34:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3d37:	8b 00                	mov    eax,DWORD PTR [eax]
    3d39:	c1 e8 12             	shr    eax,0x12
    3d3c:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    3d3f:	0f b6 c0             	movzx  eax,al
    3d42:	c7 44 24 0c d1 0a 00 00 	mov    DWORD PTR [esp+0xc],0xad1
    3d4a:	c7 44 24 08 dd 0a 00 00 	mov    DWORD PTR [esp+0x8],0xadd
    3d52:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    3d5a:	89 04 24             	mov    DWORD PTR [esp],eax
    3d5d:	e8 fc ff ff ff       	call   3d5e <ahci_device_init+0x5af>
    3d62:	89 c3                	mov    ebx,eax
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
    3d64:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3d67:	8b 00                	mov    eax,DWORD PTR [eax]
    3d69:	c1 e8 1e             	shr    eax,0x1e
    3d6c:	83 e0 01             	and    eax,0x1
		printf("Features: %s%s%sspeed: %s\n",
    3d6f:	0f b6 c0             	movzx  eax,al
    3d72:	c7 44 24 0c ee 0a 00 00 	mov    DWORD PTR [esp+0xc],0xaee
    3d7a:	c7 44 24 08 ff 02 00 00 	mov    DWORD PTR [esp+0x8],0x2ff
    3d82:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    3d8a:	89 04 24             	mov    DWORD PTR [esp],eax
    3d8d:	e8 fc ff ff ff       	call   3d8e <ahci_device_init+0x5df>
    3d92:	89 7c 24 10          	mov    DWORD PTR [esp+0x10],edi
    3d96:	89 74 24 0c          	mov    DWORD PTR [esp+0xc],esi
    3d9a:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    3d9e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3da2:	c7 04 24 f4 0a 00 00 	mov    DWORD PTR [esp],0xaf4
    3da9:	e8 fc ff ff ff       	call   3daa <ahci_device_init+0x5fb>
		printf("AHCI HBA has %u ports and %u command slots\n",
				ad->num_ports, ad->num_cmd);
    3dae:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3db1:	0f b7 40 0a          	movzx  eax,WORD PTR [eax+0xa]
		printf("AHCI HBA has %u ports and %u command slots\n",
    3db5:	0f b7 d0             	movzx  edx,ax
				ad->num_ports, ad->num_cmd);
    3db8:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3dbb:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
		printf("AHCI HBA has %u ports and %u command slots\n",
    3dbf:	0f b7 c0             	movzx  eax,ax
    3dc2:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3dc6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3dca:	c7 04 24 10 0b 00 00 	mov    DWORD PTR [esp],0xb10
    3dd1:	e8 fc ff ff ff       	call   3dd2 <ahci_device_init+0x623>
#endif

		/* transfer ownership (incl NMI) */
		if (h->cap2.boh) {
    3dd6:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3dd9:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    3ddc:	83 e0 01             	and    eax,0x1
    3ddf:	84 c0                	test   al,al
    3de1:	74 27                	je     3e0a <ahci_device_init+0x65b>
				rv = ahci_do_bohc(ad);
    3de3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3de6:	89 04 24             	mov    DWORD PTR [esp],eax
    3de9:	e8 fc ff ff ff       	call   3dea <ahci_device_init+0x63b>
    3dee:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				if (rv) {
    3df1:	83 7d b8 00          	cmp    DWORD PTR [ebp-0x48],0x0
    3df5:	74 13                	je     3e0a <ahci_device_init+0x65b>
						kfree(ad);
    3df7:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3dfa:	89 04 24             	mov    DWORD PTR [esp],eax
    3dfd:	e8 fc ff ff ff       	call   3dfe <ahci_device_init+0x64f>
						return rv;
    3e02:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    3e05:	e9 38 02 00 00       	jmp    4042 <ahci_device_init+0x893>
				}
		}

		/* disable every possible interrupt */
		if(pci_disable_interrupts(d))
    3e0a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3e0d:	89 04 24             	mov    DWORD PTR [esp],eax
    3e10:	e8 fc ff ff ff       	call   3e11 <ahci_device_init+0x662>
    3e15:	85 c0                	test   eax,eax
    3e17:	74 29                	je     3e42 <ahci_device_init+0x693>
				die("not possible!\n");
    3e19:	c7 44 24 04 3c 0b 00 00 	mov    DWORD PTR [esp+0x4],0xb3c
    3e21:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    3e28:	e8 fc ff ff ff       	call   3e29 <ahci_device_init+0x67a>
    3e2d:	e8 fc ff ff ff       	call   3e2e <ahci_device_init+0x67f>
    3e32:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3e39:	e8 fc ff ff ff       	call   3e3a <ahci_device_init+0x68b>
    3e3e:	fa                   	cli
    3e3f:	f4                   	hlt
    3e40:	eb fd                	jmp    3e3f <ahci_device_init+0x690>

		/* Stop the running ports */
		for (int i = 0; i < ad->num_ports; i++)
    3e42:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    3e49:	eb 16                	jmp    3e61 <ahci_device_init+0x6b2>
				ahci_stop_port(ad, i);
    3e4b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3e4e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3e52:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3e55:	89 04 24             	mov    DWORD PTR [esp],eax
    3e58:	e8 fc ff ff ff       	call   3e59 <ahci_device_init+0x6aa>
		for (int i = 0; i < ad->num_ports; i++)
    3e5d:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    3e61:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3e64:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3e68:	0f b7 c0             	movzx  eax,ax
    3e6b:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
    3e6e:	7c db                	jl     3e4b <ahci_device_init+0x69c>

		/* clear all interrupts and install the handler */
		ahci_clear_interrupts(ad); /* PCI disabled MSI and we're currently */
    3e70:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3e73:	89 04 24             	mov    DWORD PTR [esp],eax
    3e76:	e8 fc ff ff ff       	call   3e77 <ahci_device_init+0x6c8>
		install_irq_handler(ad->dev->intr_line, ahci_irq); /* not using it */
    3e7b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3e7e:	8b 00                	mov    eax,DWORD PTR [eax]
    3e80:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    3e84:	0f b6 c0             	movzx  eax,al
    3e87:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    3e8f:	89 04 24             	mov    DWORD PTR [esp],eax
    3e92:	e8 fc ff ff ff       	call   3e93 <ahci_device_init+0x6e4>
		/* TODO: do proper assigment */

		/* assign the command lists and the FIS buffers */
		ahci_assign_buffers(ad);
    3e97:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3e9a:	89 04 24             	mov    DWORD PTR [esp],eax
    3e9d:	e8 fc ff ff ff       	call   3e9e <ahci_device_init+0x6ef>

		/* print them */
		for (int i = 0; i < ad->num_ports; i++) {
    3ea2:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    3ea9:	e9 b2 00 00 00       	jmp    3f60 <ahci_device_init+0x7b1>
				printf("port%d: %016llx %016llx %p %p\n", i,
    3eae:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3eb1:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3eb4:	83 c2 20             	add    edx,0x20
    3eb7:	8b 7c 90 0c          	mov    edi,DWORD PTR [eax+edx*4+0xc]
    3ebb:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3ebe:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3ec1:	8b 74 90 0c          	mov    esi,DWORD PTR [eax+edx*4+0xc]
						ad->ptr->port[i].pXclb64,
						ad->ptr->port[i].pXfb64,
    3ec5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3ec8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("port%d: %016llx %016llx %p %p\n", i,
    3ecb:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3ece:	83 c2 02             	add    edx,0x2
    3ed1:	c1 e2 07             	shl    edx,0x7
    3ed4:	01 d0                	add    eax,edx
    3ed6:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    3ed9:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
						ad->ptr->port[i].pXclb64,
    3edc:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3edf:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("port%d: %016llx %016llx %p %p\n", i,
    3ee2:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3ee5:	83 c2 02             	add    edx,0x2
    3ee8:	c1 e2 07             	shl    edx,0x7
    3eeb:	01 d0                	add    eax,edx
    3eed:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3ef0:	8b 00                	mov    eax,DWORD PTR [eax]
    3ef2:	89 7c 24 1c          	mov    DWORD PTR [esp+0x1c],edi
    3ef6:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
    3efa:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    3efe:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    3f02:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3f06:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    3f0a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    3f0d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3f11:	c7 04 24 4c 0b 00 00 	mov    DWORD PTR [esp],0xb4c
    3f18:	e8 fc ff ff ff       	call   3f19 <ahci_device_init+0x76a>
						ad->command_lists[i],
						ad->recv_fis[i]);
				printf("       %016llx %p\n", ad->identify_data[i].pm,
    3f1d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f20:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3f23:	83 c2 10             	add    edx,0x10
    3f26:	c1 e2 04             	shl    edx,0x4
    3f29:	01 d0                	add    eax,edx
    3f2b:	83 c0 10             	add    eax,0x10
    3f2e:	8b 08                	mov    ecx,DWORD PTR [eax]
    3f30:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f33:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3f36:	83 c2 10             	add    edx,0x10
    3f39:	c1 e2 04             	shl    edx,0x4
    3f3c:	01 d0                	add    eax,edx
    3f3e:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    3f41:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    3f44:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    3f48:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3f4c:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3f50:	c7 04 24 6b 0b 00 00 	mov    DWORD PTR [esp],0xb6b
    3f57:	e8 fc ff ff ff       	call   3f58 <ahci_device_init+0x7a9>
		for (int i = 0; i < ad->num_ports; i++) {
    3f5c:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    3f60:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f63:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3f67:	0f b7 c0             	movzx  eax,ax
    3f6a:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    3f6d:	0f 8c 3b ff ff ff    	jl     3eae <ahci_device_init+0x6ff>
						ad->identify_data[i].ptr);
		}

		/* allow the device to write to our memory */
		pci_set_master(d);
    3f73:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3f76:	89 04 24             	mov    DWORD PTR [esp],eax
    3f79:	e8 fc ff ff ff       	call   3f7a <ahci_device_init+0x7cb>

		/* reenable the ports */
		for (int i = 0; i < ad->num_ports; i++)
    3f7e:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    3f85:	eb 16                	jmp    3f9d <ahci_device_init+0x7ee>
				ahci_enable_port(ad, i);
    3f87:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3f8a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3f8e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3f91:	89 04 24             	mov    DWORD PTR [esp],eax
    3f94:	e8 fc ff ff ff       	call   3f95 <ahci_device_init+0x7e6>
		for (int i = 0; i < ad->num_ports; i++)
    3f99:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
    3f9d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    3fa0:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
    3fa4:	0f b7 c0             	movzx  eax,ax
    3fa7:	39 45 d4             	cmp    DWORD PTR [ebp-0x2c],eax
    3faa:	7c db                	jl     3f87 <ahci_device_init+0x7d8>

		/* add the device to the list */
		struct ale* le = kzalloc(sizeof(*le));
    3fac:	c7 04 24 10 00 00 00 	mov    DWORD PTR [esp],0x10
    3fb3:	e8 fc ff ff ff       	call   3fb4 <ahci_device_init+0x805>
    3fb8:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
		le->dev = ad;
    3fbb:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3fbe:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    3fc1:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		list_add_tail(&le->devs, &ahci_dl.devs);
    3fc4:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3fc7:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    3fcf:	89 04 24             	mov    DWORD PTR [esp],eax
    3fd2:	e8 fa c0 ff ff       	call   d1 <list_add_tail>

		/* allocate the pool */
		ad->ctbl_pool = ahci_allocate_command_table_pool(
				32, 8, h->cap.is_64bit);
    3fd7:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    3fda:	8b 00                	mov    eax,DWORD PTR [eax]
    3fdc:	c1 e8 1f             	shr    eax,0x1f
		ad->ctbl_pool = ahci_allocate_command_table_pool(
    3fdf:	0f b6 c0             	movzx  eax,al
    3fe2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3fe6:	c7 44 24 04 08 00 00 00 	mov    DWORD PTR [esp+0x4],0x8
    3fee:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    3ff5:	e8 fc ff ff ff       	call   3ff6 <ahci_device_init+0x847>
    3ffa:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    3ffd:	89 82 0c 03 00 00    	mov    DWORD PTR [edx+0x30c],eax

		/* launch the worker */
		task_spawn(ahci_worker, ad, PRIORITY_ELEVATED);
    4003:	c7 44 24 0c 7e 0b 00 00 	mov    DWORD PTR [esp+0xc],0xb7e
    400b:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    4013:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    4016:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    401a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    4021:	e8 fc ff ff ff       	call   4022 <ahci_device_init+0x873>

		/* reenable interrupts */
		/* The port_enable function already set the per-port values */
		h->ctrl.ie = 1;
    4026:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    4029:	8b 42 04             	mov    eax,DWORD PTR [edx+0x4]
    402c:	83 c8 02             	or     eax,0x2
    402f:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
		pci_enable_interrupts(d);
    4032:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4035:	89 04 24             	mov    DWORD PTR [esp],eax
    4038:	e8 fc ff ff ff       	call   4039 <ahci_device_init+0x88a>

		return 0;
    403d:	b8 00 00 00 00       	mov    eax,0x0
}
    4042:	81 c4 ac 00 00 00    	add    esp,0xac
    4048:	5b                   	pop    ebx
    4049:	5e                   	pop    esi
    404a:	5f                   	pop    edi
    404b:	5d                   	pop    ebp
    404c:	c3                   	ret

0000404d <module_init>:

int MODENTRY module_init()
{
    404d:	55                   	push   ebp
    404e:	89 e5                	mov    ebp,esp
    4050:	83 ec 38             	sub    esp,0x38
		printf("AHCI initialization...\n");
    4053:	c7 04 24 8a 0b 00 00 	mov    DWORD PTR [esp],0xb8a
    405a:	e8 fc ff ff ff       	call   405b <module_init+0xe>
		struct pci_device* dev; int ct = 0, nc = 0, nf = 0;
    405f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    4066:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    406d:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    4074:	e9 8e 00 00 00       	jmp    4107 <module_init+0xba>
				int rv;
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
						dev->addr.device_no, dev->addr.func_no);
    4079:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    407c:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    4080:	83 e0 07             	and    eax,0x7
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    4083:	0f b6 c8             	movzx  ecx,al
						dev->addr.device_no, dev->addr.func_no);
    4086:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4089:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    408d:	c0 e8 03             	shr    al,0x3
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
    4090:	0f b6 d0             	movzx  edx,al
    4093:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4096:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
    409a:	0f b6 c0             	movzx  eax,al
    409d:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    40a1:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    40a5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    40a9:	c7 04 24 a4 0b 00 00 	mov    DWORD PTR [esp],0xba4
    40b0:	e8 fc ff ff ff       	call   40b1 <module_init+0x64>
				printf("Attempting initialization...\n");
    40b5:	c7 04 24 c7 0b 00 00 	mov    DWORD PTR [esp],0xbc7
    40bc:	e8 fc ff ff ff       	call   40bd <module_init+0x70>
				rv = ahci_device_init(dev);
    40c1:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    40c4:	89 04 24             	mov    DWORD PTR [esp],eax
    40c7:	e8 fc ff ff ff       	call   40c8 <module_init+0x7b>
    40cc:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (rv) {
    40cf:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    40d3:	74 1a                	je     40ef <module_init+0xa2>
						cprintf(KFMT_ERROR, "Initialization of this device failed.\n");
    40d5:	c7 44 24 04 e8 0b 00 00 	mov    DWORD PTR [esp+0x4],0xbe8
    40dd:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    40e4:	e8 fc ff ff ff       	call   40e5 <module_init+0x98>
						nf++;
    40e9:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    40ed:	eb 18                	jmp    4107 <module_init+0xba>
				} else {
						cprintf(KFMT_OK, "Initialization of AHCI HBA succeeded.\n");
    40ef:	c7 44 24 04 10 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc10
    40f7:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    40fe:	e8 fc ff ff ff       	call   40ff <module_init+0xb2>
						nc++;
    4103:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
    4107:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    410a:	8d 50 01             	lea    edx,[eax+0x1]
    410d:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    4110:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    4114:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    411c:	c7 44 24 04 06 00 00 00 	mov    DWORD PTR [esp+0x4],0x6
    4124:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
    412b:	e8 fc ff ff ff       	call   412c <module_init+0xdf>
    4130:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    4133:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    4137:	0f 85 3c ff ff ff    	jne    4079 <module_init+0x2c>
				}
		}
		/* Summary */
		cprintf(nf ? KFMT_WARN : KFMT_OK, "Initialized %d AHCI Host Bus Adapters. (%d failed)\n", nc, nf);
    413d:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    4141:	74 07                	je     414a <module_init+0xfd>
    4143:	ba 0e 00 00 00       	mov    edx,0xe
    4148:	eb 05                	jmp    414f <module_init+0x102>
    414a:	ba 0a 00 00 00       	mov    edx,0xa
    414f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4152:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    4156:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    4159:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    415d:	c7 44 24 04 38 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc38
    4165:	89 14 24             	mov    DWORD PTR [esp],edx
    4168:	e8 fc ff ff ff       	call   4169 <module_init+0x11c>
		return 0;
    416d:	b8 00 00 00 00       	mov    eax,0x0
}
    4172:	c9                   	leave
    4173:	c3                   	ret

00004174 <module_cleanup>:

void MODENTRY module_cleanup()
{
    4174:	55                   	push   ebp
    4175:	89 e5                	mov    ebp,esp
}
    4177:	90                   	nop
    4178:	5d                   	pop    ebp
    4179:	c3                   	ret
