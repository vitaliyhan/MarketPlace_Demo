#!/bin/bash

echo "=== Marketplace Demo Setup Check ==="

# Check Java
echo "Checking Java installation..."
if ! command -v java &> /dev/null; then
    echo "✗ Java is not installed or not in PATH"
    echo "Please install Java 21 JDK"
    exit 1
else
    echo "✓ Java is installed"
fi

# Check Java version
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
echo "Java version: $JAVA_VERSION"
if [ "$JAVA_VERSION" = "21" ]; then
    echo "✓ Java 21 detected"
else
    echo "⚠ Java version is not 21. This project requires Java 21."
fi

# Check Maven wrapper
echo ""
echo "Checking Maven wrapper..."
if [ -f "mvnw" ]; then
    echo "✓ Maven wrapper found"
else
    echo "✗ Maven wrapper not found"
    exit 1
fi

# Check source code
echo ""
echo "Checking source code..."
if [ -d "src/main/java" ]; then
    echo "✓ Source code found"
else
    echo "✗ Source code not found"
    exit 1
fi

# Check pom.xml
echo ""
echo "Checking pom.xml..."
if [ -f "pom.xml" ]; then
    echo "✓ pom.xml found"
else
    echo "✗ pom.xml not found"
    exit 1
fi

echo ""
echo "✓ All prerequisites check passed!"
echo "You can now build the project with: ./build.sh"