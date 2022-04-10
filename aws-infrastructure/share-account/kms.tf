// kms resource
resource "aws_kms_key" "kms_resource" {
  description = "KMS encryption key for ${var.project}"
}

// alias for the kms key
resource "aws_kms_alias" "kms_resource" {
  name          = "alias/${var.project}_kms_key_alias"
  target_key_id = "${aws_kms_key.kms_resource.key_id}"
}
