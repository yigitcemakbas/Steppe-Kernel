.PHONY: all clean iso setup

all: setup steppeos

setup:
	@if [ ! -d limine ]; then \
		echo "Cloning Limine bootloader..."; \
		git clone https://github.com/limine-bootloader/limine.git --branch=v11.x-binary --depth=1; \
	fi

steppeos: boot.o kernel.o
	ld -T linker.ld -o steppeos boot.o kernel.o

boot.o: boot.s
	as boot.s -o boot.o

kernel.o: kernel.c
	gcc -c kernel.c -o kernel.o

iso: all
	mkdir -p isodir/boot
	cp steppeos isodir/boot/
	cp limine.cfg isodir/boot/
	cp limine/limine-bios.sys isodir/boot/
	cp limine/limine-bios-cd.bin isodir/
	xorriso -as mkisofs -b limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table -o steppeos.iso isodir

clean:
	rm -f *.o steppeos steppeos.iso
	rm -rf isodir/