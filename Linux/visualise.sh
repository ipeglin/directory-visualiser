#!/bin/bash

clear

FILE_PREFIX="└"
INDENTATION_PREFIX="─"
FOLDER_PREFIX=">"

# Recursive function for file traversing
listDirectory() {
    CURRENT_PATH="$1"
    declare -i LEVEL=$2
    declare -i LIMIT=$3
    FULL_FILE_PREFIX="TEST"
    
    if [ ${LIMIT} -lt 1 ]; then
        LIMIT=1
    fi

    if [ $LEVEL -lt $LIMIT ]; then
        PREFIX_LENGTH=$(($LIMIT + 1))

        FULL_FILE_PREFIX="$FILE_PREFIX$(seq -s $INDENTATION_PREFIX $(($PREFIX_LENGTH + 1)) | tr -d '[:digit:]')"
    fi

    echo "PATH: $CURRENT_PATH"
    echo "LEVEL: $LEVEL"
    echo "LIMIT: $LIMIT"
    echo "PREFIX LENGTH: $PREFIX_LENGTH"
    echo "FILE PREFIX: $FILE_PREFIX"
    echo "INDENTATION PREFIX: $INDENTATION_PREFIX"
    echo "FULL FILE PREFIX: $FULL_FILE_PREFIX"
    echo "FOLDER PREFIX: $FOLDER_PREFIX"

    read
}

listDirectory $PWD 0 -5
