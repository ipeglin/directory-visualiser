import os
from pathlib import Path

current_path = os.getcwd()
print(current_path)

def list_content(path):
    print(f"=== Searching DIR: {os.path.realpath(path)} ===")
    files = [os.path.realpath(file) for file in os.listdir(path) if not os.path.isdir(file)]
    print("FILES IN DIRECTORY:", [Path(file).name for file in files], "\n") # Printing the files in the directory

    [list_content(os.path.realpath(DIR)) for DIR in os.listdir(path) if os.path.isdir(DIR)]

list_content(current_path)