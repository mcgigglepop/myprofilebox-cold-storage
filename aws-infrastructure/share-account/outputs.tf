output "api_auth_key" {
    value = "${aws_api_gateway_api_key.auth_key.value}"
}