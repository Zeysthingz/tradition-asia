output "vpc_id" {
  value = aws_vpc.demo_vcp.id
}

output "subnet_ids" {
  value = [
    aws_subnet.subnet_1.id,
  ]
}