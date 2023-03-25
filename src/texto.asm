; Muestra una cadena de texto terminada en &FF
; HL: posicion de memoria de video donde se muestra
; BC: puntero al inicio de la cadena
PintaTexto:
   ld A, (BC)     ; Letra en BC
   cp &FF
   ret Z          ; Fin de cadena

   sub 65

   push BC
   push HL
   push HL

   ld HL, Fuentetileset
   ld B, 0
   ld C, A
   add HL, BC     ; HL = Fueltetileset + A*2
   add HL, BC

   ld A, (HL)     ; Sacamos la direccion del grafico de la letra
   ld E, A
   inc HL
   ld A, (HL)
   ld D, A        ; DE apunta al grafico de la letra

   pop HL        ;
   ld A, 8        ; Altura de las letras
   call PintaBloque8

   pop HL
   pop BC
   inc BC         ; Siguiente letra
   inc HL         ; Posicion en pantalla de la siguiente letra
   inc HL
   inc HL
   ;inc HL
   jr PintaTexto