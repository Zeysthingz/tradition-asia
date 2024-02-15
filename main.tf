terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
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
  cidr_block = "10.3.0.0/16"
}