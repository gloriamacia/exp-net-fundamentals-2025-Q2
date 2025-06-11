# Linux Networking 

### ✅ Linux Networking: Verifying EC2-to-EC2 Communication

In this setup, we deployed two EC2 instances — one running **Ubuntu** and the other **Red Hat Enterprise Linux** — within the same VPC and subnet. Each instance has two network interfaces (enX0 and enX1) with unique private IP addresses.

We aimed to **verify bidirectional communication** between the instances using their private IPs.

1. **From Ubuntu**, we used `ping` to send ICMP packets to Red Hat’s secondary interface at `10.200.123.137`.
2. **On Red Hat**, we installed `tcpdump` and used it to capture ICMP traffic on `enX1`. The tool confirmed that echo requests and replies were being exchanged — proving network connectivity.
3. We also performed the **reverse ping from Ubuntu to Red Hat’s primary IP (10.200.123.9)** and confirmed responses.

This validates that both interfaces can communicate over the internal network, which is essential for simulating more complex multi-interface architectures or testing firewall rules and routing configurations.

![proof of work](assets/Screenshot%202025-06-11%20at%2010.08.34.png)

#### Code Samples: Ubuntu → RedHat Ping Test

From Ubuntu (`10.200.123.6`), ping RedHat's secondary interface (`10.200.123.137`):

```sh
ping 10.200.123.137
```

```
64 bytes from 10.200.123.137: icmp_seq=1 ttl=64 time=2.05 ms
...
15 packets transmitted, 15 received, 0% packet loss
```

### 🔍 tcpdump on RedHat

On RedHat, after installing tcpdump:

```sh
sudo yum install tcpdump
sudo tcpdump -i enX1 icmp
```

Captured traffic:

```
ICMP echo request, id 1126, seq 1
ICMP echo reply, id 1126, seq 1
...
```

### 🎯 Result

* Ping confirms Ubuntu can reach RedHat on both interfaces.
* Tcpdump confirms ICMP packets arrive and are replied to.
* Networking setup works as expected in your VPC.

## 📡 `wget` vs `curl` – Key Differences

* **`curl -I`** is ideal for inspecting HTTP **headers only** and does **not follow redirects** by default (`-L` to enable).
* **`wget`** downloads the **entire file content** and **follows redirects** automatically.

Use `curl` for lightweight checks (e.g. API response headers) and `wget` for downloading full resources.


`curl` example:

```sh
ubuntu@ip-10-200-123-6:~$ curl -I https://aws.amazon.com/
HTTP/2 200
content-type: text/html;charset=UTF-8
date: Wed, 11 Jun 2025 07:47:32 GMT
server: Server
x-frame-options: SAMEORIGIN
x-xss-protection: 1; mode=block
strict-transport-security: max-age=47304000; includeSubDomains
x-amz-id-1: 06656E0876A5426CA442
cache-control: no-store, no-cache, must-revalidate
last-modified: Fri, 06 Jun 2025 00:01:44 GMT
vary: accept-encoding
set-cookie: aws-priv=eyJ2IjoxLCJldSI6MCwic3QiOjB9; Version=1; Comment="Anonymous cookie for privacy regulations"; Domain=.aws.amazon.com; Max-Age=31536000; Expires=Thu, 11 Jun 2026 07:47:32 GMT; Path=/; Secure
set-cookie: aws_lang=en; Domain=.amazon.com; Path=/
x-content-type-options: nosniff
x-cache: Miss from cloudfront
via: 1.1 b13c6d10b44fd12a68a8ca01d540a750.cloudfront.net (CloudFront)
x-amz-cf-pop: IAD89-C2
x-amz-cf-id: 6EwA2dXVywtv9YWz5S3wseZRUvEjIgqoURsch4PSFatizQczCoZ6cA==
```

`wget` example:

```sh
ubuntu@ip-10-200-123-6:~$ wget aws.amazon.com
--2025-06-11 07:48:03--  http://aws.amazon.com/
Resolving aws.amazon.com (aws.amazon.com)... 99.84.188.14, 99.84.188.15, 99.84.188.78, ...
Connecting to aws.amazon.com (aws.amazon.com)|99.84.188.14|:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: https://aws.amazon.com/ [following]
--2025-06-11 07:48:03--  https://aws.amazon.com/
Connecting to aws.amazon.com (aws.amazon.com)|99.84.188.14|:443... connected.
HTTP request sent, awaiting response... 200
Length: unspecified [text/html]
Saving to: ‘index.html’

index.html              [ <=>                ]   1.93M  --.-KB/s    in 0.02s

2025-06-11 07:48:03 (100 MB/s) - ‘index.html’ saved [2024789]
```