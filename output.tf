output "ec2_public_ip" {
  description = "Public IP of EC2"
  value       = aws_instance.ec2_from_terraform.public_ip
}
