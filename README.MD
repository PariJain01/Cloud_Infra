
# Azure Infrastructure Internship Assignment

This repository contains my completed tasks for the Azure Infrastructure internship program. Each task demonstrates hands-on experience with key Azure services including virtual machines, web apps, containers, storage, DNS, networking, and load balancing.

---

## 📁 Project Structure

```

AzureInfra-Assignment/
├── 1-VM-Deployment/
│ ├── deploy-linux-VM
│ └── deploy-window-VM
├── 2-App-Service/
│ ├── app-service-plan-deploy
│ └── welcome-page.json
│ └── welcome-page.html
├── 3-ACR-Deployment/
│ ├── Dockerfile
│ ├── app.py
│ ├── requirements.txt
│ └── acr-push.sh
├── 4-Container-Instance/
│ └── container-deploy.sh
├── 5-VNet-Architecture/
│ └── vnet-peering.sh
├── 6-Load-Balancers/
│ └── internal-external-lb.sh
├── 7-Application-Gateway/
│ └── app-gateway-setup.sh
├── 8-DNS-Zone/
│ └── readme
├── 9-Storage-Account/
│ └── storage-automation.sh
└── README.md
```

---

## ✅ Completed Tasks

### 1. **VM Deployment**
- Deployed Linux and Windows VMs.
- Connected using SSH and RDP.
- Configured custom script extension for setup.

### 2. **Web App Deployment**
- Provisioned App Service Plan.
- Deployed static welcome page using Git and containerized Java web app.

### 3. **Azure Container Registry**
- Created ACR.
- Built Docker image and pushed to ACR.
- Pulled and deployed via container instance.

### 4. **Azure Container Instance**
- Deployed Python application from ACR.
- Verified accessibility and functionality.

### 5. **VNet & Subnet Configuration**
- Created Hub and Spoke VNets.
- Configured peering.
- Deployed VMs in respective VNets and verified connectivity.

### 6. **DNS and Web Server**
- Registered custom domain.
- Configured DNS zone.
- Deployed NGINX on Azure VM.
- Verified domain resolution.

### 7. **Load Balancers**
- Created Internal and External Load Balancer.
- Attached VMs to backend pools.
- Configured health probes and rules.

### 8. **Azure Application Gateway**
- Configured HTTP listener and routing rules.
- Linked to backend pools with autoscaling VM instances.

### 9. **Azure Storage Account**
- Explored access tiers and authentication (keys/SAS/AAD).
- Uploaded blobs via portal and CLI.
- Created and mounted Azure File Share.
- Implemented lifecycle management and replication (LRS/GRS).

---

## 🔐 Authentication Explored

- **Access Keys**
- **SAS Tokens**
- **Azure AD-based access**

---

## 📌 Notes

- All configurations use Azure CLI, ARM templates, and Azure Portal as needed.
- Screenshots and scripts are included for verification.
- Each subdirectory has its own `README.md` with implementation details where applicable.

---

## 📷 Screenshots

Screenshots validating task completion are located in:
- `Screenshot (69).png`
- `Screenshot (70).png`

---

## 📤 Deployment History

GitHub repo contains `.git` versioned deployments, Dockerfiles, scripts, and supporting Markdown documentation per task.

---

## Author

**[Pari Jain]**  
Intern @ Clebal Technologies  
Date: May 30, 2025

---