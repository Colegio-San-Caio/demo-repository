bits 16
org 0
db "UNISCI"
db 1
dw 256
db "TEST IMAGE 16K"
times 256-($-$$) db 0
times 16384-($-$$) db 0x20
