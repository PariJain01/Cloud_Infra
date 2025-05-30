## 📁 Folder Structure for GitHub

```
03-acr-container-deployment/
├── README.md
├── Dockerfile
├── app.py
├── requirements.txt
└── acr-push.sh
```

---

### ✅ `README.md`

### 🐳 ACR + Azure Container Instance Deployment

This task demonstrates how to:

- ✅ Create an Azure Container Registry (ACR)
- ✅ Build and push a Docker image from a Flask app
- ✅ Deploy a container instance using ACR image
- ✅ Expose the container using a DNS name

---

## 📦 Resources Used

| Resource Type            | Value                 |
|--------------------------|-----------------------|
| Resource Group           | `myResourceGroup`     |
| Azure Container Registry | `myacr12345`          |
| Container Instance       | `mycontainer`         |
| DNS Name                 | `mycontainerdns12345` |
| Region                   | `eastus`              |

---

## 🛠 Docker App Components

### `app.py`

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Welcome from Azure Container Registry!</h1>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
```

 

### requirements.txt

```
flask
```

---

### `Dockerfile`

```Dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
COPY app.py .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80
CMD ["python", "app.py"]
```

---

### `acr-push.sh`

```bash
#!/bin/bash

ACR_NAME="myacr12345"
RESOURCE_GROUP="myResourceGroup"
IMAGE_NAME="mywebapp"

az acr login --name $ACR_NAME

docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME:latest $ACR_NAME.azurecr.io/$IMAGE_NAME:latest
docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:latest

echo "✅ Image pushed to: $ACR_NAME.azurecr.io/$IMAGE_NAME:latest"
```

> Make it executable:
> `chmod +x acr-push.sh`

---

## ⚙️ Azure CLI Commands

### 🔹 Create ACR

```bash
az acr create \
  --resource-group myResourceGroup \
  --name myacr12345 \
  --sku Basic \
  --location eastus
```

---

### 🔹 Deploy Container Instance from ACR

```bash
az container create \
  --resource-group myResourceGroup \
  --name mycontainer \
  --image myacr12345.azurecr.io/mywebapp:latest \
  --cpu 1 \
  --memory 1 \
  --registry-login-server myacr12345.azurecr.io \
  --dns-name-label mycontainerdns12345 \
  --ports 80 \
  --restart-policy OnFailure
```

---

### 🔎 Check Status and Access App

```bash
az container show \
  --resource-group myResourceGroup \
  --name mycontainer \
  --query "{FQDN:ipAddress.fqdn, State:instanceView.state}" \
  --output table
```

Visit:

```
http://mycontainerdns12345.eastus.azurecontainer.io
```

---

## ✅ Task Completion Checklist

* [x] Dockerized Flask app
* [x] ACR created and image pushed
* [x] Container Instance deployed from ACR
* [x] Public DNS access tested

---
