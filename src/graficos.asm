; ***********************************************************
; TablaScanlines: inicializa la tabla con la direccion
; de memoria de cada linea de pantalla para acelerar
; la conversion de coordenadas X, Y a memoria de video
; ***********************************************************
TablaScanlines:
   ld IX, TABLA_SCANLINES  ; Inicio de la tabla
   ld HL, MEM_VIDEO        ; Primera linea
   ld A, LINEAS_POR_PANTALLA ; Contador sobre la tabla
TablaScanlines_Bucle:
   ld (IX+0), L
   ld (IX+1), H
   inc IX
   inc IX
   ld BC, #800             ; Siguiente linea
   add HL, BC              
   jr NC, TablaScanlines_SigLinea   
   ld BC, #C050
   add HL, BC
TablaScanlines_SigLinea:
   dec A
   jr NZ, TablaScanlines_Bucle
   ret

; ***********************************************************
; CoordenadasVideo: transforma las coordenadas X (0..79),
; Y (0..199) a posicion en memoria de video (C000...FFFF)
; usando la tabla TABLA_SCANLINES
; D: coordenada X (0..79)
; E: coordenada Y (0..199)
; HL: posicion correspondiente en memoria de pantalla
; ***********************************************************
CoordenadasVideo:
   ld HL, TABLA_SCANLINES  ; HL apunta al inicio de la tabla
   ld B, 0
   ld C, E                 ; Coordenada Y en BC
   add HL, BC
   add HL, BC              ; HL apunta a TABLA_SCANLINES[Y*2] (words, no bytes)
   ld C, D                 ; Coordenada X en BC
   ld E, (HL)              ; LSB de la direccion del inicio de linea (little endian)
   inc HL
   ld D, (HL)              ; MSB de la direccion del inicio de linea 
   ex DE, HL               ; Intercambiamos registros
   add HL, BC              ; Sumamos la coordenada X
   ret
   
; ***********************************************************
; PantallaABuffer: vuelca la pantalla actual al buffer secundario
; Modifica: HL, DE, BC
; ***********************************************************
PantallaABuffer:
   ld HL, MEM_VIDEO
   ld DE, BUFFER_PANTALLA
   ld BC, BYTES_POR_PANTALLA
   ldir
   ret
         
; ***********************************************************
; PintaFondo8: imprime un bloque del buffer (8px de ancho) en pantalla
; HL: posicion en memoria de video
; A: alto del bloque
; Modifica: DE, BC, HL, A
; ***********************************************************
PintaFondo8:
         ld D, H           ; Calculamos la posicion equivalente en el buffer de pantalla: 
         ld E, L           ; BUFFER_PANTALLA = MEM_VIDEO - 4000 (bit 6 del MSByte a 0)
         res 6, H          ; DE = memoria de video, HL = buffer pantalla
         ldi               ; Copiamos los 4 bytes de ancho (8 pixels)
         ldi               ; incrementando HL y DE
         ldi         
         ldi   
         ex DE, HL
         ld BC, #7FC       ; HL = HL + 7FC (#800 - 4 bytes) (primer pixel de la siguiente linea)
         add HL, BC
         jr NC, PintaFondo8_SigLinea
         ld BC, #C050
         add HL, BC        ; Cambio de linea de caracteres: acualizamos DE y HL
PintaFondo8_SigLinea:
         dec A
         jr NZ, PintaFondo8
         ret

; ***********************************************************
; PintaBloque8: pinta un bloque de 8 pixels de ancho
; HL: destino en memoria de video
; DE: origen del sprite
; A: altura del bloque (8 para tiles, 16 para sprites)
; Modifica: DE, BC, HL, A
; ***********************************************************
PintaBloque8:
         ex DE, HL   ; HL origen del sprite, DE destino en pantalla
         ldi         ; Copiamos los 8 pixels (4 bytes) de ancho
         ldi
         ldi
         ldi
         ld BC, #7FC ; Primer pixel de la siguiente linea (#800 - 4 bytes) 
         ex DE, HL   ; Ahora, destino en memoria de video en HL
         add HL, BC
         jr NC, PintaBloque8_SiguienteLinea
         ld BC, #C050
         add HL, BC
PintaBloque8_SiguienteLinea
         dec A
         jr NZ, PintaBloque8
         ret

; ***********************************************************
; PintaBloque8Mask: imprime sprite de 8 pixels de ancho 
; usando la tabla de mascaras
; HL: destino en memoria de video
; A: alto del bloque (8 para tiles, 16 para sprites)
; DE: origen del sprite
; Modifica: DE, BC, HL, A
; ***********************************************************
PintaBloque8Mask:
   ld BC, TABLA_MASCARAS
   ex AF, AF'  ; Preservamos A (alto del bloque)

   ; Desenrollamos la rutina de copiado de una linea (4 bytes)
   ; Primer byte
   ld A, (DE)   ; Byte de pantalla en A
   ld C, A      ; B no varia, C es el indice en la tabla
   ld A, (BC)   ; Traemos el valor de la tabla
   and (HL)     ; AND con mascara
   or C         ; OR con sprite
   ld (HL), A   ; Volcamos a pantalla
   inc DE       ; Siguiente byte en sprite
   inc HL       ; Siguiente pixel en pantalla
   ; Segundo byte
   ld A, (DE)   ; Byte de pantalla en A
   ld C, A      ; B no varia, C es el indice en la tabla
   ld A, (BC)   ; Traemos el valor de la tabla
   and (HL)     ; AND con mascara
   or C         ; OR con sprite
   ld (HL), A   ; Volcamos a pantalla
   inc DE       ; Siguiente byte en sprite
   inc HL       ; Siguiente pixel en pantalla
   ; Tercer byte
   ld A, (DE)   ; Byte de pantalla en A
   ld C, A      ; B no varia, C es el indice en la tabla
   ld A, (BC)   ; Traemos el valor de la tabla
   and (HL)     ; AND con mascara
   or C         ; OR con sprite
   ld (HL), A   ; Volcamos a pantalla
   inc DE       ; Siguiente byte en sprite
   inc HL       ; Siguiente pixel en pantalla
   ; Cuarto byte
   ld A, (DE)   ; Byte de pantalla en A
   ld C, A      ; B no varia, C es el indice en la tabla
   ld A, (BC)   ; Traemos el valor de la tabla
   and (HL)     ; AND con mascara
   or C         ; OR con sprite
   ld (HL), A   ; Volcamos a pantalla
   inc DE       ; Siguiente byte en sprite
   inc HL       ; Siguiente pixel en pantalla      

   ld BC, #7FC ; Primer pixel de la siguiente linea (#800 - 4 bytes) 
   add HL, BC
   jr NC, PintaBloque8Mask_SiguienteLinea
   ld BC, #C050
   add HL, BC
PintaBloque8Mask_SiguienteLinea
   ex AF, AF'  ; Recuperamos contador de lineas
   dec A
   jr NZ, PintaBloque8Mask
   ret

; ***********************************************************
; PintaObjetos: coloca en la memoria de video los objetos
; almacenados en el array PANTALLA_ACTUAL_OBJETOS
; con formato (visible,X,Y,tipo) hasta un maximo de MAX_OBJETOS
; ***********************************************************
PintaObjetos:
      ; Obtenemos el puntero al objeto
      ld IX, (PANTALLA_ACTUAL_OBJETOS)      ; Objetos de la pantalla
PintaObjetos_Bucle:
      ld A, (IX+0)            ; Visible/Invisible o fin de array
      cp #FF
      ret Z                   ; Fin de array, salimos
      cp 0                    ; Objeto invisible, lo saltamos
      jr Z, PintaObjeto_SigObjeto
      ld HL, Objetotileset    ; Lista de sprites para pintarlos
      ld B, 0
      ld C, (IX+3)      ; Tipo de objeto (indice en Objetotileset)
      add HL, BC
      add HL, BC  ; Sumamos dos veces (WORD) para desplazarnos por Objetotileset
      ld C, (HL)  ; LSB del objeto
      inc HL      ; Pasamos al MSB
      ld B, (HL)  ; Puntero al objeto en BC
      push BC     ; Modificamos BC en CoordenadasVideo
      ; Leemos las coordenadas del objeto
      ld D, (IX+1)      ; Coordenada X
      ld E, (IX+2)      ; Coordenada Y
      ; Calculamos la posicion en memoria de video en HL
      call CoordenadasVideo
      ld A, 8     ; Altura de los objetos (8 lineas)
      pop BC      ; Recuperamos puntero al objeto
      ld D, B
      ld E, C     ; Puntero al objeto en DE
      call PintaBloque8Mask
PintaObjeto_SigObjeto:
      ld B, 0
      ld C, 4
      add IX, BC  ; Siguiente objeto (+4 bytes)
      jr PintaObjetos_Bucle


; ***********************************************************
; PintaPantalla: compone una pantalla a partir de una lista de bloques
; IX: inicio de la definicion de la pantalla
; HL: inicio de la memoria de video
; Modifica: HL, BC, DE, IX, IY
; ***********************************************************
PintaPantalla:
      ld D, 0
      ld E, (IX+0)      ; DE = Numero de tile definido en la pantalla
      ;xor A             ; Nos saltamos el tile 0 (vacio)
      ;cp E
      ;jp Z, PintaPantalla_SigTile
      ld A, #FF         ; Byte de fin de pantalla
      cp E
      ret Z              ; Salir de la rutina, pantalla terminada
      ld IY, Tiletileset     ; IY apunta al inicio de la tabla de tiles
      add IY, DE        ; Desplazamos IY al tile con indice DE
      add IY, DE        ; (dos sumas para avanzar 2*DE bytes, ya que son words)
      ld E, (IY+0)      ; En DE la direccion del tile (ojo little endian)
      ld D, (IY+1)  
      push  HL          ; PintaBloque modifica HL (y BC)
      ld A, 8           ; 8 lineas de altura
      call PintaBloque8
      pop HL
PintaPantalla_SigTile:
      ld DE, 4
      add HL, DE        ; HL = HL + 4 bytes (siguiente posicion de tile)
      inc IX            ; Siguiente tile en la definicion de pantalla
      jp PintaPantalla

; ***********************************************************
; BloqueXY: devuelve el bloque que contiene el pixel X,Y.
; Usado para determinar colisiones con el escenario.
; Entrada:
; B: coordenada X (en bytes, 0..79)
; C: coordenada Y (en scanlines, 0..199)
; HL: puntero a la definicion de la pantalla
; Salida:
; A: tipo de bloque en esa posicion (#FF si fuera de la pantalla)
; Modifica A,BC,DE,HL
; ***********************************************************
BloqueXY:
      ; Salto fuera de la pantalla?
      ; B > 200?
      ld A, B
      add A, 56
      ld A, #FF
      jr NC, Sigue
      ret
Sigue:
      ; Pasamos de coordenadas de pantalla (0..79, 0..199)
      ; a coordenadas de bloques (0..19, 0..25)
      
      srl B             ; B = B/4
      srl B
      
      srl C             ; C = C/8
      srl C 
      srl C 

      ;ld A, C
      ;sub 4          ; Restamos las cuatro filas del marcador
                        ; porque la definicion de la pantalla
                        ; no las incluye

      ; HL = HL + 20C + B

      ld D, 0
      ld E, B           ; DE = B
      add HL, DE        ; HL = HL + B

      ld E, C           ; DE = C
      sla E             ; D <- carry <- E <- 0
      rl D              ; DE = 2C
      sla E             ; D <- carry <- E <- 0
      rl D              ; DE = 4C      
      add HL, DE        ; HL = HL + 4C + C
      
      sla E             ; D <- carry <- E <- 0
      rl D              ; DE = 8C
      sla E             ; D <- carry <- E <- 0
      rl D              ; DE = 16C      
      add HL, DE        ; HL = HL + 16C + 4C + B      

      ld A, (HL)        ; Sacamos el bloque de la tabla
      ret
  

; ***********************************************************
; ColorBorde: establece el color del borde
; A: color elegido
; Modifica: BC
; ***********************************************************
ColorBorde:
      ld BC, #7F10
      out (C), C  ; Seleccion borde en gate array 
      out (C), A  ; Puerto #7F40 + color
      ret

; ***********************************************************
; ColorPaleta: establece un color de la paleta
; D: pen number
; E: color number
; Modifica: BC
; ***********************************************************
ColorPaleta:
      ld BC, #7F00   ; Pen selection en gate array
      out (C), D     ; #7F00 + pen number
      out (C), E     ; #7F40 + color number
      ret

; ***********************************************************
; ColoresPaleta: establece una paleta completa
; HL: array de X colores
; B: numero de colores en el array
; Modifica: BC, HL, DE
; ***********************************************************
ColoresPaleta:
      ld D, 0        ; Indice del color
ColoresPaleta_Loop:
      ld E, (HL)
      push BC
      call ColorPaleta 
      pop BC
      inc D
      inc HL
      djnz ColoresPaleta_Loop
      ret

; ***********************************************************
; ModoPantalla: establece el modo grafico
; A = modo (0, 1 o 2)
; Modifica: BC
; ***********************************************************
ModoPantalla:
      ld BC, #7F8C   ; Upper#Lower ROM disabled
      add A, C
      out (C), A  ; #7F8C + modo pantalla
      ret

; ***********************************************************
; LimpiaPantalla: borra pantalla con color A
; A: byte a usar
; Modifica: HL, DE, BC
; ***********************************************************
LimpiaPantalla:
      ld HL, MEM_VIDEO
      ld E, L
      ld D, H
      inc DE         ; DE = HL + 1 (#C001)
      ld (HL), A     ; Byte a volcar en pantalla
      ld BC, MEM_VIDEO_TAM - 1 ; 16Kb - 1 (porque DE va uno por delante)
      ldir           ; Copia de HL (que siempre es 0) a DE (que es HL+1)
      ret            ; e incrementa HL y DE y decrementa BC

; ***********************************************************
; VSync: espera al comienzo del retrazo vertical
; ***********************************************************
VSync:
      ld B, #F5            ;; PPI port B input
VSync_Bucle:
      in A, (C)            ;; [4] read PPI port B input
                           ;; (bit 0 = "1" if vsync is active,
                           ;;  or bit 0 = "0" if vsync is in-active)
      rra                  ;; [1] put bit 0 into carry flag
      jp NC, VSync_Bucle   ;; [3] if carry not set, loop, otherwise continue
      ret


; ***********************************************************
; CapturaObjetos: comprueba si el jugador ha cogido
; alguno de los objetos visibles en la pantalla
; Input: 
; IX: puntero a los datos del jugador
; Output: 
; A: objeto con el que ha colisionado o #FF si ninguno
; ***********************************************************

CapturaObjetos:
      ld IY, (PANTALLA_ACTUAL_OBJETOS)
CapturaObjetos_Bucle:
      ld A, (IY+0)      ; Objeto invisible o fin de lista?
      cp #FF
      ret Z             ; Hemos recorrido toda la lista de objetos, fin
      cp #0             ; Objeto invisible, lo saltamos
      jr Z, CapturaObjetos_Siguiente
      call ColisionObjeto
      ; Si Carry, no colision y pasamos al siguiente
      jr C, CapturaObjetos_Siguiente

      ; Lo marcamos como invisible a partir de ahora
      ld A, 0
      ld (IY+0), A
      ; Y decrementamos el contador de objetos
      ld HL, NUM_OBJETOS
      dec (HL)

      ; Guardamos el tipo para devolverlo al final
      ld A, (IY+3)
      push AF

      ; Borramos el objeto A

      ; *********** Primera idea: borrar pintando el fondo
      ; Primero obtenemos su posicion en memoria de video en HL
      ;ld D, (IY+1)
      ;ld E, (IY+2)
      ;call CoordenadasVideo
      ; Y lo borramos sobreescribiendo el fondo
      ;ld A, 8     ; Alto del bloque
      ;call PintaFondo8
      ; **************************************************

      ; *********** Segunda idea: los objetos se pintan directamente
      ; sobre el buffer secundario de pantalla para que los enemigos
      ; no los borren al pasar por encima. Al capturar un objeto, 
      ; buscamos el tile original en la definicion de pantalla
      ; y lo volvemos a pintar en el buffer secundario.

      ld D, (IY+1)      ; Obtenemos las coordenadas en memoria de video (C000)
      ld E, (IY+2)      ; 
      call CoordenadasVideo
      push HL           ; Guardamo coordenadas en memoria de video para el repintado final
      res 6, H         ; Pasamos a coordenadas del BUFFER de pantalla (C000-4000)
      push HL           ; Lo guardamos en la pila para seguir usando HL

      ld B, (IY+1)      ; Coordenada X (0..79)
      ld C, (IY+2)      ; Coordenada Y (0..199)
      ld HL, PANTALLA_ACTUAL
      call BloqueXY     ; Obtenemos en A el tipo de bloque que ocupa esa posicion
                        ; o #FF si esta fuera de la pantalla
      cp #FF            ; No deberia pasar...
      ret Z

      ld HL, Tiletileset ; Lista de tiles, avanzamos hasta el tile A
      ld B, 0
      ld C, A
      add HL, BC        ; x2 al ser punteros
      add HL, BC
      ld E, (HL)
      inc HL
      ld D, (HL)        ; DE = puntero al tile

      ; Borramos el objeto en el BUFFER SECUNDARIO
      pop HL            ; Recuperamos la direccion de memoria del buffer de pantalla
      ld A, 8           ; Altura del bloque
      call PintaBloque8 ; HL = direccion en memoria de video 
                        ; DE = direccion de la definicion del bloque
                        ; A = altura del bloque (8)

      ; Repintamos el bloque en la memoria de video
      pop HL            ; Coordenadas en memoria de video (C000)
      ld A, 8
      call PintaFondo8

      pop AF      ; Recuperamos el tipo de objeto para devolverlo en A
      ret   ; No comprobamos el resto, salimos
CapturaObjetos_Siguiente:
      ; Pasamos al siguiente objeto
      ld B, 0
      ld C, 4
      add IY, BC
      jr CapturaObjetos_Bucle

; ***********************************************************
; ColisionSprites: detecta la colision entre personaje (8x16)
; y un objeto (8x8)
; Input:
; IX: datos personaje
; IY: datos objeto (visible, X, Y, tipo)
; Output:
; Flags de estado: NC colision, C no colision
; ***********************************************************

;; sprite 1 -> IX
;; ix+8: x1
;; ix+9: y1
;; ix+2: ancho sprite 1
;; ix+3: alto sprite 1

ColisionObjeto:
;;------------------------
;; X1 X2
;; [--A1--] [--A2--]
;;------------------------
;; if (X1 + A1 < X2 + 1) then no_collision
;; 0 < (X2 + 1) - (X1 + A1)
;; 0 > (X1 + A1) - (X2 + 1)
ld A, (IX+SPRITE_POSX) ; [5] A = X1
ld C, A ; [1] C = X1
add A, 4 ; [5] A = X1 + A1
ld B, (IY+1) ; [5] B = X2
inc B ; [1] B = X2 + 1
sub B ; [1] A = (X2 + 1) - (X1 + A1)
ret C ; [2/4] If Carry, no_collision

;; A = X2 + 1 - X1 + A1
;; B = X2 + 1
;; C = X1
;;------------------------
;; X2 X1
;; [--A2--] [--A1--]
;;------------------------
;; if (X2 + A2 < X1 + 1) then no_collision
;; 0 < (X1 + 1) - (X2 + A2)
;; 0 > (X2 + A2) - (X1 + 1)
inc C ; [1] C = X1 + 1
ld A, B ; [1] A = X2 + 1
add A, 4 ; [5] A = X2 + A2 + 1
dec A ; [1] A = X2 + A2
sub C ; [1] A = (X2 + A2) - (X1 + 1)
ret C ; [2/4] If Carry, no_collision

;;------------------------
;; Y1 Y2
;; [--H1--] [--H2--]
;;------------------------
;; if (Y1 + H1 < Y2 + 1) then no_collision
;; 0 < (Y2 + 1) - (Y1 + H1)
;; 0 > (Y1 + H1) - (Y2 + 1)
ld A, (IX+SPRITE_POSY) ; [5] A = Y1
ld C, A ; [1] C = Y1
add A, 16 ; [5] A = Y1 + H1
ld B, (IY+2) ; [5] B = Y2
inc B ; [1] B = Y2 + 1
sub B ; [1] A = (Y2 + 1) - (Y1 + H1)
ret C ; [2/4] If Carry, no_collision

;; A = Y2 + 1 - Y1 + H1
;; B = Y2 + 1
;; C = Y1
;;------------------------
;; Y2 Y1
;; [--H2--] [--H1--]
;;------------------------
;; if (Y2 + H2 < Y1 + 1) then no_collision
;; 0 < (Y1 + 1) - (Y2 + H2)
;; 0 > (Y2 + H2) - (Y1 + 1)
inc C ; [1] C = Y1 + 1
ld A, B ; [1] A = Y2 + 1
add A, 8 ; [5] A = Y2 + H2 + 1
dec A ; [1] A = Y2 + H2
sub C ; [1] A = (Y2 + H2) - (Y1 + 1)
ret ; [3] If Carry, no_collision
; If No-Carry, collision
;; Collision: Return with Carry flag off (NC)
;; No-Collision: Return with Carry flag on (C)

ColisionEnemigo:  ; Igual que ColisionObjeto pero con enemigos 8x16

ld A, (IX+SPRITE_POSX) ; [5] A = X1
ld C, A ; [1] C = X1
add A, 4 ; [5] A = X1 + A1
ld B, (IY+ENEMIGO_POSX) ; [5] B = X2
inc B ; [1] B = X2 + 1
sub B ; [1] A = (X2 + 1) - (X1 + A1)
ret C ; [2/4] If Carry, no_collision

inc C ; [1] C = X1 + 1
ld A, B ; [1] A = X2 + 1
add A, 4 ; [5] A = X2 + A2 + 1
dec A ; [1] A = X2 + A2
sub C ; [1] A = (X2 + A2) - (X1 + 1)
ret C ; [2/4] If Carry, no_collision

; Solo consideramos la parte baja (8x8) del enemigo,
; para que el jugador pueda saltarlo por encima
; aunque toque la parte superior
ld B, (IY+ENEMIGO_POSY) ; [5] B = Y2
ld A, CHEAT_SALTO     ; Bajamos 8 lineas la posicion Y
add A, B
ld B, A
ld A, (IX+SPRITE_POSY) ; [5] A = Y1
ld C, A ; [1] C = Y1
add A, 16 ; [5] A = Y1 + H1
sub B ; [1] A = (Y2 + 1) - (Y1 + H1)
ret C ; [2/4] If Carry, no_collision

inc C ; [1] C = Y1 + 1
ld A, B ; [1] A = Y2 + 1
add A, 16-CHEAT_SALTO ; [5] A = Y2 + H2 + 1
dec A ; [1] A = Y2 + H2
sub C ; [1] A = (Y2 + H2) - (Y1 + 1)
ret ; [3] If Carry, no_collision
; If No-Carry, collision
;; Collision: Return with Carry flag off (NC)
;; No-Collision: Return with Carry flag on (C)

