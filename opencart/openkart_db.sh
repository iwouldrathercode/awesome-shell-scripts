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

mysql -u root -e "CREATE DATABASE IF NOT EXISTS opencart" -ppassword

# Git all mysql files
cd /tmp
rm -rf *
mkdir db
cd db
git clone https://github.com/abhinay100/opencart_db.git .



mysql -u root opencart < /tmp/db/opencart.sql -ppassword

# Allow any server to connect
sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION" | mysql -u root -ppassword

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
