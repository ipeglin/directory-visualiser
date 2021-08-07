#!/bin/bash

# Define global prefixes
FILE_PREFIX="└"
INDENTATION_PREFIX="─"
FOLDER_PREFIX=">"

# Recursive function for file traversing
listDirectory() {
    # Declaring variables that where passed to the function
    CURRENT_PATH="$1"
    declare -i LEVEL=$2
    declare -i LIMIT=$3

    # Declaring string variables
    FULL_FILE_PREFIX=""
    BASENAME=$(basename $CURRENT_PATH)
    
    # If the limit is less than 1. Set to 1
    if [ ${LIMIT} -lt 1 ]; then
        LIMIT=$((1))
    fi

    # Run if the amount of recursion haven't reached the limit
    if [ $LEVEL -lt $LIMIT ]; then
        PREFIX_LENGTH=$(($LEVEL + 2)) # Defining prefix length

        FULL_FILE_PREFIX="$FILE_PREFIX$(seq -s $INDENTATION_PREFIX $PREFIX_LENGTH | tr -d '[:digit:]')" # Defining the full file prefix for display

        # Declaring arrays
        declare -a CONTENT=($CURRENT_PATH/*) # Containing all elements in current location
        declare -a FILES=()
        declare -a FOLDERS=()

        # Separating files from content array
        for item in ${CONTENT[@]}; do
            local ITEMNAME=$(echo $item | sed "s/.*\///") # Setting local variable containing itemname
            
            # Evaluate if it has the typical filename with text before and after a '.'
            if [[ $ITEMNAME == *"."* ]]; then
                FILES+=($item) # Add file path to array
            else
                FOLDERS+=($item) # Add folder path to array
            fi
        done

        LEVEL=$(($LEVEL + 1)) # Increment the level variable

        # Current location and folder content
        echo "$(seq -s $FOLDER_PREFIX $PREFIX_LENGTH | tr -d '[:digit:]') $BASENAME" # Print the location of the current recursion target
        for file in ${FILES[@]}; do
            echo "$FULL_FILE_PREFIX $(echo $file | sed 's/.*\///')" # Print the file name of each file in the directory
        done

        # Folder recursion
        for folder in ${FOLDERS[@]}; do
            listDirectory $folder $LEVEL $LIMIT # Recurse down for each of the folders in the $FOLDERS array
        done
    fi

    # read
}

# Main function for aquiring recursion limit
Main() {
    { # Try
        read -p "Recursion Limit: " RECURSION_LIMIT # Read the int value for the recursion limit
    } || { # Catch
        declare -i RECURSION_LIMIT=1 # Set the limit to 1
    }
    listDirectory $PWD 0 $RECURSION_LIMIT # Make the initial function call with the given limit
}

# Run the Main function
Main