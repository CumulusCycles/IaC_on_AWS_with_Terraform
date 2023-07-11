terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "seleniumLayer" {
  source = "./modules/selenium_layer"

  path_to_selenium_layer_source   = local.path_to_selenium_layer_source
  path_to_selenium_layer_artifact = local.path_to_selenium_layer_artifact
  path_to_selenium_layer_filename = local.path_to_selenium_layer_filename
  selenium_layer_name             = local.selenium_layer_name
  compatible_layer_runtimes       = local.compatible_layer_runtimes
  compatible_architectures        = local.compatible_architectures
}

module "chromedriverLayer" {
  source = "./modules/chromedriver_layer"

  path_to_chromedriver_layer_source   = local.path_to_chromedriver_layer_source
  path_to_chromedriver_layer_artifact = local.path_to_chromedriver_layer_artifact
  path_to_chromedriver_layer_filename = local.path_to_chromedriver_layer_filename
  chromedriver_layer_name             = local.chromedriver_layer_name
  compatible_layer_runtimes           = local.compatible_layer_runtimes
  compatible_architectures            = local.compatible_architectures
}

module "lambdaIAM" {
  source = "./modules/iam"

  lambda_iam_policy_name = local.lambda_iam_policy_name
  lambda_iam_policy_path = local.lambda_iam_policy_path
  lambda_iam_role_name   = local.lambda_iam_role_name
  lambda_iam_role_path   = local.lambda_iam_role_path
}

module "lambdaFunction" {
  source = "./modules/lambda"

  lambda_iam_role_arn = module.lambdaIAM.lambda_iam_role_arn
  path_to_source_file = local.path_to_source_file
  path_to_artifact    = local.path_to_artifact
  function_name       = local.function_name
  function_handler    = local.function_handler
  memory_size         = local.memory_size
  timeout             = local.timeout
  runtime             = local.runtime
  lambda_layer_arns   = [module.seleniumLayer.selenium_layer_arn, module.chromedriverLayer.chromedriver_layer_arn]
}