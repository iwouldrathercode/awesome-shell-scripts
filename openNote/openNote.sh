# Update main packages
sudo apt-get update

# Add dependencies
sudo apt-get -y install software-properties-common
sudo apt-get -y install git

# Setup LAMP
git clone https://gist.github.com/807f87ce2bd40d0f4539.git
cd 807f87ce2bd40d0f4539
chmod +x Lampp.sh

# Get into /var/www and clone Paperwork
cd /var/www
sudo rm -rf *
sudo rm -rf .*
sudo git clone https://github.com/FoxUSA/OpenNote.git .