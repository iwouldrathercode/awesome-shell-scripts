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
sudo git clone https://github.com/ellipsonic/limesurvey_app.git .
sudo chmod 777 -R /var/www/tmp/runtime
sudo chmod 777 -R /var/www/tmp/assets

## Database to be made as a seperate script like it was done for OrangeHRMS
          # Create Database
          mysql -u root -e "CREATE DATABASE IF NOT EXISTS limesurvey" -proot
          
          # Import data
          cd /tmp
          git clone https://github.com/ellipsonic/limesurvey_db.git .
          mysql -u root limesurvey < /tmp/limesurvey.sql -proot
# If database is hosted on another box, change database host name value under
# sudo sed -i "s/localhost/<New DB Host Name>/g" /var/www/phpci.yml

# Fix Apache .htaccess issues
sudo sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sudo sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
sudo sed -i "s/AllowOverride None/AllowOverride All/g" ${apache2_config_file}

# Site base to be set to /var/www/html - Can be changed as needed
count=$(cat ${apache2_config_file} | sudo sed -n "/var\/www\/>/p" | wc -l)
if [ $count -gt 0 ]; then
        echo "Site base already set to  /var/www/"    
else    
        sudo sed -i "s/\/var\/www\/html/\/var\/www/g" ${apache2_config_file}
fi

sudo service apache2 restart
sudo a2enmod rewrite
sudo service apache2 restart

# clear
pubilc_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
echo "Enter your IP address to see the app, to login 'http://$pubilc_ip/admin' "