org 0x7C00
bits 16
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    call clear
    mov si, msg_logo
    call print
    call delay1

    mov si, msg_bus
    call print
    call delay1

    mov si, msg_ftp
    call print
    call delay1

    mov si, msg_onion
    call print
    call delay1

    mov si, msg_conn
    call print
    call delay2

    mov si, msg_user
    call print
    call delay1
    mov si, msg_331
    call print
    call delay1

    mov si, msg_pass
    call print
    call delay1
    mov si, msg_230
    call print
    call delay1

    mov si, msg_pasv
    call print
    call delay1
    mov si, msg_227
    call print
    call delay1

    mov si, msg_retr
    call print
    call delay1
    mov si, msg_150
    call print
    call delay2

    mov si, msg_dl
    call print
    mov cx, 16
.loop_dl:
    mov al, '.'
    call putc
    call delay_small
    loop .loop_dl
    call newline

    mov si, msg_ok
    call print
    call delay1

    mov si, msg_tif
    call print
    call delay1

    mov si, msg_ready
    call print

    jmp $

clear:
    mov ax, 0x0003
    int 0x10
    ret
print:
    lodsb
    or al, al
    jz .done
    call putc
    jmp print
.done: ret
putc:
    mov ah, 0x0E
    mov bx, 0x0007
    int 0x10
    ret
newline:
    mov si, crlf
    call print
    ret
delay1:
    mov cx, 0x08
    call delay
    ret
delay2:
    mov cx, 0x12
    call delay
    ret
delay_small:
    push cx
    mov cx, 0x02
    call delay
    pop cx
    ret
delay:
    push ax
    push dx
    mov ax, 0
.d1: mov dx, 0xFFFF
.d2: dec dx
    jnz .d2
    dec ax
    cmp ax, 0
    jne .d1
    dec cx
    jnz delay
    pop dx
    pop ax
    ret

msg_logo: db "oeneyeOS v1.0 - Evergreen by JP",13,10,0
msg_bus: db "BUS Init B C X OK",13,10,0
msg_ftp: db "FTP Server [21] OK - holla.oeneye:2121 ONION",13,10,0
msg_onion: db "ONION: hj2i6zughoj7nwejbsnxv44nhsylof52oshwac3ywgapep3vcyenb2ad.onion",13,10,0
msg_conn: db "> CONNECT 127.0.0.1:2121 via Tor 9050...",13,10,0
msg_user: db "FTP> USER oeneye",13,10,0
msg_331: db "331 Username ok, send password.",13,10,0
msg_pass: db "FTP> PASS oeneye",13,10,0
msg_230: db "230 Login successful - oeneyeFTP Ready",13,10,0
msg_pasv: db "FTP> PASV",13,10,0
msg_227: db "227 Entering Passive Mode (127,0,0,1,117,48) [30000]",13,10,0
msg_retr: db "FTP> RETR file.tif",13,10,0
msg_150: db "150 Opening BINARY mode for file.tif (1024 bytes)",13,10,0
msg_dl: db "DOWNLOADING file.tif [1024 bytes] ",0
msg_ok: db "226 Transfer complete",13,10,0
msg_tif: db "TIF Loaded: 64x64 RGB - Displaying",13,10,0
msg_ready: db "oeneyeOS [FTP CLIENT] READY - Level 8",13,10,0
crlf: db 13,10,0

times 510-($-$$) db 0
dw 0xAA55
