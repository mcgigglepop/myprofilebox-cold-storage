# IAM execution role for AWS Step Function State Machine
resource "aws_iam_role" "iam_for_sfn" {
  name = "${var.project}-state-machine-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy for invoking lambdas
resource "aws_iam_policy" "policy_invoke_lambda" {
  name        = "${var.project}-sfn-lambda-invocation-role"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction",
                "lambda:InvokeAsync"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}