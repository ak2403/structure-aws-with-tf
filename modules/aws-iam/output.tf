output "ec2_tf_profile_id" {
  description = "ID of the created EC2 tf profile"
  value       = aws_iam_instance_profile.ec2_tf_profile.id
}
