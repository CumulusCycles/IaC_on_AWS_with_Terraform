variable "vpc_tags" {
  description = "Tags for VPC"
  type        = map(any)
}

variable "db_user_name" {
  description = "RDS DB User"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_user_name) > 5
    error_message = "DB UserName must not be empty."
  }
}

variable "db_user_password" {
  description = "RDS DB User Password"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_user_password) > 8
    error_message = "DB User Password must not be empty."
  }
}