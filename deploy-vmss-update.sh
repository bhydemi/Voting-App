#!/bin/bash

# VMSS Deployment Script
# Run this script INSIDE the VMSS instance after SSH

echo "======================================"
echo "VMSS Deployment - Updated Code"
echo "======================================"

# Navigate to project directory
cd ~/nd081-c4-azure-performance-project-starter || {
    echo "Error: Project directory not found!"
    echo "Cloning repository..."
    cd ~
    git clone https://github.com/bhydemi/Voting-App.git nd081-c4-azure-performance-project-starter
    cd nd081-c4-azure-performance-project-starter
}

# Checkout the Deploy_to_VMSS branch
echo "Checking out abdulhakeem__Deploy_to_VMSS branch..."
git fetch origin
git checkout abdulhakeem__Deploy_to_VMSS
git pull origin abdulhakeem__Deploy_to_VMSS

# Install/upgrade dependencies
echo "Installing dependencies..."
pip install -r requirements.txt --upgrade

# Kill existing Python processes
echo "Stopping existing application..."
pkill -f main.py

# Navigate to azure-vote directory
cd azure-vote

# Start the application
echo "Starting application..."
nohup python main.py > app.log 2>&1 &

echo "======================================"
echo "Deployment Complete!"
echo "Application starting in background..."
echo "Check logs: tail -f ~/nd081-c4-azure-performance-project-starter/azure-vote/app.log"
echo "Test URL: http://172.184.113.253"
echo "======================================"
