# variable "aws_access_key" {}
# variable "aws_secret_key" {}

# variable "amis" {
#     description = "AMIs by region"
#     default = {
#         us-east-1 = "ami-97785bed" # ubuntu 14.04 LTS
# 		us-east-2 = "ami-f63b1193" # ubuntu 14.04 LTS
# 		us-west-1 = "ami-824c4ee2" # ubuntu 14.04 LTS
# 		us-west-2 = "ami-f2d3638a" # ubuntu 14.04 LTS
#     }
# }
variable "aws_region" {}
variable "amis" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "key_name" {}
variable "instance_type" {}

variable "environment" {}
variable "service_ports" {}
variable "public_cidr_block" {}
variable "azs" {}
variable "private_cidr_block" {}
# variable ".private_cidr_block" {}
# variable ".private_cidr_block" {}
# variable ".private_cidr_block" {}

