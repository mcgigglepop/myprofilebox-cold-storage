# IAM Policy for the Encrypt Secret Function
resource "aws_iam_policy" "encrypt_secret_lambda_policy" {
  name = "${var.project}-encrypt-secret-lambda-policy"
  description = "IAM Policy for the Encrypt Secret Lambda Function"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
}

# IAM Policy for the Store in S3 Function
resource "aws_iam_policy" "store_in_s3_lambda_policy" {
  name = "${var.project}-store-in-s3-lambda-policy"
  description = "IAM Policy for the Store in S3 Lambda Function"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
}

# IAM Policy for the Generate MFA Function
resource "aws_iam_policy" "generate_mfa_lambda_policy" {
  name = "${var.project}-generate-mfa-lambda-policy"
  description = "IAM Policy for the Generate MFA Lambda Function"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
}

# IAM Policy for the Create Dynamo Record Function
resource "aws_iam_policy" "create_dynamo_record_lambda_policy" {
  name = "${var.project}-create-dynamo-record-lambda-policy"
  description = "IAM Policy for the Create Dynamo Record Lambda Function"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
}

# IAM Policy for the Store in S3 Function
resource "aws_iam_policy" "send_text_message_lambda_policy" {
  name = "${var.project}-send-text-message-lambda-policy"
  description = "IAM Policy for the Send Text Message Lambda Function"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
}