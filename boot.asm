[BITS 16]
[ORG 0x7C00]
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    mov si, msg_boot
    call print
    mov si, msg_bus
    call print
    mov si, msg_ftp
    call print
    mov si, msg_list1
    call print
    mov si, msg_list2
    call print
    mov si, msg_ready
    call print
    mov si, msg_onion
    call print
    hlt
    jmp $

print:
    lodsb
    or al, al
    jz.ret
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp print
.ret:
    ret

msg_boot db 'oeneyeOS v1.0 - FTP Active',13,10,0
msg_bus db 'BUS Init B C X OK',13,10,0
msg_ftp db 'FTP Server [21] OK',13,10,0
msg_list1 db 'FTP LIST C LLMM 191B',13,10,0
msg_list2 db 'FTP LIST C TIF II 25K',13,10,0
msg_ready db 'FTP Ready Evergreen',13,10,0
msg_onion db 'FTP holla.oeneye 2121 ONION',13,10,0
times 510-($-$$) db 0
dw 0xAA55
