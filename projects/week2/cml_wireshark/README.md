# 🧪 Wireshark Network Analysis 

## 🎯 Goal
Use Wireshark to observe and understand what happens behind the scenes when a computer sends a simple `ping` command to external websites like `example.com` and `google.com`.

---

## ✅ Steps

1. **Installed Wireshark** windows VM and started capturing on the active network interface (`Ethernet 2`).
   
![Install Wireshart](./assets/Screenshot%202025-06-23%20at%2016.29.27.png)

1. In **Windows PowerShell**, I ran:
   ```powershell
   ping example.com
   ping google.com
    ```

![Wireshark traffic](./assets/Screenshot%202025-06-28%20at%2012.00.48.png)


## 🔍 What I Observed in Wireshark

* **DNS packets**:
  My machine first resolved `example.com` to its IP by asking a DNS server (`10.200.123.2`).

* **ARP packets**:
  Before sending the ping, my computer needed to know the MAC address for the next hop (e.g., `10.200.123.132`). It sent ARP requests like:

  > “Who has 10.200.123.132?”
  > And received responses with the MAC address.

* **Ping replies (ICMP)**:
  Though not shown in the packet list screenshot, the ping to `google.com` succeeded (confirmed in PowerShell), demonstrating that DNS and routing were working correctly.

---

## 🧠 Key Learnings

* **DNS** is used to translate human-readable domains into IP addresses before any network request.
* **ARP** is used to map an IP address to a MAC address on the local network, which is required for sending packets.
* **Wireshark** allows you to see these background protocols in action, even before the actual ping (ICMP) packets are sent.


