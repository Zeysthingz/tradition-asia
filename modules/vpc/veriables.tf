# modules/vpc/variables.tf

variable "aws_region" {
  description = "AWS region"
  type        = string
# Frankfurt (eu-central-1)
default     = "eu-central-1"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
}

variable "rt_cidr_block" {
  type = string
}
