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

module "ec2" {
  source           = "./modules/ec2"
  name             = var.ec2_name
  instance_count   =var.instance_count
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.subnet_1_id
  subnet_id2       = module.vpc.subnet_2_id
  subnet_id3       = module.vpc.subnet_3_id
  ec2_type         = var.ec2_type
  key_pair_name    = var.key_pair_name
  private_key_path = var.private_key_path
}

