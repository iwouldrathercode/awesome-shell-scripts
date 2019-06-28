# Update min packages
sudo apt-get update
sudo apt-get -y install nano 
sudo apt-get -y install git
sudo apt-get -y install openjdk-7-jdk

# Port forwarding
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination $(hostname -i):8080
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Get the package
wget http://download.forge.ow2.org/spagobi/All-In-One-SpagoBI-4.2-28042014.zip
sudo apt-get -y install zip
unzip All-In-One-SpagoBI-4.2-28042014.zip
cd SpagoBI-Server-4.2-10042014
cd bin
chmod 755 *.sh

cd ../database
chmod 755 *.sh

cd bin
sudo bash ./startup.sh

# clear and give message
clear
echo "Open up, http://<Your IP address>/SpagoBI/"