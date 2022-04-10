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
    },
    {
      "Action": "kms:Encrypt",
      "Resource": "${aws_kms_key.kms_resource.arn}",
      "Effect": "Allow",
      "Sid": "VisualEditor1"
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
    },
    {
      "Action": [
          "s3:PutObject"
      ],
      "Resource": [
          "${aws_s3_bucket.s3_bucket.arn}",
          "${aws_s3_bucket.s3_bucket.arn}/*"
      ],
      "Effect": "Allow",
      "Sid": "VisualEditor1"
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
    },
    {
      "Action": [
          "dynamodb:UpdateItem"
      ],
      "Resource": [
          "${aws_dynamodb_table.dynamodb_table.arn}"
      ],
      "Effect": "Allow",
      "Sid": "VisualEditor1"
    }
  ]
}
EOF
}

# IAM Policy for the Send Text Message Function
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
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": "*"
    }
  ]
}
EOF
}

# IAM Policy for the Send Text Message Function
resource "aws_iam_policy" "trigger_sfn_lambda_policy" {
  name = "${var.project}-trigger-sfn-lambda-policy"
  description = "IAM Policy for the Trigger State Machine Lambda Function"
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
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "states:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Policy Attachment for the Encrypt Secret Lamdba Function
resource "aws_iam_role_policy_attachment" "encrypt_secret_lambda_policy_attachment" {
  role = module.encrypt-secret-lambda.role_name
  policy_arn = aws_iam_policy.encrypt_secret_lambda_policy.arn
}

# Policy Attachment for the Store in S3 Lamdba Function
resource "aws_iam_role_policy_attachment" "store_in_s3_lambda_policy_attachment" {
  role = module.store-in-s3-lambda.role_name
  policy_arn = aws_iam_policy.store_in_s3_lambda_policy.arn
}

# Policy Attachment for the Generate MFA Lamdba Function
resource "aws_iam_role_policy_attachment" "generate_mfa_lambda_policy_attachment" {
  role = module.generate-mfa-lambda.role_name
  policy_arn = aws_iam_policy.generate_mfa_lambda_policy.arn
}

# Policy Attachment for the Create Dynamo Record Lamdba Function
resource "aws_iam_role_policy_attachment" "create_dynamo_record_lambda_policy_attachment" {
  role = module.create-dynamo-record-lambda.role_name
  policy_arn = aws_iam_policy.create_dynamo_record_lambda_policy.arn
}

# Policy Attachment for the Send Text Message Lamdba Function
resource "aws_iam_role_policy_attachment" "send_text-message_lambda_policy_attachment" {
  role = module.send-text-message-lambda.role_name
  policy_arn = aws_iam_policy.send_text_message_lambda_policy.arn
}

# Policy attachment for the SFN Trigger Lambda
resource "aws_iam_role_policy_attachment" "trigger_sfn_lambda_policy_attachment" {
  role = module.trigger-sfn-lambda.role_name
  policy_arn = aws_iam_policy.trigger_sfn_lambda_policy.arn
}