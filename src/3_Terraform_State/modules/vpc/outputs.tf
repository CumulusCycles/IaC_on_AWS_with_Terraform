output "vpc_id" {
  value = aws_vpc.ccVPC.id
}

output "public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value = [
    aws_subnet.ccPublicSubnet1,
    aws_subnet.ccPublicSubnet2
  ]
}
output "private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [
    aws_subnet.ccPrivateSubnet1,
    aws_subnet.ccPrivateSubnet2
  ]
}