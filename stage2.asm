org 0x8000
bits 16
start:
    mov ax, 3
    int 0x10
    mov si, msg_welcome
    call print
shell:
    mov si, prompt
    call print
    call input
    mov si, buffer
    cmp byte [si], 'l'
    je do_ls
    cmp byte [si], 'c'
    je do_cat
    jmp shell
do_ls:
    mov bx, 0x9000
    mov al, [bx]
    cmp al, 0
    je shell
    mov si, bx
    add si, 1
    call print
    mov si, nl
    call print
    jmp shell
do_cat:
    mov bx, 0x9000
    mov si, bx
    add si, 32
    call print
    mov si, nl
    call print
    jmp shell
print:
    lodsb
    cmp al, 0
    je.ret
    mov ah, 0x0E
    int 0x10
    jmp print
.ret: ret
input:
    xor cx, cx
    mov di, buffer
.loop:
    mov ah, 0
    int 0x16
    cmp al, 13
    je.done
    mov ah, 0x0E
    int 0x10
    stosb
    inc cx
    jmp.loop
.done:
    mov byte [di], 0
    mov si, nl
    call print
    ret
msg_welcome db "oeneyeOS Aurum Shell v1",13,10,0
prompt db "> ",0
nl db 13,10,0
buffer times 64 db 0
times 1024-($-$$) db 0
