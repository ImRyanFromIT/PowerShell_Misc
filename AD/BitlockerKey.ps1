# Uses invoke but not fully setup for winrm

$computer = $env:computername
 
        $bitlockerVolume = Invoke-Command -ComputerName $computer -ScriptBlock {
            Get-BitLockerVolume | Where-Object { $_.VolumeType -eq "OperatingSystem" }
        }

        if ($bitlockerVolume.ProtectionStatus -eq "On" -and $bitlockerVolume.KeyProtectorId -notcontains "AD") {
            Invoke-Command -ComputerName $computer -ScriptBlock {
                Backup-BitLockerKeyProtector -MountPoint C: -KeyProtectorId (Get-BitLockerVolume -MountPoint C:).KeyProtector[0].KeyProtectorId
            }
            Write-Output "Backed up BitLocker recovery key for $($computer) to AD."
        } else {
            Write-Output "BitLocker is not enabled or recovery key is already backed up for $($computer)."
        }
