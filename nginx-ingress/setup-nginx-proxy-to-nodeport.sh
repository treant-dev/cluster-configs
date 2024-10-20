#!/bin/bash

yum install -y nginx

NGINX_CONF_PATH="/etc/nginx/nginx.conf"

sudo mv "$NGINX_CONF_PATH" "$NGINX_CONF_PATH.bak"

sudo tee "$NGINX_CONF_PATH" > /dev/null <<EOF
events {}

http {
    server {
        listen 80;
        server_name _;

        location / {
            proxy_pass http://127.0.0.1:30080;
        }
    }

    server {
        listen 443;
        server_name _;

        location / {
            proxy_pass http://127.0.0.1:30443;
        }
    }
}
EOF

sudo systemctl restart nginx