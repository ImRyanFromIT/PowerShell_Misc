
$computers = Import-Csv -Path "path_to_your_file.csv"
$results = @()
foreach ($computer in $computers) {
    $pingResult = Test-Connection -ComputerName $computer.hostname -Count 1 -ErrorAction SilentlyContinue
    
    if ($pingResult) {
        $outputObject = [PSCustomObject]@{
            hostname = $computer.hostname
            IPAddress = $pingResult.IPV4Address.IPAddressToString
            PSObject = $computer | Get-Member -MemberType NoteProperty | Where-Object {$_.Name -ne "hostname"} | ForEach-Object {
                Add-Member -InputObject $outputObject -NotePropertyName $_.Name -NotePropertyValue $computer.$($_.Name) -PassThru
            }
        }
    } else {
        $outputObject = [PSCustomObject]@{
            hostname = $computer.hostname
            IPAddress = "No Response"
            PSObject = $computer | Get-Member -MemberType NoteProperty | Where-Object {$_.Name -ne "hostname"} | ForEach-Object {
                Add-Member -InputObject $outputObject -NotePropertyName $_.Name -NotePropertyValue $computer.$($_.Name) -PassThru
            }
        }
    }
    
    $results += $outputObject
}

$results | Export-Csv -Path "results.csv" -NoTypeInformation