/* pci.h : Provides some basic defines for using the PCI bus.
 * */


#define PCI_CONFIG_ADDRESS 0xcf8
#define PCI_CONFIG_DATA    0xcfc

union pca {
		uint32_t val;
		struct {
		/*		uint32_t zero : 2;*/
				uint32_t reg_no : 8;
				uint32_t func_no : 3;
				uint32_t device_no : 5;
				uint32_t bus_no : 8;
				uint32_t reserved : 7;
				uint32_t enabled : 1;
		};
};

union pci_capability {
		struct {
				uint8_t cap;
				uint8_t next;
				/* possibly data */
				uint8_t dat[2];
		};
		uint32_t val;
};

struct pci_device {
		union pca addr;
		uint8_t device_class;
		uint8_t device_subclass;
		uint8_t device_interface;
		uint8_t device_type; /* multifunction; bridge; ... */
		uint8_t intr_pin;
		uint8_t intr_line;
		uint16_t vendor;
		uint16_t identification;
		uint8_t cap_ptrs[PCI_CAP_ID_MAX]; /* more than that? never! */
		struct pci_bar {
				int type;
				union {
						struct {
								uint64_t base;
								uint64_t size;
								void* mapping;
						} mmio;
						struct {
								uint16_t base;
								uint16_t count;
						} pio;
				};
		} ressources[6];
};

#define PCI_BAR_MMIO 0
#define PCI_BAR_PIO  1
#define PCI_BAR_32_BIT 0
#define PCI_BAR_64_BIT (1 << 2)
#define PCI_BAR_16_BIT (1 << 1)
#define PCI_BAR_PREFETCHABLE (1 << 3) /* MMIO+PREF */

static inline uint32_t pci_read(union pca a)
{
		outl(PCI_CONFIG_ADDRESS, a.val);
		io_wait();
		return inl(PCI_CONFIG_DATA);
}

/* PCI is little endian (status==06h --> high bits) */
static inline uint16_t pci_read_word(union pca a)
{
		uint16_t of = a.reg_no % 4;
		union pca a2 = a;
		uint32_t v1, v2 = 0;
		a2.reg_no -= of;
		v1 = pci_read(a2);
		if (of == 3) { /* very unaligned access */
				a2.reg_no += 4;
				v2 = pci_read(a2);
				v2 = (v2 << 8) & 0xff00;
		}
		v1 = (v1 >> 8 * of) & 0xffff;
		return (v1 | v2);
}

static inline uint8_t pci_read_byte(union pca a)
{
		uint8_t of = a.reg_no % 4;
		union pca a2 = a;
		a2.reg_no -= of;
		return (pci_read(a2) >> 8 * of) & 0xff;
}

static inline void pci_write(union pca a, uint32_t v)
{
		outl(PCI_CONFIG_ADDRESS, a.val);
		io_wait();
		outl(PCI_CONFIG_DATA, v);
}

static inline void pci_write_word(union pca a, uint16_t v)
{
		uint32_t val, of = a.reg_no % 4;
		union pca a2 = a;
		a2.reg_no -= of;
		if (of == 3) {
				/* write high half of v into low byte of a+4 */
				a.reg_no = a2.reg_no + 4;
				val = pci_read(a);
				val = (val & 0xffffff00) | (v >> 8);
				pci_write(a, val);
		}
		val = pci_read(a2);
		val &= ~(uint32_t)(0xffff << of * 8);
		val |= (uint32_t)v << of * 8;
		pci_write(a2, val);
}

static inline void pci_write_byte(union pca a, uint8_t v)
{
		uint32_t val, of = a.reg_no % 4;
		union pca a2 = a;
		a2.reg_no -= of;
		val = pci_read(a2);
		val &= ~(0xff << of * 8);
		val |= (uint32_t)v << of * 8;
		pci_write(a2, val);
}

/* Public PCI API for other modules */ /* ifc=0xff is any */
struct pci_device* pci_find_device(uint8_t cls, uint8_t subcls, uint8_t ifc, int ct);
const char* pci_get_class_string(uint8_t cls);
const char* pci_get_subclass_string(uint8_t cls, uint8_t scls, uint8_t progIf);
void pci_set_bar(struct pci_device* dev, uint32_t i, uint32_t tp, uint64_t ofs);
uint64_t pci_bar_get_size(struct pci_device* d, uint32_t i);
/* all return 0 on success 1 otherwise */
int pci_disable_interrupts(struct pci_device* d);
int pci_enable_interrupts(struct pci_device* d);
int pci_set_master(struct pci_device* d);
int pci_disable_msi(struct pci_device* d);
int pci_check_interrupt(struct pci_device* d);

