org 0x7C00
bits 16
cli
xor ax,ax
mov ds,ax
mov es,ax
mov ss,ax
mov sp,0x7C00
sti
mov ax,3
int 0x10
mov si,s0
call pr
mov si,s1
call pr
mov si,s2
call pr
mov si,s3
call pr
mov si,s4
call pr
mov si,s5
call pr
mov si,s6
call pr
mov si,s7
call pr
mov si,s8
call pr
mov si,s9
call pr
mov si,s10
call pr
mov si,s11
call pr
mov si,s12
call pr
mov si,s13
call pr
mov cx,16
.dl: mov al,'.'
mov ah,0x0E
mov bx,7
int 0x10
mov cx,2
call del
mov cx,16
; reuse loop via dec trick
dec cx
cmp cx,0
jne .dl
; actually do dots simple
mov cx,16
.dot: mov al,'.'
mov ah,0x0E
int 0x10
call d1
loop .dot
mov si,cr
call pr
mov si,s14
call pr
mov si,s15
call pr
mov si,s16
call pr
jmp $
pr: lodsb
or al,al
jz .r
mov ah,0x0E
mov bx,7
int 0x10
jmp pr
.r: ret
del: push ax
push dx
xor ax,ax
a: mov dx,0xCFFF
b: dec dx
jnz b
dec ax
jnz a
pop dx
pop ax
ret
d1: push cx
mov cx,1
call del
pop cx
ret
s0: db "oeneyeOS v1.0",13,10,0
s1: db "BUS OK",13,10,0
s2: db "FTP holla.oeneye:2121",13,10,0
s3: db "hj2i6zughoj7nwejbsnxv44nhsy",13,10,0
s4: db "lof52oshwac3ywgapep3vcyenb2ad",13,10,0
s5: db "CONNECT Tor 9050",13,10,0
s6: db "USER oeneye",13,10,0
s7: db "331 OK",13,10,0
s8: db "PASS oeneye",13,10,0
s9: db "230 OK",13,10,0
s10: db "PASV 30000",13,10,0
s11: db "227 OK",13,10,0
s12: db "RETR file.tif",13,10,0
s13: db "150 1024b ",0
s14: db "226 OK",13,10,0
s15: db "TIF Loaded",13,10,0
s16: db "Level8 CLIENT READY",13,10,0
cr: db 13,10,0
times 510-($-$$) db 0
dw 0xAA55
