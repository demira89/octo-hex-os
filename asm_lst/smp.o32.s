
smp.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
				return rv;
		rv = search_mp_fps((void*)0x9fc00, 1024);
		if (rv)
				return rv;

		/* BIOS ROM */
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
		return rv;
}

void* build_configuration_table_from_default(uint8_t tp)
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
{
		return NULL + tp - tp;
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <outb>:
		const char* el[4] = { "Bus", "edge", "res", "level" };
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
				l->dest_lapic_id, l->dest_lapic_linp,
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp
      17:	83 ec 08             	sub    esp,0x8
      1a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      1d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      20:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
      24:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
		/* TODO: for now do nothing with this info */
      27:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
      2b:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      2f:	ee                   	out    dx,al
}
      30:	90                   	nop
      31:	c9                   	leave
      32:	c3                   	ret

00000033 <memcpy>:
						pt = &ps->next;
		} while ((ps = *pt));
}

void mp_parse_config_table(void* ptr)
{
      33:	55                   	push   ebp
      34:	89 e5                	mov    ebp,esp
      36:	83 ec 10             	sub    esp,0x10
		/* first map the table to VM */
      39:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      3c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
      3f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      42:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
      45:	eb 17                	jmp    5e <memcpy+0x2b>
		uint16_t ec; void* e;
      47:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      4a:	8d 42 01             	lea    eax,[edx+0x1]
      4d:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      50:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      53:	8d 48 01             	lea    ecx,[eax+0x1]
      56:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      59:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      5c:	88 10                	mov    BYTE PTR [eax],dl
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
      5e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      61:	8d 50 ff             	lea    edx,[eax-0x1]
      64:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      67:	85 c0                	test   eax,eax
      69:	75 dc                	jne    47 <memcpy+0x14>

      6b:	90                   	nop
      6c:	90                   	nop
      6d:	c9                   	leave
      6e:	c3                   	ret

0000006f <checksum_memory>:
      6f:	55                   	push   ebp
      70:	89 e5                	mov    ebp,esp
      72:	83 ec 10             	sub    esp,0x10
      75:	c6 45 ff 00          	mov    BYTE PTR [ebp-0x1],0x0
      79:	eb 0f                	jmp    8a <checksum_memory+0x1b>
      7b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      7e:	8d 50 01             	lea    edx,[eax+0x1]
      81:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
      84:	0f b6 00             	movzx  eax,BYTE PTR [eax]
      87:	00 45 ff             	add    BYTE PTR [ebp-0x1],al
      8a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      8d:	8d 50 ff             	lea    edx,[eax-0x1]
      90:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
      93:	85 c0                	test   eax,eax
      95:	75 e4                	jne    7b <checksum_memory+0xc>
      97:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
      9b:	c9                   	leave
      9c:	c3                   	ret

0000009d <search_mp_fps>:
{
      9d:	55                   	push   ebp
      9e:	89 e5                	mov    ebp,esp
      a0:	83 ec 10             	sub    esp,0x10
		while (ct >= 16) {
      a3:	eb 3c                	jmp    e1 <search_mp_fps+0x44>
				if (*(uint32_t*)mem == 0x5f504d5f) {
      a5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      a8:	8b 00                	mov    eax,DWORD PTR [eax]
      aa:	3d 5f 4d 50 5f       	cmp    eax,0x5f504d5f
      af:	75 28                	jne    d9 <search_mp_fps+0x3c>
						struct mp_fps* fps = mem;
      b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b4:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						if (checksum_memory(mem, 16 * fps->length) == 0)
      b7:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      ba:	0f b6 40 08          	movzx  eax,BYTE PTR [eax+0x8]
      be:	0f b6 c0             	movzx  eax,al
      c1:	c1 e0 04             	shl    eax,0x4
      c4:	50                   	push   eax
      c5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
      c8:	e8 a2 ff ff ff       	call   6f <checksum_memory>
      cd:	83 c4 08             	add    esp,0x8
      d0:	84 c0                	test   al,al
      d2:	75 05                	jne    d9 <search_mp_fps+0x3c>
								return mem;
      d4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      d7:	eb 13                	jmp    ec <search_mp_fps+0x4f>
				mem += 16;
      d9:	83 45 08 10          	add    DWORD PTR [ebp+0x8],0x10
				ct -= 16;
      dd:	83 6d 0c 10          	sub    DWORD PTR [ebp+0xc],0x10
		while (ct >= 16) {
      e1:	83 7d 0c 0f          	cmp    DWORD PTR [ebp+0xc],0xf
      e5:	77 be                	ja     a5 <search_mp_fps+0x8>
		return NULL;
      e7:	b8 00 00 00 00       	mov    eax,0x0
}
      ec:	c9                   	leave
      ed:	c3                   	ret

000000ee <find_mp_fps>:
{
      ee:	55                   	push   ebp
      ef:	89 e5                	mov    ebp,esp
      f1:	83 ec 10             	sub    esp,0x10
		rv = (void*)((size_t)*(uint16_t*)0x040e << 16);
      f4:	b8 0e 04 00 00       	mov    eax,0x40e
      f9:	0f b7 00             	movzx  eax,WORD PTR [eax]
      fc:	0f b7 c0             	movzx  eax,ax
      ff:	c1 e0 10             	shl    eax,0x10
     102:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if ((size_t)rv < 0x000a0000 && (0x000a0000 - (size_t)rv) <= 128 * 1024) {
     105:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     108:	3d ff ff 09 00       	cmp    eax,0x9ffff
     10d:	77 30                	ja     13f <find_mp_fps+0x51>
     10f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     112:	ba 00 00 0a 00       	mov    edx,0xa0000
     117:	29 c2                	sub    edx,eax
     119:	81 fa 00 00 02 00    	cmp    edx,0x20000
     11f:	77 1e                	ja     13f <find_mp_fps+0x51>
				rv = search_mp_fps(rv, 1024);
     121:	68 00 04 00 00       	push   0x400
     126:	ff 75 fc             	push   DWORD PTR [ebp-0x4]
     129:	e8 fc ff ff ff       	call   12a <find_mp_fps+0x3c>
     12e:	83 c4 08             	add    esp,0x8
     131:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				if (rv)
     134:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     138:	74 05                	je     13f <find_mp_fps+0x51>
						return rv;
     13a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     13d:	eb 58                	jmp    197 <find_mp_fps+0xa9>
		rv = search_mp_fps((void*)0x7fc00, 1024);
     13f:	68 00 04 00 00       	push   0x400
     144:	68 00 fc 07 00       	push   0x7fc00
     149:	e8 fc ff ff ff       	call   14a <find_mp_fps+0x5c>
     14e:	83 c4 08             	add    esp,0x8
     151:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rv)
     154:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     158:	74 05                	je     15f <find_mp_fps+0x71>
				return rv;
     15a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     15d:	eb 38                	jmp    197 <find_mp_fps+0xa9>
		rv = search_mp_fps((void*)0x9fc00, 1024);
     15f:	68 00 04 00 00       	push   0x400
     164:	68 00 fc 09 00       	push   0x9fc00
     169:	e8 fc ff ff ff       	call   16a <find_mp_fps+0x7c>
     16e:	83 c4 08             	add    esp,0x8
     171:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rv)
     174:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     178:	74 05                	je     17f <find_mp_fps+0x91>
				return rv;
     17a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     17d:	eb 18                	jmp    197 <find_mp_fps+0xa9>
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
     17f:	68 00 00 01 00       	push   0x10000
     184:	68 00 00 0f 00       	push   0xf0000
     189:	e8 fc ff ff ff       	call   18a <find_mp_fps+0x9c>
     18e:	83 c4 08             	add    esp,0x8
     191:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return rv;
     194:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
     197:	c9                   	leave
     198:	c3                   	ret

00000199 <build_configuration_table_from_default>:
{
     199:	55                   	push   ebp
     19a:	89 e5                	mov    ebp,esp
     19c:	83 ec 04             	sub    esp,0x4
     19f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1a2:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		return NULL + tp - tp;
     1a5:	b8 00 00 00 00       	mov    eax,0x0
}
     1aa:	c9                   	leave
     1ab:	c3                   	ret

000001ac <parse_processor_entry>:
{
     1ac:	55                   	push   ebp
     1ad:	89 e5                	mov    ebp,esp
     1af:	56                   	push   esi
     1b0:	53                   	push   ebx
     1b1:	83 ec 10             	sub    esp,0x10
		if (!hdr++) {
     1b4:	a1 18 01 00 00       	mov    eax,ds:0x118
     1b9:	8d 50 01             	lea    edx,[eax+0x1]
     1bc:	89 15 18 01 00 00    	mov    DWORD PTR ds:0x118,edx
     1c2:	85 c0                	test   eax,eax
     1c4:	75 20                	jne    1e6 <parse_processor_entry+0x3a>
				printf("Processors from MP list:\n");
     1c6:	83 ec 0c             	sub    esp,0xc
     1c9:	68 00 00 00 00       	push   0x0
     1ce:	e8 fc ff ff ff       	call   1cf <parse_processor_entry+0x23>
     1d3:	83 c4 10             	add    esp,0x10
				printf("TYPE  STATUS    APIC ID  SIGNATURE  FLAGS\n");
     1d6:	83 ec 0c             	sub    esp,0xc
     1d9:	68 1c 00 00 00       	push   0x1c
     1de:	e8 fc ff ff ff       	call   1df <parse_processor_entry+0x33>
     1e3:	83 c4 10             	add    esp,0x10
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     1e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1e9:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     1ec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ef:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
				p->lapic_id, p->cpu_signature, p->cpu_features);
     1f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f5:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     1f9:	0f b6 c0             	movzx  eax,al
				(p->cpu_flags & 1) ? "enabled" : "disabled",
     1fc:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
     1ff:	0f b6 5b 03          	movzx  ebx,BYTE PTR [ebx+0x3]
     203:	0f b6 db             	movzx  ebx,bl
     206:	83 e3 01             	and    ebx,0x1
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     209:	85 db                	test   ebx,ebx
     20b:	74 07                	je     214 <parse_processor_entry+0x68>
     20d:	be 47 00 00 00       	mov    esi,0x47
     212:	eb 05                	jmp    219 <parse_processor_entry+0x6d>
     214:	be 4f 00 00 00       	mov    esi,0x4f
				(p->cpu_flags & 2) ? "BP" : "AP",
     219:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
     21c:	0f b6 5b 03          	movzx  ebx,BYTE PTR [ebx+0x3]
     220:	0f b6 db             	movzx  ebx,bl
     223:	83 e3 02             	and    ebx,0x2
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     226:	85 db                	test   ebx,ebx
     228:	74 07                	je     231 <parse_processor_entry+0x85>
     22a:	bb 58 00 00 00       	mov    ebx,0x58
     22f:	eb 05                	jmp    236 <parse_processor_entry+0x8a>
     231:	bb 5b 00 00 00       	mov    ebx,0x5b
     236:	83 ec 08             	sub    esp,0x8
     239:	51                   	push   ecx
     23a:	52                   	push   edx
     23b:	50                   	push   eax
     23c:	56                   	push   esi
     23d:	53                   	push   ebx
     23e:	68 5e 00 00 00       	push   0x5e
     243:	e8 fc ff ff ff       	call   244 <parse_processor_entry+0x98>
     248:	83 c4 20             	add    esp,0x20
		if (!(p->cpu_flags & 1))
     24b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     24e:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     252:	0f b6 c0             	movzx  eax,al
     255:	83 e0 01             	and    eax,0x1
     258:	85 c0                	test   eax,eax
     25a:	0f 84 be 00 00 00    	je     31e <parse_processor_entry+0x172>
		else if (p->cpu_flags & 2) { /* BP */
     260:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     263:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     267:	0f b6 c0             	movzx  eax,al
     26a:	83 e0 02             	and    eax,0x2
     26d:	85 c0                	test   eax,eax
     26f:	74 26                	je     297 <parse_processor_entry+0xeb>
				apic_ids.bp_id = (uint32_t)p->lapic_id << 24;
     271:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     274:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     278:	0f b6 c0             	movzx  eax,al
     27b:	c1 e0 18             	shl    eax,0x18
     27e:	a3 00 00 00 00       	mov    ds:0x0,eax
				if (cpu.has_htt)
     283:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
     28a:	83 e0 10             	and    eax,0x10
     28d:	84 c0                	test   al,al
     28f:	0f 84 8a 00 00 00    	je     31f <parse_processor_entry+0x173>
						goto htt_proc;
     295:	eb 47                	jmp    2de <parse_processor_entry+0x132>
				struct apid* pi = kmalloc(sizeof(struct apid));
     297:	83 ec 0c             	sub    esp,0xc
     29a:	6a 08                	push   0x8
     29c:	e8 fc ff ff ff       	call   29d <parse_processor_entry+0xf1>
     2a1:	83 c4 10             	add    esp,0x10
     2a4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pi->ap_id = (uint32_t)p->lapic_id << 24;
     2a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2aa:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     2ae:	0f b6 c0             	movzx  eax,al
     2b1:	c1 e0 18             	shl    eax,0x18
     2b4:	89 c2                	mov    edx,eax
     2b6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2b9:	89 10                	mov    DWORD PTR [eax],edx
				pi->next = apic_ids.ap_ids;
     2bb:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     2c1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2c4:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				apic_ids.ap_ids = pi;
     2c7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2ca:	a3 04 00 00 00       	mov    ds:0x4,eax
				if (cpu.has_htt) {
     2cf:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
     2d6:	83 e0 10             	and    eax,0x10
     2d9:	84 c0                	test   al,al
     2db:	74 42                	je     31f <parse_processor_entry+0x173>
htt_proc: /* mark as speculative */
     2dd:	90                   	nop
						pi = kmalloc(sizeof(struct apid));
     2de:	83 ec 0c             	sub    esp,0xc
     2e1:	6a 08                	push   0x8
     2e3:	e8 fc ff ff ff       	call   2e4 <parse_processor_entry+0x138>
     2e8:	83 c4 10             	add    esp,0x10
     2eb:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						pi->ap_id = ((uint32_t)p->lapic_id + 1) << 24 | 1;
     2ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2f1:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     2f5:	0f b6 c0             	movzx  eax,al
     2f8:	83 c0 01             	add    eax,0x1
     2fb:	c1 e0 18             	shl    eax,0x18
     2fe:	83 c8 01             	or     eax,0x1
     301:	89 c2                	mov    edx,eax
     303:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     306:	89 10                	mov    DWORD PTR [eax],edx
						pi->next = apic_ids.ap_ids;
     308:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     30e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     311:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						apic_ids.ap_ids = pi;
     314:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     317:	a3 04 00 00 00       	mov    ds:0x4,eax
     31c:	eb 01                	jmp    31f <parse_processor_entry+0x173>
				return; /* disabled any */
     31e:	90                   	nop
}
     31f:	8d 65 f8             	lea    esp,[ebp-0x8]
     322:	5b                   	pop    ebx
     323:	5e                   	pop    esi
     324:	5d                   	pop    ebp
     325:	c3                   	ret

00000326 <parse_bus_entry>:
{
     326:	55                   	push   ebp
     327:	89 e5                	mov    ebp,esp
     329:	83 ec 18             	sub    esp,0x18
		printf("Bus with id %u is %.6s\n", b->bus_id, b->bus_type);
     32c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     32f:	8d 50 02             	lea    edx,[eax+0x2]
     332:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     335:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     339:	0f b6 c0             	movzx  eax,al
     33c:	83 ec 04             	sub    esp,0x4
     33f:	52                   	push   edx
     340:	50                   	push   eax
     341:	68 7b 00 00 00       	push   0x7b
     346:	e8 fc ff ff ff       	call   347 <parse_bus_entry+0x21>
     34b:	83 c4 10             	add    esp,0x10
		id = kmalloc(sizeof(struct busid));
     34e:	83 ec 0c             	sub    esp,0xc
     351:	6a 08                	push   0x8
     353:	e8 fc ff ff ff       	call   354 <parse_bus_entry+0x2e>
     358:	83 c4 10             	add    esp,0x10
     35b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		id->id = b->bus_id;
     35e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     361:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     365:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     368:	88 10                	mov    BYTE PTR [eax],dl
		id->next = bus_ids;
     36a:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     370:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     373:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		if (strncmp(b->bus_type, "ISA   ", 6) == 0)
     376:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     379:	83 c0 02             	add    eax,0x2
     37c:	83 ec 04             	sub    esp,0x4
     37f:	6a 06                	push   0x6
     381:	68 93 00 00 00       	push   0x93
     386:	50                   	push   eax
     387:	e8 fc ff ff ff       	call   388 <parse_bus_entry+0x62>
     38c:	83 c4 10             	add    esp,0x10
     38f:	85 c0                	test   eax,eax
     391:	75 09                	jne    39c <parse_bus_entry+0x76>
				id->type = BT_ISA;
     393:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     396:	c6 40 01 00          	mov    BYTE PTR [eax+0x1],0x0
     39a:	eb 65                	jmp    401 <parse_bus_entry+0xdb>
		else if (strncmp(b->bus_type, "EISA  ", 6) == 0)
     39c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     39f:	83 c0 02             	add    eax,0x2
     3a2:	83 ec 04             	sub    esp,0x4
     3a5:	6a 06                	push   0x6
     3a7:	68 9a 00 00 00       	push   0x9a
     3ac:	50                   	push   eax
     3ad:	e8 fc ff ff ff       	call   3ae <parse_bus_entry+0x88>
     3b2:	83 c4 10             	add    esp,0x10
     3b5:	85 c0                	test   eax,eax
     3b7:	75 09                	jne    3c2 <parse_bus_entry+0x9c>
				id->type = BT_EISA;
     3b9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3bc:	c6 40 01 01          	mov    BYTE PTR [eax+0x1],0x1
     3c0:	eb 3f                	jmp    401 <parse_bus_entry+0xdb>
		else if (strncmp(b->bus_type, "PCI   ", 6) == 0)
     3c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c5:	83 c0 02             	add    eax,0x2
     3c8:	83 ec 04             	sub    esp,0x4
     3cb:	6a 06                	push   0x6
     3cd:	68 a1 00 00 00       	push   0xa1
     3d2:	50                   	push   eax
     3d3:	e8 fc ff ff ff       	call   3d4 <parse_bus_entry+0xae>
     3d8:	83 c4 10             	add    esp,0x10
     3db:	85 c0                	test   eax,eax
     3dd:	75 09                	jne    3e8 <parse_bus_entry+0xc2>
				id->type = BT_PCI;
     3df:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3e2:	c6 40 01 02          	mov    BYTE PTR [eax+0x1],0x2
     3e6:	eb 19                	jmp    401 <parse_bus_entry+0xdb>
				cprintf(KFMT_WARN, "bus type is unrecognized and will be ignored.\n");
     3e8:	83 ec 08             	sub    esp,0x8
     3eb:	68 a8 00 00 00       	push   0xa8
     3f0:	6a 0e                	push   0xe
     3f2:	e8 fc ff ff ff       	call   3f3 <parse_bus_entry+0xcd>
     3f7:	83 c4 10             	add    esp,0x10
				id->type = BT_UNKNOWN;
     3fa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3fd:	c6 40 01 ff          	mov    BYTE PTR [eax+0x1],0xff
		bus_ids = id;
     401:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     404:	a3 00 00 00 00       	mov    ds:0x0,eax
}
     409:	90                   	nop
     40a:	c9                   	leave
     40b:	c3                   	ret

0000040c <parse_io_apic>:
{
     40c:	55                   	push   ebp
     40d:	89 e5                	mov    ebp,esp
     40f:	53                   	push   ebx
     410:	83 ec 14             	sub    esp,0x14
						(i->flags & 1) ? "enabled" : "disabled");
     413:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     416:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     41a:	0f b6 c0             	movzx  eax,al
     41d:	83 e0 01             	and    eax,0x1
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     420:	85 c0                	test   eax,eax
     422:	74 07                	je     42b <parse_io_apic+0x1f>
     424:	b9 47 00 00 00       	mov    ecx,0x47
     429:	eb 05                	jmp    430 <parse_io_apic+0x24>
     42b:	b9 4f 00 00 00       	mov    ecx,0x4f
						i->ver, i->id, mp2ptr(i->addr),
     430:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     433:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     436:	89 c3                	mov    ebx,eax
						i->ver, i->id, mp2ptr(i->addr),
     438:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     43b:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     43f:	0f b6 d0             	movzx  edx,al
						i->ver, i->id, mp2ptr(i->addr),
     442:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     445:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     449:	0f b6 c0             	movzx  eax,al
     44c:	83 ec 0c             	sub    esp,0xc
     44f:	51                   	push   ecx
     450:	53                   	push   ebx
     451:	52                   	push   edx
     452:	50                   	push   eax
     453:	68 d8 00 00 00       	push   0xd8
     458:	e8 fc ff ff ff       	call   459 <parse_io_apic+0x4d>
     45d:	83 c4 20             	add    esp,0x20
		if ((i->flags & 1) == 0)
     460:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     463:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     467:	0f b6 c0             	movzx  eax,al
     46a:	83 e0 01             	and    eax,0x1
     46d:	85 c0                	test   eax,eax
     46f:	74 40                	je     4b1 <parse_io_apic+0xa5>
		io = kmalloc(sizeof(struct io_apic));
     471:	83 ec 0c             	sub    esp,0xc
     474:	6a 0c                	push   0xc
     476:	e8 fc ff ff ff       	call   477 <parse_io_apic+0x6b>
     47b:	83 c4 10             	add    esp,0x10
     47e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		io->id = i->id;
     481:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     484:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     488:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     48b:	88 10                	mov    BYTE PTR [eax],dl
		io->addr = mp2ptr(i->addr);
     48d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     490:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     493:	89 c2                	mov    edx,eax
     495:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     498:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		io->next = io_apics;
     49b:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     4a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4a4:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		io_apics = io;
     4a7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4aa:	a3 00 00 00 00       	mov    ds:0x0,eax
     4af:	eb 01                	jmp    4b2 <parse_io_apic+0xa6>
				return;
     4b1:	90                   	nop
}
     4b2:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     4b5:	c9                   	leave
     4b6:	c3                   	ret

000004b7 <find_bus>:
{
     4b7:	55                   	push   ebp
     4b8:	89 e5                	mov    ebp,esp
     4ba:	83 ec 24             	sub    esp,0x24
     4bd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4c0:	88 45 dc             	mov    BYTE PTR [ebp-0x24],al
		struct busid* bi = bus_ids;
     4c3:	a1 00 00 00 00       	mov    eax,ds:0x0
     4c8:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		const char* bts[4] = { "ISA", "EISA", "PCI", "Unknown" };
     4cb:	c7 45 ec 05 01 00 00 	mov    DWORD PTR [ebp-0x14],0x105
     4d2:	c7 45 f0 09 01 00 00 	mov    DWORD PTR [ebp-0x10],0x109
     4d9:	c7 45 f4 0e 01 00 00 	mov    DWORD PTR [ebp-0xc],0x10e
     4e0:	c7 45 f8 12 01 00 00 	mov    DWORD PTR [ebp-0x8],0x112
		if (!bus_ids)
     4e7:	a1 00 00 00 00       	mov    eax,ds:0x0
     4ec:	85 c0                	test   eax,eax
     4ee:	75 07                	jne    4f7 <find_bus+0x40>
				return "";
     4f0:	b8 1a 01 00 00       	mov    eax,0x11a
     4f5:	eb 39                	jmp    530 <find_bus+0x79>
				if (bi->id == id)
     4f7:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     4fa:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     4fd:	38 45 dc             	cmp    BYTE PTR [ebp-0x24],al
     500:	75 1a                	jne    51c <find_bus+0x65>
						return bts[min(bi->type, 3)];
     502:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     505:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     509:	ba 03 00 00 00       	mov    edx,0x3
     50e:	38 d0                	cmp    al,dl
     510:	0f 47 c2             	cmova  eax,edx
     513:	0f b6 c0             	movzx  eax,al
     516:	8b 44 85 ec          	mov    eax,DWORD PTR [ebp+eax*4-0x14]
     51a:	eb 14                	jmp    530 <find_bus+0x79>
		} while ((bi = bi->next));
     51c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     51f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     522:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     525:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     529:	75 cc                	jne    4f7 <find_bus+0x40>
		return "";
     52b:	b8 1a 01 00 00       	mov    eax,0x11a
}
     530:	c9                   	leave
     531:	c3                   	ret

00000532 <parse_io_interrupt>:
{
     532:	55                   	push   ebp
     533:	89 e5                	mov    ebp,esp
     535:	57                   	push   edi
     536:	56                   	push   esi
     537:	53                   	push   ebx
     538:	83 ec 5c             	sub    esp,0x5c
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
     53b:	c7 45 d4 1b 01 00 00 	mov    DWORD PTR [ebp-0x2c],0x11b
     542:	c7 45 d8 1f 01 00 00 	mov    DWORD PTR [ebp-0x28],0x11f
     549:	c7 45 dc 23 01 00 00 	mov    DWORD PTR [ebp-0x24],0x123
     550:	c7 45 e0 27 01 00 00 	mov    DWORD PTR [ebp-0x20],0x127
     557:	c7 45 e4 12 01 00 00 	mov    DWORD PTR [ebp-0x1c],0x112
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
     55e:	c7 45 c4 2e 01 00 00 	mov    DWORD PTR [ebp-0x3c],0x12e
     565:	c7 45 c8 32 01 00 00 	mov    DWORD PTR [ebp-0x38],0x132
     56c:	c7 45 cc 35 01 00 00 	mov    DWORD PTR [ebp-0x34],0x135
     573:	c7 45 d0 39 01 00 00 	mov    DWORD PTR [ebp-0x30],0x139
		const char* el[4] = { "Bus", "edge", "res", "level" };
     57a:	c7 45 b4 2e 01 00 00 	mov    DWORD PTR [ebp-0x4c],0x12e
     581:	c7 45 b8 3c 01 00 00 	mov    DWORD PTR [ebp-0x48],0x13c
     588:	c7 45 bc 35 01 00 00 	mov    DWORD PTR [ebp-0x44],0x135
     58f:	c7 45 c0 41 01 00 00 	mov    DWORD PTR [ebp-0x40],0x141
		if (!prt++) {
     596:	a1 1c 01 00 00       	mov    eax,ds:0x11c
     59b:	8d 50 01             	lea    edx,[eax+0x1]
     59e:	89 15 1c 01 00 00    	mov    DWORD PTR ds:0x11c,edx
     5a4:	85 c0                	test   eax,eax
     5a6:	75 20                	jne    5c8 <parse_io_interrupt+0x96>
				printf("I/O interrupt assignments:\n");
     5a8:	83 ec 0c             	sub    esp,0xc
     5ab:	68 47 01 00 00       	push   0x147
     5b0:	e8 fc ff ff ff       	call   5b1 <parse_io_interrupt+0x7f>
     5b5:	83 c4 10             	add    esp,0x10
				printf("TYPE     BUS (NAME)   IRQ  IOAPIC  INP#  POL    TRIG\n");
     5b8:	83 ec 0c             	sub    esp,0xc
     5bb:	68 64 01 00 00       	push   0x164
     5c0:	e8 fc ff ff ff       	call   5c1 <parse_io_interrupt+0x8f>
     5c5:	83 c4 10             	add    esp,0x10
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
     5c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5cb:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     5cf:	66 c1 e8 02          	shr    ax,0x2
     5d3:	0f b7 c0             	movzx  eax,ax
     5d6:	83 e0 03             	and    eax,0x3
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     5d9:	8b 5c 85 b4          	mov    ebx,DWORD PTR [ebp+eax*4-0x4c]
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
     5dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5e0:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     5e4:	0f b7 c0             	movzx  eax,ax
     5e7:	83 e0 03             	and    eax,0x3
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     5ea:	8b 44 85 c4          	mov    eax,DWORD PTR [ebp+eax*4-0x3c]
     5ee:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     5f1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5f4:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     5f8:	0f b6 c8             	movzx  ecx,al
     5fb:	89 4d a0             	mov    DWORD PTR [ebp-0x60],ecx
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     5fe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     601:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     605:	0f b6 f0             	movzx  esi,al
     608:	89 75 9c             	mov    DWORD PTR [ebp-0x64],esi
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     60b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     60e:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     612:	0f b6 f8             	movzx  edi,al
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     615:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     618:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     61c:	0f b6 c0             	movzx  eax,al
     61f:	83 ec 0c             	sub    esp,0xc
     622:	50                   	push   eax
     623:	e8 fc ff ff ff       	call   624 <parse_io_interrupt+0xf2>
     628:	83 c4 10             	add    esp,0x10
     62b:	89 c6                	mov    esi,eax
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     62d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     630:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     634:	0f b6 c8             	movzx  ecx,al
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     637:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     63a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     63d:	b8 04 00 00 00       	mov    eax,0x4
     642:	38 c2                	cmp    dl,al
     644:	0f 43 c2             	cmovae eax,edx
     647:	0f b6 c0             	movzx  eax,al
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     64a:	8b 44 85 d4          	mov    eax,DWORD PTR [ebp+eax*4-0x2c]
     64e:	83 ec 0c             	sub    esp,0xc
     651:	53                   	push   ebx
     652:	ff 75 a4             	push   DWORD PTR [ebp-0x5c]
     655:	ff 75 a0             	push   DWORD PTR [ebp-0x60]
     658:	ff 75 9c             	push   DWORD PTR [ebp-0x64]
     65b:	57                   	push   edi
     65c:	56                   	push   esi
     65d:	51                   	push   ecx
     65e:	50                   	push   eax
     65f:	68 9c 01 00 00       	push   0x19c
     664:	e8 fc ff ff ff       	call   665 <parse_io_interrupt+0x133>
     669:	83 c4 30             	add    esp,0x30
}
     66c:	90                   	nop
     66d:	8d 65 f4             	lea    esp,[ebp-0xc]
     670:	5b                   	pop    ebx
     671:	5e                   	pop    esi
     672:	5f                   	pop    edi
     673:	5d                   	pop    ebp
     674:	c3                   	ret

00000675 <parse_local_interrupt>:
{
     675:	55                   	push   ebp
     676:	89 e5                	mov    ebp,esp
     678:	56                   	push   esi
     679:	53                   	push   ebx
     67a:	83 ec 50             	sub    esp,0x50
		printf("local interrupt assignment:\n");
     67d:	83 ec 0c             	sub    esp,0xc
     680:	68 c6 01 00 00       	push   0x1c6
     685:	e8 fc ff ff ff       	call   686 <parse_local_interrupt+0x11>
     68a:	83 c4 10             	add    esp,0x10
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
     68d:	c7 45 e4 1b 01 00 00 	mov    DWORD PTR [ebp-0x1c],0x11b
     694:	c7 45 e8 1f 01 00 00 	mov    DWORD PTR [ebp-0x18],0x11f
     69b:	c7 45 ec 23 01 00 00 	mov    DWORD PTR [ebp-0x14],0x123
     6a2:	c7 45 f0 27 01 00 00 	mov    DWORD PTR [ebp-0x10],0x127
     6a9:	c7 45 f4 12 01 00 00 	mov    DWORD PTR [ebp-0xc],0x112
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
     6b0:	c7 45 d4 2e 01 00 00 	mov    DWORD PTR [ebp-0x2c],0x12e
     6b7:	c7 45 d8 32 01 00 00 	mov    DWORD PTR [ebp-0x28],0x132
     6be:	c7 45 dc 35 01 00 00 	mov    DWORD PTR [ebp-0x24],0x135
     6c5:	c7 45 e0 39 01 00 00 	mov    DWORD PTR [ebp-0x20],0x139
		const char* el[4] = { "Bus", "edge", "res", "level" };
     6cc:	c7 45 c4 2e 01 00 00 	mov    DWORD PTR [ebp-0x3c],0x12e
     6d3:	c7 45 c8 3c 01 00 00 	mov    DWORD PTR [ebp-0x38],0x13c
     6da:	c7 45 cc 35 01 00 00 	mov    DWORD PTR [ebp-0x34],0x135
     6e1:	c7 45 d0 41 01 00 00 	mov    DWORD PTR [ebp-0x30],0x141
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     6e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6eb:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     6ef:	0f b6 d8             	movzx  ebx,al
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     6f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6f5:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     6f9:	0f b6 c0             	movzx  eax,al
     6fc:	83 ec 0c             	sub    esp,0xc
     6ff:	50                   	push   eax
     700:	e8 fc ff ff ff       	call   701 <parse_local_interrupt+0x8c>
     705:	83 c4 10             	add    esp,0x10
     708:	89 c2                	mov    edx,eax
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     70a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     70d:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     711:	0f b6 c8             	movzx  ecx,al
     714:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     717:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     71a:	c6 45 b7 04          	mov    BYTE PTR [ebp-0x49],0x4
     71e:	3a 45 b7             	cmp    al,BYTE PTR [ebp-0x49]
     721:	0f b6 75 b7          	movzx  esi,BYTE PTR [ebp-0x49]
     725:	0f 42 c6             	cmovb  eax,esi
     728:	0f b6 c0             	movzx  eax,al
     72b:	8b 44 85 e4          	mov    eax,DWORD PTR [ebp+eax*4-0x1c]
     72f:	83 ec 0c             	sub    esp,0xc
     732:	53                   	push   ebx
     733:	52                   	push   edx
     734:	51                   	push   ecx
     735:	50                   	push   eax
     736:	68 e4 01 00 00       	push   0x1e4
     73b:	e8 fc ff ff ff       	call   73c <parse_local_interrupt+0xc7>
     740:	83 c4 20             	add    esp,0x20
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
     743:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     746:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     74a:	66 c1 e8 02          	shr    ax,0x2
     74e:	0f b7 c0             	movzx  eax,ax
     751:	83 e0 03             	and    eax,0x3
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     754:	8b 5c 85 c4          	mov    ebx,DWORD PTR [ebp+eax*4-0x3c]
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
     758:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     75b:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     75f:	0f b7 c0             	movzx  eax,ax
     762:	83 e0 03             	and    eax,0x3
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     765:	8b 4c 85 d4          	mov    ecx,DWORD PTR [ebp+eax*4-0x2c]
				l->dest_lapic_id, l->dest_lapic_linp,
     769:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     76c:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     770:	0f b6 d0             	movzx  edx,al
				l->dest_lapic_id, l->dest_lapic_linp,
     773:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     776:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     77a:	0f b6 c0             	movzx  eax,al
     77d:	83 ec 0c             	sub    esp,0xc
     780:	53                   	push   ebx
     781:	51                   	push   ecx
     782:	52                   	push   edx
     783:	50                   	push   eax
     784:	68 08 02 00 00       	push   0x208
     789:	e8 fc ff ff ff       	call   78a <parse_local_interrupt+0x115>
     78e:	83 c4 20             	add    esp,0x20
}
     791:	90                   	nop
     792:	8d 65 f8             	lea    esp,[ebp-0x8]
     795:	5b                   	pop    ebx
     796:	5e                   	pop    esi
     797:	5d                   	pop    ebp
     798:	c3                   	ret

00000799 <mp_sanitize_table>:
{
     799:	55                   	push   ebp
     79a:	89 e5                	mov    ebp,esp
     79c:	83 ec 18             	sub    esp,0x18
		if (!cpu.has_htt)
     79f:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
     7a6:	83 e0 10             	and    eax,0x10
     7a9:	84 c0                	test   al,al
     7ab:	0f 84 b0 00 00 00    	je     861 <mp_sanitize_table+0xc8>
		if (!(ps = apic_ids.ap_ids))
     7b1:	a1 04 00 00 00       	mov    eax,ds:0x4
     7b6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     7b9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     7bd:	0f 84 a1 00 00 00    	je     864 <mp_sanitize_table+0xcb>
		pt = &apic_ids.ap_ids;
     7c3:	c7 45 f0 04 00 00 00 	mov    DWORD PTR [ebp-0x10],0x4
				int psu = 0;
     7ca:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				if (ps->ap_id & 1) {
     7d1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7d4:	8b 00                	mov    eax,DWORD PTR [eax]
     7d6:	83 e0 01             	and    eax,0x1
     7d9:	85 c0                	test   eax,eax
     7db:	74 61                	je     83e <mp_sanitize_table+0xa5>
						struct apid* p2 = apic_ids.ap_ids;
     7dd:	a1 04 00 00 00       	mov    eax,ds:0x4
     7e2:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								if (p2->ap_id == (ps->ap_id & 0xfffffffe)) {
     7e5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     7e8:	8b 10                	mov    edx,DWORD PTR [eax]
     7ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7ed:	8b 00                	mov    eax,DWORD PTR [eax]
     7ef:	83 e0 fe             	and    eax,0xfffffffe
     7f2:	39 c2                	cmp    edx,eax
     7f4:	75 22                	jne    818 <mp_sanitize_table+0x7f>
										*pt = ps->next;
     7f6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7f9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     7fc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7ff:	89 10                	mov    DWORD PTR [eax],edx
										kfree(ps);
     801:	83 ec 0c             	sub    esp,0xc
     804:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     807:	e8 fc ff ff ff       	call   808 <mp_sanitize_table+0x6f>
     80c:	83 c4 10             	add    esp,0x10
										psu = 1;
     80f:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
										break;
     816:	eb 0f                	jmp    827 <mp_sanitize_table+0x8e>
						} while ((p2 = p2->next));
     818:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     81b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     81e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     821:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     825:	75 be                	jne    7e5 <mp_sanitize_table+0x4c>
						if (!psu)
     827:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     82b:	75 11                	jne    83e <mp_sanitize_table+0xa5>
								ps->ap_id &= 0xffffffe;
     82d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     830:	8b 00                	mov    eax,DWORD PTR [eax]
     832:	25 fe ff ff 0f       	and    eax,0xffffffe
     837:	89 c2                	mov    edx,eax
     839:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     83c:	89 10                	mov    DWORD PTR [eax],edx
				if (!psu)
     83e:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     842:	75 09                	jne    84d <mp_sanitize_table+0xb4>
						pt = &ps->next;
     844:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     847:	83 c0 04             	add    eax,0x4
     84a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		} while ((ps = *pt));
     84d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     850:	8b 00                	mov    eax,DWORD PTR [eax]
     852:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     855:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     859:	0f 85 6b ff ff ff    	jne    7ca <mp_sanitize_table+0x31>
     85f:	eb 04                	jmp    865 <mp_sanitize_table+0xcc>
				return;
     861:	90                   	nop
     862:	eb 01                	jmp    865 <mp_sanitize_table+0xcc>
				return;
     864:	90                   	nop
}
     865:	c9                   	leave
     866:	c3                   	ret

00000867 <mp_parse_config_table>:
{
     867:	55                   	push   ebp
     868:	89 e5                	mov    ebp,esp
     86a:	83 ec 28             	sub    esp,0x28
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
     86d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     870:	c1 e8 0c             	shr    eax,0xc
     873:	ba 00 00 00 00       	mov    edx,0x0
     878:	0f a4 c2 0c          	shld   edx,eax,0xc
     87c:	c1 e0 0c             	shl    eax,0xc
     87f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     882:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
     885:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
     88c:	83 ec 0c             	sub    esp,0xc
     88f:	6a 08                	push   0x8
     891:	6a 01                	push   0x1
     893:	8d 45 dc             	lea    eax,[ebp-0x24]
     896:	50                   	push   eax
     897:	6a 00                	push   0x0
     899:	68 00 00 00 00       	push   0x0
     89e:	e8 fc ff ff ff       	call   89f <mp_parse_config_table+0x38>
     8a3:	83 c4 20             	add    esp,0x20
     8a6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!mp) {
     8a9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     8ad:	75 17                	jne    8c6 <mp_parse_config_table+0x5f>
				cprintf(KFMT_WARN, "unable to map MP configuration table to virtual memory. Continuing with UP init.\n");
     8af:	83 ec 08             	sub    esp,0x8
     8b2:	68 34 02 00 00       	push   0x234
     8b7:	6a 0e                	push   0xe
     8b9:	e8 fc ff ff ff       	call   8ba <mp_parse_config_table+0x53>
     8be:	83 c4 10             	add    esp,0x10
     8c1:	e9 f0 01 00 00       	jmp    ab6 <mp_parse_config_table+0x24f>
		mp = (void*)mp + ((uint32_t)ptr % 4096);
     8c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8c9:	25 ff 0f 00 00       	and    eax,0xfff
     8ce:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		if (mp->length > 4096) {
     8d1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8d4:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     8d8:	66 3d 00 10          	cmp    ax,0x1000
     8dc:	0f 86 9c 00 00 00    	jbe    97e <mp_parse_config_table+0x117>
				pr.count = rdiv(mp->length, 4096);
     8e2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8e5:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     8e9:	66 c1 e8 0c          	shr    ax,0xc
     8ed:	0f b7 d0             	movzx  edx,ax
     8f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8f3:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     8f7:	66 25 ff 0f          	and    ax,0xfff
     8fb:	66 85 c0             	test   ax,ax
     8fe:	0f 95 c0             	setne  al
     901:	0f b6 c0             	movzx  eax,al
     904:	01 d0                	add    eax,edx
     906:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
     909:	83 ec 0c             	sub    esp,0xc
     90c:	6a 08                	push   0x8
     90e:	6a 01                	push   0x1
     910:	8d 45 dc             	lea    eax,[ebp-0x24]
     913:	50                   	push   eax
     914:	6a 00                	push   0x0
     916:	68 00 00 00 00       	push   0x0
     91b:	e8 fc ff ff ff       	call   91c <mp_parse_config_table+0xb5>
     920:	83 c4 20             	add    esp,0x20
     923:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (!mem)
     926:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     92a:	75 2b                	jne    957 <mp_parse_config_table+0xf0>
						die("mmap fails very early!\n");
     92c:	83 ec 08             	sub    esp,0x8
     92f:	68 86 02 00 00       	push   0x286
     934:	6a 0c                	push   0xc
     936:	e8 fc ff ff ff       	call   937 <mp_parse_config_table+0xd0>
     93b:	83 c4 10             	add    esp,0x10
     93e:	e8 fc ff ff ff       	call   93f <mp_parse_config_table+0xd8>
     943:	83 ec 0c             	sub    esp,0xc
     946:	68 00 00 00 00       	push   0x0
     94b:	e8 fc ff ff ff       	call   94c <mp_parse_config_table+0xe5>
     950:	83 c4 10             	add    esp,0x10
     953:	fa                   	cli
     954:	f4                   	hlt
     955:	eb fd                	jmp    954 <mp_parse_config_table+0xed>
				mm_unmap(&mm_kernel, mp, 1);
     957:	83 ec 04             	sub    esp,0x4
     95a:	6a 01                	push   0x1
     95c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     95f:	68 00 00 00 00       	push   0x0
     964:	e8 fc ff ff ff       	call   965 <mp_parse_config_table+0xfe>
     969:	83 c4 10             	add    esp,0x10
				mp = mem + (uint32_t)ptr % 4096;
     96c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     96f:	25 ff 0f 00 00       	and    eax,0xfff
     974:	89 c2                	mov    edx,eax
     976:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     979:	01 d0                	add    eax,edx
     97b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (checksum_memory(mp, mp->length) != 0) {
     97e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     981:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     985:	0f b7 c0             	movzx  eax,ax
     988:	83 ec 08             	sub    esp,0x8
     98b:	50                   	push   eax
     98c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     98f:	e8 db f6 ff ff       	call   6f <checksum_memory>
     994:	83 c4 10             	add    esp,0x10
     997:	84 c0                	test   al,al
     999:	74 15                	je     9b0 <mp_parse_config_table+0x149>
				cprintf(KFMT_WARN, "MP configuration table checksum error resulting in UP init.\n");
     99b:	83 ec 08             	sub    esp,0x8
     99e:	68 a0 02 00 00       	push   0x2a0
     9a3:	6a 0e                	push   0xe
     9a5:	e8 fc ff ff ff       	call   9a6 <mp_parse_config_table+0x13f>
     9aa:	83 c4 10             	add    esp,0x10
				while (1);
     9ad:	90                   	nop
     9ae:	eb fd                	jmp    9ad <mp_parse_config_table+0x146>
				mp->spec_rev, mp->product_id, mp->oem_id);
     9b0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9b3:	8d 48 08             	lea    ecx,[eax+0x8]
     9b6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9b9:	8d 50 10             	lea    edx,[eax+0x10]
     9bc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9bf:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
		printf("MP configuration table version 1.%u for machine %.12s from vendor %.8s\n",
     9c3:	0f b6 c0             	movzx  eax,al
     9c6:	51                   	push   ecx
     9c7:	52                   	push   edx
     9c8:	50                   	push   eax
     9c9:	68 e0 02 00 00       	push   0x2e0
     9ce:	e8 fc ff ff ff       	call   9cf <mp_parse_config_table+0x168>
     9d3:	83 c4 10             	add    esp,0x10
		e = mp + 1;
     9d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9d9:	83 c0 2c             	add    eax,0x2c
     9dc:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ec = mp->entry_count;
     9df:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9e2:	0f b7 40 22          	movzx  eax,WORD PTR [eax+0x22]
     9e6:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
		while (ec--) {
     9ea:	e9 94 00 00 00       	jmp    a83 <mp_parse_config_table+0x21c>
				switch (*(uint8_t*)e) {
     9ef:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     9f2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     9f5:	0f b6 c0             	movzx  eax,al
     9f8:	83 f8 04             	cmp    eax,0x4
     9fb:	77 6d                	ja     a6a <mp_parse_config_table+0x203>
     9fd:	8b 04 85 8c 03 00 00 	mov    eax,DWORD PTR [eax*4+0x38c]
     a04:	ff e0                	jmp    eax
						parse_processor_entry(e);
     a06:	83 ec 0c             	sub    esp,0xc
     a09:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     a0c:	e8 fc ff ff ff       	call   a0d <mp_parse_config_table+0x1a6>
     a11:	83 c4 10             	add    esp,0x10
						e += 20;
     a14:	83 45 ec 14          	add    DWORD PTR [ebp-0x14],0x14
						break;
     a18:	eb 69                	jmp    a83 <mp_parse_config_table+0x21c>
						parse_bus_entry(e);
     a1a:	83 ec 0c             	sub    esp,0xc
     a1d:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     a20:	e8 fc ff ff ff       	call   a21 <mp_parse_config_table+0x1ba>
     a25:	83 c4 10             	add    esp,0x10
						e += 8;
     a28:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     a2c:	eb 55                	jmp    a83 <mp_parse_config_table+0x21c>
						parse_io_apic(e);
     a2e:	83 ec 0c             	sub    esp,0xc
     a31:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     a34:	e8 fc ff ff ff       	call   a35 <mp_parse_config_table+0x1ce>
     a39:	83 c4 10             	add    esp,0x10
						e += 8;
     a3c:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     a40:	eb 41                	jmp    a83 <mp_parse_config_table+0x21c>
						parse_io_interrupt(e);
     a42:	83 ec 0c             	sub    esp,0xc
     a45:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     a48:	e8 fc ff ff ff       	call   a49 <mp_parse_config_table+0x1e2>
     a4d:	83 c4 10             	add    esp,0x10
						e += 8;
     a50:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     a54:	eb 2d                	jmp    a83 <mp_parse_config_table+0x21c>
						parse_local_interrupt(e);
     a56:	83 ec 0c             	sub    esp,0xc
     a59:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     a5c:	e8 fc ff ff ff       	call   a5d <mp_parse_config_table+0x1f6>
     a61:	83 c4 10             	add    esp,0x10
						e += 8;
     a64:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     a68:	eb 19                	jmp    a83 <mp_parse_config_table+0x21c>
						cprintf(KFMT_WARN, "encountered an unknown entry in the MP table with unkown length. Further parsing is impossible.\n");
     a6a:	83 ec 08             	sub    esp,0x8
     a6d:	68 28 03 00 00       	push   0x328
     a72:	6a 0e                	push   0xe
     a74:	e8 fc ff ff ff       	call   a75 <mp_parse_config_table+0x20e>
     a79:	83 c4 10             	add    esp,0x10
						if (ec > 0) /* only ignore last entry */
     a7c:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     a81:	75 1b                	jne    a9e <mp_parse_config_table+0x237>
		while (ec--) {
     a83:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     a87:	8d 50 ff             	lea    edx,[eax-0x1]
     a8a:	66 89 55 f2          	mov    WORD PTR [ebp-0xe],dx
     a8e:	66 85 c0             	test   ax,ax
     a91:	0f 85 58 ff ff ff    	jne    9ef <mp_parse_config_table+0x188>
		mp_sanitize_table();
     a97:	e8 fc ff ff ff       	call   a98 <mp_parse_config_table+0x231>
     a9c:	eb 01                	jmp    a9f <mp_parse_config_table+0x238>
								goto cleanup;
     a9e:	90                   	nop
		mm_unmap(&mm_kernel, mp, pr.count);
     a9f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     aa2:	83 ec 04             	sub    esp,0x4
     aa5:	50                   	push   eax
     aa6:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     aa9:	68 00 00 00 00       	push   0x0
     aae:	e8 fc ff ff ff       	call   aaf <mp_parse_config_table+0x248>
     ab3:	83 c4 10             	add    esp,0x10
}
     ab6:	c9                   	leave
     ab7:	c3                   	ret

00000ab8 <set_fs_offset>:
{
     ab8:	55                   	push   ebp
     ab9:	89 e5                	mov    ebp,esp
     abb:	53                   	push   ebx
     abc:	83 ec 14             	sub    esp,0x14
		uint32_t o = (uint32_t)ofs;
     abf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ac2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
     ac5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ac8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     acb:	8b 00                	mov    eax,DWORD PTR [eax]
     acd:	25 ff ff 00 00       	and    eax,0xffff
     ad2:	81 e2 00 ff ff 00    	and    edx,0xffff00
     ad8:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     adb:	c1 e1 10             	shl    ecx,0x10
     ade:	bb 00 00 00 00       	mov    ebx,0x0
     ae3:	09 c1                	or     ecx,eax
     ae5:	09 d3                	or     ebx,edx
				| ((uint64_t)(o & 0xff0000) << 16) | ((uint64_t)(o & 0xff000000) << 32);
     ae7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     aea:	ba 00 00 00 00       	mov    edx,0x0
     aef:	0f a4 c2 10          	shld   edx,eax,0x10
     af3:	c1 e0 10             	shl    eax,0x10
     af6:	b8 00 00 00 00       	mov    eax,0x0
     afb:	81 e2 ff 00 00 00    	and    edx,0xff
     b01:	09 c1                	or     ecx,eax
     b03:	09 d3                	or     ebx,edx
     b05:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b08:	ba 00 00 00 00       	mov    edx,0x0
     b0d:	89 c2                	mov    edx,eax
     b0f:	31 c0                	xor    eax,eax
     b11:	b8 00 00 00 00       	mov    eax,0x0
     b16:	81 e2 00 00 00 ff    	and    edx,0xff000000
     b1c:	09 c8                	or     eax,ecx
     b1e:	09 da                	or     edx,ebx
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
     b20:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     b23:	89 01                	mov    DWORD PTR [ecx],eax
     b25:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
     b28:	90                   	nop
     b29:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     b2c:	c9                   	leave
     b2d:	c3                   	ret

00000b2e <update_fs>:
{
     b2e:	55                   	push   ebp
     b2f:	89 e5                	mov    ebp,esp
		asm volatile (
     b31:	66 b8 40 00          	mov    ax,0x40
     b35:	8e e0                	mov    fs,eax
}
     b37:	90                   	nop
     b38:	5d                   	pop    ebp
     b39:	c3                   	ret

00000b3a <apic_get_base>:
{
     b3a:	55                   	push   ebp
     b3b:	89 e5                	mov    ebp,esp
     b3d:	53                   	push   ebx
     b3e:	83 ec 14             	sub    esp,0x14
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
     b41:	83 ec 04             	sub    esp,0x4
     b44:	8d 45 f0             	lea    eax,[ebp-0x10]
     b47:	50                   	push   eax
     b48:	8d 45 f4             	lea    eax,[ebp-0xc]
     b4b:	50                   	push   eax
     b4c:	6a 1b                	push   0x1b
     b4e:	e8 fc ff ff ff       	call   b4f <apic_get_base+0x15>
     b53:	83 c4 10             	add    esp,0x10
		return ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
     b56:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b59:	ba 00 00 00 00       	mov    edx,0x0
     b5e:	89 c2                	mov    edx,eax
     b60:	31 c0                	xor    eax,eax
     b62:	b8 00 00 00 00       	mov    eax,0x0
     b67:	83 e2 0f             	and    edx,0xf
     b6a:	89 c1                	mov    ecx,eax
     b6c:	89 d3                	mov    ebx,edx
     b6e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b71:	ba 00 00 00 00       	mov    edx,0x0
     b76:	25 00 f0 ff ff       	and    eax,0xfffff000
     b7b:	ba 00 00 00 00       	mov    edx,0x0
     b80:	09 c8                	or     eax,ecx
     b82:	09 da                	or     edx,ebx
}
     b84:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     b87:	c9                   	leave
     b88:	c3                   	ret

00000b89 <pcp_init>:
{
     b89:	55                   	push   ebp
     b8a:	89 e5                	mov    ebp,esp
     b8c:	53                   	push   ebx
     b8d:	83 ec 24             	sub    esp,0x24
		pcp_data = mm_alloc_page(&pm);
     b90:	83 ec 0c             	sub    esp,0xc
     b93:	8d 45 e8             	lea    eax,[ebp-0x18]
     b96:	50                   	push   eax
     b97:	e8 fc ff ff ff       	call   b98 <pcp_init+0xf>
     b9c:	83 c4 10             	add    esp,0x10
     b9f:	a3 00 00 00 00       	mov    ds:0x0,eax
		ap_stack = (void*)0x06000; // FM_AP_STACK top down (6->5)
     ba4:	c7 05 00 00 00 00 00 60 00 00 	mov    DWORD PTR ds:0x0,0x6000
		ap_cr3 = mm_kernel.cr3;
     bae:	a1 00 00 00 00       	mov    eax,ds:0x0
     bb3:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     bb9:	a3 00 00 00 00       	mov    ds:0x0,eax
     bbe:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		if (cpu.has_pae)
     bc4:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
     bcb:	83 e0 40             	and    eax,0x40
     bce:	84 c0                	test   al,al
     bd0:	74 09                	je     bdb <pcp_init+0x52>
				ap_mode = 1;
     bd2:	c6 05 00 00 00 00 01 	mov    BYTE PTR ds:0x0,0x1
     bd9:	eb 07                	jmp    be2 <pcp_init+0x59>
				ap_mode = 0;
     bdb:	c6 05 00 00 00 00 00 	mov    BYTE PTR ds:0x0,0x0
		pcp_data[0] = pd = kmalloc(sizeof(struct processor_data));
     be2:	83 ec 0c             	sub    esp,0xc
     be5:	6a 20                	push   0x20
     be7:	e8 fc ff ff ff       	call   be8 <pcp_init+0x5f>
     bec:	83 c4 10             	add    esp,0x10
     bef:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     bf2:	a1 00 00 00 00       	mov    eax,ds:0x0
     bf7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     bfa:	89 10                	mov    DWORD PTR [eax],edx
		pcp_ofs++;
     bfc:	a1 00 00 00 00       	mov    eax,ds:0x0
     c01:	83 c0 01             	add    eax,0x1
     c04:	a3 00 00 00 00       	mov    ds:0x0,eax
		pd->proc_index = 0;
     c09:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c0c:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		pd->apic_id = apic_ids.bp_id;
     c12:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     c18:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c1b:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pd->apic_addr = bp_apic_base;
     c1e:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     c24:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c27:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pd->apic_phys = apic_get_base();
     c2a:	e8 fc ff ff ff       	call   c2b <pcp_init+0xa2>
     c2f:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c32:	89 41 0c             	mov    DWORD PTR [ecx+0xc],eax
     c35:	89 51 10             	mov    DWORD PTR [ecx+0x10],edx
		pd->ticks = bp_tick;
     c38:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     c3e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c41:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pd->mm_ctx = mm_create_ctx();
     c44:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
     c47:	8d 45 e0             	lea    eax,[ebp-0x20]
     c4a:	83 ec 0c             	sub    esp,0xc
     c4d:	50                   	push   eax
     c4e:	e8 fc ff ff ff       	call   c4f <pcp_init+0xc6>
     c53:	83 c4 0c             	add    esp,0xc
     c56:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     c59:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     c5c:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
     c5f:	89 53 1c             	mov    DWORD PTR [ebx+0x1c],edx
		set_fs_offset(pcp_data, (uint64_t*)(ap_gdtp + 0x40));
     c62:	a1 00 00 00 00       	mov    eax,ds:0x0
     c67:	8d 50 40             	lea    edx,[eax+0x40]
     c6a:	a1 00 00 00 00       	mov    eax,ds:0x0
     c6f:	83 ec 08             	sub    esp,0x8
     c72:	52                   	push   edx
     c73:	50                   	push   eax
     c74:	e8 fc ff ff ff       	call   c75 <pcp_init+0xec>
     c79:	83 c4 10             	add    esp,0x10
		update_fs();
     c7c:	e8 fc ff ff ff       	call   c7d <pcp_init+0xf4>
		asm volatile ("movl %%fs:0, %%eax" : "=a" (ptr));
     c81:	64 a1 00 00 00 00    	mov    eax,fs:0x0
     c87:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (ptr != pd)
     c8a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c8d:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
     c90:	74 2b                	je     cbd <pcp_init+0x134>
				die("per-cpu data through fs/gs segment selector not working!\n");
     c92:	83 ec 08             	sub    esp,0x8
     c95:	68 a0 03 00 00       	push   0x3a0
     c9a:	6a 0c                	push   0xc
     c9c:	e8 fc ff ff ff       	call   c9d <pcp_init+0x114>
     ca1:	83 c4 10             	add    esp,0x10
     ca4:	e8 fc ff ff ff       	call   ca5 <pcp_init+0x11c>
     ca9:	83 ec 0c             	sub    esp,0xc
     cac:	68 00 00 00 00       	push   0x0
     cb1:	e8 fc ff ff ff       	call   cb2 <pcp_init+0x129>
     cb6:	83 c4 10             	add    esp,0x10
     cb9:	fa                   	cli
     cba:	f4                   	hlt
     cbb:	eb fd                	jmp    cba <pcp_init+0x131>
}
     cbd:	90                   	nop
     cbe:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     cc1:	c9                   	leave
     cc2:	c3                   	ret

00000cc3 <get_cpu_data>:
{
     cc3:	55                   	push   ebp
     cc4:	89 e5                	mov    ebp,esp
		return pcp_data[smp_index];
     cc6:	a1 00 00 00 00       	mov    eax,ds:0x0
     ccb:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     cce:	c1 e2 02             	shl    edx,0x2
     cd1:	01 d0                	add    eax,edx
     cd3:	8b 00                	mov    eax,DWORD PTR [eax]
}
     cd5:	5d                   	pop    ebp
     cd6:	c3                   	ret

00000cd7 <launch_ap>:
{
     cd7:	55                   	push   ebp
     cd8:	89 e5                	mov    ebp,esp
     cda:	57                   	push   edi
     cdb:	56                   	push   esi
     cdc:	53                   	push   ebx
     cdd:	83 ec 2c             	sub    esp,0x2c
		uint64_t ct = 10, timeout;
     ce0:	c7 45 e0 0a 00 00 00 	mov    DWORD PTR [ebp-0x20],0xa
     ce7:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		ap_start = ap_fail = 0;
     cee:	b8 00 00 00 00       	mov    eax,0x0
     cf3:	a2 00 00 00 00       	mov    ds:0x0,al
     cf8:	a2 00 00 00 00       	mov    ds:0x0,al
		if (pcp_ofs >= 1023) {
     cfd:	a1 00 00 00 00       	mov    eax,ds:0x0
     d02:	3d fe 03 00 00       	cmp    eax,0x3fe
     d07:	76 1c                	jbe    d25 <launch_ap+0x4e>
				cprintf(KFMT_WARN, "cpu-data limit reached, skipping processors.\n");
     d09:	83 ec 08             	sub    esp,0x8
     d0c:	68 dc 03 00 00       	push   0x3dc
     d11:	6a 0e                	push   0xe
     d13:	e8 fc ff ff ff       	call   d14 <launch_ap+0x3d>
     d18:	83 c4 10             	add    esp,0x10
				return -1;
     d1b:	b8 ff ff ff ff       	mov    eax,0xffffffff
     d20:	e9 fb 02 00 00       	jmp    1020 <launch_ap+0x349>
		preempt_disable();
     d25:	e8 fc ff ff ff       	call   d26 <launch_ap+0x4f>
     d2a:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     d2d:	83 c2 01             	add    edx,0x1
     d30:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		pcp_data[pcp_ofs] = pd = kzalloc(sizeof(struct processor_data));
     d33:	83 ec 0c             	sub    esp,0xc
     d36:	6a 20                	push   0x20
     d38:	e8 fc ff ff ff       	call   d39 <launch_ap+0x62>
     d3d:	83 c4 10             	add    esp,0x10
     d40:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     d43:	a1 00 00 00 00       	mov    eax,ds:0x0
     d48:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     d4e:	c1 e2 02             	shl    edx,0x2
     d51:	01 c2                	add    edx,eax
     d53:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     d56:	89 02                	mov    DWORD PTR [edx],eax
		pd->apic_id = id;
     d58:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     d5b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     d5e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pd->apic_addr = bp_apic_base - 4096;
     d61:	a1 00 00 00 00       	mov    eax,ds:0x0
     d66:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
     d6c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     d6f:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pd->apic_phys = 0;
     d72:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     d75:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
     d7c:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		pd->proc_index = pcp_ofs;
     d83:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     d89:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     d8c:	89 10                	mov    DWORD PTR [eax],edx
		pd->ticks = kzalloc(sizeof(struct perf_ctrs));
     d8e:	83 ec 0c             	sub    esp,0xc
     d91:	6a 50                	push   0x50
     d93:	e8 fc ff ff ff       	call   d94 <launch_ap+0xbd>
     d98:	83 c4 10             	add    esp,0x10
     d9b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     d9e:	89 42 14             	mov    DWORD PTR [edx+0x14],eax
		ap_gdtp = kmalloc(GDT_SIZE);
     da1:	83 ec 0c             	sub    esp,0xc
     da4:	6a 50                	push   0x50
     da6:	e8 fc ff ff ff       	call   da7 <launch_ap+0xd0>
     dab:	83 c4 10             	add    esp,0x10
     dae:	a3 00 00 00 00       	mov    ds:0x0,eax
		memcpy(ap_gdtp, &gdt, GDT_SIZE);
     db3:	a1 00 00 00 00       	mov    eax,ds:0x0
     db8:	83 ec 04             	sub    esp,0x4
     dbb:	6a 50                	push   0x50
     dbd:	68 00 00 00 00       	push   0x0
     dc2:	50                   	push   eax
     dc3:	e8 6b f2 ff ff       	call   33 <memcpy>
     dc8:	83 c4 10             	add    esp,0x10
		set_fs_offset(pcp_data + pcp_ofs, (uint64_t*)(ap_gdtp + SEG_DATA_PROC));
     dcb:	a1 00 00 00 00       	mov    eax,ds:0x0
     dd0:	8d 50 40             	lea    edx,[eax+0x40]
     dd3:	a1 00 00 00 00       	mov    eax,ds:0x0
     dd8:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     dde:	c1 e1 02             	shl    ecx,0x2
     de1:	01 c8                	add    eax,ecx
     de3:	83 ec 08             	sub    esp,0x8
     de6:	52                   	push   edx
     de7:	50                   	push   eax
     de8:	e8 fc ff ff ff       	call   de9 <launch_ap+0x112>
     ded:	83 c4 10             	add    esp,0x10
		apic_reg(APIC_REG_ESR) = 0;
     df0:	e8 0b f2 ff ff       	call   0 <per_cpu_ptr>
     df5:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     df8:	05 80 02 00 00       	add    eax,0x280
     dfd:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		apic_reg(APIC_REG_ICRH) = id;
     e03:	e8 f8 f1 ff ff       	call   0 <per_cpu_ptr>
     e08:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e0b:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
     e11:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e14:	89 02                	mov    DWORD PTR [edx],eax
		apic_reg(APIC_REG_ICRL) = 0x0000c500; /* edge assert level init */
     e16:	e8 e5 f1 ff ff       	call   0 <per_cpu_ptr>
     e1b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e1e:	05 00 03 00 00       	add    eax,0x300
     e23:	c7 00 00 c5 00 00    	mov    DWORD PTR [eax],0xc500
		while (apic_reg(APIC_REG_ICRL) & (1 << 12)); /* send pending */
     e29:	90                   	nop
     e2a:	e8 d1 f1 ff ff       	call   0 <per_cpu_ptr>
     e2f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e32:	05 00 03 00 00       	add    eax,0x300
     e37:	8b 00                	mov    eax,DWORD PTR [eax]
     e39:	25 00 10 00 00       	and    eax,0x1000
     e3e:	85 c0                	test   eax,eax
     e40:	75 e8                	jne    e2a <launch_ap+0x153>
		mdelay(20);
     e42:	83 ec 0c             	sub    esp,0xc
     e45:	6a 14                	push   0x14
     e47:	e8 fc ff ff ff       	call   e48 <launch_ap+0x171>
     e4c:	83 c4 10             	add    esp,0x10
		apic_reg(APIC_REG_ICRH) = id;
     e4f:	e8 ac f1 ff ff       	call   0 <per_cpu_ptr>
     e54:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e57:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
     e5d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e60:	89 02                	mov    DWORD PTR [edx],eax
		apic_reg(APIC_REG_ICRL) = 0x00008500; /* edge de-assert init */
     e62:	e8 99 f1 ff ff       	call   0 <per_cpu_ptr>
     e67:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e6a:	05 00 03 00 00       	add    eax,0x300
     e6f:	c7 00 00 85 00 00    	mov    DWORD PTR [eax],0x8500
		while (apic_reg(APIC_REG_ICRL) & (1 << 12));
     e75:	90                   	nop
     e76:	e8 85 f1 ff ff       	call   0 <per_cpu_ptr>
     e7b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e7e:	05 00 03 00 00       	add    eax,0x300
     e83:	8b 00                	mov    eax,DWORD PTR [eax]
     e85:	25 00 10 00 00       	and    eax,0x1000
     e8a:	85 c0                	test   eax,eax
     e8c:	75 e8                	jne    e76 <launch_ap+0x19f>
		timeout = jiffies + HZ * ct / 1000;
     e8e:	a1 00 00 00 00       	mov    eax,ds:0x0
     e93:	8b 30                	mov    esi,DWORD PTR [eax]
     e95:	8b 78 04             	mov    edi,DWORD PTR [eax+0x4]
     e98:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     e9b:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     e9e:	89 c8                	mov    eax,ecx
     ea0:	89 da                	mov    edx,ebx
     ea2:	0f a4 c2 04          	shld   edx,eax,0x4
     ea6:	c1 e0 04             	shl    eax,0x4
     ea9:	29 c8                	sub    eax,ecx
     eab:	19 da                	sbb    edx,ebx
     ead:	0f a4 c2 03          	shld   edx,eax,0x3
     eb1:	c1 e0 03             	shl    eax,0x3
     eb4:	01 c8                	add    eax,ecx
     eb6:	11 da                	adc    edx,ebx
     eb8:	6a 00                	push   0x0
     eba:	68 e8 03 00 00       	push   0x3e8
     ebf:	52                   	push   edx
     ec0:	50                   	push   eax
     ec1:	e8 fc ff ff ff       	call   ec2 <launch_ap+0x1eb>
     ec6:	83 c4 10             	add    esp,0x10
     ec9:	01 f0                	add    eax,esi
     ecb:	11 fa                	adc    edx,edi
     ecd:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     ed0:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		apic_reg(APIC_REG_ESR) = 0;
     ed3:	e8 28 f1 ff ff       	call   0 <per_cpu_ptr>
     ed8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     edb:	05 80 02 00 00       	add    eax,0x280
     ee0:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		apic_reg(APIC_REG_ICRH) = id;
     ee6:	e8 15 f1 ff ff       	call   0 <per_cpu_ptr>
     eeb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     eee:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
     ef4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ef7:	89 02                	mov    DWORD PTR [edx],eax
		apic_reg(APIC_REG_ICRL) = 0x00004600 | 6; /* pseudo-vector 6 <-> 0x6000 */
     ef9:	e8 02 f1 ff ff       	call   0 <per_cpu_ptr>
     efe:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f01:	05 00 03 00 00       	add    eax,0x300
     f06:	c7 00 06 46 00 00    	mov    DWORD PTR [eax],0x4606
		while (!ap_start)
     f0c:	eb 18                	jmp    f26 <launch_ap+0x24f>
				if (time_after(jiffies, timeout))
     f0e:	a1 00 00 00 00       	mov    eax,ds:0x0
     f13:	8b 08                	mov    ecx,DWORD PTR [eax]
     f15:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     f18:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f1b:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     f1e:	29 c8                	sub    eax,ecx
     f20:	19 da                	sbb    edx,ebx
     f22:	85 d2                	test   edx,edx
     f24:	78 0d                	js     f33 <launch_ap+0x25c>
		while (!ap_start)
     f26:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     f2d:	84 c0                	test   al,al
     f2f:	74 dd                	je     f0e <launch_ap+0x237>
     f31:	eb 01                	jmp    f34 <launch_ap+0x25d>
						break;
     f33:	90                   	nop
		if (!ap_start && ct < 1000) {
     f34:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     f3b:	84 c0                	test   al,al
     f3d:	75 36                	jne    f75 <launch_ap+0x29e>
     f3f:	ba e7 03 00 00       	mov    edx,0x3e7
     f44:	b8 00 00 00 00       	mov    eax,0x0
     f49:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
     f4c:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
     f4f:	72 24                	jb     f75 <launch_ap+0x29e>
				ct *= 10; /* 1000ms */
     f51:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     f54:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     f57:	89 c8                	mov    eax,ecx
     f59:	89 da                	mov    edx,ebx
     f5b:	0f a4 c2 02          	shld   edx,eax,0x2
     f5f:	c1 e0 02             	shl    eax,0x2
     f62:	01 c8                	add    eax,ecx
     f64:	11 da                	adc    edx,ebx
     f66:	01 c0                	add    eax,eax
     f68:	11 d2                	adc    edx,edx
     f6a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     f6d:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				goto resend;
     f70:	e9 19 ff ff ff       	jmp    e8e <launch_ap+0x1b7>
		if (!ap_start)
     f75:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     f7c:	84 c0                	test   al,al
     f7e:	74 57                	je     fd7 <launch_ap+0x300>
		while (ap_start); /* trampoline is in use */
     f80:	90                   	nop
     f81:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     f88:	84 c0                	test   al,al
     f8a:	75 f5                	jne    f81 <launch_ap+0x2aa>
		if (ap_fail)
     f8c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     f93:	84 c0                	test   al,al
     f95:	75 43                	jne    fda <launch_ap+0x303>
		pcp_ofs++;
     f97:	a1 00 00 00 00       	mov    eax,ds:0x0
     f9c:	83 c0 01             	add    eax,0x1
     f9f:	a3 00 00 00 00       	mov    ds:0x0,eax
		bp_apic_base = pd->apic_addr; /* decrement next allocation base */
     fa4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     fa7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     faa:	a3 00 00 00 00       	mov    ds:0x0,eax
		preempt_enable();
     faf:	e8 fc ff ff ff       	call   fb0 <launch_ap+0x2d9>
     fb4:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     fb7:	83 ea 01             	sub    edx,0x1
     fba:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
     fbd:	e8 fc ff ff ff       	call   fbe <launch_ap+0x2e7>
     fc2:	8b 00                	mov    eax,DWORD PTR [eax]
     fc4:	83 e0 01             	and    eax,0x1
     fc7:	85 c0                	test   eax,eax
     fc9:	74 05                	je     fd0 <launch_ap+0x2f9>
     fcb:	e8 fc ff ff ff       	call   fcc <launch_ap+0x2f5>
		return 0;
     fd0:	b8 00 00 00 00       	mov    eax,0x0
     fd5:	eb 49                	jmp    1020 <launch_ap+0x349>
				goto failure;
     fd7:	90                   	nop
     fd8:	eb 01                	jmp    fdb <launch_ap+0x304>
				goto failure;
     fda:	90                   	nop
		kfree(ap_gdtp);
     fdb:	a1 00 00 00 00       	mov    eax,ds:0x0
     fe0:	83 ec 0c             	sub    esp,0xc
     fe3:	50                   	push   eax
     fe4:	e8 fc ff ff ff       	call   fe5 <launch_ap+0x30e>
     fe9:	83 c4 10             	add    esp,0x10
		kfree(pd);
     fec:	83 ec 0c             	sub    esp,0xc
     fef:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
     ff2:	e8 fc ff ff ff       	call   ff3 <launch_ap+0x31c>
     ff7:	83 c4 10             	add    esp,0x10
		preempt_enable();
     ffa:	e8 fc ff ff ff       	call   ffb <launch_ap+0x324>
     fff:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    1002:	83 ea 01             	sub    edx,0x1
    1005:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    1008:	e8 fc ff ff ff       	call   1009 <launch_ap+0x332>
    100d:	8b 00                	mov    eax,DWORD PTR [eax]
    100f:	83 e0 01             	and    eax,0x1
    1012:	85 c0                	test   eax,eax
    1014:	74 05                	je     101b <launch_ap+0x344>
    1016:	e8 fc ff ff ff       	call   1017 <launch_ap+0x340>
		return -1;
    101b:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    1020:	8d 65 f4             	lea    esp,[ebp-0xc]
    1023:	5b                   	pop    ebx
    1024:	5e                   	pop    esi
    1025:	5f                   	pop    edi
    1026:	5d                   	pop    ebp
    1027:	c3                   	ret

00001028 <imcr_pic_to_apic>:
{
    1028:	55                   	push   ebp
    1029:	89 e5                	mov    ebp,esp
		outb(0x70, 0x22);
    102b:	6a 22                	push   0x22
    102d:	6a 70                	push   0x70
    102f:	e8 e0 ef ff ff       	call   14 <outb>
    1034:	83 c4 08             	add    esp,0x8
		outb(0x01, 0x23);
    1037:	6a 23                	push   0x23
    1039:	6a 01                	push   0x1
    103b:	e8 d4 ef ff ff       	call   14 <outb>
    1040:	83 c4 08             	add    esp,0x8
}
    1043:	90                   	nop
    1044:	c9                   	leave
    1045:	c3                   	ret

00001046 <imcr_apic_to_pic>:
{
    1046:	55                   	push   ebp
    1047:	89 e5                	mov    ebp,esp
		outb(0x70, 0x22);
    1049:	6a 22                	push   0x22
    104b:	6a 70                	push   0x70
    104d:	e8 c2 ef ff ff       	call   14 <outb>
    1052:	83 c4 08             	add    esp,0x8
		outb(0x00, 0x23);
    1055:	6a 23                	push   0x23
    1057:	6a 00                	push   0x0
    1059:	e8 b6 ef ff ff       	call   14 <outb>
    105e:	83 c4 08             	add    esp,0x8
}
    1061:	90                   	nop
    1062:	c9                   	leave
    1063:	c3                   	ret

00001064 <ioapic_init>:
{
    1064:	55                   	push   ebp
    1065:	89 e5                	mov    ebp,esp
    1067:	83 ec 18             	sub    esp,0x18
		struct io_apic* io = io_apics;
    106a:	a1 00 00 00 00       	mov    eax,ds:0x0
    106f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (imcr)
    1072:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1076:	74 2c                	je     10a4 <ioapic_init+0x40>
				imcr_pic_to_apic();
    1078:	e8 fc ff ff ff       	call   1079 <ioapic_init+0x15>
		while (io) {
    107d:	eb 25                	jmp    10a4 <ioapic_init+0x40>
				init_ioapic(io->id, io->addr);
    107f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1082:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1085:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1088:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    108b:	0f b6 c0             	movzx  eax,al
    108e:	83 ec 08             	sub    esp,0x8
    1091:	52                   	push   edx
    1092:	50                   	push   eax
    1093:	e8 fc ff ff ff       	call   1094 <ioapic_init+0x30>
    1098:	83 c4 10             	add    esp,0x10
				io = io->next;
    109b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    109e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    10a1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (io) {
    10a4:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    10a8:	75 d5                	jne    107f <ioapic_init+0x1b>
}
    10aa:	90                   	nop
    10ab:	90                   	nop
    10ac:	c9                   	leave
    10ad:	c3                   	ret

000010ae <mp_init>:
{
    10ae:	55                   	push   ebp
    10af:	89 e5                	mov    ebp,esp
    10b1:	83 ec 18             	sub    esp,0x18
		struct apid* id = apic_ids.ap_ids;
    10b4:	a1 04 00 00 00       	mov    eax,ds:0x4
    10b9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		pcp_init();
    10bc:	e8 fc ff ff ff       	call   10bd <mp_init+0xf>
		while (id) {
    10c1:	eb 73                	jmp    1136 <mp_init+0x88>
				printf("attempting to start AP %x\n", id->ap_id);
    10c3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10c6:	8b 00                	mov    eax,DWORD PTR [eax]
    10c8:	83 ec 08             	sub    esp,0x8
    10cb:	50                   	push   eax
    10cc:	68 0a 04 00 00       	push   0x40a
    10d1:	e8 fc ff ff ff       	call   10d2 <mp_init+0x24>
    10d6:	83 c4 10             	add    esp,0x10
				if (launch_ap(id->ap_id) == 0) {
    10d9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10dc:	8b 00                	mov    eax,DWORD PTR [eax]
    10de:	83 ec 0c             	sub    esp,0xc
    10e1:	50                   	push   eax
    10e2:	e8 fc ff ff ff       	call   10e3 <mp_init+0x35>
    10e7:	83 c4 10             	add    esp,0x10
    10ea:	85 c0                	test   eax,eax
    10ec:	75 27                	jne    1115 <mp_init+0x67>
						cprintf(KFMT_OK, "started AP %08x successfully\n", id->ap_id);
    10ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10f1:	8b 00                	mov    eax,DWORD PTR [eax]
    10f3:	83 ec 04             	sub    esp,0x4
    10f6:	50                   	push   eax
    10f7:	68 25 04 00 00       	push   0x425
    10fc:	6a 0a                	push   0xa
    10fe:	e8 fc ff ff ff       	call   10ff <mp_init+0x51>
    1103:	83 c4 10             	add    esp,0x10
						nproc++;
    1106:	a1 00 00 00 00       	mov    eax,ds:0x0
    110b:	83 c0 01             	add    eax,0x1
    110e:	a3 00 00 00 00       	mov    ds:0x0,eax
    1113:	eb 18                	jmp    112d <mp_init+0x7f>
						cprintf(KFMT_WARN, "AP %08x refused to start\n", id->ap_id);
    1115:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1118:	8b 00                	mov    eax,DWORD PTR [eax]
    111a:	83 ec 04             	sub    esp,0x4
    111d:	50                   	push   eax
    111e:	68 43 04 00 00       	push   0x443
    1123:	6a 0e                	push   0xe
    1125:	e8 fc ff ff ff       	call   1126 <mp_init+0x78>
    112a:	83 c4 10             	add    esp,0x10
				id = id->next;
    112d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1130:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1133:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (id) {
    1136:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    113a:	75 87                	jne    10c3 <mp_init+0x15>
		ioapic_init(imcr);
    113c:	83 ec 0c             	sub    esp,0xc
    113f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1142:	e8 fc ff ff ff       	call   1143 <mp_init+0x95>
    1147:	83 c4 10             	add    esp,0x10
		return (nproc > 1) ? 0 : -1;
    114a:	a1 00 00 00 00       	mov    eax,ds:0x0
    114f:	83 f8 01             	cmp    eax,0x1
    1152:	76 07                	jbe    115b <mp_init+0xad>
    1154:	b8 00 00 00 00       	mov    eax,0x0
    1159:	eb 05                	jmp    1160 <mp_init+0xb2>
    115b:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    1160:	c9                   	leave
    1161:	c3                   	ret

00001162 <mp_entry>:
{
    1162:	55                   	push   ebp
    1163:	89 e5                	mov    ebp,esp
    1165:	83 ec 18             	sub    esp,0x18
		struct mp_fps* fps = find_mp_fps();
    1168:	e8 fc ff ff ff       	call   1169 <mp_entry+0x7>
    116d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (fps) {
    1170:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1174:	0f 84 1d 01 00 00    	je     1297 <mp_entry+0x135>
				printf("This machine conforms to the MP specification version 1.%u\n", (uint32_t)fps->spec_rev);
    117a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    117d:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    1181:	0f b6 c0             	movzx  eax,al
    1184:	83 ec 08             	sub    esp,0x8
    1187:	50                   	push   eax
    1188:	68 60 04 00 00       	push   0x460
    118d:	e8 fc ff ff ff       	call   118e <mp_entry+0x2c>
    1192:	83 c4 10             	add    esp,0x10
				if (!fps->features[0]) { /* table present */
    1195:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1198:	0f b6 40 0b          	movzx  eax,BYTE PTR [eax+0xb]
    119c:	84 c0                	test   al,al
    119e:	75 1e                	jne    11be <mp_entry+0x5c>
						printf("It has a MP configuration table at %p\n", ptr = mp2ptr(fps->mp_config));
    11a0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11a3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    11a6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    11a9:	83 ec 08             	sub    esp,0x8
    11ac:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    11af:	68 9c 04 00 00       	push   0x49c
    11b4:	e8 fc ff ff ff       	call   11b5 <mp_entry+0x53>
    11b9:	83 c4 10             	add    esp,0x10
    11bc:	eb 6e                	jmp    122c <mp_entry+0xca>
								"Therefore there is no MP configuration table expected. (%p)\n", ptr = mp2ptr(fps->mp_config));
    11be:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11c1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
						printf("It uses a default MP configuration defined by feature bits. "
    11c4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    11c7:	83 ec 08             	sub    esp,0x8
    11ca:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    11cd:	68 c4 04 00 00       	push   0x4c4
    11d2:	e8 fc ff ff ff       	call   11d3 <mp_entry+0x71>
    11d7:	83 c4 10             	add    esp,0x10
						printf("The default configuration has ID %u\n", fps->features[0]);
    11da:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11dd:	0f b6 40 0b          	movzx  eax,BYTE PTR [eax+0xb]
    11e1:	0f b6 c0             	movzx  eax,al
    11e4:	83 ec 08             	sub    esp,0x8
    11e7:	50                   	push   eax
    11e8:	68 40 05 00 00       	push   0x540
    11ed:	e8 fc ff ff ff       	call   11ee <mp_entry+0x8c>
    11f2:	83 c4 10             	add    esp,0x10
						if (!ptr)
    11f5:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    11f9:	75 19                	jne    1214 <mp_entry+0xb2>
								ptr = build_configuration_table_from_default(fps->features[0]);
    11fb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11fe:	0f b6 40 0b          	movzx  eax,BYTE PTR [eax+0xb]
    1202:	0f b6 c0             	movzx  eax,al
    1205:	83 ec 0c             	sub    esp,0xc
    1208:	50                   	push   eax
    1209:	e8 fc ff ff ff       	call   120a <mp_entry+0xa8>
    120e:	83 c4 10             	add    esp,0x10
    1211:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!ptr) {
    1214:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1218:	75 12                	jne    122c <mp_entry+0xca>
								printf("and is unrecognized, resulting in UP init.\n");
    121a:	83 ec 0c             	sub    esp,0xc
    121d:	68 68 05 00 00       	push   0x568
    1222:	e8 fc ff ff ff       	call   1223 <mp_entry+0xc1>
    1227:	83 c4 10             	add    esp,0x10
								return;
    122a:	eb 7b                	jmp    12a7 <mp_entry+0x145>
				mp_parse_config_table(ptr);
    122c:	83 ec 0c             	sub    esp,0xc
    122f:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1232:	e8 fc ff ff ff       	call   1233 <mp_entry+0xd1>
    1237:	83 c4 10             	add    esp,0x10
				cprintf(KFMT_INFO, "attempting MP init...\n");
    123a:	83 ec 08             	sub    esp,0x8
    123d:	68 94 05 00 00       	push   0x594
    1242:	6a 0b                	push   0xb
    1244:	e8 fc ff ff ff       	call   1245 <mp_entry+0xe3>
    1249:	83 c4 10             	add    esp,0x10
				if (mp_init(!!(fps->features[1] & 0x80)))
    124c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    124f:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1253:	c0 e8 07             	shr    al,0x7
    1256:	0f b6 c0             	movzx  eax,al
    1259:	83 ec 0c             	sub    esp,0xc
    125c:	50                   	push   eax
    125d:	e8 fc ff ff ff       	call   125e <mp_entry+0xfc>
    1262:	83 c4 10             	add    esp,0x10
    1265:	85 c0                	test   eax,eax
    1267:	74 14                	je     127d <mp_entry+0x11b>
						cprintf(KFMT_WARN, "MP init failed continuing with UP.\n");
    1269:	83 ec 08             	sub    esp,0x8
    126c:	68 ac 05 00 00       	push   0x5ac
    1271:	6a 0e                	push   0xe
    1273:	e8 fc ff ff ff       	call   1274 <mp_entry+0x112>
    1278:	83 c4 10             	add    esp,0x10
    127b:	eb 2a                	jmp    12a7 <mp_entry+0x145>
						cprintf(KFMT_OK, "MP init successful, now there are %u processors active.\n", nproc);
    127d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1282:	83 ec 04             	sub    esp,0x4
    1285:	50                   	push   eax
    1286:	68 d0 05 00 00       	push   0x5d0
    128b:	6a 0a                	push   0xa
    128d:	e8 fc ff ff ff       	call   128e <mp_entry+0x12c>
    1292:	83 c4 10             	add    esp,0x10
    1295:	eb 10                	jmp    12a7 <mp_entry+0x145>
				printf("This machine does not conform to the MP specification but "
    1297:	83 ec 0c             	sub    esp,0xc
    129a:	68 0c 06 00 00       	push   0x60c
    129f:	e8 fc ff ff ff       	call   12a0 <mp_entry+0x13e>
    12a4:	83 c4 10             	add    esp,0x10
}
    12a7:	c9                   	leave
    12a8:	c3                   	ret
