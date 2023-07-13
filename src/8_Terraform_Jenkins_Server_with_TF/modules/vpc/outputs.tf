output "default_vpc_id" {
  value = aws_default_vpc.default_vpc.id
}

output "default_az_id" {
  value = aws_default_subnet.default_az.id
}
