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



