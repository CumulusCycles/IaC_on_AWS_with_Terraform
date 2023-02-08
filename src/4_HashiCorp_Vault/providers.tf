provider "aws" {
  region  = "us-east-1"
  profile = "tf_dev"
}

provider "vault" {
  address = "http://127.0.0.1:8200"
}