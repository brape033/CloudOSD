Write-Host  -ForegroundColor Cyan "Starting SeguraOSD's Custom OSDCloud ..."
Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host  -ForegroundColor Cyan "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

Write-Host  -ForegroundColor Cyan "Importing the sweet OSD PowerShell Module"
Import-Module OSD -Force

$Global:MyOSDCloud = [ordered]@{
    Restart = [bool]$true
    RecoveryPartition = [bool]$true
    WindowsUpdate = [bool]$true
    WindowsUpdateDrivers = [bool]$false
    SetTimeZone = [bool]$true
    ClearDiskConfirm = [bool]$false
    ShutdownSetupComplete = [bool]$false
    SyncMSUpCatDriverUSB = [bool]$false
    CheckSHA1 = [bool]$true
}


#Start OSDCloud ZTI the RIGHT way
Write-Host  -ForegroundColor Cyan "Start OSDCloud with MY Parameters"
Start-OSDCloud -OSLanguage de-DE -OSBuild 23H2 -OSEdition Pro -OSVersion 'Windows 11' -OSActivation Volume -SkipAutopilot:$true -SkipODT:$true -ZTI
#Anything I want  can go right here and I can change it at any time since it is in the Cloud!!!!!
Write-Host  -ForegroundColor Cyan "Starting OSDCloud PostAction ..."
Write-Warning "OSDCloud finished ... the computer is about to restart!"

#Restart from WinPE
Write-Host  -ForegroundColor Cyan "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot