$module = Get-InstalledModule -name ExchangeOnlineManagement
if($module.count -eq 0)
{
    Write-Host "Exchange Online Management is not available" -ForegroundColor Yellow
    $confirm = Read-Host "Do you want to install the module? [Y] Yes [N] No"
    if($Confirm -match "[yY]")
    {
        Install-Module -name ExchangeOnlineManagement -AllowClobber
    
    }
    else
    {
        Write-Host "Exhcange Online Management Powershell Module is required for this script. Please install module using the install-module exchangeonlinemanagement or retry this script and type y" -ForegroundColor Cyan
    }
}

# Connect to Exchange Online
$cred = get-credential
Connect-ExchangeOnline -credential $cred

# Count starts at 0
$count = 0
# Do statement will run try and catch staments
do {
    # Try statement will have user input from Read-Host asking which mailbox the user will want to remove the Automap from
    try {
        $mailboxaccess = Read-Host "Type email address of account the user wants to remove automap from"
        $user = Read-host "Type user email to verify if they have access"
        
        $verification = get-mailboxpermission -Identity $mailboxaccess -user $user -ErrorAction Stop | format-list AccessRights, User, Identity
        $success = $true
    }
    # Catch statement will catch any error output from $verification and write host error message and wait 5 seconds
catch {
    Write-Host "Mailbox or User does not exist. Check the spelling, email domain and wait 5 seconds please" -ForegroundColor Red
    Start-Sleep -Seconds 5
}

# Count will increment each do attempt
$count++

# Untill either a success is made or equals 5
}until ($count -eq 5 -or $success)
# If 5 attempts are made and there is no sucess, Powershell window will exit
if (-not($success)){exit}

# Runs variable with $mailboxaccess and $user access and format a list containing AccessRights, User and Identity
$verification

# Will write to host and ask them to press ENTER to continue
Write-Host "User has FullAccess to Identity email account" -ForegroundColor Cyan
Read-Host "Press ENTER to Continue"

# Removes mailbox permission from users account and suppresses confirmation
Remove-MailboxPermission -Identity $mailboxaccess -user $user -accessrights fullaccess -Confirm:$false

# Adds mailbox permission back but keeps AutoMapping false which will make the shared mailbox dissapear within an hour in Outlook
Add-MailboxPermission -Identity $mailboxaccess -User $user -AccessRights FullAccess -AutoMapping:$false | format-list AccessRights, User, Identity

# Displays message to host and asks them to press enter to leave Powershell
Write-Host "User Mailbox has had Automap removed"
Read-Host "Press Enter to exit"
Clear-Host
Exit