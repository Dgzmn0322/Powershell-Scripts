$action = New-ScheduledTaskAction -execute "C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2207.6-0\mpcmdrun.exe -scan -scantype 1" 
$trigger = New-ScheduledTaskTrigger -once -At 2:43pm
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -action $action -trigger $trigger -settings $settings
Register-ScheduledTask DefenderScanat2test -InputObject $task -User "system"