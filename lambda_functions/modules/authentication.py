
"""
Authentication Module

This module provides authentication utilities for validating JWT tokens issued by AWS Cognito.
It implements JWT validation using the RS256 algorithm and JWKS (JSON Web Key Set) from Cognito.
"""

from jose import jwk, jwt as jose_jwt, exceptions
from jose.utils import base64url_decode
import requests

def validate_token(token, user_pool_id, region='ap-south-1'):
    """
    Validate a JWT token issued by AWS Cognito.
    
    Args:
        token (str): The JWT token to validate
        user_pool_id (str): The Cognito User Pool ID
        region (str): AWS region where the User Pool is located (default: ap-south-1)
    
    Returns:
        bool: True if token is valid, False otherwise
    """
    
    jwks_url = f'https://cognito-idp.{region}.amazonaws.com/{user_pool_id}/.well-known/jwks.json'

    try:
        # Fetch JWKS
        jwks_response = requests.get(jwks_url)
        jwks = jwks_response.json()
        unverified_header = jose_jwt.get_unverified_header(token) 
        rsa_key = {}
        for key in jwks['keys']:
            if key['kid'] == unverified_header['kid']:
                rsa_key = {
                    'kty': key['kty'],
                    'kid': key['kid'],
                    'use': key['use'],
                    'n': key['n'],
                    'e': key['e']
                }
        if not rsa_key:
            raise ValueError('Unable to find appropriate key')

        # Validate the token
        payload = jose_jwt.decode(token, rsa_key, algorithms=['RS256'])
        return True
    except (ValueError, exceptions.JWSError, Exception) as e:
        print(f"Token validation error: {e}")
        return False