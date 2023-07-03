terraform {
  required_version = "~> 1.5"

  backend "s3" {
    bucket         = "cc-demo-bkt"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cc-demo-tbl"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = local.bucket_name
  table_name  = local.table_name
}

# Module for S3 Bucket to hold CFT Template
module "cft-bucket" {
  source      = "./modules/cft-bucket"
  bucket_name = var.cft_bucket_name
}

# Module for S3 Object (the CFT Template)
module "cft-template" {
  source          = "./modules/cft-template"
  bucket_name     = module.cft-bucket.cft_bucket_name
  template_key    = var.cft_template_name
  template_source = var.cft_template_location
}

# Module for the CFT Stack (creates the VPC Resource)
module "cft-stack" {
  source       = "./modules/cft-stack"
  stack_name   = var.cft_stack_name
  template_url = "https://${module.cft-bucket.cft_bucket_endpoint}/${module.cft-template.cft_template_key}"
  vpc_name     = var.vpc_name
  vpc_cidr     = var.vpc_cidr
}