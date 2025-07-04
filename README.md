# Jenkins Installation Script on Amazon Linux

This repository contains a shell script to install **Jenkins**, **Java**, **Git**, and **Maven** on an Amazon Linux instance (Amazon Linux 2 or similar).

## Prerequisites

- Amazon EC2 instance with Amazon Linux 2
- SSH access with `sudo` privileges
- Internet connection on the instance

## Script Details

The script performs the following:

1. Installs Maven and Git
2. Installs Java (both Java 8 and OpenJDK 21)
3. Adds Jenkins repository and imports Jenkins GPG key
4. Installs Jenkins
5. Starts Jenkins service and enables it on boot
6. Displays the Jenkins initial admin password

## How to Run

### Step 1: SSH into your EC2 instance

```bash
ssh -i your-key.pem ec2-user@your-ec2-public-ip

```
### Step 2: Download the script or create a new file
```
nano install-jenkins.sh
```
Copy and paste the following content into the file:
```
#!/bin/bash
sudo yum install maven -y git
sudo yum install java-1.8.0 -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo yum install fontconfig java-21-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
### Step 3: Make the script executable
```
chmod +x install-jenkins.sh
```
### Step 4: Run the script
```
./install-jenkins.sh
```
### Step5; Access Jenkins
Open your browser and go to:
```
http://<your-ec2-public-ip>:8080
```

## Note: 
Open Port 8080
Make sure to allow port 8080 in your EC2 Security Group to access Jenkins from your browser.

### If you using t2.micro 2023 AMI 
scripts to disk allocate
```
#!/bin/bash

echo " Checking /tmp usage..."
df -h /tmp

echo " Top large files in /tmp:"
sudo du -sh /tmp/* 2>/dev/null | sort -hr | head -n 10

echo -e "\n Cleaning /tmp directory..."
sudo rm -rf /tmp/*
sudo mkdir -p /tmp
sudo chmod 1777 /tmp
echo "/tmp cleaned."

echo -e "\n Checking if /tmp is mounted as tmpfs..."
if mount | grep -q '/tmp type tmpfs'; then
    echo " Detected tmpfs. Expanding /tmp to 2G..."
    sudo mount -o remount,size=2G /tmp

    echo " Persist this change in /etc/fstab? (y/n)"
    read persist
    if [[ $persist == "y" ]]; then
        sudo sed -i '/\/tmp/d' /etc/fstab
        echo "tmpfs /tmp tmpfs defaults,size=2G 0 0" | sudo tee -a /etc/fstab
        echo " fstab updated."
    fi
else
    echo "/tmp is not tmpfs. Consider increasing the disk size or reconfiguring Jenkins temp dir."
fi

echo -e "\n Done. Recommend restarting the Jenkins agent."
```

