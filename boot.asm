org 0x7C00
bits 16
cli
xor ax,ax
mov ds,ax
mov es,ax
mov ss,ax
mov sp,0x7C00
sti
mov [drv],dl
mov ax,3
int 0x10
mov si,s0
call pr
mov ax,0x800
mov es,ax
xor bx,bx
mov ah,2
mov al,5
mov ch,0
mov cl,2
mov dh,0
mov dl,[drv]
int 0x13
jc err
mov si,s1
call pr
mov ax,0x0013
int 0x10
mov ax,0x800
mov ds,ax
xor si,si
mov ax,0xA000
mov es,ax
mov dx,84
ly: mov cx,144
mov bx,32
lx: lodsb
add al,16
mov di,dx
imul di,320
add di,cx
mov [es:di],al
inc cx
dec bx
jnz lx
inc dx
cmp dx,116
jb ly
xor ah,ah
int 0x16
mov ax,3
int 0x10
mov si,s2
call pr
mov si,s3
call pr
jmp $
err: mov si,e0
call pr
jmp $
pr: lodsb
or al,al
jz pr_ret
mov ah,0x0E
mov bx,7
int 0x10
jmp pr
pr_ret: ret
drv: db 0
s0: db "oeneyeOS v1.0 Level9",13,10,0
s1: db "TIF 0x8000 1024b OK Mode13h",13,10,0
s2: db "Level9 GFX OK",13,10,0
s3: db "Hello, world GFX",13,10,0
e0: db "DISK ERR",13,10,0
times 510-($-$$) db 0
dw 0xAA55
