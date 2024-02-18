
variable "aws_region" {
  description = "AWS region"
  type        = string
# Frankfurt (eu-central-1)
default     = "eu-central-1"
}

variable "name" {
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

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}


variable "subnet_id2" {
  type = string
}


variable "subnet_id3" {
  type = string
}
