# Connect to Exchange Powershell Cmdlet
Connect-ExchangeOnline

# Checks current retention policy for user
Get-mailbox -Identity "Courtney Chambers" | ft RetentionPolicy

#Force Mailbox to run retention policy
Start-ManagedFolderAssistant -Identity "Courtney Chambers"