from doctest import master
import json
import boto3

def lambda_handler(event, context):
    print("CREATE DYNAMO RECORD")
    print(event)

    result = {
        "step": 4,
        "state": "create dynamo record"
    }

    response = json.dumps(result)
    return response