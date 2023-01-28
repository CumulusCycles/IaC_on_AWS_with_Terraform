# Create a VPC
resource "aws_vpc" "ccVPC" {
  cidr_block = var.vpc_cidr
  tags       = var.vpc_tags
}