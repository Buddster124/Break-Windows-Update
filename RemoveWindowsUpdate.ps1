##=========================
#Script Created By: Anthony Budd
#Last Edit: Sept 15, 2020

##=========================

#Menu 1
function Show-Menu
{
    param (
        [string]$Title = 'Windows_Update'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' To Disable Windows Update. (**Recomended**)"
    Write-Host "2: Press '2' To Renable Windows Update. (**Will Not Work If You Destroyed Windows Update**)"
    Write-Host "3: Press '3' To Destroy Windows Update. (**Destructive**)"
    Write-Host "Q: Press 'Q' to quit."
}

function Disable-Update {
    param (
    )
    ##Stops windows update services
        Set-Service BITS -StartupType Disabled
        Stop-Service BITS
        Set-Service wuauserv -StartupType Disabled
        Stop-Service wuauserv

    #Takes Ownership Of qmgr.dll
        takeown /F C:\windows\system32\qmgr.dll /A
        icacls C:\windows\system32\qmgr.dll /T /grant administrators:F

    #Take Ownership of wuaueng.dll
        takeown /F C:\windows\system32\wuaueng.dll /A
        icacls C:\windows\system32\wuaueng.dll /T /grant administrators:F

    #Move Files To Store
        New-Item -ItemType "directory" -Path "c:\GHTemp\SystemFiles\WindowsUpdate"
        Move-Item -Path C:\windows\system32\wuaueng.dll -Destination C:\GHTemp\SystemFiles\WindowsUpdate\wuaueng.dll.gh
        Move-Item -Path C:\windows\system32\qmgr.dll -Destination C:\GHTemp\SystemFiles\WindowsUpdate\qmgr.dll.gh 
}

function Remove-Update {
    param (
    )
    ##Stops windows update services
        Set-Service BITS -StartupType Disabled
        Stop-Service BITS
        Set-Service wuauserv -StartupType Disabled
        Stop-Service wuauserv

    ## Breaks Windows Update And BITS

    #Takes Ownership Of qmgr.dll
        takeown /F C:\windows\system32\qmgr.dll /A
        icacls C:\windows\system32\qmgr.dll /T /grant administrators:F

    #Take Ownership of wuaueng.dll
        takeown /F C:\windows\system32\wuaueng.dll /A
        icacls C:\windows\system32\wuaueng.dll /T /grant administrators:F

    #Removes Windows Update Service 
        sc.exe delete "wuauserv"

    #Move Files To Store
        New-Item -ItemType "directory" -Path "c:\GHTemp\SystemFiles\WindowsUpdate"
        Move-Item -Path C:\windows\system32\wuaueng.dll -Destination C:\GHTemp\SystemFiles\WindowsUpdate\wuaueng.dll.gh
        Move-Item -Path C:\windows\system32\qmgr.dll -Destination C:\GHTemp\SystemFiles\WindowsUpdate\qmgr.dll.gh 
}

function Restore-Update {
    param (
    )

    #Move Files To system32
        Move-Item -Path C:\GHTemp\SystemFiles\WindowsUpdate\wuaueng.dll.gh -Destination C:\windows\system32\wuaueng.dll
        Move-Item -Path C:\GHTemp\SystemFiles\WindowsUpdate\qmgr.dll.gh -Destination C:\windows\system32\qmgr.dll

        #Restores Ownership of files
        icacls C:\windows\system32\qmgr.dll /T /Q /C /RESET
        icacls C:\windows\system32\wuaueng.dll /T /Q /C /RESET

        ##Stops windows update services
        Set-Service BITS -StartupType Automatic
        Start-Service BITS
        Set-Service wuauserv -StartupType Automatic
        Start-Service wuauserv

}

 
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         '1' {
             'Disabling Windows Update'
            Disable-Update
         } '2' {
             'Restoring Windows Update'
            Restore-Update
         } '3' {
             'Removing Windows Update'
            Remove-Update
         }
     }
     pause
 }
 until ($selection -eq 'q')