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
	
	/* Imprimir: Ingrese 2 valores enteros (1 Digito): */
	/* I */
	mov ax, 0x0E49
	xor bx, bx
	int 0x10
	
	/* n */
	mov ax, 0x0E6E
	xor bx, bx
	int 0x10
	
	/*g*/
	mov ax, 0x0E67
	xor bx, bx
	int 0x10
	
	
	/* r */
	mov ax, 0x0E72
	xor bx, bx
	int 0x10
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/* s */
	mov ax, 0x0E73
	xor bx, bx
	int 0x10
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/*  */
	mov ax, 0x0E20
	xor bx, bx
	int 0x10
	
	/* 2 */
	mov ax, 0x0E32
	xor bx, bx
	int 0x10
	
	/*  */
	mov ax, 0x0E20
	xor bx, bx
	int 0x10
	
	/* v */
	mov ax, 0x0E76
	xor bx, bx
	int 0x10
	
	/* a */
	mov ax, 0x0E61
	xor bx, bx 
	int 0x10
	
	/* l */
	mov ax, 0x0E6C
	xor bx, bx
	int 0x10
	
	/* o */
	mov ax, 0x0E6F
	xor bx, bx 
	int 0x10
	
	/* r */
	mov ax, 0x0E72
	xor bx, bx
	int 0x10
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/* s */
	mov ax, 0x0E73
	xor bx, bx
	int 0x10
	
	/* Saltar linea */
	mov ah, 0x02 
	xor bh, bh /* Página 0 */
	mov dh, 1
	mov dl, 0
	int 0x10 /* int 0x10, ah = 0x02 Set cursor position */
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/* n */
	mov ax, 0x0E6E
	xor bx, bx
	int 0x10
	
	/* t */
	mov ax, 0x0E74
	xor bx, bx
	int 0x10
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/* r */
	mov ax, 0x0E72
	xor bx, bx
	int 0x10
	
	/* o */
	mov ax, 0x0E6F
	xor bx, bx
	int 0x10
	
	/* s */
	mov ax, 0x0E73
	xor bx, bx
	int 0x10
	
	/* ( */
	mov ax, 0x0E28
	xor bx, bx
	int 0x10
	
	/* 1 */
	mov ax, 0x0E31
	xor bx, bx
	int 0x10
	
	/*  */
	mov ax, 0x0E20
	xor bx, bx
	int 0x10
	
	/* D */
	mov ax, 0x0E44
	xor bx, bx
	int 0x10
	
	/* i */
	mov ax, 0x0E69 
	xor bx, bx 
	int 0x10
	
	/* g */
	mov ax, 0x0E67
	xor bx, bx
	int 0x10
	
	/* i */
	mov ax, 0x0E69 
	xor bx, bx 
	int 0x10
	
	/* t */
	mov ax, 0x0E74
	xor bx, bx
	int 0x10
	
	/* o */
	mov ax, 0x0E6f
	xor bx, bx
	int 0x10
	
	/* ) */
	mov ax, 0x0E29
	xor bx, bx
	int 0x10
	
	/* : */
	mov ax, 0x0E3A
	xor bx, bx
	int 0x10
	/*Pedir valores y limpiar*/
	
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
mnl:
	mov ax, 0x0E20 /* AH = 0x0E, AL = 0x20 = ' ' */
	xor bx, bx /* Página 0 */
	int 0x10
	loop mnl /* Loop: Decrementar cx y saltar a 'cls' mientras cx > 0*/

	/* Mover de nuevo el cursor al inicio de la pantalla */
	mov ah, 0x02 
	xor bh, bh /* Página 0 */
	xor dx, dx  /* dh (fila) = 0, dl (columna) = 0 */
	int 0x10 /* int 0x10, ah = 0x02 Set cursor position */
	
	
	/* Imprimir: Ingrese un caracter(c, t): */
	
      
	
        /* I */
	mov ax, 0x0E49
	xor bx, bx
	int 0x10
	
	/* n */
	mov ax, 0x0E6E
	xor bx, bx
	int 0x10
	
	/*g*/
	mov ax, 0x0E67
	xor bx, bx
	int 0x10
	
	
	/* r */
	mov ax, 0x0E72
	xor bx, bx
	int 0x10
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/* s */
	mov ax, 0x0E73
	xor bx, bx
	int 0x10
	
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
		
	/* Saltar linea */
	mov ah, 0x02 
	xor bh, bh /* Página 0 */
	mov dh, 1
	mov dl, 0
	int 0x10 /* int 0x10, ah = 0x02 Set cursor position */
	
	/* c*/
	mov ax, 0x0E63
	xor bx, bx
	int 0x10
	
	
	/* a */
	mov ax, 0x0E61
	xor bx, bx
	int 0x10
	
	/* r */
	mov ax, 0x0E72
	xor bx, bx
	int 0x10
	
	/* a */
	mov ax, 0x0E61
	xor bx, bx
	int 0x10
	
	
	/* c */
	mov ax, 0x0E63
	xor bx, bx
	int 0x10
	
      
	/* t*/
	mov ax, 0x0E74
	xor bx, bx
	int 0x10
	
        /* Error */
      
	/* e */
	mov ax, 0x0E65
	xor bx, bx
	int 0x10
	
	/* r */
	mov ax, 0x0E72
	xor bx, bx
	int 0x10
	
	/* ( */
	mov ax, 0x0E28
	xor bx, bx
	int 0x10
	
	/* c */
	mov ax, 0x0E63
	xor bx, bx
	int 0x10
	
	/*  */
	mov ax, 0x0E20
	xor bx, bx
	int 0x10
	
	/* , */
	mov ax, 0x0E2C
	xor bx, bx
	int 0x10
	
	/* t */
	mov ax, 0x0E74
	xor bx, bx
	int 0x10
	
	/* ) */
	mov ax, 0x0E29
	xor bx, bx
	int 0x10
	
	/* : */
	mov ax, 0x0E3A
	xor bx, bx
	int 0x10
	
	
	
	
	/*
	
	Recibir el caracter
	
	
	*/
	
finished:

   /* Detener el procesador con la instrucción HLT. Si las interrupciones
   se encuentran habilitadas, la BIOS toma el control, atiende la
   interrupción y continúa justo después de la instrucción HLT. */
   
   hlt


 jmp finished

