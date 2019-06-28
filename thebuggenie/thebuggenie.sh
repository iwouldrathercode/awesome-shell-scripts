# Global variables
php_config_file="/etc/php5/apache2/php.ini"
apache2_config_file="/etc/apache2/apache2.conf"

# Update main packages
sudo apt-get update

# Add dependencies
sudo apt-get -y install software-properties-common
sudo apt-get -y install git

# Setup LAMP
git clone https://gist.github.com/807f87ce2bd40d0f4539.git
cd 807f87ce2bd40d0f4539
chmod +x Lampp.sh
sudo bash ./Lampp.sh

# cd and git clone
sudo rm -f /usr/share/apache2/default-site/index.html
cd /var/www/
sudo rm -rf html

# Get into /var/www/html and pull php files
sudo chmod 777 -R /var/www/

# Get into /var/www and clone Paperwork
cd /var/www
sudo rm -rf *
sudo rm -rf .*
sudo git clone https://github.com/ellipsonic/thebuggenige_app.git thebuggenie


# Database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS thebuggenige_db" -proot
cd /tmp
sudo rm -rf *
sudo rm -rf .*
sudo git clone https://github.com/ellipsonic/thebuggenige_db.git .
mysql -u root -proot thebuggenige_db < thebuggenige_db.sql

# Update server to accept .htaccess files, enable mod-rewrite and restart the server
chmod 777 -R /var/
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/sites-available/default

sudo service apache2 restart
sudo a2enmod rewrite
sudo service apache2 restart

# All done
clear
pubilc_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
echo "Enter your IP address to see the app, to login 'http://$pubilc_ip/thebuggenie/public/' "
