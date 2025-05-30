#!/bin/bash

# Variables
RESOURCE_GROUP="myResourceGroup"
LOCATION="eastus"
APP_GW_NAME="myAppGateway"
VNET_NAME="myAppGwVnet"
SUBNET_NAME="appGwSubnet"
PUBLIC_IP_NAME="appGwPublicIP"
BACKEND_POOL_NAME="myBackendPool"
FRONTEND_PORT_NAME="httpPort"
FRONTEND_CONFIG_NAME="appGwFrontendConfig"
BACKEND_HTTP_SETTINGS_NAME="appGwBackendHttpSettings"
LISTENER_NAME="appGwHttpListener"
RULE_NAME="appGwRoutingRule"

# Create Public IP for App Gateway
az network public-ip create \
  --resource-group $RESOURCE_GROUP \
  --name $PUBLIC_IP_NAME \
  --sku Standard \
  --allocation-method Static

# Create VNet and Subnet
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --location $LOCATION \
  --address-prefix 10.0.0.0/16 \
  --subnet-name $SUBNET_NAME \
  --subnet-prefix 10.0.1.0/24

# Get Subnet ID
SUBNET_ID=$(az network vnet subnet show \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --query id --output tsv)

# Create Application Gateway
az network application-gateway create \
  --name $APP_GW_NAME \
  --location $LOCATION \
  --resource-group $RESOURCE_GROUP \
  --sku Standard_v2 \
  --capacity 2 \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET_NAME \
  --public-ip-address $PUBLIC_IP_NAME \
  --frontend-port 80 \
  --http-settings-cookie-based-affinity Disabled \
  --http-settings-port 80 \
  --http-settings-protocol Http \
  --routing-rule-type Basic \
  --servers 10.0.2.4 10.0.2.5 # Replace with your backend VM private IPs

echo "✅ Azure Application Gateway setup completed."
