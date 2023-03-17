; Lee los indices de las pantallas adyacentes a la
; pantalla actual. Despues descomprime la pantalla
; en el buffer PANTALLA_ACTUAL de 20x22 tiles
; HL: puntero a la definicion de la pantalla (comprimida)
DescomprimePantallaActual:
   ld DE, PANTALLA_ACTUAL   ; Destino, pantalla descomprimida
DescomprimePantallaActual_Bucle:
   ld B, 1        ; Contador de repeticiones (1 por defecto)
   ld A, (HL)
   cp &FF         ; Fin de pantalla?
   jp NZ, DescomprimePantallaActual_NoFin
   ld (DE), A     ; Copiamos el &FF para indicar fin de pantalla
   ret            ; Fin
DescomprimePantallaActual_NoFin:
   cp &80         ; Tile < 80? No hay repeticion, se vuelca un unico tile
   jp C, DescomprimePantallaActual_Rep
   sub &80        ; A = A-80, calculamos el ID real del tile
   inc HL         ; El siguiente byte es el numero de repeticiones
   ld B, (HL)     ; Contador de repeticiones en B
DescomprimePantallaActual_Rep:
   ld (DE), A
   inc DE
   djnz DescomprimePantallaActual_Rep   ; Copiamos B veces el mismo tile A
   inc HL         ; Siguiente tile
   jp DescomprimePantallaActual_Bucle

   
; El jugador ha pasado a otra pantalla.
; Buscamos cual es la nueva pantalla a partir de
; la pantalla actual y la direccion del cambio.
; Ademas, ajustamos la coordenada X o Y del jugador
; para posicionarlo correctamente en la siguiente pantalla.

CambioPantalla:
   ld HL, PANTALLA_ACTUAL_INDICE    ; HL apunta al indice de la pantalla actual

   ; Calculamos los indices de las nuevas pantallas adyacentes
   ; y los guardamos en sus respectivas variables
   ld A, (PANTALLA_ACTUAL_INDICE)
   dec A 
   ld (PANTALLA_ACTUAL_SALIDA_IZQUIERDA), A  ; PANTALLA_ACTUAL_INDICE - 1
   add A, 2
   ld (PANTALLA_ACTUAL_SALIDA_DERECHA), A    ; PANTALLA_ACTUAL_INDICE + 1
   add A, 16
   ld (PANTALLA_ACTUAL_SALIDA_ABAJO), A      ; PANTALLA_ACTUAL_INDICE + 17
   sub 34
   ld (PANTALLA_ACTUAL_SALIDA_ARRIBA), A     ; PANTALLA_ACTUAL_INDICE - 17

   ld A, (CAMBIO_PANTALLA)                   ; Sentido del cambio
   cp CAMBIO_PANTALLA_DERECHA
   jp NZ, CambioPantalla_Izquierda;
   ; El jugador pasa a la pantalla adyacente a la derecha
   ; Se mantiene coordenada Y y se resetea coordenada X
   ld IX, PLAYER1
   ld (IX+SPRITE_POSX), 0
   ld A, (PANTALLA_ACTUAL_SALIDA_DERECHA) ; Actualizamos PANTALLA_ACTUAL_INDICE
   ld (HL), A
   jp CambioPantalla_Sigue

CambioPantalla_Izquierda:
   cp CAMBIO_PANTALLA_IZQUIERDA
   jp NZ, CambioPantalla_Abajo;
   ; El jugador pasa a la pantalla adyacente a la izquierda
   ; Se mantiene coordenada Y y se resetea coordenada X
   ld IX, PLAYER1
   ld (IX+SPRITE_POSX), 76
   ld A, (PANTALLA_ACTUAL_SALIDA_IZQUIERDA) ; Actualizamos PANTALLA_ACTUAL_INDICE
   ld (HL), A
   jp CambioPantalla_Sigue

CambioPantalla_Abajo:
   cp CAMBIO_PANTALLA_ABAJO
   jp NZ, CambioPantalla_Arriba  ; Suponemos cambio a pantalla superior
   ; El jugador pasa a la pantalla adyacente por debajo
   ; Se mantiene coordenada X y se resetea coordenada Y
   ld IX, PLAYER1
   ld (IX+SPRITE_POSY), 0
   ld A, (PANTALLA_ACTUAL_SALIDA_ABAJO)
   ld (HL), A
   jp CambioPantalla_Sigue
   
CambioPantalla_Arriba:
   cp CAMBIO_PANTALLA_ARRIBA
   jp NZ, CambioPantalla_Sigue  ; Suponemos cambio a pantalla superior
   ; El jugador pasa a la pantalla adyacente por arriba
   ; Se mantiene coordenada X y se resetea coordenada Y
   ld IX, PLAYER1
   ld (IX+SPRITE_POSY), 160
   ld A, (PANTALLA_ACTUAL_SALIDA_ARRIBA)
   ld (HL), A

CambioPantalla_Sigue:
   ; Reseteamos el flag de cambio de pantalla
   ld A, CAMBIO_PANTALLA_NO
   ld (CAMBIO_PANTALLA), A
   
   ; HL sigue apuntando a PANTALLA_ACTUAL_INDICE
   ld B, 0
   ld C, (HL)
   ld HL, LISTA_PANTALLAS  ; Comienzo del array de pantallas
   add HL, BC              ; Sumamos el indice (2 veces al ser words)
   add HL, BC
   ld DE, PANTALLA_ACTUAL_COMPRIMIDA 
   ldi                     ; Copiamos los dos bytes de HL a PANTALLA_ACTUAL_COMPRIMIDA
   ldi

   ; ; Incrementamos el indice a los objetos de la pantalla
   ; ld HL, PANTALLA_ACTUAL_INDICE
   ; ld B, 0
   ; ld C, (HL)
   ; ld HL, LISTA_PANTALLAS_OBJETOS  ; Comienzo del array de objetos
   ; add HL, BC              ; Sumamos el indice (2 veces al ser words)
   ; add HL, BC
   ; ld DE, PANTALLA_ACTUAL_OBJETOS  
   ; ldi                     ; Copiamos los dos bytes de HL a PANTALLA_ACTUAL_OBJETOS
   ; ldi

   ; ; Incrementamos el indice a los enemigos de la pantalla
   ; ld HL, PANTALLA_ACTUAL_INDICE
   ; ld B, 0
   ; ld C, (HL)
   ; ld HL, LISTA_PANTALLAS_ENEMIGOS  ; Comienzo del array de objetos
   ; add HL, BC              ; Sumamos el indice (2 veces al ser words)
   ; add HL, BC
   ; ld DE, PANTALLA_ACTUAL_ENEMIGOS  
   ; ldi                     ; Copiamos los dos bytes de HL a PANTALLA_ACTUAL_OBJETOS
   ; ldi   

   ret