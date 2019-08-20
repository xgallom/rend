; void print(dx = [db] string)
section .text
print:
	push ax

	mov ah, 0x09
	int 0x21

	pop ax
	ret

; void printNumber(ax = dw number)
section .text
printNumber:
	push ax
	push bx
	push cx
	push dx

	mov cx, 4
	mov bx, .buffer + 3

	.loop:
		mov dl, al
		and dl, 0x0f

		cmp dl, 10
		jl .num
		.char:
			add dl, 'a' - 10
		jmp .end
		.num:
			add dl, '0'
		.end:

		mov [bx], dl

		shr ax, 4
		dec bx
	loop .loop

	mov byte [.buffer + 4], '$'

	mov dx, .buffer
	call print

	pop dx
	pop cx
	pop bx
	pop ax
	ret

section .bss
.buffer: resb 5

