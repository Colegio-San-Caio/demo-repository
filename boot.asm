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
; load 20 sectors (10KB) for Stage2 + TIF
mov ax,0x800
mov es,ax
xor bx,bx
mov ah,2
mov al,20
mov ch,0
mov cl,2
mov dh,0
mov dl,[drv]
int 0x13
jc err
mov si,s1
call pr
jmp 0x800:0x0
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
s0: db "oeneyeOS v1.0 Level10",13,10,0
s1: db "Load 0x8000 10KB OK -> Stage2",13,10,0
e0: db "DISK ERR",13,10,0
times 510-($-$$) db 0
dw 0xAA55
