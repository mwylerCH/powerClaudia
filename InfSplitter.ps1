# PI.ps1


$PATH = ".\Documents\oneChicken.fa"

# read in file
$Original = Get-Content -Path $PATH




#### Read the file line by line ------------------------

# read fasta into hash
$Fasta = [ordered]@{}
$CHIAVE
$SEQ

ForEach ($Line in $Original) {

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
    # Process each line here
}


### Split up -----------------------------

$FastaHeads = $Fasta.Keys

#for (($NR = 1); $NR -lt 9; $NR++) {
for (($NR = 1); $NR -lt 2; $NR++) {
	# open file for each segment
	"ecco $NR"
	ForEach ($head in $Original) {
		# test if key contains the number
		#if ($head -like "*_$NR_*" -or $head -like "*\|$NR\|*"){
		#if ($head -like ".*_$NR_.*" -or $head -like ".*\|$NR\|.*"){
$head = ">|PB2|Huhn_Switzerland1|Huhn|Fehraltorf"
$head
		if ($head -like ".*\|$NR\|.*"){
			$head
		}
	}
}




# $FastaHeads








