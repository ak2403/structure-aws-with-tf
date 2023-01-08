provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "ec2_from_terraform" {
  ami               = "ami-051a81c2bd3e755db"
  instance_type     = "t2.micro"
  availability_zone = var.availability_zone

  tags = var.ec2_tags
}
