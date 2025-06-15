## CML VPN

### Goal 

Establish network connectivity between an on-premises Alpine Linux server (in Cisco Modeling Lab) and an Ubuntu EC2 instance in AWS through a site-to-site VPN connection, and verify the connectivity using ICMP ping requests.

This lab will demonstrate:

1. Site-to-site VPN configuration between CML and AWS
2. Proper routing setup on both ends
3. Security group and network ACL configurations to allow ICMP traffic
4. Successful end-to-end connectivity verification using ping

---

### What is a VPN? 

A VPN (Virtual Private Network) is a secure, encrypted connection between your on-premises network and your AWS VPC (Virtual Private Cloud)

A site-to-site VPN in AWS creates a secure tunnel between your on-premises network and AWS VPC using two key components:

1. Virtual Private Gateway (VPW): AWS's side of the connection, acting as the entrance point on the AWS VPC.

2. Customer Gateway: Your network's side of the connection, representing your on-premises endpoint.

Both components are required because they contain the essential information (IP addresses, routing, and encryption settings) needed to establish and maintain the secure tunnel between both networks - just like needing both phone numbers to make a call.

### Does a VPN use the public internet? 

A VPN connection DOES use the public internet, but the traffic is encrypted. Here's the key concept:

VPN Traffic Flow:

1. Data leaves your network (CML/Alpine)
2. Gets encrypted
3. Travels through the public internet in an encrypted "tunnel"
4. Arrives at AWS VPW
5. Gets decrypted
6. Enters your AWS VPC

---

### Steps 

Setup a customer gateway in AWS

![Customer Gateway](assets/Screenshot%202025-06-15%20at%2015.49.40.png)

Setup a virtual private gateway (VPG) in AWS

![VPG](assets/Screenshot%202025-06-15%20at%2015.51.25.png)

Attach the VPG to the VPC of the EC2 instance
s
![Attach VPG to VPC](assets/Screenshot%202025-06-15%20at%2015.54.12.png)

Create a site-to-site VPN connection in AWS using the newly created VPG and Customer Gateway

![VPN connection](assets/Screenshot%202025-06-15%20at%2016.02.05.png)

Download the site-to-site VPN configuration file 
![Screenshot 7](assets/Screenshot%202025-06-15%20at%2016.03.24.png)


```
! #3: Tunnel Interface Configuration
!
interface Tunnel1
  ip address 169.254.107.226 255.255.255.252
  ip virtual-reassembly
  tunnel source Gig1
  tunnel destination 3.232.113.196
  tunnel mode ipsec ipv4
  tunnel protection ipsec profile ipsec-vpn-0f905608b8407847d-0
  ! This option causes the router to reduce the Maximum Segment Size of
  ! TCP packets to prevent packet fragmentation.
  ip tcp adjust-mss 1379
  no shutdown
exit
```

The CML router from the VM does not know the public IP of the host. Hence, for the tunnel to work we are changing it to gate 1 interface of the router. 

```
interface Tunnel1
...
interface Tunnel2

```
Note: The connection is reduntant from AWS side though we are not truly redundant because we only have one router on the CML side (single point of failure). Due to security measures in CML router, only certain encription algorithms are supported. Meaning that for it to work, in the config file it was needed to change the following ```group 2``` to ```group 14``` and same in ```set pfs group2``` to ```set pfs group14```

Note: Tim copies the config to CML but at this point since I could not install CML on my M3 Mac I stoped the hands-on and I just watched him. 

Enable route propagation in the route tables (2) of the ubuntu EC2 instance in AWS, both in the private and public subnets

![public RT](assets/Screenshot%202025-06-15%20at%2016.31.55.png)

![private RT](assets/Screenshot%202025-06-15%20at%2016.39.33.png)

