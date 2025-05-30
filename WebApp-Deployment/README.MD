
### ✅ Folder Structure (`02-webapp-deployment/`)

```
02-webapp-deployment/
├── README.md
├── welcome-page.html
├── welcomePage.json
└── deployment-screenshot.png  # (Add after deployment)
```

---

### 📄 `02-webapp-deployment/README.md`

# 🌐Azure Web App Deployment with Welcome Page

This task demonstrates how to:

- Create an **App Service Plan**
- Provision a **Web App**
- Deploy a **custom welcome page** using Azure CLI and local Git

---

## 📌 Resources Used

| Resource Type       | Name                    |
|---------------------|-------------------------|
| App Service Plan    | `welcomePagePlan`      |
| Web App             | `WelcomePage`   |
| Region              | `Canada Central`                |
| Deployment Method   | Local Git               |

---

## 🛠 Azure CLI Commands

### 1️⃣ Create an App Service Plan

```bash
az appservice plan create \
  --name myAppServicePlan \
  --resource-group myResourceGroup \
  --sku FREE \
  --is-linux
```

---

### 2️⃣ Create a Web App

```bash
az webapp create \
  --resource-group myResourceGroup \
  --plan WelcomePagePlan \
  --name WelcomePage \
  --runtime "NODE:18-lts" \
  --deployment-local-git
```

---

### 3️⃣ Enable Local Git Deployment

```bash
az webapp deployment source config-local-git \
  --name welcomePage1234 \
  --resource-group myResourceGroup
```

> Copy the Git URL returned from the command above.

---

### 4️⃣ Deploy the Welcome Page

```bash
# Navigate into folder and prepare repo
cd 02-webapp-deployment
git init
mv welcome-page.html index.html 
git add .
git commit -m "Initial deployment of welcome page"
git remote add azure https://welcomepage-h5gqhue9b5andxc0.scm.canadacentral-01.azurewebsites.net:443/WelcomePage.git
git push azure master
```
### Live URL
Your Web App should be available at:

```bash
welcomepage-h5gqhue9b5andxc0.canadacentral-01.azurewebsites.net
```
---


## ✅ Task Completed

* [x] App Service Plan created
* [x] Web App provisioned
* [x] Welcome page deployed
* [x] Screenshot uploaded

---


