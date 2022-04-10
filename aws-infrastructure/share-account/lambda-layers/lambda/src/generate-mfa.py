import json
from random import randint

def lambda_handler(event, context):
    
    # inputs
    record_id = event["record_id"]
    account_type = event["account_type"]
    account_username = event["account_username"]
    account_name = event["account_name"]
    phone_number = event["phone_number"]

    # generate mfa
    mfa = random_with_N_digits(6)
    
    result = {
        "record_id": record_id,
        "account_type": account_type,
        "account_username": account_username, 
        "account_name": account_name,
        "mfa": mfa,
        "phone_number": phone_number
    }

    response = json.dumps(result)
    return response

def random_with_N_digits(n):
    range_start = 10**(n-1)
    range_end = (10**n)-1
    return randint(range_start, range_end)