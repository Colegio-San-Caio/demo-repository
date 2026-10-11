org 0x8000
bits 16
start:
 xor ax,ax
 mov ds,ax
 mov es,ax
 mov di,0x9000
 mov cx,800
 xor al,al
 rep stosb
 mov ax,3
 int 0x10
 mov si,welcome
 call print
shell_loop:
 mov si,prompt
 call print
 mov di,buffer
 call read_line
 call make_token
 mov si,token
 mov di,c_ls
 call cmp_str
 test ax,ax
 jz is_ls
 mov si,token
 mov di,c_clear
 call cmp_str
 test ax,ax
 jz is_clear
 mov si,token
 mov di,c_touch
 call cmp_str
 test ax,ax
 jz is_touch
 mov si,token
 mov di,c_cat
 call cmp_str
 test ax,ax
 jz is_cat
 mov si,token
 mov di,c_echo
 call cmp_str
 test ax,ax
 jz is_echo
 mov si,token
 mov di,c_rm
 call cmp_str
 test ax,ax
 jz is_rm
 mov si,token
 mov di,c_help
 call cmp_str
 test ax,ax
 jz is_help
 mov si,msg_bad
 call print
 jmp shell_loop
is_ls: call do_ls
 jmp shell_loop
is_clear: mov ax,3
 int 0x10
 jmp shell_loop
is_touch: call do_touch
 jmp shell_loop
is_cat: call do_cat
 jmp shell_loop
is_echo: call do_echo
 jmp shell_loop
is_rm: call do_rm
 jmp shell_loop
is_help: call do_help
 jmp shell_loop
make_token:
 mov si,buffer
 call skip_sp_si
 mov di,token
 mov cx,16
mt_l: lodsb
 cmp al,0
 je mt_e
 cmp al,32
 je mt_e
 stosb
 loop mt_l
mt_e: mov byte [di],0
 ret
do_ls:
 mov bx,0x9000
 mov cl,[bx]
 cmp cl,0
 je ls_empty
 mov si,msg_list
 call print
 mov bx,0x9000
 add bx,1
ls_lp: cmp byte [bx],0
 je ls_end
 mov si,bx
 call print
 mov si,nl
 call print
 add bx,64
 dec cl
 jnz ls_lp
ls_end: ret
ls_empty: mov si,msg_empty
 call print
 ret
do_touch:
 call get_arg
 cmp byte [si],0
 je t_noarg
 mov di,si
 call find_file
 cmp bx,0
 jne t_exists
 mov bx,0x9000
 mov al,[bx]
 cmp al,10
 jae is_full
 inc byte [bx]
 xor ah,ah
 mov cl,al
 mov al,64
 mul cl
 mov bx,0x9000
 add bx,1
 add bx,ax
 mov si,di
 mov di,bx
 mov cx,15
cp1: lodsb
 cmp al,0
 je z1
 cmp al,32
 je z1
 stosb
 loop cp1
z1: mov byte [di],0
 mov si,msg_ok
 call print
 mov si,bx
 call print
 mov si,nl
 call print
 ret
t_exists: mov si,msg_exists
 call print
 ret
t_noarg: mov si,msg_usage
 call print
 ret
is_full: mov si,msg_full
 call print
 ret
do_cat:
 call get_arg
 cmp byte [si],0
 je t_noarg
 mov di,si
 call find_file
 cmp bx,0
 je cat_nf
 add bx,16
 mov si,bx
 call print
 mov si,nl
 call print
 ret
cat_nf: mov si,msg_nf
 call print
 ret
do_rm:
 call get_arg
 cmp byte [si],0
 je t_noarg
 mov di,si
 call find_file
 cmp bx,0
 je cat_nf
 ; replace with last file
 mov si,bx
 mov dx,bx
 mov bx,0x9000
 mov al,[bx]
 dec al
 mov cl,al
 mov al,64
 mul cl
 mov bx,0x9000
 add bx,1
 add bx,ax
 ; bx = last entry, dx = to delete
 cmp dx,bx
 je del_last
 ; copy last to del slot
 mov si,bx
 mov di,dx
 mov cx,64
 rep movsb
del_last:
 ; zero last
 mov di,bx
 mov cx,64
 xor al,al
 rep stosb
 mov bx,0x9000
 dec byte [bx]
 mov si,msg_del
 call print
 ret
do_echo:
 mov si,buffer
 mov cx,64
fg: lodsb
 cmp al,0
 je echo_print
 cmp al,'>'
 je got_gt2
 loop fg
echo_print:
 call get_rest
 mov si,si
 call print
 mov si,nl
 call print
 ret
got_gt2:
 mov di,si
 call skip_sp_si
 push di
 mov si,di
 call find_file
 cmp bx,0
 jne have_f3
 mov bx,0x9000
 mov al,[bx]
 cmp al,10
 jae is_full
 inc byte [bx]
 xor ah,ah
 mov cl,al
 mov al,64
 mul cl
 mov bx,0x9000
 add bx,1
 add bx,ax
 mov si,di
 mov di,bx
 mov cx,15
cpn3: lodsb
 cmp al,0
 je zn3
 cmp al,32
 je zn3
 stosb
 loop cpn3
zn3: mov byte [di],0
have_f3:
 pop si
 mov si,buffer
 call skip_sp_si
 add si,5
 call skip_sp_si
 mov di,bx
 add di,16
 mov cx,48
ecp3: lodsb
 cmp al,'>'
 je ecz3
 cmp al,0
 je ecz3
 stosb
 loop ecp3
ecz3: mov byte [di],0
 mov si,msg_wrote
 call print
 ret
do_help:
 mov si,msg_help
 call print
 ret
get_arg:
 mov si,buffer
 call skip_sp_si
ga1: lodsb
 cmp al,0
 je ga_e
 cmp al,32
 je ga_sp
 jmp ga1
ga_sp: call skip_sp_si
 ret
ga_e: mov si,buffer
 add si,64
 ret
get_rest:
 mov si,buffer
 call skip_sp_si
 add si,5
 call skip_sp_si
 ret
find_file:
 mov bx,0x9000
 mov cl,[bx]
 cmp cl,0
 je ff_nf3
 mov bx,0x9000
 add bx,1
ff_l3: push cx
 push di
 mov si,bx
 call cmp_str2
 pop di
 pop cx
 je ff_f3
 add bx,64
 dec cl
 jnz ff_l3
ff_nf3: xor bx,bx
 ret
ff_f3: ret
skip_sp_si:
sk3: lodsb
 cmp al,32
 je sk3
 dec si
 ret
cmp_str:
cs_l: lodsb
 scasb
 jne cs_no
 test al,al
 jz cs_yes
 jmp cs_l
cs_no: mov ax,1
 ret
cs_yes: xor ax,ax
 ret
cmp_str2:
cs2_l: mov al,[si]
 mov ah,[di]
 cmp ah,0
 je cs2_e1
 cmp ah,32
 je cs2_e1
 cmp al,ah
 jne cs2_no
 inc si
 inc di
 jmp cs2_l
cs2_e1: cmp al,0
 je cs2_yes
cs2_no: mov ax,1
 ret
cs2_yes: xor ax,ax
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
rl_loop: mov ah,0
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
rl_back: cmp cx,0
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
rl_done: mov byte [di],0
 mov si,nl
 call print
 ret
welcome db "oeneyeOS Aurum Shell v1.5.1",13,10,"type help",13,10,0
prompt db "> ",0
nl db 13,10,0
msg_bad db "?: type help",13,10,0
msg_empty db "(empty)",13,10,0
msg_full db "full (max 10)",13,10,0
msg_ok db "created: ",0
msg_nf db "not found",13,10,0
msg_wrote db "written",13,10,0
msg_usage db "usage: touch <name>",13,10,0
msg_exists db "exists",13,10,0
msg_del db "deleted",13,10,0
msg_list db "files:",13,10,0
msg_help db "cmds: ls touch <f> cat <f>",13,10," echo <t> > <f> rm <f> clear help",13,10,0
c_ls db "ls",0
c_clear db "clear",0
c_touch db "touch",0
c_cat db "cat",0
c_echo db "echo",0
c_rm db "rm",0
c_help db "help",0
token times 16 db 0
buffer times 64 db 0
times 2048-($-$$) db 0
