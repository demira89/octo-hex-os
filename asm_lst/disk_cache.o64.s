
disk_cache.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <create_disk_cache>:
		uint64_t num_dirty_pages; /* until flush */
		uint64_t num_locked_pages; /* for mmap */
};

struct disk_cache* create_disk_cache(struct disk_geometry* gm)
{
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 20          	sub    rsp,0x20
   8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct disk_cache* rv = kzalloc(sizeof(*rv));
   c:	bf 38 00 00 00       	mov    edi,0x38
  11:	e8 00 00 00 00       	call   16 <create_disk_cache+0x16>
  16:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
}
  1a:	90                   	nop
  1b:	c9                   	leave
  1c:	c3                   	ret
