Search-ADAccount  -AccountInactive -ComputersOnly -TimeSpan (New-TimeSpan -Days 30)  |  

Where-Object {
     $_.DistinguishedName -notlike "*OU=Computers,OU=Inactive Objects,DC=ps,DC=local" -and # Disabled machines get auto deleted?
     $_.DistinguishedName -notlike "*OU=Servers,DC=ps,DC=local"                       -and # Excluding servers
     $_.DistinguishedName -notlike "*OU=Domain Controllers,DC=ps,DC=local"            -and # Excluding machines with the name "Domain Controller"
     $_.DistinguishedName -notlike "CN=*NO*"                                          -and # Excluding Corporate machines
     $_.DistinguishedName -notlike "*CN=Managed Service Accounts,DC=ps,DC=local"      -and # Excluding SQL/other machines in this OU
     $_.DistinguishedName -notlike "CN=*PCCBACKUP*"                                   -and # Excluding PCCBackups just in case
     $_.DistinguishedName -notlike "*CN=Azure*"                                       -and # Excluding machines with the name "azure"
     $_.DistinguishedName -notlike "CN=*KISK*"                                             # Excluding machines with the name "KISK"
              }  | 
              
Export-csv -Path \\192.168.5.100\RyanTemp\$((Get-Date).ToString('MM-dd-yyyy')).csv -NoTypeInformation #Exports log file dated

ForEach($dn in (Import-Csv -Path "\\192.168.5.100\RyanTemp\$((Get-Date).ToString('MM-dd-yyyy')).csv"))
{
    Remove-ADObject -Identity $dn.'DistinguishedName' -Recursive -Confirm:$false #Where DistinguishedName is the column header of the csv that holds the dn.
    
}
