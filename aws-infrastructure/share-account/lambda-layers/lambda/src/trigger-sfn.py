import json
import boto3
import os
import uuid
from urllib.parse import unquote_plus

def lambda_handler(event, context):
    try:
        sfn = boto3.client('stepfunctions') 
       
        record_id = uuid.uuid4().hex
        
        payload = {
            "record_id": record_id,
            "password": "password",
            "account_type": "account_type",
            "account_username": "account_username",
            "account_name": "account_name"
        }

        sfn.start_execution(
            stateMachineArn=str(os.environ['SFN_ARN']),
            name=str(record_id),
            input=json.dumps(payload)
        )

        return
    
    except Exception as e:
        return exception_handler(e)
        
def exception_handler(e):
    print(e)
    status_code = 400
    return {
        'statusCode': status_code,
        'body': json.dumps(str(e)),
        "headers": {
            'Access-Control-Allow-Origin': '*',
        },
    }