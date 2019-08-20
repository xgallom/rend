; void initVga()
section .text
initVga:
    mov ax, 0x0013
    int 0x10

    ret

; void deinitVga()
section .text
deinitVga:
    mov ax, 0x0003
	int 0x10

	ret
