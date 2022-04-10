# Lambda Function Resource
resource "aws_lambda_function" "lambda" {
  function_name     = var.function_name
  description       = var.description
  role              = aws_iam_role.lambda_role.arn
  handler           = var.handler
  runtime           = var.runtime
  memory_size       = var.memory
  timeout           = var.timeout
  source_code_hash  = var.output_base64sha256
  filename          = var.output_path
  layers            = var.layers 

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }
}

# Cloudwatch Log Group Resource for the Function
resource "aws_cloudwatch_log_group" "lambda_cw_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
}

# IAM Role for the Lambda Function
resource "aws_iam_role" "lambda_role" {
  name          = var.lambda_role_name
  description   = var.lambda_role_description

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

}