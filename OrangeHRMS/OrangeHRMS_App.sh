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
apt-get update 
apt-get -y install sudo
apt-get -y install nano

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
php5enmod php5-mcrypt 
sudo apt-get -y install curl
sudo apt-get -y install git 

sudo a2enmod rewrite
sudo service apache2 restart

# cd and git clone
rm -f /usr/share/apache2/default-site/index.html
cd /var/www/
rm -rf html

# Get into /var/www/html and pull php files
chmod 777 -R /var/www/
git clone https://github.com/ellipsonic/orangehrm_app.git .

# Add dirs
mkdir lib/logs
mkdir upgrader/cache
mkdir upgrader/log

bash ./fix_permissions.sh 

# Fix Apache .htaccess issues
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
sed -i "s/AllowOverride None/AllowOverride All/g" ${apache2_config_file}

# Site base to be set to /var/www/html - Can be changed as needed
count=$(cat ${apache2_config_file} | sed -n "/var\/www\/>/p" | wc -l)
if [ $count -gt 0 ]; then
        echo "Site base already set to  /var/www/"    
else    
        sed -i "s/var\/www\/html/var\/www\/g" ${apache2_config_file}
fi

# Fix Database IP addresses
echo "Please enter DB Host(84.200.193.32): "
read DBHOST
sed -i "s/host=84.200.193.32/host=$DBHOST/g" /var/www/lib/confs/Conf.php
sed -i "s/host=84.200.193.32/host=$DBHOST/g" /var/www/symfony/config/databases.yml
sed -i "s/host=84.200.193.32/host=$DBHOST/g" /var/www/symfony/cache/orangehrm/prod/config/config_databases.yml.php
echo "DBHOST set to: $DBHOST"

# Change document root to var/www/
sed -i "s/\/var\/www\/html/\/var\/www/g" /etc/apache2/sites-available/000-default.conf

# Clear cache
rm -rf /var/www/symfony/cache/orangehrm/prod/config/config_autoload.yml.php


sudo a2enmod rewrite
sudo service apache2 restart
