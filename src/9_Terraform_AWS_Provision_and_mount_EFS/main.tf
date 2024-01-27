terraform {
  backend "s3" {
    bucket         = "YOUR_BUCKET_NAME"
    key            = "tf-infra/terraform.tfstate"
    region         = "YOUR_REGION"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "YOUR_REGION"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "YOUR_BUCKET_NAME"
}

module "efs" {
  source     = "./modules/efs"
  efs-name   = "cc-efs"
  subnet_ids = local.subnet_ids
}

module "webserver-infra" {
  source                 = "./modules/webserver"
  subnet_ids             = local.subnet_ids
  security_group_id      = local.security_group_id
  file_system_path       = local.file_system_path
  mount_target_dns_names = module.efs.cc-efs-mount-target-dns-names
}
