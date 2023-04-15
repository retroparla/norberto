; Muestra la pantalla principal del juego
PantallaInicio:
   ; Borra todo
   ld A, &FF   ; Negro, pen 15
   call LimpiaPantalla

   ; Mensaje de inicio
   ld D, 15
   ld E, 90
   call CoordenadasVideo
   ld BC, TEXTO_INICIO
   call PintaTexto

   ; Salimos cuando se pulse una tecla
   call EsperaTecla
   ret