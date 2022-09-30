#!/bin/bash

unset DIRPATH TARGET_FILENAME FULL_DATAPATH URL_PATH

DIRPATH=./data/

while getopts 'd:f:' c
do
  case $c in
    d) DIRPATH=$OPTARG ;;
    f) TARGET_FILENAME=$OPTARG ;;
  esac
done

URL_PATH=${@:$OPTIND:1}


# Create data Directory if doesn't exists
if [ ! -d "$DIRPATH" ]
    then
        echo "Creating directory: $DIRPATH.";
        mkdir "$DIRPATH";
fi

# Downloads data if not available.
if [ -z "$TARGET_FILENAME" ]; then
    TARGET_FILENAME=$( basename $1 )
fi

FULL_DATAPATH="$DIRPATH/$TARGET_FILENAME";

if [[ -f "$FULL_DATAPATH" ]]; then
    echo "$FULL_DATAPATH already exists.";
else
    echo "Downloading data from $URL_PATH to $FULL_DATAPATH";
    wget -O "$FULL_DATAPATH" "$URL_PATH";
fi