#!/bin/bash
php_config_file="/etc/php5/apache2/php.ini"
apache2_config_file="/etc/apache2/apache2.conf"
#Instructions to use this script
#
#chmod +x SCRIPTNAME.sh
#
#sudo ./SCRIPTNAME.sh
echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"
#Update the repositories

sudo apt-get update
sudo apt-get -y install sudo
sudo apt-get -y install nano
sudo apt-get update

#Apache, Php, MySQL and required packages installation
sudo apt-get -y install apache2
sudo apt-get -y install php5
sudo apt-get -y install libapache2-mod-php5
sudo apt-get -y install php5-mcrypt
sudo apt-get -y install php5-curl
sudo apt-get -y install php5-mysql
sudo apt-get -y install php5-gd
sudo apt-get -y install php5-cli
sudo apt-get -y install php5-dev
sudo apt-get -y install mysql-client
sudo apt-get -y install php5-mcrypt
sudo php5enmod php5-mcrypt
sudo apt-get -y install curl
sudo apt-get -y install git
sudo a2enmod rewrite
sudo service apache2 restart

# cd and git clone
sudo rm -f /usr/share/apache2/default-site/index.html
cd /var/www/
sudo rm -rf *

# Get into /var/www/html and pull php files
sudo chmod 777 -R /var/www/
git clone https://github.com/ellipsonic/tomato_app.git .

#change permissions
sudo chmod 777 -R /var/www/


# Fix Apache .htaccess issues
sudo sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sudo sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
sudo sed -i "s/AllowOverride None/AllowOverride All/g" ${apache2_config_file}


# Fix Database IP addresses

pubilc_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
sudo sed -i "s/http:\/\/localhost/http:\/\/$pubilc_ip/g" /var/www/includes/configure.php

sudo sed -i "s/DocumentRoot /var/www/html/bind-address = 0.0.0.0/" 
sudo sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\//g" /etc/apache2/sites-available/000-default.conf

echo "Please enter DBHOST(localhost): "
read DBHOST
sed -i "s/localhost/$DBHOST/g" /var/www/includes/configure.php

sudo a2enmod rewrite




sudo service apache2 restart	

