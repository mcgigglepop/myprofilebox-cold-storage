import json
import boto3
import os

def lambda_handler(event, context):
    # top-level variables
    dynamodb = boto3.resource('dynamodb')
    dynamodb_table = dynamodb.Table(os.environ['DDB_TABLE'])

    # inputs
    record_id = event["record_id"]
    account_type = event["account_type"]
    account_username = event["account_username"]
    account_name = event["account_name"]
    mfa = event["mfa"]
    phone_number = event["phone_number"]

    # create dynamo record
    # create ddb record 
    dynamodb_table.update_item(
        Key = {
            'record_id': record_id
        },
        ExpressionAttributeNames = {
            '#account_type_name': 'account_type',
            '#account_username_name': 'username',
            '#account_name_name': 'account_name',
            '#mfa_name': 'mfa_code'
        },
        ExpressionAttributeValues = {
            ':account_type_value': account_type,
            ':account_username_value': account_username,
            ':account_name_value': account_name,
            ':mfa_value': mfa
        },
        UpdateExpression = 'SET #account_type_name = :account_type_value, #account_username_name = :account_username_value, #account_name_name = :account_name_value, #mfa_name = :mfa_value',
        ReturnValues = 'ALL_NEW',
    )
    
    result = {
        "record_id": record_id,
        "mfa": mfa,
        "phone_number": phone_number
    }

    response = json.dumps(result)
    return response