variable "lambda_iam_role_arn" {
  description = "Lambda IAM Role ARN"
  type        = string
}

variable "path_to_source_file" {
  description = "Path to Lambda Fucntion Source Code"
  type        = string
}

variable "path_to_artifact" {
  description = "Path to ZIP artifact"
  type        = string
}

variable "function_name" {
  description = "Name of Lambda Function"
  type        = string
}

variable "function_handler" {
  description = "Name of Lambda Function Handler"
  type        = string
}

variable "memory_size" {
  description = "Lambda Memory"
  type        = number
}

variable "timeout" {
  description = "Lambda Timeout"
  type        = number
}

variable "runtime" {
  description = "Lambda Runtime"
  type        = string
}

variable "lambda_layer_arns" {
  description = "lambda_layer_arns"
  type        = list(string)
}