Learning Assembler
==================

This repository contains the products of me learning assembler.

The file `boot.asm` uses the NASM compiler, to use the code compile it:

```shell
$ nasm boot.asm -f bin -o boot.bin
```

Then execute it with qemu:

```shell
$ qemu-system-i386 -drive file=boot.bin,format=raw,index=0,if=floppy
```
