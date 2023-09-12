# Import the Active Directory module
Import-Module ActiveDirectory

# Search for all computers with hostname that includes "PCC"
$computers = Get-ADComputer -Filter 'Name -like "*PCC*"'

# Loop through each computer and unprotect it
foreach ($computer in $computers) {
    # Get the computer's distinguished name
    $computerDN = $computer.DistinguishedName
    # Unprotect the computer against accidental deletion
    Set-ADObject -Identity $computerDN -ProtectedFromAccidentalDeletion $false
}