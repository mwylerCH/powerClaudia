# PI.ps1


# Splits up influenza fasta with a single file for each segment
# Michele Wyler, IVI Mittelhäusern, 4.1.2024


## Ask input file through file explorer
# load library
Add-Type -AssemblyName System.Windows.Forms

# initiate windows
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Windows') }


# display
$null = $FileBrowser.ShowDialog()


# read in file
#cat $FileBrowser.FileName  
$Original = Get-Content -Path $FileBrowser.FileName  
$PATH = $FileBrowser.FileName

#### Read the file line by line ------------------------

# read fasta into hash
$Fasta = [ordered]@{}
$CHIAVE
$SEQ

ForEach ($Line in $Original) {
	if ($Line -notlike ''){
			if($Line -like ">*"){
				$CHIAVE = $Line		
			} elseif ($Line -like "*"){
				# test if key exist already
				if ($Fasta.Keys -contains $CHIAVE) {
					$SEQ = $Fasta[$CHIAVE] + $LINE
					# remove first...
					$Fasta.Remove($CHIAVE)
					# ...and add longer sequence
					$Fasta.Add($CHIAVE, $SEQ)
				} else {
					# if it's new
					$Fasta.Add($CHIAVE, $Line)
				}
			}
	}
}


### Split up -----------------------------

[System.Collections.ArrayList]$FastaHeads = $Fasta.Keys

for (($NR = 1); $NR -lt 9; $NR++) {
	# open file for each segment
	$OUTfile = $PATH.replace('.fasta','.fa')
	$OUTfile = $OUTfile.replace('.fa',"_segment$NR.fa")

	# remove file (if already present)
	$fileExists = Test-Path -Path $OUTfile
	if ($fileExists) {
		Remove-Item -Path $OUTfile
	}

	# loop through hash (and write out)	
	ForEach ($head in $Fasta.Keys) {
		# test if key contains the seg number
		if (($head -match ".*_${NR}_.*") -or ($head -match ".*\|$NR\|.*")){
			Out-File -Append -FilePath $OUTfile -InputObject $head
			Out-File -Append -FilePath $OUTfile -InputObject $Fasta[$head]
			# and remove them from list of keys (to check if all where found)
			$FastaHeads.Remove("$head")
		}
	}
}

### look for problematic headers ----------------------------

ForEach ($head in $FastaHeads) {
Write-Error "WARNING"
'ERROR: No Number indication for $head: Try to use `|1|` or `_1_`'
Pause
}
