# Description
  This contains a power-shell script to disable, break, or restore windows update.

# How to use
  1. Save the file to your computer.
  2. Open an administrator powershell window.
  3. Navigate to where the script is saved. (cd C:\my_path\yada_yada\)
  4. Run the script. (.\RemoveWindowsUpdate.ps1)
  
   What each option does.
   1. Disable: This will disable BITS / wuauserv on start-up and it will stop the service. It will also move/rename qmgr.dll and wuaueng.dll.
   2. Renable: This will revert what the disable option did.
   3. Destroy: This will completly remove qmgr.dll and wuaueng.dll aswell as remove the windows update service completely.

# Roadmap
  1. Create a GUI For the script and pack it into an exe.
