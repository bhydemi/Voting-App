#!/bin/bash
# VMSS Deployment Script - Run this INSIDE the VMSS instance

echo "=========================================="
echo "🚀 VMSS Deployment - Azure Performance"
echo "=========================================="

# Navigate to project or clone it
if [ -d ~/nd081-c4-azure-performance-project-starter ]; then
    echo "✓ Project directory found"
    cd ~/nd081-c4-azure-performance-project-starter
else
    echo "⚠ Project not found. Cloning..."
    cd ~
    git clone https://github.com/bhydemi/Voting-App.git nd081-c4-azure-performance-project-starter
    cd nd081-c4-azure-performance-project-starter
fi

# Fetch latest code
echo ""
echo "📥 Fetching latest code..."
git fetch origin
git checkout abdulhakeem__Deploy_to_VMSS
git pull origin abdulhakeem__Deploy_to_VMSS

echo ""
echo "📝 Latest commits:"
git log -3 --oneline --decorate

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
pip install -r requirements.txt --upgrade --user

# Check if app is already running
if pgrep -f "python.*main.py" > /dev/null; then
    echo ""
    echo "⚠ Application is already running. Stopping it..."
    pkill -f "python.*main.py"
    sleep 2
fi

# Start the application
echo ""
echo "🚀 Starting application..."
cd azure-vote
nohup python main.py > ~/app.log 2>&1 &

# Wait for startup
sleep 3

# Verify it's running
if pgrep -f "python.*main.py" > /dev/null; then
    PID=$(pgrep -f "python.*main.py")
    echo ""
    echo "=========================================="
    echo "✅ SUCCESS! Application is running"
    echo "=========================================="
    echo "Process ID: $PID"
    echo "Log file: ~/app.log"
    echo ""
    echo "📊 Last 10 lines of log:"
    tail -10 ~/app.log
    echo ""
    echo "=========================================="
    echo "🌐 Application URL:"
    echo "   http://172.184.113.253"
    echo ""
    echo "📋 Next Steps:"
    echo "1. Open http://172.184.113.253 in browser"
    echo "2. Click 'Dogs' button 15-20 times"
    echo "3. Click 'Cats' button 15-20 times"
    echo "4. Wait 5-10 minutes for telemetry"
    echo "5. Check Application Insights in Azure Portal"
    echo ""
    echo "📝 Monitor logs:"
    echo "   tail -f ~/app.log"
    echo "=========================================="
else
    echo ""
    echo "=========================================="
    echo "❌ ERROR: Application failed to start"
    echo "=========================================="
    echo "Check logs for errors:"
    echo "   tail -50 ~/app.log"
    echo "=========================================="
    exit 1
fi
