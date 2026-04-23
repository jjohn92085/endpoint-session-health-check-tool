
# this is a tool to check if specific services are running on startup and turn them off as needed

#run in elevation

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$geolocation = (Get-Service -Name "Geolocation Service").status

if ($geolocation -eq "Running" ) {

    Stop-Service -Name "Geolocation Service"

}

elseif ($geolocation)
