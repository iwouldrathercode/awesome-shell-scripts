# Update min packages
sudo apt-get update

# Add dependencies
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:schooltool-owners/2.8
sudo apt-get update

# Port forwarding
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination $(hostname -i):7080
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Install schooltool
sudo apt-get -y install schooltool
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/schooltool/standard/paste.ini
sudo service schooltool restart

# clear and show message
clear
echo "Enter IP address on a new browser tab, login with username:manager, password:schooltool, to setup school further";