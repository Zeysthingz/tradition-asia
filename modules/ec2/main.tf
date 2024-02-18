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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
# CREATE A SECURITY GROUP
resource "aws_security_group" "demo_security_group" {
  name        = "demo_security_group"
  description = "Allow inbound IP on ports 22, 80, and 443"
  vpc_id      = var.vpc_id  # Replace with the actual VPC ID from your module


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = "ami-03614aa887519d781"
  instance_type = "t2.micro"
  user_data     = file("${path.module}/user-data.sh") # Provide the relative path to your user_data.sh script
  key_name      = var.key_pair_name
  subnet_id     =var.subnet_id
  vpc_security_group_ids = [aws_security_group.demo_security_group.id]  # Use the custom security group


  tags = {
    Name = " demo-ec2-instance-${count.index + 1}"
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)  # Use the private key path variable
  }
}
