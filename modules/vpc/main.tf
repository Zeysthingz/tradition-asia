
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# create vcp
resource "aws_vpc" "demo_vcp" {
  cidr_block          = var.cidr_block
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
      Name = "demo-vpc"  # Set the desired name for your VPC
    }
}

# create subnet
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.demo_vcp.id
  cidr_block              = var.subnet_cidr_blocks[0]
  map_public_ip_on_launch = true
   tags = {
      Name = "demo-subnet-01"
    }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.demo_vcp.id
  cidr_block              = var.subnet_cidr_blocks[1]
  map_public_ip_on_launch = true
   tags = {
      Name = "demo-subnet-02"
    }
}

resource "aws_subnet" "subnet_3" {
  vpc_id                  = aws_vpc.demo_vcp.id
  cidr_block              = var.subnet_cidr_blocks[2]
  map_public_ip_on_launch = true
   tags = {
      Name = "demo-subnet-03"
    }
}

# create gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vcp.id

  tags = {
    Name = "demo-igw"
  }
}


# create route table
resource "aws_route_table" "demo_rt" {
  vpc_id =  aws_vpc.demo_vcp.id

  route {
    //associated subnet can reach everywhere
    cidr_block = var.rt_cidr_block
    //RT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "demo_rt"
  }
}

# associate rt to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association
resource "aws_route_table_association" "associate_subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.demo_rt.id
}

resource "aws_route_table_association" "associate_subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.demo_rt.id
}

resource "aws_route_table_association" "associate_subnet_3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.demo_rt.id
}