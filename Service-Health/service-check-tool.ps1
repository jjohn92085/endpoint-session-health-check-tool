
# this is a tool to check if specific services are running on startup and turn them off as needed

# run as admin

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$geolocation = (Get-Service -Name "Geolocation Service").status

#check if service is running and stop it

if ($geolocation -eq "Running" -or "StartPending" -or "ContinuePending" ) {

    Stop-Service -Name "Geolocation Service"

} 

# service is already stopped

else {

    Write-Host "The Geolocation service is stopped"
}

