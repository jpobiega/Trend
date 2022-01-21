# Pass in the full path of the .txt file containing the files to be excepted
# Assumes the .exes are listed on single lines in a .txt file (full system path)
# Will drop the .csv containing the hashes in the directory that script was executed in
param(
    [string]$filepath
)
$exes = Get-Content -Path $filepath
$outarray = @()
foreach ($exe in $exes) {
    $file_list = Get-FileHash -Algorithm SHA1 $exe
    foreach ($file in $file_list){
        $outarray += $file | Select-Object -Property @{Name = 'File'; Expression = {$_.Hash}},@{Name = 'Hash,File'; Expression = {$_.Path}},@{Name = 'Name'; Expression = {$_.Path}}
    }
    
}
$outarray | Export-Csv -Path .\A1Hashes.csv -NoTypeInformation