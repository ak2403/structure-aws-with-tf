#! /bin/bash

yum update -y
yum install -y httpd
systemctl enable httpd
systemctl service httpd start
service httpd start
echo '<h1> Welcome to my blog </h1>' | tee /var/www/html/index.html