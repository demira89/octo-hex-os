/* floppy.c : Implements the floppy disk controller interface
 * */

#include "limits.h"
#include "kernel.h"
#include "module.h"


int MODENTRY module_init()
{
		printf("floppy.ko says hello\n");
		return 0;
}

void MODENTRY module_cleanup()
{
		printf("goodbye floppy.ko\n");
}


