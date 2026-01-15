# PowerShell script to set up Java 21 JDK environment variables
# Run this after installing JDK 21

Write-Host "Setting up Java 21 JDK environment variables..." -ForegroundColor Green

# Find Java installation (common locations)
$javaPaths = @(
    "C:\Program Files\Java\jdk-21\bin",
    "C:\Program Files\Java\jdk-21.0.*\bin",
    "C:\Program Files\Eclipse Adoptium\jdk-21*\bin",
    "$env:USERPROFILE\.jdks\jdk-21*\bin"
)

$javaHome = $null
foreach ($path in $javaPaths) {
    $resolvedPath = Resolve-Path $path -ErrorAction SilentlyContinue
    if ($resolvedPath) {
        $javaHome = Split-Path $resolvedPath.Path -Parent
        break
    }
}

if (-not $javaHome) {
    Write-Host "Could not find Java 21 JDK installation. Please check the installation path." -ForegroundColor Red
    Write-Host "Common locations:"
    $javaPaths | ForEach-Object { Write-Host "  $_" }
    exit 1
}

Write-Host "Found Java installation at: $javaHome" -ForegroundColor Yellow

# Set JAVA_HOME
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "Machine")
Write-Host "Set JAVA_HOME to: $javaHome" -ForegroundColor Green

# Add to PATH if not already there
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$javaBinPath = Join-Path $javaHome "bin"

if ($currentPath -notlike "*$javaBinPath*") {
    $newPath = "$currentPath;$javaBinPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Host "Added $javaBinPath to PATH" -ForegroundColor Green
} else {
    Write-Host "Java bin path already in PATH" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Java setup complete! Please restart your command prompt/terminal and run:" -ForegroundColor Green
Write-Host "  java -version" -ForegroundColor Cyan
Write-Host "  javac -version" -ForegroundColor Cyan
Write-Host ""
Write-Host "Then you can build your project with: build.bat" -ForegroundColor Green