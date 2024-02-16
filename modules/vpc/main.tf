
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
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