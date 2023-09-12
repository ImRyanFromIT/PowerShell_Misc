# Import the Active Directory module
Import-Module ActiveDirectory

# Define the target OU
$targetOU = "OU=d,OU=c,DC=b,DC=a"

# Search for all computers with hostname that includes "PCC"
$computers = Get-ADComputer -Filter 'Name -like "*PCC*"'

# Loop through each computer and move it to the target OU
foreach ($computer in $computers) {
    # Move the computer to the target OU
    Move-ADObject -Identity $computer.DistinguishedName -TargetPath $targetOU
}
