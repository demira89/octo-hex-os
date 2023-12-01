
smp.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
				return rv;
		rv = search_mp_fps((void*)0x9fc00, 1024);
		if (rv)
				return rv;

		/* BIOS ROM */
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
		return rv;
}
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax

void* build_configuration_table_from_default(uint8_t tp)
{
		return NULL + tp - tp;
      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
      19:	c9                   	leave
      1a:	c3                   	ret

000000000000001b <outb>:
		const char* el[4] = { "Bus", "edge", "res", "level" };
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
				l->dest_lapic_id, l->dest_lapic_linp,
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
      1b:	55                   	push   rbp
      1c:	48 89 e5             	mov    rbp,rsp
      1f:	48 83 ec 08          	sub    rsp,0x8
      23:	89 fa                	mov    edx,edi
      25:	89 f0                	mov    eax,esi
      27:	66 89 55 fc          	mov    WORD PTR [rbp-0x4],dx
      2b:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
		/* TODO: for now do nothing with this info */
      2e:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
      32:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
      36:	ee                   	out    dx,al
}
      37:	90                   	nop
      38:	c9                   	leave
      39:	c3                   	ret

000000000000003a <memcpy>:
						pt = &ps->next;
		} while ((ps = *pt));
}

void mp_parse_config_table(void* ptr)
{
      3a:	55                   	push   rbp
      3b:	48 89 e5             	mov    rbp,rsp
      3e:	48 83 ec 28          	sub    rsp,0x28
      42:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
      46:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      4a:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		/* first map the table to VM */
      4e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      52:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
      56:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      5a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
      5e:	eb 1d                	jmp    7d <memcpy+0x43>
		uint16_t ec; void* e;
      60:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      64:	48 8d 42 01          	lea    rax,[rdx+0x1]
      68:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      6c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      70:	48 8d 48 01          	lea    rcx,[rax+0x1]
      74:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      78:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      7b:	88 10                	mov    BYTE PTR [rax],dl
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
      7d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      81:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      85:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      89:	48 85 c0             	test   rax,rax
      8c:	75 d2                	jne    60 <memcpy+0x26>

      8e:	90                   	nop
      8f:	90                   	nop
      90:	c9                   	leave
      91:	c3                   	ret

0000000000000092 <checksum_memory>:
      92:	55                   	push   rbp
      93:	48 89 e5             	mov    rbp,rsp
      96:	48 83 ec 20          	sub    rsp,0x20
      9a:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
      9e:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      a2:	c6 45 ff 00          	mov    BYTE PTR [rbp-0x1],0x0
      a6:	eb 12                	jmp    ba <checksum_memory+0x28>
      a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      ac:	48 8d 50 01          	lea    rdx,[rax+0x1]
      b0:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
      b4:	0f b6 00             	movzx  eax,BYTE PTR [rax]
      b7:	00 45 ff             	add    BYTE PTR [rbp-0x1],al
      ba:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      be:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      c2:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
      c6:	48 85 c0             	test   rax,rax
      c9:	75 dd                	jne    a8 <checksum_memory+0x16>
      cb:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
      cf:	c9                   	leave
      d0:	c3                   	ret

00000000000000d1 <search_mp_fps>:
{
      d1:	55                   	push   rbp
      d2:	48 89 e5             	mov    rbp,rsp
      d5:	48 83 ec 20          	sub    rsp,0x20
      d9:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
      dd:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		while (ct >= 16) {
      e1:	eb 49                	jmp    12c <search_mp_fps+0x5b>
				if (*(uint32_t*)mem == 0x5f504d5f) {
      e3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      e7:	8b 00                	mov    eax,DWORD PTR [rax]
      e9:	3d 5f 4d 50 5f       	cmp    eax,0x5f504d5f
      ee:	75 32                	jne    122 <search_mp_fps+0x51>
						struct mp_fps* fps = mem;
      f0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      f4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						if (checksum_memory(mem, 16 * fps->length) == 0)
      f8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      fc:	0f b6 40 08          	movzx  eax,BYTE PTR [rax+0x8]
     100:	0f b6 c0             	movzx  eax,al
     103:	c1 e0 04             	shl    eax,0x4
     106:	48 63 d0             	movsxd rdx,eax
     109:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     10d:	48 89 d6             	mov    rsi,rdx
     110:	48 89 c7             	mov    rdi,rax
     113:	e8 7a ff ff ff       	call   92 <checksum_memory>
     118:	84 c0                	test   al,al
     11a:	75 06                	jne    122 <search_mp_fps+0x51>
								return mem;
     11c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     120:	eb 16                	jmp    138 <search_mp_fps+0x67>
				mem += 16;
     122:	48 83 45 e8 10       	add    QWORD PTR [rbp-0x18],0x10
				ct -= 16;
     127:	48 83 6d e0 10       	sub    QWORD PTR [rbp-0x20],0x10
		while (ct >= 16) {
     12c:	48 83 7d e0 0f       	cmp    QWORD PTR [rbp-0x20],0xf
     131:	77 b0                	ja     e3 <search_mp_fps+0x12>
		return NULL;
     133:	b8 00 00 00 00       	mov    eax,0x0
}
     138:	c9                   	leave
     139:	c3                   	ret

000000000000013a <find_mp_fps>:
{
     13a:	55                   	push   rbp
     13b:	48 89 e5             	mov    rbp,rsp
     13e:	48 83 ec 10          	sub    rsp,0x10
		rv = (void*)((size_t)*(uint16_t*)0x040e << 16);
     142:	b8 0e 04 00 00       	mov    eax,0x40e
     147:	0f b7 00             	movzx  eax,WORD PTR [rax]
     14a:	0f b7 c0             	movzx  eax,ax
     14d:	48 c1 e0 10          	shl    rax,0x10
     151:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if ((size_t)rv < 0x000a0000 && (0x000a0000 - (size_t)rv) <= 128 * 1024) {
     155:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     159:	48 3d ff ff 09 00    	cmp    rax,0x9ffff
     15f:	77 37                	ja     198 <find_mp_fps+0x5e>
     161:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     165:	ba 00 00 0a 00       	mov    edx,0xa0000
     16a:	48 29 c2             	sub    rdx,rax
     16d:	48 81 fa 00 00 02 00 	cmp    rdx,0x20000
     174:	77 22                	ja     198 <find_mp_fps+0x5e>
				rv = search_mp_fps(rv, 1024);
     176:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     17a:	be 00 04 00 00       	mov    esi,0x400
     17f:	48 89 c7             	mov    rdi,rax
     182:	e8 00 00 00 00       	call   187 <find_mp_fps+0x4d>
     187:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (rv)
     18b:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     190:	74 06                	je     198 <find_mp_fps+0x5e>
						return rv;
     192:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     196:	eb 57                	jmp    1ef <find_mp_fps+0xb5>
		rv = search_mp_fps((void*)0x7fc00, 1024);
     198:	be 00 04 00 00       	mov    esi,0x400
     19d:	bf 00 fc 07 00       	mov    edi,0x7fc00
     1a2:	e8 00 00 00 00       	call   1a7 <find_mp_fps+0x6d>
     1a7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (rv)
     1ab:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     1b0:	74 06                	je     1b8 <find_mp_fps+0x7e>
				return rv;
     1b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1b6:	eb 37                	jmp    1ef <find_mp_fps+0xb5>
		rv = search_mp_fps((void*)0x9fc00, 1024);
     1b8:	be 00 04 00 00       	mov    esi,0x400
     1bd:	bf 00 fc 09 00       	mov    edi,0x9fc00
     1c2:	e8 00 00 00 00       	call   1c7 <find_mp_fps+0x8d>
     1c7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (rv)
     1cb:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     1d0:	74 06                	je     1d8 <find_mp_fps+0x9e>
				return rv;
     1d2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1d6:	eb 17                	jmp    1ef <find_mp_fps+0xb5>
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
     1d8:	be 00 00 01 00       	mov    esi,0x10000
     1dd:	bf 00 00 0f 00       	mov    edi,0xf0000
     1e2:	e8 00 00 00 00       	call   1e7 <find_mp_fps+0xad>
     1e7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		return rv;
     1eb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
     1ef:	c9                   	leave
     1f0:	c3                   	ret

00000000000001f1 <build_configuration_table_from_default>:
{
     1f1:	55                   	push   rbp
     1f2:	48 89 e5             	mov    rbp,rsp
     1f5:	48 83 ec 08          	sub    rsp,0x8
     1f9:	89 f8                	mov    eax,edi
     1fb:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		return NULL + tp - tp;
     1fe:	b8 00 00 00 00       	mov    eax,0x0
}
     203:	c9                   	leave
     204:	c3                   	ret

0000000000000205 <parse_processor_entry>:
{
     205:	55                   	push   rbp
     206:	48 89 e5             	mov    rbp,rsp
     209:	48 83 ec 20          	sub    rsp,0x20
     20d:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		if (!hdr++) {
     211:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 217 <parse_processor_entry+0x12>
     217:	8d 50 01             	lea    edx,[rax+0x1]
     21a:	89 15 00 00 00 00    	mov    DWORD PTR [rip+0x0],edx        # 220 <parse_processor_entry+0x1b>
     220:	85 c0                	test   eax,eax
     222:	75 22                	jne    246 <parse_processor_entry+0x41>
				printf("Processors from MP list:\n");
     224:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     22b:	b8 00 00 00 00       	mov    eax,0x0
     230:	e8 00 00 00 00       	call   235 <parse_processor_entry+0x30>
				printf("TYPE  STATUS    APIC ID  SIGNATURE  FLAGS\n");
     235:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     23c:	b8 00 00 00 00       	mov    eax,0x0
     241:	e8 00 00 00 00       	call   246 <parse_processor_entry+0x41>
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     246:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     24a:	8b 70 08             	mov    esi,DWORD PTR [rax+0x8]
     24d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     251:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
				p->lapic_id, p->cpu_signature, p->cpu_features);
     254:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     258:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     25c:	0f b6 c0             	movzx  eax,al
				(p->cpu_flags & 1) ? "enabled" : "disabled",
     25f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     263:	0f b6 52 03          	movzx  edx,BYTE PTR [rdx+0x3]
     267:	0f b6 d2             	movzx  edx,dl
     26a:	83 e2 01             	and    edx,0x1
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     26d:	85 d2                	test   edx,edx
     26f:	74 09                	je     27a <parse_processor_entry+0x75>
     271:	49 c7 c2 00 00 00 00 	mov    r10,0x0
     278:	eb 07                	jmp    281 <parse_processor_entry+0x7c>
     27a:	49 c7 c2 00 00 00 00 	mov    r10,0x0
				(p->cpu_flags & 2) ? "BP" : "AP",
     281:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     285:	0f b6 52 03          	movzx  edx,BYTE PTR [rdx+0x3]
     289:	0f b6 d2             	movzx  edx,dl
     28c:	83 e2 02             	and    edx,0x2
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     28f:	85 d2                	test   edx,edx
     291:	74 09                	je     29c <parse_processor_entry+0x97>
     293:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     29a:	eb 07                	jmp    2a3 <parse_processor_entry+0x9e>
     29c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2a3:	41 89 f1             	mov    r9d,esi
     2a6:	41 89 c8             	mov    r8d,ecx
     2a9:	89 c1                	mov    ecx,eax
     2ab:	4c 89 d2             	mov    rdx,r10
     2ae:	48 89 fe             	mov    rsi,rdi
     2b1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2b8:	b8 00 00 00 00       	mov    eax,0x0
     2bd:	e8 00 00 00 00       	call   2c2 <parse_processor_entry+0xbd>
		if (!(p->cpu_flags & 1))
     2c2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     2c6:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
     2ca:	0f b6 c0             	movzx  eax,al
     2cd:	83 e0 01             	and    eax,0x1
     2d0:	85 c0                	test   eax,eax
     2d2:	0f 84 cd 00 00 00    	je     3a5 <parse_processor_entry+0x1a0>
		else if (p->cpu_flags & 2) { /* BP */
     2d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     2dc:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
     2e0:	0f b6 c0             	movzx  eax,al
     2e3:	83 e0 02             	and    eax,0x2
     2e6:	85 c0                	test   eax,eax
     2e8:	74 28                	je     312 <parse_processor_entry+0x10d>
				apic_ids.bp_id = (uint32_t)p->lapic_id << 24;
     2ea:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     2ee:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
     2f2:	0f b6 c0             	movzx  eax,al
     2f5:	c1 e0 18             	shl    eax,0x18
     2f8:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2fe <parse_processor_entry+0xf9>
				if (cpu.has_htt)
     2fe:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 305 <parse_processor_entry+0x100>
     305:	83 e0 10             	and    eax,0x10
     308:	84 c0                	test   al,al
     30a:	0f 84 96 00 00 00    	je     3a6 <parse_processor_entry+0x1a1>
						goto htt_proc;
     310:	eb 4d                	jmp    35f <parse_processor_entry+0x15a>
				struct apid* pi = kmalloc(sizeof(struct apid));
     312:	bf 10 00 00 00       	mov    edi,0x10
     317:	e8 00 00 00 00       	call   31c <parse_processor_entry+0x117>
     31c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				pi->ap_id = (uint32_t)p->lapic_id << 24;
     320:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     324:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
     328:	0f b6 c0             	movzx  eax,al
     32b:	c1 e0 18             	shl    eax,0x18
     32e:	89 c2                	mov    edx,eax
     330:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     334:	89 10                	mov    DWORD PTR [rax],edx
				pi->next = apic_ids.ap_ids;
     336:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 33d <parse_processor_entry+0x138>
     33d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     341:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				apic_ids.ap_ids = pi;
     345:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     349:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 350 <parse_processor_entry+0x14b>
				if (cpu.has_htt) {
     350:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 357 <parse_processor_entry+0x152>
     357:	83 e0 10             	and    eax,0x10
     35a:	84 c0                	test   al,al
     35c:	74 48                	je     3a6 <parse_processor_entry+0x1a1>
htt_proc: /* mark as speculative */
     35e:	90                   	nop
						pi = kmalloc(sizeof(struct apid));
     35f:	bf 10 00 00 00       	mov    edi,0x10
     364:	e8 00 00 00 00       	call   369 <parse_processor_entry+0x164>
     369:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						pi->ap_id = ((uint32_t)p->lapic_id + 1) << 24 | 1;
     36d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     371:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
     375:	0f b6 c0             	movzx  eax,al
     378:	83 c0 01             	add    eax,0x1
     37b:	c1 e0 18             	shl    eax,0x18
     37e:	83 c8 01             	or     eax,0x1
     381:	89 c2                	mov    edx,eax
     383:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     387:	89 10                	mov    DWORD PTR [rax],edx
						pi->next = apic_ids.ap_ids;
     389:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 390 <parse_processor_entry+0x18b>
     390:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     394:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
						apic_ids.ap_ids = pi;
     398:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     39c:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3a3 <parse_processor_entry+0x19e>
     3a3:	eb 01                	jmp    3a6 <parse_processor_entry+0x1a1>
				return; /* disabled any */
     3a5:	90                   	nop
}
     3a6:	c9                   	leave
     3a7:	c3                   	ret

00000000000003a8 <parse_bus_entry>:
{
     3a8:	55                   	push   rbp
     3a9:	48 89 e5             	mov    rbp,rsp
     3ac:	48 83 ec 20          	sub    rsp,0x20
     3b0:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		printf("Bus with id %u is %.6s\n", b->bus_id, b->bus_type);
     3b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3b8:	48 8d 50 02          	lea    rdx,[rax+0x2]
     3bc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3c0:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
     3c4:	0f b6 c0             	movzx  eax,al
     3c7:	89 c6                	mov    esi,eax
     3c9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     3d0:	b8 00 00 00 00       	mov    eax,0x0
     3d5:	e8 00 00 00 00       	call   3da <parse_bus_entry+0x32>
		id = kmalloc(sizeof(struct busid));
     3da:	bf 10 00 00 00       	mov    edi,0x10
     3df:	e8 00 00 00 00       	call   3e4 <parse_bus_entry+0x3c>
     3e4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		id->id = b->bus_id;
     3e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3ec:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     3f0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     3f4:	88 10                	mov    BYTE PTR [rax],dl
		id->next = bus_ids;
     3f6:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 3fd <parse_bus_entry+0x55>
     3fd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     401:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		if (strncmp(b->bus_type, "ISA   ", 6) == 0)
     405:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     409:	48 83 c0 02          	add    rax,0x2
     40d:	ba 06 00 00 00       	mov    edx,0x6
     412:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     419:	48 89 c7             	mov    rdi,rax
     41c:	e8 00 00 00 00       	call   421 <parse_bus_entry+0x79>
     421:	85 c0                	test   eax,eax
     423:	75 0a                	jne    42f <parse_bus_entry+0x87>
				id->type = BT_ISA;
     425:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     429:	c6 40 01 00          	mov    BYTE PTR [rax+0x1],0x0
     42d:	eb 72                	jmp    4a1 <parse_bus_entry+0xf9>
		else if (strncmp(b->bus_type, "EISA  ", 6) == 0)
     42f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     433:	48 83 c0 02          	add    rax,0x2
     437:	ba 06 00 00 00       	mov    edx,0x6
     43c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     443:	48 89 c7             	mov    rdi,rax
     446:	e8 00 00 00 00       	call   44b <parse_bus_entry+0xa3>
     44b:	85 c0                	test   eax,eax
     44d:	75 0a                	jne    459 <parse_bus_entry+0xb1>
				id->type = BT_EISA;
     44f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     453:	c6 40 01 01          	mov    BYTE PTR [rax+0x1],0x1
     457:	eb 48                	jmp    4a1 <parse_bus_entry+0xf9>
		else if (strncmp(b->bus_type, "PCI   ", 6) == 0)
     459:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     45d:	48 83 c0 02          	add    rax,0x2
     461:	ba 06 00 00 00       	mov    edx,0x6
     466:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     46d:	48 89 c7             	mov    rdi,rax
     470:	e8 00 00 00 00       	call   475 <parse_bus_entry+0xcd>
     475:	85 c0                	test   eax,eax
     477:	75 0a                	jne    483 <parse_bus_entry+0xdb>
				id->type = BT_PCI;
     479:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     47d:	c6 40 01 02          	mov    BYTE PTR [rax+0x1],0x2
     481:	eb 1e                	jmp    4a1 <parse_bus_entry+0xf9>
				cprintf(KFMT_WARN, "bus type is unrecognized and will be ignored.\n");
     483:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     48a:	bf 0e 00 00 00       	mov    edi,0xe
     48f:	b8 00 00 00 00       	mov    eax,0x0
     494:	e8 00 00 00 00       	call   499 <parse_bus_entry+0xf1>
				id->type = BT_UNKNOWN;
     499:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     49d:	c6 40 01 ff          	mov    BYTE PTR [rax+0x1],0xff
		bus_ids = id;
     4a1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4a5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 4ac <parse_bus_entry+0x104>
}
     4ac:	90                   	nop
     4ad:	c9                   	leave
     4ae:	c3                   	ret

00000000000004af <parse_io_apic>:
{
     4af:	55                   	push   rbp
     4b0:	48 89 e5             	mov    rbp,rsp
     4b3:	48 83 ec 20          	sub    rsp,0x20
     4b7:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
						(i->flags & 1) ? "enabled" : "disabled");
     4bb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4bf:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
     4c3:	0f b6 c0             	movzx  eax,al
     4c6:	83 e0 01             	and    eax,0x1
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     4c9:	85 c0                	test   eax,eax
     4cb:	74 09                	je     4d6 <parse_io_apic+0x27>
     4cd:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     4d4:	eb 07                	jmp    4dd <parse_io_apic+0x2e>
     4d6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
						i->ver, i->id, mp2ptr(i->addr),
     4dd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4e1:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     4e4:	89 c0                	mov    eax,eax
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     4e6:	48 89 c1             	mov    rcx,rax
						i->ver, i->id, mp2ptr(i->addr),
     4e9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4ed:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     4f1:	0f b6 d0             	movzx  edx,al
						i->ver, i->id, mp2ptr(i->addr),
     4f4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4f8:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     4fc:	0f b6 c0             	movzx  eax,al
     4ff:	49 89 f0             	mov    r8,rsi
     502:	89 c6                	mov    esi,eax
     504:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     50b:	b8 00 00 00 00       	mov    eax,0x0
     510:	e8 00 00 00 00       	call   515 <parse_io_apic+0x66>
		if ((i->flags & 1) == 0)
     515:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     519:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
     51d:	0f b6 c0             	movzx  eax,al
     520:	83 e0 01             	and    eax,0x1
     523:	85 c0                	test   eax,eax
     525:	74 4c                	je     573 <parse_io_apic+0xc4>
		io = kmalloc(sizeof(struct io_apic));
     527:	bf 18 00 00 00       	mov    edi,0x18
     52c:	e8 00 00 00 00       	call   531 <parse_io_apic+0x82>
     531:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		io->id = i->id;
     535:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     539:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     53d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     541:	88 10                	mov    BYTE PTR [rax],dl
		io->addr = mp2ptr(i->addr);
     543:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     547:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     54a:	89 c0                	mov    eax,eax
     54c:	48 89 c2             	mov    rdx,rax
     54f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     553:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		io->next = io_apics;
     557:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 55e <parse_io_apic+0xaf>
     55e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     562:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		io_apics = io;
     566:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     56a:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 571 <parse_io_apic+0xc2>
     571:	eb 01                	jmp    574 <parse_io_apic+0xc5>
				return;
     573:	90                   	nop
}
     574:	c9                   	leave
     575:	c3                   	ret

0000000000000576 <find_bus>:
{
     576:	55                   	push   rbp
     577:	48 89 e5             	mov    rbp,rsp
     57a:	48 83 ec 40          	sub    rsp,0x40
     57e:	89 f8                	mov    eax,edi
     580:	88 45 cc             	mov    BYTE PTR [rbp-0x34],al
		struct busid* bi = bus_ids;
     583:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 58a <find_bus+0x14>
     58a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		const char* bts[4] = { "ISA", "EISA", "PCI", "Unknown" };
     58e:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
     596:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
     59e:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     5a6:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		if (!bus_ids)
     5ae:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 5b5 <find_bus+0x3f>
     5b5:	48 85 c0             	test   rax,rax
     5b8:	75 09                	jne    5c3 <find_bus+0x4d>
				return "";
     5ba:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     5c1:	eb 44                	jmp    607 <find_bus+0x91>
				if (bi->id == id)
     5c3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     5c7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     5ca:	38 45 cc             	cmp    BYTE PTR [rbp-0x34],al
     5cd:	75 1e                	jne    5ed <find_bus+0x77>
						return bts[min(bi->type, 3)];
     5cf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     5d3:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
     5d7:	ba 03 00 00 00       	mov    edx,0x3
     5dc:	38 d0                	cmp    al,dl
     5de:	0f 47 c2             	cmova  eax,edx
     5e1:	0f b6 c0             	movzx  eax,al
     5e4:	48 98                	cdqe
     5e6:	48 8b 44 c5 d0       	mov    rax,QWORD PTR [rbp+rax*8-0x30]
     5eb:	eb 1a                	jmp    607 <find_bus+0x91>
		} while ((bi = bi->next));
     5ed:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     5f1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     5f5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     5f9:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     5fe:	75 c3                	jne    5c3 <find_bus+0x4d>
		return "";
     600:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     607:	c9                   	leave
     608:	c3                   	ret

0000000000000609 <parse_io_interrupt>:
{
     609:	55                   	push   rbp
     60a:	48 89 e5             	mov    rbp,rsp
     60d:	41 57                	push   r15
     60f:	41 56                	push   r14
     611:	41 55                	push   r13
     613:	41 54                	push   r12
     615:	53                   	push   rbx
     616:	48 81 ec 88 00 00 00 	sub    rsp,0x88
     61d:	48 89 bd 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdi
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
     624:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
     62c:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
     634:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
     63c:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
     644:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
     64c:	48 c7 45 80 00 00 00 00 	mov    QWORD PTR [rbp-0x80],0x0
     654:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
     65c:	48 c7 45 90 00 00 00 00 	mov    QWORD PTR [rbp-0x70],0x0
     664:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
		const char* el[4] = { "Bus", "edge", "res", "level" };
     66c:	48 c7 85 60 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xa0],0x0
     677:	48 c7 85 68 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0x98],0x0
     682:	48 c7 85 70 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0x90],0x0
     68d:	48 c7 85 78 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0x88],0x0
		if (!prt++) {
     698:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 69e <parse_io_interrupt+0x95>
     69e:	8d 50 01             	lea    edx,[rax+0x1]
     6a1:	89 15 00 00 00 00    	mov    DWORD PTR [rip+0x0],edx        # 6a7 <parse_io_interrupt+0x9e>
     6a7:	85 c0                	test   eax,eax
     6a9:	75 22                	jne    6cd <parse_io_interrupt+0xc4>
				printf("I/O interrupt assignments:\n");
     6ab:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     6b2:	b8 00 00 00 00       	mov    eax,0x0
     6b7:	e8 00 00 00 00       	call   6bc <parse_io_interrupt+0xb3>
				printf("TYPE     BUS (NAME)   IRQ  IOAPIC  INP#  POL    TRIG\n");
     6bc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     6c3:	b8 00 00 00 00       	mov    eax,0x0
     6c8:	e8 00 00 00 00       	call   6cd <parse_io_interrupt+0xc4>
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
     6cd:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     6d4:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     6d8:	66 c1 e8 02          	shr    ax,0x2
     6dc:	0f b7 c0             	movzx  eax,ax
     6df:	83 e0 03             	and    eax,0x3
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     6e2:	48 98                	cdqe
     6e4:	4c 8b ac c5 60 ff ff ff 	mov    r13,QWORD PTR [rbp+rax*8-0xa0]
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
     6ec:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     6f3:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     6f7:	0f b7 c0             	movzx  eax,ax
     6fa:	83 e0 03             	and    eax,0x3
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     6fd:	48 98                	cdqe
     6ff:	4c 8b 64 c5 80       	mov    r12,QWORD PTR [rbp+rax*8-0x80]
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     704:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     70b:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     70f:	0f b6 d8             	movzx  ebx,al
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     712:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     719:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     71d:	44 0f b6 f8          	movzx  r15d,al
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     721:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     728:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     72c:	44 0f b6 f0          	movzx  r14d,al
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     730:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     737:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     73b:	0f b6 c0             	movzx  eax,al
     73e:	89 c7                	mov    edi,eax
     740:	e8 00 00 00 00       	call   745 <parse_io_interrupt+0x13c>
     745:	48 89 c6             	mov    rsi,rax
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     748:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     74f:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     753:	0f b6 d0             	movzx  edx,al
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     756:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     75d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     760:	b9 04 00 00 00       	mov    ecx,0x4
     765:	38 c8                	cmp    al,cl
     767:	0f 42 c1             	cmovb  eax,ecx
     76a:	0f b6 c0             	movzx  eax,al
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     76d:	48 98                	cdqe
     76f:	48 8b 44 c5 a0       	mov    rax,QWORD PTR [rbp+rax*8-0x60]
     774:	48 83 ec 08          	sub    rsp,0x8
     778:	41 55                	push   r13
     77a:	41 54                	push   r12
     77c:	53                   	push   rbx
     77d:	45 89 f9             	mov    r9d,r15d
     780:	45 89 f0             	mov    r8d,r14d
     783:	48 89 f1             	mov    rcx,rsi
     786:	48 89 c6             	mov    rsi,rax
     789:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     790:	b8 00 00 00 00       	mov    eax,0x0
     795:	e8 00 00 00 00       	call   79a <parse_io_interrupt+0x191>
     79a:	48 83 c4 20          	add    rsp,0x20
}
     79e:	90                   	nop
     79f:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
     7a3:	5b                   	pop    rbx
     7a4:	41 5c                	pop    r12
     7a6:	41 5d                	pop    r13
     7a8:	41 5e                	pop    r14
     7aa:	41 5f                	pop    r15
     7ac:	5d                   	pop    rbp
     7ad:	c3                   	ret

00000000000007ae <parse_local_interrupt>:
{
     7ae:	55                   	push   rbp
     7af:	48 89 e5             	mov    rbp,rsp
     7b2:	53                   	push   rbx
     7b3:	48 81 ec 88 00 00 00 	sub    rsp,0x88
     7ba:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
		printf("local interrupt assignment:\n");
     7c1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     7c8:	b8 00 00 00 00       	mov    eax,0x0
     7cd:	e8 00 00 00 00       	call   7d2 <parse_local_interrupt+0x24>
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
     7d2:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
     7da:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
     7e2:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
     7ea:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
     7f2:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
     7fa:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
     802:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
     80a:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
     812:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
		const char* el[4] = { "Bus", "edge", "res", "level" };
     81a:	48 c7 45 80 00 00 00 00 	mov    QWORD PTR [rbp-0x80],0x0
     822:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
     82a:	48 c7 45 90 00 00 00 00 	mov    QWORD PTR [rbp-0x70],0x0
     832:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     83a:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     841:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     845:	0f b6 d8             	movzx  ebx,al
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     848:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     84f:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     853:	0f b6 c0             	movzx  eax,al
     856:	89 c7                	mov    edi,eax
     858:	e8 00 00 00 00       	call   85d <parse_local_interrupt+0xaf>
     85d:	48 89 c6             	mov    rsi,rax
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     860:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     867:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     86b:	0f b6 d0             	movzx  edx,al
     86e:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     875:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     878:	b9 04 00 00 00       	mov    ecx,0x4
     87d:	38 c8                	cmp    al,cl
     87f:	0f 42 c1             	cmovb  eax,ecx
     882:	0f b6 c0             	movzx  eax,al
     885:	48 98                	cdqe
     887:	48 8b 44 c5 c0       	mov    rax,QWORD PTR [rbp+rax*8-0x40]
     88c:	41 89 d8             	mov    r8d,ebx
     88f:	48 89 f1             	mov    rcx,rsi
     892:	48 89 c6             	mov    rsi,rax
     895:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     89c:	b8 00 00 00 00       	mov    eax,0x0
     8a1:	e8 00 00 00 00       	call   8a6 <parse_local_interrupt+0xf8>
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
     8a6:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     8ad:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     8b1:	66 c1 e8 02          	shr    ax,0x2
     8b5:	0f b7 c0             	movzx  eax,ax
     8b8:	83 e0 03             	and    eax,0x3
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     8bb:	48 98                	cdqe
     8bd:	48 8b 74 c5 80       	mov    rsi,QWORD PTR [rbp+rax*8-0x80]
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
     8c2:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     8c9:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     8cd:	0f b7 c0             	movzx  eax,ax
     8d0:	83 e0 03             	and    eax,0x3
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     8d3:	48 98                	cdqe
     8d5:	48 8b 4c c5 a0       	mov    rcx,QWORD PTR [rbp+rax*8-0x60]
				l->dest_lapic_id, l->dest_lapic_linp,
     8da:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     8e1:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     8e5:	0f b6 d0             	movzx  edx,al
				l->dest_lapic_id, l->dest_lapic_linp,
     8e8:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     8ef:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     8f3:	0f b6 c0             	movzx  eax,al
     8f6:	49 89 f0             	mov    r8,rsi
     8f9:	89 c6                	mov    esi,eax
     8fb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     902:	b8 00 00 00 00       	mov    eax,0x0
     907:	e8 00 00 00 00       	call   90c <parse_local_interrupt+0x15e>
}
     90c:	90                   	nop
     90d:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     911:	c9                   	leave
     912:	c3                   	ret

0000000000000913 <mp_sanitize_table>:
{
     913:	55                   	push   rbp
     914:	48 89 e5             	mov    rbp,rsp
     917:	48 83 ec 20          	sub    rsp,0x20
		if (!cpu.has_htt)
     91b:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 922 <mp_sanitize_table+0xf>
     922:	83 e0 10             	and    eax,0x10
     925:	84 c0                	test   al,al
     927:	0f 84 ca 00 00 00    	je     9f7 <mp_sanitize_table+0xe4>
		if (!(ps = apic_ids.ap_ids))
     92d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 934 <mp_sanitize_table+0x21>
     934:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     938:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     93d:	0f 84 b7 00 00 00    	je     9fa <mp_sanitize_table+0xe7>
		pt = &apic_ids.ap_ids;
     943:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				int psu = 0;
     94b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
				if (ps->ap_id & 1) {
     952:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     956:	8b 00                	mov    eax,DWORD PTR [rax]
     958:	83 e0 01             	and    eax,0x1
     95b:	85 c0                	test   eax,eax
     95d:	74 6e                	je     9cd <mp_sanitize_table+0xba>
						struct apid* p2 = apic_ids.ap_ids;
     95f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 966 <mp_sanitize_table+0x53>
     966:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								if (p2->ap_id == (ps->ap_id & 0xfffffffe)) {
     96a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     96e:	8b 10                	mov    edx,DWORD PTR [rax]
     970:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     974:	8b 00                	mov    eax,DWORD PTR [rax]
     976:	83 e0 fe             	and    eax,0xfffffffe
     979:	39 c2                	cmp    edx,eax
     97b:	75 24                	jne    9a1 <mp_sanitize_table+0x8e>
										*pt = ps->next;
     97d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     981:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     985:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     989:	48 89 10             	mov    QWORD PTR [rax],rdx
										kfree(ps);
     98c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     990:	48 89 c7             	mov    rdi,rax
     993:	e8 00 00 00 00       	call   998 <mp_sanitize_table+0x85>
										psu = 1;
     998:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
										break;
     99f:	eb 13                	jmp    9b4 <mp_sanitize_table+0xa1>
						} while ((p2 = p2->next));
     9a1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     9a5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     9a9:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     9ad:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     9b2:	75 b6                	jne    96a <mp_sanitize_table+0x57>
						if (!psu)
     9b4:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     9b8:	75 13                	jne    9cd <mp_sanitize_table+0xba>
								ps->ap_id &= 0xffffffe;
     9ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9be:	8b 00                	mov    eax,DWORD PTR [rax]
     9c0:	25 fe ff ff 0f       	and    eax,0xffffffe
     9c5:	89 c2                	mov    edx,eax
     9c7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9cb:	89 10                	mov    DWORD PTR [rax],edx
				if (!psu)
     9cd:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     9d1:	75 0c                	jne    9df <mp_sanitize_table+0xcc>
						pt = &ps->next;
     9d3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9d7:	48 83 c0 08          	add    rax,0x8
     9db:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		} while ((ps = *pt));
     9df:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     9e3:	48 8b 00             	mov    rax,QWORD PTR [rax]
     9e6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     9ea:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     9ef:	0f 85 56 ff ff ff    	jne    94b <mp_sanitize_table+0x38>
     9f5:	eb 04                	jmp    9fb <mp_sanitize_table+0xe8>
				return;
     9f7:	90                   	nop
     9f8:	eb 01                	jmp    9fb <mp_sanitize_table+0xe8>
				return;
     9fa:	90                   	nop
}
     9fb:	c9                   	leave
     9fc:	c3                   	ret

00000000000009fd <mp_parse_config_table>:
{
     9fd:	55                   	push   rbp
     9fe:	48 89 e5             	mov    rbp,rsp
     a01:	48 83 ec 40          	sub    rsp,0x40
     a05:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
     a09:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a0d:	48 25 00 f0 ff ff    	and    rax,0xfffffffffffff000
     a13:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
     a17:	48 c7 45 d8 01 00 00 00 	mov    QWORD PTR [rbp-0x28],0x1
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
     a1f:	48 8d 45 d0          	lea    rax,[rbp-0x30]
     a23:	41 b8 08 00 00 00    	mov    r8d,0x8
     a29:	b9 01 00 00 00       	mov    ecx,0x1
     a2e:	48 89 c2             	mov    rdx,rax
     a31:	be 00 00 00 00       	mov    esi,0x0
     a36:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a3d:	e8 00 00 00 00       	call   a42 <mp_parse_config_table+0x45>
     a42:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!mp) {
     a46:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     a4b:	75 1b                	jne    a68 <mp_parse_config_table+0x6b>
				cprintf(KFMT_WARN, "unable to map MP configuration table to virtual memory. Continuing with UP init.\n");
     a4d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     a54:	bf 0e 00 00 00       	mov    edi,0xe
     a59:	b8 00 00 00 00       	mov    eax,0x0
     a5e:	e8 00 00 00 00       	call   a63 <mp_parse_config_table+0x66>
     a63:	e9 2d 02 00 00       	jmp    c95 <mp_parse_config_table+0x298>
		mp = (void*)mp + ((uint32_t)ptr % 4096);
     a68:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a6c:	89 c0                	mov    eax,eax
     a6e:	25 ff 0f 00 00       	and    eax,0xfff
     a73:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		if (mp->length > 4096) {
     a77:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a7b:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     a7f:	66 3d 00 10          	cmp    ax,0x1000
     a83:	0f 86 bb 00 00 00    	jbe    b44 <mp_parse_config_table+0x147>
				pr.count = rdiv(mp->length, 4096);
     a89:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a8d:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     a91:	66 c1 e8 0c          	shr    ax,0xc
     a95:	0f b7 d0             	movzx  edx,ax
     a98:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a9c:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     aa0:	66 25 ff 0f          	and    ax,0xfff
     aa4:	66 85 c0             	test   ax,ax
     aa7:	0f 95 c0             	setne  al
     aaa:	0f b6 c0             	movzx  eax,al
     aad:	01 d0                	add    eax,edx
     aaf:	48 98                	cdqe
     ab1:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
     ab5:	48 8d 45 d0          	lea    rax,[rbp-0x30]
     ab9:	41 b8 08 00 00 00    	mov    r8d,0x8
     abf:	b9 01 00 00 00       	mov    ecx,0x1
     ac4:	48 89 c2             	mov    rdx,rax
     ac7:	be 00 00 00 00       	mov    esi,0x0
     acc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     ad3:	e8 00 00 00 00       	call   ad8 <mp_parse_config_table+0xdb>
     ad8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (!mem)
     adc:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     ae1:	75 30                	jne    b13 <mp_parse_config_table+0x116>
						die("mmap fails very early!\n");
     ae3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     aea:	bf 0c 00 00 00       	mov    edi,0xc
     aef:	b8 00 00 00 00       	mov    eax,0x0
     af4:	e8 00 00 00 00       	call   af9 <mp_parse_config_table+0xfc>
     af9:	b8 00 00 00 00       	mov    eax,0x0
     afe:	e8 00 00 00 00       	call   b03 <mp_parse_config_table+0x106>
     b03:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     b0a:	e8 00 00 00 00       	call   b0f <mp_parse_config_table+0x112>
     b0f:	fa                   	cli
     b10:	f4                   	hlt
     b11:	eb fd                	jmp    b10 <mp_parse_config_table+0x113>
				mm_unmap(&mm_kernel, mp, 1);
     b13:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b17:	ba 01 00 00 00       	mov    edx,0x1
     b1c:	48 89 c6             	mov    rsi,rax
     b1f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     b26:	e8 00 00 00 00       	call   b2b <mp_parse_config_table+0x12e>
				mp = mem + (uint32_t)ptr % 4096;
     b2b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     b2f:	89 c0                	mov    eax,eax
     b31:	25 ff 0f 00 00       	and    eax,0xfff
     b36:	48 89 c2             	mov    rdx,rax
     b39:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     b3d:	48 01 d0             	add    rax,rdx
     b40:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (checksum_memory(mp, mp->length) != 0) {
     b44:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b48:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     b4c:	0f b7 d0             	movzx  edx,ax
     b4f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b53:	48 89 d6             	mov    rsi,rdx
     b56:	48 89 c7             	mov    rdi,rax
     b59:	e8 34 f5 ff ff       	call   92 <checksum_memory>
     b5e:	84 c0                	test   al,al
     b60:	74 19                	je     b7b <mp_parse_config_table+0x17e>
				cprintf(KFMT_WARN, "MP configuration table checksum error resulting in UP init.\n");
     b62:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     b69:	bf 0e 00 00 00       	mov    edi,0xe
     b6e:	b8 00 00 00 00       	mov    eax,0x0
     b73:	e8 00 00 00 00       	call   b78 <mp_parse_config_table+0x17b>
				while (1);
     b78:	90                   	nop
     b79:	eb fd                	jmp    b78 <mp_parse_config_table+0x17b>
				mp->spec_rev, mp->product_id, mp->oem_id);
     b7b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b7f:	48 8d 48 08          	lea    rcx,[rax+0x8]
     b83:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b87:	48 8d 50 10          	lea    rdx,[rax+0x10]
     b8b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b8f:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
		printf("MP configuration table version 1.%u for machine %.12s from vendor %.8s\n",
     b93:	0f b6 c0             	movzx  eax,al
     b96:	89 c6                	mov    esi,eax
     b98:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     b9f:	b8 00 00 00 00       	mov    eax,0x0
     ba4:	e8 00 00 00 00       	call   ba9 <mp_parse_config_table+0x1ac>
		e = mp + 1;
     ba9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bad:	48 83 c0 2c          	add    rax,0x2c
     bb1:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		ec = mp->entry_count;
     bb5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bb9:	0f b7 40 22          	movzx  eax,WORD PTR [rax+0x22]
     bbd:	66 89 45 f6          	mov    WORD PTR [rbp-0xa],ax
		while (ec--) {
     bc1:	e9 97 00 00 00       	jmp    c5d <mp_parse_config_table+0x260>
				switch (*(uint8_t*)e) {
     bc6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     bca:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     bcd:	0f b6 c0             	movzx  eax,al
     bd0:	83 f8 04             	cmp    eax,0x4
     bd3:	77 6b                	ja     c40 <mp_parse_config_table+0x243>
     bd5:	89 c0                	mov    eax,eax
     bd7:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     bdf:	ff e0                	jmp    rax
						parse_processor_entry(e);
     be1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     be5:	48 89 c7             	mov    rdi,rax
     be8:	e8 00 00 00 00       	call   bed <mp_parse_config_table+0x1f0>
						e += 20;
     bed:	48 83 45 e8 14       	add    QWORD PTR [rbp-0x18],0x14
						break;
     bf2:	eb 69                	jmp    c5d <mp_parse_config_table+0x260>
						parse_bus_entry(e);
     bf4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     bf8:	48 89 c7             	mov    rdi,rax
     bfb:	e8 00 00 00 00       	call   c00 <mp_parse_config_table+0x203>
						e += 8;
     c00:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
						break;
     c05:	eb 56                	jmp    c5d <mp_parse_config_table+0x260>
						parse_io_apic(e);
     c07:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c0b:	48 89 c7             	mov    rdi,rax
     c0e:	e8 00 00 00 00       	call   c13 <mp_parse_config_table+0x216>
						e += 8;
     c13:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
						break;
     c18:	eb 43                	jmp    c5d <mp_parse_config_table+0x260>
						parse_io_interrupt(e);
     c1a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c1e:	48 89 c7             	mov    rdi,rax
     c21:	e8 00 00 00 00       	call   c26 <mp_parse_config_table+0x229>
						e += 8;
     c26:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
						break;
     c2b:	eb 30                	jmp    c5d <mp_parse_config_table+0x260>
						parse_local_interrupt(e);
     c2d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c31:	48 89 c7             	mov    rdi,rax
     c34:	e8 00 00 00 00       	call   c39 <mp_parse_config_table+0x23c>
						e += 8;
     c39:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
						break;
     c3e:	eb 1d                	jmp    c5d <mp_parse_config_table+0x260>
						cprintf(KFMT_WARN, "encountered an unknown entry in the MP table with unkown length. Further parsing is impossible.\n");
     c40:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     c47:	bf 0e 00 00 00       	mov    edi,0xe
     c4c:	b8 00 00 00 00       	mov    eax,0x0
     c51:	e8 00 00 00 00       	call   c56 <mp_parse_config_table+0x259>
						if (ec > 0) /* only ignore last entry */
     c56:	66 83 7d f6 00       	cmp    WORD PTR [rbp-0xa],0x0
     c5b:	75 20                	jne    c7d <mp_parse_config_table+0x280>
		while (ec--) {
     c5d:	0f b7 45 f6          	movzx  eax,WORD PTR [rbp-0xa]
     c61:	8d 50 ff             	lea    edx,[rax-0x1]
     c64:	66 89 55 f6          	mov    WORD PTR [rbp-0xa],dx
     c68:	66 85 c0             	test   ax,ax
     c6b:	0f 85 55 ff ff ff    	jne    bc6 <mp_parse_config_table+0x1c9>
		mp_sanitize_table();
     c71:	b8 00 00 00 00       	mov    eax,0x0
     c76:	e8 00 00 00 00       	call   c7b <mp_parse_config_table+0x27e>
     c7b:	eb 01                	jmp    c7e <mp_parse_config_table+0x281>
								goto cleanup;
     c7d:	90                   	nop
		mm_unmap(&mm_kernel, mp, pr.count);
     c7e:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c82:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c86:	48 89 c6             	mov    rsi,rax
     c89:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c90:	e8 00 00 00 00       	call   c95 <mp_parse_config_table+0x298>
}
     c95:	c9                   	leave
     c96:	c3                   	ret

0000000000000c97 <set_fs_offset>:
{
     c97:	55                   	push   rbp
     c98:	48 89 e5             	mov    rbp,rsp
     c9b:	48 83 ec 20          	sub    rsp,0x20
     c9f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     ca3:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		uint32_t o = (uint32_t)ofs;
     ca7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     cab:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
     cae:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     cb2:	48 8b 00             	mov    rax,QWORD PTR [rax]
     cb5:	48 ba ff ff 00 00 00 ff ff 00 	movabs rdx,0xffff000000ffff
     cbf:	48 21 c2             	and    rdx,rax
     cc2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cc5:	c1 e0 10             	shl    eax,0x10
     cc8:	89 c0                	mov    eax,eax
     cca:	48 09 c2             	or     rdx,rax
				| ((uint64_t)(o & 0xff0000) << 16) | ((uint64_t)(o & 0xff000000) << 32);
     ccd:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cd0:	48 c1 e0 10          	shl    rax,0x10
     cd4:	48 89 c1             	mov    rcx,rax
     cd7:	48 b8 00 00 00 00 ff 00 00 00 	movabs rax,0xff00000000
     ce1:	48 21 c8             	and    rax,rcx
     ce4:	48 09 c2             	or     rdx,rax
     ce7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cea:	48 c1 e0 20          	shl    rax,0x20
     cee:	48 89 c1             	mov    rcx,rax
     cf1:	48 b8 00 00 00 00 00 00 00 ff 	movabs rax,0xff00000000000000
     cfb:	48 21 c8             	and    rax,rcx
     cfe:	48 09 c2             	or     rdx,rax
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
     d01:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d05:	48 89 10             	mov    QWORD PTR [rax],rdx
}
     d08:	90                   	nop
     d09:	c9                   	leave
     d0a:	c3                   	ret

0000000000000d0b <update_fs>:
{
     d0b:	55                   	push   rbp
     d0c:	48 89 e5             	mov    rbp,rsp
		asm volatile (
     d0f:	66 b8 38 00          	mov    ax,0x38
     d13:	8e e8                	mov    gs,eax
}
     d15:	90                   	nop
     d16:	5d                   	pop    rbp
     d17:	c3                   	ret

0000000000000d18 <apic_get_base>:
{
     d18:	55                   	push   rbp
     d19:	48 89 e5             	mov    rbp,rsp
     d1c:	48 83 ec 10          	sub    rsp,0x10
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
     d20:	48 8d 55 f8          	lea    rdx,[rbp-0x8]
     d24:	48 8d 45 fc          	lea    rax,[rbp-0x4]
     d28:	48 89 c6             	mov    rsi,rax
     d2b:	bf 1b 00 00 00       	mov    edi,0x1b
     d30:	e8 00 00 00 00       	call   d35 <apic_get_base+0x1d>
		return ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
     d35:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     d38:	89 c0                	mov    eax,eax
     d3a:	48 c1 e0 20          	shl    rax,0x20
     d3e:	48 89 c2             	mov    rdx,rax
     d41:	48 b8 00 00 00 00 0f 00 00 00 	movabs rax,0xf00000000
     d4b:	48 21 c2             	and    rdx,rax
     d4e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     d51:	89 c0                	mov    eax,eax
     d53:	25 00 f0 ff ff       	and    eax,0xfffff000
     d58:	48 09 d0             	or     rax,rdx
}
     d5b:	c9                   	leave
     d5c:	c3                   	ret

0000000000000d5d <pcp_init>:
{
     d5d:	55                   	push   rbp
     d5e:	48 89 e5             	mov    rbp,rsp
     d61:	53                   	push   rbx
     d62:	48 83 ec 28          	sub    rsp,0x28
		pcp_data = mm_alloc_page(&pm);
     d66:	48 8d 45 d8          	lea    rax,[rbp-0x28]
     d6a:	48 89 c7             	mov    rdi,rax
     d6d:	e8 00 00 00 00       	call   d72 <pcp_init+0x15>
     d72:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # d79 <pcp_init+0x1c>
		ap_stack = (void*)0x06000; // FM_AP_STACK top down (6->5)
     d79:	48 c7 05 00 00 00 00 00 60 00 00 	mov    QWORD PTR [rip+0x0],0x6000        # d84 <pcp_init+0x27>
		ap_cr3 = mm_kernel.cr3;
     d84:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d8b <pcp_init+0x2e>
     d8b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # d92 <pcp_init+0x35>
		ap_mode = 2;
     d92:	c6 05 00 00 00 00 02 	mov    BYTE PTR [rip+0x0],0x2        # d99 <pcp_init+0x3c>
		pcp_data[0] = pd = kmalloc(sizeof(struct processor_data));
     d99:	bf 30 00 00 00       	mov    edi,0x30
     d9e:	e8 00 00 00 00       	call   da3 <pcp_init+0x46>
     da3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     da7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # dae <pcp_init+0x51>
     dae:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     db2:	48 89 10             	mov    QWORD PTR [rax],rdx
		pcp_ofs++;
     db5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # dbc <pcp_init+0x5f>
     dbc:	48 83 c0 01          	add    rax,0x1
     dc0:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # dc7 <pcp_init+0x6a>
		pd->proc_index = 0;
     dc7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     dcb:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		pd->apic_id = apic_ids.bp_id;
     dd1:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # dd7 <pcp_init+0x7a>
     dd7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ddb:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		pd->apic_addr = bp_apic_base;
     dde:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # de5 <pcp_init+0x88>
     de5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     de9:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		pd->apic_phys = apic_get_base();
     ded:	b8 00 00 00 00       	mov    eax,0x0
     df2:	e8 00 00 00 00       	call   df7 <pcp_init+0x9a>
     df7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     dfb:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
		pd->ticks = bp_tick;
     dff:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # e06 <pcp_init+0xa9>
     e06:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e0a:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
		pd->mm_ctx = mm_create_ctx();
     e0e:	48 8b 5d e8          	mov    rbx,QWORD PTR [rbp-0x18]
     e12:	b8 00 00 00 00       	mov    eax,0x0
     e17:	e8 00 00 00 00       	call   e1c <pcp_init+0xbf>
     e1c:	48 89 43 20          	mov    QWORD PTR [rbx+0x20],rax
     e20:	48 89 53 28          	mov    QWORD PTR [rbx+0x28],rdx
		set_fs_offset(pcp_data, (uint64_t*)(ap_gdtp + 0x40));
     e24:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e2b <pcp_init+0xce>
     e2b:	48 8d 50 40          	lea    rdx,[rax+0x40]
     e2f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e36 <pcp_init+0xd9>
     e36:	48 89 d6             	mov    rsi,rdx
     e39:	48 89 c7             	mov    rdi,rax
     e3c:	e8 00 00 00 00       	call   e41 <pcp_init+0xe4>
		update_fs();
     e41:	b8 00 00 00 00       	mov    eax,0x0
     e46:	e8 00 00 00 00       	call   e4b <pcp_init+0xee>
		asm volatile ("movq %%gs:0, %%rax" : "=a" (ptr));
     e4b:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
     e54:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		if (ptr != pd)
     e58:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     e5c:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
     e60:	74 30                	je     e92 <pcp_init+0x135>
				die("per-cpu data through fs/gs segment selector not working!\n");
     e62:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     e69:	bf 0c 00 00 00       	mov    edi,0xc
     e6e:	b8 00 00 00 00       	mov    eax,0x0
     e73:	e8 00 00 00 00       	call   e78 <pcp_init+0x11b>
     e78:	b8 00 00 00 00       	mov    eax,0x0
     e7d:	e8 00 00 00 00       	call   e82 <pcp_init+0x125>
     e82:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e89:	e8 00 00 00 00       	call   e8e <pcp_init+0x131>
     e8e:	fa                   	cli
     e8f:	f4                   	hlt
     e90:	eb fd                	jmp    e8f <pcp_init+0x132>
}
     e92:	90                   	nop
     e93:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     e97:	c9                   	leave
     e98:	c3                   	ret

0000000000000e99 <get_cpu_data>:
{
     e99:	55                   	push   rbp
     e9a:	48 89 e5             	mov    rbp,rsp
     e9d:	48 83 ec 08          	sub    rsp,0x8
     ea1:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		return pcp_data[smp_index];
     ea4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # eab <get_cpu_data+0x12>
     eab:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     eae:	48 c1 e2 03          	shl    rdx,0x3
     eb2:	48 01 d0             	add    rax,rdx
     eb5:	48 8b 00             	mov    rax,QWORD PTR [rax]
}
     eb8:	c9                   	leave
     eb9:	c3                   	ret

0000000000000eba <launch_ap>:
{
     eba:	55                   	push   rbp
     ebb:	48 89 e5             	mov    rbp,rsp
     ebe:	48 83 ec 30          	sub    rsp,0x30
     ec2:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		uint64_t ct = 10, timeout;
     ec5:	48 c7 45 f8 0a 00 00 00 	mov    QWORD PTR [rbp-0x8],0xa
		ap_start = ap_fail = 0;
     ecd:	b8 00 00 00 00       	mov    eax,0x0
     ed2:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # ed8 <launch_ap+0x1e>
     ed8:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # ede <launch_ap+0x24>
		if (pcp_ofs >= 1023) {
     ede:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ee5 <launch_ap+0x2b>
     ee5:	48 3d fe 03 00 00    	cmp    rax,0x3fe
     eeb:	76 20                	jbe    f0d <launch_ap+0x53>
				cprintf(KFMT_WARN, "cpu-data limit reached, skipping processors.\n");
     eed:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     ef4:	bf 0e 00 00 00       	mov    edi,0xe
     ef9:	b8 00 00 00 00       	mov    eax,0x0
     efe:	e8 00 00 00 00       	call   f03 <launch_ap+0x49>
				return -1;
     f03:	b8 ff ff ff ff       	mov    eax,0xffffffff
     f08:	e9 5f 03 00 00       	jmp    126c <launch_ap+0x3b2>
		preempt_disable();
     f0d:	b8 00 00 00 00       	mov    eax,0x0
     f12:	e8 00 00 00 00       	call   f17 <launch_ap+0x5d>
     f17:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
     f1a:	83 c2 01             	add    edx,0x1
     f1d:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		pcp_data[pcp_ofs] = pd = kzalloc(sizeof(struct processor_data));
     f20:	bf 30 00 00 00       	mov    edi,0x30
     f25:	e8 00 00 00 00       	call   f2a <launch_ap+0x70>
     f2a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     f2e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f35 <launch_ap+0x7b>
     f35:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # f3c <launch_ap+0x82>
     f3c:	48 c1 e2 03          	shl    rdx,0x3
     f40:	48 01 c2             	add    rdx,rax
     f43:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f47:	48 89 02             	mov    QWORD PTR [rdx],rax
		pd->apic_id = id;
     f4a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f4e:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     f51:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		pd->apic_addr = bp_apic_base - 4096;
     f54:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f5b <launch_ap+0xa1>
     f5b:	48 8d 90 00 f0 ff ff 	lea    rdx,[rax-0x1000]
     f62:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f66:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		pd->apic_phys = 0;
     f6a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f6e:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
		pd->proc_index = pcp_ofs;
     f76:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f7d <launch_ap+0xc3>
     f7d:	89 c2                	mov    edx,eax
     f7f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f83:	89 10                	mov    DWORD PTR [rax],edx
		pd->ticks = kzalloc(sizeof(struct perf_ctrs));
     f85:	bf 50 00 00 00       	mov    edi,0x50
     f8a:	e8 00 00 00 00       	call   f8f <launch_ap+0xd5>
     f8f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f93:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
		ap_gdtp = kmalloc(GDT_SIZE);
     f97:	bf 50 00 00 00       	mov    edi,0x50
     f9c:	e8 00 00 00 00       	call   fa1 <launch_ap+0xe7>
     fa1:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # fa8 <launch_ap+0xee>
		memcpy(ap_gdtp, &gdt, GDT_SIZE);
     fa8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # faf <launch_ap+0xf5>
     faf:	ba 50 00 00 00       	mov    edx,0x50
     fb4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     fbb:	48 89 c7             	mov    rdi,rax
     fbe:	e8 77 f0 ff ff       	call   3a <memcpy>
		set_fs_offset(pcp_data + pcp_ofs, (uint64_t*)(ap_gdtp + SEG_DATA_PROC));
     fc3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fca <launch_ap+0x110>
     fca:	48 8d 50 38          	lea    rdx,[rax+0x38]
     fce:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fd5 <launch_ap+0x11b>
     fd5:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # fdc <launch_ap+0x122>
     fdc:	48 c1 e1 03          	shl    rcx,0x3
     fe0:	48 01 c8             	add    rax,rcx
     fe3:	48 89 d6             	mov    rsi,rdx
     fe6:	48 89 c7             	mov    rdi,rax
     fe9:	e8 00 00 00 00       	call   fee <launch_ap+0x134>
		apic_reg(APIC_REG_ESR) = 0;
     fee:	b8 00 00 00 00       	mov    eax,0x0
     ff3:	e8 08 f0 ff ff       	call   0 <per_cpu_ptr>
     ff8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ffc:	48 05 80 02 00 00    	add    rax,0x280
    1002:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		apic_reg(APIC_REG_ICRH) = id;
    1008:	b8 00 00 00 00       	mov    eax,0x0
    100d:	e8 ee ef ff ff       	call   0 <per_cpu_ptr>
    1012:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1016:	48 8d 90 10 03 00 00 	lea    rdx,[rax+0x310]
    101d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1020:	89 02                	mov    DWORD PTR [rdx],eax
		apic_reg(APIC_REG_ICRL) = 0x0000c500; /* edge assert level init */
    1022:	b8 00 00 00 00       	mov    eax,0x0
    1027:	e8 d4 ef ff ff       	call   0 <per_cpu_ptr>
    102c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1030:	48 05 00 03 00 00    	add    rax,0x300
    1036:	c7 00 00 c5 00 00    	mov    DWORD PTR [rax],0xc500
		while (apic_reg(APIC_REG_ICRL) & (1 << 12)); /* send pending */
    103c:	90                   	nop
    103d:	b8 00 00 00 00       	mov    eax,0x0
    1042:	e8 b9 ef ff ff       	call   0 <per_cpu_ptr>
    1047:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    104b:	48 05 00 03 00 00    	add    rax,0x300
    1051:	8b 00                	mov    eax,DWORD PTR [rax]
    1053:	25 00 10 00 00       	and    eax,0x1000
    1058:	85 c0                	test   eax,eax
    105a:	75 e1                	jne    103d <launch_ap+0x183>
		mdelay(20);
    105c:	bf 14 00 00 00       	mov    edi,0x14
    1061:	e8 00 00 00 00       	call   1066 <launch_ap+0x1ac>
		apic_reg(APIC_REG_ICRH) = id;
    1066:	b8 00 00 00 00       	mov    eax,0x0
    106b:	e8 90 ef ff ff       	call   0 <per_cpu_ptr>
    1070:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1074:	48 8d 90 10 03 00 00 	lea    rdx,[rax+0x310]
    107b:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    107e:	89 02                	mov    DWORD PTR [rdx],eax
		apic_reg(APIC_REG_ICRL) = 0x00008500; /* edge de-assert init */
    1080:	b8 00 00 00 00       	mov    eax,0x0
    1085:	e8 76 ef ff ff       	call   0 <per_cpu_ptr>
    108a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    108e:	48 05 00 03 00 00    	add    rax,0x300
    1094:	c7 00 00 85 00 00    	mov    DWORD PTR [rax],0x8500
		while (apic_reg(APIC_REG_ICRL) & (1 << 12));
    109a:	90                   	nop
    109b:	b8 00 00 00 00       	mov    eax,0x0
    10a0:	e8 5b ef ff ff       	call   0 <per_cpu_ptr>
    10a5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    10a9:	48 05 00 03 00 00    	add    rax,0x300
    10af:	8b 00                	mov    eax,DWORD PTR [rax]
    10b1:	25 00 10 00 00       	and    eax,0x1000
    10b6:	85 c0                	test   eax,eax
    10b8:	75 e1                	jne    109b <launch_ap+0x1e1>
		timeout = jiffies + HZ * ct / 1000;
    10ba:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 10c1 <launch_ap+0x207>
    10c1:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    10c4:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    10c8:	48 89 d0             	mov    rax,rdx
    10cb:	48 c1 e0 04          	shl    rax,0x4
    10cf:	48 29 d0             	sub    rax,rdx
    10d2:	48 c1 e0 03          	shl    rax,0x3
    10d6:	48 01 d0             	add    rax,rdx
    10d9:	48 c1 e8 03          	shr    rax,0x3
    10dd:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    10e7:	48 f7 e2             	mul    rdx
    10ea:	48 89 d0             	mov    rax,rdx
    10ed:	48 c1 e8 04          	shr    rax,0x4
    10f1:	48 01 c8             	add    rax,rcx
    10f4:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		apic_reg(APIC_REG_ESR) = 0;
    10f8:	b8 00 00 00 00       	mov    eax,0x0
    10fd:	e8 fe ee ff ff       	call   0 <per_cpu_ptr>
    1102:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1106:	48 05 80 02 00 00    	add    rax,0x280
    110c:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		apic_reg(APIC_REG_ICRH) = id;
    1112:	b8 00 00 00 00       	mov    eax,0x0
    1117:	e8 e4 ee ff ff       	call   0 <per_cpu_ptr>
    111c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1120:	48 8d 90 10 03 00 00 	lea    rdx,[rax+0x310]
    1127:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    112a:	89 02                	mov    DWORD PTR [rdx],eax
		apic_reg(APIC_REG_ICRL) = 0x00004600 | 6; /* pseudo-vector 6 <-> 0x6000 */
    112c:	b8 00 00 00 00       	mov    eax,0x0
    1131:	e8 ca ee ff ff       	call   0 <per_cpu_ptr>
    1136:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    113a:	48 05 00 03 00 00    	add    rax,0x300
    1140:	c7 00 06 46 00 00    	mov    DWORD PTR [rax],0x4606
		while (!ap_start)
    1146:	eb 19                	jmp    1161 <launch_ap+0x2a7>
				if (time_after(jiffies, timeout))
    1148:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 114f <launch_ap+0x295>
    114f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1152:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1156:	48 29 c2             	sub    rdx,rax
    1159:	48 89 d0             	mov    rax,rdx
    115c:	48 85 c0             	test   rax,rax
    115f:	78 0d                	js     116e <launch_ap+0x2b4>
		while (!ap_start)
    1161:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1168 <launch_ap+0x2ae>
    1168:	84 c0                	test   al,al
    116a:	74 dc                	je     1148 <launch_ap+0x28e>
    116c:	eb 01                	jmp    116f <launch_ap+0x2b5>
						break;
    116e:	90                   	nop
		if (!ap_start && ct < 1000) {
    116f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1176 <launch_ap+0x2bc>
    1176:	84 c0                	test   al,al
    1178:	75 24                	jne    119e <launch_ap+0x2e4>
    117a:	48 81 7d f8 e7 03 00 00 	cmp    QWORD PTR [rbp-0x8],0x3e7
    1182:	77 1a                	ja     119e <launch_ap+0x2e4>
				ct *= 10; /* 1000ms */
    1184:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1188:	48 89 d0             	mov    rax,rdx
    118b:	48 c1 e0 02          	shl    rax,0x2
    118f:	48 01 d0             	add    rax,rdx
    1192:	48 01 c0             	add    rax,rax
    1195:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				goto resend;
    1199:	e9 1c ff ff ff       	jmp    10ba <launch_ap+0x200>
		if (!ap_start)
    119e:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 11a5 <launch_ap+0x2eb>
    11a5:	84 c0                	test   al,al
    11a7:	74 6f                	je     1218 <launch_ap+0x35e>
		while (ap_start); /* trampoline is in use */
    11a9:	90                   	nop
    11aa:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 11b1 <launch_ap+0x2f7>
    11b1:	84 c0                	test   al,al
    11b3:	75 f5                	jne    11aa <launch_ap+0x2f0>
		if (ap_fail)
    11b5:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 11bc <launch_ap+0x302>
    11bc:	84 c0                	test   al,al
    11be:	75 5b                	jne    121b <launch_ap+0x361>
		pcp_ofs++;
    11c0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 11c7 <launch_ap+0x30d>
    11c7:	48 83 c0 01          	add    rax,0x1
    11cb:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 11d2 <launch_ap+0x318>
		bp_apic_base = pd->apic_addr; /* decrement next allocation base */
    11d2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11d6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    11da:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 11e1 <launch_ap+0x327>
		preempt_enable();
    11e1:	b8 00 00 00 00       	mov    eax,0x0
    11e6:	e8 00 00 00 00       	call   11eb <launch_ap+0x331>
    11eb:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    11ee:	83 ea 01             	sub    edx,0x1
    11f1:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    11f4:	b8 00 00 00 00       	mov    eax,0x0
    11f9:	e8 00 00 00 00       	call   11fe <launch_ap+0x344>
    11fe:	8b 00                	mov    eax,DWORD PTR [rax]
    1200:	83 e0 01             	and    eax,0x1
    1203:	85 c0                	test   eax,eax
    1205:	74 0a                	je     1211 <launch_ap+0x357>
    1207:	b8 00 00 00 00       	mov    eax,0x0
    120c:	e8 00 00 00 00       	call   1211 <launch_ap+0x357>
		return 0;
    1211:	b8 00 00 00 00       	mov    eax,0x0
    1216:	eb 54                	jmp    126c <launch_ap+0x3b2>
				goto failure;
    1218:	90                   	nop
    1219:	eb 01                	jmp    121c <launch_ap+0x362>
				goto failure;
    121b:	90                   	nop
		kfree(ap_gdtp);
    121c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1223 <launch_ap+0x369>
    1223:	48 89 c7             	mov    rdi,rax
    1226:	e8 00 00 00 00       	call   122b <launch_ap+0x371>
		kfree(pd);
    122b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    122f:	48 89 c7             	mov    rdi,rax
    1232:	e8 00 00 00 00       	call   1237 <launch_ap+0x37d>
		preempt_enable();
    1237:	b8 00 00 00 00       	mov    eax,0x0
    123c:	e8 00 00 00 00       	call   1241 <launch_ap+0x387>
    1241:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    1244:	83 ea 01             	sub    edx,0x1
    1247:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    124a:	b8 00 00 00 00       	mov    eax,0x0
    124f:	e8 00 00 00 00       	call   1254 <launch_ap+0x39a>
    1254:	8b 00                	mov    eax,DWORD PTR [rax]
    1256:	83 e0 01             	and    eax,0x1
    1259:	85 c0                	test   eax,eax
    125b:	74 0a                	je     1267 <launch_ap+0x3ad>
    125d:	b8 00 00 00 00       	mov    eax,0x0
    1262:	e8 00 00 00 00       	call   1267 <launch_ap+0x3ad>
		return -1;
    1267:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    126c:	c9                   	leave
    126d:	c3                   	ret

000000000000126e <imcr_pic_to_apic>:
{
    126e:	55                   	push   rbp
    126f:	48 89 e5             	mov    rbp,rsp
		outb(0x70, 0x22);
    1272:	be 22 00 00 00       	mov    esi,0x22
    1277:	bf 70 00 00 00       	mov    edi,0x70
    127c:	e8 9a ed ff ff       	call   1b <outb>
		outb(0x01, 0x23);
    1281:	be 23 00 00 00       	mov    esi,0x23
    1286:	bf 01 00 00 00       	mov    edi,0x1
    128b:	e8 8b ed ff ff       	call   1b <outb>
}
    1290:	90                   	nop
    1291:	5d                   	pop    rbp
    1292:	c3                   	ret

0000000000001293 <imcr_apic_to_pic>:
{
    1293:	55                   	push   rbp
    1294:	48 89 e5             	mov    rbp,rsp
		outb(0x70, 0x22);
    1297:	be 22 00 00 00       	mov    esi,0x22
    129c:	bf 70 00 00 00       	mov    edi,0x70
    12a1:	e8 75 ed ff ff       	call   1b <outb>
		outb(0x00, 0x23);
    12a6:	be 23 00 00 00       	mov    esi,0x23
    12ab:	bf 00 00 00 00       	mov    edi,0x0
    12b0:	e8 66 ed ff ff       	call   1b <outb>
}
    12b5:	90                   	nop
    12b6:	5d                   	pop    rbp
    12b7:	c3                   	ret

00000000000012b8 <ioapic_init>:
{
    12b8:	55                   	push   rbp
    12b9:	48 89 e5             	mov    rbp,rsp
    12bc:	48 83 ec 20          	sub    rsp,0x20
    12c0:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		struct io_apic* io = io_apics;
    12c3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 12ca <ioapic_init+0x12>
    12ca:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (imcr)
    12ce:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    12d2:	74 34                	je     1308 <ioapic_init+0x50>
				imcr_pic_to_apic();
    12d4:	b8 00 00 00 00       	mov    eax,0x0
    12d9:	e8 00 00 00 00       	call   12de <ioapic_init+0x26>
		while (io) {
    12de:	eb 28                	jmp    1308 <ioapic_init+0x50>
				init_ioapic(io->id, io->addr);
    12e0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12e4:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    12e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12ec:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    12ef:	0f b6 c0             	movzx  eax,al
    12f2:	48 89 d6             	mov    rsi,rdx
    12f5:	89 c7                	mov    edi,eax
    12f7:	e8 00 00 00 00       	call   12fc <ioapic_init+0x44>
				io = io->next;
    12fc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1300:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1304:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (io) {
    1308:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    130d:	75 d1                	jne    12e0 <ioapic_init+0x28>
}
    130f:	90                   	nop
    1310:	90                   	nop
    1311:	c9                   	leave
    1312:	c3                   	ret

0000000000001313 <mp_init>:
{
    1313:	55                   	push   rbp
    1314:	48 89 e5             	mov    rbp,rsp
    1317:	48 83 ec 20          	sub    rsp,0x20
    131b:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		struct apid* id = apic_ids.ap_ids;
    131e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1325 <mp_init+0x12>
    1325:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		pcp_init();
    1329:	b8 00 00 00 00       	mov    eax,0x0
    132e:	e8 00 00 00 00       	call   1333 <mp_init+0x20>
		while (id) {
    1333:	e9 83 00 00 00       	jmp    13bb <mp_init+0xa8>
				printf("attempting to start AP %x\n", id->ap_id);
    1338:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    133c:	8b 00                	mov    eax,DWORD PTR [rax]
    133e:	89 c6                	mov    esi,eax
    1340:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1347:	b8 00 00 00 00       	mov    eax,0x0
    134c:	e8 00 00 00 00       	call   1351 <mp_init+0x3e>
				if (launch_ap(id->ap_id) == 0) {
    1351:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1355:	8b 00                	mov    eax,DWORD PTR [rax]
    1357:	89 c7                	mov    edi,eax
    1359:	e8 00 00 00 00       	call   135e <mp_init+0x4b>
    135e:	85 c0                	test   eax,eax
    1360:	75 2f                	jne    1391 <mp_init+0x7e>
						cprintf(KFMT_OK, "started AP %08x successfully\n", id->ap_id);
    1362:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1366:	8b 00                	mov    eax,DWORD PTR [rax]
    1368:	89 c2                	mov    edx,eax
    136a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1371:	bf 0a 00 00 00       	mov    edi,0xa
    1376:	b8 00 00 00 00       	mov    eax,0x0
    137b:	e8 00 00 00 00       	call   1380 <mp_init+0x6d>
						nproc++;
    1380:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1386 <mp_init+0x73>
    1386:	83 c0 01             	add    eax,0x1
    1389:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 138f <mp_init+0x7c>
    138f:	eb 1e                	jmp    13af <mp_init+0x9c>
						cprintf(KFMT_WARN, "AP %08x refused to start\n", id->ap_id);
    1391:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1395:	8b 00                	mov    eax,DWORD PTR [rax]
    1397:	89 c2                	mov    edx,eax
    1399:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    13a0:	bf 0e 00 00 00       	mov    edi,0xe
    13a5:	b8 00 00 00 00       	mov    eax,0x0
    13aa:	e8 00 00 00 00       	call   13af <mp_init+0x9c>
				id = id->next;
    13af:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13b3:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    13b7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (id) {
    13bb:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    13c0:	0f 85 72 ff ff ff    	jne    1338 <mp_init+0x25>
		ioapic_init(imcr);
    13c6:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    13c9:	89 c7                	mov    edi,eax
    13cb:	e8 00 00 00 00       	call   13d0 <mp_init+0xbd>
		return (nproc > 1) ? 0 : -1;
    13d0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 13d6 <mp_init+0xc3>
    13d6:	83 f8 01             	cmp    eax,0x1
    13d9:	76 07                	jbe    13e2 <mp_init+0xcf>
    13db:	b8 00 00 00 00       	mov    eax,0x0
    13e0:	eb 05                	jmp    13e7 <mp_init+0xd4>
    13e2:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    13e7:	c9                   	leave
    13e8:	c3                   	ret

00000000000013e9 <mp_entry>:
{
    13e9:	55                   	push   rbp
    13ea:	48 89 e5             	mov    rbp,rsp
    13ed:	48 83 ec 10          	sub    rsp,0x10
		struct mp_fps* fps = find_mp_fps();
    13f1:	b8 00 00 00 00       	mov    eax,0x0
    13f6:	e8 00 00 00 00       	call   13fb <mp_entry+0x12>
    13fb:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (fps) {
    13ff:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    1404:	0f 84 41 01 00 00    	je     154b <mp_entry+0x162>
				printf("This machine conforms to the MP specification version 1.%u\n", (uint32_t)fps->spec_rev);
    140a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    140e:	0f b6 40 09          	movzx  eax,BYTE PTR [rax+0x9]
    1412:	0f b6 c0             	movzx  eax,al
    1415:	89 c6                	mov    esi,eax
    1417:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    141e:	b8 00 00 00 00       	mov    eax,0x0
    1423:	e8 00 00 00 00       	call   1428 <mp_entry+0x3f>
				if (!fps->features[0]) { /* table present */
    1428:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    142c:	0f b6 40 0b          	movzx  eax,BYTE PTR [rax+0xb]
    1430:	84 c0                	test   al,al
    1432:	75 27                	jne    145b <mp_entry+0x72>
						printf("It has a MP configuration table at %p\n", ptr = mp2ptr(fps->mp_config));
    1434:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1438:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    143b:	89 c0                	mov    eax,eax
    143d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1441:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1445:	48 89 c6             	mov    rsi,rax
    1448:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    144f:	b8 00 00 00 00       	mov    eax,0x0
    1454:	e8 00 00 00 00       	call   1459 <mp_entry+0x70>
    1459:	eb 7d                	jmp    14d8 <mp_entry+0xef>
								"Therefore there is no MP configuration table expected. (%p)\n", ptr = mp2ptr(fps->mp_config));
    145b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    145f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1462:	89 c0                	mov    eax,eax
						printf("It uses a default MP configuration defined by feature bits. "
    1464:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1468:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    146c:	48 89 c6             	mov    rsi,rax
    146f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1476:	b8 00 00 00 00       	mov    eax,0x0
    147b:	e8 00 00 00 00       	call   1480 <mp_entry+0x97>
						printf("The default configuration has ID %u\n", fps->features[0]);
    1480:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1484:	0f b6 40 0b          	movzx  eax,BYTE PTR [rax+0xb]
    1488:	0f b6 c0             	movzx  eax,al
    148b:	89 c6                	mov    esi,eax
    148d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1494:	b8 00 00 00 00       	mov    eax,0x0
    1499:	e8 00 00 00 00       	call   149e <mp_entry+0xb5>
						if (!ptr)
    149e:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    14a3:	75 16                	jne    14bb <mp_entry+0xd2>
								ptr = build_configuration_table_from_default(fps->features[0]);
    14a5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14a9:	0f b6 40 0b          	movzx  eax,BYTE PTR [rax+0xb]
    14ad:	0f b6 c0             	movzx  eax,al
    14b0:	89 c7                	mov    edi,eax
    14b2:	e8 00 00 00 00       	call   14b7 <mp_entry+0xce>
    14b7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						if (!ptr) {
    14bb:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    14c0:	75 16                	jne    14d8 <mp_entry+0xef>
								printf("and is unrecognized, resulting in UP init.\n");
    14c2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    14c9:	b8 00 00 00 00       	mov    eax,0x0
    14ce:	e8 00 00 00 00       	call   14d3 <mp_entry+0xea>
								return;
    14d3:	e9 84 00 00 00       	jmp    155c <mp_entry+0x173>
				mp_parse_config_table(ptr);
    14d8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14dc:	48 89 c7             	mov    rdi,rax
    14df:	e8 00 00 00 00       	call   14e4 <mp_entry+0xfb>
				cprintf(KFMT_INFO, "attempting MP init...\n");
    14e4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    14eb:	bf 0b 00 00 00       	mov    edi,0xb
    14f0:	b8 00 00 00 00       	mov    eax,0x0
    14f5:	e8 00 00 00 00       	call   14fa <mp_entry+0x111>
				if (mp_init(!!(fps->features[1] & 0x80)))
    14fa:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14fe:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1502:	c0 e8 07             	shr    al,0x7
    1505:	0f b6 c0             	movzx  eax,al
    1508:	89 c7                	mov    edi,eax
    150a:	e8 00 00 00 00       	call   150f <mp_entry+0x126>
    150f:	85 c0                	test   eax,eax
    1511:	74 18                	je     152b <mp_entry+0x142>
						cprintf(KFMT_WARN, "MP init failed continuing with UP.\n");
    1513:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    151a:	bf 0e 00 00 00       	mov    edi,0xe
    151f:	b8 00 00 00 00       	mov    eax,0x0
    1524:	e8 00 00 00 00       	call   1529 <mp_entry+0x140>
    1529:	eb 31                	jmp    155c <mp_entry+0x173>
						cprintf(KFMT_OK, "MP init successful, now there are %u processors active.\n", nproc);
    152b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1531 <mp_entry+0x148>
    1531:	89 c2                	mov    edx,eax
    1533:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    153a:	bf 0a 00 00 00       	mov    edi,0xa
    153f:	b8 00 00 00 00       	mov    eax,0x0
    1544:	e8 00 00 00 00       	call   1549 <mp_entry+0x160>
    1549:	eb 11                	jmp    155c <mp_entry+0x173>
				printf("This machine does not conform to the MP specification but "
    154b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1552:	b8 00 00 00 00       	mov    eax,0x0
    1557:	e8 00 00 00 00       	call   155c <mp_entry+0x173>
}
    155c:	c9                   	leave
    155d:	c3                   	ret
