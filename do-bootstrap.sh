echo "======================================================================================"
echo ""
echo "Digital Ocean CentOS7 Bootstrap"
echo ""
echo "This script will set configure the basics on a CentOS7 Digital Ocean droplet."
echo "See https://media-glass.es/2015/06/28/digital-ocean-bootstrap/ for details."
echo ""
echo "======================================================================================"
echo ""
echo "=> Enabling SWAP ..."
fallocate -l 4G /swapfile > /dev/null 2>&1
chmod 600 /swapfile > /dev/null 2>&1
mkswap /swapfile > /dev/null 2>&1
swapon /swapfile  > /dev/null 2>&1
echo "/swapfile none swap sw 0 0" >> /etc/fstab  
echo "## Make Swap betterer" >> /etc/sysctl.conf  
echo "vm.swappiness = 10" >> /etc/sysctl.conf  
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
echo "=> Done!"
echo "=> Installing EPEL, fail2ban, ntp, git and vim-enhanced ..."
## Install and configure the basics
yum install -y epel-release deltarpm > /dev/null 2>&1
yum install -y fail2ban vim-enhanced ntp git > /dev/null 2>&1
cat >> /etc/fail2ban/jail.local << FAIL2BAN_CONFIG 
[sshd]
enabled = true
maxretry = 3
bantime  = 86400
FAIL2BAN_CONFIG
echo "=> Done!"
echo "=> Setting the timezone to Europe/London ..."
timedatectl set-timezone Europe/London
echo "=> Done!"
echo "=> Running a yum update ..."
yum update -y > /dev/null 2>&1
echo "=> Done!"
echo "=> Setting the installed services to start on boot ..."
systemctl enable firewalld > /dev/null 2>&1
systemctl enable fail2ban > /dev/null 2>&1
systemctl enable ntpd > /dev/null 2>&1
echo "=> Done!"
echo ""
echo "======================================================================================"
echo ""
echo "Digital Ocean basics applied, you should reboot now"
echo ""
echo "======================================================================================"
