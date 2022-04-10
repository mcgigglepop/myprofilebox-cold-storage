# Dynamo Database Resource
resource "aws_dynamodb_table" "dynamodb_table" {
  name           = format("%s-%s", var.project, "table")
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "record_id"

  attribute {
    name = "record_id"
    type = "S"
  }
}