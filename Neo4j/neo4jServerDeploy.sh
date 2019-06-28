# Update system files
sudo apt-get update
sudo apt-get install -y sudo
sudo apt-get update && sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update && sudo apt-get install oracle-java7-installer

# Stop apache2
sudo service apache2 stop

# Install neo4j as a service
wget -O - http://debian.neo4j.org/neotechnology.gpg.key >> key.pgp
sudo apt-key add key.pgp
echo 'deb http://debian.neo4j.org/repo stable/' | sudo tee -a /etc/apt/sources.list.d/neo4j.list > /dev/null
sudo apt-get update && sudo apt-get install neo4j - See more at: http://codiply.com/blog/standalone-neo4j-server-setup-on-ubuntu-14-04
sudo service neo4j-service restart

# Accept any IP address
sudo sed -i ''s/#org.neo4j.server.webserver.address=0.0.0.0/org.neo4j.server.webserver.address=0.0.0.0/g'' /etc/neo4j/neo4j-server.properties

# Truncate default login and add new user admin with password as password
sudo truncate -s 0 /var/lib/neo4j/data/dbms/auth
sudo sh -c "echo 'admin:SHA-256,1421DCDFDEABF52E7901F3BB12F51CBB7E44DF62D67DAF706AA95F440159594F,C53B9A5102FA940DAF0A26BF285A1603:' >> /var/lib/neo4j/data/dbms/auth"

sudo service neo4j-service restart

clear
echo "Check your browser, username admin and password is password"
