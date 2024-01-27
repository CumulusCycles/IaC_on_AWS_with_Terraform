variable "subnet_ids" {
  description = "Subnet Id"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group Id"
  type        = list(string)
}

variable "ingress_rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "file_system_path" {
  description = "Path to mount EFS"
  type        = string
}

variable "mount_target_dns_names" {
  description = "Mount Target DNS Names"
  type        = list(string)
}