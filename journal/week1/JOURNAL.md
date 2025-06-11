## Week 1 Journal 

### 9 June 2025

#### Diagraming

I draw and documented a private media streaming setup where House B streams from a Jellyfin server in House A. 

✅ What's done:

Created a full network diagram using Excalidraw (ran out of Lucidchart diagrams 😅)

Wrote a README explaining the data flow

Added a 🎥 video walkthrough placeholder — I’ll record it using Descript, still pending

🐢 Bootcamp-wise: My main challenge was that I started a week late due to my trip to Malaysia, but I followed the livestreams remotely and caught up.
As a bonus, I dropped in a turtle pic from the trip! 🐢📸🌴

![turtle](assets/turtle.jpeg)

---

#### Cloud Environment Setup

This session, I successfully launched and configured **three different EC2 instances** on AWS:

* ✅ **Red Hat Enterprise Linux**
* ✅ **Ubuntu Server**
* ✅ **Windows Server**

These instances are part of my networking fundamentals bootcamp and serve as the foundation for testing connectivity, key management, and remote access.


### 💡 **Key Achievements**

* Created and configured a **custom VPC** with public and private subnets
* Generated and used SSH key pairs for secure access
* Connected to **Linux instances via Terminal using PEM keys**
* Launched a **Windows Server instance** and connected via **RDP**
* Learned how to attach **Elastic IPs** and configure security groups
* Explored network interface configuration from inside the instance
* Repeated the process for **RedHat** and **Ubuntu**

### 🚧 **Challenges Faced**

* Attempted to use a **PuTTY `.ppk` key on macOS**, which isn’t supported — resolved by switching to the `.pem` key
* Tried to **change key pairs on a running instance**, which isn’t supported by AWS — learned the correct workaround using AMIs or SSM
* Worked through **connecting and inspecting network configuration** on EC2 via CLI tools

### **VPC Configuration with CFN** 

I deployed a CloudFormation template created by the network bootcamp organizers that creates a **VPC with one public and one private subnet** in a single Availability Zone. It enables **DNS support**, configures an **Internet Gateway for the public subnet**, and sets up routing so that only the public subnet has internet access. The output includes the IDs of the VPC and both subnets for reference.

#### IP Management 

I completed the cross-platform IP configuration task for Windows, Ubuntu, and Red Hat EC2 instances. I verified dynamic IP assignment via DHCP, tested static IP setup using Netplan (Ubuntu) and nmcli (Red Hat), and documented everything with screenshots and CLI commands in the README. The goal was to ensure clear, repeatable steps for future network troubleshooting and bootcamp labs.

#### Azure Bicep

Watched a walkthrough on using Bicep for Windows Server deployment in Azure. Since we already configured our environment using the AWS Console, I didn’t recreate the setup. Instead, I dove into comparing Bicep, CloudFormation, and Terraform to understand how each handles IaC and what trade-offs exist between cloud-native and multi-cloud tooling.

#### Cisco Packet Tracer

Using Cisco Packet Tracer, I simulated a basic network with a router, switch, DHCP server, and a client PC. The goal was to observe the DHCP process in action as the PC automatically obtained its IP configuration. I analyzed each step of the DORA exchange (Discover, Offer, Request, Acknowledgment) and verified that the client successfully received its IP address from the server. This setup helped me understand how DHCP functions at both the data link and application layers within a LAN.

#### Windows Networking 

I explored and analyzed the networking setup of my Windows VM on AWS. I inspected the IP configuration (`ipconfig`), confirmed connectivity with AWS services using `ping` and `tracert`, and reviewed active network connections via `netstat`. I also examined the routing table using `route print`, identifying multiple interfaces and gateways, and observed how traffic flows within the subnet and to AWS metadata services. This gave me a clearer understanding of how the VM is connected and how network diagnostics can be performed effectively.

#### Windows Firewall Rules

Certainly! Here's a concise and well-structured journal entry summarizing what you did, the issues you encountered, and how you resolved them:

---

**📓 Journal Entry – Serving a Website on Windows EC2 VM**

I set up a simple static website hosted via Python’s built-in HTTP server on a Windows EC2 instance. Initially, I created an `index.html` file directly on the desktop to avoid installing extra tools. I then used the command `python -m http.server 8000` to serve it locally.

### Challenges & Resolutions:

* **❌ Python not found in PATH**: Although Python was installed, it wasn’t added to the system PATH. I resolved this by manually locating `python.exe` under `C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps` and re-installing Python with the “Add to PATH” option checked.

* **❌ Website not loading externally**: When trying to access the site from outside the VM using the EC2 public IP, it kept loading indefinitely. I realized the issue was due to **network restrictions**:

  * **Windows Firewall** was blocking port `8000` ➝ I created a new inbound rule to allow TCP traffic on that port.
  * **AWS EC2 Security Group** didn't allow inbound traffic on port `8000` ➝ I added a custom TCP rule to the instance's security group allowing access from anywhere (`0.0.0.0/0`).

* **✅ Final Result**: Once both firewall and AWS security settings were updated, I was able to access the site via the EC2 public IP and port `8000` from my local machine.

#### Linux Networking 

I tested connectivity between two EC2 instances — one Ubuntu and one Red Hat — by using `ping` and `tcpdump`. I SSHed into both machines using their private IPs and verified their network interfaces. On the Red Hat instance, I installed `tcpdump` and captured incoming ICMP packets on `enX1` while sending pings from the Ubuntu instance. The successful packet exchange confirmed bidirectional communication across the second network interface. I also used `wget` on Ubuntu to download a webpage and validated that basic outbound internet access was working correctly.





