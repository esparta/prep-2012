#!/bin/bash

## prep-mysql.sh
## Developer: Espartaco Palma (esparta@gmail.com)
## Date: 2012-07-04
## License: GPL
## Description: This script pre-process the
##    database of the Programa de Resultados Electorales Preliminares
##    of the Mexico Federal elections.

## MySQL Settings
DATABASE="prep2012"
USER="root"
HOST="localhost"

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


## We are going to pre-process the three databases
## removing some strings that should be nulls or numbers
## these are "Ilegible", "Sin dato", "null" or spaces



files=( presidente.txt senadores.txt diputados.txt )
strings=( Ilegible 'Sin dato' null )

  for f in "${files[@]}"; do
    echo  "... pre-procesando base de datos $f"
     for s in "${strings[@]}"; do
        echo -e "\t quitando $s"
        sed -i "s/$s/\\\N/g" $DIR/$f
     done
     echo -e "\t quitando | |"
     sed -i "s/| |/|\\\N|/g" $DIR/$f
     sed -i "s/| |/|\\\N|/g" $DIR/$f
  done

#mysqlimport --local  --fields-terminated-by="|" --ignore-lines=6 $DATABASE -u $USER -h $HOST -p presidente.txt

