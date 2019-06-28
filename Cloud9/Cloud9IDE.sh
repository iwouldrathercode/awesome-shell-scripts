# Update
sudo apt-get -y update

# Install git and curl
sudo apt-get -y install curl
sudo apt-get -y install git 


# Install nodejs and npm
curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install --yes nodejs
sudo apt-get update 
sudo apt-get -y install build-essential
sudo apt-get update 

# Clone the repo
git clone git://github.com/c9/core.git c9sdk
cd c9sdk
sudo scripts/install-sdk.sh

# Map the private IP to public IP
private_ip=$(hostname -i)
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination $private_ip:80
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo node server.js -p 8080 -a : <&- &
