# Define the URL for the VS Code installer
$url = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"

# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\VSCodeSetup.exe"

# Define the path to the VS Code executable
$vsCodePath = "$env:USERPROFILE\AppData\Local\Programs\Microsoft VS Code\bin"

# Define the path to the log file
$logFilePath = "$env:TEMP\VSCodeInstallLog.txt"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Write-Host $logEntry
    Add-Content -Path $logFilePath -Value $logEntry
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

# Run the installer with user-level installation
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

# Add VS Code to the user PATH
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

# Clean up the installer file
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
    "ms-python.debugpy",
    "ms-azuretools.vscode-docker",
    "NilsSoderman.batch-runner",
    "oven.bun-vscode",
    "VisualStudioExptTeam.vscodeintellicode",
    "VisualStudioExptTeam.intellicode-api-usage-examples",
    "ms-vscode.live-server",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode.vscode-speech",
    "rust-lang.rust-analyzer",
    "mechatroner.rainbow-csv",
    "ms-vscode.powershell",
    "ms-vscode-remote.remote-containers",
    "GitHub.copilot",
    "GitHub.copilot-chat"
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
