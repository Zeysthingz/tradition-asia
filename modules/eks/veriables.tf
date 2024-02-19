variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "eks_cluster_name" {
  type = string
}
variable "key_pair_name" {
  type = string
}

variable "eks_node_group_name" {
  type = string
}
variable "eks_node_role_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "vpc_subnet_ids" {
  description = "List of VPC subnet IDs"
  type        = list(string)
}

