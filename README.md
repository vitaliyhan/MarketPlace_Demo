# Marketplace Demo

A Spring Boot-based marketplace application.

## Prerequisites

- **Java 21 JDK** - Required for building the project
- Maven (or use the included Maven wrapper)

### Installing Java 21 JDK

#### Windows
1. Download JDK 21 from Oracle: https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html
2. Choose the Windows x64 Installer (`.exe` file)
3. Run the installer and follow the setup wizard
4. After installation, run the setup script:
   ```batch
   # Run as Administrator (batch version)
   setup-java.bat
   ```
   Or use PowerShell:
   ```powershell
   # Run as Administrator
   .\setup-java.ps1
   ```
   Or manually set environment variables:
   - Set `JAVA_HOME` to `C:\Program Files\Java\jdk-21`
   - Add `%JAVA_HOME%\bin` to your PATH

#### Linux/Mac
Install using your package manager or download from Oracle.

Verify installation:
```bash
java -version  # Should show Java 21
javac -version # Should show Java 21 compiler
```

**Quick Setup Check:**
Before building, run the setup check script:

**Windows:**
```batch
check-setup.bat
```

**Linux/Mac:**
```bash
./check-setup.sh
```

## Local Development

### Building the JAR

To build the application locally:

**Windows:**
```batch
build.bat
```

**Linux/Mac:**
```bash
./build.sh
```

This creates a JAR file in the `target/` directory and copies it to `dist/` for committing to git.

### Running Locally

```bash
./mvnw spring-boot:run
```

## Docker Deployment

### Repository-Based Deployment

The JAR file is committed to the `dist/` directory in the git repository. When you deploy to your VPS:

1. **Clone/pull the repository** on your VPS
2. **Run Docker directly** (no build step needed on VPS):

```bash
# On your VPS - after cloning the repo
docker-compose up --build -d
```

**Note**: The JAR in `dist/` is automatically updated when you run `build.bat` or `build.sh` locally.

### Alternative: Local Build Process

If you need to rebuild the JAR:

1. **Build locally** using build scripts
2. **Copy JAR to dist/**: `cp target/*.jar dist/`
3. **Commit and push** to git
4. **Deploy on VPS** as above

### Quick Deploy (Build + Docker)

For a complete build and deploy process:

**Windows:**
```batch
deploy.bat
```

**Linux/Mac:**
```bash
./deploy.sh
```

### Alternative: Build and Run in One Command

```bash
# Build JAR and then build/run Docker
./build.sh && docker-compose up --build
```

## Configuration

- Copy `env.example` to `.env` and configure your environment variables
- Database configuration is in `application.properties`
- The application runs on port 8081

## Project Structure

- `src/main/java/` - Java source code
- `src/main/resources/` - Application resources and templates
- `src/main/resources/static/` - Static assets (CSS, images)
- `src/main/resources/templates/` - FreeMarker templates