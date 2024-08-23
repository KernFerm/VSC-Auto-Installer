# Visual Studio Code Auto Setup Guide

This guide will help you understand how to use the `VisualStudioCode+Auto-Setup.ps1` script.

## how to download the repo first time users

  - click link to read [**Instructions**](https://www.gitprojects.fnbubbles420.org/how-to-download-repos)

## Prerequisites

- You need to have PowerShell installed on your system. This is used to run the script.
- `Both` MSI are from the official github page of [Official-PowerShell-Github](https://github.com/PowerShell)

# v7.4.5 Release of PowerShell - Latest (recommended)
      choose your recommended pc specs either 32bit or 64bit 

- For Windows `64-bit systems`, [Download 64-Bit Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x64.msi)
- For Windows `32-bit systems`, [Download 32-Bit Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x86.msi)

------

# Visual Studio Code Installation Script with Logging

This PowerShell script automates the download, installation, and configuration of Visual Studio Code on a Windows system. Additionally, it logs each step of the process to a file for troubleshooting and audit purposes.

## Logging Functionality

### Overview

The script includes a logging mechanism to record the installation process. This ensures that every significant action is documented, which can help in diagnosing issues and verifying that the installation steps were executed correctly.

### Log-Message Function

The core of the logging functionality is the `Log-Message` function. This function logs messages to both the console and a log file.

#### Definition

```powershell
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Write-Host $logEntry
    Add-Content -Path $logFilePath -Value $logEntry
}
```

Parameters
- `message:` The message to be logged.

Behavior
- Adds a timestamp to each log entry.
- Outputs the log entry to the console.
- Appends the log entry to a specified log file.

## Log File Path
- The log file is stored in the system's temporary directory and named `VSCodeInstallLog.txt.`
```
$logFilePath = "$env:TEMP\VSCodeInstallLog.txt"
```

## Log Entries
- Each log entry contains a timestamp and a message describing the current step of the script. For example:

```2024-07-18 12:00:00 - Downloading Visual Studio Code installer...
2024-07-18 12:01:00 - Download completed.
2024-07-18 12:02:00 - Running the Visual Studio Code installer...
2024-07-18 12:03:00 - Installation completed.
2024-07-18 12:04:00 - Adding Visual Studio Code to the user PATH...
2024-07-18 12:05:00 - Visual Studio Code path added to user PATH.
2024-07-18 12:06:00 - Cleaning up...
2024-07-18 12:07:00 - Cleanup completed.
2024-07-18 12:08:00 - Installing VS Code extension: ms-python.vscode-pylance...
2024-07-18 12:09:00 - Successfully installed extension: ms-python.vscode-pylance.
2024-07-18 12:10:00 - Installing VS Code extension: ms-python.python...
2024-07-18 12:11:00 - Successfully installed extension: ms-python.python.
2024-07-18 12:12:00 - Installing VS Code extension: ms-python.debugpy...
2024-07-18 12:13:00 - Successfully installed extension: ms-python.debugpy.
```

## Example Usage
- Below is a snippet of how the `Log-Message` function is used within the script:
```
Log-Message "Downloading Visual Studio Code installer..."
try {
    Invoke-WebRequest -Uri $url -OutFile $installerPath -ErrorAction Stop
    Log-Message "Download completed."
} catch {
    Log-Message "Failed to download Visual Studio Code installer: $_"
    exit 1
}

Log-Message "Running the Visual Studio Code installer..."
try {
    Start-Process -FilePath $installerPath -ArgumentList "/verysilent", "/mergetasks=!runcode" -Wait -ErrorAction Stop
    Log-Message "Installation completed."
} catch {
    Log-Message "Failed to run the Visual Studio Code installer: $_"
    exit 1
}

Log-Message "Adding Visual Studio Code to the user PATH..."
try {
    $oldPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)
    if ($oldPath -notlike "*$vsCodePath*") {
        $newPath = "$oldPath;$vsCodePath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::User)
        Log-Message "Visual Studio Code path added to user PATH."
    } else {
        Log-Message "Visual Studio Code path already exists in user PATH."
    }
} catch {
    Log-Message "Failed to update user PATH: $_"
    exit 1
}

Log-Message "Cleaning up..."
try {
    Remove-Item -Path $installerPath -ErrorAction Stop
    Log-Message "Cleanup completed."
} catch {
    Log-Message "Failed to clean up the installer file: $_"
}

# Install VS Code extensions
$extensions = @(
    "ms-python.vscode-pylance",
    "ms-python.python",
    "ms-python.debugpy"
)

function Install-VSCodeExtension {
    param (
        [string]$extension
    )
    Log-Message "Installing VS Code extension: $extension..."
    try {
        & "$vsCodePath\code" --install-extension $extension --force
        Log-Message "Successfully installed extension: $extension."
    } catch {
        Log-Message "Failed to install extension: $extension. Error: $_"
    }
}

foreach ($extension in $extensions) {
    Install-VSCodeExtension -extension $extension
}

Log-Message "VS Code extensions installation completed."

Log-Message "Visual Studio Code installation completed."
```

### Use For VSC PowerShell Script

## Steps

1. **Run as Administrator:** This script needs to be run as an administrator. Right-click on the script and select `Run as administrator`.
2. **Navigate to the Script Location:** Open PowerShell in administrator mode and navigate to the directory where the script is located using the `cd` command.

## How to Run

```
.\VisualStudioCode+Auto-Setup.ps1
```

### If the script does not run, use the following command to change the execution policy, select `Y`, and then run the script again:

```
Set-ExecutionPolicy Bypass -Scope Process
```

- After changing the execution policy, run the script again:

```
.\VisualStudioCode+Auto-Setup.ps1
```

1. **Automatic Download:** The script automatically downloads the latest stable release of Visual Studio Code from the official website.
2. **Installation:** The script runs the installer with user-level installation. It uses the `/verysilent` and `/mergetasks=!runcode` arguments to install VS Code silently and without running the program after installation.
3. **Add to PATH:** The script adds the path to the VS Code executable to the user PATH, allowing you to run `code` from the command line.
4. **Cleanup:** The script removes the installer file after the installation is complete.
5. **Install Extensions:** The script installs the following extensions for Python development:
- ***Pylance*** (`ms-python.vscode-pylance`)
- ***Python*** (`ms-python.python`)
- ***Python Debugger*** (`ms-python.debugpy`)

### Note
- The script checks if the path to the VS Code executable already exists in the user PATH. If it does, it will not add it again.
- Ensure that VS Code is closed before running the script to avoid conflicts during the installation of extensions.











