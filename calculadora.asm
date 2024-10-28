section .bss
	buffer resb 128
	numero1 resb 6
	numero2 resb 6
	resultado resb 6

section .data

	msg db 'Calculadora', 0xA ; Mensaje a imprimir seguido de salto de línea
	len equ $ - msg ; Longitud del mensaje

	num1 db 'Ingrese el primer operando: ', 0xA ; Mensaje que imprime y solicita el primer digito, seguido de salto de linea
	len equ $ - msg ; Longitud del mensaje

	num2 db 'Ingrese el segundo operando: ', 0xA ; Mensaje que imprime y solicita el segundo digito, seguido de salto de linea
	len equ $ - msg ; Longitud del mensaje

	operacion db 'Ingrese la operacion a realizar (+) (-) (*) (/): ', 0xA ; Mensaje que solicita la operacion, seguido de salto de linea
	len equ $ - msg ; Longitud del mensaje

	resultado db 'Resultado: ', 0xA ; Mensaje que imprime el mensaje, seguido de salto de linea
	len equ $ - msg ; Longitud del mensaje

	error db 'Error, opcion no validad...', 0xA ; Mensaje que arroja error si una opcion es cero o diferete +-*/, seguido de salto de linea
	len equ $ - msg ; Longitud del mensaje


section .text
	global _start

_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80

	mov eax,1
	xor ebx, ebx
	int 0x80
