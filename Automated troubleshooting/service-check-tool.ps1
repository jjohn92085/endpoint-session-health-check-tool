
# this is a tool to check if specific services are running on startup and turn them off as needed
# | sends command to the next command
# name is internal name
# startype tells you if it's automatic, disabled etc.
# Status is running or stopped

$nexHealth = (Get-Service -Name "NexHealth").status

# if Nexhealth is not running

if ($nexHealth = Stopped) {

}

