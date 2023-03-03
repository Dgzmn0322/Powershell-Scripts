# This will delete all local printers and network printers 
Get-WmiObject -Class Win32_Printer | foreach{$_.delete()}