provider "aws" {
  region = "ap-southeast-2"
}

module "iam_role" {
  source = "./modules/aws-iam"
}

resource "aws_ebs_volume" "ec2_ebs_tf_volume" {
  availability_zone = var.availability_zone
  size              = 2
  encrypted         = false
  type              = "gp2"

  tags = {
    Name = "EC2_EBS_TF_Volume"
  }
}

resource "aws_volume_attachment" "ec2_ebs_tf_attachment" {
  device_name = "/dev/sdi"
  volume_id   = aws_ebs_volume.ec2_ebs_tf_volume.id
  instance_id = aws_instance.ec2_from_terraform.id
}

resource "aws_security_group" "ec2_tf_security_group" {
  name        = "ec2_tf_security_group"
  description = "THe security group for the ec2 instance"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_from_terraform" {
  ami                    = "ami-051a81c2bd3e755db"
  instance_type          = "t2.micro"
  availability_zone      = var.availability_zone
  iam_instance_profile   = module.iam_role.ec2_tf_profile_id
  vpc_security_group_ids = [aws_security_group.ec2_tf_security_group.id]

  ebs_block_device {
    device_name           = "/dev/sdk"
    volume_size           = 2
    encrypted             = true
    delete_on_termination = true
  }

  tags = var.ec2_tags
}
