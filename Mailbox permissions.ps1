
Add-MailboxPermission -Identity "daisyd@alliedstoneinc.com" -User "guse@alliedstoneinc.com" -AccessRights fullaccess -InheritanceType All -AutoMapping $true

Remove-MailboxPermission -Identity "aisconferenceroom" -user "coled@asisherweb.onmicrosoft.com" -accessrights fullaccess -inheritancetype all