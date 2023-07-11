data "archive_file" "scrape" {
  type        = "zip"
  source_file = var.path_to_source_file
  output_path = var.path_to_artifact
}

resource "aws_lambda_function" "rankings_lambda" {
  filename      = var.path_to_artifact
  function_name = var.function_name
  role          = var.lambda_iam_role_arn
  handler       = var.function_handler

  memory_size = var.memory_size
  timeout     = var.timeout

  source_code_hash = filebase64sha256(var.path_to_artifact)

  runtime = var.runtime

  layers = var.lambda_layer_arns
}