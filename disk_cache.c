/* disk_cache.c : Implements a page-based disk cache,
 *                which is needed to hide the block-nature
 *                of disk devices and to accelerate random access.
 * */

#include "kernel.h"
#include "kdata.h"
#include "file.h"

struct list_head global_caches = LIST_HEAD_INIT(global_caches);

struct disk_cache {
		struct list_head lst;
		struct disk_geometry* gm;
		uint64_t num_pages; /* total count */
		uint64_t num_dirty_pages; /* until flush */
		uint64_t num_locked_pages; /* for mmap */
};

struct disk_cache* create_disk_cache(struct disk_geometry* gm)
{
		struct disk_cache* rv = kzalloc(sizeof(*rv));
}

