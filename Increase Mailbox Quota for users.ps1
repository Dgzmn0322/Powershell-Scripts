# Use below script to increase mailbox quota for users
Connect-ExchangeOnline
Get-MailboxStatistics –Identity megans@alliedstoneinc.com | Select TotalItemSize 
Get-Mailbox –Identity megans@alliedstoneinc.com | Select *quota 
Set-Mailbox –Identity megans@alliedstoneinc.com -IssueWarningQuota 50GB -ProhibitSendQuota 50GB -ProhibitSendReceiveQuota 50GB 