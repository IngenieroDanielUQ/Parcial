section .bss

	; Espacios en la memoria reservados para almacenar los valores introducidos por el usuario y el resultado de la operacion.

	opcion:		resb	5
	num1:		resb	5
	num2:		resb	5
	resultado:	resb 	5

section .data

	msg1		db		10,'-Calculadora-',10,0
	lmsg1		equ		$ - msg1

	msg2		db		10,'Ingrese el primer operando: ',0
	lmsg2		equ		$ - msg2

	msg3		db		'Ingrese el segundo operando: ',0
	lmsg3		equ		$ - msg3

	operacion	db		'Ingrese la operacion que gusta realizar (1 - Sumar) (2 - Restar) (3 - Multiplicar) (4 - Dividir) o (5) para salir del programa: ',0
	loperacion	equ		$ - operacion

	msg5		db		10,'Resultado: ',0
	lmsg5		equ		$ - msg5

	msg6		db		10,'Opcion Invalida',10,0
	lmsg6		equ		$ - msg6

	nlinea		db		10,10,0
	lnlinea		equ		$ - nlinea

section .text

	global _start

_start:

	; Imprimimos en pantalla el mensaje 1 que es para presentar la calculadora
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, lmsg1
	int 80h

	; Imprimimos en pantalla el mensaje 2 que solicita el primer operando de la calculadora
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, lmsg2
	int 80h

	; Obtenemos el primer operando
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 5
	int 80h

	; Imprimimos en pantalla el mensaje 3 para solicitar el segundo operando de la calculadora
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, lmsg3
	int 80h

	; Obtenemos el segundo operando
	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 5
	int 80h

	; Imprimimos en pantalla la operacion que el usuario elija
	mov eax, 4
	mov ebx, 1
	mov ecx, operacion
	mov edx, loperacion
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

	cmp ah, 5
	je salir

	; Si el valor ingresado no cumple con ninguna de las condiciones anteriores entonces mostramos un mensaje de error y finalizamos
	; la ejecucion del programa
	mov eax, 4
	mov ebx, 1
	mov ecx, msg6
	mov edx, lmsg6
	int 80h

	jmp _start

sumar:

	; Movemos los numeros ingresados a los registro AL y BL
	mov al, [num1]
	mov bl, [num2]

	; Convertimos los valores ingresados de ascii a decimal
	sub al, '0'
	sub bl, '0'

	; Sumamos el registro AL y BL
	add al, bl

	; Convertimos el resultado de la suma de decimal a ascii
	add al, '0'

	; Movemos el resultado a un espacio reservado en la memoria
	mov [resultado], al

	; Imprimimos en pantalla el mensaje de resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, lmsg5
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 2
	int 80h

	; Reiniciamos el programa
	jmp _start


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

	; Imprimimos en pantalla el mensaje de resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, lmsg5
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

	; Reiniciamos el programa
	jmp _start

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

	; Imprimimos en pantalla el mensaje de resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, lmsg5
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

	; Reiniciamos el programa
	jmp _start

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

	; Print on screen the message de resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, lmsg5
	int 80h

	; Imprimimos en pantalla el resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h

	; Reiniciamos el programa
	jmp _start

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
