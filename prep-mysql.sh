#!/bin/bash

## prep-mysql.sh
## Developer: Espartaco Palma (esparta@gmail.com)
## Date: 2012-07-04
## License: GPL
## Description: This script pre-process the
##    database of the Programa de Resultados Electorales Preliminares
##    of the Mexico Federal elections.
## Usage:
##    bash prep-mysql.sh [source-directory]
##    [source-directory] optional relative path of files, 
##         no parameters means current directory
##    $ pwd
##    ~ /home/esparta
##    $ bash prep-mysql.sh archivos
##    ~ This will try to get the files from /home/esparta/archivos
##     


## MySQL Settings
DATABASE="prep2012"
USER="root"
HOST="localhost"

function error_exit {
   local err=$?
   #echo "error# $err on line $BASH_LINENO: $BASH_COMMAND"
   echo "${BASH_SOURCE[0]}: ${1:-"Unknown Error"}" 1>&2
   exit $err
}



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

sd=
if [  "$#" -eq 1 ]; then
  sd="/$1"
fi

trap error_exit SIGHUP SIGINT SIGTERM

## We are going to pre-process the three databases
## removing some strings that should be nulls or numbers
## these are "Ilegible", "Sin dato", "null" or spaces
echo "Script de automatización de archivos PREP 2012 en MySQL"
if [ -d "$DIR$sd" ] ; then ## exist the source directory?
  echo "source directory: $DIR$sd"

  files=( presidente.txt senadores.txt diputados.txt )
  strings=( Ilegible 'Sin dato' null )

  for f in "${files[@]}"; do
    ## Does the file exists on the current directory?    
    if [ -f "$DIR$sd/$f" ] ; then 
      ## fine let's process it
      echo  "... pre-procesando base de datos $DIR$sd/$f"

      for s in "${strings[@]}"; do
          echo -e "\t quitando $s"

            if ! sed -i "s/$s/\\\N/g" "$DIR$sd/$f" ; then
               echo "Error al procesar archivo con comando 'sed'. ¿No instalado?"
               exit 1
            fi
      done
      echo -e "\t quitando | |"
      ## I had to do this twice. My regex-fu sucks, I know.
      if [ sed -i "s/| |/|\\\N|/g" "$DIR$sd/$f" ] && 
         [ sed -i "s/| |/|\\\N|/g" "$DIR$sd/$f" ]; then
               echo "Error al procesar archivo con comando 'sed'. ¿No instalado?"
               exit 1        
      fi

      echo "Procediendo a importar archivo presidente.txt"
      echo "Introduzca contraseña de servidor MySQL..."
      mysqlimport --local  --fields-terminated-by="|" --ignore-lines=6 $DATABASE -u $USER -h $HOST -p "$DIR$sd/$f"
    else
      echo "No es posible localizar el archivo $DIR$sd/$f"
    fi
  done
else
  echo "No se localizó el directorio $DIR$sd"  
fi


