bits 16
org 0x8000
start:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7C00
  sti
  cld
  mov si, msg
  call print
  mov si, prompt
  call print
key:
  xor ah, ah
  int 16h
  cmp al, 13
  je enter
  cmp al, 8
  je bksp
  cmp al, 32
  jb key
  cmp al, 126
  ja key
  call putc
  jmp key
enter:
  mov si, crlf
  call print
  jmp key
bksp:
  mov al, 8
  call putc
  mov al, 32
  call putc
  mov al, 8
  call putc
  jmp key
putc:
  mov ah, 0Eh
  xor bx, bx
  int 10h
  ret
print:
  lodsb
  or al, al
  jz done
  call putc
  jmp print
done:
  ret
msg db 'oeneyeOS Stage2 - Active [0x8000] - B: 2.88M OK',13,10,0
prompt db 'Type: ',0
crlf db 13,10,0
times 1024-($-$$) db 0
