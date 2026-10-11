org 0x8000
bits 16
start:
 xor ax,ax
 mov ds,ax
 mov es,ax
 mov ax,3
 int 0x10
 mov si,welcome
 call print
shell_loop:
 mov si,prompt
 call print
 mov di,buffer
 call read_line
 mov si,buffer
 mov di,c_ls
 call cmp_str
 je is_ls
 mov si,buffer
 mov di,c_clear
 call cmp_str
 je is_clear
 mov si,buffer
 mov di,c_touch
 call cmp_pre
 je is_touch
 mov si,msg_bad
 call print
 jmp shell_loop
is_ls:
 call do_ls
 jmp shell_loop
is_clear:
 mov ax,3
 int 0x10
 jmp shell_loop
is_touch:
 call do_touch
 jmp shell_loop
do_ls:
 mov bx,0x9000
 mov cl,[bx]
 cmp cl,0
 je ls_empty
 mov bx,0x9000
 add bx,1
ls_loop:
 cmp byte [bx],0
 je ls_end
 mov si,bx
 call print
 mov si,nl
 call print
 add bx,20
 dec cl
 jnz ls_loop
ls_end: ret
ls_empty:
 mov si,msg_empty
 call print
 ret
do_touch:
 mov bx,0x9000
 mov al,[bx]
 cmp al,10
 jae is_full
 inc byte [bx]
 xor ah,ah
 mov cl,al
 mov al,20
 mul cl
 mov bx,0x9000
 add bx,1
 add bx,ax
 mov si,buffer
 add si,6
 mov di,bx
 mov cx,12
copy_lp:
 lodsb
 cmp al,0
 je copy_end
 stosb
 loop copy_lp
copy_end:
 mov byte [di],0
 mov si,msg_ok
 call print
 mov si,bx
 call print
 mov si,nl
 call print
 ret
is_full:
 mov si,msg_full
 call print
 ret
print:
 lodsb
 test al,al
 jz p_ret
 mov ah,0x0E
 mov bh,0
 int 0x10
 jmp print
p_ret: ret
read_line:
 xor cx,cx
rl_loop:
 mov ah,0
 int 0x16
 cmp al,13
 je rl_done
 cmp al,8
 je rl_back
 cmp al,32
 jb rl_loop
 cmp cx,60
 jae rl_loop
 mov ah,0x0E
 int 0x10
 stosb
 inc cx
 jmp rl_loop
rl_back:
 cmp cx,0
 je rl_loop
 dec di
 dec cx
 mov ah,0x0E
 mov al,8
 int 0x10
 mov al,32
 int 0x10
 mov al,8
 int 0x10
 jmp rl_loop
rl_done:
 mov byte [di],0
 mov si,nl
 call print
 ret
cmp_str:
 mov si,buffer
cs_l:
 lodsb
 scasb
 jne cs_no
 test al,al
 jz cs_yes
 jmp cs_l
cs_no: mov ax,1
 ret
cs_yes: xor ax,ax
 ret
cmp_pre:
 mov si,buffer
cp_l:
 mov al,[si]
 mov ah,[di]
 cmp ah,0
 je cp_yes
 cmp al,ah
 jne cp_no
 inc si
 inc di
 jmp cp_l
cp_yes: xor ax,ax
 ret
cp_no: mov ax,1
 ret
welcome db "oeneyeOS Aurum Shell v1.3",13,10,"ls touch clear",13,10,0
prompt db "> ",0
nl db 13,10,0
msg_bad db "?: try ls touch clear",13,10,0
msg_empty db "(empty)",13,10,0
msg_full db "full",13,10,0
msg_ok db "saved: ",0
c_ls db "ls",0
c_clear db "clear",0
c_touch db "touch ",0
buffer times 64 db 0
times 1024-($-$$) db 0
