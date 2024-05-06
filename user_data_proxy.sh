#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo  "
server {
    listen 80 default_server;
    location / {
proxy_pass http://${module.Private_load_balancer.load_balancer_dns}
    }
} " > /etc/nginx/sites-enabled/default

sudo systemctl restart nginx
