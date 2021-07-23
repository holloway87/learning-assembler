all: kernel.img

C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

run : all
	qemu-system-i386 -drive file=kernel.img,format=raw,index=0,if=floppy

kernel.img : boot/boot.bin kernel.bin
	cat $^ > $@

%.bin : %.asm
	nasm $< -f bin -I 'boot/' -o $@

kernel.bin : kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 --oformat binary $^

%.o : %.c ${HEADERS}
	gcc -m32 -fno-pie -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

clean:
	rm -fr *.bin *.o kernel.img
	rm -fr boot/*.bin kernel/*.o drivers/*.o
