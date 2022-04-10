variable "aws_region" {
  description = "Specified AWS Region"
  default = "us-east-1"
}

variable "aws_credential_profile" {
  description = "AWS Profile location"
  default = "~/.aws/credentials"
}

variable "profile" {
  description = "AWS Profile Name"
  default = "management"
}

variable "project" {
  description = "Project Name"
  default = "blackbox"
}

variable "stage" {
  description = "api gateway stage name"
  default = "dev"
}