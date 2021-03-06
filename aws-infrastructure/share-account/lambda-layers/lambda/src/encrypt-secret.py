import json
import boto3
import os
import base64

def lambda_handler(event, context):
    # top-level variables
    session = boto3.session.Session()
    client = session.client('kms')
    key_alias = os.environ['KMS_ALIAS']

    # inputs
    record_id = event["record_id"]
    plaintext_password = event["password"]
    account_type = event["account_type"]
    account_username = event["account_username"]
    account_name = event["account_name"]
    phone_number = event["phone_number"]

    # encrypt secret
    ciphertext = client.encrypt(
        KeyId = key_alias,
        Plaintext = plaintext_password
    )

    # encrypted password blob
    encoded_password = base64.b64encode(ciphertext["CiphertextBlob"])
    encoded_password_string = encoded_password.decode("utf-8")

    result = {
        "record_id": record_id,
        "encoded_password": encoded_password_string,
        "account_type": account_type,
        "account_username": account_username,
        "account_name": account_name,
        "phone_number": phone_number
    }

    response = json.dumps(result)
    return response