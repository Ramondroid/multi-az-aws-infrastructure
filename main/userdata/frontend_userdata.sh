#!/bin/bash

# Install Apache
yum update -y
yum install -y httpd

# Start Apache
systemctl start httpd
systemctl enable httpd

# Backend URL (Injected from Terraform)
BACKEND_URL="http://@@BACKEND_URL@@/api.json"

# Fetch backend data and store in index.html
# cat <<EOF > /var/www/html/index.html
# <html>
# <head>
#     <title>Frontend Server</title>
# </head>
# <body>
#     <h1>Frontend Server - $(hostname)</h1>
#     <h2>Backend Response:</h2>
#     <pre>$(curl -s $BACKEND_URL)</pre>
# </body>
# </html>
# EOF

# # Log the interaction
# echo "Fetched from $BACKEND_URL at $(date)" >> /var/log/asg-frontend.log

# Enable CGI in Apache
echo "AddHandler cgi-script .sh" >> /etc/httpd/conf/httpd.conf
echo "DirectoryIndex /cgi-bin/fetch_backend.sh" >> /etc/httpd/conf/httpd.conf
chmod 755 /etc/httpd/conf/httpd.conf
systemctl restart httpd

# Create CGI script to fetch backend response dynamically
mkdir -p /var/www/cgi-bin
cat <<EOF > /var/www/cgi-bin/fetch_backend.sh
#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Frontend</title></head><body>"
echo "<h1>Frontend Server - $(hostname)</h1>"
echo "<h2>Backend Response:</h2>"
echo "<pre>\$(curl -s $BACKEND_URL)</pre>"
echo "</body></html>"
EOF

# Make script executable
chmod +x /var/www/cgi-bin/fetch_backend.sh

# Restart Apache
systemctl restart httpd