
; El buffer ENEMIGOS esta compuesto por un total de MAX_ENEMIGOS
; elementos con esta estructura:

; - Estaticos (provienen de la definicion del enemigo en cada pantalla
;   o de la lista de animaciones de cada tipo de personaje)
; - No se modifican.
; DB X: posicion horizontal (en bytes)
; DB Y: posicion vertical (en scanlines)
; DB tipo: indice al array de sprites de enemigos
; DB desp: total de bytes/scanlines que se desplaza en un sentido
; DB dir: 0 = horizontal, 1 = vertical
; DB sen: 0 = izq-dcha, arriba->abajo, 1 = dcha->izq, abajo->arriba
; DB vel: numero de bytes/scanlines que se mueve en cada repintado
; DB rate: cada cuantos refrescos de pantalla se redibuja el enemigo

; - Estos se sacan de la lista de definicion de animaciones de los
; - enemigos usando tipo como indice
; DW anim: puntero a la lista de frames del enemigo.
; DB numAnim: numero de frames que componen la animacion del enemigo
;             (en un unico sentido, es decir, total de frames / 2)

; - Dinamicos (se actualizan en cada repintado del enemigo)
; DB despAct: contador desp que se decrementa en cada repintado.
;             Al llegar a 0, cambiamos el sentido del enemigo.
; DB senAct: sentido del movimiento actual. Se invierte (XOR 1)
;            cuando despAct llega a cero.
; DB rateAct: contador rate que se decrementa en cada refresco.
;             Al llegar a 0, repintamos el enemigo.
; DB numFrame: indice del frame actual dentro de la animacion del enemigo
;           (0..numAnim-1)
; DW frame: puntero al frame actual
; DB X_PREV:   anterior coordenada X
; DB Y_PREV:   anterior coordenada Y

; *************************************************************
; InicializaEnemigos: Copia los valores estaticos de posicion,
; direccion, recorrido, etc. de la definicion de enemigos de
; una pantalla al buffer de enemigos donde se pueden modificar.
; Input: HL puntero a la definicion de enemigos de la pantalla actual
; *************************************************************

InicializaEnemigos:
   ld A, (HL)           ; El primer byte de la definicion de enemigos
                        ; es el numero de enemigos en la pantalla
   ld (PANTALLA_ACTUAL_NUM_ENEMIGOS), A    ; Lo guardamos en PANTALLA_ACTUAL_NUM_ENEMIGOS
   cp 0                 ; Pantalla sin enemigos? Salir.
   ret Z

   ld B, A              ; B es el contador del bucle
   inc HL               ; Apuntamos al siguiente byte (posicion X del primer enemigo)
   ld DE, ENEMIGOS      ; REPETIR X MAX_ENEMIGOS: SUMAR DE + TAM_ENEMIGO * i

InicializaEnemigos_Bucle:

   push BC            
   push HL              ; Puntero a la definicion de enemigos de cada pantalla
   push DE              ; Guardamos el puntero para recorrer todo el buffer

   ld IXL, E            ; IX apunta al enemigo que estamos inicializando en ENEMIGO (=DE)
   ld IXH, D

   ; Copiamos los datos estaticos (X,Y,tipo,desp, dir,sen,vel,rate)

   ldi   ; X
   ldi   ; Y
   ld    A, (HL)  ; Guardamos el tipo para despues
   ldi   ; tipo   
   ldi   ; desp
   ldi   ; dir
   ldi   ; sen
   ldi   ; vel
   ldi   ; rate

   ; anim: buscamos el puntero a la lista de frames de ese enemigo
   ld    HL, ENEMIGOS_ANIM  ; Primer tipo de enemigo
   ld    B, 0
   ld    C, A    ; Indice a la lista de tipos 
   add   HL, BC   ; Avanzamos hasta los frames de este tipo de enemigo
   add   HL, BC   ; Sumamos dos veces porque son words
   ldi   ; anim   ; ldi x 2, es un puntero
   ldi

   ; numAnim: numero de frames de este enemigo
   ld    HL, ENEMIGOS_NUM_ANIM
   ld    B, 0     ; BC ha sido modificado en el anterior ldi
   ld    C, A     ; volvemos a sumar el indice
   add   HL, BC   ; Avanzamos usando tipo como indice
   ldi   ; numAnim

   ; Los atributos dinamicos se inicializan con el mismo

   ; despAct
   ld A, (IX+ENEMIGO_DESP)
   ld (IX+ENEMIGO_DESP_ACT), A
   ; senAct
   ld A, (IX+ENEMIGO_SEN)
   ld (IX+ENEMIGO_SEN_ACT), A
   ; rateAct
   ld A, (IX+ENEMIGO_RATE)
   ld (IX+ENEMIGO_RATE_ACT), A
   ; X prev
   ld A, (IX+ENEMIGO_POSX)
   ld (IX+ENEMIGO_POSX_PREV), A
   ; Y prev
   ld A, (IX+ENEMIGO_POSY)
   ld (IX+ENEMIGO_POSY_PREV), A
   ; numFrame
   ld (IX+ENEMIGO_NUM_FRAME), 0

   ; Para conocer el primer frame hace falta mirar SEN
   ; para ver hacia donde esta mirando

   ld H, (IX+ENEMIGO_ANIM+1)    ; Puntero al primer frame del enemigo
   ld L, (IX+ENEMIGO_ANIM)  ; (mirando a la derecha)

   ld A, (IX+ENEMIGO_SEN)
   cp 0
   jr Z, InicializaEnemigos_MiraDerecha
   ; El sprite empieza moviendose hacia la izquierda
   ; Sacamos el primer frame que mira a la izquierda (ENEMIGO_ANIM+ENEMIGO_NUM_ANIM*TAM_SPRITE_ENEMIGO)
   ; Sumamos ENEMIGO_NUM_ANIM*TAM_SPRITE_ENEMIGO al puntero al primer frame
   ld D, 0
   ld E, TAM_SPRITE_ENEMIGO   ; 64 bytes (4x16bytes)
   ld B, (IX+ENEMIGO_NUM_ANIM)
InicializaEnemigos_Suma:
   add HL, DE
   djnz InicializaEnemigos_Suma

InicializaEnemigos_MiraDerecha:
   ld (IX+ENEMIGO_FRAME+1), H      ; Guardamos el puntero al frame
   ld (IX+ENEMIGO_FRAME), L

   ; Recuperamos HL, DE para preparar la siguiente iteracion
   pop HL
   pop DE   ; OJO: sacamos DE en HL y HL en DE para intercambiarlos luego

   ld B, 0
   ld C, TAM_ENEMIGO
   add HL, BC     ; Avanzamos el puntero al buffer (HL ahora) en TAM_ENEMIGO bytes 

   ex DE, HL      ; Restauramos HL y calculamos ahora el puntero al siguiente enemigo en la definicion

   ld C, TAM_ENEMIGO_DEF
   add HL, BC

   pop BC         ; Sacamos B de la pila y volvemos al bucle
   djnz InicializaEnemigos_Bucle

   ret

; *************************************************************
; ActualizaEnemigos: mueve uno por uno, actualiza sus frames
; y cambian el sentido si llegan al final del recorrido.
; Input: B = numero de enemigos a actualizar
;        IX = puntero al buffer de enemigos.
; Asi podemos actualizar 2 en el refresco de los jugadores
; y otros 4 en el refresco de enemigos
; *************************************************************

ActualizaEnemigos:
   ;ld IX, ENEMIGOS
   ;ld  B, MAX_ENEMIGOS     ; Contador del bucle 

ActualizaEnemigos_BuclePpal:

   ld A, (IX+ENEMIGO_POSX)   ; Guardamos siempre la posicion actual para borrar el sprite
   ld (IX+ENEMIGO_POSX_PREV), A
   ld A, (IX+ENEMIGO_POSY)
   ld (IX+ENEMIGO_POSY_PREV), A

   ; Solo actualizamos una vez cada ENEMIGO_RATE refrescos de pantalla
   ld A, (IX+ENEMIGO_RATE_ACT)
   dec A
   jr Z, ActualizaEnemigos_Sigue   ; Llegamos a cero, pintamos
   ld (IX+ENEMIGO_RATE_ACT), A      ; Si no, guardamos y pasamos al siguiente enemigo
   jp ActualizaEnemigos_SigueBucle

ActualizaEnemigos_Sigue:

   push BC     ; Guardamos el contador de enemigos

   ; Restauramos ENEMIGO_RATE_ACT y lo guardamos
   ld A, (IX+ENEMIGO_RATE)
   ld (IX+ENEMIGO_RATE_ACT), A

  
   ld A, (IX+ENEMIGO_SEN_ACT)     ; Dependiendo de ENEMIGO_SEN, incrementamos o decrementamos 
   cp 0
   jr Z, ActualizaEnemigos_Incrementa
   bit 0, (IX+ENEMIGO_DIR)    ;  0 = horizontal, 1 = vertical
   jr Z, ActualizaEnemigos_Decrementa_X

   ld A, (IX+ENEMIGO_POSY)     ; Restamos ENEMIGO_VEL a la coordenada Y
   ld B, (IX+ENEMIGO_VEL)
   sub B
   ld (IX+ENEMIGO_POSY), A
   jr ActualizaEnemigos_Desp

ActualizaEnemigos_Decrementa_X:
   ld A, (IX+ENEMIGO_POSX)     ; Restamos ENEMIGO_VEL a la coordenada X
   ld B, (IX+ENEMIGO_VEL)
   sub B
   ld (IX+ENEMIGO_POSX), A
   jr ActualizaEnemigos_Desp

ActualizaEnemigos_Decrementa:
   ld B, (IX+ENEMIGO_VEL)
   sub B
   ld (IX+ENEMIGO_POSX), A
   jr ActualizaEnemigos_Desp

ActualizaEnemigos_Incrementa:
   bit 0, (IX+ENEMIGO_DIR)    ;  0 = horizontal, 1 = vertical
   jr Z, ActualizaEnemigos_Incrementa_X

   ld B, (IX+ENEMIGO_VEL)     ; Sumamos ENEMIGO_VEL a la coordenada Y
   ld A, (IX+ENEMIGO_POSY)
   add A, B
   ld (IX+ENEMIGO_POSY), A
   jr ActualizaEnemigos_Desp

ActualizaEnemigos_Incrementa_X:
   ld B, (IX+ENEMIGO_VEL)     ; Sumamos ENEMIGO_VEL a la coordenada X
   ld A, (IX+ENEMIGO_POSX)
   add A, B
   ld (IX+ENEMIGO_POSX), A
   jr ActualizaEnemigos_Desp

ActualizaEnemigos_Desp:       ; Decrementamos ENEMIGO_DESP_ACT para ver si
                              ; tenemos que dar la vuelta ya
   ld A, (IX+ENEMIGO_DESP_ACT)
   dec A
   jr NZ, ActualizaEnemigos_GuardaDesp   ; No hay vuelta, seguimos actualizando el frame
   ld A, (IX+ENEMIGO_DESP)    ; Restauramos DESP_ACT con DESP
   ld (IX+ENEMIGO_DESP_ACT), A   ; Guardamos el desplazamiento (DESP)
   ld A, (IX+ENEMIGO_SEN_ACT)    ; Invertimos SEN_ACT 
   xor 1
   ld (IX+ENEMIGO_SEN_ACT), A    ; y lo guardamos otra vez.
   jr ActualizaEnemigos_Frame    ; 

ActualizaEnemigos_GuardaDesp:
   ld (IX+ENEMIGO_DESP_ACT), A   ; Guardamos el desplazamiento (DESP_ACT-1)

ActualizaEnemigos_Frame:         ; Incrementamos el numero de frame. Si llegamos a ENEMIGO_NUM_FRAME-1
                                 ; volvemos a 0
   ld A, (IX+ENEMIGO_NUM_FRAME)  ; Frame actual
   ld B, (IX+ENEMIGO_NUM_ANIM)   ; Numero total de frames
   inc A
   cp B
   jp C, ActualizaEnemigos_FrameGuarda ; Salta si A < B, no reseteamos el contador
   ld A, 0                       ; En caso contrario, NUM_FRAME = 0
ActualizaEnemigos_FrameGuarda   
   ld (IX+ENEMIGO_NUM_FRAME), A  ; A = NUM_FRAME, nos sirve para lo que viene

   ; Dependiendo de SEN_ACT elegimos el frame mirando a izq o dcha
   ld H, (IX+ENEMIGO_ANIM+1)    ; Puntero al primer frame del enemigo
   ld L, (IX+ENEMIGO_ANIM)      ; (mirando a la derecha)                           

   ld B, (IX+ENEMIGO_NUM_FRAME)  ; Base para el contador del DJNZ

   ; En el bucle sumamos B veces TAM_SPRITE_ENEMIGO para
   ; que HL acabe apuntando al frame correcto
   ld D, 0
   ld E, TAM_SPRITE_ENEMIGO   ; 4*16 bytes   

   bit 0, (IX+ENEMIGO_SEN_ACT)   ; SEN es 0 o 1?
   jr Z, ActualizaEnemigos_FrameDerecha   ; Si 0 nos saltamos esto

   ; Necesitamos mover HL hasta el frame NUM_FRAME del SEGUNDO set
   ; de fotogramas (los que miran a la izquierda). Para ello sumamos
   ; NUM_ANIM*TAM_SPRITE_ENEMIGO + NUM_FRAME*TAM_SPRITE_ENEMIGO
   ; => TAM_SPRITE_ENEMIGO * (NUM_ANIM + NUM_FRAME)
   ; Usamos B = NUM_ANIM + NUM_FRAME como contador del DJNZ 
   ; donde sumamos TAM_SPRITE_ENEMIGO en cada vuelta 
   ld A, (IX+ENEMIGO_NUM_ANIM)
   add A, B
   ld B, A     ; Contador listo: B = NUM_ANIM + NUM_FRAME
   jr ActualizaEnemigos_Bucle

ActualizaEnemigos_FrameDerecha: ; SEN = 0
   ; Necesitamos mover HL hasta el frame NUM_FRAME del PRIMER set
   ; de fotogramas (los que miran a la derecha). Para ello sumamos
   ; NUM_ANIM*TAM_SPRITE_ENEMIGO 
   ; Usamos B = NUM_ANIM como contador del DJNZ 
   ; donde sumamos TAM_SPRITE_ENEMIGO en cada vuelta.
   ; Esto ya lo hemos hecho justo antes del ultimo salto

   ; OJO: si NUM_FRAME = 0 NO SUMAMOS NADA
   cp 0     ; A = NUM_FRAME todavia
   jr Z, ActualizaEnemigos_Fin

ActualizaEnemigos_Bucle:
   add HL, DE
   djnz ActualizaEnemigos_Bucle

ActualizaEnemigos_Fin:
   ; Guardamos el puntero al frame en ENEMIGO_FRAME y listos
   ld (IX+ENEMIGO_FRAME), L
   ld (IX+ENEMIGO_FRAME+1), H

   ; Recuperamos BC y preparamos la siguiente iteracion
   pop BC

ActualizaEnemigos_SigueBucle:
   ; Apuntamos al siguiente enemigo del buffer
   ld D, 0
   ld E, TAM_ENEMIGO
   add IX, DE 
   dec B
   jp NZ, ActualizaEnemigos_BuclePpal

   ret

; ***********************************************************
; ChoqueEnemigos: comprueba si el jugador ha esta
; tocando a algun enemigo
; IX: puntero a los datos del jugador
; Output: 
; A: enemigo con el que ha colisionado o &FF si ninguno
; ***********************************************************

ChoqueEnemigos:
      ld IY, ENEMIGOS
      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)   ; Numero de enemigos en la pantalla actual
      cp 0
      jp Z, ChoqueEnemigos_Fin         ; Pantalla sin enemigos
      ld B, A
ChoqueEnemigos_Bucle:
      push BC
      call ColisionEnemigo
      ; Si Carry, no colision y pasamos al siguiente
      jr C, ChoqueEnemigos_Siguiente
      pop BC   ; Para restaurar la pila
      ret
ChoqueEnemigos_Siguiente:
      ; Pasamos al siguiente objeto
      ld B, 0
      ld C, TAM_ENEMIGO
      add IY, BC
      pop BC
      djnz ChoqueEnemigos_Bucle
ChoqueEnemigos_Fin:
      ld A, &FF
      ret