"""
List Products Lambda Function

This Lambda function handles the GET /products endpoint of the e-commerce API.
It retrieves the list of all products from the DynamoDB products table.
The endpoint is protected by Cognito authentication.

Environment Variables:
    USER_POOL_ID: AWS Cognito User Pool ID for token validation
    REGION: AWS region (defaults to ap-south-1)
"""

import os, json
import boto3
from modules.authentication import validate_token
from modules.database import products_table

user_pool_id = os.environ.get("USER_POOL_ID")
region = os.environ.get("REGION", "ap-south-1")

def lambda_handler(event, context):
    """
    Lambda handler for listing all products in the catalog.
    
    Args:
        event (dict): API Gateway event containing request data
        context (object): Lambda context object
    
    Returns:
        dict: API Gateway response object containing status code and product list
    """
    try:
        # Extract and validate JWT token from Authorization header
        token = event['headers'].get('Authorization', '').replace('Bearer ', '')
        if not validate_token(token, user_pool_id, region):
            return {'statusCode': 401, 'body': json.dumps({'error': 'Invalid token'})}

        # Retrieve all products from DynamoDB
        response = products_table.scan()
        return {
            'statusCode': 200,
            'body': json.dumps(response['Items'], default=float)
        }
    except Exception as e:
        # Handle any unexpected errors and return 500 response
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }