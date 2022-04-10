import json
import boto3
import os

def lambda_handler(event, context):
    # top-level variables
    s3 = boto3.resource("s3")
    bucket_name = os.environ['S3_BUCKET']    

    # inputs
    record_id = event["record_id"]
    encoded_password = event["encoded_password"]
    account_type = event["account_type"]
    account_username = event["account_username"]
    account_name = event["account_name"]
    phone_number = event["phone_number"]

    # store encrypted secret in s3
    encoded_password_string = encoded_password.decode("utf-8")
    s3.Bucket(bucket_name).put_object(Key=record_id, Body=encoded_password_string)
    

    result = {
        "record_id": record_id,
        "account_type": account_type,
        "account_username": account_username, 
        "account_name": account_name,
        "phone_number": phone_number
    }

    response = json.dumps(result)
    return response