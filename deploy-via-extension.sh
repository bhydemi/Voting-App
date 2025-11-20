#!/bin/bash
# Deploy to VMSS without SSH using Azure VM Extension

echo "Deploying to VMSS via Azure Custom Script Extension..."

# Create the deployment script content
cat > /tmp/vmss-remote-deploy.sh << 'EOFSCRIPT'
#!/bin/bash
cd /home/udacityadmin

# Clone or update repo
if [ -d nd081-c4-azure-performance-project-starter ]; then
    cd nd081-c4-azure-performance-project-starter
    git fetch origin
    git checkout abdulhakeem__Deploy_to_VMSS
    git pull origin abdulhakeem__Deploy_to_VMSS
else
    git clone https://github.com/bhydemi/Voting-App.git nd081-c4-azure-performance-project-starter
    cd nd081-c4-azure-performance-project-starter
    git checkout abdulhakeem__Deploy_to_VMSS
fi

# Install dependencies
pip3 install -r requirements.txt --user

# Stop old app
pkill -f "python.*main.py"

# Start new app
cd azure-vote
nohup python3 main.py > /home/udacityadmin/app.log 2>&1 &

echo "Deployment complete!" > /home/udacityadmin/deployment-status.txt
date >> /home/udacityadmin/deployment-status.txt
EOFSCRIPT

# Upload and run the script
az vmss extension set \
  --resource-group acdnd-c4-project \
  --vmss-name udacity-vmss \
  --name CustomScript \
  --publisher Microsoft.Azure.Extensions \
  --protected-settings "{\"fileUris\": [\"https://raw.githubusercontent.com/bhydemi/Voting-App/abdulhakeem__Deploy_to_VMSS/vmss-deploy.sh\"],\"commandToExecute\": \"bash vmss-deploy.sh\"}"

echo ""
echo "✅ Deployment initiated!"
echo "This will take 2-3 minutes to complete."
echo ""
echo "Check status with:"
echo "az vmss extension list --resource-group acdnd-c4-project --vmss-name udacity-vmss --output table"
