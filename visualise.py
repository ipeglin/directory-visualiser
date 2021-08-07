import os
import sys
from pathlib import Path

clear = lambda:os.system("cls")
clear()

def list_directory(path, level, limit):
    os.chdir(path)

    if (limit < 1):
        limit = 1

    if (level < limit):
        file_prefix = "└"
        indentation_prefix = "─"
        prefix_length = level + 1
        full_file_prefix = f"{file_prefix}{indentation_prefix * prefix_length}"
        folder_prefix = ">"

        files = [os.path.realpath(file) for file in os.listdir(path) if os.path.isfile(file)]
        folders = [os.path.realpath(DIR) for DIR in os.listdir(path) if os.path.isdir(DIR)]

        print(f"{folder_prefix * prefix_length} {os.path.basename(path)}")
        [print(f"{full_file_prefix} {os.path.basename(file)}") for file in files]

        [list_directory(os.path.realpath(folder), (level + 1), limit) for folder in folders]

def get_recursion_level():
    if (get_sys_args()):
        recursion_limit = int(get_sys_args()[0])
    else:
        try:
            recursion_limit = int(input("Recursion limit: "))
        except:
            recursion_limit = 1
    return recursion_limit
    

def get_sys_args():
    try:
        recursion_limit = sys.argv[1]
        return [recursion_limit]
    except:
        return []

# Run the recursive function in the current working directory
list_directory(os.getcwd(), 0, get_recursion_level())