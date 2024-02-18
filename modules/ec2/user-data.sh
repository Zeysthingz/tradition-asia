#!/bin/bash
#https://stackoverflow.com/questions/68004169/deploy-sh-file-in-ec2-using-terraform
# Run updates
echo "---------------------------  INSTALLING UPDATES ---------------------------"
sudo yum update -y
echo "--------------------------- UPDATES COMPLETED ---------------------------"


# Install Apache HTTPD
echo "---------------------------  INSTALLING APACHE HTTPD ---------------------------"
sudo yum install -y httpd
echo "---------------------------  INSTALLING APACHE HTTPD COMPLETED  ---------------------------"

echo "---------------------------  STARTING APACHE   ---------------------------"
sudo systemctl start httpd
sudo systemctl enable httpd

sudo systemctl status httpd

# Copy custom index.html file to Apache document root
echo "---------------------------  COPYING CUSTOM INDEX.HTML   ---------------------------"
wget https://raw.githubusercontent.com/Zeysthingz/tradition-asia-assignment/test/modules/ec2/index.html
sudo cp index.html /var/www/html/index.html