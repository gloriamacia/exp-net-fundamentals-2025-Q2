# Reverse Proxy 

## 🎯 Goal
Expose a private-subnet web application running on **Windows EC2 (`10.200.123.132`)** to the public internet **without** giving the Windows box a public IP.  

An **Ubuntu EC2** in the same subnet serves as an **Nginx reverse proxy**; all external HTTP traffic terminates there and is forwarded to the Windows backend.

---

## ✅ Step-by-Step Implementation

1. **Confirm network topology**  
   * VPC CIDR `10.200.123.0/24`.  
   * Both instances reside in the private subnet `10.200.123.128/28`.  
   * Ubuntu EC2 has an Elastic IP and routes `0.0.0.0/0 → IGW`.

2. **Install Nginx on Ubuntu EC2**
   ```bash
   sudo apt update
   sudo apt install nginx -y
    ````

3. **Configure Nginx as a reverse proxy**

   ```bash
   sudo bash -c 'cat > /etc/nginx/sites-available/default' <<'EOF'
   server {
       listen 80;
       server_name _;

       location / {
           proxy_pass http://10.200.123.132:80;   # Windows EC2 private IP
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       }
   }
   EOF

   sudo systemctl restart nginx
   ```
![proxy configuration](./assets/Screenshot%202025-06-23%20at%2016.13.55.png)

4. **Adjust security groups**

   | Instance        | Direction | Port | Source                                     |
   | --------------- | --------- | ---- | ------------------------------------------ |
   | **Ubuntu EC2**  | Inbound   | 80   | `0.0.0.0/0`                                |
   | **Windows EC2** | Inbound   | 80   | *Ubuntu EC2 private IP* |

5. **Spin up a quick test server on Windows EC2**

   ```powershell
   cd $env:USERPROFILE
   echo "Hello from Windows EC2" > index.html
   python -m http.server 80
   ```
![localhost](./assets/Screenshot%202025-06-23%20at%2016.17.06.png)

1. **Validate end-to-end**

   * In a browser: `http://<Ubuntu-Elastic-IP>` → should display **“Hello from Windows EC2”**.


![Website working](./assets/Screenshot%202025-06-23%20at%2016.25.02.png)

External users now reach the Windows-hosted application via the Ubuntu proxy’s public IP, while the Windows instance remains privately addressed and secured inside the subnet.

