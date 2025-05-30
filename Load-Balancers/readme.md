
## ✅ Setup Internal and External Load Balancers in Azure

### 🔧 Objective

Set up:

* An **External Load Balancer** with a Public IP
* An **Internal Load Balancer** within a VNet
* Associate both with two backend VMs
* Enable HTTP load balancing with health probes

---

### 🗂️ Files

* `loadbalancer-setup.sh` – Script to create and configure internal and external load balancers.

---

### 🖥️ Infrastructure Overview

* **VNet:** `myVnet`
* **Subnet:** `mySubnet`
* **Virtual Machines:** `vm1`, `vm2`
* **External Load Balancer**

  * Public IP: `ELB-PublicIP`
  * Frontend: `ELB-Frontend`
* **Internal Load Balancer**

  * Private IP: `10.0.0.100`
  * Frontend: `ILB-Frontend`
* **Common**

  * Backend pool: `LB-BackendPool`
  * Health probe: `HealthProbe`
  * Rule: HTTP on port 80

---

### 🧪 Testing

1. Deploy simple HTTP servers on `vm1` and `vm2` (Apache, Python HTTP server, or custom app).
2. Open a browser and test:

   * **External Load Balancer:** Visit Public IP from `az network public-ip show`
   * **Internal Load Balancer:** SSH into a VM in the same VNet and `curl 10.0.0.100`

---

### 📜 Commands Used

* `az network lb create` – Create load balancers
* `az network lb probe create` – Add health probes
* `az network lb rule create` – Create load balancing rules
* `az network nic ip-config address-pool add` – Associate VM NICs to backend pool

---

