# New VPC 'main-vpc'
resource "aws_vpc" "main-vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = join("-",[var.customer_env, "vpc", var.AWS_REGION])
  }
}

# 4 subnets 2 AZ's
resource "aws_subnet" "subnet-public-1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.subnet_public_1_cidr
  map_public_ip_on_launch = "true"
  availability_zone       = var.az1

  tags = {
    Name = join("-",[var.customer_env, "subnet-public", var.az1])
  }
}

resource "aws_subnet" "subnet-public-2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.subnet_public_2_cidr
  map_public_ip_on_launch = "true"
  availability_zone       = var.az2

  tags = {
    Name = join("-",[var.customer_env, "subnet-public", var.az2])
  }
}

resource "aws_subnet" "subnet-private-1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.subnet_private_1_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.az1

  tags = {
    Name = join("-",[var.customer_env, "subnet-private", var.az1])
  }
}

resource "aws_subnet" "subnet-private-2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.subnet_private_2_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.az2

  tags = {
    Name = join("-",[var.customer_env, "subnet-private", var.az2])
  }
}

# Internet GW
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = join("-",[var.customer_env, "igw"])
  }
}

# Route table public
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = {
    Name = join("-",[var.customer_env, "rtb-public"])
  }
}

# Route associations public rt
resource "aws_route_table_association" "subnet-public-1" {
  subnet_id      = aws_subnet.subnet-public-1.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "subnet-public-2" {
  subnet_id      = aws_subnet.subnet-public-2.id
  route_table_id = aws_route_table.rt-public.id
}