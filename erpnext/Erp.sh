# Update core
sudo apt-get update

# Install dependencies
sudo apt-get install python-pip python-dev build-essential 

wget https://raw.githubusercontent.com/frappe/bench/master/install_scripts/setup_frappe.sh
sudo bash setup_frappe.sh --setup-production
