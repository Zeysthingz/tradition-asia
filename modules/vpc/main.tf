
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

resource "aws_vpc" "demo_vcp" {
# Gives IP range to VCP
  cidr_block          = var.cidr_block
#   Allowing instances to resolve public DNS hostnames and receive DNS hostnames.
  enable_dns_support  = true
  enable_dns_hostnames = true

    tags = {
      Name = "demo-vpc"  # Set the desired name for your VPC
    }
}


