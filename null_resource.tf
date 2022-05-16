resource "null_resource" "deletefiles" {
    provisioner "local-exec" {
    command = <<EOH
    del public_ip && del private_ip
    EOH
  }
  
}

resource "null_resource" "cluster" {
  count = var.environment == "Prod" ? 3 : 1
  provisioner "file" {
    source      = "user_data.sh"
    destination = "/tmp/user_data.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("LaptopKey.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }
  provisioner "file" {
    source      = "aws_cli.sh"
    destination = "/tmp/aws_cli.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("LaptopKey.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/user_data.sh",
      "cd /tmp/",
      "ls -al",
      "sudo bash /tmp/user_data.sh",
      "#sudo bash /tmp/aws_cli.sh",
      "sudo /usr/local/bin/aws --version",
      "sudo sed -i '/<h1>Welcome.*/a <h1>${var.vpc_name}-PublicServer-${count.index + 1}</h1>' /var/www/html/index.nginx-debian.html"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("LaptopKey.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }
  provisioner "local-exec" {
    command = <<EOH
      echo "${element(aws_instance.public-servers.*.public_ip, count.index)}" >> public_ip && echo "${element(aws_instance.public-servers.*.private_ip, count.index)}" >> private_ip,
    EOH
  }

depends_on = [null_resource.deletefiles]
}


resource "null_resource" "localexec" {
    provisioner "local-exec" {
    command = <<EOH
    aws s3 cp private_ip s3://sreeterraformbucket/private_ip && aws s3 cp public_ip s3://sreeterraformbucket/public_ip
    EOH
  }
  depends_on = [null_resource.cluster]
}