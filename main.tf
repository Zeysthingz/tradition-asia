terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "demo-terraform-states"
    key            = "demo/tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-lock"
  }
}
provider "aws" {
  region = "eu-central-1"  # Update the AWS region to Frankfurt
}


module "vpc" {
  source             = "./modules/vpc"
  aws_region         = var.aws_region  # Pass the AWS region directly
  cidr_block         = var.cidr_block  # Pass the CIDR block directly
  subnet_cidr_blocks = var.subnet_cidr_blocks  # Pass the subnet CIDR blocks directly
  rt_cidr_block      = var.rt_cidr_block # Pass the subnet route table CIDR blocks directly
}

module "ec2" {
  source           = "./modules/ec2"
  name             = var.ec2_name
  instance_count   = var.instance_count
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.subnet_1_id
  subnet_id2       = module.vpc.subnet_2_id
  subnet_id3       = module.vpc.subnet_3_id
  ec2_type         = var.ec2_type
  key_pair_name    = var.key_pair_name
  private_key_path = var.private_key_path
}


module "eks" {
  source              = "./modules/eks"
  aws_region          = var.aws_region
  eks_cluster_name    = var.eks_cluster_name
  vpc_subnet_ids      = [module.vpc.subnet_1_id, module.vpc.subnet_2_id, module.vpc.subnet_3_id]
  vpc_id              = module.vpc.vpc_id
  key_pair_name       = var.key_pair_name
  eks_node_group_name = var.eks_node_group_name
  eks_node_role_name  = var.eks_node_role_name

}



