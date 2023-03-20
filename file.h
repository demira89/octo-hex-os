/* file.h : Defines the public functions of the file module, which
 *          provides the ramdisk-like fs, the global inode directory
 *          and the hooks for further devices and device special files.
 * */

/* inodes represented by stat
 * has no parent or "location" only device and ino_t */
struct inode
{
		struct stat in_stat; /* public stat structure */
		char in_ddat[8]; /* device-dependent data */
		void* in_pddat; /* pointer to additional device dependent data */
		rwlock_t in_lock;
};

#define INO_TMPL_DIR ((struct inode){ { INVALID_DEVICE, 0, S_IFDIR, 0, 0, 0, 0, 0, 0, 0, {0,0}, {0,0}, {0,0}}, "", NULL, RW_LOCK_UNLOCKED })
#define INO_TMPL_REG ((struct inode){ { INVALID_DEVICE, 0, S_IFREG, 0, 0, 0, 0, 0, 0, 0, {0,0}, {0,0}, {0,0}}, "", NULL, RW_LOCK_UNLOCKED })

#define DEVTYPE_NONE 1
#define DEVTYPE_CHAR 2
#define DEVTYPE_BLOCK 3
/*#define DEVTYPE_LINK 3
#define DEVTYPE_PIPE 4
#define DEVTYPE_SOCKET 5
#define DEVTYPE_REGULAR 6*/

typedef int (*dd_reg_dev)(dev_t d); /* uses errno */
typedef int (*dd_unreg_dev)(); /* returns error directly */
/* open w/o fn as it is already working on inode base i.e. no lookup */
typedef int (*dd_open)(struct inode* in, int flags);
typedef ssize_t (*dd_read)(struct inode* in, int fd, void* buf, size_t noct);
typedef ssize_t (*dd_write)(struct inode* in, int fd, const void* buf, size_t noct);
typedef int (*dd_close)(struct inode* in, int fd);
typedef off_t (*dd_lseek)(struct inode* in, int fd, off_t offset, int ref);
typedef int (*dd_truncate)(struct inode* in, off_t length);
/* convenience functions: read/write on directory "files" also possible
 * read/write has to populate inodes at first read so that fn+ptr can be read
 * with the simple format (inode*, char*) to be read */
typedef struct inode* (*dd_get_subnode)(struct inode* in, const char* fn);
/* for moving or unlinking/creating files (i.e. set(n, NULL, "name") */
typedef int (*dd_set_subnode)(struct inode* in0, struct inode* in1, const char* fn);
/* unlink(a,b) on home device & unlink(NULL,b) on "remote" device */
typedef int (*dd_unlink)(struct inode* in0, struct inode* in1);
typedef int (*dd_ioctl)(struct inode* in, int fd, unsigned long request, ...);
typedef int (*dd_fcntl)(struct inode* in, int fd, int cmd, ...);
/* ALTERNATIVE: for each device dd_get_subnode(NULL, "") opens the root folder/
 * element which then can be further explored by dd_get_subnode
 * dd_open is only responsible for getting file descriptors on the
 * inodes amd write/read only work with the fd, moving access checks
 * only into dd_open (as fd's are (or will be) per process)
 * OS code can do the whole process on a given path automatically
 * from the inodes returned by get_subnode symbolic links and other
 * candies can be processed appropiately. Incompatibilities with the
 * FS result in error codes in get/set subnode.
 * NOW I ONLY HAVE TO IMPELMENT THIS
 *
 * LAST QUESTION: device_desc per instance or intance ptr in every function?
 * */

struct device_desc
{
		char type;
		/* Mandatory for all types */
		dd_reg_dev fn_reg_dev;
		dd_unreg_dev fn_unreg_dev;
		dd_open fn_open;
		dd_read fn_read;
		dd_write fn_write;
		dd_close fn_close;
		/* used for block devices */
		dd_lseek fn_lseek;
		/* used by DEVTYPE_NONE */
		dd_truncate fn_truncate;
		dd_get_subnode fn_get_subnode;
		dd_set_subnode fn_set_subnode;
		dd_unlink fn_unlink;
		/* misc */
		dd_ioctl fn_ioctl; /* eject media, ... */
		dd_fcntl fn_fcntl; /* make non-blocking etc. */
};/* FILE object->enumerate()? get_subn*/
/* POSIX AIO; */

/* functions for providing further devices. */
dev_t register_device(struct device_desc* dd);
int unregister_device(dev_t dev);
const struct device_desc* get_device(dev_t dev);

/* functions for handling inodes */
enum spec_ino {
		INO_ROOT,
		INO_DEV,
		INO_DISK,
		INO_DISK_BY_ID,
		INO_DISK_BY_UUID,
		INO_DISK_BY_PATH
};
struct inode* ino_allocate(int init); /* nlink=0 */
int ino_release(struct inode* ino);
struct inode* get_special_inode(enum spec_ino what);

/* the same for FDs */
struct fil_fd {
		struct inode* in;
		off_t seek_offset;
		int flags;
		char fd_data[8]; /* for use by the individual devices */
		void* fd_ptr;
};
struct fil_fd* fil_fd_get(int fd);
struct fil_fd* fil_fd_allocate(struct inode* in, int* pfd);
void fil_fd_free(int fd);

/* General definition for disk devices and for partition support.
 * This allows to use a single disk-interface-independent partition
 * scheme, which is implemented in FILE.KO. */
struct disk_geometry {
		uint16_t lpp; /* logical sectors per physical */
		uint16_t lof; /* logical sector offset (1->AOFF 3584) */
		uint32_t lss; /* logical sector size */
		uint32_t pss; /* physical sector size */
		uint64_t max_lba;
};

struct disk_cache* create_disk_cahce(struct disk_geometry* gm);

