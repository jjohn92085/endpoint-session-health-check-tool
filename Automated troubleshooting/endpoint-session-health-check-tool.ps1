
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
    # New-Item creates a new directory but can also create new files, folder, or registry keys

    if (-not (Test-Path -Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir
        Write-Host "A new directory has been created: $logDir"
    } 

    # Start-transcript creates a text log file that records all commands entered and output shown in console during a powershell session
    # erroraction -stop makes the script stop if there's an error and run what is in the catch {} block

    Start-Transcript -Path "$logDir\SessionLog.txt" -ErrorAction Stop
    Write-Host "A log has been created"

    # The Win32_ComputerSystem checks the PartofDomain true or false (boolean) property to see if the workstation is joined to a domain
    # win_32 is a class that is meant to represent a computer that has setup information like hardware and config
    # You can use Get-CimInstance cmdlet to access partofdomain property on win32_computersystem
    # Get-CmInstance replaced Get-WmiObject and is used to access information from the win32 class 
    #win32 also has operating system, win32_process, win32_service, win32_logicaldisk
    # workgroups are peer to peer and do not have a central server
    # write-host writes information to the console about the script/app

            if ((Get-CimInstance Win32_ComputerSystem).PartOfDomain) {

                Write-Host "This machine is on a domain"
        } 
            else {

                Write-Host "This machine is in a workgroup"
        }

}

catch {

    Write-host "There was a problem creating the log file"

}

# the finally block runs no matter what occurs or happens
# Stop-Transcript stops a transcript that was already started

finally {

    Stop-Transcript -ErrorAction SilentlyContinue

}






