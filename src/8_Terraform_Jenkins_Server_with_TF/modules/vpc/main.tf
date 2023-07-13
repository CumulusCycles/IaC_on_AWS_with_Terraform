# Hold all AZs in Region
data "aws_availability_zones" "available_zones" {}

# Create default VPC - if one doesn't exist
resource "aws_default_vpc" "default_vpc" {
  tags = { Name = var.default_vpc_name }
}

# Create default Subnet - if one doesn't exist
resource "aws_default_subnet" "default_az" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = { Name = var.default_subnet_name }
}