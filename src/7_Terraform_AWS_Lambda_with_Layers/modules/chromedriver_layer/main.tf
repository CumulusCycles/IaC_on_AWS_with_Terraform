data "archive_file" "layer" {
  type        = "zip"
  source_dir  = var.path_to_chromedriver_layer_source
  output_path = var.path_to_chromedriver_layer_artifact
}

resource "aws_lambda_layer_version" "chromedriver_layer" {
  filename   = var.path_to_chromedriver_layer_filename
  layer_name = var.chromedriver_layer_name

  compatible_runtimes      = var.compatible_layer_runtimes
  compatible_architectures = var.compatible_architectures
}