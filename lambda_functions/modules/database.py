"""
Database Module

This module provides easy access to DynamoDB tables used in the e-commerce application.
It initializes connections to the Products and Cart tables using boto3.

Tables:
    - Products: Stores product catalog information
    - Cart: Stores user shopping cart data
"""

import boto3

# Initialize DynamoDB resource
dynamodb = boto3.resource('dynamodb')

# Initialize table resources
cart_table = dynamodb.Table('Cart')  # Table for storing user shopping cart data
products_table = dynamodb.Table('Products')  # Table for storing product catalog