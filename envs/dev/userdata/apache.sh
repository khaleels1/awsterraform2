#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<html><body><h1>Welcome to RK Apache on Ubuntu!</h1></body    ></html>" | sudo tee /var/www/html/index.html
sudo systemctl restart apache2
echo "Apache installed and running. Visit http://your_server_ip to see the welcome page."   