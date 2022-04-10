provider "aws" {
  region = var.aws_region
  shared_credentials_file = var.aws_credential_profile
  profile = var.profile
}