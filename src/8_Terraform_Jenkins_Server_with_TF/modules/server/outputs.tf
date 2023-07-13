output "local_file_name" {
  value = local_file.tf-key.filename
}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

# Print Jenkins Server URL
output "website_url" {
  value = join("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
}