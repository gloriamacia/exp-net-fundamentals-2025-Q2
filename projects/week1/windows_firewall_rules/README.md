# Windows Firewall Rules

I set up a simple website on a Windows EC2 instance using Python’s built-in HTTP server on port 8000. To make it accessible externally, I configured both the Windows Firewall and the EC2 Security Group to allow inbound traffic on that port.

## Start Server

```sh
PS C:\Users\Administrator\Desktop> python -m http.server 8000
Serving HTTP on :: port 8000 (http://[::]:8000/) ...
::ffff:127.0.0.1 - - [11/Jun/2025 06:44:56] "GET / HTTP/1.1" 200 -
```
### Screenshots

![Screenshot 1](assets/Screenshot%202025-06-11%20at%2008.30.24.png)  

## Curl Server

By default, Windows Firewall blocks incoming traffic unless an inbound rule allows it. To serve the website on port 8000, I created a new inbound rule for TCP traffic on that port. After applying the rule, I was able to access the site from the browser via localhost:8000.

![Screenshot 2](assets/Screenshot%202025-06-11%20at%2008.45.11.png)  

```sh
PS C:\Users\Administrator> curl http://127.0.0.1:8000


StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html>
                    <html lang="en">
                    <head>
                      <meta charset="UTF-8" />
                      <meta name="viewport"
                    content="width=device-width,
                    initial-scale=1.0"/>
                      <title>Networking Fundamentals
                    Bootcamp</title>
                      <...
RawContent        : HTTP/1.0 200 OK
                    Content-Length: 2574
                    Content-Type: text/html
                    Date: Wed, 11 Jun 2025 06:44:56 GMT
                    Last-Modified: Wed, 11 Jun 2025 06:27:27
                    GMT
                    Server: SimpleHTTP/0.6 Python/3.13.4

                    <!DOCTYPE htm...
Forms             : {}
Headers           : {[Content-Length, 2574], [Content-Type,
                    text/html], [Date, Wed, 11 Jun 2025
                    06:44:56 GMT], [Last-Modified, Wed, 11
                    Jun 2025 06:27:27 GMT]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 2574
```

Aftwards, I tried to connect from my Mac (outside the Windows VM)

```sh
curl http://54.81.165.126:8000    
curl: (28) Failed to connect to 54.81.165.126 port 80 after 75006 ms: Couldn't connect to server
```

I could not connect because the EC2 security group also needed to be updated. Aftewards I could also connect successfully. 

Troubleshooting Access to the Web Server:

✅ **Firewall Issue (Windows)**:
The local Windows Defender Firewall was initially blocking incoming traffic on port 8000.
**Resolution**: Manually added an inbound rule to allow TCP traffic on port 8000.

✅ **EC2 Security Group Restriction**:
The EC2 instance's security group did not allow external access on port 8000.
**Resolution**: Updated the security group to permit inbound traffic on TCP port 8000 from my IP.

![Screenshot 4](assets/Screenshot%202025-06-11%20at%2008.57.04.png)  
![Screenshot 3](assets/Screenshot%202025-06-11%20at%2008.54.54.png)  


```sh
 curl http://54.81.165.126:8000 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Networking Fundamentals Bootcamp</title>
  <style>
    :root {
      --primary: #1f2937;
      --accent: #3b82f6;
      --bg: #f9fafb;
      --text: #111827;
      --muted: #6b7280;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

```

## Proof of Work

![Screenshot 5](assets/Screenshot%202025-06-11%20at%2008.57.25.png)

