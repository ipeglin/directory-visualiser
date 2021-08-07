import os
import sys

# Recursive function for file traversing
def list_directory(path, level, limit):
    os.chdir(path) # Changing the cwd for the os terminal commands to be run in

    # Make sure that the limit is at least 1
    if (limit < 1):
        limit = 1

    # Run if amount of recursion haven't reached the limit
    if (level < limit):
        prefix_length = level + 1 # Setting prefix length

        # Setting prefixes for display
        file_prefix = "└"
        indentation_prefix = "─"
        full_file_prefix = f"{file_prefix}{indentation_prefix * prefix_length}"
        folder_prefix = ">"

        # Listing directory content
        files = [os.path.realpath(file) for file in os.listdir(path) if os.path.isfile(file)] # List of the files in the directory
        folders = [os.path.realpath(DIR) for DIR in os.listdir(path) if os.path.isdir(DIR)] # List of folders within the directory

        # Current location and folder content
        print(f"{folder_prefix * prefix_length} {os.path.basename(path)}") # Print the location of the current recursion target
        [print(f"{full_file_prefix} {os.path.basename(file)}") for file in files] # Print name of each file in the directory

        # Folder recursion
        [list_directory(os.path.realpath(folder), (level + 1), limit) for folder in folders] # Recurse down for each of the folder in the array of folders

# Get det recursion limit
def get_recursion_level():
    if (get_sys_args()):
        recursion_limit = int(get_sys_args()[0]) # Use the get_sys_args function to get argv arguments passet in the command line
    else:
        try:
            recursion_limit = int(input("Recursion limit: ")) # Try to get user input for the limit
        except:
            recursion_limit = 1 # Set the limit to 1 if input fails
    return recursion_limit
    

def get_sys_args():
    try:
        recursion_limit = sys.argv[1] # Retrieve the first in-line argument passed in command line
        return [recursion_limit]
    except:
        return []

# Run the recursive function in the current working directory
list_directory(os.getcwd(), 0, get_recursion_level())