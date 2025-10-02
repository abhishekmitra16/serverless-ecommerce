resource "aws_dynamodb_table" "products" {
  name           = var.products_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "cart" {
  name           = var.cart_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }
}