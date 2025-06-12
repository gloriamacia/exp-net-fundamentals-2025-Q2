# Linux Firewall Rules

## 🔒 Blocking Outbound Traffic on Linux

This project demonstrates how to block outbound traffic on Linux using two common firewall tools:

* `ufw` (Ubuntu)
* `firewalld` (Red Hat)

### 📡 Test Case

We test connectivity to `aardwolf.org` on **TCP port 4000**, a public MUD server, using `telnet`.

---

### ✅ Ubuntu Example (UFW)

```bash
# Initial connection succeeds
ubuntu@ip-10-200-123-6:~$ telnet aardwolf.org 4000

Welcome to Aardwolf, Gloriamacia.

We need to ask a few questions to help you create your character, then
you will be placed into the game and ready to explore.
---------------------------------------------------------------------------

Please choose a password for Gloriamacia or 'Q' to quit:
#############################################################################
##[                                               ]##########################
##[        --- Welcome to Aardwolf MUD ---        ]############ /"  #########
##[                                               ]########  _-`"""', #######
##[         Players Currently Online: 188         ]#####  _-"       )  ######
##[                                               ]### _-"          |  ######
################################################### _-"            ;  #######
######################################### __---___-"              |  ########
######################################  _"   ,,                  ;  `,,  ####
#################################### _-"    ;''                 |  ,'  ; ####
##################################  _"      '                    `"'   ; ####
###########################  __---;                                 ,' ######
######################## __""  ___                                ,' ########
#################### _-""   -"" _                               ,' ##########
################### `-_         _                              ; ############
#####################  ""----"""   ;                          ; #############
#######################  /          ;                        ; ##############
#####################  /             ;                      ; ###############
###################  /                `                    ; ################
#################  /                                      ; #################

# Block outbound traffic on port 4000
ubuntu@ip-10-200-123-6:~$ sudo ufw deny out 4000/tcp
Skipping adding existing rule
Skipping adding existing rule (v6)
ubuntu@ip-10-200-123-6:~$ sudo ufw status
Status: inactive
ubuntu@ip-10-200-123-6:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
ubuntu@ip-10-200-123-6:~$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
4000/tcp                   DENY OUT    Anywhere
4000/tcp (v6)              DENY OUT    Anywhere (v6)

ubuntu@ip-10-200-123-6:~$ telnet aardwolf.org 4000
Trying 23.111.142.226...
telnet: Unable to connect to remote host: Connection timed out
```

---

### ✅ Red Hat Example (firewalld)

```bash

# Install Telnet
sudo yum install telnet -y
# Initial connection succeeds
telnet aardwolf.org 4000

Welcome to Aardwolf, Gloriamacia.

We need to ask a few questions to help you create your character, then
you will be placed into the game and ready to explore.
---------------------------------------------------------------------------

Please choose a password for Gloriamacia or 'Q' to quit:
#############################################################################
##[                                               ]##########################
##[        --- Welcome to Aardwolf MUD ---        ]############ /"  #########
##[                                               ]########  _-`"""', #######
##[         Players Currently Online: 188         ]#####  _-"       )  ######
##[                                               ]### _-"          |  ######
################################################### _-"            ;  #######
######################################### __---___-"              |  ########
######################################  _"   ,,                  ;  `,,  ####
#################################### _-"    ;''                 |  ,'  ; ####
##################################  _"      '                    `"'   ; ####
###########################  __---;                                 ,' ######
######################## __""  ___                                ,' ########
#################### _-""   -"" _                               ,' ##########
################### `-_         _                              ; ############
#####################  ""----"""   ;                          ; #############
#######################  /          ;                        ; ##############
#####################  /             ;                      ; ###############
###################  /                `                    ; ################
#################  /                                      ; #################

sudo yum install -y firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Add direct firewall rule
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -p tcp --dport 4000 -j REJECT
sudo firewall-cmd --reload

Trying 23.111.142.226...
telnet: Unable to connect to remote host: Connection timed out
```


