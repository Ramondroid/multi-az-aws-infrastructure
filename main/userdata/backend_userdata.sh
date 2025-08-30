#!/bin/bash

# Install Apache
yum update -y
yum install -y httpd

# Start Apache
systemctl start httpd
systemctl enable httpd

# Fetch backend data and store in index.html
cat <<EOF > /var/www/html/api.json
{"status": "success", "backend": "$(hostname)", "timestamp": "$(date)"}
EOF

echo "Backend Server $(hostname) is healthy" >> /var/www/html/index.html