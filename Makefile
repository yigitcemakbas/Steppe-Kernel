.PHONY: all clean iso setup

# Default target - runs setup first, then builds kernel
all: setup steppeos

# Setup target - clones limine only if it doesn't exist
setup:
	@if [ ! -d limine ]; then \
		echo "Cloning Limine bootloader..."; \
		git clone https://github.com/limine-bootloader/limine.git --branch=v11.x-binary --depth=1; \
	fi

# Build the kernel binary
steppeos: src/boot.o src/kernel.o
	ld -T config/linker.ld -o steppeos src/boot.o src/kernel.o

# Compile boot assembly
src/boot.o: src/boot.s
	as src/boot.s -o src/boot.o

# Compile kernel C code
src/kernel.o: src/kernel.c
	gcc -c src/kernel.c -o src/kernel.o

# Create bootable ISO
iso: all
	mkdir -p isodir/boot
	cp steppeos isodir/boot/
	cp config/limine.cfg isodir/boot/
	cp limine/limine-bios.sys isodir/boot/
	cp limine/limine-bios-cd.bin isodir/
	xorriso -as mkisofs -b limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table -o steppeos.iso isodir

# Clean build artifacts
clean:
	rm -f src/*.o steppeos steppeos.iso
	rm -rf isodir/