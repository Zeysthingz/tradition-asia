terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"  # Update the AWS region to Frankfurt
}

module "vpc" {
  source     = "./modules/vpc"
  aws_region = var.aws_region  # Pass the AWS region directly
  cidr_block = var.cidr_block  # Pass the CIDR block directly
  subnet_cidr_blocks = var.subnet_cidr_blocks  # Pass the subnet CIDR blocks directly
  rt_cidr_block = var.rt_cidr_block # Pass the subnet route table CIDR blocks directly
}