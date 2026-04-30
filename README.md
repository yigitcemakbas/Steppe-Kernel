# Steppeos

A custom OS kernel written in C with a Limine bootloader, designed to demonstrate low-level kernel development.

## Features

- Custom bootloader using Limine
- Kernel written in C and assembly
- Bootable ISO image generation
- BIOS-based boot support

## Prerequisites

### macOS
```bash
brew install gcc binutils xorriso
```

### Ubuntu/Debian
```bash
sudo apt-get install gcc binutils xorriso
```

### Fedora/RHEL
```bash
sudo dnf install gcc binutils xorriso
```

### Windows
**Option 1: Using WSL (Windows Subsystem for Linux) - Recommended**
1. Install WSL2:
```PowerShell
wsl --install
```

2. Open WSL terminal and run:
```bash
sudo apt-get update
sudo apt-get install gcc binutils xorriso git
```

3. Clone and build in WSL (see Building section below)

**Option 2: Using MSYS2**
1. Download and install MSYS2
2. Open MSYS2 terminal and run:
```bash
pacman -S gcc binutils xorriso git make
```
3. Navigate to your project directory and follow the Building section below.

**Option 3: Using Cygwin**
1. Download and install Cygwin
    During installation, select: gcc-core, binutils, xorriso, git, make
2. Open Cygwin terminal and follow the Building section below

## Building

### Clone the Repository
```bash
git clone https://github.com/yourusername/steppeos.git
cd steppeos
```

### Build the Kernel
```bash
make
```
This will: 
- Automatically clone Limine bootloader (if not present)
- Compile boot.s
- Compile kernel.c
- Link everything together

### Create Bootable ISO
```bash
make iso
```
This generates steppeos.iso ready to boot.

### Clean Build Artifacts
```bash
make clean
```

## Running
### QEMU
**macOS/Linux/Windows (WSL)**
```bash
qemu-system-x86_64 -cdrom steppeos.iso
```

### Physical Machine
- Burn steppeos.iso to a USB drive
- Boot from USB drive

### Virtual Machine
- VirtualBox, VMware, or Hyper-V: Mount steppeos.iso as a CD-ROM

## License

MIT License