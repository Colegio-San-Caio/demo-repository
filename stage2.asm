# paste the INPUT DRIVER code INSIDE nano
# CTRL + O, Enter, CTRL + X

nasm -f bin stage2.asm -o stage2.bin
cat boot.bin stage2.bin payload.bin > oeneyeOS.img
ls -lh oeneyeOS.imgorg 0x0
bits 16
start:
mov ax,3
int 0x10
mov si,m2
call pr
mov ax,0x0013
int 0x10
mov bx,512
cmp word [bx],0x4949
jne bad
cmp word [bx+2],0x002A
jne bad
mov si,[bx+4]
add si,bx
mov cx,[si]
add si,2
mov word [w],32
mov word [h],32
mov word [soff],0
pl:
cmp cx,0
je pd
mov ax,[si]
cmp ax,256
je iw
cmp ax,257
je ih
cmp ax,273
je is
jmp nt
iw:
mov ax,[si+8]
mov [w],ax
jmp nt
ih:
mov ax,[si+8]
mov [h],ax
jmp nt
is:
mov ax,[si+8]
mov [soff],ax
nt:
add si,12
dec cx
jmp pl
pd:
mov ax,0xA000
mov es,ax
mov si,[soff]
add si,512
mov dx,84
yl:
mov cx,144
mov bx,32
xl:
lodsb
add al,16
mov di,dx
imul di,320
add di,cx
mov [es:di],al
inc cx
dec bx
jnz xl
inc dx
cmp dx,116
jb yl
xor ah,ah
int 0x16
mov ax,3
int 0x10
mov si,ok
call pr
jmp $
bad:
mov si,badmsg
call pr
jmp $
pr:
lodsb
or al,al
jz prr
mov ah,0x0E
mov bx,7
int 0x10
jmp pr
prr:
ret
w: dw 0
h: dw 0
soff: dw 0
m2: db "Stage2 TIF parser",13,10,0
badmsg: db "BAD TIF",13,10,0
ok: db "Level10 TIF OK",13,10,0
times 512-($-$$) db 0
