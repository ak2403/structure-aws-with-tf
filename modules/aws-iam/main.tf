resource "aws_iam_policy" "ec2_tf_policy" {
  name = "ec2_tf_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:Get*",
          "iam:List*",
        ]
        Resource = "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_iam" {
  name               = "ec2_iam"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json

  tags = {
    AccessType = "ReadOnly"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_tf_policy_role" {
  role       = aws_iam_role.ec2_iam.name
  policy_arn = aws_iam_policy.ec2_tf_policy.arn
}

resource "aws_iam_instance_profile" "ec2_tf_profile" {
  name = "ec2_tf_profile"
  role = aws_iam_role.ec2_iam.name
}
