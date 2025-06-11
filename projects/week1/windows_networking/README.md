# Journal

## Developer Enviroment

Screenshot from the Windows Virtual Machine we setup in AWS

![Windows VM](assets/Screenshot%202025-06-11%20at%2007.25.00.png)

## IPConfig

```sh
PS C:\Users\Administrator> ipconfig

Windows IP Configuration


Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . : ec2.internal
   Link-local IPv6 Address . . . . . : fe80::3e27:b27a:28ed:c154%3
   IPv4 Address. . . . . . . . . . . : 10.200.123.12
   Subnet Mask . . . . . . . . . . . : 255.255.255.240
   Default Gateway . . . . . . . . . : 10.200.123.1

Ethernet adapter Ethernet 2:

   Connection-specific DNS Suffix  . : ec2.internal
   Link-local IPv6 Address . . . . . : fe80::c54b:2e90:88e3:a830%10
   IPv4 Address. . . . . . . . . . . : 10.200.123.132
   Subnet Mask . . . . . . . . . . . : 255.255.255.240
   Default Gateway . . . . . . . . . : 10.200.123.129
```

This ipconfig output shows the network configuration of a Windows VM hosted on AWS EC2 based on the ec2.internal domain.

🔍 Key Info:
The VM has two network adapters: Ethernet and Ethernet 2, each connected to a different subnet.

Each adapter has:

A private IPv4 address (e.g., 10.200.123.12)

A subnet mask of 255.255.255.240 (equivalent to /28, allowing 16 IP addresses per subnet)

A default gateway, which is the router IP used to reach external networks (e.g., 10.200.123.1)

## Ping

```sh
PS C:\Users\Administrator> ping -t www.aws.amazon.com

Pinging dr49lng3n1n2s.cloudfront.net [99.84.188.14] with 32 bytes of data:
Reply from 99.84.188.14: bytes=32 time<1ms TTL=247
Reply from 99.84.188.14: bytes=32 time=1ms TTL=247
Reply from 99.84.188.14: bytes=32 time<1ms TTL=247
Reply from 99.84.188.14: bytes=32 time<1ms TTL=247
Reply from 99.84.188.14: bytes=32 time<1ms TTL=247
Reply from 99.84.188.14: bytes=32 time<1ms TTL=247

Ping statistics for 99.84.188.14:
    Packets: Sent = 6, Received = 6, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms
```

This output shows a **continuous ping (`-t`)** to `www.aws.amazon.com`, which resolves to a **CloudFront edge server** (`99.84.188.14`).

✅ The VM is successfully reaching the server with **very low latency** (0–1 ms), indicating:

* The network connection is stable
* The server is geographically or logically close (possibly same AWS region)
* No packet loss (6/6 replies received)

This is a quick way to check **connectivity and latency** to a specific web service.


## Trace Route

```sh
PS C:\Users\Administrator> tracert www.aws.amazon.com

Tracing route to dr49lng3n1n2s.cloudfront.net [99.84.188.78]
over a maximum of 30 hops:

  1    22 ms    61 ms    66 ms  216.182.239.157
  2     *        *        *     Request timed out.
  3     *        *        *     Request timed out.
  4     *        *        *     Request timed out.
  5     *        *        *     Request timed out.
  6     *        *        *     Request timed out.
  7     *        *        *     Request timed out.
  8     *        *        *     Request timed out.
  9     *        *        *     Request timed out.
 10     *        *        *     Request timed out.
```

This `tracert` (trace route) command shows how your **Windows VM tries to reach `www.aws.amazon.com`**, which resolves to a CloudFront server (`99.84.188.78`). Here's what it tells us:

* **Hop 1 (`216.182.239.157`) responds**: This is likely a **local AWS network gateway** (first reachable router).
* **Hops 2–10 timeout (`*`)**: These hops don't respond to ICMP packets — often due to:

  * **Firewall or network security policies** blocking trace responses
  * **Intermediate routers or CDNs** (like CloudFront) deliberately **dropping ICMP** for security or performance reasons

📌 **Conclusion**: The route beyond your local gateway is hidden, but this **doesn't mean there's a connectivity issue** — especially since your earlier `ping` was successful. Many cloud networks (especially AWS) limit traceroute visibility.


## Netstat

```sh
PS C:\Users\Administrator> netstat

Active Connections

  Proto  Local Address          Foreign Address        State
  TCP    10.200.123.12:3389     35:25258               ESTABLISHED
  TCP    10.200.123.12:50204    104.208.203.89:https   ESTABLISHED
```

This `netstat` output shows two active TCP connections: one on port `3389`, indicating a Remote Desktop session to the VM, and another on port `50204` connected to an external server over HTTPS (`104.208.203.89`), likely for secure web communication or updates.


## Route

```sh
PS C:\Users\Administrator> route print
===========================================================================
Interface List
  3...02 8e 36 12 99 bd ......Amazon Elastic Network Adapter
 10...02 27 ab dd 34 01 ......Amazon Elastic Network Adapter #2
  1...........................Software Loopback Interface 1
===========================================================================

IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0     10.200.123.1    10.200.123.12     20
          0.0.0.0          0.0.0.0   10.200.123.129   10.200.123.132     20
     10.200.123.0  255.255.255.240         On-link     10.200.123.12    276
    10.200.123.12  255.255.255.255         On-link     10.200.123.12    276
    10.200.123.15  255.255.255.255         On-link     10.200.123.12    276
   10.200.123.128  255.255.255.240         On-link    10.200.123.132    276
   10.200.123.132  255.255.255.255         On-link    10.200.123.132    276
   10.200.123.143  255.255.255.255         On-link    10.200.123.132    276
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    331
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    331
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    331
  169.254.169.123  255.255.255.255         On-link     10.200.123.12     40
  169.254.169.249  255.255.255.255         On-link     10.200.123.12     40
  169.254.169.250  255.255.255.255         On-link     10.200.123.12     40
  169.254.169.251  255.255.255.255         On-link     10.200.123.12     40
  169.254.169.253  255.255.255.255         On-link     10.200.123.12     40
  169.254.169.254  255.255.255.255         On-link     10.200.123.12     40
        224.0.0.0        240.0.0.0         On-link         127.0.0.1    331
        224.0.0.0        240.0.0.0         On-link     10.200.123.12    276
        224.0.0.0        240.0.0.0         On-link    10.200.123.132    276
  255.255.255.255  255.255.255.255         On-link         127.0.0.1    331
  255.255.255.255  255.255.255.255         On-link     10.200.123.12    276
  255.255.255.255  255.255.255.255         On-link    10.200.123.132    276
===========================================================================
Persistent Routes:
  None

IPv6 Route Table
===========================================================================
Active Routes:
 If Metric Network Destination      Gateway
  1    331 ::1/128                  On-link
  3     40 fd00:ec2::123/128        On-link
  3     40 fd00:ec2::250/128        On-link
  3     40 fd00:ec2::253/128        On-link
  3     40 fd00:ec2::254/128        On-link
  3    276 fe80::/64                On-link
 10    276 fe80::/64                On-link
  3    276 fe80::3e27:b27a:28ed:c154/128
                                    On-link
 10    276 fe80::c54b:2e90:88e3:a830/128
                                    On-link
  1    331 ff00::/8                 On-link
  3    276 ff00::/8                 On-link
 10    276 ff00::/8                 On-link
===========================================================================
Persistent Routes:
  None
```
This `route print` output lists the routing table of your Windows VM, showing how network traffic is directed. It includes two active network interfaces (`Ethernet` and `Ethernet #2`), both connected to AWS subnets. The table defines default gateways (`0.0.0.0`) for outbound traffic, local subnet routes for internal communication, and special routes for metadata access (`169.254.*`). IPv6 routes are also present, mainly for local and AWS-specific communication.
