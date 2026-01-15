#!/bin/bash

# Build script for Marketplace Demo
# This script builds the JAR file locally that can then be used with Docker

echo "Building Marketplace Demo JAR..."
echo "Make sure Java 21 JDK is installed and JAVA_HOME is set correctly."
echo ""

# Check if Java is available
if ! command -v java &> /dev/null; then
    echo "ERROR: Java is not installed or not in PATH."
    echo "Please install Java 21 JDK and make sure it's in your PATH."
    exit 1
fi

# Check Java version
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
if [ "$JAVA_VERSION" != "21" ]; then
    echo "WARNING: Java version $JAVA_VERSION detected. This project requires Java 21."
fi

# Clean and build the project
./mvnw clean package -DskipTests

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Build successful!"
    echo "JAR file created:"
    ls -la target/*.jar

    # Copy JAR to dist directory for git
    mkdir -p dist
    cp target/*.jar dist/
    echo ""
    echo "✓ JAR copied to dist/ directory"
    echo ""
    echo "You can now commit the JAR and deploy:"
    echo "  git add dist/"
    echo "  git commit -m 'Update JAR'"
    echo "  git push"
    echo "  (then deploy on VPS with docker-compose up --build)"
else
    echo ""
    echo "✗ Build failed!"
    exit 1
fi