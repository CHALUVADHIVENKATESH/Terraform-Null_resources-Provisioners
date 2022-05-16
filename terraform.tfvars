aws_region = "us-east-1"
amis = {
  us-east-1 = "ami-04505e74c0741db8d" # ubuntu 20.04 LTS
  us-east-2 = "ami-04505e74c0741db90" # ubuntu 20.04 LTS
}
vpc_cidr           = "10.25.0.0/16"
vpc_name           = "DevOpsB24"
key_name           = "LaptopKey"
instance_type      = "t2.nano"
environment        = "Prod"
service_ports      = ["80", "443", "445", "8080", "22", "3389"]
public_cidr_block  = ["10.25.1.0/24", "10.25.2.0/24", "10.25.3.0/24"]
azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_cidr_block = ["10.25.10.0/24", "10.25.20.0/24", "10.25.30.0/24"]