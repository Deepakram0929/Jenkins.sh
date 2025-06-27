# Jenkins Installation Script on Amazon Linux

This repository contains a shell script to install **Jenkins**, **Java**, **Git**, and **Maven** on an Amazon Linux instance (Amazon Linux 2 or similar).

## 📜 Prerequisites

- Amazon EC2 instance with Amazon Linux 2
- SSH access with `sudo` privileges
- Internet connection on the instance

## 🔧 Script Details

The script performs the following:

1. Installs Maven and Git
2. Installs Java (both Java 8 and OpenJDK 21)
3. Adds Jenkins repository and imports Jenkins GPG key
4. Installs Jenkins
5. Starts Jenkins service and enables it on boot
6. Displays the Jenkins initial admin password

## 🚀 How to Run

### Step 1: SSH into your EC2 instance

```bash
ssh -i your-key.pem ec2-user@your-ec2-public-ip
