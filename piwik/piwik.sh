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
php5enmod php5-mcrypt
sudo apt-get -y install curl
sudo apt-get -y install git
sudo a2enmod rewrite
sudo service apache2 restart

# cd and git clone
rm -f /usr/share/apache2/default-site/index.html
cd /var/www/
rm -rf *

# Get into /var/www/html and pull php files
chmod 777 -R /var/www/
git clone https://github.com/abhinay100/piwikapp.git .

#change permissions
chmod 777 -R /var/www/


# Fix Apache .htaccess issues
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
sed -i "s/AllowOverride None/AllowOverride All/g" ${apache2_config_file}


#Fix Application IP Addresses
pubilc_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
sed -i "s/localhost/$public_ip/g" /var/www/config/config.ini.php
sed -i "s/localhost/$public_ip/g" /var/www/config/global.ini.php

# Change document root to var/www/
sed -i "s/\/var\/www\/html/\/var\/www/g" /etc/apache2/sites-available/000-default.conf

sudo a2enmod rewrite
sudo service apache2 restart	

#!/bin/bash
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
#Apache, Php, MySQL and required packages installation
sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
php5enmod mcrypt
#The following commands set the MySQL root password to root when you install the mysql-server package.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install git
sudo apt-get -y install mysql-server

mysql -u root -e "CREATE DATABASE IF NOT EXISTS piwik" -ppassword

# Git all mysql files
cd /tmp
rm -rf *
mkdir db
cd db
git clone https://github.com/abhinay100/piwikdb_db.git .
mysql -u root piwik < /tmp/db/piwik.sql -ppassword


# Allow any server to connect
sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION" | mysql -u root -ppassword

# allow db database connection
pubilc_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
sed -i "s/localhost/$public_ip/g" /tmp/db/piwik.sql



#Restart all the installed services to verify that everything is installed properly
echo -e "\n"
service apache2 restart && service mysql restart > /dev/null
echo -e "\n"
if [ $? -ne 0 ]; then
echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi
echo -e "\n"
