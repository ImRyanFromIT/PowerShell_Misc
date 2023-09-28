Import-Module ActiveDirectory

$computers = Get-ADComputer -Filter {(OperatingSystem -like "Windows 10*") -and (Enabled -eq $true) -and (Name -notlike "*-TL*") -and (Name -notlike "*-TC*") -and (Name -notlike "*FINGERPRINT*") -and (Name -notlike "*DT*" -and (Name -notlike "*KISK*") -and (Name -notlike "HP*") )} -Property OperatingSystem

$noBitLocker = @()
foreach ($computer in $computers) {
    $bitlockerInfo = Get-ADObject -Filter {ObjectClass -eq 'msFVE-RecoveryInformation'} -SearchBase $computer.DistinguishedName
    if (-not $bitlockerInfo) {
        $noBitLocker += [PSCustomObject]@{
            'ComputerName' = $computer.Name
        }
    }
}

$noBitLocker | Export-Csv -Path "C:\temp\bitlocker.csv" -NoTypeInformation