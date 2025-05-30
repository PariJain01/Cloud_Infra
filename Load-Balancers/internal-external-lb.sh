#!/bin/bash

# Variables
RESOURCE_GROUP="myResourceGroup"
LOCATION="eastus"
VNET_NAME="myVnet"
SUBNET_NAME="mySubnet"
ILB_NAME="myInternalLB"
ELB_NAME="myExternalLB"
ILB_FRONTEND_NAME="ILB-Frontend"
ELB_FRONTEND_NAME="ELB-Frontend"
BACKEND_POOL_NAME="LB-BackendPool"
PROBE_NAME="HealthProbe"
LB_RULE_NAME="HTTPRule"
VM1_NAME="vm1"
VM2_NAME="vm2"

# Create Public IP for External LB
az network public-ip create \
  --resource-group $RESOURCE_GROUP \
  --name ELB-PublicIP \
  --sku Standard \
  --allocation-method static \
  --location $LOCATION

# Create External Load Balancer
az network lb create \
  --resource-group $RESOURCE_GROUP \
  --name $ELB_NAME \
  --sku Standard \
  --frontend-ip-name $ELB_FRONTEND_NAME \
  --public-ip-address ELB-PublicIP \
  --backend-pool-name $BACKEND_POOL_NAME \
  --location $LOCATION

# Create Internal Load Balancer
az network lb create \
  --resource-group $RESOURCE_GROUP \
  --name $ILB_NAME \
  --sku Standard \
  --frontend-ip-name $ILB_FRONTEND_NAME \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET_NAME \
  --private-ip-address 10.0.0.100 \
  --backend-pool-name $BACKEND_POOL_NAME \
  --location $LOCATION

# Create Health Probe
az network lb probe create \
  --resource-group $RESOURCE_GROUP \
  --lb-name $ELB_NAME \
  --name $PROBE_NAME \
  --protocol tcp \
  --port 80

az network lb probe create \
  --resource-group $RESOURCE_GROUP \
  --lb-name $ILB_NAME \
  --name $PROBE_NAME \
  --protocol tcp \
  --port 80

# Create LB Rule for External LB
az network lb rule create \
  --resource-group $RESOURCE_GROUP \
  --lb-name $ELB_NAME \
  --name $LB_RULE_NAME \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name $ELB_FRONTEND_NAME \
  --backend-pool-name $BACKEND_POOL_NAME \
  --probe-name $PROBE_NAME

# Create LB Rule for Internal LB
az network lb rule create \
  --resource-group $RESOURCE_GROUP \
  --lb-name $ILB_NAME \
  --name $LB_RULE_NAME \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name $ILB_FRONTEND_NAME \
  --backend-pool-name $BACKEND_POOL_NAME \
  --probe-name $PROBE_NAME

# Associate VM NICs to Backend Pool
for VM in $VM1_NAME $VM2_NAME; do
  NIC_ID=$(az vm show --resource-group $RESOURCE_GROUP --name $VM --query "networkProfile.networkInterfaces[0].id" -o tsv)
  az network nic ip-config address-pool add \
    --address-pool $BACKEND_POOL_NAME \
    --ip-config-name ipconfig1 \
    --nic-name $(basename $NIC_ID) \
    --resource-group $RESOURCE_GROUP \
    --lb-name $ELB_NAME

  az network nic ip-config address-pool add \
    --address-pool $BACKEND_POOL_NAME \
    --ip-config-name ipconfig1 \
    --nic-name $(basename $NIC_ID) \
    --resource-group $RESOURCE_GROUP \
    --lb-name $ILB_NAME
done

echo "✅ Internal and External Load Balancers have been created and configured."
