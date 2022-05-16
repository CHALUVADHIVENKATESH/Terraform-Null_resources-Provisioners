#!/bin/bash
sudo apt update
sudo apt install -y nginx
sudo rm -rf /tmp/webhooktesting
sudo git clone -b DevOpsB24 https://github.com/mavrick202/webhooktesting.git
sudo cp webhooktesting/index.html /var/www/html/index.nginx-debian.html
sudo cp webhooktesting/style.css /var/www/html/style.css
sudo cp webhooktesting/scorekeeper.js /var/www/html/scorekeeper.js