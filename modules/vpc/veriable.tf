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