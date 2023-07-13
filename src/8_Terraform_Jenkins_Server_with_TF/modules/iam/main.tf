# IAM Policy for EC2
resource "aws_iam_policy" "jenkins_iam_policy" {
  name = var.iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

# IAM Role for EC2
resource "aws_iam_role" "jenkins_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach IAM Policy to IAM Role
resource "aws_iam_policy_attachment" "jenkins_role_policy_attachment" {
  name       = var.iam_policy_attachment_name
  policy_arn = aws_iam_policy.jenkins_iam_policy.arn
  roles      = [aws_iam_role.jenkins_role.name]
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = var.jenkins_instance_profile_name
  role = aws_iam_role.jenkins_role.name
}