import os
import sys
from pathlib import Path

def list_content(path, level, limit):
    if (level <= limit):
        # Setting a prefix that indicates how deep the recursion has gone
        prefix = ("=" * level) + ">"
        print(f"{prefix} {os.path.realpath(path)}") # Print the current directory path

        # Listing all the files withing the current directory
        files = [os.path.realpath(file) for file in os.listdir(path) if not os.path.isdir(file)]
        [print(f"    - {(Path(file).name)}") for file in files] # Print the files in the directory
        
        print("\n") # Print new line before recursing to new sub-directory
        
        # Increment the level count to indicate how deep the recursion has gone
        level += 1
        # Run the recursive function for each of the sub-directory in the current folder
        [list_content(os.path.realpath(DIR), level, limit) for DIR in os.listdir(path) if os.path.isdir(DIR)]

def get_recursion_level():
    if (get_sys_args()):
        recursion_limit = int(get_sys_args()[0])
    else:
        recursion_limit = int(input("Recursion limit: "))
    return recursion_limit
    

def get_sys_args():
    try:
        recursion_limit = sys.argv[1]
        return [recursion_limit]
    except:
        return []

# Run the recursive function in the current working directory
list_content(os.getcwd(), 0, get_recursion_level())