import os, json
from modules.authentication import validate_token
from modules.database import cart_table

user_pool_id = os.environ.get("USER_POOL_ID")
region = os.environ.get("REGION", "ap-south-1")

def lambda_handler(event, context):
    try:
        token = event['headers'].get('Authorization', '').replace('Bearer ', '')
        if not validate_token(token, user_pool_id, region=region):
            return {'statusCode': 401, 'body': json.dumps({'error': 'Invalid token'})}
        
        user_id = event['pathParameters']['user_id']
        response = cart_table.get_item(Key={'user_id': user_id})
        return {
            'statusCode': 200,
            'body': json.dumps(response.get('Item', {}))
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }