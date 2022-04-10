provider "aws" {
  region = var.aws_region
  shared_credentials_file = var.aws_credential_profile
  profile = var.profile
}

# AWS Caller Identity
data "aws_caller_identity" "current" {}

# Lambda Module for Triggering the State Machine
module "trigger-sfn-lambda" {
  source                  = "./modules/lambda"
  function_name           = "${var.project}-trigger-sfn"
  description             = "lambda to send text message"
  handler                 = "trigger-sfn.lambda_handler"
  runtime                 = "python3.7"
  memory                  = 128
  timeout                 = 300
  output_base64sha256     = data.archive_file.create_dist_pkg.output_base64sha256
  output_path             = data.archive_file.create_dist_pkg.output_path
  lambda_role_name        = "trigger-sfn-lambda-role"
  lambda_role_description = "role for trigger state machine lambda"
  depends_on              = [data.archive_file.create_dist_pkg]
  environment_variables   = {
    "SFN_ARN" = "${aws_sfn_state_machine.sfn_state_machine.arn}"
  }
}

# Lambda Module for Encrypt Secret
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
  environment_variables   = {
    "KMS_ALIAS" = "${aws_kms_key.kms_resource.id}"
  }
}

# Lambda Module for Store in S3
module "store-in-s3-lambda" {
  source                  = "./modules/lambda"
  function_name           = "${var.project}-store-in-s3"
  description             = "lambda to store encrypted object in s3"
  handler                 = "store-in-s3.lambda_handler"
  runtime                 = "python3.7"
  memory                  = 128
  timeout                 = 300
  output_base64sha256     = data.archive_file.create_dist_pkg.output_base64sha256
  output_path             = data.archive_file.create_dist_pkg.output_path
  lambda_role_name        = "store-in-s3-lambda-role"
  lambda_role_description = "role for store encrypted object in s3 lambda"
  depends_on              = [data.archive_file.create_dist_pkg]
}

# Lambda Module for Generate MFA
module "generate-mfa-lambda" {
  source                  = "./modules/lambda"
  function_name           = "${var.project}-generate-mfa"
  description             = "lambda to generate mfa code"
  handler                 = "generate-mfa.lambda_handler"
  runtime                 = "python3.7"
  memory                  = 128
  timeout                 = 300
  output_base64sha256     = data.archive_file.create_dist_pkg.output_base64sha256
  output_path             = data.archive_file.create_dist_pkg.output_path
  lambda_role_name        = "generate-mfa-lambda-role"
  lambda_role_description = "role for generate mfa lambda"
  depends_on              = [data.archive_file.create_dist_pkg]
}

# Lambda Module for Create Dynamo Record
module "create-dynamo-record-lambda" {
  source                  = "./modules/lambda"
  function_name           = "${var.project}-create-dynamo-record"
  description             = "lambda to create dynamo record"
  handler                 = "create-dynamo-record.lambda_handler"
  runtime                 = "python3.7"
  memory                  = 128
  timeout                 = 300
  output_base64sha256     = data.archive_file.create_dist_pkg.output_base64sha256
  output_path             = data.archive_file.create_dist_pkg.output_path
  lambda_role_name        = "create-dynamo-record-lambda-role"
  lambda_role_description = "role for create dynamo record lambda"
  depends_on              = [data.archive_file.create_dist_pkg]
}

# Lambda Module for Send Text Message
module "send-text-message-lambda" {
  source                  = "./modules/lambda"
  function_name           = "${var.project}-send-text-message"
  description             = "lambda to send text message"
  handler                 = "send-text-message.lambda_handler"
  runtime                 = "python3.7"
  memory                  = 128
  timeout                 = 300
  output_base64sha256     = data.archive_file.create_dist_pkg.output_base64sha256
  output_path             = data.archive_file.create_dist_pkg.output_path
  lambda_role_name        = "send-text-message-lambda-role"
  lambda_role_description = "role for send text message lambda"
  depends_on              = [data.archive_file.create_dist_pkg]
}