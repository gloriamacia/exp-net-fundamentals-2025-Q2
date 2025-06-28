# Journal Week 2 

## Forward Proxy 

As part of the project, I successfully implemented a forward proxy solution using Squid on an Ubuntu EC2 instance within a private subnet. The proxy server was configured to allow HTTP/HTTPS traffic from a Windows EC2 instance that lacked direct internet access. I adjusted the Squid configuration to permit traffic from the Windows subnet (`10.200.123.128/28`), exposed the necessary port (3128) via security group rules, and pointed the Windows EC2's proxy settings to the Ubuntu proxy’s private IP. 

## Reverse Proxy 

I implemented a reverse proxy using Nginx on an Ubuntu EC2 instance to expose a web service running on a Windows EC2 within a private subnet. The goal was to allow external access to the internal application without assigning a public IP to the Windows instance. By configuring Nginx to forward incoming HTTP requests to the Windows host's private IP, I was able to securely route external traffic through the Ubuntu proxy, preserving internal network isolation while enabling controlled public access.

