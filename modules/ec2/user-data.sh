#!/bin/bash
#https://stackoverflow.com/questions/68004169/deploy-sh-file-in-ec2-using-terraform
# Run updates
echo "---------------------------  INSTALLING UPDATES ---------------------------"
yum update -y
echo "--------------------------- UPDATES COMPLETED ---------------------------"


# Install Apache HTTPD
echo "---------------------------  INSTALLING APACHE HTTPD ---------------------------"
yum install -y httpd
echo "---------------------------  INSTALLING APACHE HTTPD COMPLETED  ---------------------------"

echo "---------------------------  STARTING APACHE   ---------------------------"
systemctl start httpd
systemctl enable httpd

systemctl status httpd

# Copy custom index.html file to Apache document root
echo "---------------------------  COPYING CUSTOM INDEX.HTML   ---------------------------"
cp /projects/tradition-asia-assignment/modules/ec2/index.html /var/www/html/index.html