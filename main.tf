# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Get current AWS account ID for resource naming and ARN construction
data "aws_caller_identity" "current" {}

# DynamoDB module for product catalog and shopping cart storage
module "dynamodb" {
  source = "./terraform_modules/dynamodb"

  products_table_name = var.products_table_name
  cart_table_name     = var.cart_table_name
}

# Cognito module for user authentication and authorization
module "cognito" {
  source = "./terraform_modules/cognito"

  user_pool_name = var.user_pool_name
  client_name    = var.client_name
}

# Lambda module for serverless compute functions (product listing, cart management)
module "lambda" {
  source = "./terraform_modules/lambda"

  products_table_arn = module.dynamodb.products_table_arn
  cart_table_arn     = module.dynamodb.cart_table_arn
  region             = var.region
  account_id         = data.aws_caller_identity.current.account_id
  user_pool_id       = module.cognito.user_pool_id
}

# API Gateway module for RESTful API endpoints with Cognito authorization
module "api_gateway" {
  source = "./terraform_modules/api_gateway"

  rest_api_name        = var.rest_api_name
  user_pool_arn        = module.cognito.user_pool_arn
  list_products_arn    = module.lambda.list_products_arn
  add_to_cart_arn      = module.lambda.add_to_cart_arn
  get_cart_arn         = module.lambda.get_cart_arn
  remove_from_cart_arn = module.lambda.remove_from_cart_arn
}
    