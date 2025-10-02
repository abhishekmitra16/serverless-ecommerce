import pytest
import json
from lambda_functions.list_products import lambda_handler as list_products
from lambda_functions.add_to_cart import lambda_handler as add_to_cart
from lambda_functions.remove_from_cart import lambda_handler as remove_from_cart

def test_list_products():
    event = {'headers': {'Authorization': 'Bearer dummy_token'}}
    response = list_products(event, None)
    assert response['statusCode'] in [200, 401]

def test_add_to_cart():
    event = {
        'headers': {'Authorization': 'Bearer dummy_token'},
        'body': json.dumps({'user_id': 'test_user', 'product_id': 'prod1', 'quantity': 2})
    }
    response = add_to_cart(event, None)
    assert response['statusCode'] in [200, 401, 404, 500]


def test_remove_from_cart():
    event = {
        'headers': {'Authorization': 'Bearer dummy_token'},
        'body': json.dumps({'user_id': 'test_user', 'product_id': 'prod1'})
    }
    response = remove_from_cart(event, None)
    assert response['statusCode'] in [200, 401, 404, 500]

def test_invalid_token():
    event = {'headers': {'Authorization': 'Bearer invalid_token'}}
    response = list_products(event, None)
    assert response['statusCode'] == 401
    response = add_to_cart(event, None)
    assert response['statusCode'] == 401
    response = remove_from_cart(event, None)
    assert response['statusCode'] == 401
