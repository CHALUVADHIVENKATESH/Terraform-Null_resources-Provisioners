resource "aws_subnet" "public-subnets" {
  #count             = 4 # 0 1 2 3
  count             = length(var.public_cidr_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "${var.vpc_name}-Public-Subnet-${count.index + 1}"
    DeployedBy  = local.DeployedBy
    Costcenter  = local.Costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnets" {
  #count             = 4 # 0 1 2
  count             = length(var.private_cidr_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "${var.vpc_name}-Private-Subnet-${count.index + 1}"
    DeployedBy  = local.DeployedBy
    Costcenter  = local.Costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}
