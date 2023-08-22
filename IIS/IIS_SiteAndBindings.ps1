# Ensure the WebAdministration module is loaded
Import-Module IISAdministration

# Remove Default Web Site
if (Get-IISSite -Name "Default Web Site") {
    Remove-iissite -Name "Default Web Site" -Confirm
    Write-Host "Default Web Site has been deleted."
}

# Variables
$siteName = "imryanfrom.it"
$physicalPath = "\\gv-data01\Shares\WebShare\imryanfrom.it\public" # Update this to your desired path
$bindingInformation1 = "*:443:imryanfrom.it"
$bindingInformation2 = "*:443:www.imryanfrom.it"

# Create new IIS website - bind both
New-IISSite -Name $siteName -PhysicalPath $physicalPath -BindingInformation $bindingInformation1 -Protocol "https" -sslFlag "CentralCertStore"
New-IISSiteBinding -Name $siteName $bindingInformation2 -Protocol "https" -sslFlag "CentralCertStore"

Write-Host "Website $siteName created with HTTPS binding."

# Ensure the WebAdministration module is loaded
Import-Module WebAdministration

# Set anonymous authentication to use the application pool identity
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/anonymousAuthentication" -Name "username" -Location $siteName -Value ""
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/anonymousAuthentication" -Name "password" -Location $siteName -Value ""

Write-Host "Set anonymous authentication to use application pool identity for $siteName."