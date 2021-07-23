; prints a string in 32-bit protected mode
; currently always writes the text at the beginning of the display, overwriting everything written before

[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

func_pm_print_string:
    pusha
    mov edx, VIDEO_MEMORY
func_pm_print_string_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je func_pm_print_string_done

    mov [edx], ax
    add ebx, 1
    add edx, 2

    jmp func_pm_print_string_loop
func_pm_print_string_done:
    popa
    ret
