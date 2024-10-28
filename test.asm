section .bss

	; Espacios en la memoria reservados para almacenar los valores introducidos por el usuario y el resultado de la operacion.

	opcion:		resb 	5
	num1:		resb	5
	num2:		resb 	5
	resultado:	resb 	5

section .data

	msg1		db		10,'-Calculadora-',10,0
	lmsg1		equ		$ - msg1

	msg2		db		10,'Numero 1: ',0
	lmsg2		equ		$ - msg2

	msg3		db		'Numero 2: ',0
	lmsg3		equ		$ - msg3

	msg4		db		10,'1. Sumar',10,0
	lmsg4		equ		$ - msg4

	msg5		db		'2. Restar',10,0
	lmsg5		equ		$ - msg5

	msg6		db		'3. Multiplicar',10,0
	lmsg6		equ		$ - msg6

	msg7		db		'4. Dividir',10,0
	lmsg7		equ		$ - msg7

	msg8		db		'Operacion: ',0
	lmsg8		equ		$ - msg8

	msg9		db		10,'Resultado: ',0
	lmsg9		equ		$ - msg9

	msg10		db		10,'Opcion Invalida',10,0
	lmsg10		equ		$ - msg10

	nlinea		db		10,10,0
	lnlinea		equ		$ - nlinea

section .text

	global _start

_start:

	; Imprimimos en pantalla el mensaje 1
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, lmsg1
	int 80h

	; Imprimimos en pantalla el mensaje 2
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, lmsg2
	int 80h

	; Obtenemos el numero 1
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 5
	int 80h

	; Imprimimos en pantalla el mensaje 3
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, lmsg3
	int 80h

	; Obtenemos el numero 2
	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 5
	int 80h

	; Imprimimos en pantalla el mensaje 4
	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, lmsg4
	int 80h

	; Imprimimos en pantalla el mensaje 5
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, lmsg5
	int 80h

	; Imprimimos en pantalla el mensaje 6
	mov eax, 4
	mov ebx, 1
	mov ecx, msg6
	mov edx, lmsg6
	int 80h

	; Imprimimos en pantalla el mensaje 7
	mov eax, 4
	mov ebx, 1
	mov ecx, msg7
	mov edx, lmsg7
	int 80h

	; Print on screen the message 8
	mov eax, 4
	mov ebx, 1
	mov ecx, msg8
	mov edx, lmsg8
	int 80h

	; Obtenemos la opcion seleccionada por el usuario
	mov ebx, 0
	mov ecx, opcion
	mov edx, 2
	mov eax, 3
	int 80h

	mov ah, [opcion]	; Movemos la opcion seleccionada a el registro AH
	sub ah, '0'		; Convertimos el valor ingresado de ascii a decimal

	; Comparamos el valor ingresado por el usuario para saber que operacion realizar.
	; JE = Jump if equal = Saltamos si el valor comparado es igual

	cmp ah, 1
	je sumar

	cmp ah, 2
	je restar

	cmp ah, 3
	je multiplicar

	cmp ah, 4
	je dividir

	; Si el valor ingresado no cumple con ninguna de las condiciones anteriores entonces mostramos un mensaje de error y finalizamos
	; la ejecucion del programa
	mov eax, 4
	mov ebx, 1
	mov ecx, msg10
	mov edx, lmsg10
	int 80h

	jmp salir

sumar:

    ; Inicializar registros
    xor ecx, ecx  ; Para llevar la cuenta de la suma
    xor eax, eax   ; "EAX" para el resultado final
    xor ebx, ebx   ; "EBX" como auxiliar

    ; Convertir num1
    mov edi, num1

.next_digit1:

    movzx ebx, byte [edi] ; Cargar el siguiente carácter de num1
    cmp ebx, 0            ; Verificar si llegamos al final de la cadena
    je .end_num1
    sub ebx, '0'          ; Convertir de "Ascci" a decimal
    imul eax, eax, 10     ; Desplazar el resultado a la izquierda (multiplicar por 10)
    add eax, ebx          ; Sumar el dígito
    inc edi               ; Ir al siguiente carácter
    jmp .next_digit1

.end_num1:

    ; Convertir num2
    xor ebx, ebx          ; Limpiar "EBX"
    mov edi, num2

.next_digit2:

    movzx ebx, byte [edi] ; Cargar el siguiente carácter de num2
    cmp ebx, 0            ; Verificar si llegamos al final de la cadena
    je .end_num2
    sub ebx, '0'          ; Convertir de "ASCII" a decimal
    imul eax, eax, 10     ; Desplazar el resultado a la izquierda (multiplicar por 10)
    add eax, ebx          ; Sumar el dígito
    inc edi               ; Ir al siguiente carácter
    jmp .next_digit2

.end_num2:

    ; Almacenar el resultado en el buffer
    mov edi, resultado
    mov ecx, 0            ; Contador de dígitos

.convert_to_ascii:
    xor edx, edx          ; Limpiar "EDX"
    mov ebx, 10
    div ebx               ; Dividir "EAX" entre 10
    add edx, '0'          ; Convertir el residuo a "ASCII"
    mov [edi + ecx], dl   ; Almacenar el dígito en el buffer
    inc ecx               ; Incrementar el contador de dígitos
    test eax, eax         ; Verificar si "EAX" es cero
    jnz .convert_to_ascii ; Repetir si no es cero
    mov byte [edi + ecx], 0 ; Terminar la cadena con un nulo

    ret

restar:
	; Movemos los numeros ingresados a los registro AL y BL
	mov al, [num1]
	mov bl, [num2]

	; Convertimos los valores ingresados de ascii a decimal
	sub al, '0'
	sub bl, '0'

	; Restamos el registro AL y BL
	sub al, bl

	; Convertimos el resultado de la resta de decimal a ascii
	add al, '0'

	; Movemos el resultado a un espacio reservado en la memoria
	mov [resultado], al

	; Imprimimos en pantalla el mensaje 9
	mov eax, 4
	mov ebx, 1
	mov ecx, msg9
	mov edx, lmsg9
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

	; Finalizamos el programa
	jmp salir

multiplicar:

	; Movemos los numeros ingresados a los registro AL y BL
	mov al, [num1]
	mov bl, [num2]

	; Convertimos los valores ingresados de ascii a decimal
	sub al, '0'
	sub bl, '0'

	; Multiplicamos. AX = AL X BL
	mul bl

	; Convertimos el resultado de la resta de decimal a ascii
	add ax, '0'

	; Movemos el resultado a un espacio reservado en la memoria
	mov [resultado], ax

	; Imprimimos en pantalla el mensaje 9
	mov eax, 4
	mov ebx, 1
	mov ecx, msg9
	mov edx, lmsg9
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

	; Finalizamos el programa
	jmp salir

dividir:

	; Movemos los numeros ingresados a los registro AL y BL
	mov al, [num1]
	mov bl, [num2]

	; Igualamos a cero los registros DX y AH
	mov dx, 0
	mov ah, 0

	; Convertimos los valores ingresados de ascii a decimal
	sub al, '0'
	sub bl, '0'

	; Division. AL = AX / BL. AX = AH:AL
	div bl

	; Convertimos el resultado de la resta de decimal a ascii
	add ax, '0'

	; Movemos el resultado a un espacio reservado en la memoria
	mov [resultado], ax

	; Print on screen the message 9
	mov eax, 4
	mov ebx, 1
	mov ecx, msg9
	mov edx, lmsg9
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

	; Finalizamos el programa
	jmp salir

salir:
	; Imprimimos en pantalla dos nuevas lineas
	mov eax, 4
	mov ebx, 1
	mov ecx, nlinea
	mov edx, lnlinea
	int 80h

	; Finalizamos el programa
	mov eax, 1
	mov ebx, 0
	int 80h
