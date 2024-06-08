# Define the URL for the VS Code installer
$url = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"

# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\VSCodeSetup.exe"

# Download the installer
Write-Host "Downloading Visual Studio Code installer..."
Invoke-WebRequest -Uri $url -OutFile $installerPath

# Run the installer with system-level installation
Write-Host "Running the Visual Studio Code installer..."
Start-Process -FilePath $installerPath -ArgumentList "/verysilent", "/mergetasks=!runcode" -Wait

# Define the path to the VS Code executable
$vsCodePath = "C:\Program Files\Microsoft VS Code\bin"

# Add VS Code to the system PATH
Write-Host "Adding Visual Studio Code to the system PATH..."
$oldPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
if ($oldPath -notlike "*$vsCodePath*") {
    $newPath = "$oldPath;$vsCodePath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)
    Write-Host "Visual Studio Code path added to system PATH."
} else {
    Write-Host "Visual Studio Code path already exists in system PATH."
}

# Clean up the installer file
Write-Host "Cleaning up..."
Remove-Item -Path $installerPath

Write-Host "Visual Studio Code installation completed."
