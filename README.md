## Script de base de datos PREP 2012

Basandome en la informacion publica disponible en el
Instituto Federal Electoral de Mexico [IFE](http://ife.org.mx) a traves
de su Programa de Resultados Electorales Preliminares [PREP](http://ife.org.mx/difusores.html)

Es un esfuerzo ciudadano de apertura de datos en formatos mas amigables
para los data-hackers que deseen explorar esta informacion, ya que actualmente
la base de datos que se puede bajar no es totalmente compatible con los
manejadores de datos mas populares (tendran sus razones).

### Formatos soportados
Se seguiran adjuntando mas formatos, actualmente cuento con el siguiente:
* MySQL (probado con version 5.x.x)

## Instrucciones
-- Obtención de archivos
bash prep-get.sh  [directorio] 

[directorio] es un parámetro opcional, se creará (si tiene permisos) el directorio
especificado 

$ pwd 
~ /home/esparta
$ bash prep-get.sh archivos
~ creará directorio /home/esparta/archivos

-- Procesamiento para importar a mysql
$ bash prep-mysql.sh 

## Cambios y modificaciones
Los scripts que aqui se encuentran estaban originalmente pensados para mis
necesidades, pero no tengo ningun problema en hacer modificaciones que mejoren
la experiencia en el manejo de datos del PREP.
