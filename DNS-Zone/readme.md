# Set up a Domain with DNS and Private Link in Azure

## Objective

Create a private DNS zone, deploy a VM that acts as a web server, and access it using a custom domain over a private link within a virtual network.

---

## Resources Created

* 1x Linux VM (Apache web server)
* 1x Test Linux VM (for DNS resolution testing)
* 1x Private DNS Zone (`contoso.com`)
* 1x A record (`www.contoso.com`)
* 1x Virtual Network + Subnet
* 1x Private DNS VNet Link

---

## Steps

### 1. Create a Resource Group

```bash
az group create --name myResourceGroup --location eastus
```

### 2. Create a Virtual Network and Subnet

```bash
az network vnet create \
  --resource-group myResourceGroup \
  --name myVNet \
  --subnet-name mySubnet
```

### 3. Create the Web Server VM

```bash
az vm create \
  --name dnsVM \
  --resource-group myResourceGroup \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --vnet-name myVNet \
  --subnet mySubnet
```

### 4. SSH into the VM and Install Apache

```bash
ssh azureuser@<public-ip-of-dnsVM>
sudo apt update
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
```

Replace the content in `/var/www/html/index.html` with a welcome message.

### 5. Create a Private DNS Zone

```bash
az network private-dns zone create \
  --resource-group myResourceGroup \
  --name contoso.com
```

### 6. Link DNS Zone to VNet

```bash
az network private-dns link vnet create \
  --resource-group myResourceGroup \
  --zone-name contoso.com \
  --name myDNSLink \
  --virtual-network myVNet \
  --registration-enabled true
```

### 7. Create A Record in DNS Zone

```bash
az network private-dns record-set a add-record \
  --resource-group myResourceGroup \
  --zone-name contoso.com \
  --record-set-name www \
  --ipv4-address <private-ip-of-dnsVM>
```

### 8. Create a Test VM

```bash
az vm create \
  --name testClientVM \
  --resource-group myResourceGroup \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --vnet-name myVNet \
  --subnet mySubnet
```

### 9. Test DNS Resolution from Test VM

```bash
ssh azureuser@<public-ip-of-testClientVM>
nslookup www.contoso.com
curl http://www.contoso.com
```

You should receive the web page served from the `dnsVM` via the private IP using the DNS name.

---

## Notes

* No public IP is needed for `dnsVM` once testing is done.
* For production, restrict NSG access.
* Ensure the VMs are in the same VNet or peered VNets for proper DNS resolution.

---
