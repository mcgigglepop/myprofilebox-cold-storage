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

# Attach policy to IAM Role for Step Function
resource "aws_iam_role_policy_attachment" "iam_for_sfn_attach_policy_invoke_lambda" {
  role       = aws_iam_role.iam_for_sfn.name
  policy_arn = aws_iam_policy.policy_invoke_lambda.arn
}

// State Machine for Sharing Accounts
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "${var.project}-share-account-state-machine"
  role_arn = aws_iam_role.iam_for_sfn.arn

  definition = <<EOF
{
  "Comment": "Execution workflow for Sharing an Account",
  "StartAt": "Share Account",
  "States": {
    "Share Account": {
      "Type": "Parallel",
      "Branches": [
        {
          "StartAt": "Encrypt Secret",
          "States": {
            "Encrypt Secret": {
              "Type": "Task",
              "Resource": "arn:aws:states:::lambda:invoke",
              "OutputPath": "$.Payload",
              "Parameters": {
                "FunctionName": "${module.encrypt-secret-lambda.arn}",
                "Payload.$": "$"
              },
              "Next": "Store in S3"
            },
            "Store in S3": {
              "Type": "Task",
              "Resource": "arn:aws:states:::lambda:invoke",
              "OutputPath": "$.Payload",
              "Parameters": {
                "FunctionName": "${module.store-in-s3-lambda.arn}",
                "Payload.$": "$"
              },
              "Next": "Generate MFA"
            },
            "Generate MFA": {
              "Type": "Task",
              "Resource": "arn:aws:states:::lambda:invoke",
              "OutputPath": "$.Payload",
              "Parameters": {
                "FunctionName": "${module.generate-mfa-lambda.arn}",
                "Payload.$": "$"
              },
              "Next": "Create Dynamo Record"
            },
            "Create Dynamo Record": {
              "Type": "Task",
              "Resource": "arn:aws:states:::lambda:invoke",
              "OutputPath": "$.Payload",
              "Parameters": {
                "FunctionName": "${module.create-dynamo-record-lambda.arn}",
                "Payload.$": "$"
              },
              "Next": "Send Text Message"
            },
            "Send Text Message": {
              "Type": "Task",
              "Resource": "arn:aws:states:::lambda:invoke",
              "OutputPath": "$.Payload",
              "Parameters": {
                "FunctionName": "${module.send-text-message-lambda.arn}",
                "Payload.$": "$"
              },
              "End": true
            }
          }
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.error",
          "Next": "Send Failure Message"
        }
      ],
      "Next": "Job Succeeded"
    },
    "Job Succeeded": {
      "Type": "Succeed"
    },
    "Send Failure Message": {
      "Type": "Pass",
      "Next": "Fail Workflow"
    },
    "Fail Workflow": {
      "Type": "Fail"
    }
  }
}
EOF

  depends_on = ["module.encrypt-secret-lambda","module.store-in-s3-lambda.arn","module.generate-mfa-lambda.arn","module.create-dynamo-record-lambda.arn","module.send-text-message-lambda.arn"]

}