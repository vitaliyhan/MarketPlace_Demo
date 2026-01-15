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

This will create a JAR file in the `target/` directory.

### Running Locally

```bash
./mvnw spring-boot:run
```

## Docker Deployment

### Build Process

1. **Build the JAR locally** using one of the build scripts above
2. **Copy the JAR** to the same directory as the Dockerfile
3. **Build and run** with Docker:

```bash
# Build Docker image
docker build -t marketplace-demo .

# Run with docker-compose
docker-compose up
```

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