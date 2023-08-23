# This script installs the features necessary for an IIS server. 
Install-WindowsFeature -Name Web-Server, Web-HTTP-Logging, Web-Log-Libraries, Web-Filtering, Web-CertProvider, Web-Http-Redirect -includemanagementtools

Write-Host "Features have been installed."