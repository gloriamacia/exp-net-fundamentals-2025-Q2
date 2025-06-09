## IP Address Management

### 🧾 Task: IP Address Management on Windows

**Goal:**
Identify, configure, and verify IP address settings on a Windows EC2 instance to support troubleshooting and infrastructure readiness for networking tasks.

### 📷 Screenshots Overview

These images demonstrate how to inspect IP address settings on a Windows Server EC2 instance using both graphical tools and the command line:

1. **Ethernet Status View:**
   Confirms media state, link speed (\~5 Gbps), and whether IPv4 connectivity is present. This is essential for checking if the instance is correctly connected to the network.

2. **Network Adapter Properties (Settings > Network & Internet):**
   Displays DHCP assignment, current IP address (`10.200.123.12` or `10.200.123.132`), default gateway, DNS, and MAC address. Useful for identifying both interface-specific settings and verifying dynamic IP assignment.

3. **PowerShell `ipconfig` Output:**
   Shows IP addresses, subnet masks, and default gateways for each network interface. This is the quickest method to validate all address settings in one place.

![Windows IP Assignment GUI](assets/Screenshot%202025-06-09%20at%2018.03.59.png)

![Windows Ethernet Status](assets/Screenshot%202025-06-09%20at%2018.04.47.png)

![Windows IPConfig Output](assets/Screenshot%202025-06-09%20at%2018.05.52.png)

### ✅ Outcome

Successfully verified that Windows EC2 instances were receiving IP addresses dynamically via DHCP. Captured both GUI-based and CLI-based methods to find and validate current IPs. 

---

Here’s the expanded `README.md` section, keeping it concise and consistent with your existing format while adding detailed steps for Ubuntu and Red Hat:

---

## IP Address Management

### 🧾 Task: IP Address Management on Windows

**Goal:**
Identify, configure, and verify IP address settings on a Windows EC2 instance to support troubleshooting and infrastructure readiness for networking tasks.

### 📷 Screenshots Overview

These images demonstrate how to inspect IP address settings on a Windows Server EC2 instance using both graphical tools and the command line:

1. **Ethernet Status View:**
   Confirms media state, link speed (\~5 Gbps), and whether IPv4 connectivity is present.

2. **Network Adapter Properties (Settings > Network & Internet):**
   Displays DHCP assignment, current IP address (`10.200.123.12` or `10.200.123.132`), default gateway, DNS, and MAC address.

3. **PowerShell `ipconfig` Output:**
   Shows IP addresses, subnet masks, and default gateways for each network interface.

![Windows IP Assignment GUI](assets/Screenshot%202025-06-09%20at%2018.03.59.png)
![Windows Ethernet Status](assets/Screenshot%202025-06-09%20at%2018.04.47.png)
![Windows IPConfig Output](assets/Screenshot%202025-06-09%20at%2018.05.52.png)

### ✅ Outcome

Successfully verified that Windows EC2 instances were receiving IP addresses dynamically via DHCP. Captured both GUI-based and CLI-based methods to find and validate current IPs.

---

### 🐧 IP Address Management on Ubuntu

**Goal:**
Use command-line tools to inspect and manage IP address configuration on an Ubuntu EC2 instance.

**Commands Used:**

* Connect to EC2 instance
  
```
ssh -i ~/Downloads/nwbootcampkey-pem.pem ubuntu@34.232.9.211
```

* View current IP settings:

  ```bash
  ip a
  ```

  Displays interface details, assigned IPs, MAC address, and scope.

![Ubuntu IP Address - ip a](assets/Screenshot%202025-06-09%20at%2018.18.50.png)


* Compact view (interface/IP summary):

  ```bash
  ip -brief addr
  ```

* Release and renew IP via DHCP:

  ```bash
  sudo dhclient -r && sudo dhclient
  ```

* Configure a static IP (Netplan-based):
  Edit:

  ```bash
  sudo nano /etc/netplan/50-cloud-init.yaml
  ```

  Apply changes:

  ```bash
  sudo netplan apply
  ```

### ✅ Outcome

Validated current IP assignment, gateway, and DNS settings. Used Netplan to test static IP configuration and successfully reverted to DHCP.

---

### 🔴 IP Address Management on Red Hat

**Goal:**
Inspect, configure, and verify IP settings using Red Hat’s NetworkManager tools on an EC2 instance.

**Commands Used:**

* Connect to EC2 instance:

```
ssh -i ~/Downloads/nwbootcampkey-pem.pem ec2-user@3.216.224.236  
```` 

* View IP and network interface info:

  ```bash
  ip a
  nmcli device show
  ```
![Red Hat IP Address - ip a](assets/Screenshot%202025-06-09%20at%2018.21.09.png)

![Red Hat - nmcli device show p1](assets/Screenshot%202025-06-09%20at%2018.21.28.png)

![Red Hat - nmcli device show p2](assets/Screenshot%202025-06-09%20at%2018.21.37.png)


* Get a new DHCP lease:

  ```bash
  sudo dhclient
  ```

* Configure a static IP:

  ```bash
  nmcli con mod <connection-name> ipv4.addresses 10.200.123.101/24 \
    ipv4.gateway 10.200.123.1 ipv4.dns 10.200.123.2 ipv4.method manual
  nmcli con down <connection-name> && nmcli con up <connection-name>
  ```

Use `nmcli con show` to find the correct `<connection-name>` (usually `eth0` or `ens5`).

### ✅ Outcome

Used both `ip` and `nmcli` to inspect interfaces. Successfully tested static and dynamic IP assignment using NetworkManager.

