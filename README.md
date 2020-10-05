# Description
  This contains a power-shell script to disable, break, or restore windows update.

# How to use
  1. Save RemoveWindowsUpdate.ps1 to your computer.
  2. Open an administrator powershell window.
  3. Navigate to where the script is saved. (cd C:\my_path\yada_yada\)
  4. Run the script. (.\RemoveWindowsUpdate.ps1)
  
   What each option does.
   1. Disable: This will disable BITS / wuauserv on start-up and it will stop the service. It will also move/rename qmgr.dll and wuaueng.dll.
   2. Renable: This will revert what the disable option did.
   3. Destroy: This will completly remove qmgr.dll and wuaueng.dll aswell as remove the windows update service completely.
   
   # Notes
   1. The dll files for windows update and bits are moved to "C:\GHTemp\SystemFiles\WindowsUpdate\". If this directory is removed after disabling windows update, You will be unable to restore windows update.
   2. I would highly recommend making a restore point before running this script.
   3. If it complains about script policy you can ether use this tool "https://github.com/Buddster124/Powershell-Execution-Policy-Changer" or you can turn on script bypass with the following command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine". You can revert this change after running the script by doing the following command "Set-ExecutionPolicy -ExecutionPolicy Default -Scope LocalMachine".

# Roadmap
  1. Create a GUI For the script and pack it into an exe.
