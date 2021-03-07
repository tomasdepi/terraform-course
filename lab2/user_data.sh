#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl ifconfig.co`
echo "<h2>WebServer with PrivateIP: $MYIP</h2><br>Built by Terraform" > /var/www/html/index.html
service httpd start
chkconfig httpd on
