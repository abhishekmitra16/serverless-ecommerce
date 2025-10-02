# Like add_to_cart.py create remove from cart functionality
import os,json
from modules.authentication import validate_token
from modules.database import cart_table, products_table



user_pool_id = os.environ.get("USER_POOL_ID")
region = os.environ.get("REGION", "ap-south-1")


def lambda_handler(event, context):
    try:
        token = event['headers'].get('Authorization', '').replace('Bearer ', '')
        if not validate_token(token, user_pool_id, region):
            return {'statusCode': 401, 'body': json.dumps({'error': 'Invalid token'})}
        
        body = json.loads(event['body'])
        user_id = body['user_id']  # Should match Cognito 'sub'
        product_id = body['product_id']
        
        # Verify product exists
        product = products_table.get_item(Key={'product_id': product_id})
        if 'Item' not in product:
            return {'statusCode': 404, 'body': json.dumps({'error': 'Product not found'})}
        
        # Remove from cart
        response = cart_table.get_item(Key={'user_id': user_id})
        if 'Item' in response and 'items' in response['Item']:
            items = response['Item']['items']
            items = [item for item in items if item['product_id'] != product_id]
            cart_table.update_item(
                Key={'user_id': user_id},
                UpdateExpression='SET items = :items',
                ExpressionAttributeValues={':items': items}
            )
            return {'statusCode': 200, 'body': json.dumps({'message': 'Removed from cart'})}
        else:
            return {'statusCode': 404, 'body': json.dumps({'error': 'Cart is empty or user not found'})}
    except Exception as e:
        return {'statusCode': 500, 'body': json.dumps({'error': str(e)})}