/**
 * @file bootsect.S
 * @author Juan David Moran
 * @brief Area de un triangulo y un rectangulo
 * @description 
 * Este codigo limpia pantalla y recibe dos valores enteros, despues se debe ingresar c o t 
 * para calcular el area de un rectangulo y un triangulo respectivamente
*/

.intel_syntax noprefix 

.code16     

.section .text 

.global start                  

/**
* Símbolo que marca el inicio del código del sector de arranque 
*/
start:
        /* Configurar CS para que apunte a 0x7C00 */
  ljmp 0x7C0: offset entry_point
  
entry_point:

  /* Configurar el registro de segmento DS */
  mov ax, cs
  mov ds, ax
  mov es, ax

  /* Configurar la pila */
  cli
  mov ax, 0x9000
  mov ss, ax
  mov sp, 0xFC00
  sti
  
  
	/*Escribir Hola*/
	/* 'H' */
	mov ah, 0x0e /* int 0x10, ah = 0x0E Write text in teletype mode*/
	mov al, 'H' /* Caracter ASCII a imprimir */
	mov bh, 0x00 /* Primera página, modo texto */
	mov bl, 0x00 /* Ignorado, se usa en modo gráfico */
	int 0x10 /* Invocar el servicio! */

	/* 'o' */
	mov ax, 0x0e6f /* ah = 0x0E, al = 0x69 = '0' */
	mov bx, 0x0000 /* bh = 0x00, bl = 0x00 */
	int 0x10

        /* l */
	mov ax, 0x0e6c
	xor bx, bx
	int 0x10
	
	/* a */
	mov ax, 0x0e61
	mov bx, 0x0000
	int 0x10
	
	/* Esperar una pulsación de tecla */
	xor ax, ax /* ax = 0x0000 */
	int 0x16 /* int 0x16, ah = 0x00 Wait for keystroke and read */
	
	/* Mover el cursor al inicio de la pantalla */
	mov ah, 0x02 
	xor bh, bh /* Página 0 */
	xor dx, dx  /* dh (fila) = 0, dl (columna) = 0 */
	int 0x10 /* int 0x10, ah = 0x02 Set cursor position */

	/* Limpiar la pantalla: Escribir 80 x 25 = 2000 espacios desde la esquina
	 * superior izquierda hasta la esquina inferior derecha */
	mov cx, 2000
cls:
	mov ax, 0x0E20 /* AH = 0x0E, AL = 0x20 = ' ' */
	xor bx, bx /* Página 0 */
	int 0x10
	loop cls /* Loop: Decrementar cx y saltar a 'cls' mientras cx > 0*/

	/* Mover de nuevo el cursor al inicio de la pantalla */
	mov ah, 0x02 
	xor bh, bh /* Página 0 */
	xor dx, dx  /* dh (fila) = 0, dl (columna) = 0 */
	int 0x10 /* int 0x10, ah = 0x02 Set cursor position */
	
	/* Imprimir: Ingrese 2 valores enteros(1 digito) */
	mov si,offset mensaje1
	call imprimir
	
	/*Leer primer numero*/
	call getkey
	/*Guardarlo en bl*/
	mov bl, al
	xchg bx, bx
	
	/* Leer el segundo numero */
	call getkey
	/* Guardarlo en bh*/
	mov bh, al
        xchg bx, bx
  
	/* Salto de linea */
	mov ah, 0x0E
	mov al, 0x0D
	int 0x10
	mov al, 0x0A
	int 0x10
	
	
	/* Imprimir: Un caracter(c,t): */
	
	mov si,offset mensaje2
	call imprimir
	
	call getkey
	
finished:

   /* Detener el procesador con la instrucción HLT. Si las interrupciones
   se encuentran habilitadas, la BIOS toma el control, atiende la
   interrupción y continúa justo después de la instrucción HLT. */
   
   hlt


 jmp finished

/**
* Lee un caracter de teclado usando los servicios de teclado de la BIOS
* (int 0x16).
* Entrada:
*  Ninguna
* Salida:
*  AL contiene el caracter ASCII leido
* En esta rutina no se crea un marco de pila. El servicio de la 
* BIOS puede modificar otros registros.
*/
getkey: 
  xor ah, ah   /* ah = 0, servico de video leer un caracter de teclado */
  int 0x16     /* Servicio de video */
  sub al, '0'
  ret
  
  /* Imprimir una cadena  */
  imprimir:
  mov ah, 0x0E
  imprimir_char:
  lodsb
  or al, al
  jz done_imprimir
  int 0x10
  jmp imprimir_char
  done_imprimir:
  ret
  
  mensaje1:
  .asciz "Ingrese 2 valores enteros(1 digito):"
  mensaje2:
  .asciz "Ingrese un caracter(c,t):"
