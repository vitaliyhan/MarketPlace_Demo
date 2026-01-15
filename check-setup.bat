@echo off
echo === Marketplace Demo Setup Check ===

REM Check Java
echo Checking Java installation...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ✗ Java is not installed or not in PATH
    echo Please install Java 21 JDK and run setup-java.bat
    goto :error
) else (
    echo ✓ Java is installed
)

REM Check Java version
for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| findstr "version"') do set JAVA_VER=%%i
echo Java version: %JAVA_VER%
if "%JAVA_VER%"=="21"* (
    echo ✓ Java 21 detected
) else (
    echo ⚠ Java version is not 21. This project requires Java 21.
)

REM Check Maven wrapper
echo.
echo Checking Maven wrapper...
if exist "mvnw.cmd" (
    echo ✓ Maven wrapper found
) else (
    echo ✗ Maven wrapper not found
    goto :error
)

REM Check source code
echo.
echo Checking source code...
if exist "src\main\java" (
    echo ✓ Source code found
) else (
    echo ✗ Source code not found
    goto :error
)

REM Check pom.xml
echo.
echo Checking pom.xml...
if exist "pom.xml" (
    echo ✓ pom.xml found
) else (
    echo ✗ pom.xml not found
    goto :error
)

echo.
echo ✓ All prerequisites check passed!
echo You can now build the project with: build.bat
goto :end

:error
echo.
echo ✗ Setup check failed. Please fix the issues above.
pause
exit /b 1

:end