sudo apt-get update
sudo apt-get install -y php5 php5-sqlite unzip
service apache2 restart
cd /var/www/
rm -rf *
sudo wget http://kanboard.net/kanboard-latest.zip
sudo unzip kanboard-latest.zip
sudo chown -R www-data:www-data kanboard/data
sudo rm kanboard-latest.zip
cd
mv /var/www/kanboard/* /var/www/
service apache2 restart
