; set the base address at 0x7c00 where the BIOS will load this program
; all labels will have the correct value this way
[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov bp, 0x9000
mov sp, bp

; load the kernel
mov bx, msg_loading_kernel
call func_print

mov dl, 0; drive
mov cl, 2; start sector (1 indexed)
mov dh, 15; number of sectors
mov bx, KERNEL_OFFSET ; load into this address
call func_read_floppy

; switch to protected mode
mov bx, msg_switch_pm
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
    call KERNEL_OFFSET
    jmp $

; Data
msg_loading_kernel:
    db "Loading kernel...",10,13,0
msg_switch_pm:
    db "Switching to protected mode...",10,13,0
msg_protected_mode:
    db "Entered 32-bit protected mode.",0

; write bootloader signature at the end of the 512 bytes
times 510-($-$$) db 0
dw 0xaa55
