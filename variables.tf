variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "products_table_name" {
  description = "Name of the Products DynamoDB table"
  type        = string
  default     = "Products"
}

variable "cart_table_name" {
  description = "Name of the Cart DynamoDB table"
  type        = string
  default     = "Cart"
}

variable "user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
  default     = "EcommerceUserPool"
}

variable "client_name" {
  description = "Name of the Cognito User Pool Client"
  type        = string
  default     = "EcommerceAppClient"
}

variable "rest_api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
  default     = "EcommerceAPI"
}