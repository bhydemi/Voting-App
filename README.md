# Azure Voting Application with Performance Monitoring

A cloud-native voting application deployed on Azure with comprehensive monitoring, autoscaling, and automated remediation capabilities.

## Overview

This project demonstrates enterprise-level application deployment on Azure with:
- **Application Insights** for telemetry and performance monitoring
- **Auto-scaling** for both VM Scale Sets and Kubernetes clusters
- **Azure Automation** with RunBooks for automated incident response
- **Container orchestration** using Azure Kubernetes Service (AKS)
- **Custom telemetry** tracking user interactions

## Tech Stack

**Frontend:**
- Python Flask application
- Redis for session/vote storage
- Application Insights SDK

**Infrastructure:**
- Azure VM Scale Sets (VMSS)
- Azure Kubernetes Service (AKS)
- Azure Container Registry (ACR)
- Azure Application Insights
- Azure Log Analytics
- Azure Automation

**Monitoring & Alerts:**
- OpenCensus for distributed tracing
- Custom event telemetry
- CPU-based autoscaling rules
- Alert-driven RunBook automation

## Architecture

The application can be deployed in two configurations:

### 1. VM Scale Set Deployment
- Frontend Flask app on VMSS instances
- Nginx load balancer
- Redis running on same instances
- Auto-scaling based on CPU metrics
- Application Insights monitoring

### 2. AKS Deployment
- Multi-container setup (frontend + Redis backend)
- Horizontal Pod Autoscaler (HPA)
- Container images in ACR
- Kubernetes-based orchestration

## Features

- **Real-time Voting:** Users can vote for Cats or Dogs
- **Performance Monitoring:** Track application health and user behavior
- **Custom Telemetry:** Capture user interactions and vote patterns
- **Auto-scaling:** Automatically scale based on load
- **Automated Remediation:** RunBooks resolve performance issues automatically
- **Distributed Tracing:** End-to-end request tracking

## Prerequisites

- Azure subscription
- Azure CLI
- Docker (for local development and AKS deployment)
- kubectl (for AKS deployment)
- Python 3.6+

## Quick Start

### Local Development

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd azure-performance
   ```

2. **Install Redis:**
   ```bash
   # macOS
   brew install redis
   redis-server

   # Linux
   sudo apt-get install redis-server
   redis-server
   ```

3. **Install dependencies:**
   ```bash
   cd azure-vote
   pip install -r requirements.txt
   ```

4. **Run the application:**
   ```bash
   python main.py
   ```

5. **Access the app:** http://localhost:8080

### Deploy to Azure VMSS

1. **Set up Azure resources:**
   ```bash
   az login
   chmod +x setup-script.sh
   ./setup-script.sh
   ```

2. **Configure Application Insights** in Azure Portal

3. **Deploy the application:**
   ```bash
   chmod +x deploy-to-vmss.sh
   ./deploy-to-vmss.sh
   ```

### Deploy to AKS

1. **Create AKS cluster:**
   ```bash
   chmod +x create-cluster.sh
   ./create-cluster.sh
   ```

2. **Build and push Docker images:**
   ```bash
   docker-compose build
   az acr create --resource-group acdnd-c4-project --name <your-acr-name> --sku Basic
   az acr login --name <your-acr-name>
   docker tag azure-vote-front:v1 <your-acr-name>.azurecr.io/azure-vote-front:v1
   docker push <your-acr-name>.azurecr.io/azure-vote-front:v1
   ```

3. **Deploy to AKS:**
   ```bash
   kubectl apply -f azure-vote-all-in-one-redis.yaml
   kubectl get service azure-vote-front --watch
   ```

4. **Enable autoscaling:**
   ```bash
   kubectl autoscale deployment azure-vote-front --cpu-percent=70 --min=1 --max=10
   ```

## Monitoring

### Application Insights

The application sends telemetry data to Azure Application Insights:

- **Request tracking:** HTTP requests and response times
- **Custom events:** User votes (Cats vs Dogs)
- **Performance metrics:** CPU, memory, network usage
- **Distributed tracing:** End-to-end request flows
- **Exception tracking:** Error logging and diagnostics

### Viewing Metrics

Navigate to Application Insights in Azure Portal:
- **Metrics:** View performance counters
- **Logs:** Query telemetry with KQL
- **Application Map:** Visualize dependencies
- **Live Metrics:** Real-time monitoring

## Auto-scaling

### VMSS Auto-scaling

Configured in Azure Portal under VMSS → Scaling:
- **Scale out:** When CPU > 70%
- **Scale in:** When CPU < 25%
- **Min instances:** 2
- **Max instances:** 4

### AKS Auto-scaling

Horizontal Pod Autoscaler (HPA):
```bash
kubectl get hpa
kubectl describe hpa azure-vote-front
```

## Automated Remediation

Azure Automation RunBook automatically resolves performance issues:
- Triggered by Azure Monitor alerts
- PowerShell-based remediation scripts
- Manages VMSS scaling and health checks

## Project Structure

```
├── azure-vote/              # Flask application
│   ├── main.py             # Application with telemetry
│   ├── Dockerfile          # Container image definition
│   └── templates/          # HTML templates
├── azure-vote.yaml         # AKS deployment manifest
├── azure-vote-all-in-one-redis.yaml  # Complete AKS deployment
├── docker-compose.yaml     # Local multi-container setup
├── create-cluster.sh       # AKS cluster creation
├── setup-script.sh         # VMSS creation
├── deploy-to-vmss.sh       # VMSS deployment
├── Scale-VMSS-Runbook.ps1  # Automation runbook
└── cloud-init.txt          # VMSS initialization
```

## Environment Variables

Required for Application Insights (set in `main.py`):
- `APPINSIGHTS_INSTRUMENTATIONKEY`: Your Application Insights key

For AKS deployment:
- `REDIS`: Redis server hostname
- `REDIS_PWD`: Redis password (if required)

## Contributing

This is a portfolio project. Feel free to fork and adapt for your own use.

## License

This project uses code from [Azure Voting App](https://github.com/Azure-Samples/azure-voting-app-redis).

See [LICENSE.md](./LICENSE.md) for details.

## Acknowledgments

- Based on Azure Voting App sample
- Built with Azure cloud services
- Monitoring powered by Application Insights
