resource "aws_instance" "private-servers" {
  #count                       = length(var.private_cidr_block)
  count                       = var.environment == "Prod" ? 0 : 0
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.private-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-Private-Server-${count.index + 1}"
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
  # 	echo "<div><h1>${var.vpc_name}-Private-Server-${count.index + 1}</h1></div>" >> /var/www/html/index.nginx-debian.html
  # EOF
}