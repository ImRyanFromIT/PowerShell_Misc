import-module ExchangeOnlineManagement
# connect-exchangeonline
Measure-Command {
# Fetch mailboxes with 'Bellacare' in the UPN
$mailboxes = Get-Mailbox -ResultSize Unlimited | Where-Object {
    $_.UserPrincipalName -like "*Bellacare*"
} | ForEach-Object {
    # Check if the associated AD account is disabled
    $user = Get-User $_.Identity
    if ($user.UserAccountControl -notlike "*AccountDisabled*") {
        return $_
    }
}

# Create array of mailboxes by UPN and Size
$mailboxSizes = foreach ($mailbox in $mailboxes) {
    $size = Get-EXOMailboxStatistics -Identity $mailbox.UserPrincipalName | Select-Object TotalItemSize
    $sizeGB = $size.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB

    [PSCustomObject]@{
        UserPrincipalName = $mailbox.UserPrincipalName
        SizeGB = [math]::Round($sizeGB,3)
    }
}

# Take action on the mailboxes
$P1 = 0
$Kiosk = 0

foreach ($Mailbox in $mailboxSizes) {
    if ($Mailbox.SizeGB -ge 1.75) {
        Write-Host $Mailbox.UserPrincipalName "needs an Exchange P1 - " -ForegroundColor Cyan; 
        Write-Host ($Mailbox.SizeGB) -ForegroundColor Cyan;" / 1.75GB Used"
        
        $P1++
    }else {
        Write-host $Mailbox.UserPrincipalName "needs an Exchange Kiosk - " -ForegroundColor Yellow; 
        Write-Host ($Mailbox.SizeGB) -ForegroundColor Yellow;" / 1.75GB Used"

        $Kiosk++
    }
}

$mailboxSizes | Export-Csv -Path .\MailboxSizes_GraphMailbox2.csv -NoTypeInformation

}