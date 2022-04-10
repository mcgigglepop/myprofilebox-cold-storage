from doctest import master
import json
import boto3

def lambda_handler(event, context):
    print("SEND TEXT MESSAGE")
    print(event)

    result = {
        "step": 5,
        "state": "send text message"
    }

    response = json.dumps(result)
    return response