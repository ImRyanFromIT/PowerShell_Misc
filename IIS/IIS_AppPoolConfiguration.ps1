# Thanks to https://stackoverflow.com/a/48524821 

Import-Module WebAdministration

$app_pool_name = "DefaultAppPool" # change to your app pool name

$credentials = (Get-Credential -Message "Please enter the Login credentials including Domain Name").GetNetworkCredential()
$userName = $credentials.Domain + '\' + $credentials.UserName

Set-ItemProperty IIS:\AppPools\$app_pool_name -name processModel.identityType -Value 3 
Set-ItemProperty IIS:\AppPools\$app_pool_name -name processModel.userName -Value $username
Set-ItemProperty IIS:\AppPools\$app_pool_name -name processModel.password -Value $credentials.Password
