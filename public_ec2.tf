resource "aws_instance" "public-servers" {
  #count                       = length(var.public_cidr_block)
  count                       = var.environment == "Prod" ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-Public-Server-${count.index + 1}"
    DeployedBy  = local.DeployedBy
    Costcenter  = local.Costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

  # user_data = <<-EOF
  # 	#!/bin/bash
  #       sudo apt install nginx -y
  #       sudo apt install git -y
  #       sudo git clone -b DevOpsB24 https://github.com/mavrick202/webhooktesting.git
  #       sudo rm -rf /var/www/html/index.nginx-debian.html
  #       sudo cp webhooktesting/index.html /var/www/html/index.nginx-debian.html
  #       sudo cp webhooktesting/style.css /var/www/html/style.css
  #       sudo cp webhooktesting/scorekeeper.js /var/www/html/scorekeeper.js
  # 	echo "<center><div id="container"><h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1></div></center>" >> /var/www/html/index.nginx-debian.html
  # EOF
}