resource "aws_s3_object" "cft-template" {
  bucket = var.bucket_name
  key    = var.template_key
  source = var.template_source
}