variable "path_to_chromedriver_layer_source" {
  description = "path_to_chromedriver_layer_source"
  type        = string
}

variable "path_to_chromedriver_layer_artifact" {
  description = "path_to_chromedriver_layer_artifact"
  type        = string
}

variable "path_to_chromedriver_layer_filename" {
  description = "path_to_chromedriver_layer_filename"
  type        = string
}

variable "chromedriver_layer_name" {
  description = "chromedriver_layer_name"
  type        = string
}

variable "compatible_layer_runtimes" {
  description = "compatible_layer_runtimes"
  type        = list(string)
}

variable "compatible_architectures" {
  description = "compatible_architectures"
  type        = list(string)
}