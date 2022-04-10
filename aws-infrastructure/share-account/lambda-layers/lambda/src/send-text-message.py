import json
import boto3
import os

def lambda_handler(event, context):
    # top-level variables
    sns = boto3.client('sns')

    # inputs
    record_id = event["record_id"]
    mfa = event["mfa"]
    phone_number = event["phone_number"]

    # send text
    number = str(phone_number)
    message = "Blackbox message. Use MFA code " + str(mfa) + " to retrieve your secret \n\n https://blackbox.com/view/"+ str(record_id)
    sns.publish(PhoneNumber = number, Message=message )
    
    result = {
        "status": "complete"
    }

    response = json.dumps(result)
    return response