@echo off
REM Batch script to set up Java 21 JDK environment variables
REM Run this as Administrator after installing JDK 21

echo Setting up Java 21 JDK environment variables...

REM Check for common Java installation paths
set "JAVA_HOME="
if exist "C:\Program Files\Java\jdk-21\bin\java.exe" (
    set "JAVA_HOME=C:\Program Files\Java\jdk-21"
) else if exist "C:\Program Files\Eclipse Adoptium\jdk-21.*\bin\java.exe" (
    for /d %%i in ("C:\Program Files\Eclipse Adoptium\jdk-21.*") do set "JAVA_HOME=%%i"
)

if "%JAVA_HOME%"=="" (
    echo ERROR: Could not find Java 21 JDK installation.
    echo Please check that Java 21 JDK is installed in one of these locations:
    echo   C:\Program Files\Java\jdk-21\
    echo   C:\Program Files\Eclipse Adoptium\jdk-21.*\
    echo.
    echo Or manually set JAVA_HOME in this script.
    pause
    exit /b 1
)

echo Found Java installation at: %JAVA_HOME%

REM Set JAVA_HOME system environment variable
setx JAVA_HOME "%JAVA_HOME%" /M
if %errorlevel% neq 0 (
    echo ERROR: Failed to set JAVA_HOME. Run this script as Administrator.
    pause
    exit /b 1
)
echo Set JAVA_HOME to: %JAVA_HOME%

REM Add Java bin to PATH if not already there
set "JAVA_BIN=%JAVA_HOME%\bin"
powershell -Command "if ($env:Path -notlike '*%JAVA_BIN%*') { $newPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';%JAVA_BIN%'; [Environment]::SetEnvironmentVariable('Path', $newPath, 'Machine'); exit 0 } else { exit 1 }"
if %errorlevel% equ 0 (
    echo Added %JAVA_BIN% to PATH
) else (
    echo Java bin path already in PATH
)

echo.
echo Java setup complete! Please restart your command prompt and run:
echo   java -version
echo   javac -version
echo.
echo Then you can build your project with: build.bat
pause