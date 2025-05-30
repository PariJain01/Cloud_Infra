#!/bin/bash

# Variables
RESOURCE_GROUP="myResourceGroup"
LOCATION="eastus"

# VNet Address Ranges
MGMT_VNET="ManagementVnet"
PROD_VNET="ProductionVnet"
TEST_VNET="TestingVnet"
DEV_VNET="DevelopingVnet"

# Create Resource Group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create VNets
az network vnet create --name $MGMT_VNET --resource-group $RESOURCE_GROUP --location $LOCATION --address-prefix 10.0.0.0/16 --subnet-name default --subnet-prefix 10.0.0.0/24
az network vnet create --name $PROD_VNET --resource-group $RESOURCE_GROUP --location $LOCATION --address-prefix 10.1.0.0/16 --subnet-name default --subnet-prefix 10.1.0.0/24
az network vnet create --name $TEST_VNET --resource-group $RESOURCE_GROUP --location $LOCATION --address-prefix 10.2.0.0/16 --subnet-name default --subnet-prefix 10.2.0.0/24
az network vnet create --name $DEV_VNET --resource-group $RESOURCE_GROUP --location $LOCATION --address-prefix 10.3.0.0/16 --subnet-name default --subnet-prefix 10.3.0.0/24

# Peerings from Management (Hub) to Spokes
az network vnet peering create \
  --name MGMT-to-PROD \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $MGMT_VNET \
  --remote-vnet $PROD_VNET \
  --allow-vnet-access

az network vnet peering create \
  --name MGMT-to-TEST \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $MGMT_VNET \
  --remote-vnet $TEST_VNET \
  --allow-vnet-access

az network vnet peering create \
  --name MGMT-to-DEV \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $MGMT_VNET \
  --remote-vnet $DEV_VNET \
  --allow-vnet-access

# Peerings from Spokes to Management
az network vnet peering create \
  --name PROD-to-MGMT \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $PROD_VNET \
  --remote-vnet $MGMT_VNET \
  --allow-vnet-access

az network vnet peering create \
  --name TEST-to-MGMT \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $TEST_VNET \
  --remote-vnet $MGMT_VNET \
  --allow-vnet-access

az network vnet peering create \
  --name DEV-to-MGMT \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $DEV_VNET \
  --remote-vnet $MGMT_VNET \
  --allow-vnet-access

echo "✅ Hub-and-Spoke VNet peering completed."
