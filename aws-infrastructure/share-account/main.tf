provider "aws" {
  region = var.aws_region
  shared_credentials_file = var.aws_credential_profile
  profile = var.profile
}

# AWS Caller Identity
data "aws_caller_identity" "current" {}