provider "aws" {
  region = "ap-southeast-2"
}

module "iam_role" {
  source = "./modules/aws-iam"
}

resource "aws_instance" "ec2_from_terraform" {
  ami                  = "ami-051a81c2bd3e755db"
  instance_type        = "t2.micro"
  availability_zone    = var.availability_zone
  iam_instance_profile = module.iam_role.ec2_tf_profile_id

  tags = var.ec2_tags
}
