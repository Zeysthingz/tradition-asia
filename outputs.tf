
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}
output "subnet_1_id" {
  value = module.vpc.subnet_1_id
}

output "subnet_2_id" {
  value = module.vpc.subnet_2_id
}

output "subnet_3_id" {
  value = module.vpc.subnet_3_id
}

