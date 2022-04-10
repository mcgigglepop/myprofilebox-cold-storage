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