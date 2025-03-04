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

	/*Escribir Bienvenidos*/
	
	/* 'B' */
	mov ah, 0x0e /* int 0x10, ah = 0x0E Write text in teletype mode*/
	mov al, 'B' /* Caracter ASCII a imprimir */
	mov bh, 0x00 /* Primera página, modo texto */
	mov bl, 0x00 /* Ignorado, se usa en modo gráfico */
	int 0x10 /* Invocar el servicio! */

	/* 'i' */
	mov ax, 0x0e69 /* ah = 0x0E, al = 0x69 = 'i' */
	mov bx, 0x0000 /* bh = 0x00, bl = 0x00 */
	int 0x10

	/* 'e' */
	mov ax, 0x0e65 /* ah = 0x0E, al = 0x65 = 'e' */
	xor bx, bx /* Equivalente a mov bx, 0x000 */
	int 0x10

	/* 'n' */
	mov ax, 0x0e6e /* ah = 0x0E, al = 0x6e = 'n' */
	xor bx, bx /* Equivalente a mov bx, 0x000 */
	int 0x10

	/* 'v' */
	mov ax, 0x0e76 /* ah = 0x0E, al = 0x76 = 'v' */
	xor bx, bx /* Equivalente a mov bx, 0x000 */
	int 0x10
	
	/* 'e' */
	mov ax, 0x0e65 /* ah = 0x0E, al = 0x65 = 'e' */
	xor bx, bx /* Equivalente a mov bx, 0x000 */
	int 0x10
	
	/* 'n' */
	mov ax, 0x0e6e /* ah = 0x0E, al = 0x6e = 'n' */
	xor bx, bx /* Equivalente a mov bx, 0x000 */
	int 0x10
	
	/* 'i' */
	mov ax, 0x0e69 /* ah = 0x0E, al = 0x69 = 'i' */
	xor bx, bx /* bh = 0x00, bl = 0x00 */
	int 0x10
	
	/* 'd' */  
	mov ax, 0x0e64 /* ah = 0x0E, al = 0x64 = 'd' */
	xor bx, bx
	int 0x10
	
	/* 'o' */
	mov ax, 0x0e6f  /* ah = 0x0E, al = 0x6f = 'o' */
	xor bx, bx
	int 0x10
	
	/* 's' */
	mov ax, 0x0e73 /* ah = 0x0E, al = 0x73 = 's' */
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
	
finished:

   /* Detener el procesador con la instrucción HLT. Si las interrupciones
   se encuentran habilitadas, la BIOS toma el control, atiende la
   interrupción y continúa justo después de la instrucción HLT. */
   
   hlt


 jmp finished

