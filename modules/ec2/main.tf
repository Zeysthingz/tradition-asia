# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
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


resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = "ami-03614aa887519d781"
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  subnet_id     =var.subnet_id

  tags = {
    Name = " demo-ec2-instance-${count.index + 1}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)  # Use the private key path variable
  }
}
