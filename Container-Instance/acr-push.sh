#!/bin/bash

ACR_NAME="myacr12345"
RESOURCE_GROUP="myResourceGroup"
IMAGE_NAME="mywebapp"

az acr login --name $ACR_NAME

docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME:latest $ACR_NAME.azurecr.io/$IMAGE_NAME:latest
docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:latest

echo "✅ Image pushed to: $ACR_NAME.azurecr.io/$IMAGE_NAME:latest"
