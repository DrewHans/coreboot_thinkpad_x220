# coreboot_thinkpad_x220
A place to store the coreboot configuration for my Thinkpad x220 laptop

---

# Coreboot 4.17 Configuration for the Thinkpad x220

When you run `make nconfig` you should make sure the options below are selected (but don't deselect any coreboot defaults, except for secondary payloads).

```
General
      Compiler to use (GCC) --->
      Option backend to use (Use CMOS for configuration values) --->
  [*] Compress ramstage with LZMA
  [*] Include coreboot .config file into the ROM image
  [*] Allow use of binary-only repository
  [*] Add a bootsplash image
      (/home/nyancat/Code/coreboot_thinkpad_x220/bootsplash.jpg) Bootsplash path and filename

Mainboard
  *** Important: Run 'make distclean' before switching boards ***
  Mainboard vendor (Lenovo) --->
  Mainboard model (ThinkPad X220) --->
  ROM chip size (8192 KB (8 MB)) --->
  (0x100000) Size of CBFS filesystem in ROM

Chipset
      *** SoC ***
      *** CPU ***
  [*] Enable VMX for virtualization
  [*] Set IA32_FEATURE_CONTROL lock bit
      Include CPU microcode in CBFS (Generate from tree) --->

      *** Northbridge ***
  [*] Use native raminit
  [*] Ignore vendor programmed fuses that limit max. DRAM frequency

      *** Southbridge ***

      *** Super I/O ***
      *** Embedded Controllers ***

      *** Intel Firmware ***
  [*] Add Intel descriptor.bin file
      (/home/nyancat/Code/coreboot_thinkpad_x220/coreboot/3rdparty/blobs/mainboard/$(MAINBOARDDIR)/descriptor.bin) Path and filename
  [*] Add Intel ME/TXE firmware
      (/home/nyancat/Code/coreboot_thinkpad_x220/coreboot/3rdparty/blobs/mainboard/$(MAINBOARDDIR)/me.bin) Path to management engine firmware
  [*] Add gigabit ethernet firmware
      (/home/nyancat/Code/coreboot_thinkpad_x220/coreboot/3rdparty/blobs/mainboard/$(MAINBOARDDIR)/gbe.bin) Path to gigabit ethernet

Devices
      Graphics initialization (Run VGA Option ROMs) --->
      (0) Graphics initialization delay in ms
  [*] Use onboard VGA as primary video device
  [*] Re-run VGA Option ROMs on S3 resume
  [*] Load Option ROMs on PCI devices
      Option ROM execution type (Native mode) --->
  [*] Allow coreboot to set optional PCI bus master bits
  -*-   PCI bridges
  [*]   Any devices
  -*- Enable PCIe Common Clock
  -*- Enable PCIe ASPM
  [*] Enable PCIe Clock Power Management
  [*] Enable PCIe ASPM L1 SubState
  [*] Enable PCIe Hotplug Support
  [*] Add a VGA BIOS image
      (/home/nyancat/Code/coreboot_thinkpad_x220/coreboot/3rdparty/blobs/mainboard/$(MAINBOARDDIR)/vgabios.bin) VGA BIOS path and filename
      (8086,0126) VGA device PCI IDs
  [*] Add a Video Bios Table (VBT) binary to CBFS
      (src/mainboard/$(MAINBOARDDIR)/variants/x220/data.vbt) VBT binary path and filename

Generic Drivers
  [*] PS/2 keyboard init
  [*] Support Intel PCI-e WiFi adapters

Security

Console
  [*] Squelch AP CPUs from early console
  [*] Show POST codes on the debug console

System Tables
  [*] Generate SMBIOS tables

Payload
      Add a payload (SeaBIOS) --->
      SeaBIOS version (1.16.0) --->
      (3000) PS/2 keyboard controller initialization timeout (milliseconds)
  [*] Hardware init during option ROM execution
      Payload compression algorithm (Use LZMA compression for payloads) --->
  [*] Use LZMA compression for secondary payloads
      Secondary Payloads --->
        [ ] Load coreinfo as a secondary payload
        [ ] Load Memtest86+ as a secondary payloada
        [ ] Load nvramcui as a secondary payload
        [ ] Load tint as a secondary payload

Debugging
  -*- Platform can support the dediprog EM100 SPI emulator

```

#### Notes:
- Verify the Bootsplash image path and filename are correct
- Verify the VGA BIOS path and filename are correct
- If you replaced the stock ROM chip, make sure you run truncate on the coreboot.rom file before flashing it (truncate will pad with zeros)
    - example: I desoldered the stock ROM chip (8192 KB (8 MB)) and replaced it with a winbond W25Q128.V (16384 KB (16 MB)) \
    `truncate -s 16777216 coreboot.rom`
- If you add a custom bootsplash jpg image, make sure you export it with the following settings: 
    - uncheck "Save EXIF data", "Save XMP data", "Save IPTC data", "Save thumbnail", "Save color profile"
    - in advanced options, uncheck "Progressive"
    - in advanced options, set "Subsampling" to "4:2:0 (chroma quartered)"
    - lastly, adjust quality (compression) as needed (max size is the free space available on the flash chip)
---

# Online references:
- Lenovo X220 Laptop [Product Home](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x220/)
- coreboot [wiki page](https://www.coreboot.org/Board:lenovo/x220)
- tripcode's [video](https://www.youtube.com/watch?v=ExQKOtZhLBM)
- Michaelmob's [blog post](https://michaelmob.com/post/coreboot-thinkpad-x220/)
- Tyler Cipriani's [blog post](https://tylercipriani.com/blog/2016/11/13/coreboot-on-the-thinkpad-x220-with-a-raspberry-pi/)
- ifrit05's [coreboot-bootsplashes repo](https://github.com/ifrit05/coreboot-bootsplashes)
- notthebeee's [blog post](https://notthebe.ee/revertcoreboot.html)
