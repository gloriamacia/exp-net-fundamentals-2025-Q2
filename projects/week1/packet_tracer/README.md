## Cisco Packet Tracer Label

![DHCP Topology](assets/Screenshot%202025-06-09%20at%2021.15.16.png)

### 📡 How DHCP Works in Your Network (Step-by-Step)

When a new PC is added and set to use DHCP, this is what happens:


### 1. **DHCP Discover**

The PC sends a broadcast message to the entire network asking:
*“Is there a DHCP server that can give me an IP address?”*
This is sent to `255.255.255.255` because the PC doesn’t yet have an IP.


### 2. **DHCP Offer**

The DHCP server (Server0) responds with an offer:
*“You can use IP address 192.168.0.X, with this subnet mask and gateway.”*


### 3. **DHCP Request**

The PC replies to confirm:
*“Yes, I accept this IP address and configuration.”*


### 4. **DHCP Acknowledgment (ACK)**

The server sends a final confirmation:
*“Configuration complete. The IP is now yours for the lease duration.”*

After this exchange, the PC is fully configured with:

* An IP address
* Subnet mask
* Default gateway
* (Optional) DNS server

