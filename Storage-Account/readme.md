Here's a breakdown of how to approach **Task 9** with the necessary Azure CLI commands, code snippets, and testing steps. This will help you prepare files, README, and documentation for GitHub submission.

---

### ✅ **Azure Storage Account Setup and Blob Access**

#### 1. **Create a Storage Account**

```bash
az storage account create \
  --name mystorageacct12345 \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS
```

---

### ✅ **Upload and Access Blob**

#### 2. **Create a Container & Upload Blob**

```bash
az storage container create \
  --account-name mystorageacct12345 \
  --name mycontainer \
  --public-access blob

az storage blob upload \
  --account-name mystorageacct12345 \
  --container-name mycontainer \
  --name sample.txt \
  --file sample.txt
```

---

### ✅ **Authentication Methods**

#### 3. **Using Access Keys**

```bash
az storage account keys list \
  --account-name mystorageacct12345 \
  --resource-group myResourceGroup
```

Use these keys with `az storage` commands or in Azure Storage Explorer to authenticate.

---

#### 4. **Create a Shared Access Signature (SAS)**

```bash
az storage container generate-sas \
  --name mycontainer \
  --account-name mystorageacct12345 \
  --permissions r \
  --expiry 2025-12-31T23:59:00Z \
  --output tsv
```

Use this SAS token in a URL:

```
https://mystorageacct12345.blob.core.windows.net/mycontainer/sample.txt?<SAS_TOKEN>
```

---

#### 5. **Create a Stored Access Policy**

```bash
az storage container policy create \
  --account-name mystorageacct12345 \
  --container-name mycontainer \
  --name myPolicy \
  --permissions rl \
  --expiry 2025-12-31T23:59:00Z
```

Then generate a SAS token using this policy.

---

### ✅ **Access Tiers**

```bash
az storage blob set-tier \
  --account-name mystorageacct12345 \
  --container-name mycontainer \
  --name sample.txt \
  --tier Cool
```

Tiers: `Hot`, `Cool`, `Archive`.

---

### ✅ **Lifecycle Management Policy**

```json
{
  "rules": [
    {
      "name": "deleteOldBlobs",
      "enabled": true,
      "type": "Lifecycle",
      "definition": {
        "filters": {
          "blobTypes": ["blockBlob"],
          "prefixMatch": ["sample"]
        },
        "actions": {
          "baseBlob": {
            "delete": {
              "daysAfterModificationGreaterThan": 30
            }
          }
        }
      }
    }
  ]
}
```

```bash
az storage account management-policy create \
  --account-name mystorageacct12345 \
  --resource-group myResourceGroup \
  --policy @policy.json
```

---

### ✅ **Object Replication**

1. Create a destination storage account with replication enabled.
2. Use the portal or CLI to configure the **Object Replication Policy**.

---

### ✅ **Azure File Share**

#### 6. **Create a File Share**

```bash
az storage share create \
  --name myfileshare \
  --account-name mystorageacct12345
```

#### Upload a file

```bash
az storage file upload \
  --share-name myfileshare \
  --source ./sample.txt \
  --path sample.txt \
  --account-name mystorageacct12345
```

---

### ✅ **Azure File Sync**

* Set up Azure File Sync via portal or PowerShell (CLI support is limited).
* Create:

  * Storage Sync Service
  * Sync Group
  * Registered server
  * Server endpoint

---

### 📄 Files You Can Push to GitHub:

1. `README.md` – explanation and steps for Task 9
2. `policy.json` – for lifecycle policy
3. Screenshots or JSON outputs
4. `auth-test.sh` – demo script for testing access keys/SAS

Would you like me to generate these files now?
