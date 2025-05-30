
###  Deploy Python App via Azure Container Instance

# Deploy Python Flask App to Azure Container Instance via ACR

This task demonstrates deploying a simple Python web application to an Azure Container Instance (ACI) using an image pushed to Azure Container Registry (ACR).

---

## ✅ Objective

- Create a Docker image of a Python Flask app.
- Push the image to Azure Container Registry.
- Create an Azure Container Instance using the image from ACR.
- Access the running container app via its public IP.

---

## 🧱 Prerequisites

- Azure CLI logged in: `az login`
- ACR created: `task4acr`
- Resource Group: `myResourceGroup`
- Docker installed and running
- Python/Flask code available (`app.py`, `requirements.txt`)

---

## 📁 Project Structure

```bash
task-4/
├── app.py
├── requirements.txt
├── Dockerfile
└── acr-push.sh
```

---

## 🐳 Step 1: Dockerfile

``` dockerfile

FROM python:3.11-slim

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "app.py"]
```

---

## 🐍 Step 2: Python App (`app.py`)

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def welcome():
    return "<h1>Hello from Azure Container Instance!</h1>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

---

## 📦 Step 3: Requirements (`requirements.txt`)

```txt
flask
```

---

## 🚀 Step 4: Push Image to ACR

Make sure your ACR is created and running.

```bash
#!/bin/bash

ACR_NAME="task4acr"
RESOURCE_GROUP="myResourceGroup"
IMAGE_NAME="flaskwebapp"

az acr login --name $ACR_NAME

docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME:latest $ACR_NAME.azurecr.io/$IMAGE_NAME:latest
docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:latest
```

Run it:

```bash
chmod +x acr-push.sh
./acr-push.sh
```

---

## 📤 Step 5: Deploy Azure Container Instance (ACI)

```bash
az container create \
  --name flaskcontainer \
  --resource-group myResourceGroup \
  --image task4acr.azurecr.io/flaskwebapp:latest \
  --registry-login-server task4acr.azurecr.io \
  --ip-address Public \
  --ports 8080 \
  --registry-username $(az acr credential show --name task4acr --query username -o tsv) \
  --registry-password $(az acr credential show --name task4acr --query passwords[0].value -o tsv)
```

---

## 🌐 Step 6: Test the App

Once deployed, fetch the public IP:

```bash
az container show \
  --name flaskcontainer \
  --resource-group myResourceGroup \
  --query ipAddress.ip \
  --output tsv
```
