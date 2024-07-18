# Function to check if the script is running as an administrator
function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to re-run the script with elevated privileges
function Run-AsAdmin {
    if (-not (Test-IsAdmin)) {
        $scriptPath = $MyInvocation.MyCommand.Path
        Start-Process powershell -ArgumentList "-File `"$scriptPath`"" -Verb RunAs
        exit
    }
}

# Check and re-run as admin if necessary
Run-AsAdmin

# Define the URL for the VS Code installer
$url = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"

# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\VSCodeSetup.exe"

# Define the path to the VS Code executable
$vsCodePath = "C:\Program Files\Microsoft VS Code\bin"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "$timestamp - $message"
}

# Download the installer
Log-Message "Downloading Visual Studio Code installer..."
try {
    Invoke-WebRequest -Uri $url -OutFile $installerPath -ErrorAction Stop
    Log-Message "Download completed."
} catch {
    Log-Message "Failed to download Visual Studio Code installer: $_"
    exit 1
}

# Run the installer with system-level installation
Log-Message "Running the Visual Studio Code installer..."
try {
    Start-Process -FilePath $installerPath -ArgumentList "/verysilent", "/mergetasks=!runcode" -Wait -ErrorAction Stop
    Log-Message "Installation completed."
} catch {
    Log-Message "Failed to run the Visual Studio Code installer: $_"
    exit 1
}

# Check if VS Code was installed successfully
if (-Not (Test-Path "$vsCodePath\code.cmd")) {
    Log-Message "Visual Studio Code installation failed or VS Code executable not found."
    exit 1
}

# Add VS Code to the system PATH
Log-Message "Adding Visual Studio Code to the system PATH..."
try {
    $oldPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
    if ($oldPath -notlike "*$vsCodePath*") {
        $newPath = "$oldPath;$vsCodePath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)
        Log-Message "Visual Studio Code path added to system PATH."
    } else {
        Log-Message "Visual Studio Code path already exists in system PATH."
    }
} catch {
    Log-Message "Failed to update system PATH: $_"
    exit 1
}

# Clean up the installer file
Log-Message "Cleaning up..."
try {
    Remove-Item -Path $installerPath -ErrorAction Stop
    Log-Message "Cleanup completed."
} catch {
    Log-Message "Failed to clean up the installer file: $_"
}

Log-Message "Visual Studio Code installation completed."
