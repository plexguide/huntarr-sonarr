#!/bin/bash

# Entry point script for Huntarr Docker container
echo "Initializing Huntarr container..."

# Create necessary directories
mkdir -p /config/settings
mkdir -p /config/locks

# Define script directory in a way that works on both Linux and macOS
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SERVICES_DIR="$SCRIPT_DIR/../services"
LOGS_DIR="$SCRIPT_DIR/logs"

# Make sure directories exist
mkdir -p "$SERVICES_DIR"
mkdir -p "$LOGS_DIR"

# Make sure initialization script is executable
chmod +x "$SCRIPT_DIR/initialize_settings.sh"

# Run the initialization script to copy any missing settings files
"$SCRIPT_DIR/initialize_settings.sh"

# Make sure orchestrator script is executable
chmod +x "$SCRIPT_DIR/orchestrator.sh"

# Create service-specific directories and ensure scripts are executable
for service in sonarr radarr readarr lidarr; do
    mkdir -p "$SERVICES_DIR/$service"
    # Make sure the scripts are executable
    if [ -f "$SERVICES_DIR/$service/$service.sh" ]; then
        chmod +x "$SERVICES_DIR/$service/$service.sh"
    else
        echo "Warning: Service script $SERVICES_DIR/$service/$service.sh not found"
    fi
done

# Make sure log management script is executable
chmod +x "$LOGS_DIR/log_manager.sh"

# Start the orchestrator script
echo "Starting Huntarr with multi-thread orchestration..."
exec "$SCRIPT_DIR/orchestrator.sh"