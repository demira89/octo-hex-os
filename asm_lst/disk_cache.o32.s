
disk_cache.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <create_disk_cache>:
		uint64_t num_dirty_pages; /* until flush */
		uint64_t num_locked_pages; /* for mmap */
};

struct disk_cache* create_disk_cache(struct disk_geometry* gm)
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 28             	sub    esp,0x28
		struct disk_cache* rv = kzalloc(sizeof(*rv));
   6:	c7 04 24 28 00 00 00 	mov    DWORD PTR [esp],0x28
   d:	e8 fc ff ff ff       	call   e <create_disk_cache+0xe>
  12:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
}
  15:	90                   	nop
  16:	c9                   	leave
  17:	c3                   	ret
