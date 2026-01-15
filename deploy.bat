@echo off

REM Deploy script for Marketplace Demo
REM Builds JAR locally and then runs with Docker

echo === Marketplace Demo Deploy Script ===
echo This will build the JAR locally and deploy with Docker
echo.

REM Run the build script
call build.bat
if %errorlevel% equ 0 (
    echo.
    echo === Building and Starting Docker Containers ===
    docker-compose up --build -d
    echo.
    echo ✓ Deployment successful!
    echo Application should be available at http://localhost:8081
) else (
    echo.
    echo ✗ Build failed, deployment cancelled.
    pause
    exit /b 1
)