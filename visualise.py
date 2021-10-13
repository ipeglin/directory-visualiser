import os
import sys

# Recursive function for file traversing
def list_directory(path: str, level: int, limit: int) -> None:
    os.chdir(path) # Changing the cwd for the os terminal commands to be run in

    if (limit < 1):
        limit = 1

    if (level < limit):
        prefix_length = level + 1

        # Setting prefixes for display
        indentation_prefix = "─"
        file_prefix = "└"
        folder_prefix = ">"
        full_file_prefix = f"{file_prefix}{indentation_prefix * prefix_length}"

        # Listing directory content
        files = [os.path.realpath(file) for file in os.listdir(path) if os.path.isfile(file)]
        folders = [os.path.realpath(DIR) for DIR in os.listdir(path) if os.path.isdir(DIR)]

        print(f"{folder_prefix * prefix_length} {os.path.basename(path)}") # Print the location of the current recursion target
        [print(f"{full_file_prefix} {os.path.basename(file)}") for file in files] # Print name of each file in the directory

        # Folder recursion
        [list_directory(os.path.realpath(folder), (level + 1), limit) for folder in folders] # Recurse down for each of the folder in the array of folders


# Get det recursion limit
def get_recursion_level() -> int:
    if (get_sys_args()):
        recursion_limit = int(get_sys_args()[0])
    else:
        try:
            recursion_limit = int(input("Recursion limit: "))
        except:
            recursion_limit = 1

    return recursion_limit
    

def get_sys_args() -> list:
    try:
        recursion_limit = sys.argv[1]
        return [recursion_limit]
    except:
        return []


# Run the recursive function in the current working directory
list_directory(os.getcwd(), 0, get_recursion_level())