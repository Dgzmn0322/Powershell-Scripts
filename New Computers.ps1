# Check DNS Interface
Get-DnsClientServerAddress

# Replace Interface Alias with Wifi Number
Set-DNSClientServerAddress "Wi-Fi" –ServerAddresses ("10.252.2.10", "8.8.8.8")

$COMPUTERNAME = #Type Computer Name Here ex. ASI-LUN-00001

# 1. Rename Computer
Rename-Computer -NewName $COMPUTERNAME -force

# 2. Install the PSWindowsUpdate Module
Install-Module -name PSWindowsUpdate -Force -Confirm $true

# Install all available Updates
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll

$domaincred = get-credential alliedstoneinc\admin "All!ed$ecured"

# After Updates Install, then join computer to the domain
Add-Computer -credential $domaincred -DomainName alliedstoneinc.com  -Restart