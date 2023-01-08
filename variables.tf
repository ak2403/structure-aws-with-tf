variable "ec2_tags" {
  description = "The tags configuration of the ec2 instance to be created"
  type        = map(string)
  default = {
    Name = "EC2ServerFromTerraform"
  }
}

variable "availability_zone" {
  description = "The availability zone of the ec2 instance to be created"
  type        = string
  default     = "ap-southeast-2a"
}
