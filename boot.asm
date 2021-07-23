; set the base address at 0x7c00 where the BIOS will load this program
; all labels will have the correct value this way
[org 0x7c00]

mov bx, msg_welcome
call func_print

call switch_to_pm

jmp $

%include "lib/func_print.asm"
%include "lib/func_hex2string.asm"
%include "lib/func_read_floppy.asm"
%include "lib/func_pm_print_string.asm"
%include "lib/gdt_table.asm"
%include "lib/switch_to_pm.asm"

[bits 32]
begin_pm:
    mov ebx, msg_protected_mode
    call func_pm_print_string
    jmp $

; Data
msg_welcome:
    db "Switching to protected mode...",10,13,0
msg_protected_mode:
    db "Entered 32-bit protected mode.",0

; write bootloader signature at the end of the 512 bytes
times 510-($-$$) db 0
dw 0xaa55
