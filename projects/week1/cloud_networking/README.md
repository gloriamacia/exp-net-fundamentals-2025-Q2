# Cloud Networking

## AWS

### 🔁 VPC Peering Setup in AWS

I created two VPCs: `bootcamp-test-vpc` and `bootcamp-test-peer-vpc`, and connected them using **VPC peering** to enable network communication between instances in each VPC.

![VPC Peering Connection](assets/Screenshot%202025-06-12%20at%2021.39.31.png)

#### 🛣️ Steps to Enable Routing

To allow traffic to flow between the VPCs, I updated the **route tables** for the private subnets:

![Screenshot 2](assets/Screenshot%202025-06-12%20at%2021.51.25.png)

1. **In the main VPC (`bootcamp-test-vpc`)**
   I edited the route table to add a route that sends traffic to `10.100.0.0/20` (peer VPC CIDR) via the **VPC peering connection**.

2. **In the peer VPC (`bootcamp-test-peer-vpc`)**
   I updated the route table to allow **return traffic** back to `10.65.1.0/28` through the same VPC peering connection.

This bi-directional routing allows full communication between resources in both VPCs.

--