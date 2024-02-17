
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

# VCP VERIABLES
variable "cidr_block" {
  type = string
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
}

variable "rt_cidr_block" {
  type = string
}


# EC2 VERIABLES

variable "ec2_name" {
  type = string
}

variable "ec2_type" {
  type = string
}


variable "instance_count" {
  type = string
}
variable "key_pair_name" {
  type = string
}

variable "private_key_path" {
  description = "Path to the private key file for SSH connection"
}


