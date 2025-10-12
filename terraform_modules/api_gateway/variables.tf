variable "rest_api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
}

variable "user_pool_arn" {
  description = "ARN of the Cognito User Pool"
  type        = string
}

variable "list_products_function_name" {
  description = "Name of the list_products Lambda function"
  type        = string
}

variable "list_products_arn" {
  description = "ARN of the list_products Lambda function"
  type        = string
}

variable "add_to_cart_function_name" {
  description = "Name of the add_to_cart Lambda function"
  type        = string
}

variable "add_to_cart_arn" {
  description = "ARN of the add_to_cart Lambda function"
  type        = string
}

variable "get_cart_function_name" {
  description = "Name of the get_cart Lambda function"
  type        = string
}

variable "get_cart_arn" {
  description = "ARN of the get_cart Lambda function"
  type        = string
}


variable "remove_from_cart_function_name" {
  description = "Name of the remove_from_cart Lambda function"
  type        = string
}

variable "remove_from_cart_arn" {
  description = "ARN of the remove_from_cart Lambda function"
  type        = string
}