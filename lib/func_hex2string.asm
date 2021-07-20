; This function also needs the func_print.asm

; Convert and print hex2string, hex value in dx
func_hex2string:
    pusha
    ; bx contains the address in msg_hex, address will be moved to the last digit
    mov bx, msg_hex
    add bx, 5
func_hex2string_loop:
    cmp dx, 0
    je func_hex2string_done
    ; cx contains the current 4 bits
    mov cx, dx
    and cx, 0x000f
    cmp cx, 10
    jge func_hex2string_char
    add cx, 48
    jmp func_hex2string_next
func_hex2string_char:
    add cx, 87
func_hex2string_next:
    ; write the char at the current memory location
    mov [bx], cl
    ; shift input to the right for the next digit
    shr dx, 4
    ; move address for the next character
    sub bx, 1
    jmp func_hex2string_loop
func_hex2string_done:
    mov bx, msg_hex
    call func_print
    popa
    ret

msg_hex:
    db "0x0000",13,10,0
