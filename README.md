# Visual Studio Code Auto Setup Guide

This guide will help you understand how to use the `VisualStudioCode+Auto-Setup(Run_Admin).ps1` script.

## how to download the repo first time users

  - click link to read [**Instructions**](https://www.fnbubbles420.org/Instructions-On-How-To-Download-Repo)

## Prerequisites

- You need to have PowerShell installed on your system. This is used to run the script.
- `Both` MSI are from the official github page of [Official-PowerShell-Github](https://github.com/PowerShell)

# v7.4.3 Release of PowerShell - Latest (recommended)
      choose your recommended pc specs either 32bit or 64bit 

- [64-Bit-Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/PowerShell-7.4.3-win-x64.msi)
- [32-Bit-Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/PowerShell-7.4.3-win-x86.msi)

------

### Use For VSC PowerShell Script

## Steps

1. **Run as Administrator**: This script needs to be run as an administrator. Right-click on the script and select "Run as administrator".

2. `cd` the path of the **.ps1** into `powershell` in `admin mode`

## how to run
```
.\VisualStudioCode+Auto-Setup(Run_Admin).ps1
```
### if usage doesnt work use this first 
```
Set-ExecutionPolicy Bypass -Scope Process
```
then repeat the process you can leave powershell open in admin mode to do this you dont have to close it

3. **Automatic Download**: The script automatically downloads the latest stable release of Visual Studio Code from the official website.

4. **Installation**: The script runs the installer with system-level installation. It uses the `/verysilent` and `/mergetasks=!runcode` arguments to install VS Code silently and without running the program after installation.

5. **Add to PATH**: The script adds the path to the VS Code executable to the system PATH, allowing you to run `code` from the command line.

6. **Cleanup**: The script removes the installer file after the installation is complete.

## Note

- The script checks if the path to the VS Code executable already exists in the system PATH. If it does, it will not add it again.
