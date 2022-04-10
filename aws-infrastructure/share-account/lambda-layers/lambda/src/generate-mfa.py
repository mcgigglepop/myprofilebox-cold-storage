from doctest import master
import json
import boto3

def lambda_handler(event, context):
    print("GENERATE MFA")
    print(event)

    result = {
        "step": 3,
        "state": "generate mfa"
    }

    response = json.dumps(result)
    return response