locals {
  lambda_iam_policy_name = "lambda_iam_policy"
  lambda_iam_policy_path = "./modules/iam/lambda-iam-policy.json"
  lambda_iam_role_name   = "lambda_iam_role"
  lambda_iam_role_path   = "./modules/iam/lambda-assume-role-policy.json"

  path_to_selenium_layer_source   = "./selenium"
  path_to_selenium_layer_artifact = "./artifacts/selenium.zip"
  path_to_selenium_layer_filename = "./artifacts/selenium.zip"
  selenium_layer_name             = "selenium"

  path_to_chromedriver_layer_source   = "./chromedriver"
  path_to_chromedriver_layer_artifact = "./artifacts/chromedriver.zip"
  path_to_chromedriver_layer_filename = "./artifacts/chromedriver.zip"
  chromedriver_layer_name             = "chromedriver"

  compatible_layer_runtimes = ["python3.7"]
  compatible_architectures  = ["x86_64"]

  path_to_source_file = "./src/scrape.py"
  path_to_artifact    = "./artifacts/scrape.zip"
  function_name       = "scrape"
  function_handler    = "scrape.get_rankings"
  memory_size         = 512
  timeout             = 300
  runtime             = "python3.7"
}