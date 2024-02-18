output "public_id" {
  value = try(aws_instance.ec2_instance, "")
}