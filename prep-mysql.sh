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

## Now we are going to pre-process the three databases
## removing some strings that should be nulls or numbers
## these are "Ilegible", "Sin dato", "null" or spaces

## Working directory
## Thanks to stackoverflow
## http://stackoverflow.com/a/246128

## TODO: Pass the working directory

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

## mysqlimport --local  --fields-terminated-by="|" --ignore-lines=6 prep2012 -u root -p /home/esparta/presidente.txt

