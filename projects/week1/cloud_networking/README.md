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

---

## Azure 

# Creating and Peering Virtual Networks in Azure

## Step 1: Create Two Virtual Networks
In Azure, you'll create two separate Virtual Networks (VNets):
- bootcamp-test-vnet
- bootcamp-test-peer-vnet

## Step 2: Set Up VNet Peering
Unlike AWS, Azure VNet peering is bidirectional by default, which simplifies the process:

1. Navigate to either VNet
2. Select 'Peerings' from the left menu
3. Click '+ Add' to create a new peering connection
4. Configure the peering settings:
   - Check "Allow bootcamp-test-vnet to access bootcamp-test-peer-vnet"
   - Once enabled, traffic can flow in both directions automatically

## Key Difference from AWS
- Azure: One peering configuration enables bidirectional communication
- AWS: Requires two separate peering configurations (one in each direction)

This streamlined approach in Azure makes network configuration more straightforward and reduces the chance of misconfiguration.

![Azure VNet Peering](assets/Screenshot%202025-06-13%20at%2013.13.08.png)


---

## GCP 

I managed to successfully create a VPC and default subnets in GCP. 

![GCP VPC](assets/Screenshot%202025-06-13%20at%2011.54.23.png)

![GCP Subnets](assets/Screenshot%202025-06-13%20at%2011.55.52.png)

The trickiest part was getting past the "“Data Could Not Be Loaded” error in GCP VPC Console.

### 🛠️ Troubleshooting: “Data Could Not Be Loaded” in GCP VPC Console

![Troubleshooting](assets/Screenshot%202025-06-13%20at%2011.35.38.png)


If you see the error:

“Data could not be loaded” or “The server was not able to fulfill your request”


…when accessing VPC networks in Google Cloud Console, it may be due to the Compute Engine API not being enabled.

✅ Solution

1. Go to the Compute Engine API page.

2. Make sure it is enabled for your project.

Even if you have Owner permissions, this API must be explicitly enabled for VPC resources to load correctly.

### Observations 

* GCP calls them Virtual Private Cloud (VPC) networks, like AWS
* Unlike Azure and AWS, GCP VPC networks are global by default
* Subnets in GCP are regional resources, not zonal