/* ata_drive.c : Used for the /dev/sdX interface for (S)ATA devices.
 * */

#include "kernel.h"
#include "kdata.h"
#include "ahci.h"
#include "file.h"
#include "module.h"

#define ATABABBLE
#ifdef ATABABBLE
#define atprintf printf
#define atiprintf iprintf
#else
#define atprintf noprintf
#define atiprintf noprintf
#endif

int ata_register_device(dev_t d);
int ata_unregister_device();
int ata_open(struct inode* in, int flags);
ssize_t ata_read(struct inode* in, int fd, void* buf, size_t noct);
ssize_t ata_write(struct inode* in, int fd, const void* buf, size_t noct);
int ata_close(struct inode* in, int fd);
off_t ata_lseek(struct inode* in, int fd, off_t offset, int ref);
int ata_unlink(struct inode* in0, struct inode* in1);
/* DEVTYPE_BLOCK: no truncate, get/set_subnode */

int ata_init = 0; spinlock_t ata_lock = SPIN_LOCK_UNLOCKED;
struct device_desc dd_ata = {
		.type = DEVTYPE_BLOCK,
		.fn_reg_dev = ata_register_device,
		.fn_unreg_dev = ata_unregister_device,
		.fn_open = ata_open,
		.fn_read = ata_read,
		.fn_write = ata_write,
		.fn_close = ata_close,
		.fn_lseek = ata_lseek,
		.fn_truncate = NULL,
		.fn_get_subnode = NULL,
		.fn_set_subnode = NULL,
		.fn_unlink = ata_unlink,
		/* TODO: populate ioctls */
		.fn_ioctl = NULL,
		.fn_fcntl = NULL,
};
struct {
		dev_t id;
		uint32_t cur_idx;
		struct list_head nodes;
} ata_device;

struct ata_node {
		uint32_t index;
		struct list_head lst;
		struct ahci_device* ad;
		struct ahci_port* p;
		struct ata_identify* id;
		struct disk_cache* cache;
		uint16_t pt;
		uint16_t pmprt; /* for future extension */
		struct disk_geometry gm;
		off_t max_ofs; /* lss*max_lba (can be extended above 64-bit in future)*/
		char name[20];
};

/* borrowed from linux/drivers/scsi/sd.c */
int sd_format_disk_name(char *prefix, int index, char *buf, int buflen)
{
		const int base = 'z' - 'a' + 1;
		char *begin = buf + strlen(prefix);
		char *end = buf + buflen;
		char *p;
		int unit;

		p = end - 1;
		*p = '\0';
		unit = base;
		do {
				if (p == begin)
						return -EINVAL;
				*--p = 'a' + (index % unit);
				index = (index / unit) - 1;
		} while (index >= 0);

		memmove(begin, p, end - p);
		memcpy(buf, prefix, strlen(prefix));

		return 0;
}

/* ATA Device: Has inodes with pointer to ahci_device, port
 * and read/write is sent to the corresponding HBA. Later
 * ioctl's are needed for things like TRIM, flush, etc.
 * */

void init_ata_dd()
{
		if (!spin_trylock(&ata_lock)) {
				while (!ata_init)
						task_yield();
				return;
		}

		/* now do the protected init */
		if (register_device(&dd_ata) == INVALID_DEVICE) {
				cprintf(KFMT_ERROR, "unable to register ATA device object.\n");
				spin_unlock(&ata_lock);
				return;
		}

		/* and leave */
		ata_init = 1;
		spin_unlock(&ata_lock);
}

// void register_hba()
// void notify_ata_device()
// void remove_ata_device()
// void remove_hba()

int register_ata_device(struct ahci_device* ad, struct ahci_port* p,
				uint16_t pmprt,	struct ata_identify* id)
{
		/* init the containers */
		if (!ata_init)
				init_ata_dd();

		/* now register the node */
		struct ata_node* n = kzalloc(sizeof(*n));
		if (!n)
				return -ENOMEM;
		n->ad = ad;
		n->id = id;
		n->pt = p - ad->ptr->port;
		n->pmprt = pmprt;
		n->index = __sync_fetch_and_add(&ata_device.cur_idx, 1);

		/* and calculate the physical sizes */
		if (!id->lba_supp) {
				/* ancient ATA harddisk */
				die("LBA needed\n");
		} else if (id->has_lba48 || id->has_lba48_alt)
				n->gm.max_lba = id->num_logical_sectors;
		else
				n->gm.max_lba = id->max_lba28;
		/* sector size */
		if (id->has_multiple_logical_per_physical_sectors) {
				n->gm.lpp = 1 << id->num_pwr2_logical_per_phys;
		} else
				n->gm.lpp = 1;
		if (id->logical_sector_longer_than_512bt) {
				n->gm.lss = 2 * id->logical_sector_size;
		} else
				n->gm.lss = 512;
		n->gm.lof = id->logical_sector_offset;

		/* and create the disk cache */
		n->cache = create_disk_cache(&n->gm);

		/* add the entry (we should check for existing ones) */
		list_add_tail(&n->lst, &ata_device.nodes);

		/* populate /dev/sdX */
		struct inode *in_dev = get_special_inode(INO_DEV), *in;
		const struct device_desc* dd_d;
		in = ino_allocate(S_IFBLK); /* times have been set */
		if (!in_dev || !in) {
				die("/dev is not present or inode allocation failed\n");
		}
		in->in_pddat = n;
		in->in_stat.st_dev = ata_device.id;
		in->in_stat.st_blksize = n->gm.pss; /* preferred blocksize */
		in->in_stat.st_blocks = n->gm.max_lba * n->gm.lss / 512; /* LBA48 no overflow */
		in->in_stat.st_size = n->gm.max_lba * n->gm.lss;
		dd_d = get_device(in_dev->in_stat.st_dev);
		if (sd_format_disk_name("sd", n->index, n->name, sizeof(n->name)))
				cprintf(KFMT_WARN, "too many sdX devices\n");
		if (dd_d->fn_set_subnode(in_dev, in, n->name) == 0)
				cprintf(KFMT_OK, "registered ATA device at dev/%s\n", n->name);
		else
				cprintf(KFMT_WARN, "unable to register ATA device at dev/%s\n", n->name);

		/* TODO: populate /dev/disk/by-{id,path,uuid} */
}

/* FILE.KO interface for the ATA device object.
 * */
int ata_register_device(dev_t d)
{
		ata_device.id = d;
		ata_device.cur_idx = 0;
		ata_device.nodes = LIST_HEAD_INIT(ata_device.nodes);
		return 0;
}

int ata_unregister_device()
{
		/* we would have to notify all dependent devices of our
		 * unavailability and maye allow for flushing. */
		return -1;
}

int ata_open(struct inode* in, int flags)
{
		struct fil_fd* fd; int rv;
		if (!in || in->in_stat.st_dev != ata_device.id) {
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

/* block device does the caching: all reads/writes passed to the ahci
 * driver work on LBAs -> need for page-level cached IO arises. */
ssize_t ata_read(struct inode* in, int fd, void* buf, size_t noct)
{
		struct fil_fd* f; ssize_t rv = 0;
		struct ata_node* n; uint64_t lba;
		if (!in || !buf || in->in_stat.st_dev != ata_device.id) {
				errno = EINVAL;
				return -1;
		}

		f = fil_fd_get(fd);
		n = in->in_pddat;
		if (!f || (f->flags & O_WRONLY)
			/*|| ((f->flags & O_SEARCH) && !S_ISDIR(in->in_stat.st_mode))*/
			/*|| (f->flags & O_EXEC)*/) { /* O_EXEC->mmap with exec */
				errno = EBADF;
				return -1;
		}

		/* calculate the LBA from the offset */
		lba = f->seek_offset / n->gm.lss;
		if (f->seek_offset % n->gm.lss) {
				/* we have to handle unaligned access */
				die("not sector aligned\n");
		}

		/* cap the byte count for now */
		if (noct > n->gm.lss)
				noct = n->gm.lss;

		/* and issue the command and wait for completion */
		struct wait_queue_head wh = WAIT_QUEUE_HEAD(wh);
		struct cmd_status st;
		ahci_issue_command(n->ad, n->pt, n->pmprt, disk_cmd_read, lba, noct, buf, &wh, &st);
		wait_on_event(&wh);
		if (st.state == cmd_state_completed) {
				return (ssize_t)st.bts_cur;
		} else {
				/* TODO: interprete TFS error code */
				return -1;
		}
}

ssize_t ata_write(struct inode* in, int fd, const void* buf, size_t noct)
{
		return -1;
}

int ata_close(struct inode* in, int fd)
{
		return -1;
}

off_t ata_lseek(struct inode* in, int fd, off_t offset, int ref)
{
		return -1;
}

int ata_unlink(struct inode* in0, struct inode* in1)
{
		if (in0 || !in1)
				return -EINVAL;

		/* only unlink in1 */
		/* should we do something? */
		if (__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) {
				/* we could unmount? */
				struct ata_node* n = in1->in_pddat;
				cprintf(KFMT_INFO, "ATA device at dev/%s reached link count zero.\n", n->name);
		}
}

