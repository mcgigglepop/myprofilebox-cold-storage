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