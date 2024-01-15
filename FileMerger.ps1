# PI.ps1


# Concatenate multiple files into one (eg. Fastas) 
# Michele Wyler, IVI Mittelhäusern, 15.1.2024


## File Selection ----------------------------------------------------------


## Ask input file through file explorer
# load library
Add-Type -AssemblyName System.Windows.Forms

# initiate windows
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
									InitialDirectory = [Environment]::GetFolderPath('Windows') 
									Multiselect = $true}

# display
$null = $FileBrowser.ShowDialog()

# read in file
#cat $FileBrowser.FileNames


## name output ----------------------------------------------------------

# get time
$TIME = Get-Date -Format "MMddyyyy_HHmmss"

# get path of first file
$FIRSTfile = $FileBrowser.FileNames | Select-Object -first 1
$PATH = [System.IO.Path]::GetDirectoryName($FIRSTfile)

# concatenate new name of output
$OUT = "$PATH\mergedFile_$TIME.txt"


## print out ----------------------------------------------------------

## print out one after other
foreach ($FILE in $FileBrowser.FileNames){
	$FILEcontent = Get-Content -Path $FILE
	Out-File -Append -FilePath $OUT -InputObject $FILEcontent
}


