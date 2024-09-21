# 💻 Visual Studio Code Auto Setup Guide

This guide will help you understand how to use the `VisualStudioCode+Auto-Setup.ps1` script to automate the installation and configuration of **Visual Studio Code** on Windows 🪟.

---

## 📥 How to Download the Repo (First-Time Users)

Click the link to read [**Instructions**](https://www.gitprojects.fnbubbles420.org/how-to-download-repos) 📄.

---

## ⚙️ Prerequisites

- **PowerShell** must be installed on your system. You will use it to run the setup script.
- Both MSIs are from the official GitHub page of [Official PowerShell GitHub](https://github.com/PowerShell).

### 🔧 v7.4.5 Release of PowerShell (Latest Recommended Version)

- For **Windows 64-bit systems**: [Download 64-Bit Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x64.msi)
- For **Windows 32-bit systems**: [Download 32-Bit Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x86.msi)

---

## ⚙️ Visual Studio Code Installation Script with Logging

This **PowerShell script** automates the download, installation, and configuration of **Visual Studio Code**. It also logs every step for troubleshooting and auditing purposes 📑.

---

### 📝 Logging Functionality

The script includes a **logging mechanism** to record the installation process, ensuring that every significant action is documented.

---

### 🛠️ Log-Message Function

The core of the logging functionality is the `Log-Message` function. It logs messages to both the console and a log file.

#### Definition

```
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

### 📝 Log File Path

The log file is stored in the system's temporary directory as `VSCodeInstallLog.txt`.


$logFilePath = "$env:TEMP\VSCodeInstallLog.txt"

### 📝 Log Entries
- Each log entry contains a `timestamp` and a description of the current step of the script. Example log entries:

```
2024-07-18 12:00:00 - Downloading Visual Studio Code installer...
2024-07-18 12:01:00 - Download completed.
2024-07-18 12:02:00 - Running the Visual Studio Code installer...
2024-07-18 12:03:00 - Installation completed.
2024-07-18 12:08:00 - Installing VS Code extension: ms-python.vscode-pylance...
2024-07-18 12:09:00 - Successfully installed extension: ms-python.vscode-pylance.
```

### 🛠️ Example Usage
Here’s how the Log-Message function is used within the script:

```
Log-Message "Downloading Visual Studio Code installer..."
try {
    Invoke-WebRequest -Uri $url -OutFile $installerPath -ErrorAction Stop
    Log-Message "Download completed."
} catch {
    Log-Message "Failed to download Visual Studio Code installer: $_"
    exit 1
}
```

### 🚀 Steps to Use the Script

1. **Run as Administrator**: Right-click on the script and select **Run as administrator** 🔒.
2. **Navigate to Script Location**: Open PowerShell as admin and navigate to the script directory using `cd`.

---

### 🏃 How to Run

To execute the script, run:

```
.\VisualStudioCode+Auto-Setup.ps1
```

- If the script does not run, change the execution policy by running:

```
Set-ExecutionPolicy Bypass -Scope Process
```
- if message pops up click `Y` then enter
- Then, run the script again:

```
.\VisualStudioCode+Auto-Setup.ps1
```

### 🛠️ Script Functionality

- **Automatic Download**: The script downloads the latest stable release of **Visual Studio Code** from the official website.
- **Silent Installation**: It runs the installer with silent arguments, allowing installation without user interaction.
- **Add to PATH**: The script adds the VS Code executable to the user PATH, allowing you to run `code` from the command line.
- **Cleanup**: After installation, the script removes the installer file to free up space.
- **Extension Installation**: The script installs the following extensions for Python development:
  - **Pylance** (`ms-python.vscode-pylance`)
  - **Python** (`ms-python.python`)
  - **Python Debugger** (`ms-python.debugpy`)

---

### ⚠️ Notes

- Ensure that **Visual Studio Code** is closed before running the script to avoid conflicts during extension installation.
- The script will **not add VS Code to the PATH** if it already exists there.
