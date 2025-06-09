## 🎯 **Goal**

Set up a secure AWS Virtual Private Cloud (VPC) and launch a Windows, Ubuntu & RedHat instance as part of the networking bootcamp, following best practices for networking, access control, and remote connectivity.

---

## 🧱 **What I Did**

### 1. 🏗️ **Created a Custom VPC**

* Defined a **CIDR block**: `10.200.123.0/24`
* Set up **1 public** and **1 private subnet**
* Enabled **DNS hostnames and resolution**

> To ensure clear instance identification and simplified networking.

![VPC Setup](assets/Screenshot%202025-06-09%20at%2014.40.37.png)

![VPC Setup](assets/Screenshot%202025-06-09%20at%2014.41.17.png)


---

### 2. 🔐 **Generated Key Pairs**

* Created and downloaded:

  * `.pem` for Linux
  * `.ppk` for Windows (via PuTTYgen which I ended up not using as I am on MacOs)
* Ensured correct naming and region-specific setup

> To allow secure login into instances without exposing credentials.

![Key Pairs](assets/Screenshot%202025-06-09%20at%2014.43.38.png)

---

### 3. 💻 **Launched a Windows Instance**

* Selected **T3.large** as the instance type
* Configured **Security Group** to:

  * Open **RDP access (port 3389)** only to my own IP address

> This minimizes external attack surface during setup.

---

### 4. 🌐 **Attached a Private Network Interface**

* Created a **second ENI** for internal-only communication
* Attached it to the instance for non-internet traffic

> This supports safer management tasks without risking connection drops.

![ENI](assets/Screenshot%202025-06-09%20at%2014.50.33.png)

![ENI](assets/Screenshot%202025-06-09%20at%2014.51.07.png)


---

### 5. 🖥️ **Connected via RDP**

* Retrieved the **administrator password** using the `.pem` file
* Successfully accessed the instance via Remote Desktop

> Confirmed secure login and post-launch manageability.

![RDP](assets/Screenshot%202025-06-09%20at%2014.55.36.png)


---

### 6. 📌 **Assigned an Elastic IP**

* Allocated an **Elastic IP**
* Attached it to the Windows instance

> To maintain consistent public access even after restarts.

![Elastic IP](assets/Screenshot%202025-06-09%20at%2016.54.08.png)

![Elastic IP](assets/Screenshot%202025-06-09%20at%2016.46.10.png)


### 7. **Ubuntu & RedHat** 

I repeated the same process for an Ubuntu Server and a Redhat Server. 

![ubuntu](assets/Screenshot%202025-06-09%20at%2016.45.47.png)

![redhat](assets/Screenshot%202025-06-09%20at%2016.53.47.png)

