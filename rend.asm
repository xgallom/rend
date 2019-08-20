org 0x0100

section .text

call main

mov ah, 0x4c
int 0x21

%include "print.asm"
%include "vga.asm"
%include "file.asm"
%include "colorTable.asm"

; db getInput()
section .text
getInput:
	mov ah, 0x08
	int 0x21

	ret

; db readImageToVideoMemory([bp] = dw skip, [bp + 2] = dw cycles, [bp + 4] = vmem offset)
section .text
readImageToVideoMemory:
	mov dx, .buffer

	call readFile
	call readFile
	call readFile

	mov dx, .buffer
	add dx, [bp]
	mov di, dx

	mov cx, [bp + 2]

	push es
	mov ax, 0xa000
	mov es, ax

	.loop:
		push cx
		call mapColor
		pop cx

		push di
		mov di, [bp + 4]

		stosb

		mov [bp + 4], di
		pop di
	loop .loop

	pop es

	ret

section .data
.convertBuffer: db 0x00, 0x00, 0x00
.buffer: times 128*3+1 db '$'

; db main()
section .text
main:
    call openFile

    mov dx, .openFileError
    test al, 0xff
    jnz .error

    call initVga

	mov cx, 320 * 200 / 128
	push cx
	push word 0
	push word 128
	push word 0
	mov bp, sp

	.loop:
		mov [bp + 6], cx

		mov [bp + 2], word 128
		call readImageToVideoMemory

		mov cx, [bp + 6]
	loop .loop

	pop ax
	pop ax
	pop ax
	pop ax

    call getInput

    call deinitVga

	jmp .end
	.error:
		call print
		mov ah, 0
		call printNumber
	.end:

	mov ax, 0
	ret

section .data
.vgaError: db "Error initializing vga $"
.openFileError: db "Error opening image file $"

space: db ' $'
nl: db `\n%`
