from doctest import master
import json
import boto3

def lambda_handler(event, context):
    print("STORE IN S3")
    print(event)

    result = {
        "step": 2,
        "state": "store in s3"
    }

    response = json.dumps(result)
    return response