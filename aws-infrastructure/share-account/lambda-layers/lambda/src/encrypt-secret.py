from doctest import master
import json
import boto3

def lambda_handler(event, context):
    print("ENCRYPT SECRET")
    print(event)

    result = {
        "step": 1,
        "state": "encrypt secret"
    }

    response = json.dumps(result)
    return response