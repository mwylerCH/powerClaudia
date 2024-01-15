# powerClaudia

Various tools for file handling (in particular on Windows OS).

## Usage

**Right Click** on the file, then "Run with PowerShell"/"Ausführen mit PowerShell". 

Alternative (in the powershell window): *./InfSplitter.ps1 FILE.fa*

### InfSplitter.ps1

Splits Influenza multi fasta files into a single fasta for each segment. Headers have to contain the segment number in the following format: "\_1\_" or "|1|".

### FileMerger.ps1

Concatenates all kind of text files into a single one. Path of the output is the same as the input and is called *mergedFile_<TIME>.txt*. 
Can be used to merge back output of *InfSplitter.ps1*.
