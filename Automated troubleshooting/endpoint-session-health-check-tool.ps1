
# this makes the script require administrator to run and warns the user if not

# Requires -RunAsAdministrator

# Create a log file for outputs with Transcript
# Transcript needs to be started and stopped
# the try command is used to check for errors (also called exceptions)

try {

    # the $env retrieves information from windows and userprofile is the variable's name for the user
    # declares a variable called logDir to be used in the if statement

    $logDir = "$env:USERPROFILE\Desktop\Logs"

    # test-path checks if $logDir path already exists on the desktop then creates the directory if it doesn't
    # -path is used to just tell powershell $logDir is the path like a type of input into test-path
    # New-Item creates a new directory but can also create new files, folder, or registry keys
    # New-Item can create files to like new-item -path "path" -ItemType File

    if (-not (Test-Path -Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir
        Write-Host "A new directory has been created: $logDir"
    }

    # Start-transcript creates a text log file that records all commands entered and output shown in console during a powershell session
    # erroraction -stop makes the script stop if there's an error and run what is in the catch {} block
    # append is added for continuous logging

    Start-Transcript -Path "$logDir\SessionLog.txt" -Append -ErrorAction Stop
    Write-Host "A log has been created"
}

# return is meant to stop the script here if a log file can't be created

catch {

    Write-host "There was a problem creating the log file"

    return

}

try {

    # The Win32_ComputerSystem checks the PartofDomain true or false (boolean) property to see if the workstation is joined to a domain
    # win_32 is a class that is meant to represent a computer that has setup information like hardware and config
    # You can use Get-CimInstance cmdlet to access partofdomain property on win32_computersystem
    # Get-CmInstance replaced Get-WmiObject and is used to access information from the win32 class 
    # win32 also has operating system, win32_process, win32_service, win32_logicaldisk
    # workgroups are peer to peer and do not have a central server
    # write-host writes information to the console about the script/app and in this instance will write to the log

    if ((Get-CimInstance Win32_ComputerSystem).PartofDomain) {

        Write-Host "This machine is on a domain"
    }
    else {

        Write-Host "This machine is in a workgroup"
    }

    }

    catch {

        Write_host "Unable to check if this workstation is part of a domain."
    }


try {

    # the query session object provides information on the active session such as username, mode etc.
    # quser lists all users on the session
    # replace formats the output by adding commas with regex
    # ConvertFrom-Csv creates a powershell object to access the properties such as username

    $session = (quser) -replace '\s{2,}', ',' | ConvertFrom-Csv


    # sessionname is a property of the session object
    # -match tells you true or false if it finds the thing you wanted
    # rdp-tcp is a value stored on the sessioname property that tells you if the session is Windows RDP
    # elseif is used here to provide another condition to check rather than else that says everything else is local
    # this can't check for third party running services since it's just working off the sessionName property

    if ($session.Sessionname -match "rdp-tcp") {
        Write-Host "This is a remote session"
    } 
    elseif ($session.SessionName -match "console") {
        Write-Host "This is a local session"
    }
}

catch {
    Write_host "There was an error checking for a remote session"
}

# check if RDP is enabled on the workstation in case it's needed to remove to server
# Get-ItemPropertyValue retrieves raw value of property from an item such as registry values like names/amounts
# fDenyTSConnections is a windows registry key for for enabling and disabling RDP connections
# 0 means RDP is enabled

try {

    $rdp = Get-ItemPropertyValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' fDenyTSConnections

    if ($rdp -eq 0) {
        Write-Host "RDP is enabled on this machine"
    } else {
        Write-Host "RDP is not enabled on this machine"
    }
    }

catch {
   Write-Host "there was an error checking if RDP is enabled on this machine"
}

# find server name and test connection

try {

   $Path = 'HKCU:\Software\Microsoft\Terminal Server Client\Servers'

   # test-path checks all parts of the path are actually there
   # Get-ChildItem gets the amount or name in a location
   # Select-Object can retrieve properties of an object
   # -ExpandProperty allows you to get strings
   # PSChildName gets you the key name
   # foreach loops through each server and pings it
   # $Server is a variable
   # -ComputerName is a named parameter

   if (Test-Path $Path) {
    $ServerNames = Get-ChildItem $Path | Select-Object -ExpandProperty PSChildName
    if ($ServerNames) {
    foreach ($Server in $ServerNames) {
        $Results = Test-Connection -ComputerName $Server -Count 1 -ErrorAction SilentlyContinue
        Write-Host "Here is outcome $Results"
    }
    else {
        Write-Output "There is no saved server information"
    }
}
   }
}
catch {
      Write-Host "There is no saved server information"
}

# Get-CimInstance is used to get info from windows
# win32_processor is a class with processor details
# Select-Object grabs CPUs coming from Win32_processor
# -ExpandProperty gets the actual value to work with
# LoadPercentage is the cpu usage at the current time
# | means pass it on to next command

Try  {
    Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
}

Catch {

    Write-Host "There was an error trying to check CPU usage"
}

# the finally block runs no matter what occurs or happens
# Stop-Transcript stops start-transcript
# -ErrorAction tells you what to do next
# SilentlyContinue means don't pay attention to any errors

finally {
    Stop-Transcript -ErrorAction SilentlyContinue
}








