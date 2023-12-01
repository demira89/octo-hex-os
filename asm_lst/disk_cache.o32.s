
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
   3:	83 ec 18             	sub    esp,0x18
		struct disk_cache* rv = kzalloc(sizeof(*rv));
   6:	83 ec 0c             	sub    esp,0xc
   9:	6a 28                	push   0x28
   b:	e8 fc ff ff ff       	call   c <create_disk_cache+0xc>
  10:	83 c4 10             	add    esp,0x10
  13:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
}
  16:	90                   	nop
  17:	c9                   	leave
  18:	c3                   	ret
