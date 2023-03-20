/* module.h : Definition for the generic module functions,
 *            which can be implemented by the individual modules
 *            to receive kernel notifications.
 * */

#define MODENTRY __attribute__ ((weak))

/* two mandatory functions */
int module_init() MODENTRY;
void module_cleanup() MODENTRY;

/* device notifications */
#define MOD_DN_ADD_DEVICE 1
#define MOD_DN_REM_DEVICE 2
#define MOD_DN_PWR_CHANGE 3
struct device;
void MODENTRY module_device_notifiy(struct device* dev, int type);

