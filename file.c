/* file.c : Implements the basic file support
 * */

#include "limits.h"
#include "kernel.h"
#include "file.h"
#include "module.h"

/* filesystem hierachy 
 * - directory/file/link
 * - implement ls etc. open/read/fcntl & lock file
 *   */

static struct dd_drs
{
		struct device_desc descs[8];
		struct dd_drs* next;
} dr0;
dev_t register_device(struct device_desc* dd)
{
		dev_t rv = 0; size_t i = 0;
		struct dd_drs* dr = &dr0;

		/* find a free slot */
		while (1) {
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
						break;
				i++; rv++;
				if (i == 8) {
						if (!dr->next) {
								struct dd_drs* dr2 = kmalloc(sizeof(struct dd_drs));
								if (!dr2) {
										errno = ENOMEM;
										return INVALID_DEVICE;
								}
								dr2->next = NULL;
								for (i = 0; i < 8; i++)
										dr2->descs[i].type = 0;
								if (!__sync_bool_compare_and_swap(&dr->next, NULL, dr2))
										kfree(dr2); /* someone was faster */
						}
						i = 0;
						dr = dr->next;
				}
		}

		/* found a slot so use it */
		dr->descs[i] = *dd;
		if(dd->fn_reg_dev(rv)) {
				dr->descs[i].type = 0;
				return INVALID_DEVICE;
		}
		return rv;
}

int unregister_device(dev_t dev)
{
		struct dd_drs* dr = &dr0;
		while (1) {
				if (dev >= 8) {
						dr = dr->next;
						dr -= 8;
						if (!dr) {
								errno = EINVAL;
								return -1;
						}
				} else {
						int rv;
						if (!dr->descs[dev].type) {
								errno = EINVAL;
								return -1;
						}
						rv = dr->descs[dev].fn_unreg_dev();
						if (!rv) {
								dr->descs[dev].type = 0;
								return 0;
						} else
								return rv;
				}
		}
}

const struct device_desc* get_device(dev_t dev)
{
		struct dd_drs* dr = &dr0;
		while (1) {
				if (dev >= 8) {
						dr = dr->next;
						dr -= 8;
						if (!dr) {
								errno = EINVAL;
								return NULL;
						}
				} else {
						if (!dr->descs[dev].type)
								return NULL;
						return dr->descs + dev;
				}
		}
		return NULL;
}

/* file descriptor storage */
static struct fil_fdc
{
		struct fil_fd fds[64];
		struct fil_fdc* next;
} fdc0;

struct fil_fd* fil_fd_get(int fd)
{
		struct fil_fdc* f = &fdc0;
		while (fd >= 64) {
				fd -= 64;
				f = f->next;
				if (!f)
						return NULL;
		}
		return &f->fds[fd];
}

struct fil_fd* fil_fd_allocate(struct inode* in, int* pfd)
{
		struct fil_fdc* fdc = &fdc0;
		int rv = 0; size_t i;
		while (1) {
				for (i = 0; i < 64; i++) {
						if (__sync_bool_compare_and_swap(&fdc->fds[i].in, NULL, in)) {
								*pfd = rv + i;
								return &fdc->fds[i];
						}
				}
				rv += 64;
				if (!fdc->next) {
						struct fil_fdc* f2 = fdc->next = (struct fil_fdc*)kmalloc(sizeof(struct fil_fdc));
						if (!f2) {
								errno = ENOMEM;
								return NULL;
						}
						f2->next = NULL;
						for (i = 0; i < 64; i++)
								f2->fds[i].in = NULL;
						if (!__sync_bool_compare_and_swap(&fdc->next, NULL, f2))
								kfree(f2); /* someone was faster */
				}
				fdc = fdc->next;
		}
		return NULL;
}

void fil_fd_free(int fd)
{
		struct fil_fdc* fdc = &fdc0;
		while (1) {
				if (fd >= 64) {
						fdc = fdc->next;
						fd -= 64;
						if (!fdc)
								return;
				} else {
						if (fdc->fds[fd].in) {
								fdc->fds[fd].in = NULL;
								return;
						} else
								return;
				}
		}
}

/* TODO: rewrite to ahci-port like CI bitfields with fast checks.
 * if(~bf) -> multiple levels, parallelized on higher levels, etc.,
 * maybe use 32 leaves tree with ever-increasing depth. */
/* keep the inodes here */
static struct fil_inc
{
		struct inode inodes[64];
		struct fil_inc* next;
} inc0 = {{}, 0}; static uint64_t ino_ct = 0;
/* ino0 is the root where fn_... will be performed on */
struct inode* ino_allocate(int init) /* nlink=0 */
{
		struct fil_inc* fi = &inc0; ino_t val = 1;
		while (1) {
				struct inode* in = fi->inodes;
				do {
						if (__sync_bool_compare_and_swap(&in->in_stat.st_ino, 0, val)) {
								/* found some space */
								/*in->in_stat.st_ino = val;*/
								in->in_stat.st_nlink = 0;
								/* C99 anonymous intermediate rwlock_t{} */
								in->in_lock = (rwlock_t)RW_LOCK_UNLOCKED;
								bzero(in->in_ddat, sizeof(in->in_ddat));
								if (init) {
										/* TODO: umask */
										in->in_stat.st_uid = 0;
										in->in_stat.st_gid = 0;
										/* 0755 drwxr-xr-x */
										in->in_stat.st_mode = init | S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH;
										clock_gettime(CLOCK_REALTIME, &in->in_stat.st_ctim);
										in->in_stat.st_mtim = in->in_stat.st_atim
												= in->in_stat.st_ctim;
								}
								__sync_fetch_and_add(&ino_ct, 1);
								return in;
						}
						val++;
				} while ((void*)(in++) != (void*)(&fi->next));
				if (!fi->next) {
						struct fil_inc* fi2 = kmalloc(sizeof(struct fil_inc));
						if (!fi2) {
								errno = ENOMEM;
								return NULL;
						}
						bzero(fi2, sizeof(*fi2));
						if (!__sync_bool_compare_and_swap(&fi->next, NULL, fi2)) {
								/* someone already succeeded */
								kfree(fi2);
						}
				}
		}
		return NULL;
}

int ino_release(struct inode* ino)
{
		ino->in_stat.st_ino = 0;
		/* TODO: Inode cleanup? (empty tables?) */
		return __sync_fetch_and_sub(&ino_ct, 1);
}

/************************* MEMDEV *************************/
/* do we want to map it all? or use memory windows? */
/* use the storage provided by the inodes */
/* one device with many files */
/* names are only saved in directory entries: root has no name like all "real" files */
struct memdev_data
{
		dev_t id;
		struct memdev_node** nodes; /* never moves in memory -> no lock */
		size_t node_ct;
		size_t node_cap_bts;
		void* heap;
} *memdev_data = NULL;
struct memdev_node
{
		mode_t file; /* S_IFMT */
		size_t size;
		size_t cap;
		/* PMEM/MAP details follow hereafter */
		struct inode* ino;
		char data[0];
};
struct memdev_node** memdev_store_node(struct memdev_node* n)
{
		struct memdev_node** ns = memdev_data->nodes;
		size_t i;
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
				if (__sync_bool_compare_and_swap(&ns[i], NULL, n))
						return &ns[i]; /* stored */
				if (i == memdev_data->node_cap_bts - 2) { /* next is ptr */
						if (ns[++i])
								ns = (struct memdev_node**)ns[i];
						else { /* alloc and cmpxchg */
								struct memdev_node** ns2;
								ns2 = h_malloc(memdev_data->heap,
									memdev_data->node_cap_bts * sizeof(struct memdev_node*));
								if (!ns2) /* OOM */
										return NULL;
								bzero(ns2, memdev_data->node_cap_bts * sizeof(struct memdev_node*));
								/* now cmpxchg */
								if (!__sync_bool_compare_and_swap(&ns[i], NULL, ns2)) {
										/* someone was faster */
										h_free(memdev_data->heap, ns2);
										ns = (struct memdev_node**)ns[i];
								} else /* we won */
										ns = ns2;
						}
						i = 0;
				}
		}
		return NULL;
}
int memdev_register(dev_t d)
{
		void* ptr;
		memdev_data = (struct memdev_data*)kmalloc(sizeof(struct memdev_data));
		if (!memdev_data)
				return -1;
		memdev_data->id = d;
		memdev_data->node_ct = 0;
		memdev_data->node_cap_bts = 4096;
		memdev_data->heap = mm_alloc_vmem(&mm_kernel, NULL, 25,
						MMGR_MAP_KERNEL | MMGR_MAP_WRITE);
		if (!memdev_data->heap) {
				kfree(memdev_data);
				return -1;
		}
		ptr = h_create_heap(memdev_data->heap, 25 * 4096, h_generic_oom_handler, h_generic_decommit);
		if (!ptr) {
				mm_free_vmem(&mm_kernel, memdev_data->heap, 25);
				kfree(memdev_data);
				return -1;
		}
		memdev_data->heap = ptr;
		memdev_data->nodes = h_malloc(ptr, 4096 * sizeof(struct memdev_node*));
		if (!memdev_data->nodes) {
				h_destroy(ptr);
				kfree(memdev_data);
				return -1;
		}
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
		return 0;
}

int memdev_unregister()
{
		errno = ENOSYS;
		return -1;
}

/* mode only on O_CREAT which is done externally */
int memdev_open(struct inode* in, int flags/*, mode_t mod*/)
{
		struct fil_fd* fd; int rv;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
				errno = EINVAL;
				return -1;
		}

		/* access checks are done on the level above */
		fd = fil_fd_allocate(in, &rv);
		if (!fd) {
				errno = ENOMEM;
				return -1;
		}

		fd->flags = flags;
		fd->seek_offset = 0;
		__sync_fetch_and_add((int*)in->in_ddat, 1);
		return rv;
}

ssize_t memdev_read(struct inode* in, int fd, void* buf, size_t noct)
{
		struct fil_fd* f; ssize_t rv = 0;
		struct memdev_node* n;
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
				errno = EINVAL;
				return -1;
		}

		f = fil_fd_get(fd);
		if (!f || (f->flags & O_WRONLY)
			/*|| ((f->flags & O_SEARCH) && !S_ISDIR(in->in_stat.st_mode))*/
			/*|| (f->flags & O_EXEC)*/) { /* O_EXEC->mmap with exec */
				errno = EBADF;
				return -1;
		}

		/* now lock for read access */
		read_lock(&in->in_lock);
		n = *(struct memdev_node**)in->in_pddat;
		if (f->seek_offset < (n->size - sizeof(struct memdev_node))) {
				/* read up to noct bytes */
				rv = n->size - sizeof(struct memdev_node) - f->seek_offset;
				if ((size_t)rv > noct)
						rv = noct;
				memcpy(buf, n->data + f->seek_offset, rv);
				f->seek_offset += rv;
		}
		if (rv > 0 && !(f->flags & O_NOATIME)) {/* set atime */
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);
		}
		read_unlock(&in->in_lock);
		return rv;
}

ssize_t memdev_write(struct inode* in, int fd, const void* buf, size_t noct)
{
		struct fil_fd* f; struct memdev_node* n; size_t s_ext = 0;
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
				errno = EINVAL;
				return -1;
		}
		if (!(f = fil_fd_get(fd))) {
				errno = EBADF;
				return -1;
		}

		/* acquire the lock */
		write_lock(&in->in_lock);
		n = *(struct memdev_node**)in->in_pddat;
		if (f->flags & O_APPEND) /* atomic append */
				f->seek_offset = n->size - sizeof(struct memdev_node);
		if (f->seek_offset + noct > n->size) {
				/* we have to extend */
				s_ext = f->seek_offset + noct + sizeof(struct memdev_node);
				if (s_ext > n->cap) { /* really */
						size_t new_cap; void* mem;
						if (S_ISREG(in->in_stat.st_mode)) {
								/* work on pages */
								new_cap = s_ext / 4096 + (s_ext % 4096 ? 1 : 0) * 4096;
								mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096,
												new_cap, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
								if (mem) {
										n = (struct memdev_node*)mem;
										*(struct memdev_node**)in->in_pddat = n;
										n->cap = new_cap * 4096;
										n->size = s_ext;
								} else { /* write partially */
										noct = n->cap - n->size;
										n->size = n->cap;
										if (!noct)
												noct = -1;
								}
						} else if (S_ISDIR(in->in_stat.st_mode) || S_ISLNK(in->in_stat.st_mode)) {
								/* heap memory */
								new_cap = s_ext + 32; /* prevent many resizes */
								mem = h_realloc(memdev_data->heap, n, new_cap);
								if (!mem) { /* write partially */
										noct = n->cap - n->size;
										n->size = n->cap;
										if (!noct)
												noct = -1;
								} else {
										n = (struct memdev_node*)mem;
										*(struct memdev_node**)in->in_pddat = n;
										n->cap = new_cap;
										n->size = s_ext;
								}
						} else {
								/* wat do? */
								errno = ENOSYS;
								noct = -1;
						}
				} else
						n->size = s_ext;
				in->in_stat.st_size = n->size - sizeof(struct memdev_node);
				in->in_stat.st_size = n->cap / 512 + (n->cap % 512 ? 1 : 0);
		}
		/* now copy the data */
		memcpy(n->data + f->seek_offset, buf, noct);
		/* and update the times */
		if (noct > 0) {
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
				in->in_stat.st_ctim = in->in_stat.st_mtim;
				f->seek_offset += noct; /* only forward (-1 for errno) */
				/* clear SUID,SGID */
				in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
		}
		write_unlock(&in->in_lock);
		return noct;
}

int memdev_close(struct inode* in, int fd)
{
		struct fil_fd* f;
		if (!in || !(f = fil_fd_get(fd))) {
				errno = in ? EBADF : EINVAL;
				return -1;
		}
		/* TODO: file locks */
		fil_fd_free(fd);
		if (__sync_sub_and_fetch((int*)in->in_ddat, 1) == 0) {
				struct memdev_node* n;
				if (in->in_stat.st_nlink)
						return 0;
				/* nlink==0 && nref==0 */
				n = *(struct memdev_node**)in->in_pddat;
				*(struct memdev_node**)in->in_pddat = NULL; /* free slot */
				if (S_ISREG(in->in_stat.st_mode))
						mm_free_vmem(&mm_kernel, n, n->cap / 4096);
				else
						h_free(memdev_data->heap, n);
				ino_release(in);
		}
		return 0;
}

off_t memdev_lseek(struct inode* in, int fd, off_t offset, int ref)
{
		struct fil_fd* f;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
				errno = EINVAL;
				return -1;
		}
		if (!(f = fil_fd_get(fd))) {
				errno = EBADF;
				return -1;
		}
		/* not thread-safe as sharing FDs is not thread-safe */
		if (ref == SEEK_SET)
				f->seek_offset = offset;
		else if (ref == SEEK_CUR)
				f->seek_offset += offset;
		else if (ref == SEEK_END) {
				f->seek_offset = in->in_stat.st_size + offset;
		} else {
				errno = EINVAL;
				return -1;
		}
		return f->seek_offset;
}

int memdev_truncate(struct inode* in, off_t length)
{
		struct memdev_node* n; off_t len;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
				errno = EINVAL;
				return -1;
		}

		/* only work on regular files (i.e. memory pages) */
		if (!S_ISREG(in->in_stat.st_mode)) {
				errno = EINVAL;
				return -1;
		}

		/* modify the file */
		write_lock(&in->in_lock);
		n = *(struct memdev_node**)in->in_pddat;
		len = n->size - sizeof(struct memdev_node);
		if (len > length) { /* shrink */
				size_t num_p;
				n->size = length + sizeof(struct memdev_node);
				num_p = (n->cap - n->size) / 4096;
				if (num_p)
						mm_free_vmem(&mm_kernel, (char*)n + n->cap - num_p * 4096, num_p);
		} else if (len < length) { /* grow */
				if ((n->cap - n->size) >= (length - len))
						n->size = length + sizeof(struct memdev_node);
				else { /* allocate new pages */
						size_t num_p; void* mem;
						num_p = n->size + (length - len);
						num_p = num_p / 4096 + ((num_p % 4096) ? 1 : 0);
						mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096, num_p,
										MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
						/* everything above size is still scrubbed -> no bzero */
						if (!mem) {
								/* failed to extend */
								errno = EFBIG;
								write_unlock(&in->in_lock);
								return -1;
						}
						n->cap = num_p * 4096;
						n->size = length + sizeof(struct memdev_node);
				}
		} else { } /* do nothing */

		/* clear SUID,SGID */
		in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
		in->in_stat.st_size = length;
		in->in_stat.st_blocks = n->cap / 512;
		/* always update c&mtim (as in ftruncate) */
		clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
		in->in_stat.st_ctim = in->in_stat.st_mtim;
		write_unlock(&in->in_lock);
		return 0;
}

char* memdev_search_fn(struct memdev_node* n, const char* fn)
{
		char *str, *end;
		str = n->data;
		end = (char*)n + n->size;
		while (str < end) {
				if (strcmp(str, fn) == 0) {
						return str;
				}
				str += strlen(str) + sizeof(void*) + 1;
		}
		return NULL;
}

struct inode* memdev_get_subnode(struct inode* in, const char* fn)
{
		struct inode* rv = NULL;
		if (!fn || (!in && strlen(fn) > 0)) {
				errno = EINVAL;
				return NULL;
		}

		if (in) {
				struct memdev_node* n; char *str;
				/* we don't handle links here. The OS should only ask
				 * for files we actually have stored on this device */
				if (in->in_stat.st_dev != 0) {
						errno = EINVAL;
						return NULL;
				}
				/* check for directory */
				if (!S_ISDIR(in->in_stat.st_mode)) {
						errno = ENOTDIR;
						return NULL;
				}

				/* now search for fn with read lock */
				n = *(struct memdev_node**)in->in_pddat;
				read_lock(&in->in_lock);
				str = memdev_search_fn(n, fn);
				if (str) {
						str += strlen(str) + 1;
						rv = *(void**)str;
				}
				/* update access time <- NO only if opening the dir */
				/*clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);*/
				read_unlock(&in->in_lock);
				if (!rv)
						errno = ENOENT;
				return rv;
		}

		/* return root node */
		if (memdev_data->node_ct == 0) {
				/* create root directory first */
				void* mem = h_malloc(memdev_data->heap, 128 + sizeof(struct memdev_node));
				struct memdev_node* n = (struct memdev_node*)mem;
				if (!mem)
						return NULL;
				n->cap = 128 + sizeof(struct memdev_node);
				n->size = sizeof(struct memdev_node);
				n->file = S_IFDIR;
				rv = n->ino = ino_allocate(S_IFDIR);
				if (!rv) {
						h_free(memdev_data->heap, mem);
						return NULL;
				}
				rv->in_stat.st_dev = memdev_data->id;
				rv->in_stat.st_blksize = 4096; /* 4096/512 */
				rv->in_stat.st_blocks = 8;
				rv->in_stat.st_size = 0; /* actual size */
				rv->in_pddat = memdev_store_node(n);
				if (!rv->in_pddat) {
						ino_release(n->ino);
						h_free(memdev_data->heap, mem);
						return NULL;
				}
				rv->in_stat.st_nlink = 1; /* NEVER free / on close() */
				return rv;
		} else
				return memdev_data->nodes[0]->ino;
}

int memdev_unlink(struct inode* in0, struct inode* in1)
{
		struct timespec t;
		if (!in1 || (in0 && in0->in_stat.st_dev != memdev_data->id)) {
				errno = EINVAL;
				return -1;
		}

		if (in0) { /* remove link from source dir(!)  */
				struct memdev_node* n; char* fn;
				if (!(in0->in_stat.st_mode & S_IFDIR)) {
						errno = ENOTDIR;
						return -1;
				}

				n = *(struct memdev_node**)in0->in_pddat;
				/* now modify the directory */
				write_lock(&in0->in_lock);
				fn = n->data;
				while (fn < (char*)n + n->size) {
						char* fn2 = fn + strlen(fn) + 1;
						if (*(struct inode**)fn2 == in1) {
								/* found the entry */
								fn2 += sizeof(struct inode*);
								memmove(fn, fn2, (char*)n + n->size - fn2);
								n->size -= fn2 - fn;
								if (n->size > 128 + sizeof(struct memdev_node)) {
										/* shrink a bit */
										if (n->cap - n->size > 64) {
												n->cap = n->size + 64;
												*(struct memdev_node**)in0->in_pddat
													   	= n = h_realloc(memdev_data->heap,
																		n, n->cap);
												/* will never happen as shrink works in-place */
										}
								}
								n = NULL; /* signify found */
								in0->in_stat.st_size = n->size - sizeof(struct memdev_node);
								in0->in_stat.st_blocks = n->cap / 512 + (n->cap % 512 ? 1 : 0);
								break;
						} else
								fn = fn2 + sizeof(struct inode*);
				}
				write_unlock(&in0->in_lock);
				if (!n) {
						errno = ENOENT;
						return -1;
				}
		}

		/* get current time */
		clock_gettime(CLOCK_REALTIME, &t);
		if (in0)
				in0->in_stat.st_mtim = in0->in_stat.st_ctim = t;

		/* now unlink the node */
		if (in1->in_stat.st_dev != memdev_data->id) {
				const struct device_desc* dd = get_device(in1->in_stat.st_dev);
				if (!dd) {
						cprintf(KFMT_WARN, "unable to locate device %u"
										" for unlinking inode at %p\n",
										(uint32_t)in1->in_stat.st_dev, in1);
						if (__sync_sub_and_fetch(&in1->in_stat.st_dev, 1) == 0)
								ino_release(in1); /* clean up partially */
						errno = ENODEV;
						return 0; /* only warn */
				} else {
						return dd->fn_unlink(NULL, in1);
				}
		} else {
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
					(*(int*)in1->in_ddat == 0)) {
						struct memdev_node* n;
						/* this was the last link & no open FDs so remove the node */
						n = *(struct memdev_node**)in1->in_pddat;
						*(struct memdev_node**)in1->in_pddat = NULL; /* free slot */
						if (S_ISREG(in1->in_stat.st_mode))
								mm_free_vmem(&mm_kernel, n, n->cap / 4096);
						else
								h_free(memdev_data->heap, n);
						ino_release(in1);
						return 0;
				}
				in1->in_stat.st_ctim = t;
				return 0;
		}
}

int memdev_set_subnode(struct inode* in0, struct inode* in1, const char* fn)
{
		struct memdev_node *n0, *n1 = NULL;
		if (!in0 || !fn || in0->in_stat.st_dev != memdev_data->id) {
				errno = EINVAL;
				return -1;
		}

		/* inode in0 on this device and directory */
		if (!(in0->in_stat.st_mode & S_IFDIR)) {
				errno = ENOTDIR;
				return -1;
		}
		n0 = *(struct memdev_node**)in0->in_pddat;

		/* create REAL in1 if dummy for creation */
		if (!in1) { /* unlink */
				/* convenience function */
				in1 = memdev_get_subnode(in0, fn);
				if (!in1)
						return -1;
				return memdev_unlink(in0, in1);
		} else if (in1->in_stat.st_dev == INVALID_DEVICE) {
				void* mem = NULL; size_t s;
				/* only allow dirs, files and links */
				if (!S_ISDIR(in1->in_stat.st_mode) &&
					!S_ISREG(in1->in_stat.st_mode) &&
					!S_ISLNK(in1->in_stat.st_mode)) {
						errno = ENOTSUP;
						return -1;
				}
				/* calculate the size of the memory */
				if (in1->in_stat.st_size)
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
								+ (S_ISREG(in1->in_stat.st_mode) ? 0 : 1);
				else if (S_ISDIR(in1->in_stat.st_mode))
						s = 128 + sizeof(struct memdev_node); /* default dir capacity */
				else if (S_ISLNK(in1->in_stat.st_mode))
						s = 32 + sizeof(struct memdev_node); /* default link length */
				else
						s = 4096; /* default file size */

				/* get some memory for the memfile */
				if (S_ISREG(in1->in_stat.st_mode)) {
						if (s % 4096)
								s += 4096 - (s % 4096);
						mem = mm_alloc_vmem(&mm_kernel, NULL, s / 4096,
										MMGR_MAP_KERNEL | MMGR_MAP_WRITE);
				} else
						mem = h_malloc(memdev_data->heap, s);
				if (!mem)
						return -1;
				/* now we have clean pages or heap memory */
				n1 = (struct memdev_node*)mem;
				n1->cap = s;
				n1->size = sizeof(struct memdev_node);
				n1->file = in1->in_stat.st_mode;
				n1->ino = ino_allocate(in1->in_stat.st_mode & S_IFMT);
				if (!n1->ino) { /* undo much */
free_mem:
						if (S_ISREG(n1->file))
								mm_free_vmem(&mm_kernel, n1, s / 4096);
						else
								h_free(memdev_data->heap, n1);
						return -1;
				}
				/* and the inode */
				n1->ino->in_stat.st_blksize = 4096;
				n1->ino->in_stat.st_blocks = s / 512 + ((s % 512) ? 1 : 0);
				n1->ino->in_stat.st_dev = memdev_data->id;
				n1->ino->in_stat.st_size = 1;
				n1->ino->in_pddat = memdev_store_node(n1);
				if (!n1->ino->in_pddat) {
						/* sth. went wrong! */
						ino_release(n1->ino);
						goto free_mem;
				}
				in1 = n1->ino;
		}

		/* acquire the write lock */
		write_lock(&in0->in_lock);
		/* find possible old/conflicting inode */
		char* dt = memdev_search_fn(n0, fn), need_entry = 1;
		if (dt) {
				struct inode* in2;
				/* already existing, get inode */
				dt += strlen(dt) + 1;
				in2 = *(struct inode**)dt;
				if (in1 == in2) {
						/* do nothing */
						errno = EEXIST;
						write_unlock(&in0->in_lock);
						return -1;
				}
				/* unlink old node if neccessary */
				if (in2->in_stat.st_dev == memdev_data->id)
						memdev_unlink(NULL, in2);
				else {
						const struct device_desc* dd;
						dd = get_device(in2->in_stat.st_dev);
						if (!dd) {
								cprintf(KFMT_WARN, "unable to locate device %u"
												" for unlinking inode referenced by %s\n",
												(uint32_t)in2->in_stat.st_dev, fn);
								if (__sync_sub_and_fetch(&in2->in_stat.st_dev, 1) == 0)
										ino_release(in2); /* clean up partially */
						} else {
								dd->fn_unlink(NULL, in2);
						}
				}
				/* set new link */
				*(struct inode**)dt = in1;
				need_entry = 0;
				printf("fn matches prev\n");
		}

		/* assume valid inode in1 */
		__sync_fetch_and_add(&in1->in_stat.st_nlink, 1);
		if (need_entry) {
				/* modify data */
				size_t s = strlen(fn) + 1 + sizeof(void*);
				dt = (char*)n0 + n0->size;
				if ((n0->cap - n0->size) < s) {
						/* use realloc */
						size_t nc = 2 * n0->cap + s;
						n0 = h_realloc(memdev_data->heap, n0, nc);
						if (!n0) { /* real OOM */
								cprintf(KFMT_ERROR, "failed to realloc on memdev heap: errno=%d\n", errno);
								while (1);
						}
						/* no cmpxchg neccessary */
						*(struct memdev_node**)n0->ino->in_pddat = n0;
						n0->cap = nc;
				}
				/* we now have enough space */
				strncpy(dt, fn, s - 1 - sizeof(void*));
				dt += s - 1 - sizeof(void*);
				*dt = '\0';
				*(struct inode**)(++dt) = in1;
				n0->size += s;
				in0->in_stat.st_size = n0->size - sizeof(struct memdev_node);
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
					   	+ ((in0->in_stat.st_size % 512) ? 1 : 0);
		}
		/* update times (only c&m on dir & c on fil) */
		clock_gettime(CLOCK_REALTIME, &in0->in_stat.st_mtim);
		in0->in_stat.st_ctim = in0->in_stat.st_mtim;
		/* due to change in link count */
		in1->in_stat.st_ctim = in0->in_stat.st_mtim;
		write_unlock(&in0->in_lock);
		return 0;
}
/**********************************************************/
static struct inode *in_root, *in_dev;
struct inode* get_special_inode(enum spec_ino what)
{
		switch (what) {
				case INO_ROOT:
						return in_root;
				case INO_DEV:
						return in_dev;
				default:
						return NULL;
		}
}
/**********************************************************/
int MODENTRY module_init()
{
		struct device_desc dd = {0}; dev_t d;
		printf("registering the basic file devices\n");
		dd.type = DEVTYPE_NONE;
		dd.fn_reg_dev = memdev_register;
		dd.fn_unreg_dev = memdev_unregister;
		dd.fn_open = memdev_open;
		dd.fn_read = memdev_read;
		dd.fn_write = memdev_write;
		dd.fn_close = memdev_close;
		dd.fn_lseek = memdev_lseek;
		dd.fn_truncate = memdev_truncate;
		dd.fn_get_subnode = memdev_get_subnode;
		dd.fn_set_subnode = memdev_set_subnode;
		dd.fn_unlink = memdev_unlink;
		d = register_device(&dd);
		if (d != INVALID_DEVICE)
				printf("\tregistered memdev as device %u\n", (uint32_t)d);
		else {
				printf("\tfailed to register memdev: errno=%d\n", errno);
				return -1;
		}

		printf("\ncreating the root file system\n");
		/* create the / & /dev folders */
		in_root = dd.fn_get_subnode(NULL, "");
		if (!in_root) {
				cprintf(KFMT_ERROR, "\tfailed to create root in memdev: errno=%d\n", errno);
				return -1;
		}
		printf("adding /dev\n");
		if (dd.fn_set_subnode(in_root, &INO_TMPL_DIR, "dev") != 0) {
				cprintf(KFMT_ERROR, "\tfailed to create folder /dev in root: errno=%d\n", errno);
				return -1;
		}
		printf("retrieving /dev\n");
		in_dev = dd.fn_get_subnode(in_root, "dev");
		if (!in_dev) {
				cprintf(KFMT_ERROR, "\tfailed to access folder /dev: errno=%d\n", errno);
				return -1;
		}

		return 0;
}

void print_stat(struct inode* in, const char* fn, int cb, int cu, int cg, int cs)
{
		char fmt = KFMT_NORMAL, c_tp = '-', c_ur = '-', c_uw = '-',
			 c_ux = '-', c_gr = '-', c_gw = '-', c_gx = '-', c_or = '-',
			 c_ow = '-', c_ox = '-';
		mode_t m = in->in_stat.st_mode;

		if (m & S_IRUSR)
				c_ur = 'r';
		if (m & S_IWUSR)
				c_uw = 'w';
		if (m & S_IXUSR)
				c_ux = 'x';
		if (m & S_ISUID) /* setuid */
				c_ux = ((c_ux == 'x') ? 's' : 'S');
		if (m & S_IRGRP)
				c_gr = 'r';
		if (m & S_IWGRP)
				c_gw = 'w';
		if (m & S_IXGRP)
				c_gx = 'x';
		if (m & S_ISGID) /* setgid */
				c_gx = ((c_gx == 'x') ? 's' : 'S');
		if (m & S_IROTH)
				c_or = 'r';
		if (m & S_IWOTH)
				c_ow = 'w';
		if (m & S_IXOTH)
				c_ox = 'x';
		if (m & S_ISVTX) /* sticky bit */
				c_ox = ((c_ox == 'x') ? 't' : 'T');
		if (S_ISDIR(m))
				c_tp = 'd';
		else if (S_ISLNK(m))
				c_tp = 'l';
		else if (S_ISFIFO(m))
				c_tp = 'p';
		else if (S_ISCHR(m))
				c_tp = 'c';
		else if (S_ISBLK(m))
				c_tp = 'b';
		else if (S_ISSOCK(m))
				c_tp = 's';
		else if (S_ISREG(m))
				c_tp = '-';
		else
				c_tp = '?';
		/* -rw-r--r-- 1 dennis users 6728 Aug 29 19:32 prog.o */
		struct tm atime; char datstr[26];
		localtime_r(&in->in_stat.st_atim.tv_sec, &atime);
		asctime_r(&atime, datstr);
		/* reformat datstr TODO: strftime */
		/* old format: "Mon Aug 29 19:32:xy 2134 */
		strcpy(datstr, datstr + 4);
		if (atime.tm_year != 115/*today.tm_year*/)
				strcpy(datstr + 7, datstr + 15);
		datstr[12] = '\0';
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
						c_uw, c_ux, c_gr, c_gw, c_gx, c_or, c_ow, c_ox,
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
						datstr);
		if (S_ISDIR(m)) {
				fmt = LFMT_DIR;
				if ((m & S_ISVTX) && (m & S_IWOTH))
						fmt = LFMT_SWRT;
				else if (m & S_IWOTH)
						fmt = LFMT_OWRT;
				else if (m & S_ISVTX)
						fmt = LFMT_STCK;
		} else if (S_ISREG(m)) {
				if (m & S_ISUID)
						fmt = LFMT_SUID;
				else if (m & S_ISGID)
						fmt = LFMT_SGID;
				else if (m & S_IXUGO)
						fmt = LFMT_EXEC;
				else if (in->in_stat.st_nlink > 1)
						fmt = LFMT_MH;
		} else if (S_ISLNK(m))
				fmt = LFMT_LNK;
		else if (S_ISFIFO(m))
				fmt = LFMT_PIPE;
		else if (S_ISSOCK(m))
				fmt = LFMT_SOCK;
		else if (S_ISBLK(m))
				fmt = LFMT_BDEV;
		else if (S_ISCHR(m))
				fmt = LFMT_CDEV;
		/*else if (S_ISDOOR(m))
				fmt = LFMT_DOOR;*/
		else
				fmt = LFMT_ORPH;
		cprintf(fmt, "%s\n", fn);
}

struct inode* path_lookup(const char* str, char* tk, size_t ntk, int allow_partial)
{
		static char pwd[260] = "/";
		static struct inode* in_pwd = NULL, *in = NULL, *in_prev = NULL;
		char buf[260], *ltk = "", *ctx, *tok;
		if (!in_pwd)
				in_pwd = in_root;
		/* navigate to path */
		strncpy(buf, str, 260);
		buf[260] = '\0';
		ltk = tok = strtok_r(buf, "/", &ctx);
		in = ((*str == '/') ? in_root : in_pwd); /* abs or rel */
		in_prev = in;
		while (tok) {
				const struct device_desc* dd;
				dd = get_device(in->in_stat.st_dev);
				if (!dd) {
						cprintf(KFMT_WARN, "unable to explore node "
							"%s at associated device %u is not registered. errno=%d\n",
							tok, (uint32_t)in->in_stat.st_dev, errno);
						return NULL;
				}
				ltk = tok;
				in = dd->fn_get_subnode(in, tok);
				if (!in) {
						if (!allow_partial)
								cprintf(KFMT_WARN, "Failed to locate subnode %s"
										" in path %s: error=%d\n", tok,
										str, errno);
						else {
								if (tk) {
										strncpy(tk, ltk, ntk);
										tk[ntk - 1] = '\0';
								}
								return in_prev;
						}
						return NULL;
				} else {
						in_prev = in;
				}
				tok = strtok_r(NULL, "/", &ctx);
		}
		if (tk) {
				strncpy(tk, ltk, ntk);
				tk[ntk - 1] = '\0';
		}
		return in;
}

int fcli_ls(const char* str)
{
		struct inode* in = NULL; char ltk[40];
		/* ls-like commands */
		str += 3;
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
		if (!in)
				return 1;
		/* now do the lookup (default to ls -l) */
		if (S_ISDIR(in->in_stat.st_mode)) {
				const struct device_desc* dd; int fd;
				/* max and sum of blocks, size, user, gid */
				size_t mb = 0, ms = 0, mu = 0, mg = 0, sb = 0, ss = 0;
				char buf[128]; size_t nr; int frst = 1;

				/* open directory for reading */
				dd = get_device(in->in_stat.st_dev);
				if (!dd) {
						printf("unable to obtain device %u associated"
							" with the directory\n", (uint32_t)in->in_stat.st_dev);
						return 1;
				}
				fd = dd->fn_open(in, O_RDONLY);
				if (fd == -1) {
						printf("unable to access directory for reading: errno=%d\n", errno);
						return 1;
				}
				/* now read the data */
Pos0:
				if (!frst) {
						size_t im; size_t* arr[] = { &mb, &ms, &mu, &mg };
						/* calculate the capacites */
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
								im = 1;
								while ((**p /= 10))
										im++;
								**p = im;
						}
						if (dd->fn_lseek(in, fd, 0, SEEK_SET) != 0) {
								cprintf(KFMT_ERROR, "failed to seek to start"
									" of directory file. errno=%d\n", errno);
								return 1;
						}
				}
				do {
						char* fn = buf, *fn_prev; size_t s;
						nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
						buf[nr] = '\0';
						while ((s = strlen(fn))) {
								struct inode* in1;
Pos1:
								if (fn + s + 1 + sizeof(struct inode*) > buf + sizeof(buf)) {
										/* data spans, try lseek */
										off_t sk = sizeof(buf) - (fn - buf);
										if (sk == -sizeof(buf)) {
												cprintf(KFMT_ERROR, "fn too long for intermediate buffer\n");
												return 1;
										}
										if (-1 == dd->fn_lseek(in, fd, sk, SEEK_CUR)) {
												cprintf(KFMT_WARN, "unable to seek on directory file for ls. errno=%d\n", errno);
												return 1;
										}
										fn = buf;
										s = strlen(fn);
										goto Pos1;
								}
								fn_prev = fn;
								fn += s + 1;
								in1 = *(struct inode**)fn;
								fn += sizeof(struct inode*);
								if (!in1) {
										cprintf(KFMT_WARN, "inode of %s missing\n", fn_prev);
								} else if (frst) {
										if (in1->in_stat.st_nlink > mb)
												mb = in1->in_stat.st_nlink;
										if (in1->in_stat.st_size > ms)
												ms = in1->in_stat.st_size;
										if (in1->in_stat.st_uid > mu)
												mu = in1->in_stat.st_uid;
										if (in1->in_stat.st_gid > mg)
												mg = in1->in_stat.st_gid;
										sb += in1->in_stat.st_blocks;
										ss += in1->in_stat.st_size;
								} else {
										/* do the printing */
										print_stat(in1, fn_prev, mb, mu, mg, ms);
								}
						}
				} while (nr);
				if (frst) {
						printf("total %lu\n", sb);
						frst = 0;
						goto Pos0;
				}
				/* TODO: use dirent to not pollute space */
				if (-1 == dd->fn_close(in, fd)) {
						cprintf(KFMT_WARN, "failed to close fd %d to"
							" directory file open for reading. errno=%d\n", fd, errno);
				}
		} else
			   print_stat(in, ltk, 0, 0, 0, 0);
		return 1;
}

int fcli_cat(const char* str)
{
		struct inode* in = NULL; char ltk[40];
		/* cat-like commands */
		str += 4;
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
		if (!in)
				return 1;

		/* read the file */
		const struct device_desc* dd; int fd; size_t nr;
		dd = get_device(in->in_stat.st_dev);
		if (!dd) {
				printf("device error: errno=%d\n", errno);
				return 1;
		}
		fd = dd->fn_open(in, O_RDONLY);
		if (fd == -1) {
				printf("cannot open file %s\n", str);
				return 1;
		}
		printf("cat: size=%lld\n", in->in_stat.st_size);
		do {
				char buf[61];
				nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
				buf[nr] = '\0';
				if (nr) {
						char* c = buf;
						while (c < buf + nr)
								if (isprint(*c))
										putchar(*c++);
								else {
										putchar('.');
										c++;
								}
				}
		} while (nr);
		if (-1 == dd->fn_close(in, fd))
				return 1;
		printf("\n");
		return 1;
}

int fcli_mkdir(const char* str)
{
		struct inode* in; char ltk[40];
		const char* oc;
		if (str[2] == ' ')
				str += 3;
		else
				str += 6;
		in = path_lookup(str, ltk, sizeof(ltk), 1);
		if (!in)
				return 0;
		oc = strstr(str, ltk);
		if (strchr(oc, '/'))
				printf("mkdir: cannot create directory '%s': no such file or directory (%s missing)\n", str, ltk);
		else {
				/* try to create the node */
				const struct device_desc* dd;
				dd = get_device(in->in_stat.st_dev);
				if (!dd) {
						printf("unable to obtain device %u associated"
								"with node '%s'\n", (uint32_t)in->in_stat.st_dev, ltk);
						return 1;
				}
				if (dd->fn_set_subnode(in, &INO_TMPL_DIR, ltk) != 0) {
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
										ltk, (int)(oc - str), str, errno);
						return 1;
				} else
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
				return 1;
		}
		return 1;
}

extern int file_cli(const char* str)
{
		if (strncmp(str, "ls", 2) == 0 && (!str[2] || str[2] == ' '))
				return fcli_ls(str);
		else if (strncmp(str, "cat", 3) == 0 && (!str[3] || str[3] == ' '))
				if (!str[3]) /* stdin */
						return 0;
				else
						return fcli_cat(str);
		else if (strncmp(str, "mkdir ", 6) == 0 || strncmp(str, "md ", 3) == 0) {
				return fcli_mkdir(str);
		} else
				return 0; /* we have not handled the command */
}

void MODENTRY module_cleanup()
{
		printf("goodbye file.ko\n");
}


