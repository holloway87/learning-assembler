; set data segment to 0x7c0, with offset 0 to address 0x7c00 for the bootloader
mov dx, 0x7c0
mov ds, dx

mov bx, msg_welcome
call func_print 

mov dx, msg_welcome
call func_hex2string

jmp $

%include "lib/func_print.asm"
%include "lib/func_hex2string.asm"

; Data
msg_welcome:
    db "Oh hi there :)",10,13,0

; write bootloader signature at the end of the 512 bytes
times 510-($-$$) db 0
dw 0xaa55
