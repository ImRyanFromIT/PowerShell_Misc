# This scripts enables and configures the central cert provider for an IIS 10 server

# You'll also be prompted for the password for the certificate itself. 

$certStore = "\\gv-data01\Shares\WebShare\SSL Central Store" # Change to your certificate store path
$c = Get-Credential # Prompts for certificate management service account

Enable-IISCentralCertProvider -CertStoreLocation $certStore -UserName $c.Username -Password $c.Password

Write-Host "IIS Central Certificate Store has been configured."