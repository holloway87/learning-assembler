; beginning of the table
gdt_start:

gdt_null:
    ; write 8 bytes of zeros for the null descriptor
    dd 0x0
    dd 0x0

; the code segment descriptor
gdt_code:
    ; limit (bits 0-15)
    dw 0xffff
    ; base (bits 0-15)
    dw 0x0
    ; base (bits 16-23)
    db 0x0
    ; 1st and type flags
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1
    ; type flags (code)1 (conforming)0 (readable)1 (accessed)0
    db 10011010b
    ; 2nd flags and limit (bits 16-19)
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0
    db 11001111b
    ; base (bits 24-31)
    db 0x0

; the data segment descriptor
gdt_data:
    ; limit (bits 0-15)
    dw 0xffff
    ; base (bits 0-15)
    dw 0x0
    ; base (bits 16-23)
    db 0x0
    ; 1st and type flags
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1
    ; type flags (code)0 (expand down)0 (writable)1 (accessed)0
    db 10010010b
    ; 2nd flags and limit (bits 16-19)
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0
    db 11001111b
    ; base (bits 24-31)
    db 0x0

gdt_end:

gdt_descriptor:
    ; size of the gdt, always less one
    dw gdt_end - gdt_start - 1
    ; start address of the gdt
    dd gdt_start

; define constants for the GDT segment descriptor offsets
; 0x0 -> NULL
; 0x08 -> CODE
; 0x10 -> DATA
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
