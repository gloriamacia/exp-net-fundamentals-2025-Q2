# Forward Proxy 

Proxy Box (Ubuntu + Squid) bridges the gap between private and public networks: all instances stay in the isolated private subnet, but their HTTP/S traffic is forwarded through Squid’s public ENI to the Internet Gateway, while administrators reach them via the Windows Jump Box over RDP.

Recap of the steps you followed to set up **a Squid-based forward proxy** on my **Ubuntu EC2 (Proxy Box)** so that **Windows EC2 (Proxy Client)** in a **private subnet** can access the internet:

---

## ✅ Step-by-Step Recap: Squid Proxy Setup for Internet Access

### 1. **Verified the Network Layout**

* Confirmed:

  * Windows EC2 is in a **private subnet** (`10.200.123.128/28`) with **no direct internet access**
  * Ubuntu EC2 (Proxy Box) is in the same subnet but has a **public ENI** and access to the internet via **Internet Gateway**
  * Subnet route table: `0.0.0.0/0 → IGW` for public ENI

---

### 2. **Installed and Configured Squid on Ubuntu**

```bash
sudo apt update
sudo apt install squid -y
```

* Allowed the Windows EC2 CIDR in `/etc/squid/squid.conf` using a `sed` one-liner:

```bash
sudo sed -i '/http_access deny all/i acl localnet src 10.200.123.128\/28\nhttp_access allow localnet' /etc/squid/squid.conf
```

* Restarted Squid:

```bash
sudo systemctl restart squid
```
![Screenshot](./assets/Screenshot%202025-06-23%20at%2016.04.13.png)




---

### 3. **Adjusted Security Groups**

* Opened port `3128` (Squid) in the Ubuntu EC2’s security group:

  * **Source**: `10.200.123.128/28` (Windows subnet)

![Screenshot](./assets/Screenshot%202025-06-23%20at%2016.05.56.png)
---

### 4. **Configured Proxy on Windows EC2 (Proxy Client)**

* In **Network Proxy Settings**:

  * Manual proxy
  * **Address**: private IP of Ubuntu Proxy Box (e.g., `10.200.123.134`)
  * **Port**: `3128`

* Or via PowerShell:

```powershell
netsh winhttp set proxy 10.200.123.134:3128
```

![Screenshot](./assets/Screenshot%202025-06-23%20at%2016.09.29.png)

---

### 5. **Tested Connectivity**

* Verified internet access from Windows EC2:

![Screenshot](./assets/Screenshot%202025-06-23%20at%2016.10.20.png)

