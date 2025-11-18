#!/bin/bash

# Deployment script for VMSS instance
# This script should be run on the VMSS instance after SSH-ing in

echo "Starting deployment to VMSS instance..."

# Update system packages
echo "Step 1: Updating system packages..."
sudo apt update

# Install Python 3.7 or higher
echo "Step 2: Installing Python..."
sudo apt install -y python3.10 python3-pip

# Clone the repository
echo "Step 3: Cloning repository..."
cd ~
if [ -d "Voting-App" ]; then
    echo "Repository already exists, pulling latest changes..."
    cd Voting-App
    git pull origin abdulhakeem__Deploy_to_VMSS
else
    git clone https://github.com/bhydemi/Voting-App.git
    cd Voting-App
    git checkout abdulhakeem__Deploy_to_VMSS
fi

# Install and start Redis
echo "Step 4: Installing Redis..."
sudo apt install -y redis-server

# Start Redis service
echo "Step 5: Starting Redis..."
sudo systemctl start redis-server
sudo systemctl enable redis-server

# Verify Redis is running
redis-cli ping

# Install Python dependencies
echo "Step 6: Installing Python dependencies..."
pip3 install -r requirements.txt

# Run the application
echo "Step 7: Starting the Flask application..."
cd azure-vote
nohup python3 main.py > /tmp/flask_app.log 2>&1 &

echo "Deployment complete!"
echo "Application is running on port 8080"
echo "Check logs with: tail -f /tmp/flask_app.log"
