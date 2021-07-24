Learning Assembler and OS development
=====================================

This repository contains the products of me learning assembler and os
development.

To compile the code to an image file use:

```shell
$ make
```

To execute the image file with qemu use (it will also compile the code if
needed):

```shell
$ make run
```

Resources
---------

These are the resources I used to learn about assembler and os development:

* https://www.codeproject.com/Articles/664165/Writing-a-boot-loader-in-Assembly-and-C-Part
* https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

The website article uses the GNU assembler to compile the code, which I couldn't
get to work together with C.  I ended up using the NASM compiler, which has a
different syntax.

In the PDF file they use NASM, but not qemu to emulate the pc running the
compiled image.  I had to install qemu and also the architectures to use the
i386 architecture.

This is the command to run qemu with your image in a floppy drive:
```shell
$ qemu-system-i386 -drive file=kernel.img,format=raw,index=0,if=floppy
```

32bit on a 64bit machine
------------------------

There is a little difference to compiling 32bit code on a 64bit machine.  You
have to set some additional parameters for the compiler and linker to create
32bit code.

For `gcc` you have to add `-m32` and `-fno-pie`:
```shell
gcc -m32 -fno-pie -ffreestanding -c main.c -o main.o
```

For `ld` you have to add `-m elf_i386`:
```shell
$ ld -m elf_i386 -o kernel.bin -Ttext 0x1000 --oformat binary kernel_entry.o kernel/main.o
```

You can also look into the `Makefile`.
