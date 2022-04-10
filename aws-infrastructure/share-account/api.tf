# Root API Gateway
resource "aws_api_gateway_rest_api" "api_gateway" {
  name = "${var.project}-api-gateway"
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "deployment" {
    rest_api_id   = "${aws_api_gateway_rest_api.api_gateway.id}"
    stage_name    = "${var.stage}"
    depends_on = ["aws_api_gateway_method.encrypt_method", "aws_api_gateway_integration.encrypt_integration", "aws_api_gateway_method.decrypt_method", "aws_api_gateway_integration.decrypt_integration"]
}

# encrypt Resource
resource "aws_api_gateway_resource" "encrypt_resource" {
  path_part   = "encrypt"
  parent_id   = "${aws_api_gateway_rest_api.api_gateway.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
}

# encrypt Method
resource "aws_api_gateway_method" "encrypt_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id   = "${aws_api_gateway_resource.encrypt_resource.id}"
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
}

# Method Integration
resource "aws_api_gateway_integration" "encrypt_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id             = "${aws_api_gateway_resource.encrypt_resource.id}"
  http_method             = "${aws_api_gateway_method.encrypt_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${module.trigger-sfn-lambda.invoke_arn}"
  
  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}

# CORS OPTIONS Method for the encrypt Endpoint
resource "aws_api_gateway_method" "cors_method_encrypt" {
  rest_api_id   = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id   = "${aws_api_gateway_resource.encrypt_resource.id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# CORS Integration for the encrypt Endpoint
resource "aws_api_gateway_integration" "cors_integration_encrypt" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id = "${aws_api_gateway_resource.encrypt_resource.id}"
  http_method = "${aws_api_gateway_method.cors_method_encrypt.http_method}"
  type                    = "MOCK"
  request_templates = {
    "application/json" = <<EOF
{ "statusCode": 200 }
EOF
  }
}

# CORS Method Response for the encrypt Endpoint
resource "aws_api_gateway_method_response" "cors_method_response_encrypt" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id = "${aws_api_gateway_resource.encrypt_resource.id}"
  http_method = "${aws_api_gateway_method.cors_method_encrypt.http_method}"

  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

# CORS Integration Response for the encrypt Endpoint
resource "aws_api_gateway_integration_response" "cors_integration_response_encrypt" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id = "${aws_api_gateway_method.cors_method_encrypt.resource_id}"
  http_method = "${aws_api_gateway_method.cors_method_encrypt.http_method}"

  status_code = "${aws_api_gateway_method_response.cors_method_response_encrypt.status_code}"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

##############################################################
# decrypt Resource
resource "aws_api_gateway_resource" "decrypt_resource" {
  path_part   = "decrypt"
  parent_id   = "${aws_api_gateway_rest_api.api_gateway.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
}

# decrypt Method
resource "aws_api_gateway_method" "decrypt_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id   = "${aws_api_gateway_resource.encrypt_resource.id}"
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
}

# Method Integration
resource "aws_api_gateway_integration" "decrypt_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id             = "${aws_api_gateway_resource.decrypt_resource.id}"
  http_method             = "${aws_api_gateway_method.decrypt_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${module.decrypt-lambda.invoke_arn}"
  
  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}

# CORS OPTIONS Method for the decrypt Endpoint
resource "aws_api_gateway_method" "cors_method_decrypt" {
  rest_api_id   = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id   = "${aws_api_gateway_resource.decrypt_resource.id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# CORS Integration for the decrypt Endpoint
resource "aws_api_gateway_integration" "cors_integration_decrypt" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id = "${aws_api_gateway_resource.decrypt_resource.id}"
  http_method = "${aws_api_gateway_method.cors_method_decrypt.http_method}"
  type                    = "MOCK"
  request_templates = {
    "application/json" = <<EOF
{ "statusCode": 200 }
EOF
  }
}

# CORS Method Response for the decrypt Endpoint
resource "aws_api_gateway_method_response" "cors_method_response_decrypt" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id = "${aws_api_gateway_resource.decrypt_resource.id}"
  http_method = "${aws_api_gateway_method.cors_method_decrypt.http_method}"

  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

# CORS Integration Response for the decrypt Endpoint
resource "aws_api_gateway_integration_response" "cors_integration_response_decrypt" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
  resource_id = "${aws_api_gateway_method.cors_method_decrypt.resource_id}"
  http_method = "${aws_api_gateway_method.cors_method_decrypt.http_method}"

  status_code = "${aws_api_gateway_method_response.cors_method_response_decrypt.status_code}"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}
##############################################################
# API Gateway usage plan
resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "${var.project}_usage_plan"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.api_gateway.id}"
    stage  = "${aws_api_gateway_deployment.deployment.stage_name}"
  }
}

# creates API Gateway key
resource "aws_api_gateway_api_key" "auth_key" {
  name = "${var.project}_auth_key"
}

# API Gateway key usage plan
resource "aws_api_gateway_usage_plan_key" "auth_key_usage_plan" {
  key_id        = "${aws_api_gateway_api_key.auth_key.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
}

# Permission to allow execution from api gateway to invoke the lambda function
resource "aws_lambda_permission" "encrypt_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGatewayEncrypt"
  action        = "lambda:InvokeFunction"
  function_name = "${module.trigger-sfn-lambda.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.encrypt_method.http_method}${aws_api_gateway_resource.encrypt_resource.path}"
}

# Permission to allow execution from api gateway to invoke the lambda function
resource "aws_lambda_permission" "decrypt_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGatewaydecrypt"
  action        = "lambda:InvokeFunction"
  function_name = "${module.decrypt-lambda.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.decrypt_method.http_method}${aws_api_gateway_resource.decrypt_resource.path}"
}