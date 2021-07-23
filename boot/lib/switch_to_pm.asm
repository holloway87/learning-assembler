[bits 16]
switch_to_pm:
    ; stop interrupts
    cli
    ; load the global descriptor table
    lgdt [gdt_descriptor]
    ; switch the special bit to enter the protected mode
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    ; do a far jump to synchronize the cpu
    jmp CODE_SEG:start_protected_mode

[bits 32]
start_protected_mode:
    ; prepare all registers
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    call begin_pm
