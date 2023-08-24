# Define the parameters for network configuration
$interfaceIndex = (Get-NetAdapter | Where-Object {$_.Name -eq 'Ethernet'}).ifIndex
$ipAddress = "10.0.0.223"
$subnetPrefix = 24
$gateway = "10.0.0.1"
$dns1 = "10.0.0.201"
$dns2 = "10.0.0.202"

# Set the static IP address
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $ipAddress -PrefixLength $subnetPrefix -DefaultGateway $gateway

# Set the DNS server addresses
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $dns1,$dns2

Write-Output "Network configuration updated successfully!"