output "cft_bucket_name" {
  value = aws_s3_bucket.cft-bucket.bucket
}

output "cft_bucket_endpoint" {
  value = aws_s3_bucket.cft-bucket.bucket_domain_name
}