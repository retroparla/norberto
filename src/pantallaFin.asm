; Muestra la pantalla al finalizar el juego
PantallaFin:
   ; Borra todo
   ld A, #FF   ; Negro, pen 15
   call LimpiaPantalla

   ; Mensaje de fin
   ld D, 15
   ld E, 90
   call CoordenadasVideo
   ld BC, TEXTO_FIN
   call PintaTexto

   ; Salimos cuando se pulse una tecla
   call EsperaTecla
   ret