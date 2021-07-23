; Print a null terminated string, start address in bx
func_print:
    pusha
func_print_loop:
    mov cl, [bx]
    cmp cl, 0
    je func_print_done
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    add bx, 1
    jmp func_print_loop
func_print_done:
    popa
    ret
