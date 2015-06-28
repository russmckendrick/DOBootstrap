## Enable SWAP
fallocate -l 4G /swapfile  
chmod 600 /swapfile  
mkswap /swapfile  
swapon /swapfile  
echo "/swapfile none swap sw 0 0" >> /etc/fstab  
echo "## Make Swap betterer" >> /etc/sysctl.conf  
echo "vm.swappiness = 10" >> /etc/sysctl.conf  
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
 
## Install and configure the basics
yum install -y epel-release deltarpm && yum install -y fail2ban vim-enhanced ntpd git
cat >> /etc/fail2ban/jail.local << FAIL2BAN_CONFIG 
[sshd]
enabled = true
maxretry = 3
bantime  = 86400
FAIL2BAN_CONFIG
 
## Set the timezone
timedatectl set-timezone Europe/London
 
## Run an update
yum update -y
 
## Set the services to start on boot
systemctl enable firewalld && systemctl enable fail2ban && systemctl enable ntpd
 
## Prompt for a reboot
echo "-------------------------------"
echo "DO stuff applied, please reboot"
echo "-------------------------------"