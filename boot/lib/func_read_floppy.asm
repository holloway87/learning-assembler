; This function also needs the func_print.asm

; reads data from a floppy disk
; drive number has to be in dl (0 indexed)
; cylinder will always be the first one
; track number will always be the first one
; start sector in cl (1 indexed)
; number of sectors to read from the start point in dh
;
; start segment to write the data in, in es
; offset for data segment in bx
; es 0xa000 and bx 0x1234 would result in start address 0xa1234
func_read_floppy:
    ; drive number has to be in dl (0 indexed)
    ; cylinder number in ch (0 indexed)
    ; track number in dh (0 indexed)
    ; start sector in cl (1 indexed)
    ; number of sectors to read from the start point in al
    pusha
    push dx
    ; BIOS read sectors function
    mov ah, 0x02
    mov al, dh
    mov ch, 0; always first cylinder
    mov dh, 0; always first track
    ; tell BIOS to read the data
    int 0x13
    jc func_read_floppy_error
    pop dx
    cmp dh, al
    jne func_read_floppy_error
    popa
    ret
func_read_floppy_error:
    mov bx, msg_io_error
    call func_print
    jmp $

msg_io_error:
    db "IO Error!",10,13,0
