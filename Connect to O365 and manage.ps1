Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
$c = get-credential -Credential coled@asisherweb.onmicrosoft.com
Connect-MsolService -Credential $c
Connect-AzureAD -Credential $c

# Names for the O365 licenses we use are as follow, Office 365 E3 = SPE_E3, Microsoft 365 Business Premium = SFB, 
# Microsoft 365 Business Standard = O365_BUSINESS_PREMIUM

# Use Get-Command -Module MSOnline to grab a list of cmdlets that can be used to manage Office 365

# New-MsolUser -UserPrincipalName testpowershell@squarecabinets.com -DisplayName TestSquare -FirstName Test -LastName Square -Password Square123 -ForceChangePassword $true -usagelocation US
# The cmdlet above can be used to create a user in O365

# Remove-MsolUser -UserPrincipalName user@domain.com -verbose
# The Cmdlet above can be used to remove a user and will have a verbose prompt to remove the user before doing so.

# In order to add a license to a user, you will need to use the cmdlet below. The addlicenses switch will need to start with the reseller-account:licensename. You will also need to add -usagelocation "US" at the end. 
#
# Set-MsolUserLicense -UserPrincipalName "exampleuser.alliedstoneinc.com" -addlicenses "reseller-account:O365_BUSINESS_PREMIUM"

# You can also remove license with the same cmdlet but changing the switch to -removelicenses
# Replace one license with another
Set-MsolUserLicense -UserPrincipalName "user.alleidstoneinc.com" -AddLicenses "reseller-account:DESKLESS" -RemoveLicenses "reseller-account:ENTERPRISEPACK"