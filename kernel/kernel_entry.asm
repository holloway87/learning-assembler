[bits 32]
; declare the main symbol will be referenced at linking time
[extern main]
; invoke the c function called main
call main
jmp $
