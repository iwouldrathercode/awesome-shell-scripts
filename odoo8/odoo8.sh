sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination $(hostname -i):8069
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

sudo apt-get install openssh-server
sudo apt-get update
sudo apt-get dist-upgrade
sudo adduser --system --home=/opt/odoo --group odoo

sudo su - odoo -s /bin/bash
exit
sudo apt-get install postgresql
sudo su - postgres

# Enter odoo odoo twice
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo

exit


sudo apt-get -y install python-cups python-dateutil python-decorator python-docutils python-feedparser
sudo apt-get -y install python-gdata python-geoip python-gevent python-imaging python-jinja2 python-ldap python-libxslt1
sudo apt-get -y install python-lxml python-mako python-mock python-openid python-passlib python-psutil python-psycopg2
sudo apt-get -y install python-pybabel python-pychart python-pydot python-pyparsing python-pypdf python-reportlab python-requests
sudo apt-get -y install python-simplejson python-tz python-unittest2 python-vatnumber python-vobject
sudo apt-get -y install python-werkzeug python-xlwt python-yaml wkhtmltopdf

sudo apt-get -y install git
sudo su - odoo -s /bin/bash
git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0
mv /opt/odoo/odoo/* /opt/odoo/

exit

sudo cp /opt/odoo/debian/openerp-server.conf /etc/odoo-server.conf
sudo chown odoo: /etc/odoo-server.conf
sudo chmod 640 /etc/odoo-server.conf

sed -i "s/db_password = False/db_password = odoo/" /etc/odoo-server.conf
echo 'logfile = /var/log/odoo/odoo-server.log' >> /etc/odoo-server.conf

# Run the install
sudo su - odoo -s /bin/bash
/opt/odoo/openerp-server &

