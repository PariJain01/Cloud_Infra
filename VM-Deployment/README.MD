### 📄 `01-vm-deployment/README.md`

# 🚀 Task 1: Deploy Linux and Windows Virtual Machines on Azure

This task involves provisioning one **Linux VM** and one **Windows VM** in Azure, and verifying access using **SSH** for Linux and **RDP** for Windows.

---

## 📌 Overview

| VM Type | Name     | OS Version                      | Access Method | VM Size           | Security         |
|---------|----------|----------------------------------|----------------|-------------------|------------------|
| Linux   | LinuxVM  | Ubuntu 24.04 LTS                | SSH (port 22)  | Standard_D2s_v3   | Trusted Launch   |
| Windows | WindowVm | Windows Server 2025 Datacenter | RDP (port 3389)| Standard_D2s_v3   | Trusted Launch   |

---

## 🧑‍💻 Azure CLI Commands

### 🔧 Create Resource Group

```bash
az group create --name myResourceGroup --location eastus
```

---

### 🐧 Create Linux VM (Ubuntu 24.04 LTS)

```bash
az vm create \
  --resource-group myResourceGroup \
  --name LinuxVM \
  --image UbuntuLTS \
  --size Standard_D2s_v3 \
  --admin-username Adminn \
  --authentication-type password \
  --admin-password "<YourPassword>" \
  --security-type TrustedLaunch \
  --enable-secure-boot true \
  --enable-vtpm true
```



### 🪟 Create Windows VM (Windows Server 2025)

```bash
az vm create \
  --resource-group myResourceGroup \
  --name WindowVm \
  --image "MicrosoftWindowsServer:WindowsServer:2025-datacenter-azure-edition:latest" \
  --size Standard_D2s_v3 \
  --admin-username Adminn \
  --admin-password "<YourPassword>" \
  --security-type TrustedLaunch \
  --enable-secure-boot true \
  --enable-vtpm true
```

---

## 🔐 Access Instructions

### Linux VM: SSH

```bash
ssh Adminn@172.191.194.88
```

---

### Windows VM: RDP

1. Use Remote Desktop Connection (`mstsc`)
2. Enter: `172.172.144.209`
3. Log in with:

   * **Username:** `Adminn`
   * **Password:** 

---

## 📂 Project Structure

```
01-vm-deployment/
├── README.md
├── linux-vm-output.json
├── window-vm-output.json
├── ssh-login-screenshot.png
└── rdp-login-screenshot.png
```

---

## ✅ Status

* [x] Linux VM created and accessed via SSH
* [x] Windows VM created and accessed via RDP
* [x] Output JSON captured and saved
* [x] Screenshots added

---

## 📸 Screenshots

* ✅ SSH login to Linux VM (`ssh-login-screenshot.png`)
* ✅ RDP login to Windows VM (`rdp-login-screenshot.png`)

---
`
