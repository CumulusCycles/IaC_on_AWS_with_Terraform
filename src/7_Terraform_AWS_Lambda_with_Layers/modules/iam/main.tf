resource "aws_iam_role_policy" "lambda_iam_policy" {
  name = var.lambda_iam_policy_name
  role = aws_iam_role.lambda_iam_role.id

  policy = file(var.lambda_iam_policy_path)
}

resource "aws_iam_role" "lambda_iam_role" {
  name = var.lambda_iam_role_name

  assume_role_policy = file(var.lambda_iam_role_path)
}