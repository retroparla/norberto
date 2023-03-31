#!/usr/bin/env python3

import xml.etree.ElementTree as xml
import sys

# Only different 128 tiles allowed (0x00..0x7F)
REPETITION_FLAG = 0x80
TERMINATION_FLAG = 0xFF

# First object ID
FIRST_OBJECT_ID = 65
FIRST_ENEMY_ID = 81

# Compress the tile list
# If the tile is not repeated, the tile value is untouched.
# If the tile is repeated, the REPETITION_FLAG is added
# to the tile value and the next byte indicates the
# number of repetitions of the tile.

def Compress( data ):
   c = []
   last = data[0]
   rep = 0

   for i in data :
      if i != last : # New value, store the previous one
         if rep > 1 : # Append the number of repetitions
            c.append(last + REPETITION_FLAG - 1)
            c.append(rep)
         elif rep == 1:
            c.append(last - 1)   # Tiles start at 1
         last = i
         rep = 1
      else :
         rep = rep + 1
         # Cannot repeat more than 254 times!
         # (&FF is used as map termination byte)
         # If a tile is repeated more than 254 times,
         # split into two separated repetitions.
         if rep == 254 : # Close repetition
            c.append(last + REPETITION_FLAG - 1)
            c.append(rep)
            rep = 0  # New repetition count
   else : # Process last element
      if rep > 1 :
         c.append(last + REPETITION_FLAG - 1)
         c.append(rep)
      elif rep == 1:
         c.append(last - 1)

   # Termination flag (&FF)
   c.append(TERMINATION_FLAG)
   return c

def Decompress( data ):
   c = []
   i = 0
   while i < len(data) and data[i] != TERMINATION_FLAG:
      if data[i] < REPETITION_FLAG:
         c.append(data[i] + 1)
      else:
         i = i + 1
         for j in range(data[i]):
            c.append(data[i-1] - REPETITION_FLAG + 1)
      i = i + 1
   return c

def GetObjectsAndEnemies( objectGroup ):
   objects = []
   enemies = []
   numEnemies = 0
   if objectGroup is not None:
      for object in objectgroup:
         if int(object.attrib['gid']) < FIRST_ENEMY_ID:  # Is an object
            # visibility, x, y, type
            objects.append( 1 )
            objects.append( int(float(object.attrib['x'])) // 2 ) # 80 bytes width
            objects.append( ((int(float(object.attrib['y'])) //8)*8 ) - 8) # 200 pixels height, use top left corner, round to *8
            objects.append( int(object.attrib['gid']) - FIRST_OBJECT_ID )
         else: # Is an enemy
            x = int(float(object.attrib['x'])) // 2  # 80 bytes width
            y = int(float(object.attrib['y'])) - 16 # 200 pixels height, use top left corner
            id = (int(object.attrib['gid']) - FIRST_ENEMY_ID ) // 4
            # Reset values
            (desplazamiento, direccion, refresco, sentido, velocidad) = (-1,-1,-1,-1,-1)
            properties = object.find("properties")
            if properties is not None:
               for property in properties.iter("property"):
                  # X, Y, tipo, desplazamiento, direccion, sentido, velocidad, rate
                  if property.attrib['name'] == "desplazamiento":
                     desplazamiento = int(property.attrib['value'])
                  if property.attrib['name'] == "direccion":
                     direccion = int(property.attrib['value'])
                  if property.attrib['name'] == "refresco":
                     refresco = int(property.attrib['value'])
                  if property.attrib['name'] == "sentido":
                     sentido = int(property.attrib['value'])
                  if property.attrib['name'] == "velocidad":
                     velocidad = int(property.attrib['value'])
            # Add enemy if everything is ok
            if (desplazamiento, direccion, refresco, sentido, velocidad) != (-1,-1,-1,-1,-1):
               enemies.extend( (x, y, id, desplazamiento, direccion, sentido, velocidad, refresco) )
               numEnemies = numEnemies + 1

   # Add end of object definition (&FF)
   objects.append(255)
   # Enemy array starts with the enemies number
   enemies.insert( 0, numEnemies )
   return objects, enemies

# Open the map file
fp = open(sys.argv[1], 'r')
if not bool(fp):
    print ("\nUnable to open the file %s.\n" % sys.argv[1])
    sys.exit(-1)

# Parse the TMX file
tree = xml.parse(sys.argv[1])
root = tree.getroot()

# Get the tiles in CSV format
layer = root.find("layer")
data = layer.find("data")
tiles = data.text

# Convert to a list of integers
dataStr = tiles.replace('\n','').split(',')
dataInt = list(map(int,dataStr))

# Apply the compress algorithm
compressed = Compress(dataInt)

# Print the compression ratio
#print( dataInt )
#print( compressed )
print( len(dataInt), "->", len(compressed), "bytes (", int(len(compressed)*100 / len(dataInt)), "% )")

# Parse objects
objectgroup = root.find("objectgroup")
objects, enemies = GetObjectsAndEnemies( objectgroup )
print( "Objetos: ", objects )
print( "Enemigos: ", enemies )

# Add object list to screen compressed data
compressed = compressed + objects + enemies

# Save to a binary file
outputFile = sys.argv[1].partition('.')[0] + ".bin"
fOut = open(outputFile, 'wb')
for i in compressed :
   fOut.write( i.to_bytes(1, byteorder='big' ) )
fOut.close()

print( "Saved to", outputFile )

# Uncompress test
#uncompressed = Decompress( compressed )
#print( uncompressed )


   