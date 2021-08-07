#!/bin/bash

FILE_PREFIX="└"
INDENTATION_PREFIX="─"
FOLDER_PREFIX=">"

# Recursive function for file traversing
listDirectory() {
    CURRENT_PATH="$1"
    BASENAME=$(basename $CURRENT_PATH)
    declare -i LEVEL=$2
    declare -i LIMIT=$3
    FULL_FILE_PREFIX=""
    
    if [ ${LIMIT} -lt 1 ]; then
        LIMIT=$((1))
    fi

    if [ $LEVEL -lt $LIMIT ]; then
        PREFIX_LENGTH=$(($LEVEL + 2))

        FULL_FILE_PREFIX="$FILE_PREFIX$(seq -s $INDENTATION_PREFIX $PREFIX_LENGTH | tr -d '[:digit:]')"

        declare -a CONTENT=($CURRENT_PATH/*)
        declare -a FILES=()
        declare -a FOLDERS=()

        for item in ${CONTENT[@]}; do
            local ITEMNAME=$(echo $item | sed "s/.*\///")
            if [[ $ITEMNAME == *"."* ]]; then
                FILES+=($item)
            else
                FOLDERS+=($item)
            fi
        done

        LEVEL=$(($LEVEL + 1))
        echo "$(seq -s $FOLDER_PREFIX $PREFIX_LENGTH | tr -d '[:digit:]') $BASENAME"
        for file in ${FILES[@]}; do
            echo "$FULL_FILE_PREFIX $(echo $file | sed 's/.*\///')"
        done

        for folder in ${FOLDERS[@]}; do
            listDirectory $folder $LEVEL $LIMIT
        done
    fi

    # read
}

Main() {
    { # Try
        read -p "Recursion Limit: " RECURSION_LIMIT
    } || { # Catch
        declare -i RECURSION_LIMIT=1
    }
    listDirectory $PWD 0 $RECURSION_LIMIT
}

Main