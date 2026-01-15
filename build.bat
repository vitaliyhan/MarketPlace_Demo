@echo off

REM Build script for Marketplace Demo
REM This script builds the JAR file locally that can then be used with Docker

echo Building Marketplace Demo JAR...
echo Make sure Java 21 JDK is installed and JAVA_HOME is set correctly.
echo.

REM Check if Java is available
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH.
    echo Please install Java 21 JDK and make sure it's in your PATH.
    pause
    exit /b 1
)

REM Check Java version (simplified check)
for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| findstr "version"') do set JAVA_VER=%%i
echo Java version detected: %JAVA_VER%
echo This project requires Java 21.
echo.

REM Clean and build the project
call mvnw.cmd clean package -DskipTests

REM Check if build was successful
if %errorlevel% equ 0 (
    echo.
    echo ✓ Build successful!
    echo JAR file created:
    for %%f in (target\*.jar) do echo   %%f
    echo.
    echo You can now use this JAR with Docker:
    echo   docker build -t marketplace-demo .
    echo   docker-compose up
) else (
    echo.
    echo ✗ Build failed!
    pause
    exit /b 1
)