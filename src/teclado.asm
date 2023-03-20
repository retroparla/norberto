; LeerTeclado: rellena el array TECLADO con el estado completo de las teclas
LeerTeclado:
   ;;;;;; di
   ld HL, MAPA_TECLADO
   ld BC, &F782
   out (C), C
   ld BC, &F40E
   ld E, B
   out (C), C
   ld BC, &F6C0
   ld D, B
   out (C),C
   ld C, 0
   out (C), C
   ld BC, &F792
   out (C), C
   ld A, &40
   ld C, &4a
LeerTeclado_Bucle:
   ld B, D
   out (C), A
   ld B, E
   ini
   inc A
   cp C
   jr C, LeerTeclado_Bucle
   ld BC, &F782
   out (C), C
   ;;;;;; ei

   ; Chequea la pulsacion de las teclas del juego
   ld HL, MAPA_TECLADO     ; Inicio del array de teclas
   ld D, 0                ; Reseteamos bits de pulsaciones
   ; Fila 0: INTRO, DOWN, RIGHT, UP
   ld A, (HL)
LeerTeclado_INTRO:
   bit KEY_INTRO_MASK, A
   jp NZ, LeerTeclado_DOWN
   set KEY_RETURN, D
LeerTeclado_DOWN:
   bit KEY_DOWN_MASK, A
   jp NZ, LeerTeclado_UP
   set KEY_DOWN, D
LeerTeclado_UP:
   bit KEY_UP_MASK, A
   jp NZ, LeerTeclado_RIGHT
   set KEY_UP, D
LeerTeclado_RIGHT:
   bit KEY_RIGHT_MASK, A
   jp NZ, LeerTeclado_LEFT
   set KEY_RIGHT, D
LeerTeclado_LEFT:
   inc HL      ; Fila 1: LEFT
   ld A, (HL)
   bit KEY_LEFT_MASK, A
   jp NZ, LeerTeclado_RETURN
   set KEY_LEFT, D
LeerTeclado_RETURN:
   inc HL      ; Fila 2: RETURN
   ld A, (HL)
   bit KEY_RETURN_MASK, A
   jp NZ, LeerTeclado_P
   set KEY_RETURN, D
LeerTeclado_P:
   inc HL      ; Fila 3: P
   ld A, (HL)
   bit KEY_P_MASK, A
   jp NZ, LeerTeclado_O
   set KEY_RIGHT, D
LeerTeclado_O:
   inc HL      ; Fila 4: O
   ld A, (HL)
   bit KEY_O_MASK, A
   jp NZ, LeerTeclado_SPACE
   set KEY_LEFT, D
LeerTeclado_SPACE:
   inc HL      ; Fila 5: SPACE
   ld A, (HL)
   bit KEY_SPACE_MASK, A
   jp NZ, LeerTeclado_Q
   set KEY_FIRE, D
LeerTeclado_Q:
   inc HL      ; Fila 6
   inc HL      ; Fila 7
   inc HL      ; Fila 8: Q
   ld A, (HL)
   bit KEY_Q_MASK, A
   jp NZ, LeerTeclado_JOY_FIRE
   set KEY_UP, D
LeerTeclado_JOY_FIRE:
   inc HL      ; Fila 9: JOYSTICK
   ld A, (HL)
   bit KEY_JOY_FIRE_MASK, A
   jp NZ, LeerTeclado_JOY_FIRE2
   set KEY_FIRE, D
LeerTeclado_JOY_FIRE2:
   bit KEY_JOY_FIRE2_MASK, A
   jp NZ, LeerTeclado_JOY_DOWN
   set KEY_FIRE, D   
LeerTeclado_JOY_DOWN:
   bit KEY_JOY_DOWN_MASK, A
   jp NZ, LeerTeclado_JOY_UP
   set KEY_DOWN, D
LeerTeclado_JOY_UP:
   bit KEY_JOY_UP_MASK, A
   jp NZ, LeerTeclado_JOY_RIGHT
   set KEY_UP, D
LeerTeclado_JOY_RIGHT:
   bit KEY_JOY_RIGHT_MASK, A
   jp NZ, LeerTeclado_JOY_LEFT
   set KEY_RIGHT, D
LeerTeclado_JOY_LEFT:
   bit KEY_JOY_LEFT_MASK, A
   jp NZ, LeerTeclado_Fin
   set KEY_LEFT, D
LeerTeclado_Fin:
   ld A, D
   ld (TECLAS_PULSADAS), A   ; Guarda estado de teclas en RAM
   ret