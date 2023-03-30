org   &100 

INCLUDE "constantes.asm"

InicioCodigo:
   di ; Deshabilita interrupciones y el firmware del CPC

   ld SP, TABLA_MASCARAS      ; Pila debajo de la tabla de mascaras
   ld BC, &C9FB      ; 0038 EI + RET
   ld (&38), BC
 
   ; Inicializacion paleta, borde, modo de video
   ld HL, PALETA
   ld B, 16
   call ColoresPaleta

   call TablaScanlines

   ld A, 0  
   call ModoPantalla

   ld A, &FF   ; Negro, pen 15
   call LimpiaPantalla

   ld A, &54
   call ColorBorde

   ; Textos estaticos del marcador
   call PintaMarcadorEstatico

   ; Puntuacion del jugador
   ld IX, PLAYER1
   call ActualizaMarcadorHard
   call ActualizaMarcadorSoft
   call ActualizaMarcadorVidas

ResetJugador:

   ; Posicion inicial del jugador
   ld IX, PLAYER1
   ld (IX+SPRITE_POSX), 4
   ld (IX+SPRITE_POSY), 148
   ld (IX+SPRITE_CONGELADO), 0


IniciaJuego:

   
   di ; Deshabilitamos las interrupciones para poder
      ; cambiar de pantalla sin que se cuele ninguna
      ; entre medias

   ; Guardamos los indices a las pantallas adyacentes a la pantalla actual
   ; Descomprime la pantalla almacenandola en PANTALLA_ACTUAL
   ld HL, (PANTALLA_ACTUAL_COMPRIMIDA)
   call DescomprimePantallaActual

   ; Pinta pantalla actual
   ld IX, PANTALLA_ACTUAL
   ld HL, MEM_VIDEO     ;MEM_ESCENARIO
   call PintaPantalla

   ; Pintamos los objetos antes de pasar la pantalla
   ; al buffer secundario. Asi los enemigos no
   ; los borran al pasar por encima

   ;ld HL, (PANTALLA_ACTUAL_OBJETOS)
   ;call InicializaObjetos
   call PintaObjetos


   call PantallaABuffer

   ld HL, (PANTALLA_ACTUAL_ENEMIGOS)
   call InicializaEnemigos


   ; Instalamos nuestra rutina de servicio de interrupciones
   ; justo después del VSync
   call VSync
   ;di
   ld A, &C3         ; JP
   ld (&38), A       ; 0038 JP
   ld HL, Interrupcion0      
   ld (&39), HL      ; 0038 JP Int0
   ei

Loop: 
   ; Jugador KO?
   di
   ld IX, PLAYER1
   ld A, (IX+SPRITE_CONGELADO)
   cp 0
   jp NZ, ResetJugador   

   ei

   ; El jugador ha salido de la pantalla?
   ld A, (CAMBIO_PANTALLA)
   cp CAMBIO_PANTALLA_NO
   jp Z, Loop  ; No hay cambio de pantalla, continuamos

   di
   call CambioPantalla  ; Ejecuta el cambio de pantalla
   jp IniciaJuego       ; Reinicia en nueva pantalla


INCLUDE "gJugadores.asm"
INCLUDE "gEnemigos.asm"
INCLUDE "gTiles.asm"
INCLUDE "gObjetos.asm"
INCLUDE "gMarcador.asm"
INCLUDE "gFuente.asm"
INCLUDE "pantallas.asm"
INCLUDE "cambioPantallas.asm"
INCLUDE "graficos.asm"
INCLUDE "texto.asm"
INCLUDE "teclado.asm"
INCLUDE "personajes.asm"
INCLUDE "enemigos.asm"
INCLUDE "interrupciones.asm"
INCLUDE "marcador.asm"
INCLUDE "variables.asm"
