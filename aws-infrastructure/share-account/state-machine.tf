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