# output "public_id" {
#   value = try(aws_instance.ec2_instance, "")
# }
#
# output "auto_scaling_group_id" {
#   value = aws_autoscaling_group.demo-autoscale.id
# }

data "aws_autoscaling_groups" "demo_autoscale" {
  names = ["unique-demo3-autoscaling-group"]  # Specify the name of your Auto Scaling Group
}

output "ec2_instance_ids" {
  value = data.aws_autoscaling_groups.demo_autoscale[*].id
}

output "launch_template_id" {
  value = aws_launch_template.template.id
}