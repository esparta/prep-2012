#!/bin/bash

## prep-mysql.sh
## Developer: Espartaco Palma (esparta@gmail.com)
## Date: 2012-07-04
## License: GPL 
## Description: This script try to download and pre-process the 
##    database of the Programa de Resultados Electorales Preliminares
##    of the Mexico Federal elections.
##    Optional: Create directory
##              Prefered downloading server
##


## Create a new directory for the database files?
## Set to 1 if to create a directory with the same name of the FILE
CREATEDIR=0

## This is MY prefered downloading server
## if you desire to download ramdomized, leave it blank
PREFERED_SERVER="http://prep2012.ife.org.mx"
##PREFERED_SERVER=""

FILE="20120702_2000-listaActas.tar.gz"

## cheksum valido
SHA1VALIDO="0b214a3571491b7053cdd9e1ade54ca10a5af086"

SERVERS=(
"http://prep2012.excelsior.com.mx"
"http://ife.canal22.org.mx"
"http://prep2012.elimparcial.com"
"http://prep2012.excelsior.com.mx"
"http://elecciones2012.gruporeforma.com"
"http://prep2012.radiorama.com.mx"
"http://prep2012.excelsior.com.mx"
"http://prep2012.ife.org.mx"
"http://prep.milenio.com"
"http://prep2012.aztecanoticias.com.mx"
"http://www.difusorife.ipn.mx"
"http://www.difusorprep-elecciones2012.unam.mx"
"http://prep2012.radioformula.com.mx"
"http://prep2012.excelsior.com.mx"
"http://prep.eluniversal.com.mx"
"http://elecciones.unotv.com"
"http://74.200.195.178"
)

## Working directory
## Thanks to stackoverflow
## http://stackoverflow.com/a/246128

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

## Working directory

echo "Script de automatizacion en el procesamiento de PREP 2012"

if [ ! -f "$DIR/$FILE" ]; then
  echo "Descargar archivo de alguno de los difusores"
  if [ -z "$PREFERED_SERVER" ]; then
    ## Get the file from some random server
    RANGE=${#SERVERS[@]}
    number=$RANDOM
    let "number %= $RANGE"
    dbsource=$(echo ${SERVERS[$number]})
  else
    dbsource="$PREFERED_SERVER";
  fi
  echo "Obteniendo BBDD de $dbsource"
  wget "$dbsource/prep/$FILE"
else
  echo "Se usara el archivo del directorio local"
fi


## Validate SHA1 Checksum, MUST be the same.
sha1=$(sha1sum $FILE|awk '{print $1}')
if [ "$sha1" = "$SHA1VALIDO" ];
then
  #The SHA1 is valid, continue
  echo "Descomprimir y desempacar archivo"
  if [ $CREATEDIR = 1  ]; then
    WDIR=$(echo $DIR/${FILE%.tar.gz})
    mkdir -p $WDIR
  else
    WDIR=$DIR
  fi

  tar xvfz $FILE -C $WDIR

  ## Now we are going to pre-process the three databases
  ## removing some strings that should be nulls or numbers
  ## these are "Ilegible", "Sin dato", "null" or spaces

  files=( presidente.txt senadores.txt diputados.txt )
  strings=( Ilegible 'Sin dato' null )

  for f in "${files[@]}"; do
    echo  "... pre-procesando base de datos $f"
     for s in "${strings[@]}"; do
        echo -e "\t quitando $s"
        sed -i "s/$s/\\\N/g" $WDIR/$f
     done
     echo -e "\t quitando | |"
     sed -i "s/| |/|\\\N|/g" $WDIR/$f
     sed -i "s/| |/|\\\N|/g" $WDIR/$f
  done
else
  echo "El checksum de el archivo $FILE no coincide con el esperado"
  echo "Probablemente el archvo descargado esta corrupto"
  echo "por favor, borrelo y reinicie este proceso"
  exit
fi


## mysqlimport --local  --fields-terminated-by="|" --ignore-lines=6 prep2012 -u root -p /home/esparta/presidente.txt

