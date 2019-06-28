# Update core
sudo apt-get update

# Install dependencies
sudo apt-get install python-pip python-dev build-essential 

# Install Wagtail
pip install wagtail

# Start your site
wagtail start mysite

# Set up the database
cd mysite
python manage.py migrate

# Create admin user
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@admin.com', 'password')" | python manage.py shell

# Run the site in the background "done by adding & symbol at the end of the statement" 
sudo python manage.py runserver 0.0.0.0:80 &
