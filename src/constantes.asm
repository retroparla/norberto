MEM_VIDEO            EQU &C000
MEM_VIDEO_TAM        EQU &4000
MEM_ESCENARIO        EQU &C140

BYTES_POR_PANTALLA   EQU &3FFF   ; Igual que la memoria de video => 81 bytes por 200 lineas
BYTES_POR_LINEA      EQU 80
LINEAS_POR_PANTALLA  EQU 200
BUFFER_PANTALLA      EQU &8000

TILES_FONDO         EQU 32       ; Primer tile opaco
MAX_OBJETOS         EQU 16       ; Maximo de objetos por pantalla
MAX_ENEMIGOS        EQU 6

; Colores de la paleta
COLOR_BLACK          EQU &54
COLOR_BLUE           EQU &44
COLOR_BRIGHT_BLUE    EQU &55
COLOR_RED            EQU &5C 	
COLOR_MAGENTA        EQU &58
COLOR_MAUVE          EQU &5D
COLOR_BRIGHT_RED     EQU &4C 	
COLOR_PURPLE         EQU &45 
COLOR_BRIGHT_MAGENTA EQU &4D 
COLOR_GREEN          EQU &56 
COLOR_CYAN           EQU &46 	
COLOR_SKY_BLUE       EQU &57 
COLOR_YELLOW         EQU &5E 
COLOR_WHITE          EQU &40 
COLOR_PASTEL_BLUE    EQU &5F 
COLOR_ORANGE         EQU &4E 
COLOR_PINK           EQU &47 
COLOR_PASTEL_MAGENTA EQU &4F 
COLOR_BRIGHT_GREEN   EQU &52 
COLOR_SEA_GREEN      EQU &42
COLOR_BRIGHT_CYAN    EQU &53 
COLOR_LIME           EQU &5A 
COLOR_PASTEL_GREEN   EQU &59 
COLOR_PASTEL_CYAN    EQU &5B 
COLOR_BRIGHT_YELLOW  EQU &4A
COLOR_PASTEL_YELLOW  EQU &43
COLOR_BRIGHT_WHITE   EQU &4B

; Bits para comprobar teclas pulsadas
; sobre MAPA_TECLADO
; Fila 0
KEY_INTRO_MASK       EQU 6
KEY_DOWN_MASK        EQU 2
KEY_RIGHT_MASK       EQU 1
KEY_UP_MASK          EQU 0
; Fila 1
KEY_LEFT_MASK        EQU 0
; Fila 2
KEY_RETURN_MASK      EQU 2
; Fila 3
KEY_P_MASK           EQU 3
; Fila 4
KEY_O_MASK           EQU 2
; Fila 5
KEY_SPACE_MASK       EQU 7
; Fila 8
KEY_A_MASK           EQU 5
KEY_Q_MASK           EQU 3
KEY_ESC_MASK         EQU 2
; Fila 9
KEY_JOY_FIRE_MASK    EQU 5
KEY_JOY_FIRE2_MASK   EQU 4
KEY_JOY_RIGHT_MASK   EQU 3
KEY_JOY_LEFT_MASK    EQU 2
KEY_JOY_DOWN_MASK    EQU 1
KEY_JOY_UP_MASK      EQU 0

; Bits para comprobar teclas pulsadas
; sobre TECLAS_PULSADAS
KEY_RETURN     EQU 6
KEY_ESCAPE     EQU 5
KEY_FIRE       EQU 4
KEY_RIGHT      EQU 3
KEY_LEFT       EQU 2
KEY_DOWN       EQU 1
KEY_UP         EQU 0

; Movimiento de los jugadores
MOV_PARADO           EQU 0
MOV_DERECHA          EQU 1
MOV_IZQUIERDA        EQU 2
MOV_SALTO            EQU 4
MOV_SALTO_DERECHA    EQU 5 ; Salto + derecha
MOV_SALTO_IZQUIERDA  EQU 6 ; Salto + izquierda
MOV_CONGELADO        EQU 7

; Indices sobre el array de animaciones
FRAME_PARADO            EQU 0
FRAME_DERECHA1          EQU 2
FRAME_DERECHA2          EQU 4
FRAME_IZQUIERDA1        EQU 6
FRAME_IZQUIERDA2        EQU 8
FRAME_SALTO             EQU 10
FRAME_SALTO_DERECHA     EQU 12
FRAME_SALTO_IZQUIERDA   EQU 14
FRAME_CONGELADO         EQU 16

; Atributos de los personajes,
; para ser usados con IX, IY
SPRITE_POSX                 EQU 0
SPRITE_POSY                 EQU 1
SPRITE_POSX_PREV            EQU 2
SPRITE_POSY_PREV            EQU 3
SPRITE_ESTADO               EQU 4
SPRITE_ESTADO_PREV          EQU 5
SPRITE_SALTO                EQU 6
SPRITE_CAIDA                EQU 7
SPRITE_CONGELADO            EQU 8
SPRITE_PUNTOS               EQU 9
SPRITE_ACTUALIZA_MARCADOR   EQU 10
SPRITE_FRAME                EQU 11
SPRITE_FRAMES               EQU 13


; Atributos de los enemigos
ENEMIGO_POSX               EQU   0
ENEMIGO_POSY               EQU   1
ENEMIGO_TIPO               EQU   2
ENEMIGO_DESP               EQU   3
ENEMIGO_DIR                EQU   4
ENEMIGO_SEN                EQU   5
ENEMIGO_VEL                EQU   6
ENEMIGO_RATE               EQU   7
ENEMIGO_ANIM               EQU   8
ENEMIGO_NUM_ANIM           EQU   10
ENEMIGO_DESP_ACT           EQU   11
ENEMIGO_SEN_ACT            EQU   12
ENEMIGO_RATE_ACT           EQU   13
ENEMIGO_NUM_FRAME          EQU   14
ENEMIGO_FRAME              EQU   15
ENEMIGO_POSX_PREV          EQU   17
ENEMIGO_POSY_PREV          EQU   18

TAM_ENEMIGO         EQU 19       ; Ver enemigos.asm para estructura de enemigos en el buffer
TAM_ENEMIGO_DEF     EQU 8        ; Tam de la definicion de enemigos

; Tamano de los sprites de los enemigos
TAM_SPRITE_ENEMIGO         EQU 4*16

; En la rutina de colision con enemigos podemos ignorar las
; primeras CHEAT_SALTO lineas superiores del sprite del enemigo
; para que podamos saltarlos aunque los rocemos ligeramente.
CHEAT_SALTO                EQU 8

; Flags de cambio de pantalla
CAMBIO_PANTALLA_NO         EQU   0
CAMBIO_PANTALLA_DERECHA    EQU   1
CAMBIO_PANTALLA_IZQUIERDA  EQU   2
CAMBIO_PANTALLA_ARRIBA     EQU   3
CAMBIO_PANTALLA_ABAJO      EQU   4

; Posicion de los textos y digitos de la zona de marcadores
POSX_CORAZON               EQU 1
POSY_CORAZON               EQU 181
POSX_VIDAS                 EQU 8
POSY_PUNTUACIONES          EQU 183
POSY_TEXTOS_ESTATICOS      EQU 192
POSX_TEXTO_HARD            EQU 14
POSX_TEXTO_SOFT            EQU 48
POSX_MARCADOR_HARD         EQU 26
POSX_MARCADOR_HARD_TOTAL   EQU 37
POSX_MARCADOR_SOFT         EQU 60
POSX_MARCADOR_SOFT_TOTAL   EQU 71

; Maximo numero de objetos software y hardware
; para pintar en el marcador (en BCD)
MAX_HARD_ITEMS             EQU &10
MAX_SOFT_ITEMS             EQU &50