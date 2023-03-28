; ***********************************************************
; ActualizaMarcadorP1: con la puntuacion actual del jugador 1
; IX: puntero a los datos del jugador 1
; ***********************************************************
ActualizaMarcadorSoft:
    ld D, POSX_MARCADOR_SOFT
    ld E, POSY_PUNTUACIONES
    ld B, POSX_MARCADOR_SOFT + 4
    ld C, POSY_PUNTUACIONES
    ld A, (IX+SPRITE_PUNTOS_SOFT)
    call ActualizaMarcador
    ret

ActualizaMarcadorHard:
    ld D, POSX_MARCADOR_HARD
    ld E, POSY_PUNTUACIONES
    ld B, POSX_MARCADOR_HARD + 4
    ld C, POSY_PUNTUACIONES
    ld A, (IX+SPRITE_PUNTOS_HARD)
    call ActualizaMarcador
    ret

ActualizaMarcadorVidas:
    ld D, POSX_VIDAS
    ld E, POSY_PUNTUACIONES
    call CoordenadasVideo
    ld DE, Marcador_09    
    ld A, 16
    call PintaBloque8
    ret

; ***********************************************************
; ActualizaMarcador: con la puntuacion actual de un jugador
; IX: puntero a los datos del jugador
; DE: coordenadas X,Y del primer digito
; BC: coordenadas X,Y del segundo digito
; A: puntuacion
; ***********************************************************
ActualizaMarcador:
    push AF
    push BC     ; Guardamos las coordenadas del segundo digito
    push AF
    ; Primer digito 
    call CoordenadasVideo
    ; Obtenemos el sprite del primer digito
    ;ld A, (IX+SPRITE_PUNTOS) ; Puntos en BCD
    pop AF
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
    ;ld A, (IX+SPRITE_PUNTOS)   ; Puntos en BCD
    pop AF
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

; ***********************************************************
; PintaMarcadorEstatico: textos del marcador que no cambian
; ***********************************************************
PintaMarcadorEstatico:
    ; Corazon
    ld D, POSX_CORAZON
    ld E, POSY_CORAZON
    call CoordenadasVideo
    ld DE, Marcador_10
    ld A, 16
    call PintaBloque8
    ; X
    ld D, POSX_CORAZON+4
    ld E, POSY_TEXTOS_ESTATICOS
    call CoordenadasVideo
    ld BC, TEXTO_X
    call PintaTexto

    ; HARD
    ld D, POSX_TEXTO_HARD
    ld E, POSY_TEXTOS_ESTATICOS
    call CoordenadasVideo
    ld BC, TEXTO_HARD
    call PintaTexto

    ; / 10
    ld D, POSX_MARCADOR_HARD + 8
    ld E, POSY_PUNTUACIONES
    call CoordenadasVideo
    ld DE, Marcador_11    
    ld A, 16
    call PintaBloque8

    ld D, POSX_MARCADOR_HARD_TOTAL
    ld E, POSY_PUNTUACIONES
    ld B, POSX_MARCADOR_HARD_TOTAL + 4
    ld C, POSY_PUNTUACIONES
    ld A, MAX_HARD_ITEMS   ; En BCD!
    call ActualizaMarcador

    ;SOFT
    ld D, POSX_TEXTO_SOFT
    ld E, POSY_TEXTOS_ESTATICOS
    call CoordenadasVideo
    ld BC, TEXTO_SOFT
    call PintaTexto

    ; / 50
    ld D, POSX_MARCADOR_SOFT + 8
    ld E, POSY_PUNTUACIONES
    call CoordenadasVideo
    ld DE, Marcador_11    
    ld A, 16
    call PintaBloque8

    ld D, POSX_MARCADOR_SOFT_TOTAL
    ld E, POSY_PUNTUACIONES
    ld B, POSX_MARCADOR_SOFT_TOTAL + 4
    ld C, POSY_PUNTUACIONES
    ld A, MAX_SOFT_ITEMS   ; En BCD!
    call ActualizaMarcador
    ret