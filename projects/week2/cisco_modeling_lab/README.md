## CML

Unfortunately, I was unable to install Cisco Modeling Labs (CML) on my MacBook with M3 Pro chip running macOS Sequoia 15.5. Due to fundamental architectural incompatibilities between the Apple Silicon processor and CML's requirements, this lab environment cannot be implemented on my current system. As a result, I will proceed with the networking bootcamp by focusing on the video content, theoretical concepts, and lecture materials without the hands-on lab component.

![Network Topology](assets/Screenshot%202025-06-15%20at%2015.38.54.png)

ext-conn-0 (Cloud) → G1 → cat8000v-0 (Router) → G2/G0/0 → iosvl2-0 (Switch) → G0/1/E0 → alpine-0 (Server)

The flow:

* ext-conn-0 represents the external connection (bridges to the host system's network)
* cat8000v-0 is the Cisco router handling routing
* iosvl2-0 is a Layer 2 switch
* alpine-0 is the end server
  
When the server needs to communicate with the internet:

1. Traffic from alpine-0 goes through the switch (iosvl2-0)
2. Then through the router (cat8000v-0)
3. Finally reaches ext-conn-0 which bridges to the host system's network interface
4. From there, it can reach the internet through the host's network connection
5. Traffic flow in reverse