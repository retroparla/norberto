; ***********************************************************
; Interrupcion 0: pintamos sprites tras VSync.
; ***********************************************************

Interrupcion0:
      push HL
      push DE
      push BC
      push AF

      ; Prepara la siguiente interrupcion
      ld BC, Interrupcion1
      ld (&39), BC

      ;ld A, COLOR_BRIGHT_YELLOW
      ;call ColorBorde
      
                
            
      ; Actualizamos jugadores en frames impares
      ; y enemigos en frames pares
      ld A, (CONTADOR_FRAMES)
      bit 0, A
      jp Z, Interrupcion0_Enemigos

      ; Pintamos JUGADOR 1

      ; Pinta el personaje en su nueva posicion
      ; Calcula la posicion de memoria de video
      ld IX, PLAYER1
      ld D, (IX+SPRITE_POSX)        ; Coordenada X en D
      ld E, (IX+SPRITE_POSY)        ; Coordenada Y en E

      ; Devuelve en HL la posicion en la memoria de video
      call CoordenadasVideo
      
      ; Pinta el sprite DE en la posicion HL
      ld E, (IX+SPRITE_FRAME)
      ld D, (IX+SPRITE_FRAME+1)
      ld A, 16    ; Altura del sprite
      call PintaBloque8Mask

      ; Pintamos enemigos 5 y 6 (si existen)
      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)
      cp 5
      jp C, Interrupcion0_Fin       ; Hay menos de 5 enemigos, fin.

      ld IX, ENEMIGOS+4*TAM_ENEMIGO ; Pintamos enemigo 5

      ld D, (IX+ENEMIGO_POSX)
      ld E, (IX+ENEMIGO_POSY)
      call CoordenadasVideo

      ld E, (IX+ENEMIGO_FRAME)
      ld D, (IX+ENEMIGO_FRAME+1)
      ld A, 16
      call PintaBloque8Mask      

      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)      ; Hay un sexto enemigo?
      cp 6  
      jp NZ, Interrupcion0_Fin

      ld IX, ENEMIGOS+5*TAM_ENEMIGO
      
      ld D, (IX+ENEMIGO_POSX)
      ld E, (IX+ENEMIGO_POSY)
      call CoordenadasVideo

      ld E, (IX+ENEMIGO_FRAME)
      ld D, (IX+ENEMIGO_FRAME+1)
      ld A, 16
      call PintaBloque8Mask           

      jr Interrupcion0_Fin

Interrupcion0_Enemigos:

      ; Pinta enemigos 1 a 4 (si existen)
      ld IX, ENEMIGOS         ; Puntero al buffer de enemigos
      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)
      cp 0                    ; No hay enemigos, saltamos
      jp Z, Interrupcion0_Fin
      cp 5        ; A < 5?
      jp C, Interrupcion0_Enemigos_1_4    ; Menos de 5 enemigos, saltamos a actualizacion directamente
      ld A, 4     ; A >= 5, solo actualizamos los cuatro primeros
Interrupcion0_Enemigos_1_4:
      ld B, A     ; Contador del bucle

Interrupcion0_EnemigosBucle:

      push BC                       ; Guardamos contador

      ld D, (IX+ENEMIGO_POSX)
      ld E, (IX+ENEMIGO_POSY)
      call CoordenadasVideo

      ld E, (IX+ENEMIGO_FRAME)
      ld D, (IX+ENEMIGO_FRAME+1)
      ld A, 16
      call PintaBloque8Mask

      ld D, 0
      ld E, TAM_ENEMIGO
      add IX, DE                    ; Siguiente enemigo

      pop   BC                      ; Recuperamos y decrementamos contador
      djnz Interrupcion0_EnemigosBucle     


Interrupcion0_Fin:

      pop AF
      pop BC
      pop DE
      pop HL
      ei
      reti

; ***********************************************************
; Interrupcion 1: lectura de teclado
; ***********************************************************

Interrupcion1: 
      push HL
      push DE
      push BC
      push AF

      ; Prepara la siguiente interrupcion
      ld BC, Interrupcion2
      ld (&39), BC

      ;ld A, COLOR_BRIGHT_WHITE
      ;call ColorBorde


      ; Incrementamos el contador de frames
      ld HL, CONTADOR_FRAMES       
      inc (HL)      

      ; Leemos teclado
      call LeerTeclado

      ; Calculamos estado de los personajes 
      ; segun las teclas pulsadas

      ; Jugador 1
      ld A, (TECLAS_PULSADAS)
      ld D, A                       ; Teclas pulsadas en este momento
      ld IX, PLAYER1                ; Datos del JUGADOR 1
      ld A, (IX+SPRITE_ESTADO)      
      ld (IX+SPRITE_ESTADO_PREV), A ; Guardamos el estado antes de actualizarlo
      call CalculaEstado

      pop AF
      pop BC
      pop DE
      pop HL
      ei
      reti
      
; ***********************************************************
; Interrupcion 2: colisiones con escenario y calculo de posiciones
; ***********************************************************

Interrupcion2:
      push HL
      push DE
      push BC
      push AF

      ; Prepara la siguiente interrupcion
      ld BC, Interrupcion3
      ld (&39), BC

      ;ld A, COLOR_BRIGHT_RED
      ;call ColorBorde

      ; Solo actualizamos cada dos frames (25Hz)
      ld A, (CONTADOR_FRAMES)
      bit 0, A
      jr Z, Interrupcion2_Fin

      ; Rotamos el ciclo de animacion
      ld A, (CICLO_ANIMACION)       ; Alternamos entre IZQUIERDA1 y IZQUIERDA2
      rrca
      ld (CICLO_ANIMACION), A
      
      ; PLAYER 1

      ; La posicion actual pasa a ser la posicion anterior
      ld IX, PLAYER1
      ld A, (IX+SPRITE_POSX)
      ld (IX+SPRITE_POSX_PREV), A
      ld A, (IX+SPRITE_POSY)
      ld (IX+SPRITE_POSY_PREV), A

      ; Calculamos la siguiente posicion del personaje
      ; dependiendo de su estado actual y las 
      ; posibles colisiones
      call CalculaPosicion

      ; Calculamos el siguiente sprite
      ; de la animacion dependiendo del estado actual y anterior
      call SiguienteAnimacion


Interrupcion2_Fin:
      pop AF
      pop BC
      pop DE
      pop HL

      ei
      reti

; ***********************************************************
; Interrupcion 3: captura de objetos y choques con enemigos
; ***********************************************************

Interrupcion3: 
      push HL
      push DE
      push BC
      push AF

      ; Prepara la siguiente interrupcion
      ld BC, Interrupcion4
      ld (&39), BC

      ;ld A, COLOR_GREEN
      ;call ColorBorde

      ; Borde negro otra vez (para el efecto de perder una vida)
      ld A, &54
      call ColorBorde   

      ; Comprobamos si el jugador 1 ha cogido
      ; algun objeto del escenario
      ld IX, PLAYER1
      call CapturaObjetos
      cp &FF      ; Nada?
      jr Z, Interrupcion3_ChoqueEnemigosP1
      ; Objeto hardware o software?
      ; En A se devuelve el tipo del objeto.
      cp PRIMER_OBJETO_SOFT
      jp C, Interrupcion3_CogeHardware    ; A < PRIMER_OBJETO_SOFT
      ; Incrementa contador software
      ld A, (IX+SPRITE_PUNTOS_SOFT)
      add A, 1    ; Incrementamos la puntuacion
      daa         ; Ojo, la puntuacion esta en BCD (no vale inc)
      ld (IX+SPRITE_PUNTOS_SOFT), A
      jp Interrupcion3_ActualizaMarcadorObjetos
Interrupcion3_CogeHardware:
      ; Incrementa contador hardware
      ld A, (IX+SPRITE_PUNTOS_HARD)
      add A, 1    ; Incrementamos la puntuacion
      daa         ; Ojo, la puntuacion esta en BCD (no vale inc)
      ld (IX+SPRITE_PUNTOS_HARD), A
Interrupcion3_ActualizaMarcadorObjetos:
      ld (IX+SPRITE_ACTUALIZA_MARCADOR), 1  ; Hay que repintar el marcador

Interrupcion3_ChoqueEnemigosP1:
      ; Si el jugador no esta congelado, comprobamos si ha chocado con algun enemigo.
      ; Si el jugador esta congelado, comprobamos si el otro jugador le descongela.
      ld IX, PLAYER1
      ld A, (IX+SPRITE_CONGELADO)
      cp 1
      jr Z, Interrupcion3_Fin    ; Esta congelado, comprobamos si lo descongelan
      call ChoqueEnemigos                 ; No esta congelado, comprobamos choques con enemigos
      cp &FF      ; Nada
      jr Z, Interrupcion3_Fin
      ; WASTED!!
      ld A, 1
      ld (IX+SPRITE_CONGELADO), A          ; CONGELADO = 1

      ; Cambio momentaneo del color del borde para indicar
      ; la perdida de una vida. Se vuelve a poner negro en la
      ; interrupcion anterior.
      ld A, COLOR_BRIGHT_YELLOW
      call ColorBorde

      jr Interrupcion3_Fin

Interrupcion3_Fin:

      pop AF
      pop BC
      pop DE
      pop HL

      ei
      reti

; ***********************************************************
; Interrupcion 4: enemigos y marcadores
; ***********************************************************

Interrupcion4: 
      push HL
      push DE
      push BC
      push AF

      ; Prepara la siguiente interrupcion
      ld BC, Interrupcion5
      ld (&39), BC

      ;ld A, COLOR_BLACK
      ;call ColorBorde

      ; Solo actualizamos enemigos en frames pares
      ld A, (CONTADOR_FRAMES)
      bit 0, A
      jr NZ, Interrupcion4_RefrescoEnemigos_5_6
      ; Actualizamos solo los 4 primeros enemigos (si existen)
      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)    ; Numero de enemigos en pantalla
      cp 0
      jp Z, Interrupcion4_MarcadorPlayer1 ; No hay enemigos, nos saltamos la actualizacion
      cp 5        ; A < 5?
      jp C, Interrupcion4_Enemigos_1_4    ; Menos de 5 enemigos, saltamos a actualizacion directamente
      ld A, 4     ; A >= 5, solo actualizamos los cuatro primeros
Interrupcion4_Enemigos_1_4:
      ld B, A
      ld IX, ENEMIGOS
      call ActualizaEnemigos
      jr Interrupcion4_MarcadorPlayer1
Interrupcion4_RefrescoEnemigos_5_6: 
      ; Comprobar que hay al menos 5 enemigos en esta pantalla
      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)    ; Numero de enemigos en pantalla
      cp 5        ; A < 5?
      jp C, Interrupcion4_MarcadorPlayer1 ; Menos de 5 enemigos, no actualizamos nada aqui
      sub 4
      ld B, A     ; A-4 enemigos a actualizar
      ld IX, ENEMIGOS+TAM_ENEMIGO*4
      call ActualizaEnemigos


Interrupcion4_MarcadorPlayer1:
      ; Actualizamos marcadores
      ld IX, PLAYER1
      ld A, (IX+SPRITE_ACTUALIZA_MARCADOR)      ; Hace falta actualizar?
      cp 0
      jr Z, Interrupcion4_Fin
      call ActualizaMarcadorSoft
      call ActualizaMarcadorHard
      ld (IX+SPRITE_ACTUALIZA_MARCADOR), 0      ; Reset flag

Interrupcion4_Fin:
      pop AF
      pop BC
      pop DE
      pop HL

      ei
      reti

; ***********************************************************
; Interrupcion 5: borrado de sprites
; ***********************************************************

Interrupcion5: 

      push HL
      push DE
      push BC
      push AF

      ; Prepara la siguiente interrupcion
      ld BC, Interrupcion0
      ld (&39), BC

      ;ld A, COLOR_BRIGHT_BLUE
      ;call ColorBorde
     

      ; Actualizamos jugadores en frames impares
      ; y enemigos en frames pares
      ld A, (CONTADOR_FRAMES)
      bit 0, A
      jr Z, Interrupcion5_Enemigos    

      ; Borra el sprite del primer personaje en su posicion anterior
      ; Calcula la posicion de memoria de video
      ld IX, PLAYER1
      ld D, (IX+SPRITE_POSX_PREV)        ; Coordenada X en D
      ld E, (IX+SPRITE_POSY_PREV)        ; Coordenada Y en E
      call CoordenadasVideo
      ; Pinta el fondo sobre el sprite
      ld A, 16
      call PintaFondo8

      ; Borramos enemigos 5 y 6 (si existen)

      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)
      cp 5
      jp C, Interrupcion5_Fin       ; Hay menos de 5 enemigos, fin.
      
      ld IX, ENEMIGOS+4*TAM_ENEMIGO ; Borramos quinto enemigo

      ld D, (IX+ENEMIGO_POSX_PREV)
      ld E, (IX+ENEMIGO_POSY_PREV)
      call CoordenadasVideo
      ld A, 16
      call PintaFondo8      

      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)      ; Hay un sexto enemigo?
      cp 6  
      jp NZ, Interrupcion5_Fin
      ld IX, ENEMIGOS+5*TAM_ENEMIGO
      
      ld D, (IX+ENEMIGO_POSX_PREV)
      ld E, (IX+ENEMIGO_POSY_PREV)
      call CoordenadasVideo
      ld A, 16
      call PintaFondo8      



      jr Interrupcion5_Fin

Interrupcion5_Enemigos:

      ; Borra enemigos 1 a 4 (si existen)
      ld IX, ENEMIGOS         ; Puntero al buffer de enemigos
      ld A, (PANTALLA_ACTUAL_NUM_ENEMIGOS)
      cp 0                    ; No hay enemigos, saltamos
      jp Z, Interrupcion5_Fin
      cp 5        ; A < 5?
      jp C, Interrupcion5_Enemigos_1_4    ; Menos de 5 enemigos, saltamos a actualizacion directamente
      ld A, 4     ; A >= 5, solo actualizamos los cuatro primeros
Interrupcion5_Enemigos_1_4:
      ld B, MAX_ENEMIGOS-2     ; Contador del bucle

Interrupcion5_EnemigosBucle:

      push BC     ; Guardamos contador

      ld D, (IX+ENEMIGO_POSX_PREV)
      ld E, (IX+ENEMIGO_POSY_PREV)
      call CoordenadasVideo
      ld A, 16
      call PintaFondo8

      ld D, 0
      ld E, TAM_ENEMIGO
      add IX, DE        ; Siguiente enemigo

      pop BC
      djnz Interrupcion5_EnemigosBucle

Interrupcion5_Fin:

      pop AF
      pop BC
      pop DE
      pop HL

      ei
      reti