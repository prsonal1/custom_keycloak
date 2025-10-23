#!/bin/bash

# Keycloak Custom Theme Setup Script

set -e

echo "🚀 Keycloak Custom Theme Setup"
echo "================================"

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        echo "❌ Docker is not running. Please start Docker and try again."
        exit 1
    fi
    echo "✅ Docker is running"
}

# Function to build the image
build_image() {
    echo "🔨 Building custom Keycloak image..."
    docker build -t keycloak-custom .
    echo "✅ Image built successfully"
}

# Function to start services
start_services() {
    echo "🚀 Starting Keycloak services..."
    docker-compose up -d
    echo "✅ Services started"
    echo ""
    echo "🎨 Setting up default theme..."
    ./set-default-theme.sh &
    echo ""
    echo "🌐 Access Keycloak at: http://localhost:8080"
    echo "👤 Admin username: admin"
    echo "🔑 Admin password: admin123"
}

# Function to stop services
stop_services() {
    echo "🛑 Stopping services..."
    docker-compose down
    echo "✅ Services stopped"
}

# Function to replace custom image
replace_image() {
    if [ -z "$1" ]; then
        echo "❌ Please provide the path to your image file"
        echo "Usage: $0 replace-image /path/to/your/image.png"
        exit 1
    fi
    
    if [ ! -f "$1" ]; then
        echo "❌ Image file not found: $1"
        exit 1
    fi
    
    echo "📸 Replacing custom image..."
    cp "$1" my-theme/login/resources/img/custom-image.png
    echo "✅ Image replaced successfully"
    echo "🔄 Restarting services to apply changes..."
    docker-compose restart keycloak
    echo "✅ Services restarted"
}

# Function to show logs
show_logs() {
    echo "📋 Showing Keycloak logs..."
    docker-compose logs -f keycloak
}

# Function to clean up
cleanup() {
    echo "🧹 Cleaning up..."
    docker-compose down -v
    docker rmi keycloak-custom 2>/dev/null || true
    echo "✅ Cleanup completed"
}

# Main script logic
case "$1" in
    "build")
        check_docker
        build_image
        ;;
    "start")
        check_docker
        start_services
        ;;
    "stop")
        stop_services
        ;;
    "restart")
        stop_services
        start_services
        ;;
    "replace-image")
        replace_image "$2"
        ;;
    "logs")
        show_logs
        ;;
    "cleanup")
        cleanup
        ;;
    "full-setup")
        check_docker
        build_image
        start_services
        ;;
    *)
        echo "Keycloak Custom Theme Setup Script"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  build          Build the custom Keycloak image"
        echo "  start          Start Keycloak services"
        echo "  stop           Stop Keycloak services"
        echo "  restart        Restart Keycloak services"
        echo "  replace-image  Replace the custom image (provide path)"
        echo "  logs           Show Keycloak logs"
        echo "  cleanup        Clean up containers and images"
        echo "  full-setup     Build and start everything"
        echo ""
        echo "Examples:"
        echo "  $0 full-setup"
        echo "  $0 replace-image /path/to/logo.png"
        echo "  $0 logs"
        ;;
esac