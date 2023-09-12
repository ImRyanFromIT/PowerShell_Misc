$currentName = 
$newName = 
$credentials = (Get-Credential -Message "Please enter the Login credentials including Domain Name").GetNetworkCredential()

Rename-Computer -ComputerName $currentName -NewName $newName -DomainCredential $credentials
