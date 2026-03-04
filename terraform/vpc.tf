#VPC

resource "aws_vpc" "main" {
  cidr_block           = "30.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "crs_vpc"
  }
}
#subnets
variable "public_subnets" {
  default = ["30.0.1.0/24", "30.0.2.0/24", "30.0.3.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

variable "private_subnets" {
  default = ["30.0.101.0/24", "30.0.102.0/24", "30.0.103.0/24"]
}

resource "aws_subnet" "private" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "private_subnet_${count.index + 1}"
  }
}

#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name="crs_igw"
  }
}

#RT

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.igw.id
  }

  tags = {
    Name="public_rt"
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id 
}

#Elastic ip

resource "aws_eip" "nat_ip" {
  domain = "vpc"
  count = length(aws_subnet.public)
}

#Natgwy

resource "aws_nat_gateway" "nat" {
  count = length(aws_subnet.public)

  allocation_id = aws_eip.nat_ip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "crs_nat_${count.index + 1}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  count = length(aws_subnet.private)
  route {
    cidr_block="0.0.0.0/0"
    nat_gateway_id=aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name="private_rt_${count.index + 1}"
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id 
}