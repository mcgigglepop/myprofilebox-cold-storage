# Root API Gateway
resource "aws_api_gateway_rest_api" "api_gateway" {
  name = "${var.project}-api-gateway"
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "deployment" {
    rest_api_id   = "${aws_api_gateway_rest_api.api_gateway.id}"
    stage_name    = "${var.stage}"
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
  uri                     = "${module.encrypt-secret-lambda.invoke_arn}"
  
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
