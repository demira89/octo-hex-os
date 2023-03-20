/* partition.c : Implements the partitioning scheme defined
 *               in file.h for handling MBR and GPT partitions.
 * */

#include "limits.h"
#include "kernel.h"
#include "file.h"
#include "module.h"

void do_nothing()
{
		while (1);
}

