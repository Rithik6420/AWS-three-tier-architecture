#!/bin/bash

# Update packages
dnf update -y

# Install Apache Web Server
dnf install -y httpd

# Start Apache
systemctl start httpd

# Enable Apache at boot
systemctl enable httpd

# Create sample application page
echo "<h1>Three Tier AWS Project</h1><h2>App Server</h2>" > /var/www/html/index.html
