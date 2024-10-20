#!/bin/bash

yum install -y nginx

NGINX_CONF_PATH="/etc/nginx/nginx.conf"

sudo mv "$NGINX_CONF_PATH" "$NGINX_CONF_PATH.bak"

cp nginx.conf "$NGINX_CONF_PATH"

sudo systemctl restart nginx