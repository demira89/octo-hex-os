/* pci.c : Implements the PCI subsystem for hardware detection
 * */

#include "limits.h"
#include "kernel.h"
#include "kdata.h"
#include "pci_regs.h"
#include "pci.h"
#include "module.h"


struct dle {
		struct list_head devices;
		struct pci_device dev;
} device_list = { .dev = {0}, .devices = LIST_HEAD_INIT(device_list.devices) };

const char* pci_get_class_string(uint8_t cls)
{
		switch (cls) {
		case 0:
				return "(old device)";
		case 1:
				return "mass storage controller";
		case 2:
				return "network controller";
		case 3:
				return "display controller";
		case 4:
				return "multimedia controller";
		case 5:
				return "memory controller";
		case 6:
				return "bridge device";
		case 7:
				return "simple communication controllers";
		case 8:
				return "base system peripherials";
		case 9:
				return "input devices";
		case 10:
				return "docking stations";
		case 11:
				return "processors";
		case 12:
				return "serial bus controllers";
		case 13:
				return "wireless controllers";
		case 14:
				return "intelligent I/O controllers";
		case 15:
				return "satellite communication controllers";
		case 16:
				return "encryption/decryption controllers";
		case 17:
				return "data acquisiton and signal processing controllers";
		case 0xff:
				return "no fitting class";
		default:
				return "(reserved)";
		}
}

const char* pci_get_subclass_string(uint8_t cls, uint8_t scls, uint8_t progIf)
{
		if (cls == 0)
				if (scls == 0)
						return "any device (not VGA compatible)";
				else if (scls == 1)
						return "VGA compatible";
				else
						return "(invalid)";
		else if (cls == 1)
				if (scls == 0)
						return "SCSI bus controller";
				else if (scls == 1)
						return "IDE controller";
				else if (scls == 3)
						return "IPI bus controller";
				else if (scls == 4)
						return "RAID controller";
				else if (scls == 5)
						if (progIf == 0x20)
								return "ATA controller (single DMA)";
						else if (progIf == 0x30)
								return "ATA controller (chained DMA)";
						else
								return "ATA controller (unknown interface)";
				else if (scls == 6)
						if (progIf == 0)
								return "SATA (vendor interface)";
						else if (progIf == 1)
								return "SATA (AHCI 1.0)";
						else
								return "SATA (unknown interface)";
				else if (scls == 7)
						return "Serial Attached SCSI (SAS)";
				else if (scls == 0x80)
						return "other mass storage controller";
				else
						return "unrecognized mass storage controller";
		else if (cls == 2)
				if (scls == 0)
						return "Ethernet controller";
				else if (scls == 1)
						return "Token ring controller";
				else if (scls == 2)
						return "FDDI controller";
				else if (scls == 3)
						return "ATM controller";
				else if (scls == 4)
						return "ISDN controller";
				else if (scls == 5)
						return "WorldFip controller";
				else if (scls == 6)
						return "PICMG 2.14 Multi Computing";
				else if (scls == 0x80)
						return "other network controller";
				else
						return "unrecognized network controller";
		else if (cls == 3)
				if (scls == 0)
						if (progIf == 0)
								return "VGA-compatible controller";
						else if (progIf == 1)
								return "8512-compatible controller";
						else
								return "unkown sc0 display controller";
				else if (scls == 1)
						return "XGA controller";
				else if (scls == 2)
						return "3D controller (no VGA)";
				else if (scls == 0x80)
						return "other video controller";
				else
						return "unrecognized video controller";
		else if (cls == 4)
				if (scls == 0)
						return "video device";
				else if (scls == 1)
						return "audio device";
				else if (scls == 2)
						return "Computer telephony device";
				else if (scls == 0x80)
						return "other media device";
				else
						return "unrecongnized media device";
		else if (cls == 5)
				if (scls == 0)
						return "RAM controller";
				else if (scls == 1)
						return "flash controller";
				else if (scls == 0x80)
						return "other memory controller";
				else
						return "unrecognized memory controller";
		else if (cls == 6)
				if (scls == 0)
						return "Host bridge";
				else if (scls == 1)
						return "ISA bridge";
				else if (scls == 2)
						return "EISA bridge";
				else if (scls == 3)
						return "MCA bridge";
				else if (scls == 4)
						if (progIf == 0)
								return "PCI-to-PCI bridge";
						else if (progIf == 1)
								return "PCI-to-PCI bridge (subtractive decode)";
						else
								return "possibly PCI-to-PCI bridge";
				else if (scls == 5)
						return "PCMCIA bridge";
				else if (scls == 6)
						return "NuBus bridge";
				else if (scls == 7)
						return "CardBus bridge";
				else if (scls == 8)
						return "RACEway bridge";
				else if (scls == 9)
						if (progIf == 0x40)
								return "PCI-to-PCI bridge (ST, pri)";
						else if (progIf == 0x80)
								return "PCI-to-PCI bridge (ST, sec)";
						else
								return "possibly PCI-to-PCI bridge (ST)";
				else if (scls == 10)
						return "InfiniBand-to-PCI host bridge";
				else if (scls == 0x80)
						return "other bridge device";
				else
						return "unrecognized bridge device";
		else if (cls == 7)
				if (scls == 0)
						if (progIf == 0)
								return "generic XT-compatible serial controller";
						else if (progIf == 1)
								return "16450-compatible serial controller";
						else if (progIf == 2)
								return "16550-compatible serial controller";
						else if (progIf == 3)
								return "16650-compatible serial controller";
						else if (progIf == 4)
								return "16750-compatible serial controller";
						else if (progIf == 5)
								return "16850-compatible serial controller";
						else if (progIf == 6)
								return "16950-compatible serial controller";
						else
								return "other serial controller";
				else if (scls == 1)
						if (progIf == 0)
								return "parallel port";
						else if (progIf == 1)
								return "bidirectional parallel port";
						else if (progIf == 2)
								return "ECP 1.x compliant parallel port";
						else if (progIf == 3)
								return "IEEE 1284 controller";
						else if (progIf == 0xfe)
								return "IEEE 1284 target device";
						else
								return "other parallel device";
				else if (scls == 2)
						return "multiport serial controller";
				else if (scls == 3)
						if (progIf == 0)
								return "generic modem";
						else if (progIf <= 4)
								return "Hayes compatible modem (see progIf for details)";
						else
								return "other modem";
				else if (scls == 4)
						return "IEEE 488.1/2 (GPIB) controller";
				else if (scls == 5)
						return "SmartCard";
				else if (scls == 0x80)
						return "other communications device";
				else
						return "unrecognized communications device";
		else if (cls == 8)
				if (scls == 0)
						if (progIf == 0)
								return "generic 8259 PIC";
						else if (progIf == 1)
								return "ISA PIC";
						else if (progIf == 2)
								return "EISA PIC";
						else if (progIf == 0x10)
								return "I/O APIC";
						else if (progIf == 0x20)
								return "I/O(x) APIC";
						else
								return "other interrupt controller";
				else if (scls == 1)
						if (progIf == 0)
								return "generic 8237 DMA controller";
						else if (progIf == 1)
								return "ISA DMA controller";
						else if (progIf == 2)
								return "EISA DMA controller";
						else
								return "other DMA controller";
				else if (scls == 2)
						if (progIf == 0)
								return "generic 8254 system timer";
						else if (progIf == 1)
								return "ISA system timer";
						else if (progIf == 2)
								return "EISA system timer";
						else
								return "other system timer";
				else if (scls == 3)
						if (progIf == 0)
								return "generic RTC controller";
						else if (progIf == 1)
								return "ISA RTC controller";
						else
								return "other RTC controller";
				else if (scls == 4)
						return "generic PCI Hot-Plug controller";
				else if (scls == 0x80)
						return "other system peripheral";
				else
						return "unrecognized system peripheral";
		else if (cls == 9)
				if (scls == 0)
						return "keyboard controller";
				else if (scls == 1)
						return "digitizer";
				else if (scls == 2)
						return "mouse controller";
				else if (scls == 3)
						return "scanner controller";
				else if (scls == 4)
						if (progIf == 0)
								return "Gameport controller (generic)";
						else if (progIf == 0x10)
								return "Gameport controller (legacy)";
						else
								return "other Gameport controller";
				else if (scls == 0x80)
						return "other input controller";
				else
						return "unrecognized input controller";
		else if (cls == 10)
				if (scls == 0)
						return "generic docking station";
				else if (scls == 0x80)
						return "other docking station";
				else
						return "unrecognized docking station";
		else if (cls == 11)
				if (scls == 0)
						return "386 processor";
				else if (scls == 1)
						return "486 processor";
				else if (scls == 2)
						return "Pentiu processor";
				else if (scls == 0x10)
						return "Alpha processor";
				else if (scls == 0x20)
						return "PowerPC processor";
				else if (scls == 0x30)
						return "MIPS processor";
				else if (scls == 0x40)
						return "coprocessor";
				else
						return "unrecognized processor";
		else if (cls == 12)
				if (scls == 0)
						if (progIf == 0)
								return "IEEE 1394 controller (FireWire)";
						else if (progIf == 0x10)
								return "IEEE 1394 controller (OpenHCI)";
						else
								return "unrecognized FireWire-compatible controller";
				else if (scls == 1)
						return "ACCESS bus";
				else if (scls == 2)
						return "SSA";
				else if (scls == 3)
						if (progIf == 0)
								return "USB (universal host controller)";
						else if (progIf == 0x10)
								return "USB (open host controller)";
						else if (progIf == 0x20)
								return "USB2 host controller (EHCI)";
						else if (progIf == 0x30)
								return "USB3 host controller (xHCI)";
						else if (progIf == 0x80)
								return "USB";
						else if (progIf == 0xfe)
								return "USB (not host controller)";
						else
								return "unrecognized USB controller";
				else if (scls == 4)
						return "Fibre channel";
				else if (scls == 5)
						return "SMBus";
				else if (scls == 6)
						return "InfiniBand";
				else if (scls == 7)
						if (progIf == 0)
								return "IPMI SMIC interface";
						else if (progIf == 1)
								return "IPMI kbd controller style interface";
						else if (progIf == 2)
								return "IPMI block transfer interface";
						else
								return "unrecognized IMPI interface";
				else if (scls == 8)
						return "SERCOS interface (IEC61491)";
				else if (scls == 9)
						return "CANbus";
				else
						return "other bus interface";
		else if (cls == 13)
				if (scls == 0)
						return "iRDA compatible controller";
				else if (scls == 1)
						return "consumer IR controller";
				else if (scls == 0x10)
						return "RF controller";
				else if (scls == 0x11)
						return "Bluetooth controller";
				else if (scls == 0x12)
						return "Broadband controller";
				else if (scls == 0x20)
						return "Ethernet controller (802.11a)";
				else if (scls == 0x21)
						return "Ethernet controller (802.11b)";
				else if (scls == 0x80)
						return "other wireless controller";
				else
						return "unrecognized wireless controller";
		else if (cls == 14)
				if (scls == 0)
						if (progIf == 0)
								return "Message FIFO";
						else
								return "I20 architecture";
				else
						return "other intelligent I/O controller";
		else if (cls == 15)
				if (scls == 1)
						return "TV controller";
				else if (scls == 2)
						return "audio controller";
				else if (scls == 3)
						return "voice controller";
				else if (scls == 4)
						return "data controller";
				else
						return "other satellite controller";
		else if (cls == 16)
				if (scls == 0)
						return "network and computing de/en-cryption";
				else if (scls == 0x10)
						return "entertainent de/en-cryption";
				else if (scls == 0x80)
						return "other de/en-cryption";
				else
						return "unrecognized de/en-cryption";
		else if (cls == 17)
				if (scls == 0)
						return "DPIO modules";
				else if (scls == 1)
						return "performance conters";
				else if (scls == 0x10)
						return "communications synch plus time and freq test/measurement";
				else if (scls == 0x20)
						return "management card";
				else if (scls == 0x80)
						return "other data acquisition/signal processing controller";
				else
						return "unrecognized data acquisition/signal processing controller";
		else if (cls == 0xff)
				return "device not fitting defined class";
		else
				return "unrecognized device class";
		return "(unknown)";
}

int pci_disable_interrupts(struct pci_device* d)
{
		union pca a = d->addr; uint32_t dat;
		a.reg_no = PCI_COMMAND;
		dat = pci_read(a);
		if (dat & PCI_COMMAND_INTX_DISABLE)
				return 0;
		/* we have to disable */
		dat |= PCI_COMMAND_INTX_DISABLE;
		pci_write(a, dat);
		/* check for success */
		dat = pci_read(a);
		return !(dat & PCI_COMMAND_INTX_DISABLE);
}

int pci_enable_interrupts(struct pci_device* d)
{
		union pca a = d->addr; uint32_t dat;
		a.reg_no = PCI_COMMAND;
		dat = pci_read(a);
		if (!(dat & PCI_COMMAND_INTX_DISABLE))
				return 0;
		/* we have to enable */
		dat &= 0xffff0000 | ~(PCI_COMMAND_INTX_DISABLE);
		pci_write(a, dat);
		/* check for success */
		dat = pci_read(a);
	//	cprintf(KFMT_ERROR, "New COMMAND: %08X\n", dat);
		return !!(dat & PCI_COMMAND_INTX_DISABLE);
}

void pci_print_is(union pca ad)
{
		int rv;
		ad.reg_no = PCI_STATUS;
		rv = !!(pci_read_word(ad) & PCI_STATUS_INTERRUPT);
		printf("PCI IS: %d\n", rv);
}

int pci_set_master(struct pci_device* d)
{
		union pca a = d->addr; uint32_t dat;
		a.reg_no = PCI_COMMAND;
		dat = pci_read(a);
		if (dat & PCI_COMMAND_MASTER)
				return 0;
		/* we have to enable */
		dat &= 0xffff0000 | ~(PCI_COMMAND_MASTER);
		pci_write(a, dat);
		/* check for success */
		dat = pci_read(a);
		return !(dat & PCI_COMMAND_MASTER);
}

int pci_check_interrupt(struct pci_device* d)
{
		union pca a = d->addr;
		a.reg_no = PCI_STATUS;
		if (pci_read_word(a) & PCI_STATUS_INTERRUPT)
				return 1;
		return 0;
}

struct pci_device* pci_find_device(uint8_t cls, uint8_t subcls, uint8_t ifc, int ct)
{
		struct dle* d; struct pci_device* rv = NULL;
		lock_list(device_list.devices);
		list_for_each_entry(d, &device_list.devices, devices) {
				if (d->dev.device_class == cls && d->dev.device_subclass == subcls) {
						if (d->dev.device_interface == ifc || ifc == 0xff) {
								if (!ct--) {
										rv = &d->dev;
										goto exit;
								}
						}
				}
		}
exit:
		unlock_list(device_list.devices);
		return rv;
}

void pci_set_bar(struct pci_device* dev, uint32_t i, uint32_t tp, uint64_t ofs)
{
		union pca addr = dev->addr;
		if (i > 5)
				return;
		addr.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
		uint32_t dat;
		dat = pci_read(addr);
		if ((dat & 0xf) != tp) /* only I/O space for those */
				return;
		if (i > 5 || ((tp & PCI_BAR_64_BIT) && i == 5))
				return;
		if (tp & PCI_BAR_PIO) {
				dat = (dat & 0x3) | ((uint32_t)ofs & 0xfffc);
				pci_write(addr, dat);
				dat = pci_read(addr);
				dev->ressources[i].pio.base = (dat & 0xfffc);
		} else if (tp & PCI_BAR_16_BIT) {
				dat = (dat & 0xf) | ((uint32_t)ofs & 0x0000fff0);
				pci_write(addr, dat);
				dat = pci_read(addr);
				dev->ressources[i].mmio.base = (dat & 0xfff0);
		} else if (tp & PCI_BAR_64_BIT) {
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
				pci_write(addr, dat);
				addr.reg_no += 4;
				dat = (uint32_t)(ofs >> 32);
				pci_write(addr, dat);
				dat = pci_read(addr);
				dev->ressources[i].mmio.base = (uint64_t)dat << 32;
				addr.reg_no -= 4;
				dat = pci_read(addr);
				dev->ressources[i].mmio.base |= (dat & 0xfffffff0);
		} else {
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
				pci_write(addr, dat);
				dat = pci_read(addr);
				dev->ressources[i].mmio.base = (dat & 0xfffffff0);
		}
}

uint64_t pci_bar_get_size(struct pci_device* d, uint32_t i)
{
		union pca a = d->addr; uint32_t dat, datH;
		uint64_t rv = 0;
		if (i > 5)
				return 0;
		a.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
		dat = pci_read(a);
		if (dat & 1) { /* PIO */
				pci_write(a, 0xffff);
				rv = pci_read(a) & 0xfffc;
				pci_write(a, dat);
				rv = (uint64_t)(~(uint16_t)rv + 1);
		} else {
				uint32_t tp = (dat >> 1) & 0x3;
				if (tp == 2) {
						a.reg_no += 4;
						datH = pci_read(a);
						pci_write(a, 0xffffffff);
						a.reg_no -= 4;
						rv = (uint64_t)pci_read(a) << 32;
						pci_write(a, datH);
						a.reg_no -= 4;
				}
				/* write all ones */
				pci_write(a, 0xffffffff);
				rv |= (pci_read(a) & 0xfffffff0);
				pci_write(a, dat);
				if (tp == 2) {
						rv = ~rv + 1;
				} else if (tp == 1) {
						rv = (uint64_t)(~(uint16_t)rv + 1);
				} else {
						rv = (uint64_t)(~(uint32_t)rv + 1);
				}
		}
		return rv;
}

/* prevents MSIs from firing and also restricts the message count */
void pci_init_msi(struct pci_device* d)
{
		uint32_t dat; union pca a = d->addr;
		uint8_t n_c, n_e;

		/* read the MSI control register */
		if (!(a.reg_no = d->cap_ptrs[PCI_CAP_ID_MSI]))
				return; /* no MSI */
		dat = pci_read(a);
		n_c = (dat >> 1) & 0x7;
		n_e = (dat >> 4) & 0x7;

		cprintf(KFMT_INFO, "MSI cap: %u capable %u enable and status %u\n",
				n_c, n_e, dat & 1);
		if (n_e > 3) /* >8 */
				n_e = 3;

		/* write the new values */
		dat = (dat & 0xffffff8e) | (n_e << 4);
		pci_write(a, dat);

		/* and confirm */
		if (pci_read(a) != dat) {
				cprintf(KFMT_WARN, "Failed to configure PCI MSI data.\n");
				printf("%08x vs %08x\n", dat, pci_read(a));
				mdelay(1000);
		}
}

/* sets the cap infos */
void pci_add_caps(struct pci_device* d)
{
		uint32_t dat;
		union pca a = d->addr; /* 5h MSI, 10h PCIe, 14h MSI-X */

		/* first look for CAP support */
		a.reg_no = PCI_STATUS;
		dat = pci_read_word(a);
		if (!(dat & PCI_STATUS_CAP_LIST))
				return; /* we don't have to look for it */

		/* read the cap pointer */
		a.reg_no = ((d->device_type & 0x7f) == 2) ? PCI_CB_CAPABILITY_LIST
				: PCI_CAPABILITY_LIST;
		a.reg_no = pci_read_byte(a) & 0xfc; /* dword alignment */

		/* and continue in the list */
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
				union pci_capability cap;
				cap.val = pci_read(a);

				/* add the pointer */
				if (!(cap.cap > PCI_CAP_ID_MAX))
						d->cap_ptrs[cap.cap] = a.reg_no;

				/* Check the types for specific information */
				switch (cap.cap) {
						case PCI_CAP_ID_PM:
								break;
						case PCI_CAP_ID_MSI:
								pci_init_msi(d);
								break;
						case PCI_CAP_ID_PCIX:
								break;
						case PCI_CAP_ID_MSIX:
								break;
				}

				if (!(a.reg_no = (cap.next & 0xfc))) /* end of list */
						break;
		}
}

void pci_add_bars(struct pci_device* d)
{
		union pca a = d->addr;
		uint8_t t = d->device_type & 0x7f;
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
				/* TODO: type1 prefetachble/non-pref ranges */
				int limit = d->device_type ? 2 : 6;
				a.reg_no = PCI_BASE_ADDRESS_0;
				for (int i = 0; i < limit; i++) {
						uint32_t dat = pci_read(a);
						if (dat & 1) { /* I/O space */
								d->ressources[i].type = PCI_BAR_PIO;
								d->ressources[i].pio.base = dat & 0xfffc;
								/* for getting count we would have to change it */
								d->ressources[i].pio.count = 0;
								/* which is safe if unassigned */
								if (1/*d->ressources[i].pio.base == 0*/)
										d->ressources[i].pio.count = pci_bar_get_size(d, i);
						} else { /* MMIO */
								uint8_t tp = (dat >> 1) & 0x3;
								d->ressources[i].type = dat & 0xf;
								if (tp == 2) { /* 64-bit */
										d->ressources[i].mmio.base = dat & 0xfffffff0;
										d->ressources[i].mmio.size = 0;
										d->ressources[i].mmio.mapping = NULL;
										a.reg_no += 4; i++;
										d->ressources[i].mmio.base |=
												((uint64_t)pci_read(a) << 32);
								} else {
										d->ressources[i].mmio.base = dat & 0xfffffff0;
										d->ressources[i].mmio.size = 0;
										d->ressources[i].mmio.mapping = NULL;
								}
								/* we can get the size w/o affecting operation */
								if (1/*d->ressources[i].mmio.base == 0*/)
										d->ressources[i].mmio.size = pci_bar_get_size(d, i);
						}
						a.reg_no += 4;
				}
		} else if (t == 2) { /* PCI-to-CardBus bridge */
				/* with clear limits */
				a.reg_no = 0x1c;
				for (int i = 0; i < 4; i++) {
						uint32_t base = pci_read(a), limit;
						a.reg_no += 4;
						limit = pci_read(a);
						if (i < 2) { /* memory */
								d->ressources[i].type = PCI_BAR_MMIO;
								d->ressources[i].mmio.base = base;
								d->ressources[i].mmio.size = limit - base;
						} else { /* PIO */
								d->ressources[i].type = PCI_BAR_PIO;
								d->ressources[i].pio.base = base;
								d->ressources[i].pio.count = limit - base;
						}
				}
		}
}

void pci_enumerate_devices()
{
		union pca pca = {0};
		uint32_t bus, dev;
		printf("Enumerating PCI devices:\n");
		for (bus = 0; bus < 256; bus++)
				for (dev = 0; dev < 32; dev++) {
						uint32_t dat, fno = 0;
						pca.bus_no = bus;
						pca.device_no = dev;
						pca.enabled = 1;
multifun:
						pca.func_no = fno++;
						pca.reg_no = 0;
						pca.reserved =/* pca.zero =*/ 0;
						dat = pci_read(pca);
						if ((dat & 0xffff) != 0xffff) {
								int mf = 0; struct dle* le;
								le = kzalloc(sizeof(*le));
								/* device exists */
								le->dev.addr = pca;
								le->dev.identification = dat >> 16;
								le->dev.vendor = (dat & 0xffff);
								printf("devie at %02x:%02x.%x\n",
										pca.bus_no, pca.device_no, pca.func_no);
								printf("\tid:       %04x\n", (dat >> 16));
								printf("\tvendor:   %04x\n", (dat & 0xffff));
								pca.reg_no = 8;
								dat = pci_read(pca);
								le->dev.device_class = dat >> 24;
								le->dev.device_subclass = (dat >> 16) & 0xff;
								le->dev.device_interface = (dat >> 8) & 0xff;
								printf("\tclass:    %s\n",
									pci_get_class_string(dat >> 24));
								printf("\tsubclass: %s\n",
									pci_get_subclass_string(dat >> 24,
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
								/* check for ACPI (mass storage, 1-6-1) */
								//if ((dat >> 24 == 1) && (((dat >> 16) & 0xff) == 6))
								//		ahci_func(pca, (dat >> 8) & 0xff);
								//else if ((dat >> 24) == 1)
								//		mdelay(1000);
								pca.reg_no = 12;
								dat = pci_read(pca);
								dat = (dat >> 16) & 0xff;
								le->dev.device_type = dat;
								mf = dat & 0x80;
								printf("\tfunction: %s\n",
									(dat & 0x80) ? "multi" : "single");
								printf("\ttype:     %s\n",
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
									? ("PCI-to-PCI bridge") : ("CardBus bridge")));
								pca.reg_no = PCI_INTERRUPT_LINE;
								dat = pci_read(pca);
								le->dev.intr_pin = (dat >> 8) & 0xff;
								le->dev.intr_line = dat & 0xff;
								if (!le->dev.intr_pin || le->dev.intr_pin > 4)
										dat = ' ';
								else
										dat = 'A' + (le->dev.intr_pin - 1);
								printf("\tinterrupt: INT%c#  line: %u\n", (char)dat, le->dev.intr_line);
								printf("\n");
								pci_add_bars(&le->dev);
								pci_add_caps(&le->dev);
								list_add_tail(&le->devices, &device_list.devices);
								if (mf && fno < 8)
										goto multifun;
						} else if (fno && fno < 8)
								goto multifun; /* non-consecuitive layouts */
				}
}

int MODENTRY module_init()
{
		pci_enumerate_devices();
		return 0;
}

void MODENTRY module_cleanup()
{
		printf("goodbye pci.ko\n");
}

