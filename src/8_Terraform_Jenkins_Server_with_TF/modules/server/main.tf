# Getet AMZ Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# EC2 Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_desc
  vpc_id      = var.vpc_id

  # Open Jenkins Port (8080)
  ingress {
    description = var.ec2_security_group_http_proxy_desc
    from_port   = var.ec2_security_group_http_proxy_port
    to_port     = var.ec2_security_group_http_proxy_port
    protocol    = var.ec2_security_group_http_proxy_protocol
    cidr_blocks = [var.ec2_security_group_http_proxy_cidr]
  }

  # Allow ssh (Port 22)
  ingress {
    description = var.ec2_security_group_ssh_proxy_desc
    from_port   = var.ec2_security_group_ssh_proxy_port
    to_port     = var.ec2_security_group_ssh_proxy_port
    protocol    = var.ec2_security_group_ssh_proxy_protocol
    cidr_blocks = [var.ec2_security_group_ssh_proxy_cidr]
  }

  egress {
    from_port   = var.ec2_security_group_egress_port
    to_port     = var.ec2_security_group_egress_port
    protocol    = var.ec2_security_group_egrress_protocol
    cidr_blocks = [var.ec2_security_group_egress_cidr]
  }

  tags = {
    Name = var.ec2_security_group_tag_val
  }
}

# Create KP and download to local machine
resource "aws_key_pair" "tf-key-pair" {
  key_name   = var.ec2_keypair_name
  public_key = tls_private_key.rsa.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.rsa.private_key_pem}' > ./tf-key-pair.pem"
  }
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = var.ec2_keypair_name
  file_permission = "0400"
}

# Launch Instance
resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = var.default_az_id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  iam_instance_profile   = var.jenkins_instance_profile_name
  key_name               = var.ec2_keypair_name

  tags = { Name = var.ec2_instanct_tag_val }
}
