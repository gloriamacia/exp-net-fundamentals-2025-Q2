## 📺 Media Streaming Across Two Houses – Overview
This setup allows House B to stream content from a Jellyfin media server hosted in House A, using a private and secure network path without relying on public internet access.

![Diagram of Two-House Media Setup](assets/diagram.png)

### 🔄 Data Flow Summary:

1. TV in House B requests a movie from Jellyfin.

2. The request is routed via House B's router.

3. It passes through White Box B (a bridge device).

4. Crosses over the shared point-to-point network to White Box A in House A.

5. Packet reaches House A's router.

6. Finally, the Jellyfin server (at 192.168.0.4:8096) receives the request and starts streaming.

➡️ The reply takes the exact same path in reverse, ensuring smooth and secure delivery.

### 🎥 Video Explanation 

I used Excalidraw to create a diagram and recorded a video explaining the media streaming setup between two houses.

[TO DO: Add the link]

📂 Committing Changes to Version Control

I followed version control best practices by working from an issue-specific branch and submitting my updates through a pull request to the main repository on GitHub.

![Version Control](assets/Screenshot%202025-06-09%20at%2014.13.27.png)

### Questions 

Certainly — here are refined, expert-level responses in 2–3 lines each:

---

**What was the scope of the business use-case?**
To enable private, low-latency media streaming from a Jellyfin server in House A to a smart TV in House B, without exposing any services to the public internet, using direct L3 connectivity between both homes.

**What are the pros and cons of different design decisions?**
The direct routed setup provides low overhead and full control, but lacks high availability and introduces operational complexity due to manual IP and route management. It's secure but not scalable by default.

**Defend your design choices**
Using a dedicated point-to-point network avoids NAT traversal and minimizes latency. Static subnets and explicit routing ensure predictability, while white box devices allow for custom firewalling and monitoring.

**What would be a recovery plan for this design?**
The recovery plan would include pre-imaged replacement devices, offline backups of server and network configs, and documented IP allocations and routing logic to allow quick restoration of connectivity.

**What would this plan look like at scale if you extended it to entire block?**
At scale, this would evolve into a hub-and-spoke or mesh topology, with VLAN segmentation per house, centralized routing/firewalling, DHCP with reservations, and orchestration via Ansible or SDN controllers.

**What would you do to resolve overlapping networking conflicts?**
I would assign unique, non-overlapping CIDR blocks to each house based on a predefined address plan, and in edge cases, apply 1:1 NAT or policy-based routing to resolve legacy or static IP constraints.

**What have you done to security harden this design?**
All services are isolated from the internet, routing is explicitly controlled, and devices are physically secured. The design limits the attack surface and avoids dynamic discovery protocols across boundaries.
