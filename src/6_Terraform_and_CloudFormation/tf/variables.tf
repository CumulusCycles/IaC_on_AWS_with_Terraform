variable "cft_bucket_name" {
  description = "Name of CFT Bucket"
  type        = string
}

variable "cft_template_name" {
  description = "Name of CFT Template"
  type        = string
}

variable "cft_template_location" {
  description = "Location of CFT Template"
  type        = string
}

variable "cft_stack_name" {
  description = "Name of CFT Stack"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
