; ***********************************************************
; ActualizaMarcadorP1: con la puntuacion actual del jugador 1
; IX: puntero a los datos del jugador 1
; ***********************************************************
ActualizaMarcadorP1:
    ld D, MARCADOR_P1_X1
    ld E, MARCADOR_P1_Y1
    ld B, MARCADOR_P1_X2
    ld C, MARCADOR_P1_Y2

; ***********************************************************
; ActualizaMarcador: con la puntuacion actual de un jugador
; IX: puntero a los datos del jugador
; DE: coordenadas X,Y del primer digito
; BC: coordenadas X,Y del segundo digito
; ***********************************************************
ActualizaMarcador:
    push BC     ; Guardamos las coordenadas del segundo digito
    ; Primer digito 
    call CoordenadasVideo
    ; Obtenemos el sprite del primer digito
    ld A, (IX+SPRITE_PUNTOS) ; Puntos en BCD
    srl A                    ; Sacamos el primer digito
    srl A                    ; desplazando cuatro veces 
    srl A                    ; a la derecha
    srl A
    ld B, 0
    ld C, A
    ld IY, Marcadortileset    ; Indice sobre la lista de sprites
    add IY, BC              ; Dos veces porque son words
    add IY, BC
    ld E, (IY+0)
    ld D, (IY+1)
    ld A, 16
    call PintaBloque8
    ; Segundo digito
    pop DE                  ; Sacamos las coordenadas de la pila
    call CoordenadasVideo
    ; Obtenemos el sprite del segundo digito
    ld A, (IX+SPRITE_PUNTOS)   ; Puntos en BCD
    and &0F    ; Sacamos el segundo digito con una mascara 00001111
    ld B, 0
    ld C, A
    ld IY, Marcadortileset    ; Indice sobre la lista de sprites
    add IY, BC              ; Dos veces porque son words
    add IY, BC
    ld E, (IY+0)
    ld D, (IY+1)
    ld A, 16
    call PintaBloque8
  
    ret
