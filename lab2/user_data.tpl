#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl ifconfig.co`

cat <<EOF > /var/www/html/index.html
<html>
<h2>Built by Power of <font color="red">Terraform</font></h2><br>
Server Owner is: ${name} ${lastname} <br>
My Hobbies:
%{ for x in hobbies ~}
${x}<br>
%{ endfor ~}
<p>PrivateIP: $MYIP
</html>
EOF

service httpd start
chkconfig httpd on
