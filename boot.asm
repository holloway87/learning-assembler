; set the base address at 0x7c00 where the BIOS will load this program
; all labels will have the correct value this way
[org 0x7c00]

mov bx, msg_welcome
call func_print

mov dx, msg_welcome
call func_hex2string

mov bp, 0x8000
mov sp, bp

mov dl, 0; drive
mov cl, 2; start sector (1 indexed)
mov dh, 1; number of sectors
mov bx, 0x9000
call func_read_floppy

mov bx, 0x9000
call func_print

jmp $

%include "lib/func_print.asm"
%include "lib/func_hex2string.asm"
%include "lib/func_read_floppy.asm"

; Data
msg_welcome:
    db "Oh hi there :)",10,13,0

; write bootloader signature at the end of the 512 bytes
times 510-($-$$) db 0
dw 0xaa55

msg_new:
    db "This is new",10,13,0

times 1024-($-$$) db 0
