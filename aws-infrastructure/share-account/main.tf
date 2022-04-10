provider "aws" {
  region = var.aws_region
  shared_credentials_file = var.aws_credential_profile
  profile = var.profile
}

# AWS Caller Identity
data "aws_caller_identity" "current" {}

# Lambda Module for Fetch Quesionnaire
module "encrypt-secret-lambda" {
  source                  = "./modules/lambda"
  function_name           = "${var.project}-encrypt-secret"
  description             = "lambda to encrypt secret"
  handler                 = "encrypt-secret.lambda_handler"
  runtime                 = "python3.7"
  memory                  = 128
  timeout                 = 300
  output_base64sha256     = data.archive_file.create_dist_pkg.output_base64sha256
  output_path             = data.archive_file.create_dist_pkg.output_path
  lambda_role_name        = "encrypt-secret-lambda-role"
  lambda_role_description = "role for encrypt secret lambda"
  depends_on              = [data.archive_file.create_dist_pkg]
}