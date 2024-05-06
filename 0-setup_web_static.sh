#!/usr/bin/env bash

# Update package lists and install nginx if not already installed
sudo apt-get update
sudo apt-get -y install nginx

# Allow Nginx HTTP traffic in firewall
sudo ufw allow 'Nginx HTTP'

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test
sudo mkdir -p /data/web_static/shared

# Create fake HTML file in /data/web_static/releases/test
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link from /data/web_static/current to /data/web_static/releases/test
sudo ln -sfn /data/web_static/releases/test/ /data/web_static/current

# Set ownership of /data/ directory to the ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Define the path to the Nginx configuration file
NGINX_CONF="/etc/nginx/sites-enabled/default"

# Check if the `location /hbnb_static` block exists in the configuration file
if ! grep -q 'location /hbnb_static {' "$NGINX_CONF"; then
    # If the block does not exist, add it
    sudo bash -c "echo 'location /hbnb_static {
        alias /data/web_static/current/;
    }' >> $NGINX_CONF"
fi

# Test Nginx configuration for syntax errors
sudo nginx -t
if [[ $? -ne 0 ]]; then
    echo "Nginx configuration test failed. Please check the configuration manually."
    exit 1
fi

# Restart Nginx
sudo service nginx restart

echo "Web servers have been set up successfully."
