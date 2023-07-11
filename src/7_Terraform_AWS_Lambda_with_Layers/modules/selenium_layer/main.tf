data "archive_file" "layer" {
  type        = "zip"
  source_dir  = var.path_to_selenium_layer_source
  output_path = var.path_to_selenium_layer_artifact
}

resource "aws_lambda_layer_version" "selenium_layer" {
  filename   = var.path_to_selenium_layer_filename
  layer_name = var.selenium_layer_name

  compatible_runtimes      = var.compatible_layer_runtimes
  compatible_architectures = var.compatible_architectures
}