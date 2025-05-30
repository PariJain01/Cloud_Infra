#!/bin/bash

# Variables
ACR_NAME="myacr12345"
RESOURCE_GROUP="myResourceGroup"
IMAGE_NAME="mywebapp"

# Login to Azure
az acr login --name $ACR_NAME

# Build Docker image
docker build -t $IMAGE_NAME .

# Tag for ACR
docker tag $IMAGE_NAME:latest $ACR_NAME.azurecr.io/$IMAGE_NAME:latest

# Push to ACR
docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:latest

echo "✅ Image pushed to ACR: $ACR_NAME.azurecr.io/$IMAGE_NAME:latest"
