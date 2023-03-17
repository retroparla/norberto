
; CalculaEstado: comprueba las teclas pulsadas para determinar
; el estado del personaje (parado, andando derecha, andando izquierda,
; salto parado, salto derecha, salto izquierda, congelado)
; Input: 
; D: teclas pulsadas para el jugador X
; IX: puntero a los datos del jugador
; Modifica IX+SPRITE_ESTADO con el nuevo estado del jugador

CalculaEstado:
      ld A, (IX+SPRITE_CONGELADO)   ; Esta congelado?
      cp 1
      jr NZ, CalculaEstado_Parado
      ld A, MOV_CONGELADO
      ld (IX+SPRITE_ESTADO), A
      ret
CalculaEstado_Parado:
      xor A          ; A = 0
      cp D           ; Si no hay teclas pulsadas, PARADO o SALTO y fin
      jr NZ, CalculaEstado_Derecha
      ld A, MOV_PARADO
      ld (IX+SPRITE_ESTADO), A     ; Guarda estado en memoria y salimos
      ret
CalculaEstado_Derecha:  ; Comprobamos derecha
      bit KEY_RIGHT, D
      jr Z, CalculaEstado_Izquierda
      ld A, MOV_DERECHA       ; Derecha SI
      jr CalculaEstado_Salto     ; Salto derecha?
CalculaEstado_Izquierda:
      bit KEY_LEFT, D
      jr Z, CalculaEstado_Salto
      ld A, MOV_IZQUIERDA
CalculaEstado_Salto:
      bit KEY_UP, D
      jr Z, CalculaEstado_Fin
      add A, MOV_SALTO            ; SALTO + PARADO ,SALTO + DERECHA, SALTO + IZQUIERDA
CalculaEstado_Fin:
      ld (IX+SPRITE_ESTADO), A       ; Guarda el estado en memoria
      ret

;SiguienteAnimacion: actualiza el puntero al siguiente frame
;de la animacion dependiendo del estado del personaje
;Input:
;IX: puntero a los datos del sprite
SiguienteAnimacion:
      ld A, (IX+SPRITE_ESTADO)
      cp MOV_CONGELADO
      jr NZ, SiguienteAnimacion_Start
      ld H, (IX+SPRITE_FRAMES+FRAME_CONGELADO)
      ld L, (IX+SPRITE_FRAMES+FRAME_CONGELADO+1)
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_Start:
      cp MOV_PARADO              ; Si esta parado usamos el primer frame
      jr NZ, SiguienteAnimacion_Derecha
      ld A, (IX+SPRITE_SALTO)       ; Parado pero subiendo?
      cp 0
      jr Z, SiguienteAnimacion_Parado
      ld H, (IX+SPRITE_FRAMES+FRAME_SALTO) ; Usamos frame SALTO
      ld L, (IX+SPRITE_FRAMES+FRAME_SALTO+1) 
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_Parado:
      ld H, (IX+SPRITE_FRAMES+FRAME_PARADO) ; Usamos frame PARADO si cae o esta quieto
      ld L, (IX+SPRITE_FRAMES+FRAME_PARADO+1) 
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_Derecha:
      cp MOV_DERECHA             ; Andando hacia la derecha?
      jr NZ, SiguienteAnimacion_Izquierda
      ld A, (CICLO_ANIMACION)       ; Alternamos entre DERECHA1 y DERECHA2
      rrca                          ; cada dos frames
      jr C, SiguienteAnimacion_Derecha1
      ld H, (IX+SPRITE_FRAMES+FRAME_DERECHA2) ; Si frame impar, usamos DERECHA2
      ld L, (IX+SPRITE_FRAMES+FRAME_DERECHA2+1) 
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_Derecha1:
      ld H, (IX+SPRITE_FRAMES+FRAME_DERECHA1) ; Si frame par, usamos DERECHA1
      ld L, (IX+SPRITE_FRAMES+FRAME_DERECHA1+1) 
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_Izquierda:
      cp MOV_IZQUIERDA             ; Andando hacia la izquierdaa?
      jr NZ, SiguienteAnimacion_Salto
      ld A, (CICLO_ANIMACION)       ; Alternamos entre IZQUIERDA1 e IZQUIERDA2
      rrca                          ; cada dos frames
      jr C, SiguienteAnimacion_Izquierda1
      ld H, (IX+SPRITE_FRAMES+FRAME_IZQUIERDA2) ; Si frame impar, usamos IZQUIERDA2
      ld L, (IX+SPRITE_FRAMES+FRAME_IZQUIERDA2+1) 
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_Izquierda1:
      ld H, (IX+SPRITE_FRAMES+FRAME_IZQUIERDA1) ; Si frame par, usamos IZQUIERDA1
      ld L, (IX+SPRITE_FRAMES+FRAME_IZQUIERDA1+1) 
      jr SiguienteAnimacion_Fin
 SiguienteAnimacion_Salto:
      cp MOV_SALTO
      jr NZ, SiguienteAnimacion_SaltoDerecha
      ld H, (IX+SPRITE_FRAMES+FRAME_SALTO) 
      ld L, (IX+SPRITE_FRAMES+FRAME_SALTO+1) 
      jr SiguienteAnimacion_Fin
SiguienteAnimacion_SaltoDerecha:
      cp MOV_SALTO_DERECHA
      jr NZ, SiguienteAnimacion_SaltoIzquierda
      ld H, (IX+SPRITE_FRAMES+FRAME_SALTO_DERECHA) 
      ld L, (IX+SPRITE_FRAMES+FRAME_SALTO_DERECHA+1) 
      jr SiguienteAnimacion_Fin
 SiguienteAnimacion_SaltoIzquierda:
      cp MOV_SALTO_IZQUIERDA
      ret NZ
      ld H, (IX+SPRITE_FRAMES+FRAME_SALTO_IZQUIERDA) 
      ld L, (IX+SPRITE_FRAMES+FRAME_SALTO_IZQUIERDA+1) 
SiguienteAnimacion_Fin
      ld (IX+SPRITE_FRAME), H       ; Copiamos la direccion de la nueva animacion
      ld (IX+SPRITE_FRAME+1), L     ; al atributo FRAME
      ret



; Actualiza la posicion del personaje a partir
; de su estado actual, chequeando las posibles
; colisiones con el escenario
; Input:
; IX: puntero al personaje
; Output:
; Modifica los registros y la posicion del personaje
CalculaPosicion:
      ; Estamos saltando?
      ld A, (IX+SPRITE_SALTO) ; 0 = no hay salto
      cp 0
      jr Z, CalculaPosicion_Parado
      ; Estamos en pleno salto. Calculamos el nuevo
      ; incremento en la altura del personaje
      ; leyendo CICLO_SALTO[IX+SPRITE_SALTO+1]
      inc A       ; Siguiente valor del ciclo de salto
      ld B, 0
      ld C, A
      ld HL, CICLO_SALTO
      add HL, BC  ; 
      ld A, (HL)  ; A = CICLO_SALTO[IX+SPRITE_SALTO+1]

      ; Si A=0, hemos llegado al fin del ciclo de salto
      cp 0
      jr Z, CalculaPosicion_FinSalto

      ; Comprobamos si podemos seguir saltando
      ; sin colisionar con ningun bloque
      ; Miramos primero esquina TOP LEFT
      ld C, A
      ld B, (IX+SPRITE_POSX)
      ld A, (IX+SPRITE_POSY)
      sub C       ; Restamos el offset del salto
      ; Si Carry es que salimos por la parte superior de la pantalla!
      jr NC, CalculaPosicion_NoSalePorArriba

      ; Nos salimos de la pantalla por arriba
      ld A, CAMBIO_PANTALLA_ARRIBA
      ld (CAMBIO_PANTALLA), A       ; Activamos flag de cambio de pantalla
      ret 

CalculaPosicion_NoSalePorArriba:  
      ld C, A

      push AF        ; Guardamos el offset para actualizarlo al final
      push BC
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      pop BC      ; Recuperamos esquina top left antes del ret
      cp TILES_FONDO
      jr NC, CalculaPosicion_FinSaltoPop  ; Chocamos con bloque solido, fin.

      ; Comprobamos tambien la esquina TOP RIGHT
      inc B       ; Desplazamos 3 bytes a la derecha
      inc B 
      inc B 
      ld HL, PANTALLA_ACTUAL
      call BloqueXY

      cp TILES_FONDO
      jr NC, CalculaPosicion_FinSaltoPop      ; Chocamos con bloque solido, fin.

      ; Seguimos saltando
      ; Recuperamos el incremento en A y
      ; guardamos nueva posicion Y
      pop AF
      ld (IX+SPRITE_POSY), A
      inc (IX+SPRITE_SALTO)

      jr CalculaPosicion_Sigue
CalculaPosicion_FinSaltoPop:
      pop AF            ; Limpiamos la pila
CalculaPosicion_FinSalto:
      ld (IX+SPRITE_SALTO), 0       ; Reset flag de salto
      
CalculaPosicion_Parado:
      ; Miramos si estamos sobre tierra firme.
      ; En caso contrario, caemos.
      ld B, (IX+SPRITE_POSX)
      ld A, (IX+SPRITE_POSY)

      ; Comprobamos pixel bajo el sprite (y+16) (bottom left)
      add A, 16
      ld C, A 
      push BC

      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      pop BC

      ; Si hay bloque debajo nos saltamos toda esta parte
      cp TILES_FONDO
      jr NC, CalculaPosicion_NoCae

      ; Comprobamos tambien pixel inferior derecho (x+3) (bottom right)
      inc B 
      inc B 
      inc B 
      ld HL, PANTALLA_ACTUAL
      call BloqueXY

      ; Si hay bloque debajo nos saltamos toda esta parte
      cp TILES_FONDO
      jr NC, CalculaPosicion_NoCae

      ; Si estamos en pleno salto, no podemos caer
      ; Salto != 0 significa que aun esta subiendo
      ld A, (IX+SPRITE_SALTO)
      cp 0
      jr NZ, CalculaPosicion_NoCae

      ; Estamos cayendo, actualiza POSY
      ld C, (IX+SPRITE_POSY)
      inc C
      inc C
      inc C
      inc C 
      ld (IX+SPRITE_POSY), C


      ld (IX+SPRITE_CAIDA), 1 ; Flag de caida ON

      ; Nos salimos de la pantalla por abajo?
      ld A, C
      cp 164      
      jr C, CalculaPosicion_Sigue
      ld A, CAMBIO_PANTALLA_ABAJO
      ld (CAMBIO_PANTALLA), A       ; Activamos flag de cambio de pantalla
      ret 

      ; Ponemos MOV_SALTO para cambiar la animacion
     ; ld (IX+SPRITE_ESTADO), MOV_SALTO 
      ;ret
      jr CalculaPosicion_Sigue

CalculaPosicion_NoCae:
      ld (IX+SPRITE_CAIDA), 0 ; Flag de caida OFF

CalculaPosicion_Sigue:

      ; Puntero al primer bloque de la pantalla
      ld A, (IX+SPRITE_ESTADO)      ; Estado del sprite

      cp MOV_PARADO  ; Si esta quieto no modificamos nada
      ret Z             


CalculaPosicion_Derecha
      cp MOV_DERECHA ; Andamos hacia la derecha 2 pixels
      jr Z, CalculaPosicionDerecha_NoSalto
      cp MOV_SALTO_DERECHA ; Andamos hacia la derecha saltando
      jr NZ, CalculaPosicion_Izquierda
CalculaPosicionDerecha_NoSalto:
      ; Comprobamos si podemos avanzar dos pixels
      ; hacia la derecha. Cogemos la posicion X actual
      ; y le sumamos 3 (para llegar al pixel superior derecho)
      ; y 1 byte mas de avance
      ld A, (IX+SPRITE_POSX)
      add A, 4
      cp 80       ; Nos salimos por la derecha? A=A-80 y comprobar signo (flag S)
      jp M, CalculaPosicionDerecha_NoBorde ; A-80 < 0 (S=1), no hemos llegado al borde derecho
      ld A, CAMBIO_PANTALLA_DERECHA ; Nos salimos! A-80 >= 0 (S=0) -> Cambio de pantalla
      ld (CAMBIO_PANTALLA), A       ; Activamos flag de cambio de pantalla
      ret
      
CalculaPosicionDerecha_NoBorde:
      ld B, A     ; B = coordenada X
      ; La coordenada Y no cambia (top right)
      ld C, (IX+SPRITE_POSY)  ; C = coordenada Y

      ; Nos guardamos BC (x,y) para comprobar despues
      ; otros dos pixels
      push BC

      ; Devuelve en A el tipo de bloque
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      cp TILES_FONDO        ; Si no es bloque vacio, choque 
      pop BC
      jr NC, CalculaPosicion_Salto  ; Comprobamos salto tambien

      ; Comprobamos el pixel medio tambien (middle right)
      ld A, C
      add A, 8    ; Ocho pixels hacia abajo
      ld C, A
      push BC     ; Guardamos para la siguiente comprobacion
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      cp TILES_FONDO
      pop BC
      jr NC, CalculaPosicion_Salto  ; Comprobamos salto tambien

      ; Ultima comprobacion, parte de abajo (bottom right)
      ld A, C
      add A, 7
      ld C, A
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      cp TILES_FONDO
      jr NC, CalculaPosicion_Salto  ; Comprobamos salto tambien, 
                                    ; para poder saltar en diagonal

CalculaPosicion_Derecha_Ok:
      ; Si hemos llegado hasta aqui, podemos avanzar a la derecha
      ld A, (IX+SPRITE_POSX)
      inc A
      ;inc A
      ld (IX+SPRITE_POSX), A
      ;ret
      jr CalculaPosicion_Salto ; Comprobamos salto tambien

CalculaPosicion_Izquierda:
      cp MOV_IZQUIERDA ; Andamos hacia la izquierda 2 pixels
      jr Z, CalculaPosicionIzquierda_NoSalto
      cp MOV_SALTO_IZQUIERDA  ; Andamos hacia la izquierda saltando
      jr NZ, CalculaPosicion_Salto

CalculaPosicionIzquierda_NoSalto
      ; Comprobamos si podemos avanzar dos pixels
      ; hacia la izquierda. Cogemos la posicion X actual
      ; (top left)y le restamos los 2 pixels (1 byte) de avance
      ld A, (IX+SPRITE_POSX)
      sub 1
      jp NC, CalculaPosicionIzquierda_NoBorde ; No hemos llegado al borde izquierdo, continuamos
      ld A, CAMBIO_PANTALLA_IZQUIERDA ; Nos salimos por la izquierda -> Cambio de pantalla
      ld (CAMBIO_PANTALLA), A       ; Activamos flag de cambio de pantalla
      ret      

CalculaPosicionIzquierda_NoBorde:      
      ld B, A     ; B = coordenada X


      ; La coordenada Y no cambia (top left)
      ld C, (IX+SPRITE_POSY)  ; C = coordenada Y

      ; Nos guardamos BC (x,y) para comprobar despues
      ; otros dos pixels
      push BC

      ; Devuelve en A el tipo de bloque
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      cp TILES_FONDO        ; Si no es bloque vacio, choque y salimos
      pop BC      ; Restauramos la pila antes de salir
      jr NC, CalculaPosicion_Salto  ; Comprobamos salto tambien

      ; Comprobamos el pixel medio tambien (middle left)
      ld A, C
      add A, 8    ; Ocho pixels hacia abajo
      ld C, A
      push BC     ; Guardamos para la siguiente comprobacion
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      cp TILES_FONDO        ; Si no es bloque vacio, choque y salimos
      pop BC      ; Restauramos la pila antes de salir
      jr NC, CalculaPosicion_Salto  ; Comprobamos salto tambien

      ; Ultima comprobacion, parte de abajo (bottom left)
      ld A, C
      add A, 7    ; Siete pixels mas abajo
      ld C, A
      ld HL, PANTALLA_ACTUAL
      call BloqueXY
      cp TILES_FONDO        ; Si no es bloque vacio, choque y salimos
      jr NC, CalculaPosicion_Salto  ; Comprobamos salto tambien

      ; Podemos movernos a la izquierda, actualizamos POSY
      ld A, (IX+SPRITE_POSX)
      dec A
      ;dec A 
      ld (IX+SPRITE_POSX), A
      ;ret  ; Comprobamos salto tambien, para poder saltar en diagonal

CalculaPosicion_Salto:
      ; Comprobamos si INICIAMOS un salto.
      ; El resto del salto se procesa al inicio de
      ; esta rutina.
      ld A, (IX+SPRITE_ESTADO)      ; Estado del sprite
      cp MOV_SALTO                  ; Salto parado
      jr Z, CalculaPosicion_SaltoParado
      cp MOV_SALTO_DERECHA          ; Salto a la derecha
      jr Z,  CalculaPosicion_SaltoParado
      cp MOV_SALTO_IZQUIERDA        ; Salto a la izquierda
      ret NZ

CalculaPosicion_SaltoParado: 
      ; Si estamos cayendo no podemos saltar!
      ld A, (IX+SPRITE_CAIDA)
      cp 1
      ret Z

      ; Habiamos comenzado antes el salto?
      ld A, (IX+SPRITE_SALTO)
      cp 0
      ret NZ  ; Si es asi, salimos tambien.

      ; Al iniciar el salto NO COMPROBAMOS COLISIONES
      ; en la parte superior. De esta forma el personaje
      ; es capaz de subir a una plataforma de 8 pixels
      ; que tenga justo encima. Si la plataforma es de 
      ; 16 o mas pixels de grosor, en el segundo paso
      ; del salto detectara la colision y rebotara 
      ; hacia abajo.

      ; Estamos sobre un bloque solido e iniciamos salto.
      ; Cogemos el primer valor del array CICLO_SALTO 
      ; y comprobamos que no hay colision en TOP LEFT
      ; tras modificar la coordenada Y
;;      ld A, (CICLO_SALTO)
;;      ld C, A

;;      ld B, (IX+SPRITE_POSX)
;;      ld A, (IX+SPRITE_POSY)
;;      sub C       ; Restamos el primer decremento del salto
;;      ld C, A 
;;      push BC
;;      ld HL, (PANTALLA_ACTUAL)
;;      call BloqueXY
;;      pop BC      ; Recuperamos esquina top left antes del ret
;;      cp TILES_FONDO
;;      ret NC      ; Chocamos con bloque solido, fin.

      ; Comprobamos tambien la esquina TOP RIGHT

;;      inc B       ; Desplazamos 3 bytes a la derecha
;;      inc B 
;;      inc B 
;;      ld HL, (PANTALLA_ACTUAL)
;;      call BloqueXY

;;     cp TILES_FONDO
;;      ret NC      ; Chocamos con bloque solido, fin.
      
      ; Podemos iniciar el salto. Actualizamos
      ; el contador del ciclo de salto y 
      ; decrementamos la coordenada Y convenientemente
      ld (IX+SPRITE_SALTO), 1 ; Iniciamos contador de salto
      ld HL, CICLO_SALTO+1
      ld A, (IX+SPRITE_POSY)  ; Posicion Y actual
      sub (HL)                ; Restamos CICLO_SALTO[1]
      ld (IX+SPRITE_POSY), A  ; Guardamos nueva POSY
 
      ret   

