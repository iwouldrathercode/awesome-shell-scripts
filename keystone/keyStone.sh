# Install dependencies
sudo apt-get install python-software-properties 
sudo apt-get install -y curl

# Install nodejs and npm
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install -y nodejs
sudo apt-get update 

# Install mongoDB
sudo apt-get install -y mongodb
sudo apt-get install -y git

# Git keystone
mkdir myapp
cd myapp
git clone https://github.com/ellipsonic/keystone-demo.git .

# Clean app and add BSN to avoid memory leaks
sudo npm cache clean
rm -rf node_modules
export PYTHON=python2.7
sudo npm install --python=python2.7

# Deploy app
sudo node keystone &
