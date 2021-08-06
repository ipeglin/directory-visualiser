
# Recursive function for file traversing
function listDirectory {
    param (
        $Path = ".",
        $Level = 0,
        $Limit = 1
    )

    # If the limit is less than 1. Set to 1
    if ($Limit -lt 1) {
        $Limit = 1
    }

    # Run if the amount of recursion havent reached the limit
    if ($Level -lt $Limit) {
        $PrefixLength = ($Level + 1) # Difining the prefix length

        # Setting the prefixes for display
        $FilePrefix = "└" # Alternatives for prefix design: ├═ (alt 195 & 205)   ╠═ (alt 204 & 205)   ├─ (alt 195 & 196)   └─ (alt 192 & 196)
        $IndentationPrefix = "─"
        $FullFilePrefix = "$FilePrefix$($IndentationPrefix * $PrefixLength)"
        $FolderPrefix = ">"
        
        
        # Listing directory content
        $Files = Get-ChildItem -Path $Path | Where-Object {$_.GetType().Name -like "FileInfo"} | Select-Object $_ # List of files in the directory
        $Folders = Get-ChildItem -Path $Path | Where-Object {$_.GetType().Name -like "DirectoryInfo"} | Select-Object $_ # List of sub-directories in the directory
                
        $Level = $Level + 1 # Incrementing the counter for level of recursion

        # Current location and folder content
        Write-Host "$($FolderPrefix * $PrefixLength) $(Split-Path -Path $Path -Leaf)" # Print the location of the current recursion target
        foreach ($file in $Files) {
            Write-Host "$FullFilePrefix $(Split-Path -Path $file -Leaf)" # Print name of each file in the directory
        }
        
        # Folder recursion
        foreach ($folder in $Folders) {
            listDirectory -Path $folder.FullName -Level $Level -Limit $Limit # Recurse down for each of the folders in the $Folders list
        }
    }
}

# Main function for aquiring recursion limit
function Main {
    try {
        $RecursionLimit = [int]$(Read-Host "Recurion Limit: ") # Try to set the recursion limit
    }
    catch {
        $RecursionLimit = 1 # If the attempts failed. Set the limit to 1
    }
    listDirectory -Path $pwd -Limit $RecursionLimit # Make the initial function call with the given limit
}

# Run the Main function 
Main