## A. Create a VNet with 2 Subnets

### Step 1: Create Resource Group

```bash
az group create --name VNetRG --location eastus
```

### Step 2: Create Virtual Network with 2 Subnets

```bash
az network vnet create \
  --resource-group VNetRG \
  --name MyVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name Subnet-1 \
  --subnet-prefix 10.0.1.0/24

az network vnet subnet create \
  --resource-group VNetRG \
  --vnet-name MyVNet \
  --name Subnet-2 \
  --address-prefix 10.0.2.0/24
```

### Step 3: Create Linux and Windows VMs in Subnet-1

```bash
az vm create \
  --resource-group VNetRG \
  --name LinuxVM \
  --image UbuntuLTS \
  --vnet-name MyVNet \
  --subnet Subnet-1 \
  --admin-username azureuser \
  --generate-ssh-keys

az vm create \
  --resource-group VNetRG \
  --name WindowsVM \
  --image Win2022Datacenter \
  --vnet-name MyVNet \
  --subnet Subnet-1 \
  --admin-username azureuser \
  --admin-password P@ssword1234!
```

### Step 4: Reserve Subnet-2 for SQL Database

(SQL DB service will consume Subnet-2 using delegated subnet if needed.)

---

## B. Configure Hub-Spoke Architecture

### Step 1: Create Four VNets

```bash
az network vnet create --resource-group VNetRG --name HubVNet --address-prefix 10.1.0.0/16 --subnet-name HubSubnet --subnet-prefix 10.1.0.0/24

az network vnet create --resource-group VNetRG --name ProdVNet --address-prefix 10.2.0.0/16 --subnet-name ProdSubnet --subnet-prefix 10.2.0.0/24

az network vnet create --resource-group VNetRG --name TestVNet --address-prefix 10.3.0.0/16 --subnet-name TestSubnet --subnet-prefix 10.3.0.0/24

az network vnet create --resource-group VNetRG --name DevVNet --address-prefix 10.4.0.0/16 --subnet-name DevSubnet --subnet-prefix 10.4.0.0/24
```

### Step 2: Peer VNets to Hub (Hub-Spoke Topology)

```bash
# Hub to Spokes
az network vnet peering create --name HubToProd --resource-group VNetRG --vnet-name HubVNet --remote-vnet ProdVNet --allow-vnet-access
az network vnet peering create --name HubToTest --resource-group VNetRG --vnet-name HubVNet --remote-vnet TestVNet --allow-vnet-access
az network vnet peering create --name HubToDev  --resource-group VNetRG --vnet-name HubVNet --remote-vnet DevVNet  --allow-vnet-access

# Spokes to Hub
az network vnet peering create --name ProdToHub --resource-group VNetRG --vnet-name ProdVNet --remote-vnet HubVNet --allow-vnet-access
az network vnet peering create --name TestToHub --resource-group VNetRG --vnet-name TestVNet --remote-vnet HubVNet --allow-vnet-access
az network vnet peering create --name DevToHub  --resource-group VNetRG --vnet-name DevVNet  --remote-vnet HubVNet --allow-vnet-access
```

### Step 3: Launch VMs in Each VNet

```bash
az vm create --resource-group VNetRG --name HubVM --vnet-name HubVNet --subnet HubSubnet --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

az vm create --resource-group VNetRG --name ProdVM --vnet-name ProdVNet --subnet ProdSubnet --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

az vm create --resource-group VNetRG --name TestVM --vnet-name TestVNet --subnet TestSubnet --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

az vm create --resource-group VNetRG --name DevVM --vnet-name DevVNet --subnet DevSubnet --image UbuntuLTS --admin-username azureuser --generate-ssh-keys
```

### Step 4: Verify Connectivity

1. SSH into `HubVM`:

```bash
ssh azureuser@<Public-IP-of-HubVM>
```

2. Ping other VMs (internal IPs)

```bash
ping 172.191.194.88
ping 172.161.154.67
ping 172.172.144.209
```

Ensure all VMs respond successfully (firewalls/NIC NSGs must allow ICMP or SSH/port 22 for test).

---

