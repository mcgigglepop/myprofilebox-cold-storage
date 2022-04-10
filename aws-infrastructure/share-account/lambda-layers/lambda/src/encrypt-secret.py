from doctest import master
import json
import boto3

def lambda_handler(event, context):
    bucket = event['bucket']
    key = event['key']
    
    result = {
        "bucket": bucket,
        "key": key
    }

    response = json.dumps(result)
    return response