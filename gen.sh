#!/usr/bin/bash

if [[ $1 != "asm" ]]
then
   PALETA="17,26,16,11,6,24,9,25,4,3,15,18,1,20,13,0"

   # Genera el asm correspondiente a los sprites del personaje
   img2cpc -fwp $PALETA -of asm -m 0 -o src/gJugadores -abn -bn Jugador -nt -h 16 -w 8 data/jugadores.png

   # Genera el asm correspondiente a los enemigos
   img2cpc -fwp $PALETA -of asm -m 0 -o src/gEnemigos -abn -bn Enemigo -h 16 -w 8 data/enemigos.png

   # Genera el asm correspondiente a los tiles del escenario
   img2cpc -fwp $PALETA -of asm -m 0 -o src/gTiles -abn -bn Tile -h 8 -w 8 data/tiles.png

   # Genera el asm correspondiente a los numeros del marcador
   img2cpc -fwp $PALETA -of asm -m 0 -o src/gMarcador -abn -bn Marcador -h 16 -w 8 data/marcador.png

   # Genera el asm correspondiente al resto de objetos que pueden aparecer
   img2cpc -fwp $PALETA -of asm -m 0 -o src/gObjetos -abn -bn Objeto -h 8 -w 8 data/objetos.png

   # Genera el asm correspondiente a la fuente para letras y numeros
   img2cpc -fwp $PALETA -of asm -m 0 -o src/gFuente -abn -bn Fuente -h 8 -w 8 data/fuente.png

   # Genera las pantallas comprimidas
   echo "Generando pantallas..."
   for f in data/*.tmx
   do
      ./compress.py ${f}
   done
fi

# Ensambla todo
echo "Ensamblando todo..."
cd src
rasm main.asm ../juego -sp
cd ..
iDSK juego.dsk -n
iDSK juego.dsk -i juego.bin -e 100 -c 100 -t 1

echo "¡HECHO!"

