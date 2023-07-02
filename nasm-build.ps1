# Define the folder path where the .asm files are located
$folderPath = "."

# Get all .asm file names in the specified folder
$asmFiles = Get-ChildItem -Path $folderPath -Filter "*.asm" | Select-Object -ExpandProperty Name

# Iterate through each .asm file and build the .obj
foreach ($asmFile in $asmFiles) {
    try {
        # Build command for assembling the .asm file for Win64
        $nasmCommand = "nasm -f win64 $asmFile -o $asmFile.obj"

        # Execute the nasm command
        Invoke-Expression $nasmCommand

        # Print a green message when the obj is created
        Write-Host "[$asmFile.obj] created successfully" -ForegroundColor Green
    }
    catch {
        # Print an error message if any exception occurs during the build process
        Write-Host "Error occurred while building [$asmFile]: $_" -ForegroundColor Red
    }
}