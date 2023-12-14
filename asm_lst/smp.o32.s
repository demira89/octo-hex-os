
smp.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		/* BIOS ROM */
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
		return rv;
}

void* build_configuration_table_from_default(uint8_t tp)
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
{
		return NULL + tp - tp;
}

void parse_processor_entry(struct mp_proc* p)
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
{
		static int hdr = 0;
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
		if (!hdr++) {
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <outb>:
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
		/* TODO: for now do nothing with this info */
}

void mp_sanitize_table()
{
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp
      17:	83 ec 08             	sub    esp,0x8
      1a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      1d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      20:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
      24:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
		struct apid *ps, **pt;
      27:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
      2b:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      2f:	ee                   	out    dx,al
		/* removes duplicate speculative processor entries */
      30:	90                   	nop
      31:	c9                   	leave
      32:	c3                   	ret

00000033 <memcpy>:
{
		/* first map the table to VM */
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
		uint16_t ec; void* e;

      33:	55                   	push   ebp
      34:	89 e5                	mov    ebp,esp
      36:	83 ec 10             	sub    esp,0x10
		if (!mp) {
      39:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      3c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				cprintf(KFMT_WARN, "unable to map MP configuration table to virtual memory. Continuing with UP init.\n");
      3f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      42:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				return;
      45:	eb 17                	jmp    5e <memcpy+0x2b>
		}
      47:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      4a:	8d 42 01             	lea    eax,[edx+0x1]
      4d:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      50:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      53:	8d 48 01             	lea    ecx,[eax+0x1]
      56:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      59:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      5c:	88 10                	mov    BYTE PTR [eax],dl
				return;
      5e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      61:	8d 50 ff             	lea    edx,[eax-0x1]
      64:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      67:	85 c0                	test   eax,eax
      69:	75 dc                	jne    47 <memcpy+0x14>
		/* fix the mmap alignment */
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
      a0:	83 ec 18             	sub    esp,0x18
		while (ct >= 16) {
      a3:	eb 3f                	jmp    e4 <search_mp_fps+0x47>
				if (*(uint32_t*)mem == 0x5f504d5f) {
      a5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      a8:	8b 00                	mov    eax,DWORD PTR [eax]
      aa:	3d 5f 4d 50 5f       	cmp    eax,0x5f504d5f
      af:	75 2b                	jne    dc <search_mp_fps+0x3f>
						struct mp_fps* fps = mem;
      b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b4:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						if (checksum_memory(mem, 16 * fps->length) == 0)
      b7:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      ba:	0f b6 40 08          	movzx  eax,BYTE PTR [eax+0x8]
      be:	0f b6 c0             	movzx  eax,al
      c1:	c1 e0 04             	shl    eax,0x4
      c4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
      c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      cb:	89 04 24             	mov    DWORD PTR [esp],eax
      ce:	e8 9c ff ff ff       	call   6f <checksum_memory>
      d3:	84 c0                	test   al,al
      d5:	75 05                	jne    dc <search_mp_fps+0x3f>
								return mem;
      d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      da:	eb 13                	jmp    ef <search_mp_fps+0x52>
				mem += 16;
      dc:	83 45 08 10          	add    DWORD PTR [ebp+0x8],0x10
				ct -= 16;
      e0:	83 6d 0c 10          	sub    DWORD PTR [ebp+0xc],0x10
		while (ct >= 16) {
      e4:	83 7d 0c 0f          	cmp    DWORD PTR [ebp+0xc],0xf
      e8:	77 bb                	ja     a5 <search_mp_fps+0x8>
		return NULL;
      ea:	b8 00 00 00 00       	mov    eax,0x0
}
      ef:	c9                   	leave
      f0:	c3                   	ret

000000f1 <find_mp_fps>:
{
      f1:	55                   	push   ebp
      f2:	89 e5                	mov    ebp,esp
      f4:	83 ec 18             	sub    esp,0x18
		rv = (void*)((size_t)*(uint16_t*)0x040e << 16);
      f7:	b8 0e 04 00 00       	mov    eax,0x40e
      fc:	0f b7 00             	movzx  eax,WORD PTR [eax]
      ff:	0f b7 c0             	movzx  eax,ax
     102:	c1 e0 10             	shl    eax,0x10
     105:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if ((size_t)rv < 0x000a0000 && (0x000a0000 - (size_t)rv) <= 128 * 1024) {
     108:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     10b:	3d ff ff 09 00       	cmp    eax,0x9ffff
     110:	77 33                	ja     145 <find_mp_fps+0x54>
     112:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     115:	ba 00 00 0a 00       	mov    edx,0xa0000
     11a:	29 c2                	sub    edx,eax
     11c:	81 fa 00 00 02 00    	cmp    edx,0x20000
     122:	77 21                	ja     145 <find_mp_fps+0x54>
				rv = search_mp_fps(rv, 1024);
     124:	c7 44 24 04 00 04 00 00 	mov    DWORD PTR [esp+0x4],0x400
     12c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     12f:	89 04 24             	mov    DWORD PTR [esp],eax
     132:	e8 fc ff ff ff       	call   133 <find_mp_fps+0x42>
     137:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				if (rv)
     13a:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     13e:	74 05                	je     145 <find_mp_fps+0x54>
						return rv;
     140:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     143:	eb 5e                	jmp    1a3 <find_mp_fps+0xb2>
		rv = search_mp_fps((void*)0x7fc00, 1024);
     145:	c7 44 24 04 00 04 00 00 	mov    DWORD PTR [esp+0x4],0x400
     14d:	c7 04 24 00 fc 07 00 	mov    DWORD PTR [esp],0x7fc00
     154:	e8 fc ff ff ff       	call   155 <find_mp_fps+0x64>
     159:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rv)
     15c:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     160:	74 05                	je     167 <find_mp_fps+0x76>
				return rv;
     162:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     165:	eb 3c                	jmp    1a3 <find_mp_fps+0xb2>
		rv = search_mp_fps((void*)0x9fc00, 1024);
     167:	c7 44 24 04 00 04 00 00 	mov    DWORD PTR [esp+0x4],0x400
     16f:	c7 04 24 00 fc 09 00 	mov    DWORD PTR [esp],0x9fc00
     176:	e8 fc ff ff ff       	call   177 <find_mp_fps+0x86>
     17b:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rv)
     17e:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     182:	74 05                	je     189 <find_mp_fps+0x98>
				return rv;
     184:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     187:	eb 1a                	jmp    1a3 <find_mp_fps+0xb2>
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
     189:	c7 44 24 04 00 00 01 00 	mov    DWORD PTR [esp+0x4],0x10000
     191:	c7 04 24 00 00 0f 00 	mov    DWORD PTR [esp],0xf0000
     198:	e8 fc ff ff ff       	call   199 <find_mp_fps+0xa8>
     19d:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return rv;
     1a0:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
     1a3:	c9                   	leave
     1a4:	c3                   	ret

000001a5 <build_configuration_table_from_default>:
{
     1a5:	55                   	push   ebp
     1a6:	89 e5                	mov    ebp,esp
     1a8:	83 ec 04             	sub    esp,0x4
     1ab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ae:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		return NULL + tp - tp;
     1b1:	b8 00 00 00 00       	mov    eax,0x0
}
     1b6:	c9                   	leave
     1b7:	c3                   	ret

000001b8 <parse_processor_entry>:
{
     1b8:	55                   	push   ebp
     1b9:	89 e5                	mov    ebp,esp
     1bb:	56                   	push   esi
     1bc:	53                   	push   ebx
     1bd:	83 ec 30             	sub    esp,0x30
		if (!hdr++) {
     1c0:	a1 18 00 00 00       	mov    eax,ds:0x18
     1c5:	8d 50 01             	lea    edx,[eax+0x1]
     1c8:	89 15 18 00 00 00    	mov    DWORD PTR ds:0x18,edx
     1ce:	85 c0                	test   eax,eax
     1d0:	75 18                	jne    1ea <parse_processor_entry+0x32>
				printf("Processors from MP list:\n");
     1d2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     1d9:	e8 fc ff ff ff       	call   1da <parse_processor_entry+0x22>
				printf("TYPE  STATUS    APIC ID  SIGNATURE  FLAGS\n");
     1de:	c7 04 24 1c 00 00 00 	mov    DWORD PTR [esp],0x1c
     1e5:	e8 fc ff ff ff       	call   1e6 <parse_processor_entry+0x2e>
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     1ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ed:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     1f0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
				p->lapic_id, p->cpu_signature, p->cpu_features);
     1f6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f9:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     1fd:	0f b6 c0             	movzx  eax,al
				(p->cpu_flags & 1) ? "enabled" : "disabled",
     200:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
     203:	0f b6 5b 03          	movzx  ebx,BYTE PTR [ebx+0x3]
     207:	0f b6 db             	movzx  ebx,bl
     20a:	83 e3 01             	and    ebx,0x1
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     20d:	85 db                	test   ebx,ebx
     20f:	74 07                	je     218 <parse_processor_entry+0x60>
     211:	be 47 00 00 00       	mov    esi,0x47
     216:	eb 05                	jmp    21d <parse_processor_entry+0x65>
     218:	be 4f 00 00 00       	mov    esi,0x4f
				(p->cpu_flags & 2) ? "BP" : "AP",
     21d:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
     220:	0f b6 5b 03          	movzx  ebx,BYTE PTR [ebx+0x3]
     224:	0f b6 db             	movzx  ebx,bl
     227:	83 e3 02             	and    ebx,0x2
		printf("%4s  %-8s  %7u  %08x   %08x\n",
     22a:	85 db                	test   ebx,ebx
     22c:	74 07                	je     235 <parse_processor_entry+0x7d>
     22e:	bb 58 00 00 00       	mov    ebx,0x58
     233:	eb 05                	jmp    23a <parse_processor_entry+0x82>
     235:	bb 5b 00 00 00       	mov    ebx,0x5b
     23a:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     23e:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
     242:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     246:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
     24a:	89 5c 24 04          	mov    DWORD PTR [esp+0x4],ebx
     24e:	c7 04 24 5e 00 00 00 	mov    DWORD PTR [esp],0x5e
     255:	e8 fc ff ff ff       	call   256 <parse_processor_entry+0x9e>
		if (!(p->cpu_flags & 1))
     25a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     25d:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     261:	0f b6 c0             	movzx  eax,al
     264:	83 e0 01             	and    eax,0x1
     267:	85 c0                	test   eax,eax
     269:	0f 84 bc 00 00 00    	je     32b <parse_processor_entry+0x173>
		else if (p->cpu_flags & 2) { /* BP */
     26f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     272:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     276:	0f b6 c0             	movzx  eax,al
     279:	83 e0 02             	and    eax,0x2
     27c:	85 c0                	test   eax,eax
     27e:	74 26                	je     2a6 <parse_processor_entry+0xee>
				apic_ids.bp_id = (uint32_t)p->lapic_id << 24;
     280:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     283:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     287:	0f b6 c0             	movzx  eax,al
     28a:	c1 e0 18             	shl    eax,0x18
     28d:	a3 00 00 00 00       	mov    ds:0x0,eax
				if (cpu.has_htt)
     292:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
     299:	83 e0 10             	and    eax,0x10
     29c:	84 c0                	test   al,al
     29e:	0f 84 88 00 00 00    	je     32c <parse_processor_entry+0x174>
						goto htt_proc;
     2a4:	eb 46                	jmp    2ec <parse_processor_entry+0x134>
				struct apid* pi = kmalloc(sizeof(struct apid));
     2a6:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
     2ad:	e8 fc ff ff ff       	call   2ae <parse_processor_entry+0xf6>
     2b2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pi->ap_id = (uint32_t)p->lapic_id << 24;
     2b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2b8:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     2bc:	0f b6 c0             	movzx  eax,al
     2bf:	c1 e0 18             	shl    eax,0x18
     2c2:	89 c2                	mov    edx,eax
     2c4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2c7:	89 10                	mov    DWORD PTR [eax],edx
				pi->next = apic_ids.ap_ids;
     2c9:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     2cf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2d2:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				apic_ids.ap_ids = pi;
     2d5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2d8:	a3 04 00 00 00       	mov    ds:0x4,eax
				if (cpu.has_htt) {
     2dd:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
     2e4:	83 e0 10             	and    eax,0x10
     2e7:	84 c0                	test   al,al
     2e9:	74 41                	je     32c <parse_processor_entry+0x174>
htt_proc: /* mark as speculative */
     2eb:	90                   	nop
						pi = kmalloc(sizeof(struct apid));
     2ec:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
     2f3:	e8 fc ff ff ff       	call   2f4 <parse_processor_entry+0x13c>
     2f8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						pi->ap_id = ((uint32_t)p->lapic_id + 1) << 24 | 1;
     2fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2fe:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     302:	0f b6 c0             	movzx  eax,al
     305:	83 c0 01             	add    eax,0x1
     308:	c1 e0 18             	shl    eax,0x18
     30b:	83 c8 01             	or     eax,0x1
     30e:	89 c2                	mov    edx,eax
     310:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     313:	89 10                	mov    DWORD PTR [eax],edx
						pi->next = apic_ids.ap_ids;
     315:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     31b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     31e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						apic_ids.ap_ids = pi;
     321:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     324:	a3 04 00 00 00       	mov    ds:0x4,eax
     329:	eb 01                	jmp    32c <parse_processor_entry+0x174>
				return; /* disabled any */
     32b:	90                   	nop
}
     32c:	83 c4 30             	add    esp,0x30
     32f:	5b                   	pop    ebx
     330:	5e                   	pop    esi
     331:	5d                   	pop    ebp
     332:	c3                   	ret

00000333 <parse_bus_entry>:
{
     333:	55                   	push   ebp
     334:	89 e5                	mov    ebp,esp
     336:	83 ec 28             	sub    esp,0x28
		printf("Bus with id %u is %.6s\n", b->bus_id, b->bus_type);
     339:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     33c:	8d 50 02             	lea    edx,[eax+0x2]
     33f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     342:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     346:	0f b6 c0             	movzx  eax,al
     349:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     34d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     351:	c7 04 24 7b 00 00 00 	mov    DWORD PTR [esp],0x7b
     358:	e8 fc ff ff ff       	call   359 <parse_bus_entry+0x26>
		id = kmalloc(sizeof(struct busid));
     35d:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
     364:	e8 fc ff ff ff       	call   365 <parse_bus_entry+0x32>
     369:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		id->id = b->bus_id;
     36c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     36f:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     373:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     376:	88 10                	mov    BYTE PTR [eax],dl
		id->next = bus_ids;
     378:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     37e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     381:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		if (strncmp(b->bus_type, "ISA   ", 6) == 0)
     384:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     387:	83 c0 02             	add    eax,0x2
     38a:	c7 44 24 08 06 00 00 00 	mov    DWORD PTR [esp+0x8],0x6
     392:	c7 44 24 04 93 00 00 00 	mov    DWORD PTR [esp+0x4],0x93
     39a:	89 04 24             	mov    DWORD PTR [esp],eax
     39d:	e8 fc ff ff ff       	call   39e <parse_bus_entry+0x6b>
     3a2:	85 c0                	test   eax,eax
     3a4:	75 09                	jne    3af <parse_bus_entry+0x7c>
				id->type = BT_ISA;
     3a6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3a9:	c6 40 01 00          	mov    BYTE PTR [eax+0x1],0x0
     3ad:	eb 71                	jmp    420 <parse_bus_entry+0xed>
		else if (strncmp(b->bus_type, "EISA  ", 6) == 0)
     3af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b2:	83 c0 02             	add    eax,0x2
     3b5:	c7 44 24 08 06 00 00 00 	mov    DWORD PTR [esp+0x8],0x6
     3bd:	c7 44 24 04 9a 00 00 00 	mov    DWORD PTR [esp+0x4],0x9a
     3c5:	89 04 24             	mov    DWORD PTR [esp],eax
     3c8:	e8 fc ff ff ff       	call   3c9 <parse_bus_entry+0x96>
     3cd:	85 c0                	test   eax,eax
     3cf:	75 09                	jne    3da <parse_bus_entry+0xa7>
				id->type = BT_EISA;
     3d1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3d4:	c6 40 01 01          	mov    BYTE PTR [eax+0x1],0x1
     3d8:	eb 46                	jmp    420 <parse_bus_entry+0xed>
		else if (strncmp(b->bus_type, "PCI   ", 6) == 0)
     3da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3dd:	83 c0 02             	add    eax,0x2
     3e0:	c7 44 24 08 06 00 00 00 	mov    DWORD PTR [esp+0x8],0x6
     3e8:	c7 44 24 04 a1 00 00 00 	mov    DWORD PTR [esp+0x4],0xa1
     3f0:	89 04 24             	mov    DWORD PTR [esp],eax
     3f3:	e8 fc ff ff ff       	call   3f4 <parse_bus_entry+0xc1>
     3f8:	85 c0                	test   eax,eax
     3fa:	75 09                	jne    405 <parse_bus_entry+0xd2>
				id->type = BT_PCI;
     3fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ff:	c6 40 01 02          	mov    BYTE PTR [eax+0x1],0x2
     403:	eb 1b                	jmp    420 <parse_bus_entry+0xed>
				cprintf(KFMT_WARN, "bus type is unrecognized and will be ignored.\n");
     405:	c7 44 24 04 a8 00 00 00 	mov    DWORD PTR [esp+0x4],0xa8
     40d:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     414:	e8 fc ff ff ff       	call   415 <parse_bus_entry+0xe2>
				id->type = BT_UNKNOWN;
     419:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     41c:	c6 40 01 ff          	mov    BYTE PTR [eax+0x1],0xff
		bus_ids = id;
     420:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     423:	a3 00 00 00 00       	mov    ds:0x0,eax
}
     428:	90                   	nop
     429:	c9                   	leave
     42a:	c3                   	ret

0000042b <parse_io_apic>:
{
     42b:	55                   	push   ebp
     42c:	89 e5                	mov    ebp,esp
     42e:	53                   	push   ebx
     42f:	83 ec 34             	sub    esp,0x34
						(i->flags & 1) ? "enabled" : "disabled");
     432:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     435:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     439:	0f b6 c0             	movzx  eax,al
     43c:	83 e0 01             	and    eax,0x1
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     43f:	85 c0                	test   eax,eax
     441:	74 07                	je     44a <parse_io_apic+0x1f>
     443:	b9 47 00 00 00       	mov    ecx,0x47
     448:	eb 05                	jmp    44f <parse_io_apic+0x24>
     44a:	b9 4f 00 00 00       	mov    ecx,0x4f
						i->ver, i->id, mp2ptr(i->addr),
     44f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     452:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     455:	89 c3                	mov    ebx,eax
						i->ver, i->id, mp2ptr(i->addr),
     457:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     45a:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     45e:	0f b6 d0             	movzx  edx,al
						i->ver, i->id, mp2ptr(i->addr),
     461:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     464:	0f b6 40 02          	movzx  eax,BYTE PTR [eax+0x2]
		printf("I/O APIC version %u with id %u at %p is %s.\n",
     468:	0f b6 c0             	movzx  eax,al
     46b:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     46f:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
     473:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     477:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     47b:	c7 04 24 d8 00 00 00 	mov    DWORD PTR [esp],0xd8
     482:	e8 fc ff ff ff       	call   483 <parse_io_apic+0x58>
		if ((i->flags & 1) == 0)
     487:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     48a:	0f b6 40 03          	movzx  eax,BYTE PTR [eax+0x3]
     48e:	0f b6 c0             	movzx  eax,al
     491:	83 e0 01             	and    eax,0x1
     494:	85 c0                	test   eax,eax
     496:	74 3f                	je     4d7 <parse_io_apic+0xac>
		io = kmalloc(sizeof(struct io_apic));
     498:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     49f:	e8 fc ff ff ff       	call   4a0 <parse_io_apic+0x75>
     4a4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		io->id = i->id;
     4a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4aa:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     4ae:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4b1:	88 10                	mov    BYTE PTR [eax],dl
		io->addr = mp2ptr(i->addr);
     4b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4b6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     4b9:	89 c2                	mov    edx,eax
     4bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4be:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		io->next = io_apics;
     4c1:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     4c7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4ca:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		io_apics = io;
     4cd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4d0:	a3 00 00 00 00       	mov    ds:0x0,eax
     4d5:	eb 01                	jmp    4d8 <parse_io_apic+0xad>
				return;
     4d7:	90                   	nop
}
     4d8:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     4db:	c9                   	leave
     4dc:	c3                   	ret

000004dd <find_bus>:
{
     4dd:	55                   	push   ebp
     4de:	89 e5                	mov    ebp,esp
     4e0:	83 ec 24             	sub    esp,0x24
     4e3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4e6:	88 45 dc             	mov    BYTE PTR [ebp-0x24],al
		struct busid* bi = bus_ids;
     4e9:	a1 00 00 00 00       	mov    eax,ds:0x0
     4ee:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		const char* bts[4] = { "ISA", "EISA", "PCI", "Unknown" };
     4f1:	c7 45 ec 05 01 00 00 	mov    DWORD PTR [ebp-0x14],0x105
     4f8:	c7 45 f0 09 01 00 00 	mov    DWORD PTR [ebp-0x10],0x109
     4ff:	c7 45 f4 0e 01 00 00 	mov    DWORD PTR [ebp-0xc],0x10e
     506:	c7 45 f8 12 01 00 00 	mov    DWORD PTR [ebp-0x8],0x112
		if (!bus_ids)
     50d:	a1 00 00 00 00       	mov    eax,ds:0x0
     512:	85 c0                	test   eax,eax
     514:	75 07                	jne    51d <find_bus+0x40>
				return "";
     516:	b8 1a 01 00 00       	mov    eax,0x11a
     51b:	eb 39                	jmp    556 <find_bus+0x79>
				if (bi->id == id)
     51d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     520:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     523:	38 45 dc             	cmp    BYTE PTR [ebp-0x24],al
     526:	75 1a                	jne    542 <find_bus+0x65>
						return bts[min(bi->type, 3)];
     528:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     52b:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
     52f:	ba 03 00 00 00       	mov    edx,0x3
     534:	38 d0                	cmp    al,dl
     536:	0f 47 c2             	cmova  eax,edx
     539:	0f b6 c0             	movzx  eax,al
     53c:	8b 44 85 ec          	mov    eax,DWORD PTR [ebp+eax*4-0x14]
     540:	eb 14                	jmp    556 <find_bus+0x79>
		} while ((bi = bi->next));
     542:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     545:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     548:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     54b:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     54f:	75 cc                	jne    51d <find_bus+0x40>
		return "";
     551:	b8 1a 01 00 00       	mov    eax,0x11a
}
     556:	c9                   	leave
     557:	c3                   	ret

00000558 <parse_io_interrupt>:
{
     558:	55                   	push   ebp
     559:	89 e5                	mov    ebp,esp
     55b:	57                   	push   edi
     55c:	56                   	push   esi
     55d:	53                   	push   ebx
     55e:	81 ec 8c 00 00 00    	sub    esp,0x8c
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
     564:	c7 45 d4 1b 01 00 00 	mov    DWORD PTR [ebp-0x2c],0x11b
     56b:	c7 45 d8 1f 01 00 00 	mov    DWORD PTR [ebp-0x28],0x11f
     572:	c7 45 dc 23 01 00 00 	mov    DWORD PTR [ebp-0x24],0x123
     579:	c7 45 e0 27 01 00 00 	mov    DWORD PTR [ebp-0x20],0x127
     580:	c7 45 e4 12 01 00 00 	mov    DWORD PTR [ebp-0x1c],0x112
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
     587:	c7 45 c4 2e 01 00 00 	mov    DWORD PTR [ebp-0x3c],0x12e
     58e:	c7 45 c8 32 01 00 00 	mov    DWORD PTR [ebp-0x38],0x132
     595:	c7 45 cc 35 01 00 00 	mov    DWORD PTR [ebp-0x34],0x135
     59c:	c7 45 d0 39 01 00 00 	mov    DWORD PTR [ebp-0x30],0x139
		const char* el[4] = { "Bus", "edge", "res", "level" };
     5a3:	c7 45 b4 2e 01 00 00 	mov    DWORD PTR [ebp-0x4c],0x12e
     5aa:	c7 45 b8 3c 01 00 00 	mov    DWORD PTR [ebp-0x48],0x13c
     5b1:	c7 45 bc 35 01 00 00 	mov    DWORD PTR [ebp-0x44],0x135
     5b8:	c7 45 c0 41 01 00 00 	mov    DWORD PTR [ebp-0x40],0x141
		if (!prt++) {
     5bf:	a1 1c 00 00 00       	mov    eax,ds:0x1c
     5c4:	8d 50 01             	lea    edx,[eax+0x1]
     5c7:	89 15 1c 00 00 00    	mov    DWORD PTR ds:0x1c,edx
     5cd:	85 c0                	test   eax,eax
     5cf:	75 18                	jne    5e9 <parse_io_interrupt+0x91>
				printf("I/O interrupt assignments:\n");
     5d1:	c7 04 24 47 01 00 00 	mov    DWORD PTR [esp],0x147
     5d8:	e8 fc ff ff ff       	call   5d9 <parse_io_interrupt+0x81>
				printf("TYPE     BUS (NAME)   IRQ  IOAPIC  INP#  POL    TRIG\n");
     5dd:	c7 04 24 64 01 00 00 	mov    DWORD PTR [esp],0x164
     5e4:	e8 fc ff ff ff       	call   5e5 <parse_io_interrupt+0x8d>
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
     5e9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5ec:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     5f0:	66 c1 e8 02          	shr    ax,0x2
     5f4:	0f b7 c0             	movzx  eax,ax
     5f7:	83 e0 03             	and    eax,0x3
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     5fa:	8b 5c 85 b4          	mov    ebx,DWORD PTR [ebp+eax*4-0x4c]
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
     5fe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     601:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     605:	0f b7 c0             	movzx  eax,ax
     608:	83 e0 03             	and    eax,0x3
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     60b:	8b 44 85 c4          	mov    eax,DWORD PTR [ebp+eax*4-0x3c]
     60f:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     612:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     615:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     619:	0f b6 c8             	movzx  ecx,al
     61c:	89 4d a0             	mov    DWORD PTR [ebp-0x60],ecx
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     61f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     622:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     626:	0f b6 f0             	movzx  esi,al
     629:	89 75 9c             	mov    DWORD PTR [ebp-0x64],esi
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
     62c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     62f:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     633:	0f b6 f8             	movzx  edi,al
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     636:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     639:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     63d:	0f b6 c0             	movzx  eax,al
     640:	89 04 24             	mov    DWORD PTR [esp],eax
     643:	e8 fc ff ff ff       	call   644 <parse_io_interrupt+0xec>
     648:	89 c6                	mov    esi,eax
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     64a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     64d:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     651:	0f b6 c8             	movzx  ecx,al
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
     654:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     657:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     65a:	b8 04 00 00 00       	mov    eax,0x4
     65f:	38 c2                	cmp    dl,al
     661:	0f 43 c2             	cmovae eax,edx
     664:	0f b6 c0             	movzx  eax,al
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
     667:	8b 44 85 d4          	mov    eax,DWORD PTR [ebp+eax*4-0x2c]
     66b:	89 5c 24 20          	mov    DWORD PTR [esp+0x20],ebx
     66f:	8b 5d a4             	mov    ebx,DWORD PTR [ebp-0x5c]
     672:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     676:	8b 5d a0             	mov    ebx,DWORD PTR [ebp-0x60]
     679:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
     67d:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
     680:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
     684:	89 7c 24 10          	mov    DWORD PTR [esp+0x10],edi
     688:	89 74 24 0c          	mov    DWORD PTR [esp+0xc],esi
     68c:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     690:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     694:	c7 04 24 9c 01 00 00 	mov    DWORD PTR [esp],0x19c
     69b:	e8 fc ff ff ff       	call   69c <parse_io_interrupt+0x144>
}
     6a0:	90                   	nop
     6a1:	81 c4 8c 00 00 00    	add    esp,0x8c
     6a7:	5b                   	pop    ebx
     6a8:	5e                   	pop    esi
     6a9:	5f                   	pop    edi
     6aa:	5d                   	pop    ebp
     6ab:	c3                   	ret

000006ac <parse_local_interrupt>:
{
     6ac:	55                   	push   ebp
     6ad:	89 e5                	mov    ebp,esp
     6af:	56                   	push   esi
     6b0:	53                   	push   ebx
     6b1:	83 ec 70             	sub    esp,0x70
		printf("local interrupt assignment:\n");
     6b4:	c7 04 24 c6 01 00 00 	mov    DWORD PTR [esp],0x1c6
     6bb:	e8 fc ff ff ff       	call   6bc <parse_local_interrupt+0x10>
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
     6c0:	c7 45 e4 1b 01 00 00 	mov    DWORD PTR [ebp-0x1c],0x11b
     6c7:	c7 45 e8 1f 01 00 00 	mov    DWORD PTR [ebp-0x18],0x11f
     6ce:	c7 45 ec 23 01 00 00 	mov    DWORD PTR [ebp-0x14],0x123
     6d5:	c7 45 f0 27 01 00 00 	mov    DWORD PTR [ebp-0x10],0x127
     6dc:	c7 45 f4 12 01 00 00 	mov    DWORD PTR [ebp-0xc],0x112
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
     6e3:	c7 45 d4 2e 01 00 00 	mov    DWORD PTR [ebp-0x2c],0x12e
     6ea:	c7 45 d8 32 01 00 00 	mov    DWORD PTR [ebp-0x28],0x132
     6f1:	c7 45 dc 35 01 00 00 	mov    DWORD PTR [ebp-0x24],0x135
     6f8:	c7 45 e0 39 01 00 00 	mov    DWORD PTR [ebp-0x20],0x139
		const char* el[4] = { "Bus", "edge", "res", "level" };
     6ff:	c7 45 c4 2e 01 00 00 	mov    DWORD PTR [ebp-0x3c],0x12e
     706:	c7 45 c8 3c 01 00 00 	mov    DWORD PTR [ebp-0x38],0x13c
     70d:	c7 45 cc 35 01 00 00 	mov    DWORD PTR [ebp-0x34],0x135
     714:	c7 45 d0 41 01 00 00 	mov    DWORD PTR [ebp-0x30],0x141
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     71b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     71e:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     722:	0f b6 d8             	movzx  ebx,al
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     725:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     728:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     72c:	0f b6 c0             	movzx  eax,al
     72f:	89 04 24             	mov    DWORD PTR [esp],eax
     732:	e8 fc ff ff ff       	call   733 <parse_local_interrupt+0x87>
     737:	89 c2                	mov    edx,eax
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
     739:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     73c:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
     740:	0f b6 c8             	movzx  ecx,al
     743:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     746:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     749:	c6 45 b7 04          	mov    BYTE PTR [ebp-0x49],0x4
     74d:	3a 45 b7             	cmp    al,BYTE PTR [ebp-0x49]
     750:	0f b6 75 b7          	movzx  esi,BYTE PTR [ebp-0x49]
     754:	0f 42 c6             	cmovb  eax,esi
     757:	0f b6 c0             	movzx  eax,al
     75a:	8b 44 85 e4          	mov    eax,DWORD PTR [ebp+eax*4-0x1c]
     75e:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     762:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     766:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     76a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     76e:	c7 04 24 e4 01 00 00 	mov    DWORD PTR [esp],0x1e4
     775:	e8 fc ff ff ff       	call   776 <parse_local_interrupt+0xca>
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
     77a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     77d:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     781:	66 c1 e8 02          	shr    ax,0x2
     785:	0f b7 c0             	movzx  eax,ax
     788:	83 e0 03             	and    eax,0x3
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     78b:	8b 5c 85 c4          	mov    ebx,DWORD PTR [ebp+eax*4-0x3c]
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
     78f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     792:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     796:	0f b7 c0             	movzx  eax,ax
     799:	83 e0 03             	and    eax,0x3
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     79c:	8b 4c 85 d4          	mov    ecx,DWORD PTR [ebp+eax*4-0x2c]
				l->dest_lapic_id, l->dest_lapic_linp,
     7a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7a3:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     7a7:	0f b6 d0             	movzx  edx,al
				l->dest_lapic_id, l->dest_lapic_linp,
     7aa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7ad:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
     7b1:	0f b6 c0             	movzx  eax,al
     7b4:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     7b8:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     7bc:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     7c0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     7c4:	c7 04 24 08 02 00 00 	mov    DWORD PTR [esp],0x208
     7cb:	e8 fc ff ff ff       	call   7cc <parse_local_interrupt+0x120>
}
     7d0:	90                   	nop
     7d1:	83 c4 70             	add    esp,0x70
     7d4:	5b                   	pop    ebx
     7d5:	5e                   	pop    esi
     7d6:	5d                   	pop    ebp
     7d7:	c3                   	ret

000007d8 <mp_sanitize_table>:
{
     7d8:	55                   	push   ebp
     7d9:	89 e5                	mov    ebp,esp
     7db:	83 ec 28             	sub    esp,0x28
		if (!cpu.has_htt)
     7de:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
     7e5:	83 e0 10             	and    eax,0x10
     7e8:	84 c0                	test   al,al
     7ea:	0f 84 ad 00 00 00    	je     89d <mp_sanitize_table+0xc5>
		if (!(ps = apic_ids.ap_ids))
     7f0:	a1 04 00 00 00       	mov    eax,ds:0x4
     7f5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     7f8:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     7fc:	0f 84 9e 00 00 00    	je     8a0 <mp_sanitize_table+0xc8>
		pt = &apic_ids.ap_ids;
     802:	c7 45 f0 04 00 00 00 	mov    DWORD PTR [ebp-0x10],0x4
				int psu = 0;
     809:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				if (ps->ap_id & 1) {
     810:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     813:	8b 00                	mov    eax,DWORD PTR [eax]
     815:	83 e0 01             	and    eax,0x1
     818:	85 c0                	test   eax,eax
     81a:	74 5e                	je     87a <mp_sanitize_table+0xa2>
						struct apid* p2 = apic_ids.ap_ids;
     81c:	a1 04 00 00 00       	mov    eax,ds:0x4
     821:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								if (p2->ap_id == (ps->ap_id & 0xfffffffe)) {
     824:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     827:	8b 10                	mov    edx,DWORD PTR [eax]
     829:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     82c:	8b 00                	mov    eax,DWORD PTR [eax]
     82e:	83 e0 fe             	and    eax,0xfffffffe
     831:	39 c2                	cmp    edx,eax
     833:	75 1f                	jne    854 <mp_sanitize_table+0x7c>
										*pt = ps->next;
     835:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     838:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     83b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     83e:	89 10                	mov    DWORD PTR [eax],edx
										kfree(ps);
     840:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     843:	89 04 24             	mov    DWORD PTR [esp],eax
     846:	e8 fc ff ff ff       	call   847 <mp_sanitize_table+0x6f>
										psu = 1;
     84b:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
										break;
     852:	eb 0f                	jmp    863 <mp_sanitize_table+0x8b>
						} while ((p2 = p2->next));
     854:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     857:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     85a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     85d:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     861:	75 c1                	jne    824 <mp_sanitize_table+0x4c>
						if (!psu)
     863:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     867:	75 11                	jne    87a <mp_sanitize_table+0xa2>
								ps->ap_id &= 0xffffffe;
     869:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     86c:	8b 00                	mov    eax,DWORD PTR [eax]
     86e:	25 fe ff ff 0f       	and    eax,0xffffffe
     873:	89 c2                	mov    edx,eax
     875:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     878:	89 10                	mov    DWORD PTR [eax],edx
				if (!psu)
     87a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     87e:	75 09                	jne    889 <mp_sanitize_table+0xb1>
						pt = &ps->next;
     880:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     883:	83 c0 04             	add    eax,0x4
     886:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		} while ((ps = *pt));
     889:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     88c:	8b 00                	mov    eax,DWORD PTR [eax]
     88e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     891:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     895:	0f 85 6e ff ff ff    	jne    809 <mp_sanitize_table+0x31>
     89b:	eb 04                	jmp    8a1 <mp_sanitize_table+0xc9>
				return;
     89d:	90                   	nop
     89e:	eb 01                	jmp    8a1 <mp_sanitize_table+0xc9>
				return;
     8a0:	90                   	nop
}
     8a1:	c9                   	leave
     8a2:	c3                   	ret

000008a3 <mp_parse_config_table>:
{
     8a3:	55                   	push   ebp
     8a4:	89 e5                	mov    ebp,esp
     8a6:	83 ec 48             	sub    esp,0x48
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
     8a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8ac:	c1 e8 0c             	shr    eax,0xc
     8af:	ba 00 00 00 00       	mov    edx,0x0
     8b4:	0f a4 c2 0c          	shld   edx,eax,0xc
     8b8:	c1 e0 0c             	shl    eax,0xc
     8bb:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     8be:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
     8c1:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
     8c8:	c7 44 24 10 08 00 00 00 	mov    DWORD PTR [esp+0x10],0x8
     8d0:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
     8d8:	8d 45 dc             	lea    eax,[ebp-0x24]
     8db:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     8df:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     8e7:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     8ee:	e8 fc ff ff ff       	call   8ef <mp_parse_config_table+0x4c>
     8f3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!mp) {
     8f6:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     8fa:	75 19                	jne    915 <mp_parse_config_table+0x72>
				cprintf(KFMT_WARN, "unable to map MP configuration table to virtual memory. Continuing with UP init.\n");
     8fc:	c7 44 24 04 34 02 00 00 	mov    DWORD PTR [esp+0x4],0x234
     904:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     90b:	e8 fc ff ff ff       	call   90c <mp_parse_config_table+0x69>
     910:	e9 05 02 00 00       	jmp    b1a <mp_parse_config_table+0x277>
		mp = (void*)mp + ((uint32_t)ptr % 4096);
     915:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     918:	25 ff 0f 00 00       	and    eax,0xfff
     91d:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		if (mp->length > 4096) {
     920:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     923:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     927:	66 3d 00 10          	cmp    ax,0x1000
     92b:	0f 86 b1 00 00 00    	jbe    9e2 <mp_parse_config_table+0x13f>
				pr.count = rdiv(mp->length, 4096);
     931:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     934:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     938:	66 c1 e8 0c          	shr    ax,0xc
     93c:	0f b7 d0             	movzx  edx,ax
     93f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     942:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     946:	66 25 ff 0f          	and    ax,0xfff
     94a:	66 85 c0             	test   ax,ax
     94d:	0f 95 c0             	setne  al
     950:	0f b6 c0             	movzx  eax,al
     953:	01 d0                	add    eax,edx
     955:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
     958:	c7 44 24 10 08 00 00 00 	mov    DWORD PTR [esp+0x10],0x8
     960:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
     968:	8d 45 dc             	lea    eax,[ebp-0x24]
     96b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     96f:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     977:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     97e:	e8 fc ff ff ff       	call   97f <mp_parse_config_table+0xdc>
     983:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (!mem)
     986:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     98a:	75 29                	jne    9b5 <mp_parse_config_table+0x112>
						die("mmap fails very early!\n");
     98c:	c7 44 24 04 86 02 00 00 	mov    DWORD PTR [esp+0x4],0x286
     994:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     99b:	e8 fc ff ff ff       	call   99c <mp_parse_config_table+0xf9>
     9a0:	e8 fc ff ff ff       	call   9a1 <mp_parse_config_table+0xfe>
     9a5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     9ac:	e8 fc ff ff ff       	call   9ad <mp_parse_config_table+0x10a>
     9b1:	fa                   	cli
     9b2:	f4                   	hlt
     9b3:	eb fd                	jmp    9b2 <mp_parse_config_table+0x10f>
				mm_unmap(&mm_kernel, mp, 1);
     9b5:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
     9bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9c0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     9c4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     9cb:	e8 fc ff ff ff       	call   9cc <mp_parse_config_table+0x129>
				mp = mem + (uint32_t)ptr % 4096;
     9d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9d3:	25 ff 0f 00 00       	and    eax,0xfff
     9d8:	89 c2                	mov    edx,eax
     9da:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9dd:	01 d0                	add    eax,edx
     9df:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (checksum_memory(mp, mp->length) != 0) {
     9e2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9e5:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     9e9:	0f b7 c0             	movzx  eax,ax
     9ec:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     9f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9f3:	89 04 24             	mov    DWORD PTR [esp],eax
     9f6:	e8 74 f6 ff ff       	call   6f <checksum_memory>
     9fb:	84 c0                	test   al,al
     9fd:	74 17                	je     a16 <mp_parse_config_table+0x173>
				cprintf(KFMT_WARN, "MP configuration table checksum error resulting in UP init.\n");
     9ff:	c7 44 24 04 a0 02 00 00 	mov    DWORD PTR [esp+0x4],0x2a0
     a07:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     a0e:	e8 fc ff ff ff       	call   a0f <mp_parse_config_table+0x16c>
				while (1);
     a13:	90                   	nop
     a14:	eb fd                	jmp    a13 <mp_parse_config_table+0x170>
				mp->spec_rev, mp->product_id, mp->oem_id);
     a16:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a19:	8d 48 08             	lea    ecx,[eax+0x8]
     a1c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a1f:	8d 50 10             	lea    edx,[eax+0x10]
     a22:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a25:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
		printf("MP configuration table version 1.%u for machine %.12s from vendor %.8s\n",
     a29:	0f b6 c0             	movzx  eax,al
     a2c:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     a30:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     a34:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     a38:	c7 04 24 e0 02 00 00 	mov    DWORD PTR [esp],0x2e0
     a3f:	e8 fc ff ff ff       	call   a40 <mp_parse_config_table+0x19d>
		e = mp + 1;
     a44:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a47:	83 c0 2c             	add    eax,0x2c
     a4a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ec = mp->entry_count;
     a4d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a50:	0f b7 40 22          	movzx  eax,WORD PTR [eax+0x22]
     a54:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
		while (ec--) {
     a58:	e9 87 00 00 00       	jmp    ae4 <mp_parse_config_table+0x241>
				switch (*(uint8_t*)e) {
     a5d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a60:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     a63:	0f b6 c0             	movzx  eax,al
     a66:	83 f8 04             	cmp    eax,0x4
     a69:	77 5e                	ja     ac9 <mp_parse_config_table+0x226>
     a6b:	8b 04 85 8c 03 00 00 	mov    eax,DWORD PTR [eax*4+0x38c]
     a72:	ff e0                	jmp    eax
						parse_processor_entry(e);
     a74:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a77:	89 04 24             	mov    DWORD PTR [esp],eax
     a7a:	e8 fc ff ff ff       	call   a7b <mp_parse_config_table+0x1d8>
						e += 20;
     a7f:	83 45 ec 14          	add    DWORD PTR [ebp-0x14],0x14
						break;
     a83:	eb 5f                	jmp    ae4 <mp_parse_config_table+0x241>
						parse_bus_entry(e);
     a85:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a88:	89 04 24             	mov    DWORD PTR [esp],eax
     a8b:	e8 fc ff ff ff       	call   a8c <mp_parse_config_table+0x1e9>
						e += 8;
     a90:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     a94:	eb 4e                	jmp    ae4 <mp_parse_config_table+0x241>
						parse_io_apic(e);
     a96:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a99:	89 04 24             	mov    DWORD PTR [esp],eax
     a9c:	e8 fc ff ff ff       	call   a9d <mp_parse_config_table+0x1fa>
						e += 8;
     aa1:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     aa5:	eb 3d                	jmp    ae4 <mp_parse_config_table+0x241>
						parse_io_interrupt(e);
     aa7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     aaa:	89 04 24             	mov    DWORD PTR [esp],eax
     aad:	e8 fc ff ff ff       	call   aae <mp_parse_config_table+0x20b>
						e += 8;
     ab2:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     ab6:	eb 2c                	jmp    ae4 <mp_parse_config_table+0x241>
						parse_local_interrupt(e);
     ab8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     abb:	89 04 24             	mov    DWORD PTR [esp],eax
     abe:	e8 fc ff ff ff       	call   abf <mp_parse_config_table+0x21c>
						e += 8;
     ac3:	83 45 ec 08          	add    DWORD PTR [ebp-0x14],0x8
						break;
     ac7:	eb 1b                	jmp    ae4 <mp_parse_config_table+0x241>
						cprintf(KFMT_WARN, "encountered an unknown entry in the MP table with unkown length. Further parsing is impossible.\n");
     ac9:	c7 44 24 04 28 03 00 00 	mov    DWORD PTR [esp+0x4],0x328
     ad1:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     ad8:	e8 fc ff ff ff       	call   ad9 <mp_parse_config_table+0x236>
						if (ec > 0) /* only ignore last entry */
     add:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     ae2:	75 1b                	jne    aff <mp_parse_config_table+0x25c>
		while (ec--) {
     ae4:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     ae8:	8d 50 ff             	lea    edx,[eax-0x1]
     aeb:	66 89 55 f2          	mov    WORD PTR [ebp-0xe],dx
     aef:	66 85 c0             	test   ax,ax
     af2:	0f 85 65 ff ff ff    	jne    a5d <mp_parse_config_table+0x1ba>
		mp_sanitize_table();
     af8:	e8 fc ff ff ff       	call   af9 <mp_parse_config_table+0x256>
     afd:	eb 01                	jmp    b00 <mp_parse_config_table+0x25d>
								goto cleanup;
     aff:	90                   	nop
		mm_unmap(&mm_kernel, mp, pr.count);
     b00:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b03:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     b07:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b0a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b0e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     b15:	e8 fc ff ff ff       	call   b16 <mp_parse_config_table+0x273>
}
     b1a:	c9                   	leave
     b1b:	c3                   	ret

00000b1c <set_fs_offset>:
{
     b1c:	55                   	push   ebp
     b1d:	89 e5                	mov    ebp,esp
     b1f:	53                   	push   ebx
     b20:	83 ec 14             	sub    esp,0x14
		uint32_t o = (uint32_t)ofs;
     b23:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b26:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
     b29:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b2c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     b2f:	8b 00                	mov    eax,DWORD PTR [eax]
     b31:	25 ff ff 00 00       	and    eax,0xffff
     b36:	81 e2 00 ff ff 00    	and    edx,0xffff00
     b3c:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     b3f:	c1 e1 10             	shl    ecx,0x10
     b42:	bb 00 00 00 00       	mov    ebx,0x0
     b47:	09 c1                	or     ecx,eax
     b49:	09 d3                	or     ebx,edx
				| ((uint64_t)(o & 0xff0000) << 16) | ((uint64_t)(o & 0xff000000) << 32);
     b4b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b4e:	ba 00 00 00 00       	mov    edx,0x0
     b53:	0f a4 c2 10          	shld   edx,eax,0x10
     b57:	c1 e0 10             	shl    eax,0x10
     b5a:	b8 00 00 00 00       	mov    eax,0x0
     b5f:	81 e2 ff 00 00 00    	and    edx,0xff
     b65:	09 c1                	or     ecx,eax
     b67:	09 d3                	or     ebx,edx
     b69:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b6c:	ba 00 00 00 00       	mov    edx,0x0
     b71:	89 c2                	mov    edx,eax
     b73:	31 c0                	xor    eax,eax
     b75:	b8 00 00 00 00       	mov    eax,0x0
     b7a:	81 e2 00 00 00 ff    	and    edx,0xff000000
     b80:	09 c8                	or     eax,ecx
     b82:	09 da                	or     edx,ebx
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
     b84:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     b87:	89 01                	mov    DWORD PTR [ecx],eax
     b89:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
     b8c:	90                   	nop
     b8d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     b90:	c9                   	leave
     b91:	c3                   	ret

00000b92 <update_fs>:
{
     b92:	55                   	push   ebp
     b93:	89 e5                	mov    ebp,esp
		asm volatile (
     b95:	66 b8 40 00          	mov    ax,0x40
     b99:	8e e0                	mov    fs,eax
}
     b9b:	90                   	nop
     b9c:	5d                   	pop    ebp
     b9d:	c3                   	ret

00000b9e <apic_get_base>:
{
     b9e:	55                   	push   ebp
     b9f:	89 e5                	mov    ebp,esp
     ba1:	53                   	push   ebx
     ba2:	83 ec 24             	sub    esp,0x24
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
     ba5:	8d 45 f0             	lea    eax,[ebp-0x10]
     ba8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     bac:	8d 45 f4             	lea    eax,[ebp-0xc]
     baf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     bb3:	c7 04 24 1b 00 00 00 	mov    DWORD PTR [esp],0x1b
     bba:	e8 fc ff ff ff       	call   bbb <apic_get_base+0x1d>
		return ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
     bbf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     bc2:	ba 00 00 00 00       	mov    edx,0x0
     bc7:	89 c2                	mov    edx,eax
     bc9:	31 c0                	xor    eax,eax
     bcb:	b8 00 00 00 00       	mov    eax,0x0
     bd0:	83 e2 0f             	and    edx,0xf
     bd3:	89 c1                	mov    ecx,eax
     bd5:	89 d3                	mov    ebx,edx
     bd7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bda:	ba 00 00 00 00       	mov    edx,0x0
     bdf:	25 00 f0 ff ff       	and    eax,0xfffff000
     be4:	ba 00 00 00 00       	mov    edx,0x0
     be9:	09 c8                	or     eax,ecx
     beb:	09 da                	or     edx,ebx
}
     bed:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     bf0:	c9                   	leave
     bf1:	c3                   	ret

00000bf2 <pcp_init>:
{
     bf2:	55                   	push   ebp
     bf3:	89 e5                	mov    ebp,esp
     bf5:	53                   	push   ebx
     bf6:	83 ec 34             	sub    esp,0x34
		pcp_data = mm_alloc_page(&pm);
     bf9:	8d 45 e8             	lea    eax,[ebp-0x18]
     bfc:	89 04 24             	mov    DWORD PTR [esp],eax
     bff:	e8 fc ff ff ff       	call   c00 <pcp_init+0xe>
     c04:	a3 00 00 00 00       	mov    ds:0x0,eax
		ap_stack = (void*)0x06000; // FM_AP_STACK top down (6->5)
     c09:	c7 05 00 00 00 00 00 60 00 00 	mov    DWORD PTR ds:0x0,0x6000
		ap_cr3 = mm_kernel.cr3;
     c13:	a1 00 00 00 00       	mov    eax,ds:0x0
     c18:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     c1e:	a3 00 00 00 00       	mov    ds:0x0,eax
     c23:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		if (cpu.has_pae)
     c29:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
     c30:	83 e0 40             	and    eax,0x40
     c33:	84 c0                	test   al,al
     c35:	74 09                	je     c40 <pcp_init+0x4e>
				ap_mode = 1;
     c37:	c6 05 00 00 00 00 01 	mov    BYTE PTR ds:0x0,0x1
     c3e:	eb 07                	jmp    c47 <pcp_init+0x55>
				ap_mode = 0;
     c40:	c6 05 00 00 00 00 00 	mov    BYTE PTR ds:0x0,0x0
		pcp_data[0] = pd = kmalloc(sizeof(struct processor_data));
     c47:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     c4e:	e8 fc ff ff ff       	call   c4f <pcp_init+0x5d>
     c53:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     c56:	a1 00 00 00 00       	mov    eax,ds:0x0
     c5b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     c5e:	89 10                	mov    DWORD PTR [eax],edx
		pcp_ofs++;
     c60:	a1 00 00 00 00       	mov    eax,ds:0x0
     c65:	83 c0 01             	add    eax,0x1
     c68:	a3 00 00 00 00       	mov    ds:0x0,eax
		pd->proc_index = 0;
     c6d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c70:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		pd->apic_id = apic_ids.bp_id;
     c76:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     c7c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c7f:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pd->apic_addr = bp_apic_base;
     c82:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     c88:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c8b:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pd->apic_phys = apic_get_base();
     c8e:	e8 fc ff ff ff       	call   c8f <pcp_init+0x9d>
     c93:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c96:	89 41 0c             	mov    DWORD PTR [ecx+0xc],eax
     c99:	89 51 10             	mov    DWORD PTR [ecx+0x10],edx
		pd->ticks = bp_tick;
     c9c:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     ca2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ca5:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pd->mm_ctx = mm_create_ctx();
     ca8:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
     cab:	8d 45 e0             	lea    eax,[ebp-0x20]
     cae:	89 04 24             	mov    DWORD PTR [esp],eax
     cb1:	e8 fc ff ff ff       	call   cb2 <pcp_init+0xc0>
     cb6:	83 ec 04             	sub    esp,0x4
     cb9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     cbc:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     cbf:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
     cc2:	89 53 1c             	mov    DWORD PTR [ebx+0x1c],edx
		set_fs_offset(pcp_data, (uint64_t*)(ap_gdtp + 0x40));
     cc5:	a1 00 00 00 00       	mov    eax,ds:0x0
     cca:	8d 50 40             	lea    edx,[eax+0x40]
     ccd:	a1 00 00 00 00       	mov    eax,ds:0x0
     cd2:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     cd6:	89 04 24             	mov    DWORD PTR [esp],eax
     cd9:	e8 fc ff ff ff       	call   cda <pcp_init+0xe8>
		update_fs();
     cde:	e8 fc ff ff ff       	call   cdf <pcp_init+0xed>
		asm volatile ("movl %%fs:0, %%eax" : "=a" (ptr));
     ce3:	64 a1 00 00 00 00    	mov    eax,fs:0x0
     ce9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (ptr != pd)
     cec:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cef:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
     cf2:	74 29                	je     d1d <pcp_init+0x12b>
				die("per-cpu data through fs/gs segment selector not working!\n");
     cf4:	c7 44 24 04 a0 03 00 00 	mov    DWORD PTR [esp+0x4],0x3a0
     cfc:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     d03:	e8 fc ff ff ff       	call   d04 <pcp_init+0x112>
     d08:	e8 fc ff ff ff       	call   d09 <pcp_init+0x117>
     d0d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     d14:	e8 fc ff ff ff       	call   d15 <pcp_init+0x123>
     d19:	fa                   	cli
     d1a:	f4                   	hlt
     d1b:	eb fd                	jmp    d1a <pcp_init+0x128>
}
     d1d:	90                   	nop
     d1e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     d21:	c9                   	leave
     d22:	c3                   	ret

00000d23 <get_cpu_data>:
{
     d23:	55                   	push   ebp
     d24:	89 e5                	mov    ebp,esp
		return pcp_data[smp_index];
     d26:	a1 00 00 00 00       	mov    eax,ds:0x0
     d2b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     d2e:	c1 e2 02             	shl    edx,0x2
     d31:	01 d0                	add    eax,edx
     d33:	8b 00                	mov    eax,DWORD PTR [eax]
}
     d35:	5d                   	pop    ebp
     d36:	c3                   	ret

00000d37 <launch_ap>:
{
     d37:	55                   	push   ebp
     d38:	89 e5                	mov    ebp,esp
     d3a:	57                   	push   edi
     d3b:	56                   	push   esi
     d3c:	53                   	push   ebx
     d3d:	83 ec 3c             	sub    esp,0x3c
		uint64_t ct = 10, timeout;
     d40:	c7 45 e0 0a 00 00 00 	mov    DWORD PTR [ebp-0x20],0xa
     d47:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		ap_start = ap_fail = 0;
     d4e:	b8 00 00 00 00       	mov    eax,0x0
     d53:	a2 00 00 00 00       	mov    ds:0x0,al
     d58:	a2 00 00 00 00       	mov    ds:0x0,al
		if (pcp_ofs >= 1023) {
     d5d:	a1 00 00 00 00       	mov    eax,ds:0x0
     d62:	3d fe 03 00 00       	cmp    eax,0x3fe
     d67:	76 1e                	jbe    d87 <launch_ap+0x50>
				cprintf(KFMT_WARN, "cpu-data limit reached, skipping processors.\n");
     d69:	c7 44 24 04 dc 03 00 00 	mov    DWORD PTR [esp+0x4],0x3dc
     d71:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     d78:	e8 fc ff ff ff       	call   d79 <launch_ap+0x42>
				return -1;
     d7d:	b8 ff ff ff ff       	mov    eax,0xffffffff
     d82:	e9 ff 02 00 00       	jmp    1086 <launch_ap+0x34f>
		preempt_disable();
     d87:	e8 fc ff ff ff       	call   d88 <launch_ap+0x51>
     d8c:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     d8f:	83 c2 01             	add    edx,0x1
     d92:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		pcp_data[pcp_ofs] = pd = kzalloc(sizeof(struct processor_data));
     d95:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     d9c:	e8 fc ff ff ff       	call   d9d <launch_ap+0x66>
     da1:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     da4:	a1 00 00 00 00       	mov    eax,ds:0x0
     da9:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     daf:	c1 e2 02             	shl    edx,0x2
     db2:	01 c2                	add    edx,eax
     db4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     db7:	89 02                	mov    DWORD PTR [edx],eax
		pd->apic_id = id;
     db9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     dbc:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     dbf:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		pd->apic_addr = bp_apic_base - 4096;
     dc2:	a1 00 00 00 00       	mov    eax,ds:0x0
     dc7:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
     dcd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     dd0:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pd->apic_phys = 0;
     dd3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     dd6:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
     ddd:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		pd->proc_index = pcp_ofs;
     de4:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     dea:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     ded:	89 10                	mov    DWORD PTR [eax],edx
		pd->ticks = kzalloc(sizeof(struct perf_ctrs));
     def:	c7 04 24 50 00 00 00 	mov    DWORD PTR [esp],0x50
     df6:	e8 fc ff ff ff       	call   df7 <launch_ap+0xc0>
     dfb:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     dfe:	89 42 14             	mov    DWORD PTR [edx+0x14],eax
		ap_gdtp = kmalloc(GDT_SIZE);
     e01:	c7 04 24 50 00 00 00 	mov    DWORD PTR [esp],0x50
     e08:	e8 fc ff ff ff       	call   e09 <launch_ap+0xd2>
     e0d:	a3 00 00 00 00       	mov    ds:0x0,eax
		memcpy(ap_gdtp, &gdt, GDT_SIZE);
     e12:	a1 00 00 00 00       	mov    eax,ds:0x0
     e17:	c7 44 24 08 50 00 00 00 	mov    DWORD PTR [esp+0x8],0x50
     e1f:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     e27:	89 04 24             	mov    DWORD PTR [esp],eax
     e2a:	e8 04 f2 ff ff       	call   33 <memcpy>
		set_fs_offset(pcp_data + pcp_ofs, (uint64_t*)(ap_gdtp + SEG_DATA_PROC));
     e2f:	a1 00 00 00 00       	mov    eax,ds:0x0
     e34:	8d 50 40             	lea    edx,[eax+0x40]
     e37:	a1 00 00 00 00       	mov    eax,ds:0x0
     e3c:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     e42:	c1 e1 02             	shl    ecx,0x2
     e45:	01 c8                	add    eax,ecx
     e47:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     e4b:	89 04 24             	mov    DWORD PTR [esp],eax
     e4e:	e8 fc ff ff ff       	call   e4f <launch_ap+0x118>
		apic_reg(APIC_REG_ESR) = 0;
     e53:	e8 a8 f1 ff ff       	call   0 <per_cpu_ptr>
     e58:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e5b:	05 80 02 00 00       	add    eax,0x280
     e60:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		apic_reg(APIC_REG_ICRH) = id;
     e66:	e8 95 f1 ff ff       	call   0 <per_cpu_ptr>
     e6b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e6e:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
     e74:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e77:	89 02                	mov    DWORD PTR [edx],eax
		apic_reg(APIC_REG_ICRL) = 0x0000c500; /* edge assert level init */
     e79:	e8 82 f1 ff ff       	call   0 <per_cpu_ptr>
     e7e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e81:	05 00 03 00 00       	add    eax,0x300
     e86:	c7 00 00 c5 00 00    	mov    DWORD PTR [eax],0xc500
		while (apic_reg(APIC_REG_ICRL) & (1 << 12)); /* send pending */
     e8c:	90                   	nop
     e8d:	e8 6e f1 ff ff       	call   0 <per_cpu_ptr>
     e92:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e95:	05 00 03 00 00       	add    eax,0x300
     e9a:	8b 00                	mov    eax,DWORD PTR [eax]
     e9c:	25 00 10 00 00       	and    eax,0x1000
     ea1:	85 c0                	test   eax,eax
     ea3:	75 e8                	jne    e8d <launch_ap+0x156>
		mdelay(20);
     ea5:	c7 04 24 14 00 00 00 	mov    DWORD PTR [esp],0x14
     eac:	e8 fc ff ff ff       	call   ead <launch_ap+0x176>
		apic_reg(APIC_REG_ICRH) = id;
     eb1:	e8 4a f1 ff ff       	call   0 <per_cpu_ptr>
     eb6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     eb9:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
     ebf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ec2:	89 02                	mov    DWORD PTR [edx],eax
		apic_reg(APIC_REG_ICRL) = 0x00008500; /* edge de-assert init */
     ec4:	e8 37 f1 ff ff       	call   0 <per_cpu_ptr>
     ec9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ecc:	05 00 03 00 00       	add    eax,0x300
     ed1:	c7 00 00 85 00 00    	mov    DWORD PTR [eax],0x8500
		while (apic_reg(APIC_REG_ICRL) & (1 << 12));
     ed7:	90                   	nop
     ed8:	e8 23 f1 ff ff       	call   0 <per_cpu_ptr>
     edd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ee0:	05 00 03 00 00       	add    eax,0x300
     ee5:	8b 00                	mov    eax,DWORD PTR [eax]
     ee7:	25 00 10 00 00       	and    eax,0x1000
     eec:	85 c0                	test   eax,eax
     eee:	75 e8                	jne    ed8 <launch_ap+0x1a1>
		timeout = jiffies + HZ * ct / 1000;
     ef0:	a1 00 00 00 00       	mov    eax,ds:0x0
     ef5:	8b 30                	mov    esi,DWORD PTR [eax]
     ef7:	8b 78 04             	mov    edi,DWORD PTR [eax+0x4]
     efa:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     efd:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     f00:	89 c8                	mov    eax,ecx
     f02:	89 da                	mov    edx,ebx
     f04:	0f a4 c2 04          	shld   edx,eax,0x4
     f08:	c1 e0 04             	shl    eax,0x4
     f0b:	29 c8                	sub    eax,ecx
     f0d:	19 da                	sbb    edx,ebx
     f0f:	0f a4 c2 03          	shld   edx,eax,0x3
     f13:	c1 e0 03             	shl    eax,0x3
     f16:	01 c8                	add    eax,ecx
     f18:	11 da                	adc    edx,ebx
     f1a:	c7 44 24 08 e8 03 00 00 	mov    DWORD PTR [esp+0x8],0x3e8
     f22:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
     f2a:	89 04 24             	mov    DWORD PTR [esp],eax
     f2d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     f31:	e8 fc ff ff ff       	call   f32 <launch_ap+0x1fb>
     f36:	01 f0                	add    eax,esi
     f38:	11 fa                	adc    edx,edi
     f3a:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     f3d:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		apic_reg(APIC_REG_ESR) = 0;
     f40:	e8 bb f0 ff ff       	call   0 <per_cpu_ptr>
     f45:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f48:	05 80 02 00 00       	add    eax,0x280
     f4d:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		apic_reg(APIC_REG_ICRH) = id;
     f53:	e8 a8 f0 ff ff       	call   0 <per_cpu_ptr>
     f58:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f5b:	8d 90 10 03 00 00    	lea    edx,[eax+0x310]
     f61:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f64:	89 02                	mov    DWORD PTR [edx],eax
		apic_reg(APIC_REG_ICRL) = 0x00004600 | 6; /* pseudo-vector 6 <-> 0x6000 */
     f66:	e8 95 f0 ff ff       	call   0 <per_cpu_ptr>
     f6b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f6e:	05 00 03 00 00       	add    eax,0x300
     f73:	c7 00 06 46 00 00    	mov    DWORD PTR [eax],0x4606
		while (!ap_start)
     f79:	eb 18                	jmp    f93 <launch_ap+0x25c>
				if (time_after(jiffies, timeout))
     f7b:	a1 00 00 00 00       	mov    eax,ds:0x0
     f80:	8b 08                	mov    ecx,DWORD PTR [eax]
     f82:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     f85:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f88:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     f8b:	29 c8                	sub    eax,ecx
     f8d:	19 da                	sbb    edx,ebx
     f8f:	85 d2                	test   edx,edx
     f91:	78 0d                	js     fa0 <launch_ap+0x269>
		while (!ap_start)
     f93:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     f9a:	84 c0                	test   al,al
     f9c:	74 dd                	je     f7b <launch_ap+0x244>
     f9e:	eb 01                	jmp    fa1 <launch_ap+0x26a>
						break;
     fa0:	90                   	nop
		if (!ap_start && ct < 1000) {
     fa1:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     fa8:	84 c0                	test   al,al
     faa:	75 36                	jne    fe2 <launch_ap+0x2ab>
     fac:	ba e7 03 00 00       	mov    edx,0x3e7
     fb1:	b8 00 00 00 00       	mov    eax,0x0
     fb6:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
     fb9:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
     fbc:	72 24                	jb     fe2 <launch_ap+0x2ab>
				ct *= 10; /* 1000ms */
     fbe:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     fc1:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     fc4:	89 c8                	mov    eax,ecx
     fc6:	89 da                	mov    edx,ebx
     fc8:	0f a4 c2 02          	shld   edx,eax,0x2
     fcc:	c1 e0 02             	shl    eax,0x2
     fcf:	01 c8                	add    eax,ecx
     fd1:	11 da                	adc    edx,ebx
     fd3:	01 c0                	add    eax,eax
     fd5:	11 d2                	adc    edx,edx
     fd7:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     fda:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				goto resend;
     fdd:	e9 0e ff ff ff       	jmp    ef0 <launch_ap+0x1b9>
		if (!ap_start)
     fe2:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     fe9:	84 c0                	test   al,al
     feb:	74 57                	je     1044 <launch_ap+0x30d>
		while (ap_start); /* trampoline is in use */
     fed:	90                   	nop
     fee:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     ff5:	84 c0                	test   al,al
     ff7:	75 f5                	jne    fee <launch_ap+0x2b7>
		if (ap_fail)
     ff9:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    1000:	84 c0                	test   al,al
    1002:	75 43                	jne    1047 <launch_ap+0x310>
		pcp_ofs++;
    1004:	a1 00 00 00 00       	mov    eax,ds:0x0
    1009:	83 c0 01             	add    eax,0x1
    100c:	a3 00 00 00 00       	mov    ds:0x0,eax
		bp_apic_base = pd->apic_addr; /* decrement next allocation base */
    1011:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1014:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1017:	a3 00 00 00 00       	mov    ds:0x0,eax
		preempt_enable();
    101c:	e8 fc ff ff ff       	call   101d <launch_ap+0x2e6>
    1021:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    1024:	83 ea 01             	sub    edx,0x1
    1027:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    102a:	e8 fc ff ff ff       	call   102b <launch_ap+0x2f4>
    102f:	8b 00                	mov    eax,DWORD PTR [eax]
    1031:	83 e0 01             	and    eax,0x1
    1034:	85 c0                	test   eax,eax
    1036:	74 05                	je     103d <launch_ap+0x306>
    1038:	e8 fc ff ff ff       	call   1039 <launch_ap+0x302>
		return 0;
    103d:	b8 00 00 00 00       	mov    eax,0x0
    1042:	eb 42                	jmp    1086 <launch_ap+0x34f>
				goto failure;
    1044:	90                   	nop
    1045:	eb 01                	jmp    1048 <launch_ap+0x311>
				goto failure;
    1047:	90                   	nop
		kfree(ap_gdtp);
    1048:	a1 00 00 00 00       	mov    eax,ds:0x0
    104d:	89 04 24             	mov    DWORD PTR [esp],eax
    1050:	e8 fc ff ff ff       	call   1051 <launch_ap+0x31a>
		kfree(pd);
    1055:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1058:	89 04 24             	mov    DWORD PTR [esp],eax
    105b:	e8 fc ff ff ff       	call   105c <launch_ap+0x325>
		preempt_enable();
    1060:	e8 fc ff ff ff       	call   1061 <launch_ap+0x32a>
    1065:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    1068:	83 ea 01             	sub    edx,0x1
    106b:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    106e:	e8 fc ff ff ff       	call   106f <launch_ap+0x338>
    1073:	8b 00                	mov    eax,DWORD PTR [eax]
    1075:	83 e0 01             	and    eax,0x1
    1078:	85 c0                	test   eax,eax
    107a:	74 05                	je     1081 <launch_ap+0x34a>
    107c:	e8 fc ff ff ff       	call   107d <launch_ap+0x346>
		return -1;
    1081:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    1086:	83 c4 3c             	add    esp,0x3c
    1089:	5b                   	pop    ebx
    108a:	5e                   	pop    esi
    108b:	5f                   	pop    edi
    108c:	5d                   	pop    ebp
    108d:	c3                   	ret

0000108e <imcr_pic_to_apic>:
{
    108e:	55                   	push   ebp
    108f:	89 e5                	mov    ebp,esp
    1091:	83 ec 08             	sub    esp,0x8
		outb(0x70, 0x22);
    1094:	c7 44 24 04 22 00 00 00 	mov    DWORD PTR [esp+0x4],0x22
    109c:	c7 04 24 70 00 00 00 	mov    DWORD PTR [esp],0x70
    10a3:	e8 6c ef ff ff       	call   14 <outb>
		outb(0x01, 0x23);
    10a8:	c7 44 24 04 23 00 00 00 	mov    DWORD PTR [esp+0x4],0x23
    10b0:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
    10b7:	e8 58 ef ff ff       	call   14 <outb>
}
    10bc:	90                   	nop
    10bd:	c9                   	leave
    10be:	c3                   	ret

000010bf <imcr_apic_to_pic>:
{
    10bf:	55                   	push   ebp
    10c0:	89 e5                	mov    ebp,esp
    10c2:	83 ec 08             	sub    esp,0x8
		outb(0x70, 0x22);
    10c5:	c7 44 24 04 22 00 00 00 	mov    DWORD PTR [esp+0x4],0x22
    10cd:	c7 04 24 70 00 00 00 	mov    DWORD PTR [esp],0x70
    10d4:	e8 3b ef ff ff       	call   14 <outb>
		outb(0x00, 0x23);
    10d9:	c7 44 24 04 23 00 00 00 	mov    DWORD PTR [esp+0x4],0x23
    10e1:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    10e8:	e8 27 ef ff ff       	call   14 <outb>
}
    10ed:	90                   	nop
    10ee:	c9                   	leave
    10ef:	c3                   	ret

000010f0 <ioapic_init>:
{
    10f0:	55                   	push   ebp
    10f1:	89 e5                	mov    ebp,esp
    10f3:	83 ec 28             	sub    esp,0x28
		struct io_apic* io = io_apics;
    10f6:	a1 00 00 00 00       	mov    eax,ds:0x0
    10fb:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (imcr)
    10fe:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1102:	74 2b                	je     112f <ioapic_init+0x3f>
				imcr_pic_to_apic();
    1104:	e8 fc ff ff ff       	call   1105 <ioapic_init+0x15>
		while (io) {
    1109:	eb 24                	jmp    112f <ioapic_init+0x3f>
				init_ioapic(io->id, io->addr);
    110b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    110e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1111:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1114:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1117:	0f b6 c0             	movzx  eax,al
    111a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    111e:	89 04 24             	mov    DWORD PTR [esp],eax
    1121:	e8 fc ff ff ff       	call   1122 <ioapic_init+0x32>
				io = io->next;
    1126:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1129:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    112c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (io) {
    112f:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1133:	75 d6                	jne    110b <ioapic_init+0x1b>
}
    1135:	90                   	nop
    1136:	90                   	nop
    1137:	c9                   	leave
    1138:	c3                   	ret

00001139 <mp_init>:
{
    1139:	55                   	push   ebp
    113a:	89 e5                	mov    ebp,esp
    113c:	83 ec 28             	sub    esp,0x28
		struct apid* id = apic_ids.ap_ids;
    113f:	a1 04 00 00 00       	mov    eax,ds:0x4
    1144:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		pcp_init();
    1147:	e8 fc ff ff ff       	call   1148 <mp_init+0xf>
		while (id) {
    114c:	eb 78                	jmp    11c6 <mp_init+0x8d>
				printf("attempting to start AP %x\n", id->ap_id);
    114e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1151:	8b 00                	mov    eax,DWORD PTR [eax]
    1153:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1157:	c7 04 24 0a 04 00 00 	mov    DWORD PTR [esp],0x40a
    115e:	e8 fc ff ff ff       	call   115f <mp_init+0x26>
				if (launch_ap(id->ap_id) == 0) {
    1163:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1166:	8b 00                	mov    eax,DWORD PTR [eax]
    1168:	89 04 24             	mov    DWORD PTR [esp],eax
    116b:	e8 fc ff ff ff       	call   116c <mp_init+0x33>
    1170:	85 c0                	test   eax,eax
    1172:	75 2c                	jne    11a0 <mp_init+0x67>
						cprintf(KFMT_OK, "started AP %08x successfully\n", id->ap_id);
    1174:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1177:	8b 00                	mov    eax,DWORD PTR [eax]
    1179:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    117d:	c7 44 24 04 25 04 00 00 	mov    DWORD PTR [esp+0x4],0x425
    1185:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    118c:	e8 fc ff ff ff       	call   118d <mp_init+0x54>
						nproc++;
    1191:	a1 00 00 00 00       	mov    eax,ds:0x0
    1196:	83 c0 01             	add    eax,0x1
    1199:	a3 00 00 00 00       	mov    ds:0x0,eax
    119e:	eb 1d                	jmp    11bd <mp_init+0x84>
						cprintf(KFMT_WARN, "AP %08x refused to start\n", id->ap_id);
    11a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11a3:	8b 00                	mov    eax,DWORD PTR [eax]
    11a5:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    11a9:	c7 44 24 04 43 04 00 00 	mov    DWORD PTR [esp+0x4],0x443
    11b1:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    11b8:	e8 fc ff ff ff       	call   11b9 <mp_init+0x80>
				id = id->next;
    11bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11c0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    11c3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (id) {
    11c6:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    11ca:	75 82                	jne    114e <mp_init+0x15>
		ioapic_init(imcr);
    11cc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11cf:	89 04 24             	mov    DWORD PTR [esp],eax
    11d2:	e8 fc ff ff ff       	call   11d3 <mp_init+0x9a>
		return (nproc > 1) ? 0 : -1;
    11d7:	a1 00 00 00 00       	mov    eax,ds:0x0
    11dc:	83 f8 01             	cmp    eax,0x1
    11df:	76 07                	jbe    11e8 <mp_init+0xaf>
    11e1:	b8 00 00 00 00       	mov    eax,0x0
    11e6:	eb 05                	jmp    11ed <mp_init+0xb4>
    11e8:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
    11ed:	c9                   	leave
    11ee:	c3                   	ret

000011ef <mp_entry>:
{
    11ef:	55                   	push   ebp
    11f0:	89 e5                	mov    ebp,esp
    11f2:	83 ec 28             	sub    esp,0x28
		struct mp_fps* fps = find_mp_fps();
    11f5:	e8 fc ff ff ff       	call   11f6 <mp_entry+0x7>
    11fa:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (fps) {
    11fd:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1201:	0f 84 15 01 00 00    	je     131c <mp_entry+0x12d>
				printf("This machine conforms to the MP specification version 1.%u\n", (uint32_t)fps->spec_rev);
    1207:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    120a:	0f b6 40 09          	movzx  eax,BYTE PTR [eax+0x9]
    120e:	0f b6 c0             	movzx  eax,al
    1211:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1215:	c7 04 24 60 04 00 00 	mov    DWORD PTR [esp],0x460
    121c:	e8 fc ff ff ff       	call   121d <mp_entry+0x2e>
				if (!fps->features[0]) { /* table present */
    1221:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1224:	0f b6 40 0b          	movzx  eax,BYTE PTR [eax+0xb]
    1228:	84 c0                	test   al,al
    122a:	75 1e                	jne    124a <mp_entry+0x5b>
						printf("It has a MP configuration table at %p\n", ptr = mp2ptr(fps->mp_config));
    122c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    122f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1232:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1235:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1238:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    123c:	c7 04 24 9c 04 00 00 	mov    DWORD PTR [esp],0x49c
    1243:	e8 fc ff ff ff       	call   1244 <mp_entry+0x55>
    1248:	eb 65                	jmp    12af <mp_entry+0xc0>
								"Therefore there is no MP configuration table expected. (%p)\n", ptr = mp2ptr(fps->mp_config));
    124a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    124d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
						printf("It uses a default MP configuration defined by feature bits. "
    1250:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1253:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1256:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    125a:	c7 04 24 c4 04 00 00 	mov    DWORD PTR [esp],0x4c4
    1261:	e8 fc ff ff ff       	call   1262 <mp_entry+0x73>
						printf("The default configuration has ID %u\n", fps->features[0]);
    1266:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1269:	0f b6 40 0b          	movzx  eax,BYTE PTR [eax+0xb]
    126d:	0f b6 c0             	movzx  eax,al
    1270:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1274:	c7 04 24 40 05 00 00 	mov    DWORD PTR [esp],0x540
    127b:	e8 fc ff ff ff       	call   127c <mp_entry+0x8d>
						if (!ptr)
    1280:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1284:	75 15                	jne    129b <mp_entry+0xac>
								ptr = build_configuration_table_from_default(fps->features[0]);
    1286:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1289:	0f b6 40 0b          	movzx  eax,BYTE PTR [eax+0xb]
    128d:	0f b6 c0             	movzx  eax,al
    1290:	89 04 24             	mov    DWORD PTR [esp],eax
    1293:	e8 fc ff ff ff       	call   1294 <mp_entry+0xa5>
    1298:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!ptr) {
    129b:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    129f:	75 0e                	jne    12af <mp_entry+0xc0>
								printf("and is unrecognized, resulting in UP init.\n");
    12a1:	c7 04 24 68 05 00 00 	mov    DWORD PTR [esp],0x568
    12a8:	e8 fc ff ff ff       	call   12a9 <mp_entry+0xba>
								return;
    12ad:	eb 79                	jmp    1328 <mp_entry+0x139>
				mp_parse_config_table(ptr);
    12af:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12b2:	89 04 24             	mov    DWORD PTR [esp],eax
    12b5:	e8 fc ff ff ff       	call   12b6 <mp_entry+0xc7>
				cprintf(KFMT_INFO, "attempting MP init...\n");
    12ba:	c7 44 24 04 94 05 00 00 	mov    DWORD PTR [esp+0x4],0x594
    12c2:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    12c9:	e8 fc ff ff ff       	call   12ca <mp_entry+0xdb>
				if (mp_init(!!(fps->features[1] & 0x80)))
    12ce:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    12d1:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    12d5:	c0 e8 07             	shr    al,0x7
    12d8:	0f b6 c0             	movzx  eax,al
    12db:	89 04 24             	mov    DWORD PTR [esp],eax
    12de:	e8 fc ff ff ff       	call   12df <mp_entry+0xf0>
    12e3:	85 c0                	test   eax,eax
    12e5:	74 16                	je     12fd <mp_entry+0x10e>
						cprintf(KFMT_WARN, "MP init failed continuing with UP.\n");
    12e7:	c7 44 24 04 ac 05 00 00 	mov    DWORD PTR [esp+0x4],0x5ac
    12ef:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    12f6:	e8 fc ff ff ff       	call   12f7 <mp_entry+0x108>
    12fb:	eb 2b                	jmp    1328 <mp_entry+0x139>
						cprintf(KFMT_OK, "MP init successful, now there are %u processors active.\n", nproc);
    12fd:	a1 00 00 00 00       	mov    eax,ds:0x0
    1302:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1306:	c7 44 24 04 d0 05 00 00 	mov    DWORD PTR [esp+0x4],0x5d0
    130e:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    1315:	e8 fc ff ff ff       	call   1316 <mp_entry+0x127>
    131a:	eb 0c                	jmp    1328 <mp_entry+0x139>
				printf("This machine does not conform to the MP specification but "
    131c:	c7 04 24 0c 06 00 00 	mov    DWORD PTR [esp],0x60c
    1323:	e8 fc ff ff ff       	call   1324 <mp_entry+0x135>
}
    1328:	c9                   	leave
    1329:	c3                   	ret
