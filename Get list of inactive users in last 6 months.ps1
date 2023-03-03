# Connect to Microsoft 365
Connect-MsolService

# Variable for UPN Admin Credential
$UPN = coled@alliedstoneinc.com

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName $UPN

# Set time range
$startdate = (get-date).AddDays(-180).ToString('MM/dd/yyyy')
$enddate = (get-date).ToString('MM/dd/yyyy')

# Look for accounts active, not deactivated
$allusers = @()
$allusers = Get-msoluser -all -enabledfilter EnabledOnly | Select UserPrincipalName

# Search
$loggedonusers = @()
$loggedOnUsers = Search-UnifiedAuditLog -StartDate $startDate -EndDate `
$endDate -Operations UserLoggedIn, PasswordLogonInitialAuthUsingPassword, UserLoginFailed -ResultSize 5000

# Create the list
$inactiveinlastsixmonthsusers = @()
$inactiveinlastsixmonthsusers = $allusers.userprincipalname | where {$loggedonusers.userids -notcontains $_}

# Get a result
Write-output "The following users have not logged in for the last 180 days:"

# Written to screen
Write-Output $inactiveinlastsixmonthsusers

#Export list to CSV
$inactiveinlastsixmonthsusers
$inactiveinlastsixmonthsusers > "C:\Temp\InactiveUsers.csv"

# Remove the session
Disconnect-ExchangeOnline -confirm:$false