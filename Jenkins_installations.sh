select 
# Amazon Machine Image (AMI)
# Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type

sudo yum install maven -y git
sudo yum install java-1.8.0 -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-21-openjdk
sudo yum install jenkins
sudo systemctl daemon-reload
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
