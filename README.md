# Visual Studio Code Auto Setup Guide

This guide will help you understand how to use the `VisualStudioCode+Auto-Setup(Run_Admin).ps1` script.

## Prerequisites

- You need to have PowerShell installed on your system. This is used to run the script.
- `Both` MSI are from the official github page of [Official-PowerShell-Github](https://github.com/PowerShell)

# v7.4.2 Release of PowerShell

- [64-Bit-Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.msi)
- [32-Bit-Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.msi)

# v7.5.0-preview.3 Release of PowerShell Notes
 - [PowerShell-PreRelease-Notes](https://github.com/PowerShell/PowerShell/releases/tag/v7.5.0-preview.3)

## Steps

1. **Run as Administrator**: This script needs to be run as an administrator. Right-click on the script and select "Run as administrator".

2. **Automatic Download**: The script automatically downloads the latest stable release of Visual Studio Code from the official website.

3. **Installation**: The script runs the installer with system-level installation. It uses the `/verysilent` and `/mergetasks=!runcode` arguments to install VS Code silently and without running the program after installation.

4. **Add to PATH**: The script adds the path to the VS Code executable to the system PATH, allowing you to run `code` from the command line.

5. **Cleanup**: The script removes the installer file after the installation is complete.

## Note

- The script checks if the path to the VS Code executable already exists in the system PATH. If it does, it will not add it again.
