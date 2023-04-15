; Colores de la paleta (hardware number+40)

;defb 0, 0x1A, 0x10, 0xB, 0x06, 0x18, 0x12, 0x19, 0x17, 0x03, 0x0F, 0x013, 0x02, 0x014, 0x0D, 0x01 ; Firmware numbers
; defb &54, &4B, &47, &57, &4C, &4A, &52, &43, &5B, &5C, &4E, &42, &55, &53, &40, &44 ; Hardware numbers

PALETA:

   DB  COLOR_PASTEL_MAGENTA, COLOR_BRIGHT_WHITE, COLOR_PINK, COLOR_SKY_BLUE, COLOR_BRIGHT_RED, COLOR_BRIGHT_YELLOW
   DB  COLOR_GREEN, COLOR_PASTEL_YELLOW, COLOR_MAGENTA, COLOR_RED, COLOR_ORANGE, COLOR_BRIGHT_GREEN
   DB  COLOR_BLUE, COLOR_BRIGHT_CYAN, COLOR_WHITE, COLOR_BLACK

MAPA_TECLADO DS 10   ; Estado de todas las teclas del teclado

; Estado actual de las teclas pulsadas
; Bits: (MSB) N/A, ENTER, ESC, FIRE, RIGHT, LEFT, DOWN, UP (LSB)
TECLAS_PULSADAS DB 0

; Puntero a la pantalla actual (comprimida)
PANTALLA_ACTUAL_COMPRIMIDA DW P051     ; Puntero a pantalla inicial (51)
PANTALLA_ACTUAL_OBJETOS DW 0           ; Puntero a la lista de objetos de la pantalla
PANTALLA_ACTUAL_ENEMIGOS DW 0          ; Puntero a la lista de enemigos de la pantalla
PANTALLA_ACTUAL_INDICE DB 51           ; Numero de pantalla inicial
PANTALLA_ACTUAL_NUM_ENEMIGOS DB 0      ; Numero de enemigos en pantalla

TEXTO_HARD DB "HARD", 101, 101, 101, 102, 92, 91, &FF
TEXTO_SOFT DB "SOFT", 101, 101, 101, 102, 94, 91, &FF
TEXTO_X  DB "X", &FF

TEXTO_INICIO DB "PULSA", 101, "UNA", 101, "TECLA", &FF
TEXTO_FIN DB "FINAL", 101, "DEL", 101, "JUEGO", &FF

; Estado de los personajes

; Jugador 1
PLAYER1:
P1X DB 4       ; Posicion actual X
P1Y DB 148       ; Posicion actual Y
P1X_PREV DB 0  ; Posicion anterior, para borrar con fondo
P1Y_PREV DB 0  ; Posicion anterior, para borrar con fondo
P1_ESTADO DB 0 ; Parado, izq, dcha, salto, salto dcha, salto izq
P1_ESTADO_PREV DB 0  ; Estado anterior
P1_SALTO DB 0
P1_CAIDA DB 0
P1_CONGELADO DB 0
P1_PUNTOS_HARD DB 0  ; Puntuacion hardware en BCD
P1_PUNTOS_SOFT DB 0  ; Puntuacion software en BCD
P1_ACTUALIZA_MARCADOR DB 0 ; Flag para repintado del marcador
P1_FRAME DW Jugador_0  ; Siguiente frame de la animacion
P1_FRAMES   DW Jugador_0, Jugador_2, Jugador_3           
            DW Jugador_4, Jugador_5
            DW Jugador_1, Jugador_2, Jugador_4
            DW Jugador_6
     
NUM_OBJETOS DB 0  ; Numero de objetos presentes en pantalla

; Buffer de enemigos: array de NUM_ENEMIGOS de TAM_ENEMIGO bytes cada uno
ENEMIGOS DS MAX_ENEMIGOS * TAM_ENEMIGO 

; Punteros a los frames de cada tipo de enemigo
ENEMIGOS_ANIM DW Enemigo_00, Enemigo_04, Enemigo_08, Enemigo_12 
              DW Enemigo_16, Enemigo_20, Enemigo_24 ; .... ampliar cada vez que se diseñe un enemigo nuevo

CICLO_SALTO DB 0, 8, 8, 4, 4, 4, 0  ; 

CONTADOR_FRAMES DB 0 ; Se incrementa con cada nuevo fotograma
                     ; Lo usamos para controlar las animaciones
                     ; o eventos que solo sucedan cada X frames

CICLO_ANIMACION DB %11001100  ; Para alternar entre los dos ciclos
                              ; de animacion al andar a derecha
                              ; e izquierda. Vamos rotando esta variable
                              ; y mirando el bit que sale
 
TABLA_SCANLINES DS LINEAS_POR_PANTALLA*2 ; Direcciones de inicio de cada linea de pantalla

; Flag que se activa cuando el personaje pasa de una pantalla a otra:
; 0 = no hay cambio
; 1 = paso a pantalla derecha, 2 = paso a pantalla izquierda
; 3 = paso a pantalla superior, 4 = paso a pantalla inferior
CAMBIO_PANTALLA DB CAMBIO_PANTALLA_NO

; Buffer que contiene la pantalla actual descomprimida
PANTALLA_ACTUAL DS 20*22

; Matriz de 17x22 pantallas
LISTA_PANTALLAS DW   0000, 0000, 0000, 0000, 0000, 0000, 0000, P007, 0000, 0000, 0000, 0000, P011, P012, P013, 0000, 0000
                DW   0000, 0000, P019, 0000, 0000, 0000, 0000, P024, 0000, 0000, P026, P027, P028, 0000, 0000, 0000, 0000
                DW   0000, 0000, P036, 0000, 0000, P039, P040, P041, 0000, 0000, 0000, P044, 0000, 0000, 0000, 0000, 0000
                DW   P051, P052, P053, 0000, 0000, P056, 0000, P058, P059, P060, P061, P062, 0000, 0000, 0000, 0000, 0000
                DW   0000, 0000, P070, 0000, 0000, P073, 0000, 0000, 0000, 0000, 0000, P079, 0000, P081, 0000, P083, 0000
                DW   0000, 0000, P087, P088, P089, P090, P091, 0000, 0000, P094, P095, P096, P097, P098, P099, P100, P101
                DW   0000, 0000, 0000, 0000, P106, 0000, 0000, 0000, 0000, 0000, 0000, P113, 0000, 0000, 0000, P117, 0000
                DW   0000, 0000, P121, P122, P123, 0000, 0000, P126, P127, P128, 0000, P130, P131, 0000, 0000, 0000, 0000
                DW   P136, P137, P138, 0000, P140, P141, P142, P143, 0000, 0000, 0000, 0000, P148, P149, 0000, 0000, 0000
                DW   0000, 0000, 0000, 0000, 0000, P158, 0000, P160, P161, P162, P163, 0000, 0000, P166, P167, 0000, 0000
                DW   0000, 0000, 0000, 0000, 0000, P175, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
                DW   0000, 0000, 0000, 0000, 0000, P192, P193, P194, P195, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000

; Doble buffer con todos los tiles de la pantalla actual,
; para recuperar el fondo al borrar los sprites

ORG &7F00   ; Alineamos la tabla de mascaras a 256 bytes para acelerar la busqueda

               ;    0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
TABLA_MASCARAS DB &FF, &AA, &55, &00, &AA, &AA, &00, &00, &55, &00, &55, &00, &00, &00, &00, &00   ; 0
               DB &AA, &AA, &00, &00, &AA, &AA, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 1
               DB &55, &00, &55, &00, &00, &00, &00, &00, &55, &00, &55, &00, &00, &00, &00, &00   ; 2
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 3
               DB &AA, &AA, &00, &00, &AA, &AA, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 4
               DB &AA, &AA, &00, &00, &AA, &AA, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 5
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 6
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 7
               DB &55, &00, &55, &00, &00, &00, &00, &00, &55, &00, &55, &00, &00, &00, &00, &00   ; 8
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; 9
               DB &55, &00, &55, &00, &00, &00, &00, &00, &00, &00, &55, &00, &00, &00, &00, &00   ; A
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; B
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; C
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; D
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; E
               DB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00   ; F
