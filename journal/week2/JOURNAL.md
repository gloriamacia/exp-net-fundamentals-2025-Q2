# Journal Week 2 

## Cisco Modeling Lab (CML)

In this part of the project, I attempted to set up Cisco Modeling Labs (CML) on my MacBook with an M3 Pro chip running macOS Sequoia 15.5, but the installation was unsuccessful due to architectural incompatibility between Apple Silicon and CML. As a result, I was unable to run the hands-on lab environment locally. Instead, I studied the network topology and traffic flow theoretically using the provided lecture materials and diagrams, which included a setup with an external connector, a Cisco router, a Layer 2 switch, and an Alpine server. This helped me understand how traffic would flow from the server to the internet via the simulated network layers.

## CML Virtual Private Network (VPN)

In this part of the networking bootcamp, I followed a lab that demonstrated how to set up a site-to-site VPN between a simulated on-premises Alpine Linux server in Cisco Modeling Labs (CML) and an Ubuntu EC2 instance in AWS. The goal was to establish encrypted connectivity over the public internet and verify it using ICMP ping. While I couldn’t install CML on my M3 Mac due to compatibility issues, I could configure a customer gateway and virtual private gateway in AWS, establishing the VPN tunnel, adjusting IPsec parameters for compatibility, and enabling route propagation in AWS route tables. This exercise helped me understand the practical steps and components involved in creating a secure network bridge between on-premises environments and the cloud.

## Wireshark 

In this exercise, I used Wireshark to observe what happens at the network level when a computer sends a `ping` to external websites like `example.com` and `google.com`. My goal was to understand the underlying protocols involved in even simple commands. I captured and analyzed packets showing DNS queries (resolving domain names to IP addresses) and ARP requests (resolving IP addresses to MAC addresses), which are required before the actual ping can be sent. This helped me visualize the step-by-step process a system follows to initiate basic network communication.

## Forward Proxy 

As part of the project, I successfully implemented a forward proxy solution using Squid on an Ubuntu EC2 instance within a private subnet. The proxy server was configured to allow HTTP/HTTPS traffic from a Windows EC2 instance that lacked direct internet access. I adjusted the Squid configuration to permit traffic from the Windows subnet (`10.200.123.128/28`), exposed the necessary port (3128) via security group rules, and pointed the Windows EC2's proxy settings to the Ubuntu proxy’s private IP. 

## Reverse Proxy 

I implemented a reverse proxy using Nginx on an Ubuntu EC2 instance to expose a web service running on a Windows EC2 within a private subnet. The goal was to allow external access to the internal application without assigning a public IP to the Windows instance. By configuring Nginx to forward incoming HTTP requests to the Windows host's private IP, I was able to securely route external traffic through the Ubuntu proxy, preserving internal network isolation while enabling controlled public access.

## HA Proxy 

In this section, the goal was to configure an Ubuntu EC2 instance as an HAProxy load balancer to distribute traffic across backend servers. However, the tutorial referenced setup files that were not provided, so I couldn't complete the hands-on part. In AWS, this functionality is typically handled by Elastic Load Balancer (ELB), which offers similar capabilities as a managed service.

## Pomerium

In this section, I watched a video on Pomerium, an open-source identity-aware reverse proxy that enables Zero Trust access to internal web apps. It authenticates users based on identity before allowing access and removes the need for a VPN by integrating with providers like GitHub or Okta. Unlike VPNs, which grant broad access to the internal network once connected, Pomerium applies fine-grained, identity-based policies to each request. While more secure, many companies still rely on VPNs due to their simplicity, legacy systems, and familiarity.
