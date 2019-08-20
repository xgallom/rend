; db openFile(ax = [db] fileName, bx = [db] fileExtension)
section .text
openFile:
	mov dx, fileControlBlock
	mov ah, 0x0f
	int 0x21

	ret

; db readFile(dx = [db] buffer)
section .text
readFile:
	push dx

	mov ah, 0x1a
	int 0x21

	mov ah, 0x14
	mov dx, fileControlBlock
	int 0x21

	pop dx
	add dx, 128
	ret

section .data
fileControlBlock:
	.driveNumber:   db 0
	.fileName:      db "IMAGE3  "
	.fileExtension: db "BMP"
	.blockNumber:   dw 0
	.recordSize:	dw 0
	.fileSize:		dd 0
	.lastWriteData: dw 0
	.lastWriteTime: dw 0
	.reserved:      times 8 db 0
	.record:		db 0
	.random:		dd 0