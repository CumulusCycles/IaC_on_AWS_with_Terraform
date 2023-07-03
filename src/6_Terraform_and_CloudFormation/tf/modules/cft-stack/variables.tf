variable "stack_name" {
  description = "Name of CFT Stack"
  type        = string
}

variable "template_url" {
  description = "Location of CFT Stack Template"
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