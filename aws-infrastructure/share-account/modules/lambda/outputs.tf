output "arn" {
  value = aws_lambda_function.lambda.arn
}

output "role_name" {
  value = aws_iam_role.lambda_role.name
}

output "function_name" {
  value = aws_lambda_function.lambda.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}