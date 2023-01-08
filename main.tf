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

resource "aws_instance" "ec2_from_terraform" {
  ami                  = "ami-051a81c2bd3e755db"
  instance_type        = "t2.micro"
  availability_zone    = var.availability_zone
  iam_instance_profile = module.iam_role.ec2_tf_profile_id

  ebs_block_device {
    device_name           = "/dev/sdk"
    volume_size           = 2
    encrypted             = true
    delete_on_termination = true
  }

  tags = var.ec2_tags
}
