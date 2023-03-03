Connect-ExchangeOnline 

$count = 0
do {
    try {
        $mailboxaccess = Read-Host "Type email address of account the user wants to remove automap from"
        $user = Read-host "Type user email to verify if they have access"
        
        $verification = get-mailboxpermission -Identity $mailboxaccess -user $user -ErrorAction Stop | format-list AccessRights, User, Identity
        $success = $true
    }
catch {
    Write-Host "Mailbox or User does not exist. Check the spelling, email domain and wait 5 seconds please" -ForegroundColor Red
    Start-Sleep -Seconds 5
}

$count++

}until ($count -eq 5 -or $success)
if (-not($success)){exit}

$verification

Write-Host "User has FullAccess to Identity email account" -ForegroundColor Cyan
Read-Host "Press ENTER to Continue"

Remove-MailboxPermission -Identity $mailboxaccess -user $user -accessrights fullaccess -Confirm:$false

Add-MailboxPermission -Identity $mailboxaccess -User $user -AccessRights FullAccess -AutoMapping:$false | format-list AccessRights, User, Identity

Write-Host "User Mailbox has had Automap removed"
Read-Host "Press Enter to exit"
Clear-Host
Exit