# 🌐 EXP-NET-FUNDAMENTALS-2025-Q2

Welcome to my repository for the **Networking Fundamentals Bootcamp (Q2 2025)** organized by **ExamPro**.  
Here you’ll find all of my hands-on labs, diagrams, notes, and weekly reflection journals for Linux, Windows, and Cloud networking topics.

---

## 🗂️ Repository Structure

```txt
.
├── journal/
│   ├── week1/
│   │   ├── JOURNAL.md          # Reflections & summary
│   │   └── assets/             # Images used in journal
│   └── week2/
│       ├── JOURNAL.md
│       └── assets/
├── projects/
│   └── week1/
│       ├── diagramming/            # Home media-server topology
│       ├── env_automation/         # IaC (CloudFormation, Bicep, Terraform)
│       ├── ip-address-management/  # Static & dynamic IP tasks
│       ├── cloud_networking/       # VPC setup in AWS, Azure, GCP
│       ├── linux_firewall_rules/   # ufw & firewalld configs
│       ├── linux_networking/       # EC2 cross-pings & tcpdump
│       ├── packet_tracer/          # Cisco DHCP simulations
│       ├── windows_firewall_rules/ # HTTP service rules
│       └── windows_networking/     # ipconfig, route print, netstat
├── week2/                          # All labs & configs for Week 2
│   ├── cisco_modeling_lab/.        # topology exploration
│   │   ├── assets/
│   │   └── README.md
│   ├── cml_vpn/                    # site-to-site vpn 
│   │   ├── assets/
│   │   └── README.md
│   ├── cml_wireshark/              # packet capture lab
│   │   ├── assets/
│   │   └── README.md
│   ├── forward_proxy/              # Squid configs & scripts
│   ├── ha_proxy/                   # HAProxy notes & README.md
│   └── reverse_proxy/              # Nginx reverse-proxy configs
├── .gitignore
└── README.md                       # ← you are here!
````

---

## ✍️ Week 1 Journal Highlights

| Key Activity                                 | Take-away                                                                 |
| -------------------------------------------- | ------------------------------------------------------------------------- |
| **Ubuntu, Red Hat & Windows EC2 setup**      | Connected via SSH/RDP and validated baseline connectivity.                |
| **Custom VPC with public & private subnets** | Deployed entirely with CloudFormation.                                    |
| **Cisco Packet Tracer DHCP simulation**      | Observed the full DORA cycle at L2/L3.                                    |
| **Windows networking deep-dive**             | Explored *ipconfig*, *route print*, *netstat*, plus HTTP hosting.         |
| **Firewalling on Linux**                     | Blocked outbound port 4000 with **ufw**, **firewalld**, and **iptables**. |
| **Inter-EC2 connectivity tests**             | Verified Ubuntu ↔ Red Hat pings and captured packets with *tcpdump*.      |
| **Multi-cloud VPC exploration**              | Replicated similar subnet/VPC architecture in Azure & GCP.                |

---

## ✍️ Week 2 Journal Highlights

| Lab / Topic                  | Summary                                                                                                                                                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Cisco Modeling Lab (CML)** | Attempted local install on Apple Silicon (M3 Pro macOS 15.5) — blocked by architecture mismatch. Studied topology/traffic flow theoretically (external connector → router → L2 switch → Alpine server). |
| **CML Site-to-Site VPN**     | Built VPN between simulated on-prem Alpine server (CML) and an Ubuntu EC2 in AWS: configured Customer Gateway, Virtual Private Gateway, IPsec params, and route propagation.                            |
| **Wireshark Packet Capture** | Captured traffic for simple `ping example.com`: inspected DNS query/response, ARP resolution, then ICMP echo/reply — visualized end-to-end packet flow.                                                 |
| **Forward Proxy (Squid)**    | Deployed Squid on Ubuntu EC2 (private subnet). Allowed HTTP/HTTPS from Windows EC2 (`10.200.123.128/28`) via port 3128; demonstrated internet egress without direct public IP.                          |
| **Reverse Proxy (Nginx)**    | Used Nginx to expose an internal web service on Windows EC2 to the internet. External requests hit Ubuntu proxy first, then forward to Windows via private IP.                                          |
| **HAProxy Load Balancer**    | Explored configuration on Ubuntu EC2; hands-on paused due to missing sample configs. Documented parity with AWS ELB for layer-4/7 load balancing.                                                       |

---

## 📌 How to Use This Repo

1. **Clone & explore**:

   ```bash
   git clone https://github.com/gloriamacia/exp-net-fundamentals-2025-Q2.git
   cd exp-net-fundamentals-2025-Q2
   ```
2. **Reproduce a lab**: open the corresponding subdirectory (e.g., `week2/forward_proxy`) and follow its `README.md`.
3. **View diagrams**: all PNG/SVG assets live in each `/assets` folder.
4. **Read reflections**: weekly thoughts are under `journal/week*/JOURNAL.md`.


