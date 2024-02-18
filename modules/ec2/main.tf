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
# Create an Auto Scaling Group with two EC2 instances
# https://registry.terraform.io/providers/vmware/avi/latest/docs/data-sources/avi_autoscalelaunchconfig
# https://spacelift.io/blog/terraform-autoscaling-group/
# https://spacelift.io/blog/terraform-autoscaling-group

resource "aws_launch_template" "template" {
  name_prefix     = "unique-demo-launch-template-v3-"
  image_id        = "ami-03614aa887519d781"
  instance_type   = "t2.micro"
  user_data       = base64encode(file("${path.module}/user-data.sh"))
  key_name        = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.demo_security_group.id]
  update_default_version = true



  lifecycle {
    create_before_destroy = true
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }
}

resource "aws_autoscaling_group" "demo_autoscale" {
  name                  = "unique-demo3-autoscaling-group"
  desired_capacity      = 2
  max_size              = 4
  min_size              = 2
  health_check_type     = "EC2"
  vpc_zone_identifier   = [var.subnet_id, var.subnet_id2, var.subnet_id3]
  count                 = var.instance_count

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  tag {
      key                 = "Name"
      value               = "demo-ec2-instance"
      propagate_at_launch = true
  }
}


# resource "aws_instance" "ec2_instance" {
#   count         = var.instance_count
#   ami           = "ami-03614aa887519d781"
#   instance_type = "t2.micro"
#   user_data     = file("${path.module}/user-data.sh") # Provide the relative path to your user_data.sh script
#   key_name      = var.key_pair_name
#   subnet_id     =var.subnet_id
#   vpc_security_group_ids = [aws_security_group.demo_security_group.id]  # Use the custom security group
#
#
#   tags = {
#     Name = " demo-ec2-instance-${count.index + 1}"
#   }
#
#
#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file(var.private_key_path)  # Use the private key path variable
#   }
# }
