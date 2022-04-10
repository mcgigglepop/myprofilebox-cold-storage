variable "function_name" {
  description = "The name of the lambda function"
}

variable "description" {
  description = "The description of the lambda function"
}

variable "handler" {
  description = "The handler name of the lambda function"
}

variable "runtime" {
  description = "The runtime of the lambda function"
}

variable "memory" {
  description = "The memory of the lambda function in MB"
}

variable "timeout" {
  description = "The timeout of the lambda function"
}

variable "output_base64sha256" {
  description = "The base 64 hash of the lambda source code"
}

variable "output_path" {
  description = "The output path of the lambda source code"
}

variable "lambda_role_name" {
  description = "The name of the lambda IAM Role"
}

variable "lambda_role_description" {
  description = "The description of the lambda IAM Role"
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = null
}