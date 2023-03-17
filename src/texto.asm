; Muestra una cadena de texto terminada en &FF
; HL: posicion de memoria de video donde se muestra
; BC: puntero al inicio de la cadena
PintaTexto:
   ld A, (BC)     ; Letra en BC
   cp &FF
   ret Z          ; Fin de cadena
   push BC
   ld BC, Fuentetileset ; Puntero a caracteres
   sub 65         ; Convertimos de ASCII a puntero sobre Fuentetileset
   ; BC = BC + A*2   ; Movemos puntero al caracter indicado (A*2 porque son words)
   sla A          ; A = A*2
   add A, C       ; BC = BC + A, usando add y adc
   ld C, A
   xor A
   adc A, B
   ld B, A  
   ld A, (BC)     ; Sacamos la direccion del grafico de la letra
   ld E, A
   inc BC
   ld A, (BC)
   ld D, A        ; DE apunta al grafico de la letra
   push HL        ; Guardamos HL para el siguiente caracter
   ld A, 8        ; Altura de las letras
   call PintaBloque8Mask
   pop HL
   pop BC
   inc BC         ; Siguiente letra
   inc HL         ; Posicion en pantalla de la siguiente letra
   inc HL
   inc HL
   inc HL
   jr PintaTexto