$hostnamePullLocation

Get-ADComputer -Filter 'Name -like "*-kisk*"' -Properties DistinguishedName -SearchBase "DC=b, DC=a" |
Export-Csv $hostnamePullLocation
