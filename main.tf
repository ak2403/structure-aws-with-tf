provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "ssh_security" {
  name        = "ssh security"
  description = "security for ssh usage"

  ingress {
    description = "Inbound rules"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound rules"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh security"
  }
}

resource "aws_security_group" "web_security" {
  name        = "web security"
  description = "security for web usage"

  ingress {
    description = "Inbound rules"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound rules"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web security"
  }
}

resource "aws_instance" "ec2_from_terraform" {
  ami                    = data.aws_ami.ec2_ami.id
  instance_type          = var.ec2_instance_type
  user_data              = file("${path.module}/start-up.sh")
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.ssh_security.id, aws_security_group.web_security.id]

  tags = {
    "Name" = "EC2 practice"
  }
}
