#!/bin/bash

# Deploy script for Marketplace Demo
# Builds JAR locally and then runs with Docker

echo "=== Marketplace Demo Deploy Script ==="
echo "This will build the JAR locally and deploy with Docker"
echo ""

# Run the build script
if ./build.sh; then
    echo ""
    echo "=== Building and Starting Docker Containers ==="
    docker-compose up --build -d
    echo ""
    echo "✓ Deployment successful!"
    echo "Application should be available at http://localhost:8081"
else
    echo ""
    echo "✗ Build failed, deployment cancelled."
    exit 1
fi