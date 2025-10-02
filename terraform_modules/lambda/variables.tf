variable "products_table_arn" {
  description = "ARN of the Products DynamoDB table"
  type        = string
}

variable "cart_table_arn" {
  description = "ARN of the Cart DynamoDB table"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "user_pool_id" {
  description = "ID of the Cognito User Pool"
  type        = string
}
