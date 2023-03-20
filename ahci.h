/* ahci.h : Contains the definitions for the AHCI driver.
 * */

/* SATA definitions 
 * */
#define FIS_REG_H2D        0x27
#define FIS_REG_D2H        0x34
#define FIS_DMA_ACTIVATE   0x39 /* D2H */
#define FIS_DMA_SETUP      0x41 /* Bi-directional */
#define FIS_DATA           0x46 /* Bi-directional */
#define FIS_BIST_ACTIVATE  0x58 /* BD */
#define FIS_PIO_SETUP      0x5f /* D2H */
#define FIS_SET_DEVICE_BIT 0xa1 /* D2H */
#define FIS_RES_1          0xa6
#define FIS_RES_2          0xb8
#define FIS_RES_3          0xbf
#define FIS_RES_4          0xd9
#define FIS_VENDOR_1       0xc7
#define FIS_VENDOR_2       0xd4

/* Info: reserved=0 */
struct sata_reg_h2d {
		uint8_t fis_type;
		uint8_t pm_port : 4;
		uint8_t res0 : 3;
		uint8_t c : 1; /* 1: command, 0: control */
		uint8_t command; /* command register */
		uint8_t feat_low; /* bits 0-7 of features */
		uint32_t lba_low : 24; /* bits 0-23 of LBA */
		uint32_t device : 8; /* device register */
		uint32_t lba_high : 24; /* bits 24-47 of LBA48 */
		uint32_t feat_high : 8; /* bits 8-15 of features */
		uint16_t count; /* sector & exp. addr. count */
		uint8_t icc; /* time limit for completion */
		uint8_t control; /* if control */
		uint32_t res1;
} __attribute__ ((packed));

struct sata_reg_d2h {
		uint8_t fis_type;
		uint8_t pm_port : 4;
		uint8_t res1 : 2;
		uint8_t I : 1; /* interrupt flag */
		uint8_t res2 : 1;
		uint8_t status;
		uint8_t error;
		uint32_t lba_low : 24;
		uint32_t device : 8;
		uint32_t lba_high : 24;
		uint32_t res3 : 8;
		uint16_t count;
		uint8_t res4[6];
} __attribute__ ((packed));

/* ATA/ATAPI definitions
 * */
#define ATA_SC_NEED_SPIN_UP_INC 0x37c8 /* fetch identify after spin-up */
#define ATA_SC_NEED_SPIN_UP     0x738c /* identify data valid */
#define ATA_SC_NO_SPIN_UP_INC   0x8c73 /* incomplete, but no spin-up */
#define ATA_SC_NO_SPIN_UP       0xc837 /* complete, no further action req. */
struct ata_identify {
		/* word 0 */
		uint16_t res0 : 2;
		uint16_t is_incomplete : 1;
		uint16_t res1 : 12;
		uint16_t is_not_ata : 1;
		/* word 1: obsolete */
		uint16_t w1;
		/* word 2: specific configuration */
		uint16_t specific_configuration; /* ATA_SC_ */
		/* words 3-6: obsolete */
		uint16_t w3to6[4];
		/* words 7-8: CFA */
		uint16_t cfa[2];
		/* word 9: obsolete */
		uint16_t w9;
		/* words 10-19: serial number */
		uint16_t serial_number[10]; /* ATA string (i.e. ABCDEF -> BADCFE)*/
		/* words 20-22: obsolete/retired */
		uint16_t w20to22[3];
		/* words 23-26: firmware revision (ATA str) */
		uint16_t firmware_rev[4];
		/* words 27-46: model number */
		uint16_t model_number[20];
		/* word 47: 0x80XX XX=max DRQ */
		uint16_t max_drq : 8; /* in READ/WRITE MULTIPLE */
		uint16_t w47_80h : 8;
		/* word 48: TrustedComputing feature bits */
		uint16_t tc_features; /* bit0 = TC supported */
		/* word 49-50: Capabilities */
		uint16_t cap_align_err : 2; /* LPS: 00 no rep, 01 align. err, 10 abort instead, 11 res. */
		uint16_t w49_res1 : 6;
		uint16_t dma_supp : 1; /* ATA, SATA always 1 */
		uint16_t lba_supp : 1; /* always 1 */
		uint16_t iordy_disable_supp : 1; /* SATA 11 */
		uint16_t iordy_supp : 1;
		uint16_t w49_ipd_res : 1; /* IDENTIFY PACKET specific */
		uint16_t uses_std_tmr_def : 1; /* Standby timer values from Table 52 */
		uint16_t w49_res2 : 2;
		uint16_t has_min_tmr_val : 1; /* Minimum standby timer value exists */
		uint16_t w50_res : 13;
		uint16_t w50_one : 1;
		uint16_t w50_zero : 1;
		/* words 51-52: obsolete */
		uint16_t w51to52[2];
		/* word 53: */
		uint16_t w53_res1 : 1;
		uint16_t pio_mode3_supp : 1; /* ATA -> words 64-70 valid; SATA always 1 */
		uint16_t udma_supp : 1; /* ATA: only together with word 88, SATA 1 */
		uint16_t w53_res2 : 5;
		uint16_t ff_sensitivity : 8; /* FREE-FALL SENSITIVITY (0-ff increasing) */
		/* words 54-58: obsolete */
		uint16_t w54to58[5];
		/* word 59: more details */
		uint16_t sectors_per_drq : 8;
		uint16_t multi_logic_sectors : 1; /* using multiple log sec is valid */
		uint16_t w59_res1 : 1;
		uint16_t has_sanitize_atifreeze_lock_ext : 1;
		uint16_t sanitize_allowed_is_acs3 : 1; /* else ACS-2 */
		uint16_t has_sanitize : 1;
		uint16_t has_crypto_scramble_ext : 1;
		uint16_t has_overwrite_ext : 1;
		uint16_t has_block_erase_ext : 1;
		/* words 60-61: LBA28 limit DWORD */
		uint32_t max_lba28; /* 0ffffffff -> more */
		/* word 62: obsolete */
		uint16_t w62;
		/* word 63: multiword DMA (PATA) */
		uint16_t mw_dma_m0_supp : 1;
		uint16_t mw_dma_m1_supp : 1;
		uint16_t mw_dma_m2_supp : 1;
		uint16_t mw_dma_res : 5;
		uint16_t mw_dma_m0_sel : 1;
		uint16_t mw_dma_m1_sel : 1;
		uint16_t mw_dma_m2_sel : 1;
		uint16_t mw_dma_res_sel : 5;
		/* word 64: PATA PIO details */
		uint16_t pio_mode_3_supp : 1;
		uint16_t pio_mode_4_supp : 1;
		uint16_t w64_res : 14;
		/* word 65: PATA minimum cycle time DMA per word */
		uint16_t mw_dma_min_time;
		/* word 66: PATA manufactor cylcle time */
		uint16_t mw_dma_rec_time;
		/* word 67: PATA min PIO cycle time */
		uint16_t pio_min_time;
		/* word 68: PATA min PIO cylce time with IORDY */
		uint16_t pio_min_iordy_time;
		/* word 69: additional supported */
		uint16_t w69_res : 2;
		uint16_t non_volatile_write_cache : 1; /* <--- IMPORTANT INFO */
		uint16_t has_ext_num_sectors : 1; /* user addressible */
		uint16_t has_encryption : 1; /* of user data */
		uint16_t trim_returns_zero : 1; /* Reads to TRIM area returns 0 */
		uint16_t no_optional_lba28_cmds : 1;
		uint16_t iee1667_res : 1;
		uint16_t has_download_microcode_dma : 1;
		uint16_t w69_res2 : 1;
		uint16_t has_write_buffer_dma : 1;
		uint16_t has_read_buffer_dma : 1;
		uint16_t w69_res3 : 1;
		uint16_t has_lps_align_error_rep : 1; /* LPS errors working (see above) */
		uint16_t trim_returns_deterministic : 1; /* TRIM returns non-random data */
		uint16_t w69_cfa_res : 1;
		/* word 70 and 71-74: Reserved and res. for ATAPI */
		uint16_t w70to74[5];
		/* word 75: SATA queue depth */
		uint16_t w75_res : 11;
		uint16_t sata_queue_depth : 5; /* N-1 (for NCQ) */
		/* word 76: SATA capabilities */
		uint16_t sata_caps_invalid : 1; /* is zero */
		uint16_t sata_spd_gen_1 : 1;
		uint16_t sata_spd_gen_2 : 1;
		uint16_t sata_spd_gen_3 : 1;
		uint16_t sata_spd_gen_x : 4;
		uint16_t sata_has_ncq : 1;
		uint16_t sata_accepts_host_pm : 1; /* host IPM -> device */
		uint16_t sata_has_phy_event_counter_log : 1;
		uint16_t sata_has_unload_while_ncq : 1; /* can UNLOAD with NCQ */
		uint16_t sata_ncq_prioirties : 1; /* supported? 1 */
		uint16_t sata_ipm_auto_p2s_supp : 1;
		uint16_t sata_ipm_dev_dauto_p2s_supp : 1;
		uint16_t sata_has_read_log_dma_ext : 1; /* analogous to READ_LOG_EXT */
		/* word 77: more SATA caps */
		uint16_t sata_caps2_invalid : 1;
		uint16_t sata_cur_spd : 3; /* up to 7/8 */
		uint16_t sata_has_ncq_stream : 1;
		uint16_t sata_has_ncq_queue_mgmt : 1;
		uint16_t sata_has_fpdma_queued : 1; /* SEND/RECEIVE FPDMA QUEUED */
		uint16_t sata_caps2_res : 9;
		/* word 78: SATA features */
		uint16_t sata_features_invalid : 1;
		uint16_t sata_has_nonzero_buffer_offsets : 1; /* <- Important for PRDT? */
		uint16_t sata_has_dma_auto_setup : 1;
		uint16_t sata_device_initiates_pm : 1; /* power (not port) */
		uint16_t sata_in_order_delivery : 1;
		uint16_t sata_hw_feature_control : 1;
		uint16_t sata_has_sw_settings_preservation : 1;
		uint16_t sata_has_ncq_autosense : 1;
		uint16_t sata_feat_res : 8;
		/* word 79: SATA features enabled? */
		uint16_t sata_features_enabled; /* la meme chose qu'avant */
		/* word 80: ATA standard revision (OK if != 0 or ffff)*/
		uint16_t ata_version_major;
		/* word 81: ATA minor version, except for 0 amd ffff */
		uint16_t ata_version_minor;
		/* word 82: commands and features (both versions) */
		uint16_t has_smart : 1;
		uint16_t has_security_features : 1;
		uint16_t w82_res : 1;
		uint16_t has_power_mgmt : 1; /* set to one */
		uint16_t has_packet : 1; /* set to zero */
		uint16_t has_volatile_write_cache : 1;
		uint16_t has_read_look_ahead : 1;
		uint16_t w82_res2 : 2;
		uint16_t has_device_reset : 1; /* set to zero */
		uint16_t w82_res3 : 2;
		uint16_t has_write_buffer : 1;
		uint16_t has_read_buffer : 1;
		uint16_t has_nop : 1;
		uint16_t w82_res4 : 1;
		/* word 83: continuation */
		uint16_t has_download_microcode : 1;
		uint16_t w83_res : 1;
		uint16_t w83_cfa : 1;
		uint16_t has_apm : 1; /* advanced power mgmt */
		uint16_t w83_res2 : 1;
		uint16_t has_puis : 1; /* puis tout est bon, no? */
		uint16_t spinup_by_set_features : 1; /* IMPORTANT */
		uint16_t w83_res3 : 3;
		uint16_t has_lba48 : 1;
		uint16_t w83_res4 : 1;
		uint16_t has_flush_cache : 1; /* set to one */
		uint16_t has_flush_cache_ext : 1;
		uint16_t w83_one : 1; /* is 1 in ACS-3 */
		uint16_t w83_zero : 1; /* prolly zero, innit? */
		/* word 84: even more */
		uint16_t has_smart_error_log : 1;
		uint16_t has_smart_self_test : 1;
		uint16_t w84_res : 2;
		uint16_t has_stream : 1; /* STREAM commands */
		uint16_t has_gpl : 1; /* GPL features */
		uint16_t has_write_fua_ext : 1; /* WRITE (DMA/MULTIPLE) FUA EXT */
		uint16_t w84_res2 : 1;
		uint16_t has_ww_name : 1; /* always one */
		uint16_t w84_res3 : 4;
		uint16_t has_idle_immediate_unload : 1;
		uint16_t w84_one : 1;
		uint16_t w84_zero : 1;
		/* word 85: more more until 87 */
		uint16_t smart_enabled : 1;
		uint16_t security_enabled : 1;
		uint16_t w85_res : 1;
		uint16_t pm_enabled : 1; /* set to one */
		uint16_t packet_enabled : 1; /* set to zero */
		uint16_t volatile_wc_enabled : 1; /* IMPORTANT one */
		uint16_t read_look_ahead_enabled : 1;
		uint16_t w85_res2 : 5;
		uint16_t w85_copy_of_w82 : 4;
		/* word 86: only two left */
		uint16_t has_download_microcode_alt : 1;
		uint16_t w86_res : 1;
		uint16_t w86_cfa_res : 1;
		uint16_t apm_enabled : 1;
		uint16_t w86_res2 : 1;
		uint16_t puis_enabled : 1; /* encore tout est bon! */
		uint16_t spinup_by_set_features_alt : 1;
		uint16_t w86_res3 : 3;
		uint16_t has_lba48_alt : 1;
		uint16_t w86_res4 : 1;
		uint16_t has_flush_cache_alt : 1;
		uint16_t has_flush_cache_ext_alt : 1;
		uint16_t w86_res5 : 1;
		uint16_t has_w119to120 : 1; /* TODO: name appropiately */
		/* word 87: the last one of the duplicates */
		uint16_t has_smart_error_log_alt : 1;
		uint16_t has_smart_self_test_alt : 1;
		uint16_t has_media_serial_number : 1;
		uint16_t w87_res : 2;
		uint16_t has_gpl_alt : 1;
		uint16_t has_write_fua_ext_alt : 1; /* WRITE DMA/MULTIPLE FUA EXT */
		uint16_t w87_res2 : 1;
		uint16_t has_ww_name_alt : 1;
		uint16_t w87_res3 : 4;
		uint16_t has_idle_immediate_unload_alt : 1;
		uint16_t w87_one : 1;
		uint16_t w87_zero : 1;
		/* word 88: PATA UDMA modes */
		uint16_t udma_support : 8; /* bitfield mode 0-6 7 nonexistant */
		uint16_t udma_selected : 8;
		/* word 89: NORMAL SECURITY ERASE TIME (O) */
		uint16_t security_erase_time : 15;
		uint16_t security_erase_time_is_ext : 1; /* else only 1 byte */
		/* word 90: ENHANCED SECURITY ERASE TIME (O) */
		uint16_t enh_security_erase_time : 15;
		uint16_t enh_security_erase_time_is_ext : 1;
		/* word 91: APM level */
		uint16_t apm_level : 8;
		uint16_t w91_res : 8;
		/* word 92: master password identifier */
		uint16_t master_pw_identifier;
		/* word 93: hardware reset results; 0 for SATA */
		uint16_t hw_reset_result; /* CSEL etc. in PATA */
		/* word 94: obsolete */
		uint16_t w94;
		/* word 95: STREAM minimum request size */
		uint16_t stream_min_request_size;
		/* word 96: STREAM transfer time DMA */
		uint16_t stream_transfer_time;
		/* word 97: STREAM access latency */
		uint16_t stream_access_latency;
		/* words 98+99: STREAM performance granularity */
		uint32_t stream_perf_gran;
		/* words 100-103: number of user addressable logical sectors */
		uint64_t num_logical_sectors; /* depends on LBA24/48; Mandatory if has_lba48 */
		/* word 104: STREAM transfer time PIO */
		uint16_t stream_pio_transfer_time;
		/* word 105: max blocks per DATA SET MANAGEMENT */
		uint16_t max_blocks_per_data_set_mgmt;
		/* word 106: physical/logical sector assignment */
		uint16_t num_pwr2_logical_per_phys : 4;
		uint16_t w106_res : 8;
		uint16_t logical_sector_longer_than_512bt : 1;
		uint16_t has_multiple_logical_per_physical_sectors : 1;
		uint16_t w106_one : 1;
		uint16_t w106_zero : 1; /* prolly existance flags */
		/* word 107: ISO/IEC 7779 acoustic test delay */
		uint16_t w107; /* who cares? */
		/* words 108-111: world wide name */
		uint16_t ww_name[4]; /* WWN: NAA IEEE designator SPC-4 /w NAA=5h Tbl A33 */
		/* words 112-115: WWN extension */
		uint16_t ww_name_ext[4];
		/* word 116: obsolete */
		uint16_t w116;
		/* words 117-118: logical sector size */
		uint32_t logical_sector_size; /* word count if w106>512bt */
		/* word 119: commands and features supported (cont.) */
		uint16_t w119_res : 1;
		uint16_t has_write_read_verify : 1;
		uint16_t has_write_uncorrectable_ext : 1;
		uint16_t has_log_dma_ext : 1;
		uint16_t has_download_microcode_mode3 : 1;
		uint16_t has_free_fall_control : 1;
		uint16_t has_sense_data_reporting : 1;
		uint16_t has_epc_features : 1;
		uint16_t has_accessible_max_addr_features : 1;
		uint16_t has_dsn_features : 1;
		uint16_t w119_res2 : 4;
		uint16_t w119_one : 1;
		uint16_t w119_zero : 1;
		/* word 120: meme chose, mais avec enabled aussi */
		uint16_t w120_res : 1;
		uint16_t write_read_verify_enabled : 1;
		uint16_t has_write_uncorrectable_ext_alt : 1;
		uint16_t has_log_dma_ext_alt : 1;
		uint16_t has_download_microcode_mode3_alt : 1;
		uint16_t has_free_fall_control_alt : 1;
		uint16_t has_sense_data_reporting_alt : 1;
		uint16_t has_epc_features_alt : 1;
		uint16_t w120_res2 : 1;
		uint16_t has_dsn_features_alt : 1;
		uint16_t w120_res3 : 4;
		uint16_t w120_one : 1;
		uint16_t w120_zero : 1;
		/* words 121-126: reserved for even more */
		uint16_t res_settings[6];
		/* word 127: obsolete */
		uint16_t w127;
		/* word 128: optional SECURITY status */
		uint16_t sec_has_security : 1;
		uint16_t sec_enabled : 1;
		uint16_t sec_locked : 1;
		uint16_t sec_frozen : 1;
		uint16_t sec_count_expired : 1;
		uint16_t sec_has_enh_erase : 1;
		uint16_t sec_res : 2;
		uint16_t sec_has_master_pw : 1; /* 0=high, 1=max */
		uint16_t sec_res2 : 7;
		/* words 129-159: vendor specific */
		uint16_t w_vendor[31];
		/* words 160-167 CFA */
		uint16_t w_cfa[8];
		/* word 168: NOMINAL FORM FACTOR (0; 1-4: 5.25, 3.5, 2.5, 1.8; 5<1.8; 6-f res) */
		uint16_t form_factor : 4;
		uint16_t w168_res : 12;
		/* word 169: DATA SET MANAGEMENT commands */
		uint16_t has_trim_dsm : 1; /* TRIM /w DSM */
		uint16_t w169_res : 15;
		/* words 170-173: Additional product identifier */
		uint16_t additional_product_identifier[4]; /* 8char ATA string */
		/* words 174-175: reserved */
		uint16_t w174to175[2];
		/* words 176-195: current media serial number */
		uint16_t current_media_serial_number[20]; /* up to 40char ATA string */
		/* words 196-205: current media manufacturer */
		uint16_t current_media_manufacturer[10]; /* 20 char ATA string */
		/* word 206: SCT command transport */
		uint16_t has_sct_ct : 1;
		uint16_t w206_res : 1;
		uint16_t has_sct_write_same : 1;
		uint16_t has_sct_error_recovery_control : 1;
		uint16_t has_sct_feature_control : 1;
		uint16_t has_sct_data_tables : 1;
		uint16_t w206_res2 : 1;
		uint16_t w206_sata_res : 1;
		uint16_t w206_res3 : 4;
		uint16_t w206_vendor : 4;
		/* words 207-208: reserved */
		uint16_t w207to208[2];
		/* word 209: aligment of logical sector */
		uint16_t logical_sector_offset : 14;
		uint16_t w209_one : 1;
		uint16_t w209_zero : 1;
		/* words 210-211: WRV mode 3 count */
		uint32_t write_read_verify_mode3_count;
		/* words 212-213: WRV mode 2 count */
		uint32_t write_read_verify_mode2_count;
		/* words 214-216: obsolete (mode1?) */
		uint16_t w214to216[3];
		/* word 217: nominal rotation rate */
		uint16_t nominal_rotation_rate; /* x=RPM; 1=non-rotating, <400h res; 0&ffff not rep */
		/* words 218-219: res & obsolete */
		uint16_t w218to219[2];
		/* word 220: write read verify current mode */
		uint16_t write_read_verify_current_mode : 8;
		uint16_t w220_res : 8;
		/* word 221: reserved */
		uint16_t w221;
		/* word 222: transport major version 0/ffff none */
		uint16_t transport_major_version : 12;
		uint16_t transport_type : 4; /* 0: PATA, 1: SATA, x: RES */
		/* word 223: transport minor version */
		uint16_t transport_minor_version;
		/* words 224-229: reserved */
		uint16_t w224to229[6];
		/* words 230-233: extended number of user addressible sectors */
		uint64_t num_sectors_user_ext; /* depends on word69:3 */
		/* word 234: min blocks per DOWNLOAD MICROCODE */
		uint16_t min_download_microcode_block_count;
		/* word 235: max blocks per DOWNLOAD MICROCODE */
		uint16_t max_download_microcode_block_count;
		/* words 236-254: reserved */
		uint16_t w236to254[19];
		/* word 255: checksum */
		uint16_t checksum_validity : 8; /* 0xa5 */
		uint16_t checksum : 8; /* sum of all bytes incl. -> 0 */
} __attribute__ ((packed));

static inline void convert_ata_string(uint16_t* str, size_t len)
{
		size_t i; char* s = (char*)str;
		for (i = 0; i < len; i++) /* xchg ah, al */
				str[i] = ((str[i] >> 8) | (str[i] << 8));
		/* possibly null terminate by eliminating spaces */
		i = 2 * i - 1;
		while (i && s[i] == ' ')
				i--;
		if (i + 1 < len)
				s[i + 1] = '\0';
}

/* AHCI definitions 
 * */

#define GHC_CNT_AE (1 << 31) /* AHCI enable */
#define GHC_CNT_MRSM (1 << 2) /* MSI revert to single message */
#define GHC_CNT_IE (1 << 1) /* Interrupt enable */
#define GHC_CNT_HR (1) /* HBA reset on writing 1 until 0 read back */

#define BOHC_BB (1 << 4) /* The BIOS is busy changing ownership */
#define BOHC_OOC (1 << 3) /* cleared by writing 1 (to abort OS request) */
#define BOHC_SOOE (1 << 2) /* ownership change causes SMI */
#define BOHC_OOS (1 << 1) /* to be set if the OS request ownership */
#define BOHC_BOS (1) /* This is the BIOS owned semaphore (1 if BIOS) */

#define DET_NOT_PRESENT 0
#define DET_PRESENT_NO_PHY 1
#define DET_PRESENT 3
#define DET_PHY_OFFLINE 4

#define IPM_NOT_PRESENT 0
#define IPM_ACTIVE 1
#define IPM_PARTIAL 2
#define IPM_SLUMBER 6
#define IPM_SLEEP 8

#define TFS_ERR (1 << 0)
#define TFS_BSY (1 << 7)
#define TFS_DRQ (1 << 3)
/* status from TF: 0 ERR, 1-2 CMD specific */
/* 3 DRQ (request), 4-6 CMD spec, 7 BSY */

#define IFS_NOT_PRESENT 0
#define IFS_GEN_1 1
#define IFS_GEN_2 2
#define IFS_GEN_3 3

#define SIG_ATA   0x00000101
#define SIG_ATAPI 0xeb140101
#define SIG_SEMB  0xc33c0101
#define SIG_PM    0x96690101

/* ATA commands */
#define ATA_CMD_ACCESSIBLE_MAX_ADDRESS    0x78 /* /w subcommands via feature 0-2 */
#define ATA_CMD_CHECK_PWR_MODE            0xe5
#define ATA_CMD_CONFIGURE_STRAM           0x51
#define ATA_CMD_DATA_SET_MGMT             0x06 /* TRIM bit (feature 0) */
#define ATA_CMD_DEVICE_RESET              0x08
#define ATA_CMD_DOWNLOAD_MICROCODE        0x92
#define ATA_CMD_DOWNLOAD_MICROCODE_DMA    0x93
#define ATA_CMD_EXECUTE_DEVICE_DIAGNOSTIC 0x90
#define ATA_CMD_FLUSH_CACHE               0xe7
#define ATA_CMD_FLUSH_CACHE_EXT           0xea
#define ATA_CMD_IDENTIFY_DEVICE           0xec
#define ATA_CMD_IDENTIFY_PACKET_DEVICE    0xa1
#define ATA_CMD_IDLE                      0xe3
#define ATA_CMD_IDLE_IMMEDIATE            0xe1
#define ATA_CMD_NCQ_QUEUE_MGMT            0x63
#define ATA_CMD_NOP                       0x00
#define ATA_CMD_PACKET                    0xa0
#define ATA_CMD_READ_BUFFER               0xe4
#define ATA_CMD_READ_BUFFER_DMA           0xe9
#define ATA_CMD_READ_DMA                  0xc8
#define ATA_CMD_READ_DMA_EXT              0x25
#define ATA_CMD_READ_FPDMA_QUEUED         0x60
#define ATA_CMD_READ_LOG_EXT              0x2f
#define ATA_CMD_READ_LOG_DMA_EXT          0x47
/* ATA status/errors */
#define ATA_STATUS_BUSY                 (1 << 7) /* transport dependent */
#define ATA_STATUS_DEVICE_READY         (1 << 6) /* transport dependent */
#define ATA_STATUS_DEVIE_FAULT          (1 << 5) /* defective device (except in sense data) */
#define ATA_STATUS_STREAM_ERROR         (1 << 5) /* set on STREAM command errors */
#define ATA_STATUS_DEFERRED_WRITE_ERROR (1 << 4) /* set on prev error /w WRITE_STREAM_(DMA)_EXT */
#define ATA_STATUS_DATA_REQUEST         (1 << 3) /* transport dep. */
#define ATA_STATUS_ALIGNMENT_ERROR      (1 << 2)
#define ATA_STATUS_SENSE_DATA_AVAILABLE (1 << 1) /* set if SDA, SDE,rep; else obsolete */
#define ATA_STATUS_CHECK_CONDITION      (1 << 0) /* ATAPI if (SENSE, EOM, ILI)*/
#define ATA_STATUS_ERROR                (1 << 0) /* error bits are set ATA */

struct ahci_cmdlst {
		struct ahci_cmdhdr {
				union {
						struct {
								uint16_t CFL : 5; /* command FIS length in DW (>1 <10h) */
								uint16_t A : 1; /* ATAPI bit (used with PIO setup, CTBAz[ACMD]) */
								uint16_t W : 1; /* write bit (else read) */
								uint16_t P : 1; /* prefetchable (valid for ATAPI or prdtl>0, not for PM/NCQ) */
								uint16_t R : 1; /* software reset (SRST bit -> det. 10.4) */
								uint16_t B : 1; /* BIST FIS */
								uint16_t C : 1; /* clear busy upon R_OK pXtfd.sts.bsy, CI */
								uint16_t res : 1;
								uint16_t pmp : 4; /* PM port to use if PM */
						};
						uint16_t flags;
				};
				uint16_t prdtl; /* length of PRD table ; 0 no data transfer */
				uint32_t prdbc; /* current byte count -> 5.4.1 */
				union {
						struct {
								uint32_t ctba; /* base address of command table (128-bit aligned) */
								uint32_t ctbau; /* upper part if 64-bit */
						};
				uint64_t ctba64;
				};

				uint32_t res1[4];
		} chdrs[32];
};

struct ahci_fis {
		uint8_t dsfis[32]; // 1c
		uint8_t psfis[32]; // 14
		uint8_t rfis[20]; // 14h
		uint32_t res0;
		uint8_t sdbfis[8]; // 8
		uint8_t ufis[64]; // up to 64
		uint8_t res1[0x100-0xa0];
};

struct ahci_prdt {
		union {
				struct {
						uint32_t dba;
						uint32_t dbau;
				};
				uint64_t dba64; /* data base address */
		};
		uint32_t res;
		union {
				struct {
						uint32_t dbc : 22; /* has to be divisible by 2 (set to num-1) */
						uint32_t res1 : 9;
						uint32_t I : 1; /* interrupt on completion (IS.DPS is set when data is really there) */
				};
				uint32_t dw3;
		};
};

struct ahci_cmdtbl {
		struct { /* H2D register FIS from SATA 2.6 */
				union {
						uint8_t data[64];
						struct sata_reg_h2d rh2d; /* 400ns until BSY if SRST0->1 */
				};
		} cfis;
		struct {
				uint8_t cmd[16];
		} acmd;
		uint8_t res[0x80-0x50];
		struct ahci_prdt prdts[0];
};

struct ahci_port {
		union {
				struct {
						uint32_t pXclb; /* base address of port X command list (1024 align) */
						uint32_t pXclbu; /* upper half of base address */
				};
				uint64_t pXclb64;
		};
		union {
				struct {
						uint32_t pXfb; /* FIS base address (256 align) */
						uint32_t pXfbu; /* upper half */
				};
				uint64_t pXfb64;
		};
		union {
				volatile struct { /* RWC (write 1 to clear bit) */
						uint32_t dhrs : 1; /* D2H RegFIS with IF received */
						uint32_t pss : 1; /* PIO setup FIS recv */
						uint32_t dss : 1; /* DMA setup FIS recv */
						uint32_t sdbs : 1; /* Set device bits FIS recv */
						uint32_t ufs : 1; /* Unknown FIS recv (cleared through serr.DIAG.F)*/
						uint32_t dps : 1; /* PRD has finished transfer */
						uint32_t pcs : 1; /* port connect change status (clr diag.X) */
						uint32_t dmps : 1; /* Device mechanical presence (i.e. pcs about to change )*/
						uint32_t res : 14;
						uint32_t prcs : 1; /* PhyRdy signal state change (diag.N) */
						uint32_t ipms : 1; /* incorrect PM status */
						uint32_t ofs : 1; /* Overflow, recv more bits than in PRD */
						uint32_t res1 : 1;
						uint32_t infs : 1; /* IF non-fatal error status */
						uint32_t ifs : 1; /* IF fatal error status */
						uint32_t hbds : 1; /* HBA data error /w system memory */
						uint32_t hbfs : 1; /* HBA fatal error (bad ptr, pci) */
						uint32_t tfes : 1; /* Task file error status (set on any error FIS) */
						uint32_t cpds : 1; /* detected change of a cold port */
				} is;
				uint32_t pXis; /* port interrupt status */
		};
		uint32_t pXie; /* interrupt enable (the same as above) */
		union {
				volatile struct {
						uint32_t st : 1; /* process command list (needs FRE) */
						uint32_t sud : 1; /* spin-up device (if cap.SSS) */
						uint32_t pod : 1; /* power-on device (if CPD) */
						uint32_t clo : 1; /* command list override (enable reset even if sts.bsy/drq, followed by ST)*/
						uint32_t fre : 1; /* FIS receive enabled */
						uint32_t res : 3;
						uint32_t ccs : 5; /* indicates which slot is sent if ST */
						uint32_t mpss : 1; /* state of the mech. pres. switch */
						uint32_t fr : 1; /* FIS receive running */
						uint32_t cr : 1; /* command list running */
						uint32_t cps : 1; /* cold presence detected */
						uint32_t pma : 1; /* software sets to indicate PM presence (if ST=0), no autodetect */
						uint32_t hpcp : 1; /* hot-plug capable port */
						uint32_t mpsp : 1; /* MPS supported */
						uint32_t cpd : 1; /* cold presence detection */
						uint32_t esp : 1; /* is eSATA port */
						uint32_t fbscp : 1; /* FIS-based switch capable */
						uint32_t apste : 1; /* auto partial-to-slumber transitions enabled */
						uint32_t atapi : 1; /* ATAPI device */
						uint32_t dlae : 1; /* Show LED for non-ATAPI devices */
						uint32_t alpe : 1; /* aggresive link PM enable */
						uint32_t asp : 1; /* aggressive slumber/partial */
						uint32_t icc : 4; /* IF comm ctrl: 0=idle (issue cmd only on idle) */
						/* 1: active, 2: partial, 3-5 res, 6: slumber, 8: sleep, 7-f: res */
				} cmd;
				uint32_t pXcmd; /* command and status */
		};
		uint32_t res;
		union {
				volatile struct {
						uint32_t sts : 8; /* status from TF: 0 ERR, 1-2 CMD specific */
						/* 3 DRQ (request), 4-6 CMD spec, 7 BSY */
						uint32_t err : 8; /* latest copy of error register */
						uint32_t res : 16;
				} tfd;
				uint32_t pXtfd; /* Task file data */
		};
		/* LBA high mid low; sector count (4 registers) */
		uint32_t pXsig; /* port signature */
		union {
				volatile struct {
						uint32_t det : 4; /* detection: 0 NP, 1 pres no phy, 3 P+P, 4 Phy offline */
						uint32_t spd : 4; /* current IF speed 0 NP, 1-3 Gen1-3 */
						uint32_t ipm : 4; /* IF PowerMgmt: 0 NP, 1 act, 2 part, 6 slmb, 8 sleep */
						uint32_t res : 20;
				} scr0;
				uint32_t pXssts; /* SATA status (SCR0) */
		};
		union {
				volatile struct {
						uint32_t res : 12;
						uint32_t pmp : 4; /* PM port (not AHCI) */
						uint32_t spm : 4; /* select PowerMgmt (not AHCI) */
						uint32_t imp : 4; /* RW: allowed power transitions */
						/* 0 no restrictions, 1P, 2S, 3PS, 4D, 5PD, 6SD, 7PSD */
						uint32_t spd : 4; /* speed limits: 0 none, n genN */
						uint32_t det : 4; /* ST=0; Det acts: 0 none, 1 init (hard reset if set for 1ms, 4 SATA disable)*/
				} scr2;
				uint32_t pXsctl; /* SATA control (SCR2) */
		};
		union {
				volatile struct {
						uint32_t err : 16; /* 01891011 bits IMTCPE */
						uint32_t diag : 16; /*16-26 NIWBDCHSTFX */
				} scr1;
				uint32_t pXserr; /* SATA error (SCR1) */
		};
		uint32_t pXsact; /* SATA active (SCR3): bitfield for NCQ */
		/* set before writing pXci[TAG]=1 -> cmd with TAG outstanding */
		uint32_t pXci; /* port command issue: bitfield for issuing commands */
		/* HBA clears bit after receiving FIS /w BSY DRQ ERR = 0 */
		uint32_t pXsntf; /* SATA notification (SCR4): used for PM FIS /w notify */
		union {
				volatile struct {
						uint32_t en : 1; /* enable FIS-based switching */
						uint32_t dec : 1; /* clear single device error (wait for 0) */
						uint32_t sde : 1; /* single device error detected by PM */
						uint32_t res : 5;
						uint32_t dev : 4; /* device selector for next commands issued by pXci */
						uint32_t ado : 4; /* set to the optimal number of active devices */
						uint32_t dwe : 4; /* number of the single device with error */
						uint32_t res1 : 12;
				} fbs;
				uint32_t pXfbs; /* FIS-based switching control (for PM operation) */
		};
		union {
				volatile struct {
						uint32_t adse : 1; /* aggressive D enable */
						uint32_t dsp : 1; /* device sleep is present */
						uint32_t deto : 8; /* sleep exit timeout in ms (time until acceptance) */
						uint32_t mdat : 5; /* minimum time to assert devslp in ms */
						uint32_t dito : 10; /* timeout until D set by HBA */
						uint32_t dm : 4; /* dito multiplier dito*=dm+1 */
						uint32_t res : 3;
				} devslp;
				uint32_t pXdevslp; /* device sleep of portX */
		};
		uint8_t res1[0x70-0x48];
		uint8_t vendor[0x80-0x70];
};

struct ahci_hba { /* HBA memory registers */
		union {
				uint32_t capabilities;
				volatile struct {
						uint32_t num_ports : 5; /* real value: +1 */
						uint32_t xs_supp : 1; /* eSATA support */
						uint32_t em_supp : 1; /* EM support */
						uint32_t ccc_supp : 1; /* CCC */
						uint32_t num_cmd : 5;
						uint32_t psc : 1; /* partial state capable */
						uint32_t ssc : 1; /* slumber state capable */
						uint32_t pio_drq : 1; /* multiple drq's in PIO */
						uint32_t fbss : 1; /* FIS based switching (with PM) */
						uint32_t pm_supp : 1; /* HBA supports port multipliers */
						uint32_t ahci_only : 1; /* no legacy interface */
						uint32_t dma_nz : 1; /* support non-zero offset DMA */
						uint32_t if_speed : 4; /* 0=res, 1=Gen1, 2=Gen2, 3=Gen3 */
						uint32_t clo_supp : 1; /* supports command list override */
						uint32_t aled_supp : 1; /* supports activity LED */
						uint32_t alp_supp : 1; /* aggressive link PM support */
						uint32_t sss : 1; /* staggered spin-up support */
						uint32_t is_supp : 1; /* interlock/mech. pres. switch support (1.3 mp, 1.1 il) */
						uint32_t ssntf : 1; /* SNotification register is supported */
						uint32_t ncq_supp : 1; /* NCQ is supported */
						uint32_t is_64bit : 1; /* indicates long address support */
				} cap;
		};
		union {
				volatile struct {
						uint32_t hr : 1; /* reset */
						uint32_t ie : 1; /* intr enabled */
						uint32_t mrsm : 1; /* RO: single MSI mode */
						uint32_t res : 28;
						uint32_t ae : 1; /* AHCI enable */
				} ctrl;
				uint32_t control;
		};
		uint32_t intr; /* write 1 to reset */
		uint32_t ports; /* bitfield of implemented ports */
		uint32_t ahci_ver;
		union {
				volatile struct {
						uint32_t enabled : 1;
						uint32_t res : 2;
						uint32_t intr : 5; /*has to be set to an not impl port */
						uint32_t count : 8; /* num of CC until interrupt */
						uint32_t timeout : 16; /* in 1ms intervals */
				};
				uint32_t ccc_control;
		} ccc;
		uint32_t ccc_ports; /* bitfield of ports under ccc */
		uint32_t em_loc; /* offset to EM interface (2 words(*4), 31_ofs__ sz_0) */
		uint32_t em_control; /* uninteresting */
		union {
				volatile struct {
						uint32_t boh : 1; /* BIOS handoff is supported */
						uint32_t nvmhci_present : 1; /* NVMHCI supp. */
						uint32_t apst : 1; /* automatic partial to slumber trans. */
						uint32_t sds : 1; /* supports device sleep */
						uint32_t sadm : 1; /* aggresive DS management */
						uint32_t deso : 1; /* use devslp only in slumber */
						uint32_t res : 26;
				} cap2;
				uint32_t capabilities2;
		};
		uint32_t bohc;
		uint8_t res[0x60-0x2c];
		uint8_t nvm_hci[0xa0-0x60];
		uint8_t vsr[0x100-0xa0];
		/* the ports (at least one) */
		struct ahci_port port[1];
};

/* uses up to 10 pages for 32 ports
 * but PM can increase the FIS size by 16 times
 * -> 32+8 pages w/ 512 devices */
struct ahci_device {
		struct pci_device* dev;
		struct ahci_hba* ptr;
		uint16_t num_ports;
		uint16_t num_cmd;
		struct ahci_cmdlst* command_lists[32];
		struct ahci_fis* recv_fis[32];
		struct {
				uint32_t sig;
				void* ptr;
				uint64_t pm;
		} identify_data[32];
		void* ctbl_pool;
		struct list_head pending_cmds[32]; /* commands to be executed */
		struct list_head proc_cmds[32]; /* commands curently running */
		uint32_t pending_ct;
		struct list_head ctxs;
		struct wait_queue_head wh;
};

/* The API for external users
 * */

/* commands */
enum port_cmd {
		/* command that'll be sent to the disk */
		disk_cmd_identify,
		disk_cmd_read,
		disk_cmd_write,
		disk_cmd_trim,
		/* commands that don't go to the device */
		host_cmd_process_identify = 0x80,
		host_cmd_resend, /* reuse valid command table */
		host_cmd_reset, /* no cmdtbl */
};

/* for informing consumers */
enum cmd_state {
		cmd_state_pending,
		cmd_state_issued,
		cmd_state_abort,
		cmd_state_completed
};

/* generic & optional status information */
struct cmd_status {
		enum cmd_state state;
		uint16_t tfs_err;
		uint16_t tfs_status;
		uint64_t bts_left;
		uint64_t bts_cur;
};

/* ptr has to be word-aligned */
void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st);

