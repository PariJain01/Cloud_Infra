
## ✅ Create and Test Azure Application Gateway

### 🎯 Objective

Set up an **Azure Application Gateway** with:

* HTTP listener
* Backend pool of VMs or Web Apps
* Routing rule
* Health probes
* Public frontend IP

---

### 🛠️ Steps to Perform

#### 1. **Create a Resource Group (if not already present)**

```bash
az group create --name myResourceGroup --location eastus
```

#### 2. **Create a Virtual Network and Subnets**

```bash
az network vnet create \
  --resource-group myResourceGroup \
  --name myVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name appGatewaySubnet \
  --subnet-prefix 10.0.1.0/24
```


---

#### 3. **Create Public IP**

```bash
az network public-ip create \
  --resource-group myResourceGroup \
  --name myPublicIP
```

---

#### 4. **Create the Application Gateway**

```bash
az network application-gateway create \
  --name myAppGateway \
  --location eastus \
  --resource-group myResourceGroup \
  --capacity 2 \
  --sku Standard_v2 \
  --frontend-port 80 \
  --http-settings-cookie-based-affinity Disabled \
  --vnet-name myVNet \
  --subnet appGatewaySubnet \
  --public-ip-address myPublicIP
```

---

#### 5. **Configure Backend Pool and HTTP Settings**

Assuming you already have backend VMs or web apps:

```bash
az network application-gateway address-pool create \
  --gateway-name myAppGateway \
  --resource-group myResourceGroup \
  --name myBackendPool \
  --servers <VM1_IP> <VM2_IP>

az network application-gateway http-settings create \
  --resource-group myResourceGroup \
  --gateway-name myAppGateway \
  --name appGatewayBackendHttpSettings \
  --port 80 \
  --protocol Http \
  --cookie-based-affinity Disabled
```

---

#### 6. **Create Listener and Rules**

```bash
az network application-gateway frontend-port create \
  --resource-group myResourceGroup \
  --gateway-name myAppGateway \
  --name myFrontendPort \
  --port 80

az network application-gateway listener create \
  --resource-group myResourceGroup \
  --gateway-name myAppGateway \
  --name appGatewayHttpListener \
  --frontend-port myFrontendPort \
  --frontend-ip appGatewayFrontendIP \
  --protocol Http

az network application-gateway rule create \
  --resource-group myResourceGroup \
  --gateway-name myAppGateway \
  --name rule1 \
  --http-listener appGatewayHttpListener \
  --rule-type Basic \
  --address-pool myBackendPool \
  --http-settings appGatewayBackendHttpSettings
```

---

### ✅ Verification

1. Ensure web apps on VMs are running (like Python HTTP or Apache).
2. Access the Public IP via browser:

   ```
   http://<AppGatewayPublicIP>
   ```

---

### 📸 Do You Want?

* A **README.md**?
* A **reference diagram**?
* A **shell script (app-gateway.sh)**?
* A **test script**?

Let me know, and I’ll generate them for you!
