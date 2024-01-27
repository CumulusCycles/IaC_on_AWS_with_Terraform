variable "efs-name" {
  description = "Name of EFS"
  type        = string
}

variable "subnet_ids" {
  description = "Mount Target Subnet Id"
  type        = list(string)
}
