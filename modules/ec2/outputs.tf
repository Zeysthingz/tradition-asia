
data "aws_autoscaling_groups" "demo_autoscale" {
  names = ["unique-demo3-autoscaling-group"]  # Specify the name of your Auto Scaling Group
}

output "ec2_instance_ids" {
  value = data.aws_autoscaling_groups.demo_autoscale[*].id
}

output "launch_template_id" {
  value = aws_launch_template.template.id
}